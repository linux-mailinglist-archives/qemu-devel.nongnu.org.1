Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653C7D9C10
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO08-0007Cq-NW; Fri, 27 Oct 2023 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO07-0007CD-8b
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:51 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO05-00087D-Dt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:51 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507b9408c61so3024250e87.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417586; x=1699022386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a5UT81fbfzfhP+2DLCF06+YDd0SwIv4OzRvdR3APDic=;
 b=QGuVWTl/YoEmfdVRsG0nfJRLcIOoz1+VONurjgv6meXLHvFrq2fB9ocA/Ki2b0Sm0t
 Qqhb6QhCPob8YGGefbcNUb0FWhkaT4bJo5gc+6ykbvnrTGfp//PhClNu4K2V+/1M1K49
 25a6OO+a6ExR4UuW6xFDxqqlGrYwjSEPQYdy3Es+nqKfSm5SjMwY6YPeI1T0oLiyY8iV
 Do6quncjkTuMJ21dLK0VnSV+tEik64b1U8TD07MgSWD/q3ycUkKWgmTaNuX46pd7Y6MB
 Vcwn+7ZmEBLACKsXahxg4y9/DO/Wz5QOLF0J3JgMZy0bsYYby1pnq80uOsYcElSIDmNA
 fg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417586; x=1699022386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5UT81fbfzfhP+2DLCF06+YDd0SwIv4OzRvdR3APDic=;
 b=pSCgGIvy+u68LSCODY6RRVkmVtsogtbTwysTuMhUMcWbQHcUcmxlYML6f6uRBIhdQm
 W9YEqWvxV1EFtrrKa8aQuMcVDmsOcWY190Os+jVMmXhEL8I/OvIsCQ0hWnK6oDAdYcqy
 2Lw1WtgFulkxHuPEh0NzScu0A3Huf8IXEtBdus6bVshN4R1hU5hlI4bB8NPYZiaxgGP1
 nhFffdkl/fVUJQw2YvNOfXey4w4rlcnE8cH4AmcI/UsHm236O2IrW1nOpzPo20nO0/xT
 eZUTP1Ijyf90pObLcxp/RDAXrL17tfj40RVNsTuMVtWpp+dV/f92O1hJKlRqnmHTDcdl
 NmPA==
X-Gm-Message-State: AOJu0Ywi6d6I1Pthm3pyP3fxFlNPHZsR57/cLgFqQFRlMNzUpGff/r3f
 P5wjs1z4xYXOG9D4NUTVz3ZQX5gsS+N/2qCEFwY=
X-Google-Smtp-Source: AGHT+IGxGXPpqQj342fPIngAUedB+Rl0k5w5XgG8jjbHI4QSEFOPMu1YJ0gVGHElCIAuaKhTkhfhgw==
X-Received: by 2002:ac2:46d4:0:b0:508:1851:d29b with SMTP id
 p20-20020ac246d4000000b005081851d29bmr1959301lfo.17.1698417586521; 
 Fri, 27 Oct 2023 07:39:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] target/arm: Move ID_AA64MMFR0 tests up to before MMFR1
 and MMFR2
Date: Fri, 27 Oct 2023 15:39:06 +0100
Message-Id: <20231027143942.3413881-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

Move the ID_AA64MMFR0 feature test functions up so they are
before the ones for ID_AA64MMFR1 and ID_AA64MMFR2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024163510.2972081-4-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 120 +++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fc85a8fe130..90200a4b98f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -606,6 +606,66 @@ static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
 }
 
+static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
+}
+
+static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
+}
+
+static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
+}
+
+static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
+}
+
+static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
+}
+
+static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
+}
+
+static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
+}
+
+static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
+}
+
+static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
+}
+
+static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
+{
+    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
+    return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
+}
+
+static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
@@ -764,66 +824,6 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
 }
 
-static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
-}
-
-static inline bool isar_feature_aa64_tgran4_2_lpa2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
-    return t >= 3 || (t == 0 && isar_feature_aa64_tgran4_lpa2(id));
-}
-
-static inline bool isar_feature_aa64_tgran16_lpa2(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 2;
-}
-
-static inline bool isar_feature_aa64_tgran16_2_lpa2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
-    return t >= 3 || (t == 0 && isar_feature_aa64_tgran16_lpa2(id));
-}
-
-static inline bool isar_feature_aa64_tgran4(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 0;
-}
-
-static inline bool isar_feature_aa64_tgran16(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16) >= 1;
-}
-
-static inline bool isar_feature_aa64_tgran64(const ARMISARegisters *id)
-{
-    return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64) >= 0;
-}
-
-static inline bool isar_feature_aa64_tgran4_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran4(id));
-}
-
-static inline bool isar_feature_aa64_tgran16_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN16_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran16(id));
-}
-
-static inline bool isar_feature_aa64_tgran64_2(const ARMISARegisters *id)
-{
-    unsigned t = FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN64_2);
-    return t >= 2 || (t == 0 && isar_feature_aa64_tgran64(id));
-}
-
-static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
-{
-    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
-}
-
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
-- 
2.34.1


