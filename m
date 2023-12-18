Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E5816C73
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsA-0006fY-DG; Mon, 18 Dec 2023 06:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs7-0006dT-Qa
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs1-0003Is-G0
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so1715022f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899192; x=1703503992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qPsvpxF310iFfemPS3jxwCbvqlyY2e5E1329lnZ8oYM=;
 b=FYMktptijT/TXko/8fLvNN8IXTcKvyTWob/dKk33oQxzBhygXPa3CQdMz1qaf9Bior
 UBHQD3UObSK6PvqLRKs5GmFIixulWm+yeTGHjPkJMY4ablb7YTaMfMHRtOB0J29oXYAC
 ebKxLdmEbXXjqEDpP2xJOwP3jTHMesXJGszZmCER7srzAhGX91jiZjW1rKC1TG29Nsti
 nK5Y3GcIwf7qSvtGbeKMJGJONhVioYJoui+icnIE/689+NTfizGBniJuMEfjxGP18dmx
 CGYRoym/tjwMd+4F/I2U8FIU/h6zRXqvj/1wUMgiPcINFPJlTDGATw0mAB6l2fODchfo
 bBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899192; x=1703503992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPsvpxF310iFfemPS3jxwCbvqlyY2e5E1329lnZ8oYM=;
 b=c/9Gzfk38E20O32lnUmlGdkeSuFeuNbK0md9mvWUGbLklXtzWqOcWL/5gKOJOSe5+5
 7aP7UBj7zPNZk/mAOf/2hKnr8vZBJmnkbnVr0OIUw0nIu7LkvvZ5ZFiyYGP4wptn9py+
 drHoLAdY50SMifaSYFzKluqtNPc+7DUlW6Tbh7qoPbFpdRWp8E7WbnulWTT4NkS4P2sv
 +gcOVfkbxVqjjnaIzZi8W7OO/Z+Iuvk6nKY0nV0bxc9Yt8YEESmRsANbx8W81joY/+Gr
 HhZ4tTaG8tV7giQIuuDcv+at52Pu+EchX0gQbbg5X/KfpEQsjq98gaV8KMYRMfsnstyK
 xHAQ==
X-Gm-Message-State: AOJu0Ywrx0CIvFOM+JuRQ6ER8vYEZcEyvLwo8aWskZyHfapKwRB/QSDG
 2PPzNIFjIJbXS0+WR5UD85MMdemqakGQoVtW77Q=
X-Google-Smtp-Source: AGHT+IF2EaRE3cAtjhV0mnqSrx1TkG5NCQ3j+DFdoWkwylqGnZ8v36Gkv7QEZN/EAKeTO/NSNmJGng==
X-Received: by 2002:a7b:c8d8:0:b0:40b:5e56:7b57 with SMTP id
 f24-20020a7bc8d8000000b0040b5e567b57mr8252810wml.160.1702899191903; 
 Mon, 18 Dec 2023 03:33:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/35] target/arm: Make EL2 cpreg accessfns safe for FEAT_NV
 EL1 accesses
Date: Mon, 18 Dec 2023 11:32:41 +0000
Message-Id: <20231218113305.2511480-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

FEAT_NV and FEAT_NV2 will allow EL1 to attempt to access cpregs that
only exist at EL2. This means we're going to want to run their
accessfns when the CPU is at EL1. In almost all cases, the behaviour
we want is "the accessfn returns OK if at EL1".

Mostly the accessfn already does the right thing; in a few cases we
need to explicitly check that the EL is not 1 before applying various
trap controls, or split out an accessfn used both for an _EL1 and an
_EL2 register into two so we can handle the FEAT_NV case correctly
for the _EL2 register.

There are two registers where we want the accessfn to trap for
a FEAT_NV EL1 access: VSTTBR_EL2 and VSTCR_EL2 should UNDEF
an access from NonSecure EL1, not trap to EL2 under FEAT_NV.
The way we have written sel2_access() already results in this
behaviour.

