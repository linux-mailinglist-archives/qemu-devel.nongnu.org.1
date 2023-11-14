Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB817EBA6C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:04:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33Jo-0004Ca-5V; Tue, 14 Nov 2023 18:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r33Jk-00044h-2G
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r33Ji-0007Q4-EV
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700006377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwMztkO73N/CczTrLEnz5dB16TLg0zyhFk70FFGOseI=;
 b=V21t7Fbdga5rE+7S/KMhlkYD2hzUtCxCjOqgSfu722BlLl9vkqxqxclz8pL2LnDyBzKp4z
 q7Rdl9/0QcHL9yBy5+wKJDW9falrxu8juOCl8MfrXBXPM8vuJSkbROuant2UWq5ObMxain
 3OqSQrhyimdfV6bijPZvJCsiFd7jgl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-8rihQODPP6SQi6Y7AsiVCw-1; Tue, 14 Nov 2023 18:59:30 -0500
X-MC-Unique: 8rihQODPP6SQi6Y7AsiVCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED98F811E7D;
 Tue, 14 Nov 2023 23:59:28 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF103C15885;
 Tue, 14 Nov 2023 23:59:16 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 philmd@linaro.org, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com, edgar.iglesias@gmail.com,
 bcain@quicinc.com, gaosong@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
Subject: [PATCH v5 11/31] target/hexagon: Use generic cpu_list()
Date: Wed, 15 Nov 2023 09:56:08 +1000
Message-ID: <20231114235628.534334-12-gshan@redhat.com>
In-Reply-To: <20231114235628.534334-1-gshan@redhat.com>
References: <20231114235628.534334-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

No changes in the output from the following command.

[gshan@gshan q]$ ./build/qemu-hexagon -cpu ?
Available CPUs:
  v67
  v68
  v69
  v71
  v73

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/hexagon/cpu.c | 20 --------------------
 target/hexagon/cpu.h |  3 ---
 2 files changed, 23 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index aa48f5fe89..c0cd739e15 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -32,26 +32,6 @@ static void hexagon_v69_cpu_init(Object *obj) { }
 static void hexagon_v71_cpu_init(Object *obj) { }
 static void hexagon_v73_cpu_init(Object *obj) { }
 
-static void hexagon_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    char *name = g_strdup(object_class_get_name(oc));
-    if (g_str_has_suffix(name, HEXAGON_CPU_TYPE_SUFFIX)) {
-        name[strlen(name) - strlen(HEXAGON_CPU_TYPE_SUFFIX)] = '\0';
-    }
-    qemu_printf("  %s\n", name);
-    g_free(name);
-}
-
-void hexagon_cpu_list(void)
-{
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_HEXAGON_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, hexagon_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7d16083c6a..5c11ae3445 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -37,9 +37,6 @@
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 
-void hexagon_cpu_list(void);
-#define cpu_list hexagon_cpu_list
-
 #define MMU_USER_IDX 0
 
 typedef struct {
-- 
2.41.0


