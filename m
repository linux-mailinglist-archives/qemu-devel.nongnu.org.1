Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED30BE0D75
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 23:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D7-0003c7-MZ; Wed, 15 Oct 2025 17:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cx-0003Zn-AP
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cs-0004zg-K1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-279e2554b6fso420255ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564328; x=1761169128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+Ory51uKr3/oVevt6rzy+XSeeS7wBifyEegMff7Qdo=;
 b=UPLczVWP4cM00xwf+1Ku5GOB8CjH63bJfmdtlr+S9br/I6R3woSmDRe4AXF7XqwjII
 ElP/ipk/EG0tikwNBvoHeCByMsNhJZsnf2kBMkfNmZEqy91mrNCMm0yaZzjhj8LhhdEE
 kdw3JuHa59OhNl0OBPBeIs0AC7eIlO+s9JX8sj9dWkqD3Umkb0uL9faKNKrblSxfZ01U
 AtqX+5XdshRF60DKZG/wV4zYKHPFrUzpY57cfD/htCguGCsKG38Fbw5MMh4hXMvyYOI1
 i8X3K7VldCIYpFR5YQdlJPpws/g/d3YwSKzEgkY8B6LUKdXTx9AYT7BnqJeNiPWq3ABM
 XnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564328; x=1761169128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+Ory51uKr3/oVevt6rzy+XSeeS7wBifyEegMff7Qdo=;
 b=lftT2T3uaZ3w/ZmoEyZxp7MGBMLVYh/XPpdR4uRZX6lVlCEmRHlh05DBYFYqYjnNyR
 CvazWFuBm6md5qm20cFewflchLWMLRdkx2HnP9QHnffBX3eFynu1HLly7NHZcCTF21aI
 +bcdrCmaiqKElEcONaF5JnYJ9nCHKYO+HV2EYUrDqKnklqtp9bFkngfGDVWqR3WECeTr
 1+ia8HspQ7OtMyA1FVUX0WzoD20kUvI9Cujz43svQC8ITOLuurhekMEGRqPXHxqBaRrY
 0tpOzDcmqUq08lQBfa/HILnLU2itucuFms3o8UmYky1+1t7BC/1tqyHxpImcrA7wj+B0
 XrVw==
X-Gm-Message-State: AOJu0YxwuHWRdUYzRwR5/ATLkZs1WJf/EfETWBpiF1m8Zj9V9mQ8sR9T
 JNqUf+KpFpMyHSRDqefEgdiW0GCIcRYgWIq7UJ6sRGKYxeSXHgJklERjK5Qw1kgsoV/eEi2EDo1
 trRydGQI=
X-Gm-Gg: ASbGnctZM7tQA8rv34JSB92PmWyQ8ngzuD8kUaMWtpH8VRex9MH5gRWgeSMtgHVY0xr
 M2jeVNp1GDBIEAuMDvvG0KIOxB/NI4yT1hStsPMGtyuggM+5knpjHtpIh+4bgCEhK8rTWVAPIrB
 iIYdALC11EgZ5ZN/ci9Y0+L9x61h9oJaxpgUxaVfmWf2IL02AgfvNXsVxfodJqipw3XOSHYiTn5
 ARiqDFnYypnfdDb7KvSopXqVH7T3+8apSyH4LZIDEoX+JCz9l1Yg4fRvf/izkacZZam4p8ElpJj
 vApyCLVBBRGQUVAVQlyv06O/zIMZZ6b3d3Y/FWAHHVz5eDeWFvKSdCTFOoQxsU4PTh/G7lziKbm
 OAkymr3AVxh3l+48/NK9tE3thArCuOwkg2wsyEJMDxmZcK1HeQzEVmCnJyI6syfAMOdJu6q5jdj
 i+lzmlyU8i7A==
X-Google-Smtp-Source: AGHT+IG7iGDMvsZgC1VPgWAIcNARmyJN/FpbWR7eroq5MEthsFx7knXipDna+mDHeJZnb80gH5VnNg==
X-Received: by 2002:a17:903:fa6:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-29027356614mr350152215ad.12.1760564328479; 
 Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 5/9] tcg/mips: Remove support for 32-bit hosts
Date: Wed, 15 Oct 2025 14:38:39 -0700
Message-ID: <20251015213843.14277-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"), released as v10.0.
The next release being v10.2, we can remove the TCG backend
for 32-bit MIPS hosts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-6-philmd@linaro.org>
---
 tcg/mips/tcg-target-has.h |   2 -
 tcg/mips/tcg-target.c.inc | 285 +++++---------------------------------
 2 files changed, 38 insertions(+), 249 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index b9eb338528..88f0145efb 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,11 +39,9 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#endif
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2ca5aaf3a6..8e7c0ea33f 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -32,15 +32,6 @@
 #define TCG_TARGET_CALL_RET_I128      TCG_CALL_RET_NORMAL
 #define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
 
