Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49B798B3C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:08:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevv-0004zU-43; Fri, 08 Sep 2023 13:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevr-0004yR-Qp
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00016I-JZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso26760665e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192762; x=1694797562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWwlHVNJnT8eB6OUZXjTfW+sqmWiIf2OOHeWWjYot8w=;
 b=b5BJhefr7jZxb/CG1vOPDJ3Pu+VCiypkDZ6LFJJl3cH5JyXoFG284U824F3lQ4nrWp
 Ug2HEHnjt/1c6En+3SUuiBOYIeO40vipLfr5dDPqswYY8GZGaiqKM8GW7W2E6dYRNzrx
 C7IKpco0AYFlwJxjY/np1xluQXq7iwv46bjv9k3vyt3DJTokdHx3Ygtx9Z1zby+Bwj/m
 C0UqzqH+sThpl/02lDQVlDhGtgIvtY5xlAURHiw+CDuBBHfvLDecNsGCO1/K5JcxGfLl
 CvdSVNNSyNQoVH6AaxcFGMTx7Nkh74LBQ1YYn0VtSF1/HsmqDbqvDgmLWokNvi9Etu31
 5AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192762; x=1694797562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWwlHVNJnT8eB6OUZXjTfW+sqmWiIf2OOHeWWjYot8w=;
 b=E2SYW8faGxBWWeetPx9Jw0tkzzBheqGDdhkqBnAmca4XZtuDCUs70Dey3vYysCx5V+
 8hfba49yWzGYxjt76daeONyL0duBa0Utq27zop0w2pOzCMzAhXF8q7FLTVUKoj/yG622
 UUUZEJUMjse/3AEaXX5hCV4STeOVIts2Iewp8CLFr+vaUdeGVmUWf+ffmoe7uDKYSAcQ
 odq48GPNZu6YHiwzjaSn5Juf3tw7QY2q0y8E+NkoJvRuE3hy59NnnUG7RR9KRc2qMxYb
 u5vdOJErVmKeOGF1k6ntfj1AhxN5KDaLzxYVmpZljpnD/c8BZ9JBZZSh+Qu3Wy4fDqST
 iYvA==
X-Gm-Message-State: AOJu0YwoontlL/pGxfv53ezkM+VL+esQ7s+hvDdW18o5NEZd0lKNqiBj
 V1pjWhhgecegwGHGFwuw8pc/oPCoMRIhVQu20ko=
X-Google-Smtp-Source: AGHT+IHoIqEMCANdrFQCBuplX0V/t/Unhaogqj5MzBOngtGxKFnk+1muTPsRw7xGjfL82eV4lwfT+w==
X-Received: by 2002:a05:600c:b58:b0:3fb:4055:1ddd with SMTP id
 k24-20020a05600c0b5800b003fb40551dddmr2535245wmr.28.1694192762052; 
 Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] target/arm: Add feature detection for FEAT_Pauth2 and
 extensions
Date: Fri,  8 Sep 2023 18:05:34 +0100
Message-Id: <20230908170557.773048-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Rename isar_feature_aa64_pauth_arch to isar_feature_aa64_pauth_qarma5
to distinguish the other architectural algorithm qarma3.

Add ARMPauthFeature and isar_feature_pauth_feature to cover the
other pauth conditions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-4-richard.henderson@linaro.org
Message-Id: <20230609172324.982888-3-aaron@os.amperecomputing.com>
[rth: Add ARMPauthFeature and eliminate most other predicates]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h              | 47 +++++++++++++++++++++++++++++------
 target/arm/tcg/pauth_helper.c |  2 +-
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9b76cc68c6d..225a9b5af54 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3804,28 +3804,59 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+/*
+ * These are the values from APA/API/APA3.
+ * In general these must be compared '>=', per the normal Arm ARM
+ * treatment of fields in ID registers.
+ */
+typedef enum {
+    PauthFeat_None         = 0,
+    PauthFeat_1            = 1,
+    PauthFeat_EPAC         = 2,
+    PauthFeat_2            = 3,
+    PauthFeat_FPAC         = 4,
+    PauthFeat_FPACCOMBINED = 5,
+} ARMPauthFeature;
+
+static inline ARMPauthFeature
+isar_feature_pauth_feature(const ARMISARegisters *id)
+{
+    /*
+     * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
+     * and the other two must be zero.  Thus we may avoid conditionals.
+     */
+    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
+            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
+            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
+}
+
 static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
 {
     /*
      * Return true if any form of pauth is enabled, as this
      * predicate controls migration of the 128-bit keys.
      */
-    return (id->id_aa64isar1 &
-            (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, API, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, GPA, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
+    return isar_feature_pauth_feature(id) != PauthFeat_None;
 }
 
-static inline bool isar_feature_aa64_pauth_arch(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
 {
     /*
-     * Return true if pauth is enabled with the architected QARMA algorithm.
-     * QEMU will always set APA+GPA to the same value.
+     * Return true if pauth is enabled with the architected QARMA5 algorithm.
+     * QEMU will always enable or disable both APA and GPA.
      */
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
 }
 
+static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
+{
+    /*
+     * Return true if pauth is enabled with the architected QARMA3 algorithm.
+     * QEMU will always enable or disable both APA3 and GPA3.
+     */
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+}
+
 static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 62af5693419..6271a84ec9b 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -282,7 +282,7 @@ static uint64_t pauth_computepac_impdef(uint64_t data, uint64_t modifier,
 static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
                                  uint64_t modifier, ARMPACKey key)
 {
-    if (cpu_isar_feature(aa64_pauth_arch, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_pauth_qarma5, env_archcpu(env))) {
         return pauth_computepac_architected(data, modifier, key);
     } else {
         return pauth_computepac_impdef(data, modifier, key);
-- 
2.34.1