We can identify the registers we care about here because they
all have opc1 == 4 or 5.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 12 +++++++-
 target/arm/helper.c       | 65 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 83d2619080f..b39144d5b93 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -844,6 +844,16 @@ static CPAccessResult access_tda(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_dbgvcr32(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* MCDR_EL3.TDMA doesn't apply for FEAT_NV traps */
+    if (arm_current_el(env) == 2 && (env->cp15.mdcr_el3 & MDCR_TDA)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
 /*
  * Check for traps to Debug Comms Channel registers. If FEAT_FGT
  * is implemented then these are controlled by MDCR_EL2.TDCC for
@@ -1062,7 +1072,7 @@ static const ARMCPRegInfo debug_aa32_el1_reginfo[] = {
      */
     { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
-      .access = PL2_RW, .accessfn = access_tda,
+      .access = PL2_RW, .accessfn = access_dbgvcr32,
       .type = ARM_CP_NOP | ARM_CP_EL3_NO_EL2_KEEP },
 };
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e90eb5e16f3..44005665d12 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3308,6 +3308,11 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
 static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access */
+        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
+        return CP_ACCESS_OK;
+    }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
         return CP_ACCESS_TRAP;
     }
@@ -5998,7 +6003,7 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult access_hxen(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if (arm_current_el(env) < 3
+    if (arm_current_el(env) == 2
         && arm_feature(env, ARM_FEATURE_EL3)
         && !(env->cp15.scr_el3 & SCR_HXEN)) {
         return CP_ACCESS_TRAP_EL3;
@@ -6523,6 +6528,15 @@ static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
                                          const ARMCPRegInfo *ri,
                                          bool isread)
 {
+    if (arm_current_el(env) == 1) {
+        /*
+         * This must be a FEAT_NV access (will either trap or redirect
+         * to memory). None of the registers with _EL12 aliases want to
+         * apply their trap controls for this kind of access, so don't
+         * call the orig_accessfn or do the "UNDEF when E2H is 0" check.
+         */
+        return CP_ACCESS_OK;
+    }
     /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
         return CP_ACCESS_TRAP_UNCATEGORIZED;
@@ -6999,10 +7013,21 @@ static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_esm(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 bool isread)
+static CPAccessResult access_smprimap(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* If EL1 this is a FEAT_NV access and CPTR_EL3.ESM doesn't apply */
+    if (arm_current_el(env) == 2
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !FIELD_EX64(env->cp15.cptr_el[3], CPTR_EL3, ESM)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_smpri(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
 {
-    /* TODO: FEAT_FGT for SMPRI_EL1 but not SMPRIMAP_EL2 */
     if (arm_current_el(env) < 3
         && arm_feature(env, ARM_FEATURE_EL3)
         && !FIELD_EX64(env->cp15.cptr_el[3], CPTR_EL3, ESM)) {
@@ -7121,12 +7146,12 @@ static const ARMCPRegInfo sme_reginfo[] = {
      */
     { .name = "SMPRI_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 4,
-      .access = PL1_RW, .accessfn = access_esm,
+      .access = PL1_RW, .accessfn = access_smpri,
       .fgt = FGT_NSMPRI_EL1,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "SMPRIMAP_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 5,
-      .access = PL2_RW, .accessfn = access_esm,
+      .access = PL2_RW, .accessfn = access_smprimap,
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
@@ -7769,7 +7794,33 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     int el = arm_current_el(env);
+    if (el < 2 && arm_is_el2_enabled(env)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    if (el < 3 &&
+        arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ATA)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
 
+static CPAccessResult access_tfsr_el2(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /*
+     * TFSR_EL2: similar to generic access_mte(), but we need to
+     * account for FEAT_NV. At EL1 this must be a FEAT_NV access;
+     * we will trap to EL2 and the HCR/SCR traps do not apply.
+     */
+    int el = arm_current_el(env);
+
+    if (el == 1) {
+        return CP_ACCESS_OK;
+    }
     if (el < 2 && arm_is_el2_enabled(env)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
@@ -7805,7 +7856,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 6, .opc2 = 0,
-      .access = PL2_RW, .accessfn = access_mte,
+      .access = PL2_RW, .accessfn = access_tfsr_el2,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
     { .name = "TFSR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 6, .opc2 = 0,
-- 
2.34.1


