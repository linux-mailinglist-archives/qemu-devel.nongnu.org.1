Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20B73EA81
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrIL-00041V-Vz; Mon, 26 Jun 2023 14:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIH-00040o-KS; Mon, 26 Jun 2023 14:50:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrIF-0004kX-FS; Mon, 26 Jun 2023 14:50:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 748BCEF16;
 Mon, 26 Jun 2023 21:50:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4A553F7A9;
 Mon, 26 Jun 2023 21:50:16 +0300 (MSK)
Received: (nullmailer pid 1573967 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:15 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 03/54] target/ppc: Fix fallback to MFSS for MFFS*
 instructions on pre 3.0 ISAs
Date: Mon, 26 Jun 2023 21:49:10 +0300
Message-Id: <20230626185002.1573836-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The following commits changed the code such that the fallback to MFSS for MFFSCRN,
MFFSCRNI, MFFSCE and MFFSL on pre 3.0 ISAs was removed and became an illegal instruction:

  bf8adfd88b547680aa857c46098f3a1e94373160 - target/ppc: Move mffscrn[i] to decodetree
  394c2e2fda70da722f20fb60412d6c0ca4bfaa03 - target/ppc: Move mffsce to decodetree
  3e5bce70efe6bd1f684efbb21fd2a316cbf0657e - target/ppc: Move mffsl to decodetree

The hardware will handle them as a MFFS instruction as the code did previously.
This means applications that were segfaulting under qemu when encountering these
instructions which is used in glibc libm functions for example.

The fallback for MFFSCDRN and MFFSCDRNI added in a later patch was also missing.

This patch restores the fallback to MFSS for these instructions on pre 3.0s ISAs
as the hardware decoder would, fixing the segfaulting libm code. It doesn't have
the fallback for 3.0 onwards to match hardware behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230510111913.1718734-1-richard.purdie@linuxfoundation.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 5260ecffd24e36c029849f379c8b9cc3d099c879)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f8f589e9fd..4fcf3af8d0 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -390,13 +390,19 @@ SETNBCR         011111 ..... ..... ----- 0111100000 -   @X_bi
 
 ### Move To/From FPSCR
 
-MFFS            111111 ..... 00000 ----- 1001000111 .   @X_t_rc
-MFFSCE          111111 ..... 00001 ----- 1001000111 -   @X_t
-MFFSCRN         111111 ..... 10110 ..... 1001000111 -   @X_tb
-MFFSCDRN        111111 ..... 10100 ..... 1001000111 -   @X_tb
-MFFSCRNI        111111 ..... 10111 ---.. 1001000111 -   @X_imm2
-MFFSCDRNI       111111 ..... 10101 --... 1001000111 -   @X_imm3
-MFFSL           111111 ..... 11000 ----- 1001000111 -   @X_t
+{
+  # Before Power ISA v3.0, MFFS bits 11~15 were reserved and should be ignored
+  MFFS_ISA207     111111 ..... ----- ----- 1001000111 .   @X_t_rc
+  [
+    MFFS            111111 ..... 00000 ----- 1001000111 .   @X_t_rc
+    MFFSCE          111111 ..... 00001 ----- 1001000111 -   @X_t
+    MFFSCRN         111111 ..... 10110 ..... 1001000111 -   @X_tb
+    MFFSCDRN        111111 ..... 10100 ..... 1001000111 -   @X_tb
+    MFFSCRNI        111111 ..... 10111 ---.. 1001000111 -   @X_imm2
+    MFFSCDRNI       111111 ..... 10101 --... 1001000111 -   @X_imm3
+    MFFSL           111111 ..... 11000 ----- 1001000111 -   @X_t
+  ]
+}
 
 ### Decimal Floating-Point Arithmetic Instructions
 
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 57d8437851..874774eade 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -568,6 +568,22 @@ static void store_fpscr_masked(TCGv_i64 fpscr, uint64_t clear_mask,
     gen_helper_store_fpscr(cpu_env, fpscr_masked, st_mask);
 }
 
+static bool trans_MFFS_ISA207(DisasContext *ctx, arg_X_t_rc *a)
+{
+    if (!(ctx->insns_flags2 & PPC2_ISA300)) {
+        /*
+         * Before Power ISA v3.0, MFFS bits 11~15 were reserved, any instruction
+         * with OPCD=63 and XO=583 should be decoded as MFFS.
+         */
+        return trans_MFFS(ctx, a);
+    }
+    /*
+     * For Power ISA v3.0+, return false and let the pattern group
+     * select the correct instruction.
+     */
+    return false;
+}
+
 static bool trans_MFFS(DisasContext *ctx, arg_X_t_rc *a)
 {
     REQUIRE_FPU(ctx);
@@ -584,7 +600,6 @@ static bool trans_MFFSCE(DisasContext *ctx, arg_X_t *a)
 {
     TCGv_i64 fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     gen_reset_fpstatus();
@@ -597,7 +612,6 @@ static bool trans_MFFSCRN(DisasContext *ctx, arg_X_tb *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -614,7 +628,6 @@ static bool trans_MFFSCDRN(DisasContext *ctx, arg_X_tb *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -631,7 +644,6 @@ static bool trans_MFFSCRNI(DisasContext *ctx, arg_X_imm2 *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -647,7 +659,6 @@ static bool trans_MFFSCDRNI(DisasContext *ctx, arg_X_imm3 *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -661,7 +672,6 @@ static bool trans_MFFSCDRNI(DisasContext *ctx, arg_X_imm3 *a)
 
 static bool trans_MFFSL(DisasContext *ctx, arg_X_t *a)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     gen_reset_fpstatus();
-- 
2.39.2


