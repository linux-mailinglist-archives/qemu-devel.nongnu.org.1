Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FF786C0A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ep-0007rS-Si; Thu, 24 Aug 2023 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047Y-UX
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e2-0004yz-TJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso5754397f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869326; x=1693474126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wK9zE1Lifmm6/8IKHW10U8rTZ3FDJYtigwQOzAGgaWs=;
 b=WFqUOLsNCUUg6/arHsbf3t+zbnPOGovnegH8BywZTwQrcGHH1Rp4yUVln1GYo4YCcT
 UUOpltTBDExWj6bV4Qgk0+2wE6axXLQONIbJsLOF3Q7p5GJjwVaLpLMm5dK6o1A2JIvr
 pZkumAbQjXA+1m7QpMVbBj+NgtjC5jEfdC5LLpowSKdM9CxpYuGAlKmisGW8qibwhKTt
 qk0VGzl3bEZ/vlKcUo6PEgA3QrCysFLa74YDJqFuDTYOQxFHAJscT4nUD1tw7LVLnYeR
 mAi5LRyMWCsEHaL/MwE4l2FAfW86xGzegqvuFCNp4iOd9i6X7iYUhecQhGzkybSzr9tM
 CuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869326; x=1693474126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wK9zE1Lifmm6/8IKHW10U8rTZ3FDJYtigwQOzAGgaWs=;
 b=luYy8EsXDW0Di3Em7T0sPFWGVhS0ZPAQ5AEktMDPC6gwHed9duVKUl3X8GO94XjNVy
 oR5P7G1ZNqCxqoLXpqjz5qkzFwMSm5SHLPUerIInCbBSbNf/rFI+r49eQLrpbEK5V8LW
 IFlwh37/g5qPV9WVw6nfE35JJe1oujsi3EDFi+gKi+mx9u5psKS0lvHB3hzd7EKv2M+S
 ufz3HbI5eGthAnJVUNf7BG6J1katmaCuyhd790X431fZZMqi/DsZFw2S64umNLkwdN2h
 IfWx0T3xJCeH/atokEtHcLk6cKGf+gMR6m4BVk/+4LV5K4MXbfQGuln71vnF3S5UYziw
 eG+g==
X-Gm-Message-State: AOJu0YwyVIKR/5jZAlQai8gcT7Mci8QmvYg3faZGDWwQfDyz7gS1q2jK
 dvA0hO+K7dGjD2J7+JxOhWd4IaBdvvm71ROMnKo=
X-Google-Smtp-Source: AGHT+IHj+FXn+IDHX0HvWVLTBvfSIameyCs9wmxRrS/nsZcu3SP7bq6DGLFu3tAn76tapz591eBCmA==
X-Received: by 2002:a5d:6409:0:b0:319:70b3:d51a with SMTP id
 z9-20020a5d6409000000b0031970b3d51amr11246232wru.7.1692869325886; 
 Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/35] target/arm/ptw: Pass ptw into get_phys_addr_pmsa*() and
 get_phys_addr_disabled()
Date: Thu, 24 Aug 2023 10:28:17 +0100
Message-Id: <20230824092836.2239644-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In commit 6d2654ffacea813916176 we created the S1Translate struct and
used it to plumb through various arguments that we were previously
passing one-at-a-time to get_phys_addr_v5(), get_phys_addr_v6(), and
get_phys_addr_lpae().  Extend that pattern to get_phys_addr_pmsav5(),
get_phys_addr_pmsav7(), get_phys_addr_pmsav8() and
get_phys_addr_disabled(), so that all the get_phys_addr_* functions
we call from get_phys_addr_nogpc() take the S1Translate struct rather
than the mmu_idx and is_secure bool.

(This refactoring is a prelude to having the called functions look
at ptw->is_space rather than using an is_secure boolean.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-5-peter.maydell@linaro.org
---
 target/arm/ptw.c | 57 ++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 67078ae3509..a873fbe0239 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2045,15 +2045,19 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     return true;
 }
 
-static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
-                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 bool is_secure, GetPhysAddrResult *result,
+static bool get_phys_addr_pmsav5(CPUARMState *env,
+                                 S1Translate *ptw,
+                                 uint32_t address,
+                                 MMUAccessType access_type,
+                                 GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
     int n;
     uint32_t mask;
     uint32_t base;
+    ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(env, mmu_idx);
+    bool is_secure = arm_space_is_secure(ptw->in_space);
 
     if (regime_translation_disabled(env, mmu_idx, is_secure)) {
         /* MPU disabled.  */
@@ -2210,14 +2214,18 @@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     return regime_sctlr(env, mmu_idx) & SCTLR_BR;
 }
 
-static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
-                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 bool secure, GetPhysAddrResult *result,
+static bool get_phys_addr_pmsav7(CPUARMState *env,
+                                 S1Translate *ptw,
+                                 uint32_t address,
+                                 MMUAccessType access_type,
+                                 GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
     int n;
+    ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     bool is_user = regime_is_user(env, mmu_idx);
+    bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
     result->f.lg_page_size = TARGET_PAGE_BITS;
@@ -2736,12 +2744,16 @@ void v8m_security_lookup(CPUARMState *env, uint32_t address,
     }
 }
 
-static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
-                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 bool secure, GetPhysAddrResult *result,
+static bool get_phys_addr_pmsav8(CPUARMState *env,
+                                 S1Translate *ptw,
+                                 uint32_t address,
+                                 MMUAccessType access_type,
+                                 GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
     V8M_SAttributes sattrs = {};
+    ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
+    bool secure = arm_space_is_secure(ptw->in_space);
     bool ret;
 
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
@@ -3045,12 +3057,15 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
  * MMU disabled.  S1 addresses within aa64 translation regimes are
  * still checked for bounds -- see AArch64.S1DisabledOutput().
  */
-static bool get_phys_addr_disabled(CPUARMState *env, target_ulong address,
+static bool get_phys_addr_disabled(CPUARMState *env,
+                                   S1Translate *ptw,
+                                   target_ulong address,
                                    MMUAccessType access_type,
-                                   ARMMMUIdx mmu_idx, bool is_secure,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
 {
+    ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
+    bool is_secure = arm_space_is_secure(ptw->in_space);
     uint8_t memattr = 0x00;    /* Device nGnRnE */
     uint8_t shareability = 0;  /* non-shareable */
     int r_el;
@@ -3252,8 +3267,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return get_phys_addr_disabled(env, address, access_type, mmu_idx,
-                                      is_secure, result, fi);
+        return get_phys_addr_disabled(env, ptw, address, access_type,
+                                      result, fi);
 
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
@@ -3321,16 +3336,16 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = get_phys_addr_pmsav8(env, address, access_type, mmu_idx,
-                                       is_secure, result, fi);
+            ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
+                                       result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-            ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
-                                       is_secure, result, fi);
+            ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
+                                       result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
-                                       is_secure, result, fi);
+            ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
+                                       result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
@@ -3348,8 +3363,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, is_secure)) {
-        return get_phys_addr_disabled(env, address, access_type, mmu_idx,
-                                      is_secure, result, fi);
+        return get_phys_addr_disabled(env, ptw, address, access_type,
+                                      result, fi);
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-- 
2.34.1


