Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE77799BB
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsI-0003Br-M9; Fri, 11 Aug 2023 17:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00039J-UN
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00028d-CU
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686f090310dso2240371b3a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790038; x=1692394838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tau8pgXUMuYC3xEwEgLgNu8xbGRCSUW71FNo8qIPNck=;
 b=qQDlvhHCPP1lE8R36jdKhzhWTJ1ttE+av5hD2ZmlriJIlbopuy+sOR8cPIFJJ5cHpr
 0bOM/eVDbBDSQkxXt+d8WQo/19BIRWG7gsugxX6trCiMMGyTUlQSpHj/mTst9ybo2+XJ
 WPKKupsY8jRRsCSjD0wqDSM5JCr6P+UGoZVXqaPeyLh50+dNxCsvgVzMCudmGTZuGgKf
 vQYjpUqWde+ecwacHpjlk3JLhAt3NNBOYo04i5nQOzrZyNaKQkkHxbj2EasUJNf7dbgg
 aMQytYJx+IascmSeTdzakQmUe6yOp18/VzKI1pOVBwt1ofM3v2o5HVjCOezZCb3qeFTc
 HKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790038; x=1692394838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tau8pgXUMuYC3xEwEgLgNu8xbGRCSUW71FNo8qIPNck=;
 b=Wu4LDTIuSuUKDKgrwoxVWh5V6+d+UrAUuwOuRny7E0Btxb+3tvgcX0xqj2Ye4xKOKA
 Jh3a6/mqDtG+fgfBCDtQDdj2O7APBdX7KWKMmeflRG9re216vC1/Y7833OJ+PR5f6CEU
 JItn2xRvnHBzJqHoMtGrTPndP25eGiJ/WaJl+xeMOHUZhS1AYzEGVvoQlrdqLTlcgU+Z
 D+3o/3HUZYWbZQfPMRbcIGpkBx7mivUE25GqTJMZagFfu1HKMPZhrT4C6P9YwGZmjTYy
 VKcQM62Wy/gR+HmnWu+1CJRvRxteELGNmYk2mSBaaGa0BRUaLPthrFTdEAsrbjmlx8Xq
 PlIg==
X-Gm-Message-State: AOJu0YyOAe8jrApofUH8dbI9AqjGgk/4f6VqMyVhOVbjsAuoYjllZ8cs
 3D9uTyMQoqbadAydbrfTb5TwLJF32JTgK0WprUc=
X-Google-Smtp-Source: AGHT+IG+T2PX9i0EL2n0koAviOLB00rIKvo9vO9qCV9l2wbKS63iRlWBc+mMMcZv2DJGIjybQYUWYw==
X-Received: by 2002:a17:90b:90b:b0:261:685:95b6 with SMTP id
 bo11-20020a17090b090b00b00261068595b6mr2639117pjb.13.1691790038318; 
 Fri, 11 Aug 2023 14:40:38 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 06/11] target/arm: Apply access checks to neoverse-n1
 special registers
Date: Fri, 11 Aug 2023 14:40:26 -0700
Message-Id: <20230811214031.171020-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Access to many of the special registers is enabled or disabled
by ACTLR_EL[23], which we implement as constant 0, which means
that all writes outside EL3 should trap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h    |  2 ++
 target/arm/helper.c    |  4 ++--
 target/arm/tcg/cpu64.c | 46 +++++++++++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 14785686f6..f1293d16c0 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1077,4 +1077,6 @@ static inline void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu) { }
 void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu);
 #endif
 
+CPAccessResult access_tvm_trvm(CPUARMState *, const ARMCPRegInfo *, bool);
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f5effa30f7..ff3ea2abf8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -319,8 +319,8 @@ static CPAccessResult access_tpm(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 /* Check for traps from EL1 due to HCR_EL2.TVM and HCR_EL2.TRVM.  */
-static CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
-                                      bool isread)
+CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
+                               bool isread)
 {
     if (arm_current_el(env) == 1) {
         uint64_t trap = isread ? HCR_TRVM : HCR_TVM;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 00f39d42a8..bc3db798f0 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -463,10 +463,30 @@ static void aarch64_a64fx_initfn(Object *obj)
     /* TODO:  Add A64FX specific HPC extension registers */
 }
 
+static CPAccessResult access_actlr_w(CPUARMState *env, const ARMCPRegInfo *r,
+                                     bool read)
+{
+    if (!read) {
+        int el = arm_current_el(env);
+
+        /* Because ACTLR_EL2 is constant 0, writes below EL2 trap to EL2. */
+        if (el < 2 && arm_is_el2_enabled(env)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* Because ACTLR_EL3 is constant 0, writes below EL3 trap to EL3. */
+        if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo neoverse_n1_cp_reginfo[] = {
     { .name = "ATCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 7, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      /* Traps and enables are the same as for TCR_EL1. */
+      .accessfn = access_tvm_trvm, .fgt = FGT_TCR_EL1, },
     { .name = "ATCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 15, .crm = 7, .opc2 = 0,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
@@ -481,13 +501,16 @@ static const ARMCPRegInfo neoverse_n1_cp_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "CPUACTLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "CPUACTLR2_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 1,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "CPUACTLR3_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 2,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     /*
      * Report CPUCFR_EL1.SCU as 1, as we do not implement the DSU
      * (and in particular its system registers).
@@ -497,7 +520,8 @@ static const ARMCPRegInfo neoverse_n1_cp_reginfo[] = {
       .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 4 },
     { .name = "CPUECTLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 4,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0x961563010 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0x961563010,
+      .accessfn = access_actlr_w },
     { .name = "CPUPCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 1,
       .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
@@ -512,16 +536,20 @@ static const ARMCPRegInfo neoverse_n1_cp_reginfo[] = {
       .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "CPUPWRCTLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 7,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "ERXPFGCDN_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 2,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "ERXPFGCTL_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 1,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
     { .name = "ERXPFGF_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0,
+      .accessfn = access_actlr_w },
 };
 
 static void define_neoverse_n1_cp_reginfo(ARMCPU *cpu)
-- 
2.34.1


