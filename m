Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC30B2663D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 15:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXa2-0004G3-UG; Thu, 14 Aug 2025 09:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYx-0002rR-6x
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:14 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYm-0004Ra-KC
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:08 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32326e7baa1so813574a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176393; x=1755781193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQ+8y37epe2XnhLdBmGfBFQy97VMfyMTxB36KkE7wvY=;
 b=Gewqvjx2sCEVcS6YFSUmgzO/tpoEjZ8FuPF9uGkWW1MgUgCalyf3ZQo2G2KHWNKuUt
 1yZzyNT4Tc2TTUTLsanEE+VoA1lz5ELc7L+tb6tkaRCsBWq5UzYL5ZyO3CZu9mHcfmzi
 UbcvsHaJWq5Ba8/9loSSMAiF1u9GIzoVDvJVlED2xBvVkNFhI+xko1KP/vS+lnXOprwt
 8hod3TF7v/gHR2vSh7kmeaHb3iZvDr6HFdjLR7Hl6g1uUr8qaiWlqelTusLEnHTKfsyJ
 MnDYffKowRxZJ4Gz8LmLztr9SYC9Uua1UUS353ACUtuKoZIhGFRl/hkM7f83BCHBrpKb
 zwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176393; x=1755781193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ+8y37epe2XnhLdBmGfBFQy97VMfyMTxB36KkE7wvY=;
 b=XA6bAIk0xUrRhXBkhZPKyzoVsO2TvtBrZ0UZKF4aRLXAqi/aScoNXRnmcild096FYu
 LbPpPwoPyeocVFY5g3pkgz9UUuF4rYiQuRiRjvkhAKqDarLQCdyI/bCABMrovLcz68jL
 OjROWErQKWBWZ1tq16fW2i/8OAEHlpm1t1IX3wPRhbtsqowafmSyG2fqzQ1rWp7sgKst
 ztx+GesdnSaVbqImzS/aXNhaXAbpmDwA/GiZyoc9W7tXJg/if8UVhrYNAcQBESUrxSdy
 Q6Uj25uuXEXcZ5zxtWa7Qosqq9olMi4dVWnNxa2qfYTcDPCzJ5QY8j/wCs+UP9j5CYVP
 66zQ==
X-Gm-Message-State: AOJu0YzM52LabBYcahbmtFg49Z9bYw93/AXNGBIF+6r/Zh84+pCkeZ4i
 a8f1kJUEKot3HXafAdEzRhIBiZCCGiTFqp4tUjfnwol4EJnEpWVwWHPFrKlXY1zp8NsqohA0U39
 eJ1ahc00=
X-Gm-Gg: ASbGncuTDay7r2jj2yNgTxLsPZjw3AkKQCuFIGSutzJaG5ls6/B9qJcx/XRTP9EreTC
 G35z32aOqHTwa6ZWdvjIdQ636Lbxmed0o2zIhV06Rg3zNyXtl6CEgm3J+P/6ZPNRLnT7IYrlsNI
 uMWGfK1L1IQDrse8rdYmrJ7kNKVXrIdj3PQtDCgnYX1l/3owK74T5t+LGVP1AZSkJ4RtFiFGcdW
 aqz6haJi1r2lfTlTPXyCjPmN2hZepdkDxiMRXQhCU6QI2sD3b9sIGET/Q7a2zUsGIMHjEcIEowb
 DdKa2i63MfvZB4T5o4uvrgIBwD+EylG2UJbuoUpqowd3+zpBXbQ06/4Qk37Z1EpnAOXWyoAR9x9
 Nbrc0XR4DypBToQpnuz3BX2DbXh69zFcH6Wr7Q1hRHU46aq8=
X-Google-Smtp-Source: AGHT+IE8V4EEeTq15gyskiIlRgJ+g7LmxSxMu1IcZUmz1XaZ0P0CgmCbvxtqbXRi/X74E+G0pm575Q==
X-Received: by 2002:a17:90b:3d92:b0:321:38a:dd17 with SMTP id
 98e67ed59e1d1-32327a62f91mr4812417a91.20.1755176392677; 
 Thu, 14 Aug 2025 05:59:52 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 34/85] target/arm: Remove unused env argument from regime_el
Date: Thu, 14 Aug 2025 22:57:01 +1000
Message-ID: <20250814125752.164107-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  8 ++++----
 target/arm/helper.c         |  2 +-
 target/arm/ptw.c            | 34 +++++++++++++++++-----------------
 target/arm/tcg/mte_helper.c |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2dc82330ec..4991d6ab7f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1076,7 +1076,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
 }
 
 /* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint32_t regime_el(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E20_0:
@@ -1130,7 +1130,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
+    return env->cp15.sctlr_el[regime_el(mmu_idx)];
 }
 
 /*
@@ -1162,13 +1162,13 @@ static inline uint64_t regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
         v |= env->cp15.vtcr_el2 & VTCR_SHARED_FIELD_MASK;
         return v;
     }
-    return env->cp15.tcr_el[regime_el(env, mmu_idx)];
+    return env->cp15.tcr_el[regime_el(mmu_idx)];
 }
 
 /* Return true if the translation regime is using LPAE format page tables */
 static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    int el = regime_el(env, mmu_idx);
