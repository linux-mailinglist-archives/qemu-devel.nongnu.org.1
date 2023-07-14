Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A85753F47
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0Z-0007G8-LW; Fri, 14 Jul 2023 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0V-0007DR-8Z
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0R-00075d-8B
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso2145448f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NaxZtJ/Zz22f09eQWd/e/ljK+9HRxTBlYQ6KBcsfIVM=;
 b=W+KiEeRbe7uLSwAPNeebc+R7ZWvzTKi8otnyrRvka0SurnrjXrvz2cauO2NWdAsXHD
 PKAZtzToBwKOiVeGyw2bBf0zlc0ZWRq+erI4ClyjF4BJevUv8qEmjyDtl50YRnihVtly
 Cm2npTVwkvYiIy5NT84mkEzd4IMWq95DWwrFeWXWNtWYO5LRuoyoCM+gO6BUOFnOtLcX
 0RoOz9xyFs1kpnAfgkcG0BAXHlv0UQusFOxSkBANKCgqPNUjOeYCAOqSKQNJzY9hSi8L
 qQQwKBmdNh1K7kyCaUo/CqwTQecW+GER4jsDsnTRxFlT22xicEzcGAKT1+IoQP2DxyH/
 IBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaxZtJ/Zz22f09eQWd/e/ljK+9HRxTBlYQ6KBcsfIVM=;
 b=Foz52bIDL1QAMHZV/w7OakdUBQCxF++aTIhMGugKrHsVzTfCGcjlCeKFgZBWHkvGWv
 jxAkP6AUDctyQ9/Ri7O3Xa278u1R1ZeUb3Tt124arcvgt8duS6fMgG8n0m7Hwjj3bTlY
 b1lXsinGgc4GocXwnZxU3xzj21d7+jc3ACpWym6t4bRC6fzW/2jdydx2jxHcAQNEKUg1
 Pi6yh+17UlCd0+yEmfmoGWI9ri3ag6v9GOC7Woqg09EDdPaYSmLrhs/3I1+F9PqUJ0cq
 CiYb3+k1Z3JvkhtQMwEFo+tIicf1oOE//4l4XfNUPtcar0GAXCLK2fruVdhGPlsAZlvV
 JU9g==
X-Gm-Message-State: ABy/qLZwpUBJgYbHpmbeMXJST99kJ7goxTk7G709178Y0cMUJYnHOtCy
 3BerAwDb9ssWZHtTzK3EcGrgZA==
X-Google-Smtp-Source: APBJJlEklTkayyd8SPRgJQnoxgTUT6u8i4dYJ584BiPuBA9zVlAeqUrq//ncDKciJZs+wi5yNT1msg==
X-Received: by 2002:adf:f5ca:0:b0:315:acbc:cab6 with SMTP id
 k10-20020adff5ca000000b00315acbccab6mr2659450wrp.16.1689349613803; 
 Fri, 14 Jul 2023 08:46:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/14] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
Date: Fri, 14 Jul 2023 16:46:40 +0100
Message-Id: <20230714154648.327466-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
instead.

Note that since arm_hcr_el2_eff() uses the return value from
arm_security_space_below_el3() for the 'space' argument, its
behaviour does not change even when at EL3 (Root security state) and
it continues to tell you what EL2 would be if you were in it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c |  7 ++++---
 target/arm/ptw.c    | 13 +++++--------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d6c0f95d59..3743a9e2f8a 100644
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
index d08c058e424..1e45fdb47c9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5731,11 +5731,12 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
  * Bits that are not included here:
  * RW       (read from SCR_EL3.RW as needed)
  */
-uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure)
+uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
 {
     uint64_t ret = env->cp15.hcr_el2;
 
-    if (!arm_is_el2_enabled_secstate(env, secure)) {
+    if (space == ARMSS_Root ||
+        !arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
         /*
          * "This register has no effect if EL2 is not enabled in the
          * current Security state".  This is ARMv8.4-SecEL2 speak for
@@ -5799,7 +5800,7 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     if (arm_feature(env, ARM_FEATURE_M)) {
         return 0;
     }
-    return arm_hcr_el2_eff_secstate(env, arm_is_secure_below_el3(env));
+    return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
 /*
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 63dd8e3cbe1..9e45160e1ba 100644
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
@@ -230,7 +230,7 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
         }
     }
 
-    hcr_el2 = arm_hcr_el2_eff_secstate(env, is_secure);
+    hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
 
     switch (mmu_idx) {
     case ARMMMUIdx_Stage2:
@@ -530,7 +530,6 @@ static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
 static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                              hwaddr addr, ARMMMUFaultInfo *fi)
 {
-    bool is_secure = ptw->in_secure;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     ARMMMUIdx s2_mmu_idx = ptw->in_ptw_idx;
     uint8_t pte_attrs;
@@ -587,7 +586,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_is_stage2(s2_mmu_idx)) {
-        uint64_t hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
 
         if ((hcr & HCR_PTW) && S2_attrs_are_device(hcr, pte_attrs)) {
             /*
@@ -3066,7 +3065,6 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                                    ARMMMUFaultInfo *fi)
 {
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_secure = arm_space_is_secure(ptw->in_space);
     uint8_t memattr = 0x00;    /* Device nGnRnE */
     uint8_t shareability = 0;  /* non-shareable */
     int r_el;
@@ -3112,7 +3110,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 
         /* Fill in cacheattr a-la AArch64.TranslateAddressS1Off. */
         if (r_el == 1) {
-            uint64_t hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+            uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
             if (hcr & HCR_DC) {
                 if (hcr & HCR_DCT) {
                     memattr = 0xf0;  /* Tagged, Normal, WB, RWA */
@@ -3149,7 +3147,6 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 {
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
-    bool is_secure = ptw->in_secure;
     ARMSecuritySpace in_space = ptw->in_space;
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
@@ -3212,7 +3209,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     }
 
     /* Combine the S1 and S2 cache attributes. */
-    hcr = arm_hcr_el2_eff_secstate(env, is_secure);
+    hcr = arm_hcr_el2_eff_secstate(env, in_space);
     if (hcr & HCR_DC) {
         /*
          * HCR.DC forces the first stage attributes to
-- 
2.34.1


