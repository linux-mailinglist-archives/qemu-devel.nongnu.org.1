Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A273B7BC
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxI-0002DP-G7; Fri, 23 Jun 2023 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0001WL-4p
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx1-0000g1-I0
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa7eb35a13so2868865e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523502; x=1690115502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nx4skIHE69mR8fFMxVkedaz6uu5onab2yXbL5Okcli8=;
 b=ZGOI2dPOYIYoAKrFttCBXotQU3b6G05R+Scez0cteVPZmhPnc90o23qUMNSYbAmnjJ
 sxfT9Tp+EpyJsDdC4qhXj8Q4yhqnxY4NJ+PBUYrMwY3JtCHClZCpQ3YRv8imrlCzGMfl
 YT0ETz1QtF3Tst8+mA+gHWN0EGT7/rLP4dMgkw9D1z1EWPCJX6cBbeoQRiWgychqpeUi
 vKEoBgVzCE+yCDgBBvyZPaAQCJhnkT23JkTcmn16NgcY6cMiftPdDC5fL4pWiKBI5PBu
 3ZWYN0seXmlwT3xXgADcFIxy75f+iNNhGDE1gGzVRjG6LDZk3XqFnjzMORUWcPaotjK+
 SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523502; x=1690115502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nx4skIHE69mR8fFMxVkedaz6uu5onab2yXbL5Okcli8=;
 b=Z4U17qiarwaWLfdOTNCJyVvbQIssEsKppS9ymZTVJHQL+qGaY17w90fDCduKAW15Dh
 CuNeioFrCjsv/y4KtzC/sZojtPQDisng+VNVhFhHzHbOARnOYeq0co3YOmR2vNAjMq/x
 D+yURP5ma/XRHMdH4pHH1YAHEcfwgo4TMOP/d2p7US9kCxS4GJJEQiAr0QOD7fS2Jmj8
 KDJRUdNdfNqclZLaQmRPti6KzKR3WypAQCotHaSXMamYAoC8i27D1r76PeL+irM9dR3U
 h2gJoTiELu5hMNgX2ZvtLr+5mlnZWLKEJPgioqOdvYOgOVWy2Rne3+h0+bfHgU59zycI
 8f6g==
X-Gm-Message-State: AC+VfDzdaCd8IXwvuTUmtNpZI8oXUbNkbOhJAGsV7b9/Ft/rauC1O2Yx
 6V2hrqnXxhhMZU+FgJjtlGdyFT7JYoXmbK6o5Ts=
X-Google-Smtp-Source: ACHHUZ7QlwegFgefoLM2g11qw0A6Yhe5zrNKhMOCZ7MOhBPy/WDnIByQiZWIarSGp5F2xDJQjovGuQ==
X-Received: by 2002:a7b:cc0c:0:b0:3f8:fb7c:6793 with SMTP id
 f12-20020a7bcc0c000000b003f8fb7c6793mr13604510wmh.24.1687523502224; 
 Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] target/arm: Pipe ARMSecuritySpace through ptw.c
Date: Fri, 23 Jun 2023 13:31:19 +0100
Message-Id: <20230623123135.1788191-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Add input and output space members to S1Translate.  Set and adjust
them in S1_ptw_translate, and the various points at which we drop
secure state.  Initialize the space in get_phys_addr; for now leave
get_phys_addr_with_secure considering only secure vs non-secure spaces.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 86 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f7cbb984f93..e1e7c9a3d22 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -21,11 +21,13 @@
 typedef struct S1Translate {
     ARMMMUIdx in_mmu_idx;
     ARMMMUIdx in_ptw_idx;
+    ARMSecuritySpace in_space;
     bool in_secure;
     bool in_debug;
     bool out_secure;
     bool out_rw;
     bool out_be;
+    ARMSecuritySpace out_space;
     hwaddr out_virt;
     hwaddr out_phys;
     void *out_host;
@@ -249,6 +251,7 @@ static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
 static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                              hwaddr addr, ARMMMUFaultInfo *fi)
 {
+    ARMSecuritySpace space = ptw->in_space;
     bool is_secure = ptw->in_secure;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
     ARMMMUIdx s2_mmu_idx = ptw->in_ptw_idx;
@@ -266,6 +269,9 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                 .in_mmu_idx = s2_mmu_idx,
                 .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
                 .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
+                .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
+                             : space == ARMSS_Realm ? ARMSS_Realm
+                             : ARMSS_NonSecure),
                 .in_debug = true,
             };
             GetPhysAddrResult s2 = { };
@@ -277,11 +283,15 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             ptw->out_phys = s2.f.phys_addr;
             pte_attrs = s2.cacheattrs.attrs;
             ptw->out_secure = s2.f.attrs.secure;
+            ptw->out_space = s2.f.attrs.space;
         } else {
             /* Regime is physical. */
             ptw->out_phys = addr;
             pte_attrs = 0;
             ptw->out_secure = s2_mmu_idx == ARMMMUIdx_Phys_S;
+            ptw->out_space = (s2_mmu_idx == ARMMMUIdx_Phys_S ? ARMSS_Secure
+                              : space == ARMSS_Realm ? ARMSS_Realm
+                              : ARMSS_NonSecure);
         }
         ptw->out_host = NULL;
         ptw->out_rw = false;
@@ -303,6 +313,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         ptw->out_rw = full->prot & PAGE_WRITE;
         pte_attrs = full->pte_attrs;
         ptw->out_secure = full->attrs.secure;
+        ptw->out_space = full->attrs.space;
 #else
         g_assert_not_reached();
 #endif
