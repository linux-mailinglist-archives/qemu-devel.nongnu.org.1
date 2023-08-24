Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4D786C07
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eU-0006o8-GO; Thu, 24 Aug 2023 05:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006JB-Ac
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00050T-MD
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so1125836f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869327; x=1693474127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDHSxOSl0MJbCZlJn1CE8qSsJHuOf7Mv48j5eHy1yrg=;
 b=ep9kXQ+65tYcGgq8lhWchFsI9c7eHiARn+y74xO55HkYTvbx+XDnsexFvEkuPnra6y
 AarTmmmxcYzozj1vwIqY63vXc5bGLFUELrnM+P/F/auBudsxZgZTxKgk8Ujonca17DVz
 CfAHxSTzCishPSZK6GAR0Agd/ptXJGjb4DsRlLqrdcd0Vb+ll92cNsMKKXp3Vg2aJXbc
 JcYUIrKGgg8lMnoUqaBHlVZLEsqTSB8ADxkwqhqdjqvwvdpXpVqD6OVSYiUlPg9dqN+f
 SV0IJeyRPEojEE0msPlJOWS8kCY45nIADPza5jBfuAIwkV+vJlH7CbV/EaRRBVVpfQBp
 ZTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869327; x=1693474127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDHSxOSl0MJbCZlJn1CE8qSsJHuOf7Mv48j5eHy1yrg=;
 b=Qw382xvCVxNszzR3nenvMLmXf/R1R2/r+2DL+612yw4ip0Lpzw8PNG2PzYEMEmi44d
 NbR7rourPp7iw+jW3r22qyK+dLsyN9mGmIWdgVMJmtbvlmRg/Zkf4B2C0rH0NTdIcrcZ
 l99Upz9oIvI0dUPc4C/VdEznf9otfibKMiigPtUJQdilQS5DLhUg2jJ6Dk32aPhNXfFF
 FCNmh0Zn7btcFT6/20MESp/jxw0OPSMGT+FW4NOWFRjxqT+tRaIDVjimzOYAPOPikbzw
 lmiEWYGfSGRPd8AwvoBd5z+nYTb6ZY9+wBqlgAJS4LnPb/qL7OzGo3b3Kup32ulSB3c0
 1Z/g==
X-Gm-Message-State: AOJu0Yz6P5HckL4mZA/j/HueFAQAf+5t43O/FjxVlsdQVU5qngQo0a4F
 DUl8rrjPdgD1Ylg/mXLhTSJHFZEFl1sJewUK7rs=
X-Google-Smtp-Source: AGHT+IEi512bRtS2UZbR/VIhiZMpPIEqFCMbB8nCxeNi4JXfNO1pOdH0aDJIJFKq2tzhqbxa8dAMKg==
X-Received: by 2002:adf:ee0e:0:b0:319:755c:3c1e with SMTP id
 y14-20020adfee0e000000b00319755c3c1emr10574318wrn.11.1692869327042; 
 Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/35] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
Date: Thu, 24 Aug 2023 10:28:19 +0100
Message-Id: <20230824092836.2239644-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

arm_hcr_el2_eff_secstate() takes a bool secure, which it uses to
determine whether EL2 is enabled in the current security state.
With the advent of FEAT_RME this is no longer sufficient, because
EL2 can be enabled for Secure state but not for Root, and both
of those will pass 'secure == true' in the callsites in ptw.c.

As it happens in all of our callsites in ptw.c we either avoid making
the call or else avoid using the returned value if we're doing a
translation for Root, so this is not a behaviour change even if the
experimental FEAT_RME is enabled.  But it is less confusing in the
ptw.c code if we avoid the use of a bool secure that duplicates some
of the information in the ArmSecuritySpace argument.

Make arm_hcr_el2_eff_secstate() take an ARMSecuritySpace argument
instead. Because we always want to know the HCR_EL2 for the
security state defined by the current effective value of
SCR_EL3.{NSE,NS}, it makes no sense to pass ARMSS_Root here,
and we assert that callers don't do that.

