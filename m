Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB4B26670
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 15:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXcH-0001Pg-CF; Thu, 14 Aug 2025 09:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcC-0001Ce-2g
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXc5-00052q-L0
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2ea79219so1116224b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176601; x=1755781401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufhXOkFFiQ9xg40jDZ1CMA8qL889kDviEVXXcrUgfT0=;
 b=BUyUOkOPLXTJ3rY5Z/f5iGEb42YeZWbwOncEfoYcbYBcI0P++30m1tW2KJvyH0Gxv8
 Z/qKmHJIUW6oXXVrKf/P64i7Rnhq0chpdD5pxwZ4Vq2Kt5CbLNW7s6qqFE/7+RtstJ+P
 0VG9Wv9b+ENEkCZ+iN5ha40yEglu5y9XOLF4ks1AlS0E6yzOGMryUvvFfVVbnCO/qVu7
 BoYKpdEE9nHKf2KsAHfIXJ0m+UnFojcgIM4j90cKrZ7zeboCLUyogpEDrY4oeFk7G3mF
 bZAiby0mqciWVknHzvq0DhsC9Co2PAAFCdNMTTnwP3R8O8PZdOkEg14eiHQZeigC3lr5
 fgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176601; x=1755781401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufhXOkFFiQ9xg40jDZ1CMA8qL889kDviEVXXcrUgfT0=;
 b=w1YExkvPaD+a95W3bueKOBRtcXJryHOLOQf5NJFbAGIncPBSgM6xs7fWBovQ8QROFl
 j9aAbEjnz+T1nh0zpD0Pio/aRdsGn9usH35dpOqOsfDuSBdqdYUqFDdsUINOtPW5USsO
 cCQPUMwSPxQzeAXBsk5Ext/ls4Ax/zDBDU1kj/kpFrshVvVkGF+aZaTLc59OZdZxPhER
 n+BAbNLxum4xp8I0rijr6X+jcjPld8iJbTT4joczH5yCLLyiNIcN1u7k1AUv3eYcDztI
 BeVUm+6Vcc0b84Hia3R2OkMZ8yHWbkkI0Q4vHJ6qwGRSUR1wGxPCCsZJCZNWeSRBq8Ls
 y/hw==
X-Gm-Message-State: AOJu0YzUkjB8DSyrbkf7wxZXXcID0EQTVFUnrHd+AecF9wf/DrXZL6Hf
 0GCuEz2ZVfsKzTj80rj1U5oZO6NlZWB07CjvzttKEge7Hr2JrAMsjGRuic3fFNpMRy+7dUnfij7
 voyG8LFg=
X-Gm-Gg: ASbGncuX/vvoje6zugnzOhLkCJ5wTy/AtAGSw6FYjCu2DjtJYvaeWcPXYRIgBXMcuWP
 /M0pkFBUaGq4kQ+jX99Wp0l+MTfd6b9SYytxtM76qhIZkHxbutbwGZvUp8GLI6RKMyag/eHNI8i
 LDrCwWRd+pDSmf/Q1qDJuWELRxADgn/NSl+XtgZZab7F6oU/jYbwlLBTrjOtFiX+DBA0IK8D1nn
 jfIQuuC5KDi3JUTJW2BbQZvGk0KijDoaC2ZZ44VkQ1lVQSpVbBao184ArOc+P11kj6EJjq3Go9h
 lqWK/7/c0mLBnQslPBRduryiQBI075y4rN1PBkrMW/kskLoD0GmmMO4zK6IUkJkhrHvp6ammK+Z
 4kQNEQQV1PrXWcQjFP7e410n3s4BS1QZOck7Tj/9COzi4U+s=
X-Google-Smtp-Source: AGHT+IFmDrAyz88bKgSQd69skwtjmu65pDol5AX9IISn7CYdR34qURYraJqH1MtuX1XvsnU1COb+qg==
X-Received: by 2002:a05:6a00:180e:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-76e2fdcf721mr3909277b3a.21.1755176600777; 
 Thu, 14 Aug 2025 06:03:20 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 41/85] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Thu, 14 Aug 2025 22:57:08 +1000
Message-ID: <20250814125752.164107-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 19 -------------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  7 ++++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c6f3ae470b..4f99ec69f8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1282,25 +1282,6 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
-/**
- * arm_mmu_idx_is_stage1_of_2:
- * @mmu_idx: The ARMMMUIdx to test
- *
- * Return true if @mmu_idx is a NOTLB mmu_idx that is the
- * first stage of a two stage regime.
- */
-static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
                                                const ARMISARegisters *id)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 3e51c0f579..55fba4aae2 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -18,6 +18,7 @@ FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
+FIELD(MMUIDXINFO, STAGE1, 9, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -76,4 +77,11 @@ static inline bool regime_is_user(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, USER);
 }
 
+/* Return true if this mmu index is stage 1 of a 2-stage translation. */
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 1c1e062bfe..c5b43a5932 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -13,6 +13,7 @@
 #define R2     R_MMUIDXINFO_2RANGES_MASK
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
+#define S1     R_MMUIDXINFO_STAGE1_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -35,9 +36,9 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
-    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
+    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | S1 | PAN,
 
     /*
      * M-profile.
-- 
2.43.0


