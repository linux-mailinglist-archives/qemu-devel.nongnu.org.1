Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A1832150
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQaSZ-00074P-9t; Thu, 18 Jan 2024 17:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSP-0006xx-Lm; Thu, 18 Jan 2024 17:01:53 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSM-00059z-Um; Thu, 18 Jan 2024 17:01:53 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7C69A4E622B;
 Thu, 18 Jan 2024 23:01:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pe24ocJOHLdR; Thu, 18 Jan 2024 23:01:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8AAA54E61B4; Thu, 18 Jan 2024 23:01:46 +0100 (CET)
Message-Id: <b00624744d5aa799ba6d772350b45d012393dfb5.1705614747.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1705614747.git.balaton@eik.bme.hu>
References: <cover.1705614747.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 4/9] target/ppc: Move patching nip from exception handler
 to helper_scv
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Thu, 18 Jan 2024 23:01:46 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Unlike sc, for scv a facility unavailable interrupt must be generated
if FSCR[SCV]=0 so we can't raise the exception with nip set to next
instruction but we can move advancing nip if the FSCR check passes to
helper_scv so the exception handler does not need to change it.

[balaton: added commit message]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 2 +-
 target/ppc/translate.c   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1c07a11405..411d67376c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1405,7 +1405,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
         lev = env->error_code;
         dump_syscall(env);
-        env->nip += 4;
         new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
 
@@ -2528,6 +2527,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
 void helper_scv(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        env->nip += 4;
         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
     } else {
         raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a80d24143e..d8cd34721c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4554,7 +4554,11 @@ static void gen_scv(DisasContext *ctx)
 {
     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
 
-    /* Set the PC back to the faulting instruction. */
+    /*
+     * Set the PC back to the scv instruction (unlike sc), because a facility
+     * unavailable interrupt must be generated if FSCR[SCV]=0. The helper
+     * advances nip if the FSCR check passes.
+     */
     gen_update_nip(ctx, ctx->cia);
     gen_helper_scv(tcg_env, tcg_constant_i32(lev));
 
-- 
2.30.9