-#if TCG_TARGET_REG_BITS == 32
-# define LO_OFF  (HOST_BIG_ENDIAN * 4)
-# define HI_OFF  (4 - LO_OFF)
-#else
-/* Assert at compile-time that these values are never used for 64-bit. */
-# define LO_OFF  ({ qemu_build_not_reached(); 0; })
-# define HI_OFF  ({ qemu_build_not_reached(); 0; })
-#endif
-
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero",
@@ -84,11 +75,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP3  TCG_REG_T7
 
 #define TCG_GUEST_BASE_REG TCG_REG_S7
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_REG_TB         TCG_REG_S6
-#else
-#define TCG_REG_TB         ({ qemu_build_not_reached(); TCG_REG_ZERO; })
-#endif
 
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
@@ -559,7 +546,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     tcg_target_long tmp;
     int sh, lo;
 
-    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+    if (type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
     }
 
@@ -567,7 +554,6 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (tcg_out_movi_two(s, ret, arg)) {
         return;
     }
-    assert(TCG_TARGET_REG_BITS == 64);
 
     /* Load addresses within 2GB of TB with 1 or 3 insns. */
     tmp = tcg_tbrel_diff(s, (void *)arg);
@@ -630,8 +616,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
-    TCGReg tbreg = TCG_TARGET_REG_BITS == 64 ? TCG_REG_TB : 0;
-    tcg_out_movi_int(s, type, ret, arg, tbreg);
+    tcg_out_movi_int(s, type, ret, arg, TCG_REG_TB);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
@@ -658,7 +643,6 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     tcg_out_opc_sa(s, OPC_SLL, rd, rs, 0);
 }
 
@@ -701,7 +685,6 @@ static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     if (use_mips32r2_instructions) {
         tcg_out_opc_bf(s, OPC_DEXT, ret, arg, 31, 0);
     } else {
@@ -727,20 +710,14 @@ static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    MIPSInsn opc = OPC_LD;
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
-        opc = OPC_LW;
-    }
+    MIPSInsn opc = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
     tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    MIPSInsn opc = OPC_SD;
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
-        opc = OPC_SW;
-    }
+    MIPSInsn opc = type == TCG_TYPE_I32 ? OPC_SW : OPC_SD;
     tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
@@ -918,72 +895,6 @@ void tcg_out_br(TCGContext *s, TCGLabel *l)
     tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO, l);
 }
 
-static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
-{
-    int flags = 0;
-
-    switch (cond) {
-    case TCG_COND_EQ:
-        flags |= SETCOND_INV;
-        /* fall through */
-    case TCG_COND_NE:
-        flags |= SETCOND_NEZ;
-        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP0, al, bl);
-        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP1, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
-        break;
-
-    default:
-        tgen_setcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_TMP0, ah, bh);
-        tgen_setcond(s, TCG_TYPE_I32, tcg_unsigned_cond(cond),
-                     TCG_TMP1, al, bl);
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP0);
-        tgen_setcond(s, TCG_TYPE_I32, tcg_high_cond(cond), TCG_TMP0, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
-        break;
-    }
-    return ret | flags;
-}
-
-static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                          TCGReg al, TCGReg ah,
-                          TCGArg bl, bool const_bl,
-                          TCGArg bh, bool const_bh)
-{
-    int tmpflags = tcg_out_setcond2_int(s, cond, ret, al, ah, bl, bh);
-    tcg_out_setcond_end(s, ret, tmpflags);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpSetcond2 outop_setcond2 = {
-    .base.static_constraint = C_O1_I4(r, r, r, rz, rz),
-    .out = tgen_setcond2,
-};
-
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    int tmpflags = tcg_out_setcond2_int(s, cond, TCG_TMP0, al, ah, bl, bh);
-    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
-    MIPSInsn b_opc = tmpflags & SETCOND_INV ? OPC_BEQ : OPC_BNE;
-
-    tcg_out_reloc(s, s->code_ptr, R_MIPS_PC16, l, 0);
-    tcg_out_opc_br(s, b_opc, tmp, TCG_REG_ZERO);
-    tcg_out_nop(s);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, rz, rz),
-    .out = tgen_brcond2,
-};
-
 static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
                          TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
@@ -1189,7 +1100,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
 
         /* Extract the TLB index from the address into TMP3.  */