To avoid the assert(), we thus push the call to
arm_hcr_el2_eff_secstate() down into the cases in
regime_translation_disabled() that need it, rather than calling the
function and ignoring the result for the Root space translations.
All other calls to this function in ptw.c are already in places
where we have confirmed that the mmu_idx is a stage 2 translation
or that the regime EL is not 3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-7-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c |  8 +++++---
 target/arm/ptw.c    | 15 +++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88e5accda69..bcd65a63ca0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2555,7 +2555,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  * "for all purposes other than a direct read or write access of HCR_EL2."
  * Not included here is HCR_RW.
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure);
+uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50f61e42ca8..9862bc73b52 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5772,11 +5772,13 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
  * Bits that are not included here:
  * RW       (read from SCR_EL3.RW as needed)
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure)
+uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
 {
     uint64_t ret = env->cp15.hcr_el2;
 
-    if (!arm_is_el2_enabled_secstate(env, secure)) {
+    assert(space != ARMSS_Root);
+
+    if (!arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
         /*
          * "This register has no effect if EL2 is not enabled in the
          * current Security state".  This is ARMv8.4-SecEL2 speak for
@@ -5840,7 +5842,7 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     if (arm_feature(env, ARM_FEATURE_M)) {
         return 0;
     }
-    return arm_hcr_el2_eff_secstate(env, arm_is_secure_below_el3(env));
+    return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
 /*
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 63dd8e3cbe1..4c60de753dd 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -209,9 +209,9 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
                                         ARMSecuritySpace space)
 {
     uint64_t hcr_el2;
-    bool is_secure = arm_space_is_secure(space);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
+        bool is_secure = arm_space_is_secure(space);
         switch (env->v7m.mpu_ctrl[is_secure] &
                 (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
         case R_V7M_MPU_CTRL_ENABLE_MASK:
@@ -230,18 +230,19 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
         }
     }
 
-    hcr_el2 = arm_hcr_el2_eff_secstate(env, is_secure);
 
     switch (mmu_idx) {
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_Stage2_S:
         /* HCR.DC means HCR.VM behaves as 1 */
+        hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
         return (hcr_el2 & (HCR_DC | HCR_VM)) == 0;
 
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
         /* TGE means that EL0/1 act as if SCTLR_EL1.M is zero */
+        hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
         if (hcr_el2 & HCR_TGE) {
             return true;
         }
@@ -251,6 +252,7 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
+        hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
         if (hcr_el2 & HCR_DC) {
             return true;
         }
@@ -530,7 +532,6 @@ static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
 static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                              hwaddr addr, ARMMMUFaultInfo *fi)
 {
-    bool is_secure = ptw->in_secure;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     ARMMMUIdx s2_mmu_idx = ptw->in_ptw_idx;
     uint8_t pte_attrs;
@@ -587,7 +588,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_is_stage2(s2_mmu_idx)) {
-        uint64_t hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
 
         if ((hcr & HCR_PTW) && S2_attrs_are_device(hcr, pte_attrs)) {
             /*
@@ -3066,7 +3067,6 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                                    ARMMMUFaultInfo *fi)
 {
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_secure = arm_space_is_secure(ptw->in_space);
     uint8_t memattr = 0x00;    /* Device nGnRnE */
     uint8_t shareability = 0;  /* non-shareable */
     int r_el;
@@ -3112,7 +3112,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 
         /* Fill in cacheattr a-la AArch64.TranslateAddressS1Off. */
         if (r_el == 1) {
-            uint64_t hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+            uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
             if (hcr & HCR_DC) {
                 if (hcr & HCR_DCT) {
                     memattr = 0xf0;  /* Tagged, Normal, WB, RWA */
@@ -3149,7 +3149,6 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 {
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
-    bool is_secure = ptw->in_secure;
     ARMSecuritySpace in_space = ptw->in_space;
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
@@ -3212,7 +3211,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     }
 
     /* Combine the S1 and S2 cache attributes. */
-    hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+    hcr = arm_hcr_el2_eff_secstate(env, in_space);
     if (hcr & HCR_DC) {
         /*
          * HCR.DC forces the first stage attributes to
-- 
2.34.1


