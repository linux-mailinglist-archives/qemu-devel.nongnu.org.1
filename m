Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A147D58AC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKNV-000291-W2; Tue, 24 Oct 2023 12:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNJ-000205-1K
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:25 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNB-0004NA-Sz
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:23 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c59a4dd14cso5566001fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698165316; x=1698770116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5WGh0voIbBHj+DcvsvmqoPjrnRTVY8rj8gNN9HFZqcE=;
 b=mi9u3QQnYDNQUTp4jQvIC3ZBhR3jJ4Uri3RpFVVP97cyYAL6gzzK3OAL68FtqBpDO3
 +KmOIsiEhTvPR1TqvhvOS14zfYFFueW1glHS0iw1ygPMR/auRZv3+9LW96mE3cei7DFX
 T+Gp6ufQkwQVU+N6JYMfDePpTTDX0rSQkUNlr9O6ToWnufGIDEaVnx4KhP6UXB6CO7LM
 jwog8Jy8PhkXsH00KOU17HcGelukzF5TvEjvVgwikQjBLxuSVyt9KBSZz9GvPMJAAmUX
 rZ/e2HhYY+sTvMlypK/tbAUh4alZ+ZZcAVqUbsgQ3cDotJq64//pGJWmsmerOaQ+lsIS
 ev1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165316; x=1698770116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WGh0voIbBHj+DcvsvmqoPjrnRTVY8rj8gNN9HFZqcE=;
 b=YRo+wNYm/J7mjxIxcc75jfxuJk799LInm2ZBQDLn9aAqIfxbx6cE6wRnsJX3MS1y3E
 wHx7zYoB0OviXR2rUNtQvk0zTAR/5HBzcYvrrSn5c/eFxx0eSXzMfG2Zat6vMgNBopTB
 jecrx8qB+PIjmodGhGghcAClVTU1CGTUCRtZBLaqaVawWmLLMBFyiPRzaizcY8Jz869T
 VaUR3yRmFYqp+5ndiT6AC+z2JHUgOKtF+ByxquREcg7VhPwhQfO7c3eAhgDlNB45swok
 cfoxQJQx+l3aDATJi4jxbQtO5NKKRPOO3O/PYrwNVCLC8lkagXuKxG7c6NVPGg96ih6Q
 TLCg==
X-Gm-Message-State: AOJu0Yx6Wx2PD6CM7TU7ryhjZ8jMZZ90MXeAYeEn3OtdkZvv+wVlShmU
 C+yTdMPU2Vji74Xx5TecYencEg==
X-Google-Smtp-Source: AGHT+IE4QM+QyuX7pDjVtv3GmuuT6MDlmtSs0GRZ3jC6lGu9VmUJn+OU7XbZl8aVV2S6XmkhVAuPxg==
X-Received: by 2002:a2e:9dd9:0:b0:2b9:412a:111d with SMTP id
 x25-20020a2e9dd9000000b002b9412a111dmr8826198ljj.42.1698165315998; 
 Tue, 24 Oct 2023 09:35:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm16860101wmh.11.2023.10.24.09.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:35:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/arm: Move ID_AA64PFR* tests together
Date: Tue, 24 Oct 2023 17:35:09 +0100
Message-Id: <20231024163510.2972081-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024163510.2972081-1-peter.maydell@linaro.org>
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

Move all the ID_AA64PFR* feature test functions together.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 86 +++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e73120ef974..0ed05b8b19e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -631,6 +631,49 @@ static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
 }
 
+static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
+}
+
+static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
+{
+    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
+    if (key >= 2) {
+        return true;      /* FEAT_CSV2_2 */
+    }
+    if (key == 1) {
+        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
+        return key >= 2;  /* FEAT_CSV2_1p2 */
+    }
+    return false;
+}
+
+static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
+}
+
+static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+}
+
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
+static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
@@ -791,26 +834,6 @@ static inline bool isar_feature_aa64_e0pd(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, E0PD) != 0;
 }
 
-static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
-}
-
-static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
-}
-
-static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
-}
-
-static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
-}
-
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
@@ -829,29 +852,6 @@ static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
-static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
-}
-
-static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
-{
-    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
-    if (key >= 2) {
-        return true;      /* FEAT_CSV2_2 */
-    }
-    if (key == 1) {
-        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
-        return key >= 2;  /* FEAT_CSV2_1p2 */
-    }
-    return false;
-}
-
-static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
-}
-
 static inline bool isar_feature_aa64_debugv8p2(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, DEBUGVER) >= 8;
-- 
2.34.1


