Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1579A86A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMV-0005qJ-Up; Mon, 11 Sep 2023 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMU-0005pU-GO
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMJ-0003Am-Ts
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso1047326f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440426; x=1695045226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1SPaLFJICW9q9gqa6qvPwlUkb8XaROQF8dYUvvHc24Q=;
 b=XvgKZ50R8Dbc3FCeJtRahF+ujCToUeWldnj/USmBXiW4NOsH6Nwor2OO95xjHll+hi
 YrUaijJSzaIbIagjDVXj3MrJdfvGxxQeCuCjZb1VTYvxqgEBjxyn/9XKXi724OuI3mY2
 pufSNFviwK01r+UWVT7DBq6Oq726gHb/hncvlFv25mTGJkFNVilXpLwYkPEgVScLjHju
 lrkxQVNYJCmk1Q4K8LDwqe1tWkuq3LP6+jG/Nf8wahLACRWvH0J9Kcby7jsW5Z+j84zj
 1xe/95lGeEW3UftyI5Wkze5tqF9kEuaO+NUOzoOjlgSEXDFOWwW2bzdxq7NVHSpQSZd1
 ndqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440426; x=1695045226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SPaLFJICW9q9gqa6qvPwlUkb8XaROQF8dYUvvHc24Q=;
 b=PXGLPJmEfNKmROmbsMfkVOOB88uhjvNr/sepA1G5ExVYNww30OqdMyoI+/N+2V/BvG
 0kUtIMUV4xUeBNCizCR0bc2FmDMIephgERY5cjbaIzl52x0AIY4iqWoFAL+Zv70+Sxh/
 W5f5P6028JvkcQ0EPEqdiy7mXDZkMPK9drSy1aBrOH544VUHz6h7JGFDLYU+6eKprUjG
 c5nhCuGXWznzidHn4X+1yVGYOQSyDioG3SeIAndWfhQyc8zLhx8ahLLIDkGFIBpWDhm6
 lc6Ffx+Lj5ErTcHMJkW/hxXZypXWJs0WHuwRwCz8CbSso/smgV0yhktfqGZo9l3r1D5o
 NvWQ==
X-Gm-Message-State: AOJu0Yw1TfQWIU8eXPdskDP14RL5xSQuJoLDZL9WTmUxeRONSUoBlfNw
 4ER9AYzzhhaF+FifoifbXsoO/MFfgC5fZyv+QAc=
X-Google-Smtp-Source: AGHT+IH4iUR6QG0LLQ5pPYm11Xtvmh2D7E8OvHkKSnSCUlsFauob0y93CkVzXiP3kcWVLnYm9cQsAA==
X-Received: by 2002:a5d:5744:0:b0:31a:e972:3601 with SMTP id
 q4-20020a5d5744000000b0031ae9723601mr8458561wrw.54.1694440426494; 
 Mon, 11 Sep 2023 06:53:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/arm: Implement FEAT_HBC
Date: Mon, 11 Sep 2023 14:53:40 +0100
Message-Id: <20230911135340.1139553-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

FEAT_HBC (Hinted conditional branches) provides a new instruction
BC.cond, which behaves exactly like the existing B.cond except
that it provides a hint to the branch predictor about the
likely behaviour of the branch.

Since QEMU does not implement branch prediction, we can treat
this identically to B.cond.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  | 1 +
 target/arm/cpu.h               | 5 +++++
 target/arm/tcg/a64.decode      | 3 ++-
 linux-user/elfload.c           | 1 +
 target/arm/tcg/cpu64.c         | 4 ++++
 target/arm/tcg/translate-a64.c | 4 ++++
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2e6a7c8961e..34429054a3f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -39,6 +39,7 @@ the following architecture extensions:
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
+- FEAT_HBC (Hinted conditional branches)
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
 - FEAT_HPDS2 (Translation table page-based hardware attributes)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eddf2d3b72c..fc45f1fb9e2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -4050,6 +4050,11 @@ static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
 }
 
+static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ef64a3f9cba..71113173020 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -126,7 +126,8 @@ CBZ             sf:1 011010 nz:1 ................... rt:5 &cbz imm=%imm19
 
 TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=%imm31_19
 
-B_cond          0101010 0 ................... 0 cond:4 imm=%imm19
+# B.cond and BC.cond
+B_cond          0101010 0 ................... c:1 cond:4 imm=%imm19
 
 BR              1101011 0000 11111 000000 rn:5 00000 &r
 BLR             1101011 0001 11111 000000 rn:5 00000 &r
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bbb4f08109c..203a2b790d5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -815,6 +815,7 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_f64f64, ARM_HWCAP2_A64_SME_F64F64);
     GET_FEATURE_ID(aa64_sme_i16i64, ARM_HWCAP2_A64_SME_I16I64);
     GET_FEATURE_ID(aa64_sme_fa64, ARM_HWCAP2_A64_SME_FA64);
+    GET_FEATURE_ID(aa64_hbc, ARM_HWCAP2_A64_HBC);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0f8972950d6..90e033bbc3a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -814,6 +814,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     cpu->isar.id_aa64isar1 = t;
 
+    t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    cpu->isar.id_aa64isar2 = t;
+
     t = cpu->isar.id_aa64pfr0;
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b77c92437f..15eca55fc75 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1453,6 +1453,10 @@ static bool trans_TBZ(DisasContext *s, arg_tbz *a)
 
 static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
 {
+    /* BC.cond is only present with FEAT_HBC */
+    if (a->c && !dc_isar_feature(aa64_hbc, s)) {
+        return false;
+    }
     reset_btype(s);
     if (a->cond < 0x0e) {
         /* genuinely conditional branches */
-- 
2.34.1


