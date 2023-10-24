Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F19F7D5895
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKNZ-0002Bo-Aq; Tue, 24 Oct 2023 12:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNJ-000207-2h
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNC-0004Mi-0g
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso34411565e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698165315; x=1698770115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9L3xRsVveSCMU9gTM2aMKdKV9IjkyK5EbO21w89IxGw=;
 b=TESFRAPlmnXahKVNZTRUZsOCSjPMK8fdm8LdQOOdUfDdBkHRfIklnpUSobdeh/pezB
 oCfio9a/TTZznzEatQF9ippTKnNZNcU/3WGoKTiJ6nbg5Ma33jmLRBYEQOGfsdnLZEBG
 jgeG5SHRzcGzPEOQSRR+hFrFnOdX3Pt3PwfbSERkLKaOtSiNi81kLtFsaSis9EgQm6cp
 dgTGr4dUZ2LgDMW2ijbf1rFzESyLEDuRnPCvvQC/olQgIzOOxUmQp1DuvFBGddAdEq2q
 7AElwIfy0xN9XOEdzcxLqPAAmABm916RoS51DQ5pSWoNoNNtIK8oMwn4nvS8tUHv0G5P
 2Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165315; x=1698770115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9L3xRsVveSCMU9gTM2aMKdKV9IjkyK5EbO21w89IxGw=;
 b=Zzpr3l04slA1Bn7r+IFGAxVXeNf5QMIuaL0v7b/1+9Skv7cNN8Jpkxlq6qh5VqZOdm
 BgFtT3gE/EHPHH+SXZzqw/16s3Sr0am7xhgcFSuqtV7tPyNKqFtqiBcObM9KAgYl9SyS
 8eNgXpC8YNvIZvnGiplsx8LJUAmROMglu3Voc+aSP1ezNfOVlxjDM0GiOBuCbIM7wt4V
 nG7UR7y7zqZCPuohc9KDxkklDK4BFYZjuIVYcm4NJg0yBxcmHgLO3tWUd55bejg3JCqJ
 PUCaTYfawtVogiuj1EBMLB+T8q7QMpmWYiC7xqOgYn9mhS6bCkm/fQqRB9wN5/IkWIse
 6TrQ==
X-Gm-Message-State: AOJu0YydlpRsvnWqnqgdgGVcHTrjXJB06+qf62CISiVDAuWHpB7lJsl+
 1vCXMnX4TG4GyCRza8snq8bPWX8dcLU/1Zrgy7E=
X-Google-Smtp-Source: AGHT+IFb8S5G1lgmHqKxXXjdqrMY6doHrWiC8P8sEcNrMvbS25kZ1GIs7mrgLrud8csgerbA1fdZ9w==
X-Received: by 2002:a05:600c:35c5:b0:405:4002:825a with SMTP id
 r5-20020a05600c35c500b004054002825amr10383205wmq.13.1698165315387; 
 Tue, 24 Oct 2023 09:35:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm16860101wmh.11.2023.10.24.09.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:35:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/arm: Move ID_AA64ISAR* test functions together
Date: Tue, 24 Oct 2023 17:35:08 +0100
Message-Id: <20231024163510.2972081-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024163510.2972081-1-peter.maydell@linaro.org>
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Move the feature test functions that test ID_AA64ISAR* fields
together.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 90200a4b98f..e73120ef974 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -451,6 +451,16 @@ static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
 }
 
+static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
+}
+
+static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
@@ -514,16 +524,6 @@ static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
 }
 
-static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
-}
-
-static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) != 0;
-}
-
 static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
@@ -554,6 +554,31 @@ static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
 }
 
+static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+}
+
+static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+}
+
+static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
+}
+
+static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+}
+
+static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
@@ -804,26 +829,6 @@ static inline bool isar_feature_aa64_pmuv3p5(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
-static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
-}
-
-static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
-}
-
-static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
-}
-
-static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
-}
-
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
@@ -922,11 +927,6 @@ static inline bool isar_feature_aa64_doublelock(const ARMISARegisters *id)
     return FIELD_SEX64(id->id_aa64dfr0, ID_AA64DFR0, DOUBLELOCK) >= 0;
 }
 
-static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
-}
-
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
-- 
2.34.1


