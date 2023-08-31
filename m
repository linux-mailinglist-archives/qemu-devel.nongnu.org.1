Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3E78EADE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBG-0003ky-Sf; Thu, 31 Aug 2023 06:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB3-0003R9-Ri
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfAy-00042j-Ts
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so498152f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478723; x=1694083523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oe9Jt0sfVfKoVrUXZlvG7DRWxhpDGvcCVkIY29waBDc=;
 b=lvkkLzO+bvzdyed5o+nU44A1670hrKy98KmD13ANtsy/YuzPJFaIF/enadDatb411B
 86K8+93J6k3uSZMTk5Ki0fak1JMzqnGFm0ctNLONy7vQmBIT39Cl5X/nEFVhnUUYLNWC
 PSDv1TMUQ7eGzbJRgT33Ww4pTJrUWDYyyr+nDT7VUs0FG2nEoD8r3tbsta0jB6D7TCim
 tfCQDzGqqvzyop4uKQwb9Sqs48OtE6MwObijWB0zt2Qw0AknyH7KGzxQYyOefK6nKXo+
 gFDKIFZ6NKbVP/R4YhOFSWSrkPuf492/6Sjsuv7SDTqqIdvRUxfJT2FJ8mM37MFkQZMp
 mZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478723; x=1694083523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe9Jt0sfVfKoVrUXZlvG7DRWxhpDGvcCVkIY29waBDc=;
 b=gzrkhtxXRVKXew/HPZRe17/7eccYBb8Ij6HwBk3bnIEoUQna3sQDz/MyVRAKaYW6un
 yUcOOteVqokxq9MgEiMrL3LKV/ElbIAerebGufYVuB0lxm+ht60RpCTH1k4UYXen/4Dz
 BbbVAF2WFlWXO8ejngsuRxeRQtb6FCbi1pASpfcEjdhAKJnsLacMOmv7uDmvVy+UVW8v
 DVOL6uL6GhHlhLSHhXIobq8kNaED3rNKz7wsV0pB5o4k0m/E4CLxLcrOS1Qzbeim9Q2w
 i/kzUSlNFwsk43RZsBHUkh6L5A3LP1SHu8AoND0kCSLoeq+/hcA5Iv1vDNSQOQlGcDL5
 xwog==
X-Gm-Message-State: AOJu0YxG8efrjYDsIJ51CTJHCrw5ngbkeXLkOLBJUjhr3scfhtdnPqH/
 kK0+GaaFH7SK472xvcx5v8ohnz4xjqEMNuo4d8Y=
X-Google-Smtp-Source: AGHT+IHX9IOaIbu+WxonB/PHLajx2VfxX9wpj1m8WlBhqlK6EOjlUi2IX428u51cJUFiU7/TxeFQkA==
X-Received: by 2002:a5d:6b88:0:b0:319:6fff:f2c1 with SMTP id
 n8-20020a5d6b88000000b003196ffff2c1mr3736933wrx.38.1693478723010; 
 Thu, 31 Aug 2023 03:45:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] target/arm: Apply access checks to neoverse-n1 special
 registers
Date: Thu, 31 Aug 2023 11:45:01 +0100
Message-Id: <20230831104519.3520658-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Access to many of the special registers is enabled or disabled
by ACTLR_EL[23], which we implement as constant 0, which means
that all writes outside EL3 should trap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230811214031.171020-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h    |  2 ++
 target/arm/helper.c    |  4 ++--
 target/arm/tcg/cpu64.c | 46 +++++++++++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 14785686f64..f1293d16c07 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1077,4 +1077,6 @@ static inline void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu) { }
 void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu);
 #endif
 
+CPAccessResult access_tvm_trvm(CPUARMState *, const ARMCPRegInfo *, bool);
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4dfc51de351..e3f5a7d2bdc 100644
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
index 00f39d42a8c..bc3db798f09 100644
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


