Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A0775F51
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiRL-0002cW-3W; Wed, 09 Aug 2023 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRI-0002Zt-1K
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRC-0002oW-QJ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-313e742a787so514871f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691584637; x=1692189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xA8fBj98FjuofQKoymExQL2re0GZGratjLN/CLg4U2g=;
 b=fFyvLZbvh/0GECY3SPUxFoobh95HWeloN/nKh5d75YTphg1zmcZcrVkH5B2Fb+nFqp
 cOJkMAEK9cPcCOorXXiTNT+dt6fDDSQZhwujapD/UxoEN0oZrJDmqqDenuVrw6XFYb/j
 V/k8I8+h6dUfrJwCvZgDBG9c69Cb3LQ8B13wGCgYUdEe/+FfW4IV/bTtnaOsj5/jFWHV
 xCqv4GOv3Mly60rqJVpNSrFDivMUWjPEgw66DFiROrgd5IwNUg6yOBxmYi1H4LeT/r0A
 V9Q1l50Vcc3r1obBVXOfWybEoHmwmAokAOgebwZ1UesXxE/CR83wjOgPTpQ0rT7BBnbB
 KNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584637; x=1692189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xA8fBj98FjuofQKoymExQL2re0GZGratjLN/CLg4U2g=;
 b=PlnHxwIzLnd9922HTtog5SZU2v8ZBM/2uT5dnwjDI8Q9QIRpjDeunNs+9qbWcyqdaI
 jY9RZ7eSrhGV+e8kryBF3lhUN6I8C3IJ4j6Ps7bU5sCv5FvIPg6V+8U45qY8Co9Hfd8Z
 w68JKnED9NHC79guG35rDl/5krkjOme/ko8THZK+p9LF9tbH3eWIpon5bV8YWA1eD73q
 tHFEnG2lTQ1apdE9oN10t5oq9BMbGt/VOdA+cO5oxDD/kIhof+N+azTMWUrkjdq+cePR
 uSqs9VDUgCacH+c1M4dU6lqK+8A8XxlMwE0H2b/bC7gJvVpERLwNFLv2rZHKA0+vzJLF
 VWhQ==
X-Gm-Message-State: AOJu0YykhWJbv9qVGUTHibYOEZGauO3Rud5SRU/2XJps1Cp3BpDX3IdT
 X98xwQzD5NP2/CnPJFERXClRZQ==
X-Google-Smtp-Source: AGHT+IFn/Qj/1dVnPK1WTa3bLEGR2n779OC53Han68pyVFsnmzjBjYL7UUjDX4DlBBYZa2F0l7mt5Q==
X-Received: by 2002:adf:ed82:0:b0:314:1f0:5846 with SMTP id
 c2-20020adfed82000000b0031401f05846mr10037513wro.19.1691584636835; 
 Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5246000000b00317f70240afsm5617888wrc.27.2023.08.09.05.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 4/6] target/arm: Pass security space rather than flag for
 AT instructions
Date: Wed,  9 Aug 2023 13:37:04 +0100
Message-ID: <20230809123706.1842548-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809123706.1842548-1-jean-philippe@linaro.org>
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
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

At the moment we only handle Secure and Nonsecure security spaces for
the AT instructions. Add support for Realm and Root.

For AArch64, arm_security_space() gives the desired space. ARM DDI0487J
says (R_NYXTL):

  If EL3 is implemented, then when an address translation instruction
  that applies to an Exception level lower than EL3 is executed, the
  Effective value of SCR_EL3.{NSE, NS} determines the target Security
  state that the instruction applies to.

