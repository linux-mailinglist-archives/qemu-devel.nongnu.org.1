Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF283214B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:03:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQaSb-00075s-Fe; Thu, 18 Jan 2024 17:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSR-00070M-VR; Thu, 18 Jan 2024 17:01:55 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rQaSQ-0005FS-4R; Thu, 18 Jan 2024 17:01:55 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B36C14E62ED;
 Thu, 18 Jan 2024 23:01:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RQ9UPtijDn9i; Thu, 18 Jan 2024 23:01:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BFFA34E628A; Thu, 18 Jan 2024 23:01:50 +0100 (CET)
Message-Id: <2ae612eeb7f7712a4a3d1d13e08d218fb0a04e0b.1705614747.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1705614747.git.balaton@eik.bme.hu>
References: <cover.1705614747.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 8/9] target/ppc: Clean up ifdefs in excp_helper.c, part 3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Thu, 18 Jan 2024 23:01:50 +0100 (CET)
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

Concatenate #if blocks that are ending then beginning on the next line
again.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2d4a72883f..5124c3e6b5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2496,10 +2496,8 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
 void helper_store_msr(CPUPPCState *env, target_ulong val)
 {
     uint32_t excp = hreg_store_msr(env, val, 0);
@@ -2605,9 +2603,7 @@ void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
-#endif /* TARGET_PPC64 */
 
-#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2707,10 +2703,8 @@ void helper_rfmci(CPUPPCState *env)
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
-#endif /* CONFIG_TCG */
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* !CONFIG_USER_ONLY */
 
-#ifdef CONFIG_TCG
 void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
@@ -2738,9 +2732,7 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 #endif /* TARGET_PPC64 */
-#endif /* CONFIG_TCG */
 
-#ifdef CONFIG_TCG
 static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
 {
     const uint16_t c = 0xfffc;
@@ -2851,11 +2843,8 @@ HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
 HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
 HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
-
 /* Embedded.Processor Control */
 static int dbell2irq(target_ulong rb)
 {
@@ -3197,5 +3186,5 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
-#endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
-- 
2.30.9


