Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DF7D9C0D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0w-00011s-Ca; Fri, 27 Oct 2023 10:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0I-0007LO-75
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:02 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO05-00087E-K5
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:01 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507d7b73b74so2984318e87.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417587; x=1699022387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CzSla6VJ+VFu9HZ2dJfSZCPn1N3Rp6Fy7bChRtXFBsk=;
 b=YvHMXFis3UNUnat+djRYUdPBQBaXhPfzR4XqjFCYqbksO1KAoVfDbUEJkJOOMtZ3UJ
 xRKqfPKbj0C0MV2JwUGg5Sp3FUPXyimgkw3zvEysnYCBNfzGBy5JiQ7Wstm6FSNobJU8
 Vz/63U2IvFLolvhK4AH/fMU4DkT/xxQTwzMXhu0VWXm90nRaB1HynLlggPk9zJH/6Dut
 P287r7Ytpflw9M2FAcMDd3EljW65w9z85TzXwZoOBxu/jFQULfxH4F0J1PvzDz9fR3a9
 kDMiJT2tJHWKaAjqS/xNmNZp2ag1UaRgWR0itbUkRKsdcUlHvYpxSd3gwYfUpALubW4/
 NotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417587; x=1699022387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzSla6VJ+VFu9HZ2dJfSZCPn1N3Rp6Fy7bChRtXFBsk=;
 b=jxZ84FQ0t9F6bJUtSAuiFqkKjo6ILf/EoLr4vGJiY+ajw2eMbRg4nbsltj3cO4YDbl
 tgSwnI2mqGHax3XnfxpysFsCi/d/bx7pUiiAk+iny3VLPk3YroNNRjdnErXnWB3OtCxk
 h2MVwhGlZGEcs/GZPY0HF7zyGTZrGbFpjhWnxqFOCLRCNQ7E1yZbSt8vQ0tl/jz9JnmS
 L2+OvNT6KxjkgzTig54gYf8kVkiynbonRtts9YIpTnjbEdjBVmaiQD9Kfj5tjC9zVqkV
 QiIETR3OoV9X08bHnmfs2L2Yj3IP7AKRE++bQa/g61jsI9KJPKVn7zF2EnynMZcvpOlk
 sBQQ==
X-Gm-Message-State: AOJu0Yx0id+GzRIOZtkv9J1SvPSd+02p2nOdwSC3QT5teoXDO6zrKbHC
 gQvHAoJvQGDELztFltt0JclSzx/JCRWkz7Vn2kA=
X-Google-Smtp-Source: AGHT+IHNC6UR9dU69DfxNG9eP33ZwLJyn3bQJQf9ZHv++Wz/f5zKQBP8RMczCFzFHFYiaxT5chzvkw==
X-Received: by 2002:ac2:5e6c:0:b0:503:905:c5a3 with SMTP id
 a12-20020ac25e6c000000b005030905c5a3mr1779341lfr.35.1698417587466; 
 Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] target/arm: Move ID_AA64PFR* tests together
Date: Fri, 27 Oct 2023 15:39:08 +0100
Message-Id: <20231027143942.3413881-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-6-peter.maydell@linaro.org
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


