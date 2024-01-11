Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC582ACD9
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssd-0001S0-J2; Thu, 11 Jan 2024 06:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssC-0001Ny-9p
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss9-0004Rz-Sf
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e5f615a32so4439355e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971116; x=1705575916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hav1ye9+RT9H+505sGqV2d7rdaD4VVDbqLiiWOv4ZlA=;
 b=GCP0+sbLxysF6xQs8XHY8LwKIx+C0dCVuQ/7qKd1wWuZuhqGz0gNLNrCGaUVIcwbXD
 5aTSczvYLyHvGYGfGD1fsEOz0Q80VPEqZNLX1RW6qwopIgLewxFSbILyVRsKrJ1nC0Fs
 FBcY6+rP/+JNGGO6OtnJc0WA05Xx/jjINUuEiKLzOsBzK2xRvozO+D0OHPlrA9bmFb8D
 /UzNh4XeiRz3+IPSNzD6Y0h/Tu5qCRLLTXklzCZv8vA6lnSJnuax4twD21LddIRIz3i1
 9p3R36zRTZStA/TE6hRi0pgVO/cKBWLwpQQqZ4mi4J/P5633QXpfMqP6SXx+5RPTuup9
 46bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971116; x=1705575916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hav1ye9+RT9H+505sGqV2d7rdaD4VVDbqLiiWOv4ZlA=;
 b=sbtCkQ9S0GvDgLwOkJn0ftDbcEJ0VpvHhB3kEhbyI7rRgJiTx4H3uwqSNwVzfsao0C
 RBus1PLtaI+B7l/Do+vNUnoLzZ0/AsoETJ4Sb3m8yeDKnf9AYgm/JyR8FfcTVK8FzsdH
 H76T9yKnB0y4JchrO8YOCnTRCPMvhSj/Z7kT96aM1mRIJhrMmZsYTUQenyRXG7frxhzg
 PpgEs22bm6r/vj09Ih0mOYKYKY98wPYFXEKgqGzopFphcs5PelKy3zw6VBDRZtl4CNW/
 Qgps62FqtpYAv5ylt5sj17Eg35Zt1WOHf+0D9w3VdWxmtPXEgw9EJmsgVEM+mG9aAZkr
 FCRw==
X-Gm-Message-State: AOJu0YyG9smpha+NaBRVjVGeg3dmnQGk7ER8FX9Touv8c5fTfNY7xgKa
 4ihjGIss83v571Q4hRxrnQYifbuWSI0LZNabYa6ewLPWDwE=
X-Google-Smtp-Source: AGHT+IE0+vgsmyub1t2Xoiq11SmEUmFBVTMDzQfP2L0sUZV0N2lkm1auGMWiCkDDcTPHKg8ZhGkEuA==
X-Received: by 2002:a05:600c:a082:b0:40e:5f54:816a with SMTP id
 jh2-20020a05600ca08200b0040e5f54816amr166206wmb.16.1704971116194; 
 Thu, 11 Jan 2024 03:05:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] target/arm: Trap registers when HCR_EL2.{NV, NV1} == {1,
 1}
Date: Thu, 11 Jan 2024 11:04:46 +0000
Message-Id: <20240111110505.1563291-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

When HCR_EL2.{NV,NV1} is {1,1} we must trap five extra registers to
EL2: VBAR_EL1, ELR_EL1, SPSR_EL1, SCXTNUM_EL1 and TFSR_EL1.
Implement these traps.

This trap does not apply when FEAT_NV2 is implemented and enabled;
include the check that HCR_EL2.NV2 is 0 here, to save us having
to come back and add it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e48b03ba1d0..c8296a9c191 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5355,6 +5355,19 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        uint64_t hcr_nv = arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1 | HCR_NV2);
+
+        if (hcr_nv == (HCR_NV | HCR_NV1)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 #ifdef CONFIG_USER_ONLY
 /*
  * `IC IVAU` is handled to improve compatibility with JITs that dual-map their
@@ -5703,12 +5716,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL1_RW,
+      .access = PL1_RW, .accessfn = access_nv1,
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL1_RW,
+      .access = PL1_RW, .accessfn = access_nv1,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
      * We rely on the access checks not allowing the guest to write to the
@@ -7831,6 +7844,17 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_tfsr_el1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    CPAccessResult nv1 = access_nv1(env, ri, isread);
+
+    if (nv1 != CP_ACCESS_OK) {
+        return nv1;
+    }
+    return access_mte(env, ri, isread);
+}
+
 static CPAccessResult access_tfsr_el2(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
@@ -7875,7 +7899,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
     { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_mte,
+      .access = PL1_RW, .accessfn = access_tfsr_el1,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 6, .opc2 = 0,
@@ -8027,6 +8051,18 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_scxtnum_el1(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool isread)
+{
+    CPAccessResult nv1 = access_nv1(env, ri, isread);
+
+    if (nv1 != CP_ACCESS_OK) {
+        return nv1;
+    }
+    return access_scxtnum(env, ri, isread);
+}
+
 static const ARMCPRegInfo scxtnum_reginfo[] = {
     { .name = "SCXTNUM_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 13, .crm = 0, .opc2 = 7,
@@ -8035,7 +8071,7 @@ static const ARMCPRegInfo scxtnum_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[0]) },
     { .name = "SCXTNUM_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 7,
-      .access = PL1_RW, .accessfn = access_scxtnum,
+      .access = PL1_RW, .accessfn = access_scxtnum_el1,
       .fgt = FGT_SCXTNUM_EL1,
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[1]) },
     { .name = "SCXTNUM_EL2", .state = ARM_CP_STATE_AA64,
@@ -9417,6 +9453,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
               .access = PL1_RW, .writefn = vbar_write,
+              .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
-- 
2.34.1


