Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8289EA1C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 07:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQo7-0002Z4-Fs; Wed, 10 Apr 2024 01:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQnl-0000hR-Ag; Wed, 10 Apr 2024 01:47:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQnh-0001yo-Cv; Wed, 10 Apr 2024 01:47:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C70E95D4F8;
 Wed, 10 Apr 2024 08:46:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B71CB015F;
 Wed, 10 Apr 2024 08:44:18 +0300 (MSK)
Received: (nullmailer pid 4182099 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 32/41] target/loongarch: Fix qemu-system-loongarch64
 assert failed with the option '-d int'
Date: Wed, 10 Apr 2024 08:43:53 +0300
Message-Id: <20240410054416.4181891-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Song Gao <gaosong@loongson.cn>

qemu-system-loongarch64 assert failed with the option '-d int',
the helper_idle() raise an exception EXCP_HLT, but the exception name is undefined.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240321123606.1704900-1-gaosong@loongson.cn>
(cherry picked from commit 1590154ee4376819a8c6ee61e849ebf4a4e7cd02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup for lack of 2 commits adding new entries into excp_names[]:
 v8.0.0-514-ga3f3db5cda "target/loongarch: Add CHECK_SXE maccro for check LSX enable" and
 v8.1.0-801-gb8f1bdf3d1 "target/loongarch: check_vec support check LASX instructions")

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 46b04cbdad..92dd50e15e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -33,31 +33,45 @@ const char * const fregnames[32] = {
     "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
 };
 
-static const char * const excp_names[] = {
-    [EXCCODE_INT] = "Interrupt",
-    [EXCCODE_PIL] = "Page invalid exception for load",
-    [EXCCODE_PIS] = "Page invalid exception for store",
-    [EXCCODE_PIF] = "Page invalid exception for fetch",
-    [EXCCODE_PME] = "Page modified exception",
-    [EXCCODE_PNR] = "Page Not Readable exception",
-    [EXCCODE_PNX] = "Page Not Executable exception",
-    [EXCCODE_PPI] = "Page Privilege error",
-    [EXCCODE_ADEF] = "Address error for instruction fetch",
-    [EXCCODE_ADEM] = "Address error for Memory access",
-    [EXCCODE_SYS] = "Syscall",
-    [EXCCODE_BRK] = "Break",
-    [EXCCODE_INE] = "Instruction Non-Existent",
-    [EXCCODE_IPE] = "Instruction privilege error",
-    [EXCCODE_FPD] = "Floating Point Disabled",
-    [EXCCODE_FPE] = "Floating Point Exception",
-    [EXCCODE_DBP] = "Debug breakpoint",
-    [EXCCODE_BCE] = "Bound Check Exception",
+struct TypeExcp {
+    int32_t exccode;
+    const char * const name;
+};
+
+static const struct TypeExcp excp_names[] = {
+    {EXCCODE_INT, "Interrupt"},
+    {EXCCODE_PIL, "Page invalid exception for load"},
+    {EXCCODE_PIS, "Page invalid exception for store"},
+    {EXCCODE_PIF, "Page invalid exception for fetch"},
+    {EXCCODE_PME, "Page modified exception"},
+    {EXCCODE_PNR, "Page Not Readable exception"},
+    {EXCCODE_PNX, "Page Not Executable exception"},
+    {EXCCODE_PPI, "Page Privilege error"},
+    {EXCCODE_ADEF, "Address error for instruction fetch"},
+    {EXCCODE_ADEM, "Address error for Memory access"},
+    {EXCCODE_SYS, "Syscall"},
+    {EXCCODE_BRK, "Break"},
+    {EXCCODE_INE, "Instruction Non-Existent"},
+    {EXCCODE_IPE, "Instruction privilege error"},
+    {EXCCODE_FPD, "Floating Point Disabled"},
+    {EXCCODE_FPE, "Floating Point Exception"},
+    {EXCCODE_DBP, "Debug breakpoint"},
+    {EXCCODE_BCE, "Bound Check Exception"},
+    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
+    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCP_HLT, "EXCP_HLT"},
 };
 
 const char *loongarch_exception_name(int32_t exception)
 {
-    assert(excp_names[exception]);
-    return excp_names[exception];
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
+        if (excp_names[i].exccode == exception) {
+            return excp_names[i].name;
+        }
+    }
+    return "Unknown";
 }
 
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
@@ -66,7 +80,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s)\n",
+    qemu_log_mask(CPU_LOG_INT, "%s: expection: %d (%s)\n",
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
@@ -143,22 +157,16 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     CPULoongArchState *env = &cpu->env;
     bool update_badinstr = 1;
     int cause = -1;
-    const char *name;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
 
     if (cs->exception_index != EXCCODE_INT) {
-        if (cs->exception_index < 0 ||
-            cs->exception_index >= ARRAY_SIZE(excp_names)) {
-            name = "unknown";
-        } else {
-            name = excp_names[cs->exception_index];
-        }
-
         qemu_log_mask(CPU_LOG_INT,
                      "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
-                     " TLBRERA " TARGET_FMT_lx " %s exception\n", __func__,
-                     env->pc, env->CSR_ERA, env->CSR_TLBRERA, name);
+                     " TLBRERA " TARGET_FMT_lx " exception: %d (%s)\n",
+                     __func__, env->pc, env->CSR_ERA, env->CSR_TLBRERA,
+                     cs->exception_index,
+                     loongarch_exception_name(cs->exception_index));
     }
 
     switch (cs->exception_index) {
-- 
2.39.2