-        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addr,
                            TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         } else {
@@ -1201,7 +1112,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
         /* Load the tlb comparator.  */
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
                        cmp_off + HOST_BIG_ENDIAN * 4);
         } else {
@@ -1218,8 +1129,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          */
         tcg_out_movi(s, addr_type, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
         if (a_mask < s_mask) {
-            tcg_out_opc_imm(s, (TCG_TARGET_REG_BITS == 32
-                                || addr_type == TCG_TYPE_I32
+            tcg_out_opc_imm(s, (addr_type == TCG_TYPE_I32
                                 ? OPC_ADDIU : OPC_DADDIU),
                             TCG_TMP2, addr, s_mask - a_mask);
             tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
@@ -1228,7 +1138,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         /* Zero extend a 32-bit guest address for a 64-bit host. */
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ext32u(s, TCG_TMP2, addr);
             addr = TCG_TMP2;
         }
@@ -1261,7 +1171,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
 
         base = addr;
-        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+        if (addr_type == TCG_TYPE_I32) {
             tcg_out_ext32u(s, TCG_REG_A0, base);
             base = TCG_REG_A0;
         }
@@ -1297,7 +1207,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
         break;
     case MO_UL:
-        if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I64) {
+        if (type == TCG_TYPE_I64) {
             tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
             break;
         }
@@ -1306,16 +1216,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
         break;
     case MO_UQ:
-        /* Prefer to load from offset 0 first, but allow for overlap.  */
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
-        } else if (HOST_BIG_ENDIAN ? hi != base : lo == base) {
-            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
-            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
-        } else {
-            tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
-            tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
-        }
+        tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
         break;
     default:
         g_assert_not_reached();
@@ -1357,21 +1258,14 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
     case MO_32:
         tcg_out_opc_imm(s, lw1, lo, base, 0);
         tcg_out_opc_imm(s, lw2, lo, base, 3);
-        if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I64 && !sgn) {
+        if (type == TCG_TYPE_I64 && !sgn) {
             tcg_out_ext32u(s, lo, lo);
         }
         break;
 
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, ld1, lo, base, 0);
-            tcg_out_opc_imm(s, ld2, lo, base, 7);
-        } else {
-            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
-        }
+        tcg_out_opc_imm(s, ld1, lo, base, 0);
+        tcg_out_opc_imm(s, ld2, lo, base, 7);
         break;
 
     default:
@@ -1407,36 +1301,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    MemOp opc = get_memop(oi);
-    TCGLabelQemuLdst *ldst;
-    HostAddress h;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-    ldst = prepare_host_addr(s, &h, addr, oi, true);
-
-    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
-        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
-    } else {
-        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
-    }
-
-    if (ldst) {
-        ldst->type = type;
-        ldst->datalo_reg = datalo;
-        ldst->datahi_reg = datahi;
-        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
-    }
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
-    /* Ensure that the mips32 code is compiled but discarded for mips64. */
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
-    .out =
-        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
@@ -1453,12 +1319,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         tcg_out_opc_imm(s, OPC_SW, lo, base, 0);
         break;
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
-        } else {
-            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? hi : lo, base, 0);
-            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? lo : hi, base, 4);
-        }
+        tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
         break;
     default:
         g_assert_not_reached();
@@ -1486,15 +1347,8 @@ static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
         break;
 
     case MO_64:
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_opc_imm(s, sd1, lo, base, 0);
-            tcg_out_opc_imm(s, sd2, lo, base, 7);
-        } else {
-            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
-        }
+        tcg_out_opc_imm(s, sd1, lo, base, 0);
+        tcg_out_opc_imm(s, sd2, lo, base, 7);
         break;
 
     default:
@@ -1530,36 +1384,8 @@ static const TCGOutOpQemuLdSt outop_qemu_st = {
     .out = tgen_qemu_st,
 };
 
-static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
-                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
-{
-    MemOp opc = get_memop(oi);
-    TCGLabelQemuLdst *ldst;
-    HostAddress h;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-    ldst = prepare_host_addr(s, &h, addr, oi, false);
-
-    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
-        tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
-    } else {
-        tcg_out_qemu_st_unalign(s, datalo, datahi, h.base, opc);
-    }
-
-    if (ldst) {
-        ldst->type = type;
-        ldst->datalo_reg = datalo;
-        ldst->datahi_reg = datahi;
-        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
-    }
-}
-
 static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
-    /* Ensure that the mips32 code is compiled but discarded for mips64. */
-    .base.static_constraint =
-        TCG_TARGET_REG_BITS == 32 ? C_O0_I3(rz, rz, r) : C_NotImplemented,
-    .out =
-        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_st2 : NULL,
+    .base.static_constraint = C_NotImplemented,
 };
 
 static void tcg_out_mb(TCGContext *s, unsigned a0)
