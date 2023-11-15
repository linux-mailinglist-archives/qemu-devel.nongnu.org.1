Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E17DE961
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 01:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyLaj-0006g2-9j; Wed, 01 Nov 2023 20:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qyLah-0006eP-Pv
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 20:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qyLaf-0001Ll-U9
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 20:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698884981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:mime-version: content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mp+1RJQ7fLp2xhgFZRncDqgoq7F0zB0CU9tFZZbCxlY=;
 b=Fz97mesHCySS/VEq+OXo1ckIjasRh0J+d6kdN1zwn3kab2jLIZN1JmtRUMtWi/sbwBbv06
 KpDlzzrGjUFXCKdQYHeD93TV6SXureX5G7ShgfVTS2kMLLxxZnio7xwXkHm3UuOgIuVmNQ
 oaKUzNUUApqlMqdgdFUVIeAHuagkD9c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-ej23bsXWOdSzZTkz6cyTsw-1; Wed,
 01 Nov 2023 20:29:36 -0400
X-MC-Unique: ej23bsXWOdSzZTkz6cyTsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E15091C05AA4;
 Thu,  2 Nov 2023 00:29:33 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E6FC1290F;
 Thu,  2 Nov 2023 00:29:19 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, philmd@linaro.org, clg@kaod.org,
 imammedo@redhat.com, imp@bsdimp.com, kevans@freebsd.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 aleksandar.rikalo@syrmia.com, chenhuacai@kernel.org, crwulff@gmail.com,
 marex@denx.de, shorne@gmail.com, npiggin@gmail.com,
 ysato@users.sourceforge.jp, david@redhat.com, thuth@redhat.com,
 iii@linux.ibm.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 shan.gavin@gmail.com
Subject: [PATCH v4 15/33] target/ppc: Use generic helper to show CPU model
 names
Date: Thu,  2 Nov 2023 10:24:42 +1000
Message-ID: <20231102002500.1750692-16-gshan@redhat.com>
In-Reply-To: <20231102002500.1750692-1-gshan@redhat.com>
References: <20231102002500.1750692-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For target/ppc, the registered CPU type name is always the
combination of the CPU model name and suffix. Use cpu_model_from_type()
to show the CPU model names.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a6c2..a8ab698700 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7029,16 +7029,15 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
     DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
-    char *name;
+    char *model;
     int i;
 
     if (unlikely(strcmp(typename, TYPE_HOST_POWERPC_CPU) == 0)) {
         return;
     }
 
-    name = g_strndup(typename,
-                     strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
-    qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
+    model = cpu_model_from_type(typename);
+    qemu_printf("PowerPC %-16s PVR %08x\n", model, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
@@ -7055,10 +7054,10 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
                         alias->alias, family->desc);
         } else {
             qemu_printf("PowerPC %-16s (alias for %s)\n",
-                        alias->alias, name);
+                        alias->alias, model);
         }
     }
-    g_free(name);
+    g_free(model);
 }
 
 void ppc_cpu_list(void)
@@ -7067,6 +7066,7 @@ void ppc_cpu_list(void)
 
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
     list = g_slist_sort(list, ppc_cpu_list_compare);
+    qemu_printf("Available CPUs:\n");
     g_slist_foreach(list, ppc_cpu_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.41.0