For AArch32, some instructions can access NonSecure space from Secure,
so we still need to pass the state explicitly to do_ats_write().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 18 +++++++++---------
 target/arm/helper.c    | 27 ++++++++++++---------------
 target/arm/ptw.c       | 12 ++++++------
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc90c364f7..cf13bb94f5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1217,24 +1217,24 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     __attribute__((nonnull));
 
 /**
- * get_phys_addr_with_secure_nogpc: get the physical address for a virtual
- *                                  address
+ * get_phys_addr_with_space_nogpc: get the physical address for a virtual
+ *                                 address
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
  * @mmu_idx: MMU index indicating required translation regime
- * @is_secure: security state for the access
+ * @space: security space for the access
  * @result: set on translation success.
  * @fi: set to fault info if the translation fails
  *
- * Similar to get_phys_addr, but use the given security regime and don't perform
+ * Similar to get_phys_addr, but use the given security space and don't perform
  * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
-                                     MMUAccessType access_type,
-                                     ARMMMUIdx mmu_idx, bool is_secure,
-                                     GetPhysAddrResult *result,
-                                     ARMMMUFaultInfo *fi)
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+                                    MMUAccessType access_type,
+                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
+                                    GetPhysAddrResult *result,
+                                    ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 427de6bd2a..fbb03c364b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3357,7 +3357,7 @@ static int par_el1_shareability(GetPhysAddrResult *res)
 
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                             bool is_secure)
+                             ARMSecuritySpace ss)
 {
     bool ret;
     uint64_t par64;
@@ -3369,8 +3369,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
      * I_MXTJT: Granule protection checks are not performed on the final address
      * of a successful translation.
      */
-    ret = get_phys_addr_with_secure_nogpc(env, value, access_type, mmu_idx,
-                                          is_secure, &res, &fi);
+    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
+                                         &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
@@ -3535,7 +3535,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
-    bool secure = arm_is_secure_below_el3(env);
+    ARMSecuritySpace ss = arm_security_space(env);
 
     switch (ri->opc2 & 6) {
     case 0:
@@ -3543,10 +3543,9 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_E3;
-            secure = true;
             break;
         case 2:
-            g_assert(!secure);  /* ARMv8.4-SecEL2 is 64-bit only */
+            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
             if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
@@ -3564,10 +3563,9 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_E10_0;
-            secure = true;
             break;
         case 2:
-            g_assert(!secure);  /* ARMv8.4-SecEL2 is 64-bit only */
+            g_assert(ss != ARMSS_Secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
@@ -3580,18 +3578,18 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
         mmu_idx = ARMMMUIdx_E10_1;
-        secure = false;
+        ss = ARMSS_NonSecure;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
         mmu_idx = ARMMMUIdx_E10_0;
-        secure = false;
+        ss = ARMSS_NonSecure;
         break;
     default:
         g_assert_not_reached();
     }
 
-    par64 = do_ats_write(env, value, access_type, mmu_idx, secure);
+    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 #else
@@ -3608,7 +3606,8 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t par64;
 
     /* There is no SecureEL2 for AArch32. */
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2, false);
+    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
+                         ARMSS_NonSecure);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 #else
@@ -3633,7 +3632,6 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
 #ifdef CONFIG_TCG
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     ARMMMUIdx mmu_idx;
-    int secure = arm_is_secure_below_el3(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
 
@@ -3653,7 +3651,6 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_E3;
-            secure = true;
             break;
         default:
             g_assert_not_reached();
@@ -3673,7 +3670,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     env->cp15.par_el[1] = do_ats_write(env, value, access_type,
-                                       mmu_idx, secure);
+                                       mmu_idx, arm_security_space(env));
 #else
     /* Handled by hardware accelerator. */
     g_assert_not_reached();
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 33179f3471..6c5ecd37cd 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3418,15 +3418,15 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
-                                     MMUAccessType access_type,
-                                     ARMMMUIdx mmu_idx, bool is_secure,
-                                     GetPhysAddrResult *result,
-                                     ARMMMUFaultInfo *fi)
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+                                    MMUAccessType access_type,
+                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
+                                    GetPhysAddrResult *result,
+                                    ARMMMUFaultInfo *fi)
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_space = arm_secure_to_space(is_secure),
+        .in_space = space,
     };
     return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
-- 
2.41.0


