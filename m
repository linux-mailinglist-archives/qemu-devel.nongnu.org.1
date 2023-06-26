Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9475E73EA89
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrJ8-0004Yt-QY; Mon, 26 Jun 2023 14:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJ3-0004Wo-Re; Mon, 26 Jun 2023 14:51:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJ1-00050C-SS; Mon, 26 Jun 2023 14:51:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00297EF26;
 Mon, 26 Jun 2023 21:50:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4884FF7B5;
 Mon, 26 Jun 2023 21:50:19 +0300 (MSK)
Received: (nullmailer pid 1574003 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 15/54] target/arm: Explicitly select short-format FSR
 for M-profile
Date: Mon, 26 Jun 2023 21:49:22 +0300
Message-Id: <20230626185002.1573836-15-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

For M-profile, there is no guest-facing A-profile format FSR, but we
still use the env->exception.fsr field to pass fault information from
the point where a fault is raised to the code in
arm_v7m_cpu_do_interrupt() which interprets it and sets the M-profile
specific fault status registers.  So it doesn't matter whether we
fill in env->exception.fsr in the short format or the LPAE format, as
long as both sides agree.  As it happens arm_v7m_cpu_do_interrupt()
assumes short-form.

In compute_fsr_fsc() we weren't explicitly choosing short-form for
M-profile, but instead relied on it falling out in the wash because
arm_s1_regime_using_lpae_format() would be false.  This was broken in
commit 452c67a4 when we added v8R support, because we said "PMSAv8 is
always LPAE format" (as it is for v8R), forgetting that we were
implicitly using this code path on M-profile. At that point we would
hit a g_assert_not_reached():
 ERROR:../../target/arm/internals.h:549:arm_fi_to_lfsc: code should not be reached

#7  0x0000555555e055f7 in arm_fi_to_lfsc (fi=0x7fffecff9a90) at ../../target/arm/internals.h:549
#8  0x0000555555e05a27 in compute_fsr_fsc (env=0x555557356670, fi=0x7fffecff9a90, target_el=1, mmu_idx=1, ret_fsc=0x7fffecff9a1c)
    at ../../target/arm/tlb_helper.c:95
#9  0x0000555555e05b62 in arm_deliver_fault (cpu=0x555557354800, addr=268961344, access_type=MMU_INST_FETCH, mmu_idx=1, fi=0x7fffecff9a90)
    at ../../target/arm/tlb_helper.c:132
#10 0x0000555555e06095 in arm_cpu_tlb_fill (cs=0x555557354800, address=268961344, size=1, access_type=MMU_INST_FETCH, mmu_idx=1, probe=false, retaddr=0)
    at ../../target/arm/tlb_helper.c:260

The specific assertion changed when commit fcc7404eff24b4c added
"assert not M-profile" to arm_is_secure_below_el3(), because the
conditions being checked in compute_fsr_fsc() include
arm_el_is_aa64(), which will end up calling arm_is_secure_below_el3()
and asserting before we try to call arm_fi_to_lfsc():

#7  0x0000555555efaf43 in arm_is_secure_below_el3 (env=0x5555574665a0) at ../../target/arm/cpu.h:2396
#8  0x0000555555efb103 in arm_is_el2_enabled (env=0x5555574665a0) at ../../target/arm/cpu.h:2448
#9  0x0000555555efb204 in arm_el_is_aa64 (env=0x5555574665a0, el=1) at ../../target/arm/cpu.h:2509
#10 0x0000555555efbdfd in compute_fsr_fsc (env=0x5555574665a0, fi=0x7fffecff99e0, target_el=1, mmu_idx=1, ret_fsc=0x7fffecff996c)

Avoid the assertion and the incorrect FSR format selection by
explicitly making M-profile use the short-format in this function.

Fixes: 452c67a42704 ("target/arm: Enable TTBCR_EAE for ARMv8-R AArch32")a
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1658
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230523131726.866635-1-peter.maydell@linaro.org
(cherry picked from commit d7fe699be54b2cbb8e4ee37b63588b3458a49da7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 31eb77f7df..7166923ebf 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -68,8 +68,17 @@ static uint32_t compute_fsr_fsc(CPUARMState *env, ARMMMUFaultInfo *fi,
     ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
     uint32_t fsr, fsc;
 
-    if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
-        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
+    /*
+     * For M-profile there is no guest-facing FSR. We compute a
+     * short-form value for env->exception.fsr which we will then
+     * examine in arm_v7m_cpu_do_interrupt(). In theory we could
+     * use the LPAE format instead as long as both bits of code agree
+     * (and arm_fi_to_lfsc() handled the M-profile specific
+     * ARMFault_QEMU_NSCExec and ARMFault_QEMU_SFault cases).
+     */
+    if (!arm_feature(env, ARM_FEATURE_M) &&
+        (target_el == 2 || arm_el_is_aa64(env, target_el) ||
+         arm_s1_regime_using_lpae_format(env, arm_mmu_idx))) {
         /*
          * LPAE format fault status register : bottom 6 bits are
          * status code in the same form as needed for syndrome
-- 
2.39.2


