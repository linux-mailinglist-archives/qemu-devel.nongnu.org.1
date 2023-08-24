Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8079786C01
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eS-0006Kv-Cg; Thu, 24 Aug 2023 05:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047V-TP
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-0004zl-Co
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so4926415e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869326; x=1693474126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tytt/fOPhVvLsxVci+b5d34otV2ZT934LA/p/rF2PD4=;
 b=SAnowIkp6q6oNMSJiwohmrsk6N+kRdEeRWWe9eFNvUXnAYen901gQVwf3mOYcwlbd3
 jGhG6UIjBYu6Jvk6AIYA3bdunwA1K/fqvHO1k1QvcUhc0wO0OoMvWcqygH+daW3ve/8j
 fX1NabE4SyldsGucj1dh+wsrxtVLH27x9UpBa95UKKwrhtXw0L42QUzEOFly7JxTy3g7
 4HjObZ7Sn5c9y0Wjm0TFkaHy3qz/pZpmfjyVHLB+6WRwExQNsWSHYCH4lz+aoYlmSU0E
 SVdGLOwzNeVo331sj9HNy9P/TS84unfq7ZlLnsWW+T1qAgT73jxnj1DNroNBdaB0RxaV
 7mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869326; x=1693474126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tytt/fOPhVvLsxVci+b5d34otV2ZT934LA/p/rF2PD4=;
 b=iPwhMyLC4RrPqlZ3P6whvedX1UpKHoq1c7tRdb7z2lERmxWcDme0NN5f6cdalTIzM7
 pOmanhE0dnE/sVPaKLYrdX/X1ScBRD8NJYeNWLQCrAb7Bc+NZu0DN+V6NoG99qoAP7p9
 7xe0VJMiOU/YEGdX8HzzYRwseSr9FZbGCv+aJzPxiifciRkVkRHM/OBh41bZe6uVBaXb
 ChKKUb2L72rVZWrttjnTpfbH2TKftt72A1xd22VKhFY/8Pr3XQZA3XLJMa7geCVh2EyT
 znBMdSWET9Chae3fmcLWRAGrv2PxkiDmtCvykGWj3yHwjhaBlNjSqadHc4JbIOtPhly5
 +sDg==
X-Gm-Message-State: AOJu0Yww2xWLobA1YF1ZGfpW2x9cFe4aBsc7rEXWsfs6OVeEcfnhpBkU
 yhYpKABvybEzeSN4l44TbAh+FxCJN8WtoRnbzGI=
X-Google-Smtp-Source: AGHT+IEeyamXLhcgU49h3oNnNgjQVor5LmgWi/3tVQUxMEleztXVHYf96u5RNaaT/2QGjQj+scrdPA==
X-Received: by 2002:a5d:618c:0:b0:314:21b:1ea2 with SMTP id
 j12-20020a5d618c000000b00314021b1ea2mr11436301wru.39.1692869326443; 
 Thu, 24 Aug 2023 02:28:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/35] target/arm/ptw: Pass ARMSecurityState to
 regime_translation_disabled()
Date: Thu, 24 Aug 2023 10:28:18 +0100
Message-Id: <20230824092836.2239644-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Plumb the ARMSecurityState through to regime_translation_disabled()
rather than just a bool is_secure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-6-peter.maydell@linaro.org
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


