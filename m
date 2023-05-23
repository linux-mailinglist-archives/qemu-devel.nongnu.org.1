Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A938170DD54
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RtP-0005zX-1G; Tue, 23 May 2023 09:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1RtM-0005wa-Pz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:17:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1RtJ-000396-F7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:17:32 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4884712f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847848; x=1687439848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LkjqdKUcDn2/SNKZAz8AfREoxe1hNpTQmu1ENSJzA9k=;
 b=O/j7Tvnva972+DO/yDSzTTtKVXAvycqCbwMnNqml1XMUS8XnAfbNkjWCLmZJWfmHDo
 elmiCL8JPabsBPU0KJrScswVlZCVlD4SqfaRAckbL8eY62CIjeUt8oHB2rewbFBvaoQM
 0xWnXwDJulEb1MadIe2vNROH3f4yADriwbsOudzyyNqR5qIURKeHjA8wrJOjTK9/Ob5p
 +lhnM2PEtlEPBOAZca30BGtiFqwgujm4R+Os459gTXjw6nDqBQXkMT8dYzHS0R65UONY
 hlYBHLZn7wwT7n8B2oWESn1XTan4GhFvQ1j201dUuG9mtwClqE7ftGyYdupPCoNGAUvO
 pNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847848; x=1687439848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LkjqdKUcDn2/SNKZAz8AfREoxe1hNpTQmu1ENSJzA9k=;
 b=NGAZpmmztcAqM8yHKIorBbm4zB/fuCiJzCGevhvhbwA0BW+ikKrsxDtRqcRmfwlXeR
 mApJRv/pc+UWiqO3UsGBcP4PYmPMSpxAfryKk+UMG22irB63tMfUsUOMjqNWaK3ryWHb
 fzmV85WDDPP1s4+LAOJqYEM8WXfmv3gas0FL8jRpdOQd88e5hwCRLKLbUYlYkYH7CCvb
 tXog0niD4PFoVfFhuMjvJeRGeguxjWvtgz/7/XjnNm+GVktdzLX2D6Z+Ey4j0AlwHCH4
 y91o5bWHhgu/Mr7TDZ7Y6L0cHifhTKu8C5BqdNtLN2ocsQ2laAozr5GUpd3R4zZh8uXY
 CT2w==
X-Gm-Message-State: AC+VfDxp1+FBydvSysg6zISVncpKySMX4PGVDv8WVsXaFzU4/+8K2arX
 dQHE8UOxPldvmIWtkkkEnJtQ2A==
X-Google-Smtp-Source: ACHHUZ5sEXsSHZtaeAPnRjWvoFY7gDgOL2ZL3EDWFwb+a6tgA+YcKmT88TVxxeXuddDWCLKBSYF0Ag==
X-Received: by 2002:adf:f548:0:b0:307:904b:29e1 with SMTP id
 j8-20020adff548000000b00307904b29e1mr9942982wrp.20.1684847847608; 
 Tue, 23 May 2023 06:17:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adfd842000000b0030647449730sm11115598wrl.74.2023.05.23.06.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:17:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Explicitly select short-format FSR for M-profile
Date: Tue, 23 May 2023 14:17:26 +0100
Message-Id: <20230523131726.866635-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/tcg/tlb_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index d5a89bc5141..8df36c2cbf0 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -75,8 +75,17 @@ static uint32_t compute_fsr_fsc(CPUARMState *env, ARMMMUFaultInfo *fi,
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
2.34.1


