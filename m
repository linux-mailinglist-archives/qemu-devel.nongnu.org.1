Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C10796E1A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 02:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe35G-0007CB-W9; Wed, 06 Sep 2023 20:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qe35D-00074q-8M
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 20:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qe35A-0001w9-Re
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 20:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694047276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WohNYH4gTLq9BFq5GnGY6CggI5nGuj9cBsyGpjzAchU=;
 b=X09H/p1JWmQFIExab43VfDUg1z1a+ezp2MvioVVzm97Joe9mOEeG+wTVY6N3QEHTUTetXt
 13+0Ipni9x9daC15zE0IoVS8UZ2XzGGecCMMsb+LCaZQFDaZq1KuVkTdJ9wxkzgQG169fY
 nr+PR8r32l3sY8s0a+0Wwlk1AAgzOII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-hUlPjLayODGTntSVImTpZA-1; Wed, 06 Sep 2023 20:41:11 -0400
X-MC-Unique: hUlPjLayODGTntSVImTpZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6165080523C;
 Thu,  7 Sep 2023 00:41:09 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2657D47819;
 Thu,  7 Sep 2023 00:40:53 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org, mrolnik@gmail.com, edgar.iglesias@gmail.com,
 bcain@quicinc.com, gaosong@loongson.cn, yangxiaojuan@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 aleksandar.rikalo@syrmia.com, chenhuacai@kernel.org, crwulff@gmail.com,
 marex@denx.de, shorne@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com, ysato@users.sourceforge.jp,
 david@redhat.com, thuth@redhat.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, pbonzini@redhat.com,
 imammedo@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 17/32] target/tricore: Use generic helper to show CPU model
 names
Date: Thu,  7 Sep 2023 10:35:38 +1000
Message-ID: <20230907003553.1636896-18-gshan@redhat.com>
In-Reply-To: <20230907003553.1636896-1-gshan@redhat.com>
References: <20230907003553.1636896-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For target/tricore, the CPU type name is always the combination of the
CPU model name and suffix. The CPU model names have been correctly
shown in tricore_cpu_list_entry().

Use generic helper cpu_model_from_type() to show the CPU model names
in the above function. tricore_cpu_class_by_name() is also improved
by merging the condition of '@oc == NULL' to object_class_dynamic_cast().

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/tricore/cpu.c    |  9 +++++----
 target/tricore/helper.c | 13 +++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 133a9ac70e..066249e50d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -140,11 +140,12 @@ static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) ||
-        object_class_is_abstract(oc)) {
-        return NULL;
+    if (object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) &&
+        !object_class_is_abstract(oc)) {
+        return oc;
     }
-    return oc;
+
+    return NULL;
 }
 
 static void tc1796_initfn(Object *obj)
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 6d076ac36f..21f4e1f1a3 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -98,14 +98,11 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    ObjectClass *oc = data;
-    const char *typename;
-    char *name;
-
-    typename = object_class_get_name(oc);
-    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_TRICORE_CPU));
-    qemu_printf("  %s\n", name);
-    g_free(name);
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    char *model = cpu_model_from_type(typename);
+
+    qemu_printf("  %s\n", model);
+    g_free(model);
 }
 
 void tricore_cpu_list(void)
-- 
2.41.0


