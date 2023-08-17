Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA077F359
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMD-0000WI-0Y; Thu, 17 Aug 2023 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZLw-0006SP-W1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZLr-0002Yk-7t
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:39 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuOjx6N1kTnUZAA--.16567S3;
 Thu, 17 Aug 2023 17:31:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S5; 
 Thu, 17 Aug 2023 17:31:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 03/18] target/loongarch: Add GDB support for loongarch32
 mode
Date: Thu, 17 Aug 2023 17:31:06 +0800
Message-Id: <20230817093121.1053890-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Jiajie Chen <c@jia.je>

GPRs and PC are 32-bit wide in loongarch32 mode.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 configs/targets/loongarch64-softmmu.mak |  2 +-
 gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++++++++
 target/loongarch/cpu.c                  | 10 +++++-
 target/loongarch/gdbstub.c              | 32 ++++++++++++++----
 4 files changed, 80 insertions(+), 9 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 9abc99056f..f23780fdd8 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_SUPPORTS_MTTCG=y
-TARGET_XML_FILES= gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
+TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
 TARGET_NEED_FDT=y
diff --git a/gdb-xml/loongarch-base32.xml b/gdb-xml/loongarch-base32.xml
new file mode 100644
index 0000000000..af47bbd3da
--- /dev/null
+++ b/gdb-xml/loongarch-base32.xml
@@ -0,0 +1,45 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2022 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.loongarch.base">
+  <reg name="r0" bitsize="32" type="uint32" group="general"/>
+  <reg name="r1" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="r2" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r3" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r4" bitsize="32" type="uint32" group="general"/>
+  <reg name="r5" bitsize="32" type="uint32" group="general"/>
+  <reg name="r6" bitsize="32" type="uint32" group="general"/>
+  <reg name="r7" bitsize="32" type="uint32" group="general"/>
+  <reg name="r8" bitsize="32" type="uint32" group="general"/>
+  <reg name="r9" bitsize="32" type="uint32" group="general"/>
+  <reg name="r10" bitsize="32" type="uint32" group="general"/>
+  <reg name="r11" bitsize="32" type="uint32" group="general"/>
+  <reg name="r12" bitsize="32" type="uint32" group="general"/>
+  <reg name="r13" bitsize="32" type="uint32" group="general"/>
+  <reg name="r14" bitsize="32" type="uint32" group="general"/>
+  <reg name="r15" bitsize="32" type="uint32" group="general"/>
+  <reg name="r16" bitsize="32" type="uint32" group="general"/>
+  <reg name="r17" bitsize="32" type="uint32" group="general"/>
+  <reg name="r18" bitsize="32" type="uint32" group="general"/>
+  <reg name="r19" bitsize="32" type="uint32" group="general"/>
+  <reg name="r20" bitsize="32" type="uint32" group="general"/>
+  <reg name="r21" bitsize="32" type="uint32" group="general"/>
+  <reg name="r22" bitsize="32" type="data_ptr" group="general"/>
+  <reg name="r23" bitsize="32" type="uint32" group="general"/>
+  <reg name="r24" bitsize="32" type="uint32" group="general"/>
+  <reg name="r25" bitsize="32" type="uint32" group="general"/>
+  <reg name="r26" bitsize="32" type="uint32" group="general"/>
+  <reg name="r27" bitsize="32" type="uint32" group="general"/>
+  <reg name="r28" bitsize="32" type="uint32" group="general"/>
+  <reg name="r29" bitsize="32" type="uint32" group="general"/>
+  <reg name="r30" bitsize="32" type="uint32" group="general"/>
+  <reg name="r31" bitsize="32" type="uint32" group="general"/>
+  <reg name="orig_a0" bitsize="32" type="uint32" group="general"/>
+  <reg name="pc" bitsize="32" type="code_ptr" group="general"/>
+  <reg name="badv" bitsize="32" type="code_ptr" group="general"/>
+</feature>
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c6b73444b4..30dd70571a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -694,7 +694,13 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 
 static gchar *loongarch_gdb_arch_name(CPUState *cs)
 {
-    return g_strdup("loongarch64");
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    if (is_la64(env)) {
+        return g_strdup("loongarch64");
+    } else {
+        return g_strdup("loongarch32");
+    }
 }
 
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
@@ -734,6 +740,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 
 static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
 {
+    CPUClass *cc = CPU_CLASS(c);
+    cc->gdb_core_xml_file = "loongarch-base32.xml";
 }
 
 #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 0752fff924..a462e25737 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -34,16 +34,25 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
+    uint64_t val;
 
     if (0 <= n && n < 32) {
-        return gdb_get_regl(mem_buf, env->gpr[n]);
+        val = env->gpr[n];
     } else if (n == 32) {
         /* orig_a0 */
-        return gdb_get_regl(mem_buf, 0);
+        val = 0;
     } else if (n == 33) {
-        return gdb_get_regl(mem_buf, env->pc);
+        val = env->pc;
     } else if (n == 34) {
-        return gdb_get_regl(mem_buf, env->CSR_BADV);
+        val = env->CSR_BADV;
+    }
+
+    if (0 <= n && n <= 34) {
+        if (is_la64(env)) {
+            return gdb_get_reg64(mem_buf, val);
+        } else {
+            return gdb_get_reg32(mem_buf, val);
+        }
     }
     return 0;
 }
@@ -52,15 +61,24 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
-    target_ulong tmp = ldtul_p(mem_buf);
+    target_ulong tmp;
+    int read_length;
     int length = 0;
 
+    if (is_la64(env)) {
+        tmp = ldq_p(mem_buf);
+        read_length = 8;
+    } else {
+        tmp = ldl_p(mem_buf);
+        read_length = 4;
+    }
+
     if (0 <= n && n < 32) {
         env->gpr[n] = tmp;
-        length = sizeof(target_ulong);
+        length = read_length;
     } else if (n == 33) {
         env->pc = tmp;
-        length = sizeof(target_ulong);
+        length = read_length;
     }
     return length;
 }
-- 
2.39.1


