Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29999771D5D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwoD-0006xR-EN; Mon, 07 Aug 2023 05:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwo6-0006tm-5J
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:48 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwo4-0002uN-Go
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:45 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id B7F6443B9B;
 Mon,  7 Aug 2023 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691401541; bh=C0i+nmBhNDiH0s67+9P3xHZ9nUpjop/vjTD6yVAonDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kkqfkWJemWELzB+SOAB5jzY1PxukXyW/t5pIwWbg/vLkJarUXYBcohPdGdTVJZIdK
 S8Pp0HFT+hS1Omzq1FJvYBx46mVo3dS6jFOnKP0T9k/tgWxqAuX2uOtH9XPFR/gjoG
 TzvRqpGbqWYjqM9/tzhzE0mSXJvRQvTkWChYe+mg=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 2/6] target/loongarch: Add loongarch32 cpu la132
Date: Mon,  7 Aug 2023 17:45:01 +0800
Message-Id: <20230807094505.2030603-3-c@jia.je>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807094505.2030603-1-c@jia.je>
References: <20230807094505.2030603-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add la132 as a loongarch32 cpu type and allow virt machine to be used
with la132 instead of la464.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 hw/loongarch/virt.c    |  5 -----
 target/loongarch/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 target/loongarch/cpu.h | 11 +++++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..af15bf5aaa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
-    if (!strstr(cpu_model, "la464")) {
-        error_report("LoongArch/TCG needs cpu type la464");
-        exit(1);
-    }
-
     if (ram_size < 1 * GiB) {
         error_report("ram_size must be greater than 1G.");
         exit(1);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..d31efe86da 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -362,6 +362,8 @@ static void loongarch_la464_initfn(Object *obj)
     CPULoongArchState *env = &cpu->env;
     int i;
 
+    env->mode = LA64;
+
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -439,6 +441,20 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 }
 
+static void loongarch_la132_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    env->mode = LA32;
+
+    cpu->dtb_compatible = "loongarch,Loongson-3C103";
+
+    uint32_t data = 0;
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    env->cpucfg[1] = data;
+}
+
 static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
@@ -732,6 +748,10 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
+{
+}
+
 #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
     { \
         .parent = TYPE_LOONGARCH_CPU, \
@@ -754,3 +774,24 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)
+
+#define DEFINE_LOONGARCH32_CPU_TYPE(model, initfn) \
+    { \
+        .parent = TYPE_LOONGARCH32_CPU, \
+        .instance_init = initfn, \
+        .name = LOONGARCH_CPU_TYPE_NAME(model), \
+    }
+
+static const TypeInfo loongarch32_cpu_type_infos[] = {
+    {
+        .name = TYPE_LOONGARCH32_CPU,
+        .parent = TYPE_LOONGARCH_CPU,
+        .instance_size = sizeof(LoongArchCPU),
+
+        .abstract = true,
+        .class_size = sizeof(LoongArchCPUClass),
+        .class_init = loongarch32_cpu_class_init,
+    },
+    DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
+};
+DEFINE_TYPES(loongarch32_cpu_type_infos)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 43c73e6363..f1907cddc5 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,6 +404,17 @@ struct LoongArchCPUClass {
     ResettablePhases parent_phases;
 };
 
+#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
+typedef struct LoongArch32CPUClass LoongArch32CPUClass;
+DECLARE_CLASS_CHECKERS(LoongArch32CPUClass, LOONGARCH32_CPU,
+                       TYPE_LOONGARCH32_CPU)
+
+struct LoongArch32CPUClass {
+    /*< private >*/
+    LoongArchCPUClass parent_class;
+    /*< public >*/
+};
+
 /*
  * LoongArch CPUs has 4 privilege levels.
  * 0 for kernel mode, 3 for user mode.
-- 
2.39.2