+    int el = regime_el(mmu_idx);
     if (el == 2 || arm_el_is_aa64(env, el)) {
         return true;
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8985ad8c8a..78f670314d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9633,7 +9633,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
     bool stage2 = regime_is_stage2(mmu_idx);
-    int r_el = regime_el(env, mmu_idx);
+    int r_el = regime_el(mmu_idx);
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 820d5e65a0..30c83334b6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -232,9 +232,9 @@ static uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx, int ttbrn)
         return env->cp15.vsttbr_el2;
     }
     if (ttbrn == 0) {
-        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
+        return env->cp15.ttbr0_el[regime_el(mmu_idx)];
     } else {
-        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
+        return env->cp15.ttbr1_el[regime_el(mmu_idx)];
     }
 }
 
@@ -1023,7 +1023,7 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
     }
     type = (desc & 3);
     domain = (desc >> 5) & 0x0f;
-    if (regime_el(env, ptw->in_mmu_idx) == 1) {
+    if (regime_el(ptw->in_mmu_idx) == 1) {
         dacr = env->cp15.dacr_ns;
     } else {
         dacr = env->cp15.dacr_s;
@@ -1163,7 +1163,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         /* Page or Section.  */
         domain = (desc >> 5) & 0x0f;
     }
-    if (regime_el(env, mmu_idx) == 1) {
+    if (regime_el(mmu_idx) == 1) {
         dacr = env->cp15.dacr_ns;
     } else {
         dacr = env->cp15.dacr_s;
@@ -1454,7 +1454,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
             xn = pxn || (user_rw & PAGE_WRITE);
         }
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
-        switch (regime_el(env, mmu_idx)) {
+        switch (regime_el(mmu_idx)) {
         case 1:
         case 3:
             if (is_user) {
@@ -1510,7 +1510,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         /* F */ 0,             /* reserved */
     };
 
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     uint64_t pir = env->cp15.pir_el[el];
     uint64_t pire0 = 0;
     int perm;
@@ -1585,7 +1585,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     int select, tsz;
     bool epd, hpd;
 
@@ -1811,7 +1811,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
     int ap, prot;
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
@@ -2259,7 +2259,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+        mair = env->cp15.mair_el[regime_el(mmu_idx)];
         assert(attrindx <= 7);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
@@ -2737,7 +2737,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         return env->pmsav8.hprbar;
     } else {
         return env->pmsav8.rbar[secure];
@@ -2747,7 +2747,7 @@ static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
 static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         return env->pmsav8.hprlar;
     } else {
         return env->pmsav8.rlar[secure];
@@ -2779,7 +2779,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     uint32_t addr_page_limit = addr_page_base + (TARGET_PAGE_SIZE - 1);
     int region_counter;
 
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         region_counter = cpu->pmsav8r_hdregion;
     } else {
         region_counter = cpu->pmsav7_dregion;
@@ -2905,7 +2905,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
             xn = 1;
         }
 
-        if (regime_el(env, mmu_idx) == 2) {
+        if (regime_el(mmu_idx) == 2) {
             result->f.prot = simple_ap_to_rw_prot_is_user(ap,
                                             mmu_idx != ARMMMUIdx_E2);
         } else {
@@ -2914,7 +2914,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
         if (!arm_feature(env, ARM_FEATURE_M)) {
             uint8_t attrindx = extract32(matched_rlar, 1, 3);
-            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+            uint64_t mair = env->cp15.mair_el[regime_el(mmu_idx)];
             uint8_t sh = extract32(matched_rlar, 3, 2);
 
             if (regime_sctlr(env, mmu_idx) & SCTLR_WXN &&
@@ -2922,7 +2922,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 xn = 0x1;
             }
 
-            if ((regime_el(env, mmu_idx) == 1) &&
+            if ((regime_el(mmu_idx) == 1) &&
                 regime_sctlr(env, mmu_idx) & SCTLR_UWXN && ap == 0x1) {
                 pxn = 0x1;
             }
@@ -3407,7 +3407,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
         break;
 
     default:
-        r_el = regime_el(env, mmu_idx);
+        r_el = regime_el(mmu_idx);
         if (arm_el_is_aa64(env, r_el)) {
             int pamax = arm_pamax(env_archcpu(env));
             uint64_t tcr = env->cp15.tcr_el[r_el];
@@ -3659,7 +3659,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      */
     if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
-        if (regime_el(env, mmu_idx) == 3) {
+        if (regime_el(mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
         } else {
             address += env->cp15.fcseidr_ns;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0efc18a181..ed30026b7d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -604,7 +604,7 @@ void mte_check_fail(CPUARMState *env, uint32_t desc,
     int el, reg_el, tcf;
     uint64_t sctlr;
 
-    reg_el = regime_el(env, arm_mmu_idx);
+    reg_el = regime_el(arm_mmu_idx);
     sctlr = env->cp15.sctlr_el[reg_el];
 
     switch (arm_mmu_idx) {
-- 
2.43.0