@@ -355,7 +366,10 @@ static uint32_t arm_ldl_ptw(CPUARMState *env, S1Translate *ptw,
         }
     } else {
         /* Page tables are in MMIO. */
-        MemTxAttrs attrs = { .secure = ptw->out_secure };
+        MemTxAttrs attrs = {
+            .secure = ptw->out_secure,
+            .space = ptw->out_space,
+        };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
 
@@ -398,7 +412,10 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
 #endif
     } else {
         /* Page tables are in MMIO. */
-        MemTxAttrs attrs = { .secure = ptw->out_secure };
+        MemTxAttrs attrs = {
+            .secure = ptw->out_secure,
+            .space = ptw->out_space,
+        };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
 
@@ -909,6 +926,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
          * regime, because the attribute will already be non-secure.
          */
         result->f.attrs.secure = false;
+        result->f.attrs.space = ARMSS_NonSecure;
     }
     result->f.phys_addr = phys_addr;
     return false;
@@ -1616,6 +1634,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          * regime, because the attribute will already be non-secure.
          */
         result->f.attrs.secure = false;
+        result->f.attrs.space = ARMSS_NonSecure;
     }
 
     if (regime_is_stage2(mmu_idx)) {
@@ -2400,6 +2419,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
              */
             if (sattrs.ns) {
                 result->f.attrs.secure = false;
+                result->f.attrs.space = ARMSS_NonSecure;
             } else if (!secure) {
                 /*
                  * NS access to S memory must fault.
@@ -2750,6 +2770,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     bool is_secure = ptw->in_secure;
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
+    ARMSecuritySpace ipa_space;
     bool is_el0;
     uint64_t hcr;
 
@@ -2762,10 +2783,12 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
     ipa = result->f.phys_addr;
     ipa_secure = result->f.attrs.secure;
+    ipa_space = result->f.attrs.space;
 
     is_el0 = ptw->in_mmu_idx == ARMMMUIdx_Stage1_E0;
     ptw->in_mmu_idx = ipa_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
     ptw->in_secure = ipa_secure;
+    ptw->in_space = ipa_space;
     ptw->in_ptw_idx = ptw_idx_for_stage_2(env, ptw->in_mmu_idx);
 
     /*
@@ -2854,11 +2877,12 @@ static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
     ARMMMUIdx s1_mmu_idx;
 
     /*
-     * The page table entries may downgrade secure to non-secure, but
-     * cannot upgrade an non-secure translation regime's attributes
-     * to secure.
+     * The page table entries may downgrade Secure to NonSecure, but
+     * cannot upgrade a NonSecure translation regime's attributes
+     * to Secure or Realm.
      */
     result->f.attrs.secure = is_secure;
+    result->f.attrs.space = ptw->in_space;
 
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
@@ -2910,7 +2934,7 @@ static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
 
     default:
         /* Single stage uses physical for ptw. */
-        ptw->in_ptw_idx = is_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
+        ptw->in_ptw_idx = arm_space_to_phys(ptw->in_space);
         break;
     }
 
@@ -2985,6 +3009,7 @@ bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_secure = is_secure,
+        .in_space = arm_secure_to_space(is_secure),
     };
     return get_phys_addr_with_struct(env, &ptw, address, access_type,
                                      result, fi);
@@ -2994,7 +3019,10 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
-    bool is_secure;
+    S1Translate ptw = {
+        .in_mmu_idx = mmu_idx,
+    };
+    ARMSecuritySpace ss;
 
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
@@ -3007,30 +3035,55 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
-        is_secure = arm_is_secure_below_el3(env);
+        ss = arm_security_space_below_el3(env);
         break;
     case ARMMMUIdx_Stage2:
+        /*
+         * For Secure EL2, we need this index to be NonSecure;
+         * otherwise this will already be NonSecure or Realm.
+         */
+        ss = arm_security_space_below_el3(env);
+        if (ss == ARMSS_Secure) {
+            ss = ARMSS_NonSecure;
+        }
+        break;
     case ARMMMUIdx_Phys_NS:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
     case ARMMMUIdx_MUser:
-        is_secure = false;
+        ss = ARMSS_NonSecure;
         break;
-    case ARMMMUIdx_E3:
     case ARMMMUIdx_Stage2_S:
     case ARMMMUIdx_Phys_S:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
     case ARMMMUIdx_MSUser:
-        is_secure = true;
+        ss = ARMSS_Secure;
+        break;
+    case ARMMMUIdx_E3:
+        if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+            cpu_isar_feature(aa64_rme, env_archcpu(env))) {
+            ss = ARMSS_Root;
+        } else {
+            ss = ARMSS_Secure;
+        }
+        break;
+    case ARMMMUIdx_Phys_Root:
+        ss = ARMSS_Root;
+        break;
+    case ARMMMUIdx_Phys_Realm:
+        ss = ARMSS_Realm;
         break;
     default:
         g_assert_not_reached();
     }
-    return get_phys_addr_with_secure(env, address, access_type, mmu_idx,
-                                     is_secure, result, fi);
+
+    ptw.in_space = ss;
+    ptw.in_secure = arm_space_is_secure(ss);
+    return get_phys_addr_with_struct(env, &ptw, address, access_type,
+                                     result, fi);
 }
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
@@ -3038,9 +3091,12 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMSecuritySpace ss = arm_security_space(env);
     S1Translate ptw = {
-        .in_mmu_idx = arm_mmu_idx(env),
-        .in_secure = arm_is_secure(env),
+        .in_mmu_idx = mmu_idx,
+        .in_space = ss,
+        .in_secure = arm_space_is_secure(ss),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
-- 
2.34.1


