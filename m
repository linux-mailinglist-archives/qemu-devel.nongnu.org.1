Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6E79763A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU1-0000rC-90; Thu, 07 Sep 2023 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTz-0000q2-N3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTu-0001zs-H1
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31ae6bf91a9so1068450f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102624; x=1694707424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7BS/rY/c60JsPKvSpLBQ5UvGiBW6XDQ0AnN4C2kj1HA=;
 b=Toemc/B7GPOs34eXnM9No05/Wb80jCsBy50rCBRj03fF4DlPFUUZeWt89xmnzOimHr
 swPr9dk+aUjQNfjtlNjmX+Ooy+zrW/R+i5LI1hl+mSdJ7hZWAiHpvtNH77O3fiiPW0qY
 25EJBjc9va6Z71MHSfgVqFLvCm73aieXbUOAv8ZhF8bcsJ1N5ZjvdmuG6812AY+l4NO6
 Mot5F3rJWIsnF5okFi7ZKL6gyH2YVHHDQoJSqwg9XirsRJI5DSk5TWfY75MSZf33XsfK
 Dwbq/gmatRekx5mlVLMDTzxqlNH7GJzLRVwDtMUasK+lBgO0ZiR4QY73waiAyPLkYmvr
 UOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102624; x=1694707424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BS/rY/c60JsPKvSpLBQ5UvGiBW6XDQ0AnN4C2kj1HA=;
 b=QHHRXQSWZxZFjFT+srra3HkBgS8tBorjUHAgKT+YDecotBtwFjOje9gTuq/qq0x6Qm
 WPizu3AWXTFEj/xrY/NkKwKogIZyz5DLQPW8KRc7fpBoOkEFrkyWYdt7o5MPLY49Syjy
 WcD2LNJR1EldTeTIBOJheLWvWVDQPvrMD62ymk7JpN5MjUpCUuKnZ+8yWW1Zv1W8KTzh
 r6h+wbONRG4CDiHRKojxuM59uHT9/mKY0GK/1xG8UBfp8ugi6HFKz9hjm9gOzt+QdIlK
 /U2r92XOgMPW6QK8ZMGivyfdPlBPtFGLzzFBWHAMg5/gx0VP5gtGnYVYoniO7Yex9XiK
 eFFQ==
X-Gm-Message-State: AOJu0YxgiIW4OSHAlTDVB15JDML1Km2hv+1gW7xxbmcJPANnzWsFd8ZB
 2eyHn0uZkL6bD1bWAZgwN8dnDpOyltF0AILZVt4=
X-Google-Smtp-Source: AGHT+IHcvQyZL61w5SaXf3jDTdvFWiR42dn/MJjShCP19lscbAupU6nBBI8bKZ6k/0WX3jTYo4cbOA==
X-Received: by 2002:adf:f30a:0:b0:31d:cf59:8d8 with SMTP id
 i10-20020adff30a000000b0031dcf5908d8mr4980131wro.14.1694102624605; 
 Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/14] target/arm: Implement FEAT_MOPS enable bits
Date: Thu,  7 Sep 2023 17:03:30 +0100
Message-Id: <20230907160340.260094-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 28 +++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9b76cc68c6d..7d2e1a1cfe8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1314,6 +1314,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
 #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
+#define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
@@ -4224,6 +4225,11 @@ static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
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
index f9f7c3c39e9..c751fbfead5 100644
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


