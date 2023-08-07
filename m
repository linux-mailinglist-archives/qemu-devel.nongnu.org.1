Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9D77276A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT11q-0000fS-7z; Mon, 07 Aug 2023 10:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-00008u-Qy
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10y-0005SB-Nb
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so39301195e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417719; x=1692022519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NbiccwBAU2xAl/qEFIXdbuxGrXw7jKmkAECaPM8LQRA=;
 b=PStWaomuWsgH8MrHlhPDKhV+hpru9KiwIS76TimVXzFilDUGdT6CCaJg9W8e0ffrGY
 p+PXZyYeaLFdirJqGXJ4LiytIUUTFbKVE2FNjLg2NXukFVamseuHgfSnKeV6jvouFT6l
 lSPXMwi37D29/IRACJmrzdkwNwYGpf00YdSYcC5IuhSgvLJXc82vU8DrYmHb0TQD4En3
 FHZrOyfwarxipyCJUWHB0fEz2palTn9IQSapBmmD+hiB/2XZc6F4s/aE+62kyfS6Shbp
 fh8zAzC2CAuYpkEpaOQMCHq2YJIZr9gXGjToyQS1tERVYpCUv8J6K6XY6EDAcS6ptfIT
 YjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417719; x=1692022519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbiccwBAU2xAl/qEFIXdbuxGrXw7jKmkAECaPM8LQRA=;
 b=D6ULVbauDqw+FkTieQfEcSoGfSgMFA4Mo+pDKFU2Fpj2/UAxjFjM9BqWYVyKi+Nl3i
 dFI8miwM17CALc0J3h4gTk5jSlzSRvEnEpvzhZOmvnvPt3NPp8GWIScIg8W93C3Q2KbB
 heQn5aYSZxOyZKq0lGpegIv2lPvkORjtJOD18KNAyW6e8WPrDhghak8MIG7r6p3gFMzk
 ddkZB7uF8VqsCDBBj+5DMIlYd89Xz7To0pnLRpUaC5v218OUOgJBm2vxfnvra6RM95SI
 nEtQynHX3ywBS50xsPWARrv79YyZ5v8czd2aHZ7cKQaZtEnuS4U2I2vY7uWWXFngrt8+
 GfhA==
X-Gm-Message-State: AOJu0Yw7kTQw91y9FNay3tW8kJQ6O26POPqeONQ/BPT1kf5Yn8YsJt9+
 UiMsEzZSUixEjM89/qKluuKSD5JLIHHvftfvUbA=
X-Google-Smtp-Source: AGHT+IF8rGgQ8+SEvCpD3mNXWz2r9nioOWObTKCGkOQhvgqfXuGQtqPSRmVFUx6W2B67tRFJwxZZPw==
X-Received: by 2002:a05:600c:221a:b0:3fc:9e:eead with SMTP id
 z26-20020a05600c221a00b003fc009eeeadmr6401525wml.20.1691417719289; 
 Mon, 07 Aug 2023 07:15:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/15] target/arm/ptw: Pass ARMSecurityState to
 regime_translation_disabled()
Date: Mon,  7 Aug 2023 15:15:04 +0100
Message-Id: <20230807141514.19075-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Plumb the ARMSecurityState through to regime_translation_disabled()
rather than just a bool is_secure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a873fbe0239..63dd8e3cbe1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -206,9 +206,10 @@ static uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx, int ttbrn)
 
 /* Return true if the specified stage of address translation is disabled */
 static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
-                                        bool is_secure)
+                                        ARMSecuritySpace space)
 {
     uint64_t hcr_el2;
+    bool is_secure = arm_space_is_secure(space);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         switch (env->v7m.mpu_ctrl[is_secure] &
@@ -2057,9 +2058,8 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(env, mmu_idx);
-    bool is_secure = arm_space_is_secure(ptw->in_space);
 
-    if (regime_translation_disabled(env, mmu_idx, is_secure)) {
+    if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
         result->f.phys_addr = address;
         result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -2231,7 +2231,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     result->f.lg_page_size = TARGET_PAGE_BITS;
     result->f.prot = 0;
 
-    if (regime_translation_disabled(env, mmu_idx, secure) ||
+    if (regime_translation_disabled(env, mmu_idx, ptw->in_space) ||
         m_is_ppb_region(env, address)) {
         /*
          * MPU disabled or M profile PPB access: use default memory map.
@@ -2475,7 +2475,8 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * are done in arm_v7m_load_vector(), which always does a direct
      * read using address_space_ldl(), rather than going via this function.
      */
-    if (regime_translation_disabled(env, mmu_idx, secure)) { /* MPU disabled */
+    if (regime_translation_disabled(env, mmu_idx, arm_secure_to_space(secure))) {
+        /* MPU disabled */
         hit = true;
     } else if (m_is_ppb_region(env, address)) {
         hit = true;
@@ -3303,7 +3304,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
          */
         ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
         if (arm_feature(env, ARM_FEATURE_EL2) &&
-            !regime_translation_disabled(env, ARMMMUIdx_Stage2, is_secure)) {
+            !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
             return get_phys_addr_twostage(env, ptw, address, access_type,
                                           result, fi);
         }
@@ -3362,7 +3363,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
     /* Definitely a real MMU, not an MPU */
 
-    if (regime_translation_disabled(env, mmu_idx, is_secure)) {
+    if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         return get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
     }
-- 
2.34.1


