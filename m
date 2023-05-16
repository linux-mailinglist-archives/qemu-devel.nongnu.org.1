Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B0A70583B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:03:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eN-0002mO-VM; Tue, 16 May 2023 15:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c8-0000E1-UF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:46 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c2-0003jU-HQ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:36 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-24e015fcf3dso40506a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266333; x=1686858333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3C62E7I5KSH6hopm1N3+kJjnyiF8W6DIOatywqt9qE=;
 b=hioE5TVG9YT7/E1qGMhj6V+n9ItFr8Wdaj6sJeeOOmtTD1lpk94s6RgXnI14FBWdnM
 qUEWtVMo27iIMfBehhzDG0kuHjeGupfX3pfaLIYplWd7U28TBhj9yOZdddZ89NlVSPWk
 2jxd2wjPFlXXSTyHDJX4TkZdoz0YS8RPHt+5t4NcnhRVGvNkMg3RW21/h/03RbqYfIDZ
 GzbzbTUFnJE2GKggay6yYz6nNu+zC9svzCPtiT1S5XiV68pos/0mfmk/rTaD5IB+dMqo
 LHZC6Z9fsVrIwvNq2QAzTVUvZFTUTt6UkCVvw+d4YB/P/cjSksUJG5ODjJBZlbytCZqV
 pm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266333; x=1686858333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3C62E7I5KSH6hopm1N3+kJjnyiF8W6DIOatywqt9qE=;
 b=FOSCqSY9wLrT2BxiReeMTJ1ok9T9vVe5MYzedXTngYNnF1mdatTj6EHsisy5awZOIR
 eAdldO69Xl8Hl47IZqzVbSjFifjgURPWyu6beF3/hdkUtAM3d44es5pf4o/fYyH54cUI
 /i/0z/f9tWReOdHOsaMQcm3oqcQdyfNmSP+POE7WdQOvUBtBcUfWJK7pR4oPM04ezBNC
 ysYhzS42UIAxjfJZpE/MEEnmyM3c7mWgK8nbCEzMQqCkj7AJZUmhdXBK0QZXIOFLMbux
 WKK1b/41sl+R7vz7S9P33/6pOejvQhxXTAaLtj61JBZnnAXGPkpn54fHjzmroxVu4Yiy
 xqHw==
X-Gm-Message-State: AC+VfDzQL+1UDqV3SFqKT16P0aUdnhs9g8TRHdFsaOPDp12QQ/PZoYYa
 QDGyOx6EA8kpxfmkUdU7eTBXo962yxhNZTu9z5E=
X-Google-Smtp-Source: ACHHUZ41aaZ2mXmX/0dkW6lD2kiq78w8L5ENG1fBd4bP6Rg8HO8ZmJdFTIz9agi8PFlCunOkeWcdsQ==
X-Received: by 2002:a17:90a:1141:b0:250:43a8:6551 with SMTP id
 d1-20020a17090a114100b0025043a86551mr36373020pje.35.1684266333046; 
 Tue, 16 May 2023 12:45:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 51/80] tcg/ppc: Support 128-bit load/store
Date: Tue, 16 May 2023 12:41:16 -0700
Message-Id: <20230516194145.1749305-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Use LQ/STQ with ISA v2.07, and 16-byte atomicity is required.
Note that these instructions do not require 16-byte alignment.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |   2 +
 tcg/ppc/tcg-target-con-str.h |   1 +
 tcg/ppc/tcg-target.h         |   3 +-
 tcg/ppc/tcg-target.c.inc     | 115 +++++++++++++++++++++++++++++++----
 4 files changed, 108 insertions(+), 13 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index f206b29205..bbd7b21247 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(r, r)
 C_O0_I2(r, ri)
 C_O0_I2(v, r)
 C_O0_I3(r, r, r)
+C_O0_I3(o, m, r)
 C_O0_I4(r, r, ri, ri)
 C_O0_I4(r, r, r, r)
 C_O1_I1(r, r)
