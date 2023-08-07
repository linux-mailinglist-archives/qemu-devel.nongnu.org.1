Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F4D7718C2
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 05:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSqm7-0000wz-58; Sun, 06 Aug 2023 23:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSqm1-0000vl-93
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 23:19:14 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSqlz-0002Ep-Cs
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 23:19:13 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id BA67941FEB;
 Mon,  7 Aug 2023 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691378350; bh=0aopDn3HiqdrGJxkqGFEjZ9YRCd2L4Dg6StwXOZgbSI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nPRheFJYeGfpNiMCl8U1qqBnMJ1JET2nkYHF2Zsiquj8FzaccfMTD1kAWtf9DqKIk
 sbrUeTq68AeKoupR5aJ5rPYFyr7WS66zUrsnafrO7yI4xxkdl4iY1DBcyMQw38gN4K
 ycpZgG/8kw5/ceneBcEO4zv1e+9ckK1E1nMFrCQQ=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] target/loongarch: Add GDB support for loongarch32 mode
Date: Mon,  7 Aug 2023 11:18:48 +0800
Message-Id: <20230807031850.1961130-3-c@jia.je>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807031850.1961130-1-c@jia.je>
References: <20230807031850.1961130-1-c@jia.je>
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

GPRs and PC are 32-bit wide in loongarch32 mode.

Signed-off-by: Jiajie Chen <c@jia.je>
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
index d31efe86da..ee6d45f1b0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -710,7 +710,13 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
 
 static gchar *loongarch_gdb_arch_name(CPUState *cs)
 {
-    return g_strdup("loongarch64");
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    if (env->mode == LA64) {
+        return g_strdup("loongarch64");
+    } else {
+        return g_strdup("loongarch32");
+    }
 }
 
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
@@ -750,6 +756,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 
 static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
 {
+    CPUClass *cc = CPU_CLASS(c);
+    cc->gdb_core_xml_file = "loongarch-base32.xml";
 }
 
 #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 0752fff924..7c82204e92 100644
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
+        if (env->mode == LA64) {
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
 
+    if (env->mode == LA64) {
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
2.39.2


