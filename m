Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADF816C42
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsC-0006lc-CA; Mon, 18 Dec 2023 06:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsA-0006gk-Kj
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs3-0003KE-Lx
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso34712685e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899194; x=1703503994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hBXQVeZsXBqhyEWf0FNTaJxd5EQkBYWOl8LzTg4GXs=;
 b=mxKhpxUq0DyA5vLHbcVBcOr7Mx2ukq/C4FbeyxjV67fxEwaEUNcllt5DOt4q7TOYkL
 M3WUlNmtFxYducNfaRo1BU8M/vdzCGFMQ0cama+Xv2vgHjDeY/vGZCUV43SmCOKhwqpZ
 truzJ6FadrhTDgWxBGa+hGXrc8tDbUScgStZEk9vvirKL8lXyB2Of2+kkdmrfXs+5bs4
 61VDeWtztfsWL82FzDLI3Mfy0YLrjDZ74NyZnDWZZ3VnviEc5NaKTTSfbxUlqnrI0sqm
 oyeWQUg39F/AstgTRc/8LbRSg+ZE5UfwC60QJ0+ItAMOETFbimO28uBnRyNObiUK0O4E
 c2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899194; x=1703503994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hBXQVeZsXBqhyEWf0FNTaJxd5EQkBYWOl8LzTg4GXs=;
 b=joBrTnlCwfy8ltqrmmBeGw00U9ZkyXfq2ozvtbc+WTn788G7JXlF2wJdGtbL3tuoBO
 njx86lXm4hk5VC6q3iyl3M4Xr40FncOAfYbvuwEJ8l7wjpDuVwuhnYlR6wIbqKS4J3Z8
 NwjkpFvcV4AXEHbsJyV5N+Rx3NHJCgKVwlOxPE9rnt+/taETp0XO9hW5yhoBuVqlNdsg
 6kpJp5YN4bU240OrvTCSdqofrV1qq/dbiDarEOJuXZ2dsuotMItKIiVc4WJzOV1R9QeP
 NgMsq8KZtLZZaKxKZ6qEP9XrDjlnQnnSDgyw1uC5gLBJEA946RJos6cZ81AqgPOM8CDa
 HahA==
X-Gm-Message-State: AOJu0YzO9B/CrWg4BXk1sN+bf3xftdGOEyfb5CN6BpmdZEeeEpxT31qo
 oAdrSq2NGOJZ3MSI20ZzdC2k+A==
X-Google-Smtp-Source: AGHT+IG+mG4BLRXb+h4IacHFNz5g/ChE1pd0R3ksKGGEHcVrbkex6MpdF6qKKXIKdBZTj5ao2d6vTg==
X-Received: by 2002:a7b:c84e:0:b0:40c:267e:3506 with SMTP id
 c14-20020a7bc84e000000b0040c267e3506mr8274324wml.130.1702899194215; 
 Mon, 18 Dec 2023 03:33:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/35] target/arm: Trap registers when HCR_EL2.{NV, NV1} == {1,
 1}
Date: Mon, 18 Dec 2023 11:32:46 +0000
Message-Id: <20231218113305.2511480-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

When HCR_EL2.{NV,NV1} is {1,1} we must trap five extra registers to
EL2: VBAR_EL1, ELR_EL1, SPSR_EL1, SCXTNUM_EL1 and TFSR_EL1.
Implement these traps.

This trap does not apply when FEAT_NV2 is implemented and enabled;
include the check that HCR_EL2.NV2 is 0 here, to save us having
to come back and add it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have mostly implemented FEAT_NV2 after FEAT_NV, but in
this particular case it seemed cleaner to include the NV2
bit check from the start.
---
 target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 220ee64df0d..3270fb11049 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5339,6 +5339,19 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -5687,12 +5700,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
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
@@ -7807,6 +7820,16 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
     }
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
 
 static CPAccessResult access_tfsr_el2(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
@@ -7852,7 +7875,7 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
     { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_mte,
+      .access = PL1_RW, .accessfn = access_tfsr_el1,
       .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
     { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 6, .opc2 = 0,
@@ -8004,6 +8027,18 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -8012,7 +8047,7 @@ static const ARMCPRegInfo scxtnum_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[0]) },
     { .name = "SCXTNUM_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 7,
-      .access = PL1_RW, .accessfn = access_scxtnum,
+      .access = PL1_RW, .accessfn = access_scxtnum_el1,
       .fgt = FGT_SCXTNUM_EL1,
       .fieldoffset = offsetof(CPUARMState, scxtnum_el[1]) },
     { .name = "SCXTNUM_EL2", .state = ARM_CP_STATE_AA64,
@@ -9394,6 +9429,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
               .access = PL1_RW, .writefn = vbar_write,
+              .accessfn = access_nv1,
               .fgt = FGT_VBAR_EL1,
               .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
                                      offsetof(CPUARMState, cp15.vbar_ns) },
-- 
2.34.1