@@ -34,6 +35,7 @@ C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
+C_O2_I1(o, m, r)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rI, rZM, r, r)
 C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 094613cbcb..20846901de 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -9,6 +9,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('o', ALL_GENERAL_REGS & 0xAAAAAAAAu)  /* odd registers */
 REGS('v', ALL_VECTOR_REGS)
 
 /*
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 0914380bd7..204b70f86a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -149,7 +149,8 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
+#define TCG_TARGET_HAS_qemu_ldst_i128   \
+    (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
 /*
  * While technically Altivec could support V64, it has no 64-bit store
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b5c49895f3..c3a1527856 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -295,25 +295,27 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 
 #define B      OPCD( 18)
 #define BC     OPCD( 16)
+
 #define LBZ    OPCD( 34)
 #define LHZ    OPCD( 40)
 #define LHA    OPCD( 42)
 #define LWZ    OPCD( 32)
 #define LWZUX  XO31( 55)
-#define STB    OPCD( 38)
-#define STH    OPCD( 44)
-#define STW    OPCD( 36)
-
-#define STD    XO62(  0)
-#define STDU   XO62(  1)
-#define STDX   XO31(149)
-
 #define LD     XO58(  0)
 #define LDX    XO31( 21)
 #define LDU    XO58(  1)
 #define LDUX   XO31( 53)
 #define LWA    XO58(  2)
 #define LWAX   XO31(341)
+#define LQ     OPCD( 56)
+
+#define STB    OPCD( 38)
+#define STH    OPCD( 44)
+#define STW    OPCD( 36)
+#define STD    XO62(  0)
+#define STDU   XO62(  1)
+#define STDX   XO31(149)
+#define STQ    XO62(  2)
 
 #define ADDIC  OPCD( 12)
 #define ADDI   OPCD( 14)
@@ -2020,7 +2022,18 @@ typedef struct {
 
 bool tcg_target_has_memory_bswap(MemOp memop)
 {
-    return true;
+    TCGAtomAlign aa;
+
+    if ((memop & MO_SIZE) <= MO_64) {
+        return true;
+    }
+
+    /*
+     * Reject 16-byte memop with 16-byte atomicity,
+     * but do allow a pair of 64-bit operations.
+     */
+    aa = atom_and_align_for_opc(tcg_ctx, memop, MO_ATOM_IFALIGN, true);
+    return aa.atom <= MO_64;
 }
 
 /*
@@ -2035,7 +2048,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    MemOp a_bits;
+    MemOp a_bits, s_bits;
 
     /*
      * Book II, Section 1.4, Single-Copy Atomicity, specifies:
@@ -2047,10 +2060,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * As of 3.0, "the non-atomic access is performed as described in
      * the corresponding list", which matches MO_ATOM_SUBALIGN.
      */
+    s_bits = opc & MO_SIZE;
     h->aa = atom_and_align_for_opc(s, opc,
                                    have_isa_3_00 ? MO_ATOM_SUBALIGN
                                                  : MO_ATOM_IFALIGN,
-                                   false);
+                                   s_bits == MO_128);
     a_bits = h->aa.align;
 
 #ifdef CONFIG_SOFTMMU
@@ -2060,7 +2074,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int fast_off = TLB_MASK_TABLE_OFS(mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
     int table_off = fast_off + offsetof(CPUTLBDescFast, table);
-    unsigned s_bits = opc & MO_SIZE;
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
@@ -2303,6 +2316,70 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static TCGLabelQemuLdst *
+prepare_host_addr_index_only(TCGContext *s, HostAddress *h, TCGReg addr_reg,
+                             MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+
+    ldst = prepare_host_addr(s, h, addr_reg, -1, oi, true);
+
+    /* Compose the final address, as LQ/STQ have no indexing. */
+    if (h->base != 0) {
+        tcg_out32(s, ADD | TAB(TCG_REG_TMP1, h->base, h->index));
+        h->index = TCG_REG_TMP1;
+        h->base = 0;
+    }
+
+    return ldst;
+}
+
+static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
+                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+    bool need_bswap;
+    uint32_t insn;
+
+    ldst = prepare_host_addr_index_only(s, &h, addr_reg, oi, is_ld);
+    need_bswap = get_memop(oi) & MO_BSWAP;
+
+    if (h.aa.atom == MO_128) {
+        tcg_debug_assert(!need_bswap);
+        tcg_debug_assert(datalo & 1);
+        tcg_debug_assert(datahi == datalo - 1);
+        insn = is_ld ? LQ : STQ;
+        tcg_out32(s, insn | TAI(datahi, h.index, 0));
+    } else {
+        TCGReg d1, d2;
+
+        if (HOST_BIG_ENDIAN ^ need_bswap) {
+            d1 = datahi, d2 = datalo;
+        } else {
+            d1 = datalo, d2 = datahi;
+        }
+
+        if (need_bswap) {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 8);
+            insn = is_ld ? LDBRX : STDBRX;
+            tcg_out32(s, insn | TAB(d1, 0, h.index));
+            tcg_out32(s, insn | TAB(d2, h.index, TCG_REG_R0));
+        } else {
+            insn = is_ld ? LD : STD;
+            tcg_out32(s, insn | TAI(d1, h.index, 0));
+            tcg_out32(s, insn | TAI(d2, h.index, 8));
+        }
+    }
+
+    if (ldst) {
+        ldst->type = TCG_TYPE_I128;
+        ldst->datalo_reg = datalo;
+        ldst->datahi_reg = datahi;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
@@ -2853,6 +2930,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                             args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_ld_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
+        break;
+
     case INDEX_op_qemu_st_i32:
         if (TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
             tcg_out_qemu_st(s, args[0], -1, args[1], -1,
@@ -2874,6 +2956,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                             args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_st_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
+        break;
 
     case INDEX_op_setcond_i32:
         tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
@@ -3709,6 +3795,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
                 : TARGET_LONG_BITS == 32 ? C_O0_I3(r, r, r)
                 : C_O0_I4(r, r, r, r));
 
+    case INDEX_op_qemu_ld_i128:
+        return C_O2_I1(o, m, r);
+    case INDEX_op_qemu_st_i128:
+        return C_O0_I3(o, m, r);
+
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.34.1


