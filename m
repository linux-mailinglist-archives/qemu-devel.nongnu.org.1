Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16956786BAB
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Zv-0003k9-VL; Thu, 24 Aug 2023 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6Zs-0003aG-9T
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6Zm-0003SE-GU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axjuu_IedkR3kbAA--.53765S3;
 Thu, 24 Aug 2023 17:24:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S10; 
 Thu, 24 Aug 2023 17:24:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/31] target/loongarch: Add GDB support for loongarch32 mode
Date: Thu, 24 Aug 2023 17:23:46 +0800
Message-Id: <20230824092409.1492470-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S10
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
Message-ID: <20230817093121.1053890-4-gaosong@loongson.cn>
[PMD: Rebased, set gdb_num_core_regs]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230821125959.28666-9-philmd@linaro.org>
---
 configs/targets/loongarch64-softmmu.mak |  2 +-
 gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++++++++
 target/loongarch/cpu.c                  | 10 ++++++
 target/loongarch/gdbstub.c              | 32 ++++++++++++++----
 4 files changed, 81 insertions(+), 8 deletions(-)
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
index 556419f159..822f2a72e5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -726,8 +726,18 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #endif
 }
 
+static gchar *loongarch32_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("loongarch32");
+}
+
 static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
 {
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "loongarch-base32.xml";
+    cc->gdb_arch_name = loongarch32_gdb_arch_name;
 }
 
 static gchar *loongarch64_gdb_arch_name(CPUState *cs)
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


