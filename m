Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056EB73230B
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9w02-0002Wm-4Y; Thu, 15 Jun 2023 19:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzz-0002Qk-QR; Thu, 15 Jun 2023 19:03:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzy-0007jf-4D; Thu, 15 Jun 2023 19:03:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 202C3748A5B;
 Fri, 16 Jun 2023 01:03:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01FFB748A56; Fri, 16 Jun 2023 01:03:19 +0200 (CEST)
Message-Id: <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686868895.git.balaton@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 09/14] target/ppc: Move patching nip from exception handler
 to helper_scv
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 16 Jun 2023 01:03:19 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
This needs SoB from Nick

 target/ppc/excp_helper.c | 2 +-
 target/ppc/translate.c   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 903216c2a6..ef363b0285 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1304,7 +1304,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
         lev = env->error_code;
         dump_syscall(env);
-        env->nip += 4;
         new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
 
@@ -2410,6 +2409,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
 void helper_scv(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        env->nip += 4;
         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
     } else {
         raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4260d3d66f..0360a17fb3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4433,7 +4433,11 @@ static void gen_scv(DisasContext *ctx)
 {
     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
 
-    /* Set the PC back to the faulting instruction. */
+    /*
+     * Set the PC back to the scv instruction (unlike sc), because a facility
+     * unavailable interrupt must be generated if FSCR[SCV]=0. The helper
+     * advances nip if the FSCR check passes.
+     */
     gen_update_nip(ctx, ctx->cia);
     gen_helper_scv(cpu_env, tcg_constant_i32(lev));
 
-- 
2.30.9


