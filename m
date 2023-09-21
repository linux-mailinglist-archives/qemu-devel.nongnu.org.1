Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3857A9850
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcN-00020w-Fv; Thu, 21 Sep 2023 13:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcI-000205-5A
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcF-0007fE-VC
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40537481094so7505225e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317846; x=1695922646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t2XxQEkbUIbrufa38MGz1qprxVFgYcv2dQMKgqOxxd8=;
 b=z7E41OWO3CF+jBtukMu7ad00n6h6TgT4Ii/b2e8SEUSxjx0yavmrU/t1JkKR0+voMr
 bKfmH1k7qxn2jafQo2d01z9EzCfYgw7LJyLpjpcENyQj8OnCc7ViyrAYNVa0ncaCUmor
 voCDQIbHDkNPOdIpXNjAcP2UiH3RFneFXpNt0sMJ5MnmKuUSonWydplKqispUPfw5nVh
 BNBjis1FCAlaOGmMDg1fYN6k6aGFvWqy/M234KkXDo7ME9I7cQ4/IhuKDYD1t2p44Zxr
 qSzSKF85FF5OK95qVI2OYryU6pnLUylTuvxg+NtQbCE3EJS6OwEK+hnPQ3sCtye5QNPr
 P+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317846; x=1695922646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2XxQEkbUIbrufa38MGz1qprxVFgYcv2dQMKgqOxxd8=;
 b=xEoLC5gzlPwq/HhuuBeBkDPKNPk52kxVeD1ulnywG/UD2paEZyyYX5diap0HYaIr5i
 jnSlwywAB1VbFh4meWpS+J4LxwT7uZJEIccIUMd+NI+crOHUDyLLPriTBIU7nXiCAeBH
 vsih/0GNh1rgmvmE7WkZ8x0KUu6YIEQX2v+qgDaNy1CCBox/McVKl75NQl6/MHrc7Tjd
 ptQ18SAuy8x4FhMei8riQxni4XNVPXRmtZ7O8q2idF9YijA580TwdNk+c6J8uQr+7oLO
 4DISDji4fR/gu64rtFBHabKnOdahBn0avtv4XY/WpLFp4LvxPS7nkrikWN+D/qt2tSOv
 n0Iw==
X-Gm-Message-State: AOJu0YwBNZoXwj+YuZ/ea+kGUriq893kwNbcefN9sI7Wz0cBHqQq/wD4
 GMT4bwgv22H4vISRp7D37G1MX3T2bQbSu7oOYlw=
X-Google-Smtp-Source: AGHT+IFtAoMkTZdXBMPrY64CfepFNE4+9L+WsH00vQus69402khkhFsNJzqq4uPdnQFFdVCYz8aSIA==
X-Received: by 2002:a05:600c:3c93:b0:405:3455:d603 with SMTP id
 bg19-20020a05600c3c9300b004053455d603mr2217264wmb.17.1695317846503; 
 Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/30] target/arm: Implement FEAT_HBC
Date: Thu, 21 Sep 2023 18:36:59 +0100
Message-Id: <20230921173720.3250581-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

FEAT_HBC (Hinted conditional branches) provides a new instruction
BC.cond, which behaves exactly like the existing B.cond except
that it provides a hint to the branch predictor about the
likely behaviour of the branch.

Since QEMU does not implement branch prediction, we can treat
this identically to B.cond.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst  | 1 +
 target/arm/cpu.h               | 5 +++++
 target/arm/tcg/a64.decode      | 3 ++-
 linux-user/elfload.c           | 1 +
 target/arm/tcg/cpu64.c         | 4 ++++
 target/arm/tcg/translate-a64.c | 4 ++++
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3df936fc356..1fb6a2e8c3e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -42,6 +42,7 @@ the following architecture extensions:
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
+- FEAT_HBC (Hinted conditional branches)
 - FEAT_HCX (Support for the HCRX_EL2 register)
 - FEAT_HPDS (Hierarchical permission disables)
 - FEAT_HPDS2 (Translation table page-based hardware attributes)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7ba2402f727..bc7a69a8753 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -4088,6 +4088,11 @@ static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
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
index 7264ab5ead1..57abaea00cd 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1027,6 +1027,10 @@ void aarch64_max_tcg_initfn(Object *obj)
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
index 1b6fbb61e2b..1dd86edae13 100644
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


