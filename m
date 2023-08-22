Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316577838C9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxd-0006Me-Jg; Tue, 22 Aug 2023 00:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxY-0006IH-VP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxU-0007WQ-Cf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a40d8557eso1297936b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678335; x=1693283135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toHkAvNUsxddzvlMZhAu54QiPCxJpyfW30OdoFF5T1c=;
 b=ingf3qaVb+xg81KpgXHZDvJ1QNhH4nNIYCp3QKi06MX6QHT0Fkp5Rzp7kPeVVuMby9
 iAl1B4EBogIm/Obi8M4tAtXWC2JZmf+7X+h39i6OzL3pfoE0LPYgjUo9VzmExXSmPsFm
 TxlFf1dMicn3MrQAJJ3nuhpZ+uj2aniZTZyCExHfv9MnSMyX5H5vE09xujDFiB72NjeG
 a8IF87FLYobPsSxcy6Q89beRPZzPlmEa1Uz6ZiKHtTMOC7Qrby5Bh0uGUDiD3DFPG+32
 Juja2byqj7mPqDHtWX9qIBIqBMxs27rivIcH200+jnpVuunUV8xsENffT8JDNmEa2LUH
 rrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678335; x=1693283135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toHkAvNUsxddzvlMZhAu54QiPCxJpyfW30OdoFF5T1c=;
 b=dnavxo4LESrL+R7os4KD8qNLphSW8IjvMVYefL7BkbTkqGHjtIhuu4gI8ZI5xkTse0
 viwnCxj2uqrSwC3siwBwrOetiJEqUlSaSDIWIUz8JVrhqKeaeyQe5wRaT34mYPdMEG9i
 Tap3qk/riRgr+cssQTFJzVl4zfhEW4u9zdDoorgZvMxtuH89J1BaRo5rhS9B8wAsKN9h
 G/Qzs4UQ1QpQ+nIMeCPJyfp0IKVFvZeHUjd1fIeYCC4GfA609C9vVEBI/ZcC5r7mIvld
 e0p9nZ6C7J64rOWFqJOVg51Mb8JJk5Vn9cdID11KbigWzSFmr73pON+v0Zs8M9dLRS9Q
 DUpQ==
X-Gm-Message-State: AOJu0YxO8m+7/e1L8ybm5QuoMe5rzBvzEJlbRIitTthJXKhKLx+7KDsF
 AvAnBp3DoTtMsRnitlVHq350qt3NF8iL8BetJRg=
X-Google-Smtp-Source: AGHT+IG4Prd1zong9vDelu7LmAEIqDKMZz+pbieGDxQndqnLdOyMwAa9z7IbSf2WK6L1iGwYLPDP7A==
X-Received: by 2002:a05:6a00:801a:b0:68a:4163:66f with SMTP id
 eg26-20020a056a00801a00b0068a4163066fmr8829415pfb.9.1692678334683; 
 Mon, 21 Aug 2023 21:25:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v4 3/9] target/arm: Add feature detection for FEAT_Pauth2 and
 extensions
Date: Mon, 21 Aug 2023 21:25:24 -0700
Message-Id: <20230822042530.1026751-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Rename isar_feature_aa64_pauth_arch to isar_feature_aa64_pauth_qarma5
to distinguish the other architectural algorithm qarma3.

Add ARMPauthFeature and isar_feature_pauth_feature to cover the
other pauth conditions.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Message-Id: <20230609172324.982888-3-aaron@os.amperecomputing.com>
[rth: Add ARMPauthFeature and eliminate most other predicates]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h              | 49 +++++++++++++++++++++++++++++------
 target/arm/tcg/pauth_helper.c |  2 +-
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fbdbf2df7f..e9fe268453 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3794,28 +3794,61 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+/*
+ * These are the values from APA/API/APA3.
+ *
+ * They must be compared '>=', except EPAC should use '=='.
+ * In the ARM pseudocode, EPAC is treated as not being implemented
+ * by larger values.
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
index 62af569341..6271a84ec9 100644
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


