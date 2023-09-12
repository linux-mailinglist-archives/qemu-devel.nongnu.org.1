Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0B79D344
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:08:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg412-0008PZ-KL; Tue, 12 Sep 2023 10:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40a-000870-8C
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40N-0003pk-On
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so66395555e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527477; x=1695132277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RHcf7tHzqDKzr5rxsbuc/JHbMcICd4o46jDSREKWJM4=;
 b=OkoAMpduUyO5ez4VZyIW+3/ckECAaaOFWRGkXsPrd56QXettAf33tedNo0Rn9gbETa
 XDaCSq3DvIVaHEOM4WFnIWeixNEZLEC/F+EP/nxOF+q+A+uhfN2jMSfl9zE0/giqMh5Y
 XU2OYzPXL2N4+9NJnA4YnOTlSCH4uAtobEN36wob1RFVxuR7KxbLomQkTX7BLVyx4bZ6
 CM7CKqIjysv3cyKUZuMujW57GEgCZ7xxsGEmNs2dDRIX6WzDTs5zGM8vk57+SO2ZeV59
 WLskhjCmYYd9zjUDX5DnV6LO6CznRM5ft/aAzgEACI6U9CZF6hngCY0ou0vKQMGyoV+D
 YieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527477; x=1695132277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHcf7tHzqDKzr5rxsbuc/JHbMcICd4o46jDSREKWJM4=;
 b=e9MZtRCC1rks3bHMhjKKx0g/itZ+QkyavfOsa32EH/v2+xPymxdEbZAAFAfyOmUdu0
 VcZJBtaC6cQEBC1FOK84kYLUNjESipO52j4VtdySIQRlhnwqxMR9oYb5pCTv4kALzOGW
 W0SR3pvChZN1VnBFfQxAG9ZdZDrG6076mS/rgFUxOIFWKdcc1gfZFPgXkVqAQoaa5w9w
 44Xjv1eAF7ZAMDhXu3h1X6/H2+usdPZPqdO7X1UgljUKC1rX/rqtlJxi5eV6bAMpRBI3
 5MJcTUX95H0Wbv68KuPLyDr/OZIxg7nCltAy9mgJVCEMYJyDGi6ttgHp3CNo1+GFkMqV
 M1sg==
X-Gm-Message-State: AOJu0YxbGqOzizvsuqmPe9EDL/MXM9qyGo6uyubx/hZOT/9OqP7MwvOE
 UZaxenjYxS7k4dU0dIcA3IXa8UkUGGuQKPxJey4=
X-Google-Smtp-Source: AGHT+IHuktr3DXPrSPhOjbbBlCwgK1dkFDg/duQWSPDQdXAPJbXXMbqWXBsm8mJVp1ZLXg69yD8zZA==
X-Received: by 2002:adf:ea4b:0:b0:31d:da10:e47e with SMTP id
 j11-20020adfea4b000000b0031dda10e47emr11333879wrn.57.1694527476927; 
 Tue, 12 Sep 2023 07:04:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] target/arm: Implement FEAT_MOPS enable bits
Date: Tue, 12 Sep 2023 15:04:24 +0100
Message-Id: <20230912140434.1333369-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

FEAT_MOPS defines a handful of new enable bits:
 * HCRX_EL2.MSCEn, SCTLR_EL1.MSCEn, SCTLR_EL2.MSCen:
   define whether the new insns should UNDEF or not
 * HCRX_EL2.MCE2: defines whether memops exceptions from
   EL1 should be taken to EL1 or EL2

Since we don't sanitise what bits can be written for the SCTLR
registers, we only need to handle the new bits in HCRX_EL2, and
define SCTLR_MSCEN for the new SCTLR bit value.

The precedence of "HCRX bits acts as 0 if SCR_EL3.HXEn is 0" versus
"bit acts as 1 if EL2 disabled" is not clear from the register
definition text, but it is clear in the CheckMOPSEnabled()
pseudocode(), so we follow that.  We'll have to check whether other
bits we need to implement in future follow the same logic or not.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 28 +++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc7a69a8753..266c1a9ea1b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1315,6 +1315,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
 #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
+#define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
@@ -4281,6 +4282,11 @@ static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
     return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
 }
 
+static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 594985d7c8c..83620787b45 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5980,7 +5980,10 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t valid_mask = 0;
 
-    /* No features adding bits to HCRX are implemented. */
+    /* FEAT_MOPS adds MSCEn and MCE2 */
+    if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
+        valid_mask |= HCRX_MSCEN | HCRX_MCE2;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -6009,13 +6012,24 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
 {
     /*
      * The bits in this register behave as 0 for all purposes other than
-     * direct reads of the register if:
-     *   - EL2 is not enabled in the current security state,
-     *   - SCR_EL3.HXEn is 0.
+     * direct reads of the register if SCR_EL3.HXEn is 0.
+     * If EL2 is not enabled in the current security state, then the
+     * bit may behave as if 0, or as if 1, depending on the bit.
+     * For the moment, we treat the EL2-disabled case as taking
+     * priority over the HXEn-disabled case. This is true for the only
+     * bit for a feature which we implement where the answer is different
+     * for the two cases (MSCEn for FEAT_MOPS).
+     * This may need to be revisited for future bits.
      */
-    if (!arm_is_el2_enabled(env)
-        || (arm_feature(env, ARM_FEATURE_EL3)
-            && !(env->cp15.scr_el3 & SCR_HXEN))) {
+    if (!arm_is_el2_enabled(env)) {
+        uint64_t hcrx = 0;
+        if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
+            /* MSCEn behaves as 1 if EL2 is not enabled */
+            hcrx |= HCRX_MSCEN;
+        }
+        return hcrx;
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
         return 0;
     }
     return env->cp15.hcrx_el2;
-- 
2.34.1


