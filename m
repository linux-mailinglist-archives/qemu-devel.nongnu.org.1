Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3979E906
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPmQ-0000po-L4; Wed, 13 Sep 2023 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPmN-0000lJ-Tz; Wed, 13 Sep 2023 09:19:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPmL-0004F1-Cy; Wed, 13 Sep 2023 09:19:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4DB6821770;
 Wed, 13 Sep 2023 16:18:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2C36727C92;
 Wed, 13 Sep 2023 16:18:05 +0300 (MSK)
Received: (nullmailer pid 4073328 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 64/66] target/riscv: fix satp_mode_finalize() when
 satp_mode.supported = 0
Date: Wed, 13 Sep 2023 16:17:45 +0300
Message-Id: <20230913131757.4073200-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In the same emulated RISC-V host, the 'host' KVM CPU takes 4 times
longer to boot than the 'rv64' KVM CPU.

The reason is an unintended behavior of riscv_cpu_satp_mode_finalize()
when satp_mode.supported = 0, i.e. when cpu_init() does not set
satp_mode_max_supported(). satp_mode_max_from_map(map) does:

31 - __builtin_clz(map)

This means that, if satp_mode.supported = 0, satp_mode_supported_max
wil be '31 - 32'. But this is C, so satp_mode_supported_max will gladly
set it to UINT_MAX (4294967295). After that, if the user didn't set a
satp_mode, set_satp_mode_default_map(cpu) will make

cfg.satp_mode.map = cfg.satp_mode.supported

So satp_mode.map = 0. And then satp_mode_map_max will be set to
satp_mode_max_from_map(cpu->cfg.satp_mode.map), i.e. also UINT_MAX. The
guard "satp_mode_map_max > satp_mode_supported_max" doesn't protect us
here since both are UINT_MAX.

And finally we have 2 loops:

        for (int i = satp_mode_map_max - 1; i >= 0; --i) {

Which are, in fact, 2 loops from UINT_MAX -1 to -1. This is where the
extra delay when booting the 'host' CPU is coming from.

Commit 43d1de32f8 already set a precedence for satp_mode.supported = 0
in a different manner. We're doing the same here. If supported == 0,
interpret as 'the CPU wants the OS to handle satp mode alone' and skip
satp_mode_finalize().

We'll also put a guard in satp_mode_max_from_map() to assert out if map
is 0 since the function is not ready to deal with it.

Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Fixes: 6f23aaeb9b ("riscv: Allow user to set the satp mode")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230817152903.694926-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 3a2fc23563885c219c73c8f24318921daf02f3f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1e97473af2..8c0721c715 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -282,6 +282,17 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
 
 uint8_t satp_mode_max_from_map(uint32_t map)
 {
+    /*
+     * 'map = 0' will make us return (31 - 32), which C will
+     * happily overflow to UINT_MAX. There's no good result to
+     * return if 'map = 0' (e.g. returning 0 will be ambiguous
+     * with the result for 'map = 1').
+     *
+     * Assert out if map = 0. Callers will have to deal with
+     * it outside of this function.
+     */
+    g_assert(map > 0);
+
     /* map here has at least one bit set, so no problem with clz */
     return 31 - __builtin_clz(map);
 }
@@ -1043,9 +1054,15 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    uint8_t satp_mode_map_max;
-    uint8_t satp_mode_supported_max =
-                        satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    uint8_t satp_mode_map_max, satp_mode_supported_max;
+
+    /* The CPU wants the OS to decide which satp mode to use */
+    if (cpu->cfg.satp_mode.supported == 0) {
+        return;
+    }
+
+    satp_mode_supported_max =
+                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
 
     if (cpu->cfg.satp_mode.map == 0) {
         if (cpu->cfg.satp_mode.init == 0) {
-- 
2.39.2


