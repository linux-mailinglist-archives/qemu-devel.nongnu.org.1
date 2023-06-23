Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87A73B7DA
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxO-0002lq-8U; Fri, 23 Jun 2023 08:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx9-0001nm-CV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0000iA-4y
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fa7eb35a13so2869615e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g2pBrFqSLXDykV1+dGNy5GO5Jdx558VbKfiUk+ucQvg=;
 b=E5DSMY/AFyKnyYhlP1sdhGmr6gfwWIVWfJ3C5gBgIYzY7DW5mcOYUPmFRY7rDh443i
 Df7YJZK6Vuw3ALouaR2rsZu6+9A6wfQhgHUSQSkrAkfImF6XEMhvK7HX468El7I88NZ0
 yiTyFZVxhJq1k+r2fU6pyOZGjxY6ps998hC0iWZ9Jv2f/ybTLnhyDB/72KBirj/8SrpI
 wZC9W6S9JngUnAMVjbaAkYjt2SFq+c3+NYQOqKK2+yMWq7MdiHSkgypF+L9C2xQNWv4N
 Z/kVI0ZkuXEpEXLwMCY8k9uBFOA2zx85jtCc4JQpIPcOXCxLk/RpVp/cMLw9m2ttbgPT
 Erew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523506; x=1690115506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2pBrFqSLXDykV1+dGNy5GO5Jdx558VbKfiUk+ucQvg=;
 b=ZBNk4KOkAnIEuMmDN6nyIIV9D7zkWpXqNlGvEi728ZBbAK9iAubfMceHZnYv7JBjVB
 Mv+ymzzwQzbAY6nMNoPZUECHbggd4ceHfI4i/4PNwoCGY6f09eP5xsftoP/WTCEQr0Ac
 feD0iB2+olLXjKKz5IinW1Gs7NFzGHkYvBNaqfbdcy9KIPjBdJ7V57+51FxznoM8LRk9
 phQG8g1YKPhKlkYmVjkVEkDQrRABj09TI+B1VWTnAx6dJUtV7YuwWAA2JqvxGMpDJtUq
 G0DFy80rYMImB129ng3jkGOmQ+2RPWIsexXcaVzY9q2pToy6m9D5wJc1X2ku9cn3sj1q
 EtTw==
X-Gm-Message-State: AC+VfDxO1xq5bnqrYOag3AtFzrts5hsOfjc4fPH+tHuho+0u5zLofI2n
 2oD+AVNQQlhpIzDsAAqecqoTd2Ww9l2xpTavk+8=
X-Google-Smtp-Source: ACHHUZ46+G14lD1MXgX7s0xxE2QOJnml9Vi0651UeJAEao7RimQYrzh8lvHMgVZ37ti9flBQ15bB6A==
X-Received: by 2002:a05:600c:21c7:b0:3f9:b0ed:b71f with SMTP id
 x7-20020a05600c21c700b003f9b0edb71fmr3442805wmj.10.1687523506312; 
 Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] target/arm: Implement the granule protection check
Date: Fri, 23 Jun 2023 13:31:28 +0100
Message-Id: <20230623123135.1788191-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Place the check at the end of get_phys_addr_with_struct,
so that we check all physical results.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 249 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 232 insertions(+), 17 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7c4526e2da1..6015121b99b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -39,11 +39,17 @@ typedef struct S1Translate {
     void *out_host;
 } S1Translate;
 
-static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
-                                      target_ulong address,
-                                      MMUAccessType access_type,
-                                      GetPhysAddrResult *result,
-                                      ARMMMUFaultInfo *fi);
+static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
+                                target_ulong address,
+                                MMUAccessType access_type,
+                                GetPhysAddrResult *result,
+                                ARMMMUFaultInfo *fi);
+
+static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
+                              target_ulong address,
+                              MMUAccessType access_type,
+                              GetPhysAddrResult *result,
+                              ARMMMUFaultInfo *fi);
 
 /* This mapping is common between ID_AA64MMFR0.PARANGE and TCR_ELx.{I}PS. */
 static const uint8_t pamax_map[] = {
@@ -230,6 +236,197 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
 }
 
