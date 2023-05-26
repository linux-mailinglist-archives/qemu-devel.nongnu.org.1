Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1E711B17
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFI-0002cW-TZ; Thu, 25 May 2023 20:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFG-0002bE-4O
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFC-0002Az-CG
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso292993b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060624; x=1687652624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m1gy3VcWcPhyrnWVeS5QjTxUcewlY10qC8szGENLB4=;
 b=bAIULuHXyP5kYF+g/POXMt06p5DqPcMYvJ/GZHgzWA9BqA64aLSudFUKqPFo4dDIz5
 yDNAzLEe+AryKO6f+qF9N5PH86LFa7Iu0UM8SgV1DH42GuRpS7GegQIbxhdHV+rwKNh1
 4TGttgiq1sfVKBRxM7ZTkEy+II0fzKCoM/QJnN7QkQJc5hiWg+AckbgGHzkGIVIps817
 0YmeC8uRkn+0pXhp1YlSOSIB3nsherFnywQeHn7J+octDz2HGEqu09NGVflBG7vbwUNI
 X0s24RHsb9Jwcuu+nid7TwXSpnmH0fBc6jWDLTXSywVWQVo06tli9Oq+S+/2aC0foq3F
 1ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060624; x=1687652624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m1gy3VcWcPhyrnWVeS5QjTxUcewlY10qC8szGENLB4=;
 b=jQMyVkm8TiuWAcEzSoNUiVLdQGk8sJH2htNJdQnCr8nAElEa/IRd3m8OGBd0UUmyd8
 qvffoh5R7xFXoIQXst+zud6VNrT2Exb6MmEU11RQJHze5rn13dw2AwNZmdD1ARlmmJ0j
 rrgYaohqOSc2v7UgPTpvevdZ/mhQRNleYEvvFRysGIkfwfq9nUoPqJFZjIzgFo5F20Zd
 /XCg83luM199cIWhLL5fhxdz6cuUyyQ+6aURJE+D10WpLc7Ynv1MkdezymAsCsGfTMPx
 hTPIUC0XhugHVI4NYgi4wxn2m1O2RYpX+D0v5COfTcZdANH9yp0nXr2BBiIXR3XTdwS5
 VFzQ==
X-Gm-Message-State: AC+VfDxBkQHLQsDhmfg1CEUcvi5n30NkwW3dm0EUdkUAL+SK2pm5/cMQ
 JxzjgtLxXMwILSexMNjWPjkA0rLaZydZgHcumv4=
X-Google-Smtp-Source: ACHHUZ5vBgZakf5Ld7G1VzpNiAyB6PaVjaeqQMaBAlDKe0uHbBKVwbvb0gax5s7aZcCssLBJbtrnOQ==
X-Received: by 2002:a05:6a20:72a8:b0:10b:b166:8836 with SMTP id
 o40-20020a056a2072a800b0010bb1668836mr17307229pzk.47.1685060623841; 
 Thu, 25 May 2023 17:23:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 10/16] tcg/ppc: Support 128-bit load/store
Date: Thu, 25 May 2023 17:23:28 -0700
Message-Id: <20230526002334.1760495-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 tcg/ppc/tcg-target.c.inc     | 108 +++++++++++++++++++++++++++++++----
 4 files changed, 101 insertions(+), 13 deletions(-)

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
index d4269dffcf..d47a9e3478 100644
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
@@ -2303,6 +2316,60 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
+                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+    bool need_bswap;
+    uint32_t insn;
+    TCGReg index;
+
+    ldst = prepare_host_addr(s, &h, addr_reg, -1, oi, is_ld);
+
+    /* Compose the final address, as LQ/STQ have no indexing. */
+    index = h.index;
+    if (h.base != 0) {
+        index = TCG_REG_TMP1;
+        tcg_out32(s, ADD | TAB(index, h.base, h.index));
+    }
+    need_bswap = get_memop(oi) & MO_BSWAP;
+
+    if (h.aa.atom == MO_128) {
+        tcg_debug_assert(!need_bswap);
+        tcg_debug_assert(datalo & 1);
+        tcg_debug_assert(datahi == datalo - 1);
+        insn = is_ld ? LQ : STQ;
+        tcg_out32(s, insn | TAI(datahi, index, 0));
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
+            tcg_out32(s, insn | TAB(d1, 0, index));
+            tcg_out32(s, insn | TAB(d2, index, TCG_REG_R0));
+        } else {
+            insn = is_ld ? LD : STD;
+            tcg_out32(s, insn | TAI(d1, index, 0));
+            tcg_out32(s, insn | TAI(d2, index, 8));
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
@@ -2860,6 +2927,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                             args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
+        break;
 
     case INDEX_op_qemu_st_a64_i32:
         if (TCG_TARGET_REG_BITS == 32) {
@@ -2889,6 +2961,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                             args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
+        break;
 
     case INDEX_op_setcond_i32:
         tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
@@ -3722,6 +3799,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I4(r, r, r, r);
 
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        return C_O2_I1(o, m, r);
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        return C_O0_I3(o, m, r);
+
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.34.1