@@ -1584,22 +1410,14 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
     int16_t lo = 0;
 
     if (a0) {
-        intptr_t ofs;
-        if (TCG_TARGET_REG_BITS == 64) {
-            ofs = tcg_tbrel_diff(s, (void *)a0);
-            lo = ofs;
-            if (ofs == lo) {
-                base = TCG_REG_TB;
-            } else {
-                base = TCG_REG_V0;
-                tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
-                tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
-            }
+        intptr_t ofs = tcg_tbrel_diff(s, (void *)a0);
+        lo = ofs;
+        if (ofs == lo) {
+            base = TCG_REG_TB;
         } else {
-            ofs = a0;
-            lo = ofs;
             base = TCG_REG_V0;
             tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
+            tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
         }
     }
     if (!tcg_out_opc_jmp(s, OPC_J, tb_ret_addr)) {
@@ -1616,35 +1434,24 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     TCGReg base, dest;
 
     /* indirect jump method */
-    if (TCG_TARGET_REG_BITS == 64) {
-        dest = TCG_REG_TB;
-        base = TCG_REG_TB;
-        ofs = tcg_tbrel_diff(s, (void *)ofs);
-    } else {
-        dest = TCG_TMP0;
-        base = TCG_REG_ZERO;
-    }
+    dest = TCG_REG_TB;
+    base = TCG_REG_TB;
+    ofs = tcg_tbrel_diff(s, (void *)ofs);
     tcg_out_ld(s, TCG_TYPE_PTR, dest, base, ofs);
     tcg_out_opc_reg(s, OPC_JR, 0, dest, 0);
     /* delay slot */
     tcg_out_nop(s);
 
     set_jmp_reset_offset(s, which);
-    if (TCG_TARGET_REG_BITS == 64) {
-        /* For the unlinked case, need to reset TCG_REG_TB. */
-        tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
-                     -tcg_current_code_size(s));
-    }
+    /* For the unlinked case, need to reset TCG_REG_TB. */
+    tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
+                 -tcg_current_code_size(s));
 }
 
 static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
 {
     tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
-    } else {
-        tcg_out_nop(s);
-    }
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -1839,7 +1646,6 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
 {
     tcg_out_dsra(s, a0, a1, 32);
@@ -1849,7 +1655,6 @@ static const TCGOutOpUnary outop_extrh_i64_i32 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_extrh_i64_i32,
 };
-#endif
 
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
@@ -2238,7 +2043,6 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
@@ -2256,7 +2060,6 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_bswap64,
 };
-#endif /* TCG_TARGET_REG_BITS == 64 */
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -2384,7 +2187,6 @@ static const TCGOutOpLoad outop_ld16s = {
     .out = tgen_ld16s,
 };
 
-#if TCG_TARGET_REG_BITS == 64
 static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
@@ -2406,7 +2208,6 @@ static const TCGOutOpLoad outop_ld32s = {
     .base.static_constraint = C_O1_I1(r, r),
     .out = tgen_ld32s,
 };
-#endif
 
 static void tgen_st8_r(TCGContext *s, TCGType type, TCGReg data,
                        TCGReg base, ptrdiff_t offset)
@@ -2545,7 +2346,7 @@ static tcg_insn_unit *align_code_ptr(TCGContext *s)
 }
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   8
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 
@@ -2577,17 +2378,15 @@ static void tcg_target_qemu_prologue(TCGContext *s)
          * with the address of the prologue, so we can use that instead
          * of TCG_REG_TB.
          */
-#if TCG_TARGET_REG_BITS == 64 && !defined(__mips_abicalls)
+#if !defined(__mips_abicalls)
 # error "Unknown mips abi"
 #endif
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base,
-                         TCG_TARGET_REG_BITS == 64 ? TCG_REG_T9 : 0);
+                         TCG_REG_T9);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
-    }
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
 
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
@@ -2643,10 +2442,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /* t3 = dcba -- delay slot */
     tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        return;
-    }
-
     /*
      * bswap32u -- unsigned 32-bit swap.  a0 = ....abcd.
      */
@@ -2741,9 +2536,7 @@ static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
-    }
+    tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
@@ -2774,9 +2567,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);   /* return address */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);   /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB); /* tc->tc_ptr */
-    }
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);   /* tc->tc_ptr */
 }
 
 typedef struct {
@@ -2794,7 +2585,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -REG_SIZE & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
-- 
2.43.0