+static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
+                                     ARMSecuritySpace pspace,
+                                     ARMMMUFaultInfo *fi)
+{
+    MemTxAttrs attrs = {
+        .secure = true,
+        .space = ARMSS_Root,
+    };
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t gpccr = env->cp15.gpccr_el3;
+    unsigned pps, pgs, l0gptsz, level = 0;
+    uint64_t tableaddr, pps_mask, align, entry, index;
+    AddressSpace *as;
+    MemTxResult result;
+    int gpi;
+
+    if (!FIELD_EX64(gpccr, GPCCR, GPC)) {
+        return true;
+    }
+
+    /*
+     * GPC Priority 1 (R_GMGRR):
+     * R_JWCSM: If the configuration of GPCCR_EL3 is invalid,
+     * the access fails as GPT walk fault at level 0.
+     */
+
+    /*
+     * Configuration of PPS to a value exceeding the implemented
+     * physical address size is invalid.
+     */
+    pps = FIELD_EX64(gpccr, GPCCR, PPS);
+    if (pps > FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE)) {
+        goto fault_walk;
+    }
+    pps = pamax_map[pps];
+    pps_mask = MAKE_64BIT_MASK(0, pps);
+
+    switch (FIELD_EX64(gpccr, GPCCR, SH)) {
+    case 0b10: /* outer shareable */
+        break;
+    case 0b00: /* non-shareable */
+    case 0b11: /* inner shareable */
+        /* Inner and Outer non-cacheable requires Outer shareable. */
+        if (FIELD_EX64(gpccr, GPCCR, ORGN) == 0 &&
+            FIELD_EX64(gpccr, GPCCR, IRGN) == 0) {
+            goto fault_walk;
+        }
+        break;
+    default:   /* reserved */
+        goto fault_walk;
+    }
+
+    switch (FIELD_EX64(gpccr, GPCCR, PGS)) {
+    case 0b00: /* 4KB */
+        pgs = 12;
+        break;
+    case 0b01: /* 64KB */
+        pgs = 16;
+        break;
+    case 0b10: /* 16KB */
+        pgs = 14;
+        break;
+    default: /* reserved */
+        goto fault_walk;
+    }
+
+    /* Note this field is read-only and fixed at reset. */
+    l0gptsz = 30 + FIELD_EX64(gpccr, GPCCR, L0GPTSZ);
+
+    /*
+     * GPC Priority 2: Secure, Realm or Root address exceeds PPS.
+     * R_CPDSB: A NonSecure physical address input exceeding PPS
+     * does not experience any fault.
+     */
+    if (paddress & ~pps_mask) {
+        if (pspace == ARMSS_NonSecure) {
+            return true;
+        }
+        goto fault_size;
+    }
+
+    /* GPC Priority 3: the base address of GPTBR_EL3 exceeds PPS. */
+    tableaddr = env->cp15.gptbr_el3 << 12;
+    if (tableaddr & ~pps_mask) {
+        goto fault_size;
+    }
+
+    /*
+     * BADDR is aligned per a function of PPS and L0GPTSZ.
+     * These bits of GPTBR_EL3 are RES0, but are not a configuration error,
+     * unlike the RES0 bits of the GPT entries (R_XNKFZ).
+     */
+    align = MAX(pps - l0gptsz + 3, 12);
+    align = MAKE_64BIT_MASK(0, align);
+    tableaddr &= ~align;
+
+    as = arm_addressspace(env_cpu(env), attrs);
+
+    /* Level 0 lookup. */
+    index = extract64(paddress, l0gptsz, pps - l0gptsz);
+    tableaddr += index * 8;
+    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
+    if (result != MEMTX_OK) {
+        goto fault_eabt;
+    }
+
+    switch (extract32(entry, 0, 4)) {
+    case 1: /* block descriptor */
+        if (entry >> 8) {
+            goto fault_walk; /* RES0 bits not 0 */
+        }
+        gpi = extract32(entry, 4, 4);
+        goto found;
+    case 3: /* table descriptor */
+        tableaddr = entry & ~0xf;
+        align = MAX(l0gptsz - pgs - 1, 12);
+        align = MAKE_64BIT_MASK(0, align);
+        if (tableaddr & (~pps_mask | align)) {
+            goto fault_walk; /* RES0 bits not 0 */
+        }
+        break;
+    default: /* invalid */
+        goto fault_walk;
+    }
+
+    /* Level 1 lookup */
+    level = 1;
+    index = extract64(paddress, pgs + 4, l0gptsz - pgs - 4);
+    tableaddr += index * 8;
+    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
+    if (result != MEMTX_OK) {
+        goto fault_eabt;
+    }
+
+    switch (extract32(entry, 0, 4)) {
+    case 1: /* contiguous descriptor */
+        if (entry >> 10) {
+            goto fault_walk; /* RES0 bits not 0 */
+        }
+        /*
+         * Because the softmmu tlb only works on units of TARGET_PAGE_SIZE,
+         * and because we cannot invalidate by pa, and thus will always
+         * flush entire tlbs, we don't actually care about the range here
+         * and can simply extract the GPI as the result.
+         */
+        if (extract32(entry, 8, 2) == 0) {
+            goto fault_walk; /* reserved contig */
+        }
+        gpi = extract32(entry, 4, 4);
+        break;
+    default:
+        index = extract64(paddress, pgs, 4);
+        gpi = extract64(entry, index * 4, 4);
+        break;
+    }
+
+ found:
+    switch (gpi) {
+    case 0b0000: /* no access */
+        break;
+    case 0b1111: /* all access */
+        return true;
+    case 0b1000:
+    case 0b1001:
+    case 0b1010:
+    case 0b1011:
+        if (pspace == (gpi & 3)) {
+            return true;
+        }
+        break;
+    default:
+        goto fault_walk; /* reserved */
+    }
+
+    fi->gpcf = GPCF_Fail;
+    goto fault_common;
+ fault_eabt:
+    fi->gpcf = GPCF_EABT;
+    goto fault_common;
+ fault_size:
+    fi->gpcf = GPCF_AddressSize;
+    goto fault_common;
+ fault_walk:
+    fi->gpcf = GPCF_Walk;
+ fault_common:
+    fi->level = level;
+    fi->paddr = paddress;
+    fi->paddr_space = pspace;
+    return false;
+}
+
 static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
 {
     /*
@@ -276,10 +473,10 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_with_struct(env, &s2ptw, addr,
-                                      MMU_DATA_LOAD, &s2, fi)) {
+        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, &s2, fi)) {
             goto fail;
         }
+
         ptw->out_phys = s2.f.phys_addr;
         pte_attrs = s2.cacheattrs.attrs;
         ptw->out_host = NULL;
@@ -332,6 +529,9 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
 
  fail:
     assert(fi->type != ARMFault_None);
+    if (fi->type == ARMFault_GPCFOnOutput) {
+        fi->type = ARMFault_GPCFOnWalk;
+    }
     fi->s2addr = addr;
     fi->stage2 = true;
     fi->s1ptw = true;
@@ -2769,7 +2969,7 @@ static bool get_phys_addr_disabled(CPUARMState *env, target_ulong address,
                                    ARMMMUFaultInfo *fi)
 {
     uint8_t memattr = 0x00;    /* Device nGnRnE */
-    uint8_t shareability = 0;  /* non-sharable */
+    uint8_t shareability = 0;  /* non-shareable */
     int r_el;
 
     switch (mmu_idx) {
@@ -2828,7 +3028,7 @@ static bool get_phys_addr_disabled(CPUARMState *env, target_ulong address,
             } else {
                 memattr = 0x44;  /* Normal, NC, No */
             }
-            shareability = 2; /* outer sharable */
+            shareability = 2; /* outer shareable */
         }
         result->cacheattrs.is_s2_format = false;
         break;
@@ -2856,7 +3056,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_with_struct(env, ptw, address, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, address, access_type, result, fi);
 
     /* If S1 fails, return early.  */
     if (ret) {
@@ -2882,7 +3082,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_with_struct(env, ptw, ipa, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
@@ -2942,7 +3142,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
+static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
@@ -3076,6 +3276,23 @@ static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
     }
 }
 
+static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
+                              target_ulong address,
+                              MMUAccessType access_type,
+                              GetPhysAddrResult *result,
+                              ARMMMUFaultInfo *fi)
+{
+    if (get_phys_addr_nogpc(env, ptw, address, access_type, result, fi)) {
+        return true;
+    }
+    if (!granule_protection_check(env, result->f.phys_addr,
+                                  result->f.attrs.space, fi)) {
+        fi->type = ARMFault_GPCFOnOutput;
+        return true;
+    }
+    return false;
+}
+
 bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                bool is_secure, GetPhysAddrResult *result,
@@ -3086,8 +3303,7 @@ bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
         .in_secure = is_secure,
         .in_space = arm_secure_to_space(is_secure),
     };
-    return get_phys_addr_with_struct(env, &ptw, address, access_type,
-                                     result, fi);
+    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
 }
 
 bool get_phys_addr(CPUARMState *env, target_ulong address,
@@ -3157,8 +3373,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
 
     ptw.in_space = ss;
     ptw.in_secure = arm_space_is_secure(ss);
-    return get_phys_addr_with_struct(env, &ptw, address, access_type,
-                                     result, fi);
+    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
 }
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
@@ -3178,7 +3393,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMMMUFaultInfo fi = {};
     bool ret;
 
-    ret = get_phys_addr_with_struct(env, &ptw, addr, MMU_DATA_LOAD, &res, &fi);
+    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
-- 
2.34.1


