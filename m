Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9076AB6C4F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 15:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBfm-0000ds-Bl; Wed, 14 May 2025 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfb-0000Ey-Uc; Wed, 14 May 2025 08:57:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfZ-0007ix-TN; Wed, 14 May 2025 08:57:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5535121AC7;
 Wed, 14 May 2025 15:56:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 916E120B83F;
 Wed, 14 May 2025 15:56:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 07/18] target/mips: Simplify and fix update_pagemask
Date: Wed, 14 May 2025 15:56:13 +0300
Message-Id: <20250514125640.91677-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

When update_pagemask was split from helper_mtc0_pagemask,
we failed to actually write to the new parameter but continue
to write to env->CP0_PageMask.  Thus the use within
page_table_walk_refill modifies cpu state and not the local
variable as expected.

Simplify by renaming to compute_pagemask and returning the
value directly.  No need for either env or pointer return.

Fixes: 074cfcb4dae ("target/mips: Implement hardware page table walker for MIPS32")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 256ba7715b109c080c0c77a3923df9e69736ba17)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index a4a6282827..80260ecd8a 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -887,24 +887,24 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
+uint32_t compute_pagemask(uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    uint32_t mask = extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
     /* Ensure no more set bit after first zero, and maskbits even. */
     if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
-        env->CP0_PageMask = mask << CP0PM_MASK;
+        return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-        env->CP0_PageMask = 0;
+        return 0;
     }
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    update_pagemask(env, arg1, &env->CP0_PageMask);
+    env->CP0_PageMask = compute_pagemask(arg1);
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index f0a513365b..cce3dcdc0e 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -878,7 +878,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
+    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..be398665e6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -45,7 +45,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
+uint32_t compute_pagemask(uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
-- 
2.39.5


