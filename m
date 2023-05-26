Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E1711B1E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFE-0002Z9-HG; Thu, 25 May 2023 20:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFC-0002Y6-Jo
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFA-0002Ah-8p
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso458056b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060623; x=1687652623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEZrTsR2PvGkZpVHW0X7uxlBuHoyyk6ikGwddeWtJk8=;
 b=aCisnnu5QWtkH4w8dubH+oPT2hQk9c4BZzGCgf/mVbBwMSu5rA9AVp8H6uV+uxldDJ
 p4x5j5HO+WtVI7JtaOUci+4SzYyF+Q8FtPU6aYS91v6mpuzg1xtcX8eiy2KehKoZnw6O
 KefkNdlivhZX5H5kf9j+X1ZPnS/QzAOEjcLim6IWiB1Yk7KK6jzkuZedrMmiZyzI71O9
 RAIyE3kZ+Ie0HxK9Yp3hVX9ZvYgz59lGQL/9lY32YCUwnseEkfbqiIKfwWbnoYGLGrDX
 xsCTUevn8EfmUhMkI0FLAc/libehth2ZnkBHDBjTfOm3Hwm+vEd9/HtqP1W7KDoXxwSC
 2c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060623; x=1687652623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEZrTsR2PvGkZpVHW0X7uxlBuHoyyk6ikGwddeWtJk8=;
 b=aA8KtuYA1F6zZgwpvppKIUcbQtynHV7tRyYfb6v5zcEeBpFICtM2gsgiX/k6FAwZJm
 K5ddH4a/baNiR6va7MgYZTmhia4FiT78rpIOD+7Wfth0FMBuK4raAR3t3gfsIGDiwLhR
 WEpzrUBOaNFAy95OTOIJ4htmxfCrIPxgicSkgGijKDDl++JpzilateDIomtWdJZwDvHO
 9yjnoFvxUWUjZCfYsJ9Uy0Vx3F6bplTjZty7Ffa4SgjNOLrcGhroqZKDovWtgg1U6KmZ
 gdwlNSEZogdL88R7gViqL4Dsy/z0qwWSln0wAZ98WNOpPw/YkJAa+iz1anpi0OLMPdcL
 md9w==
X-Gm-Message-State: AC+VfDzdfzmPJ1iDmiCezk8rYm/PtUwirf0MK7oqAiXGtlN4197lTsEv
 pdEk3r+tafhNny6tWuY1W2bmTPf4vcM/s34SsLo=
X-Google-Smtp-Source: ACHHUZ4NfEPlE2MTd3tQ1rGD4HWafTPTRbJOJJsZu3NrpGkcSAo+mxBdDJWsyNBgdnLOoQH3n9r2cQ==
X-Received: by 2002:a05:6a00:1508:b0:641:3bf8:6514 with SMTP id
 q8-20020a056a00150800b006413bf86514mr732263pfu.10.1685060622841; 
 Thu, 25 May 2023 17:23:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 09/16] tcg/aarch64: Support 128-bit load/store
Date: Thu, 25 May 2023 17:23:27 -0700
Message-Id: <20230526002334.1760495-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

With FEAT_LSE2, LDP/STP suffices.  Without FEAT_LSE2, use LDXP+STXP
16-byte atomicity is required and LDP/STP otherwise.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |   2 +
 tcg/aarch64/tcg-target.h         |  11 ++-
 tcg/aarch64/tcg-target.c.inc     | 141 ++++++++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 109f4ab97c..3fdee26a3d 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -13,6 +13,7 @@ C_O0_I1(r)
 C_O0_I2(r, rA)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
+C_O0_I3(rZ, rZ, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
@@ -31,4 +32,5 @@ C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, r, rA, rZ, rZ)
+C_O2_I1(r, r, r)
 C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index d5f7614880..192a2758c5 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -131,7 +131,16 @@ typedef enum {
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
+/*
+ * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
+ * which requires writable pages.  We must defer to the helper for user-only,
+ * but in system mode all ram is writable for the host.
+ */
+#ifdef CONFIG_USER_ONLY
+#define TCG_TARGET_HAS_qemu_ldst_i128   have_lse2
+#else
+#define TCG_TARGET_HAS_qemu_ldst_i128   1
+#endif
 
 #define TCG_TARGET_HAS_v64              1
 #define TCG_TARGET_HAS_v128             1
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 00d9033e2f..261ad25210 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -385,6 +385,10 @@ typedef enum {
     I3305_LDR_v64   = 0x5c000000,
     I3305_LDR_v128  = 0x9c000000,
 
+    /* Load/store exclusive. */
+    I3306_LDXP      = 0xc8600000,
+    I3306_STXP      = 0xc8200000,
+
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
@@ -449,6 +453,9 @@ typedef enum {
     I3406_ADR       = 0x10000000,
     I3406_ADRP      = 0x90000000,
 
+    /* Add/subtract extended register instructions. */
+    I3501_ADD       = 0x0b200000,
+
     /* Add/subtract shifted register instructions (without a shift).  */
     I3502_ADD       = 0x0b000000,
     I3502_ADDS      = 0x2b000000,
@@ -619,6 +626,12 @@ static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
 }
 
+static void tcg_out_insn_3306(TCGContext *s, AArch64Insn insn, TCGReg rs,
+                              TCGReg rt, TCGReg rt2, TCGReg rn)
+{
+    tcg_out32(s, insn | rs << 16 | rt2 << 10 | rn << 5 | rt);
+}
+
 static void tcg_out_insn_3201(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rt, int imm19)
 {
@@ -701,6 +714,14 @@ static void tcg_out_insn_3406(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | (disp & 3) << 29 | (disp & 0x1ffffc) << (5 - 2) | rd);
 }
 
+static inline void tcg_out_insn_3501(TCGContext *s, AArch64Insn insn,
+                                     TCGType sf, TCGReg rd, TCGReg rn,
+                                     TCGReg rm, int opt, int imm3)
+{
+    tcg_out32(s, insn | sf << 31 | rm << 16 | opt << 13 |
+              imm3 << 10 | rn << 5 | rd);
+}
+
 /* This function is for both 3.5.2 (Add/Subtract shifted register), for
    the rare occasion when we actually want to supply a shift amount.  */
 static inline void tcg_out_insn_3502S(TCGContext *s, AArch64Insn insn,
@@ -1628,16 +1649,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
+    MemOp s_bits = opc & MO_SIZE;
     unsigned a_mask;
 
     h->aa = atom_and_align_for_opc(s, opc,
                                    have_lse2 ? MO_ATOM_WITHIN16
                                              : MO_ATOM_IFALIGN,
-                                   false);
+                                   s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
-    unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1u << s_bits) - 1;
     unsigned mem_index = get_mmuidx(oi);
     TCGReg addr_adj;
@@ -1818,6 +1839,108 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
+                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+    TCGReg base;
+    bool use_pair;
+
+    ldst = prepare_host_addr(s, &h, addr_reg, oi, is_ld);
+
+    /* Compose the final address, as LDP/STP have no indexing. */
+    if (h.index == TCG_REG_XZR) {
+        base = h.base;
+    } else {
+        base = TCG_REG_TMP2;
+        if (h.index_ext == TCG_TYPE_I32) {
+            /* add base, base, index, uxtw */
+            tcg_out_insn(s, 3501, ADD, TCG_TYPE_I64, base,
+                         h.base, h.index, MO_32, 0);
+        } else {
+            /* add base, base, index */
+            tcg_out_insn(s, 3502, ADD, 1, base, h.base, h.index);
+        }
+    }
+
+    use_pair = h.aa.atom < MO_128 || have_lse2;
+
+    if (!use_pair) {
+        tcg_insn_unit *branch = NULL;
+        TCGReg ll, lh, sl, sh;
+
+        /*
+         * If we have already checked for 16-byte alignment, that's all
+         * we need. Otherwise we have determined that misaligned atomicity
+         * may be handled with two 8-byte loads.
+         */
+        if (h.aa.align < MO_128) {
+            /*
+             * TODO: align should be MO_64, so we only need test bit 3,
+             * which means we could use TBNZ instead of ANDS+B_C.
+             */
+            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, 15);
+            branch = s->code_ptr;
+            tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
+            use_pair = true;
+        }
+
+        if (is_ld) {
+            /*
+             * 16-byte atomicity without LSE2 requires LDXP+STXP loop:
+             *    ldxp lo, hi, [base]
+             *    stxp t0, lo, hi, [base]
+             *    cbnz t0, .-8
+             * Require no overlap between data{lo,hi} and base.
+             */
+            if (datalo == base || datahi == base) {
+                tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_TMP2, base);
+                base = TCG_REG_TMP2;
+            }
+            ll = sl = datalo;
+            lh = sh = datahi;
+        } else {
+            /*
+             * 16-byte atomicity without LSE2 requires LDXP+STXP loop:
+             * 1: ldxp t0, t1, [base]
+             *    stxp t0, lo, hi, [base]
+             *    cbnz t0, 1b
+             */
+            tcg_debug_assert(base != TCG_REG_TMP0 && base != TCG_REG_TMP1);
+            ll = TCG_REG_TMP0;
+            lh = TCG_REG_TMP1;
+            sl = datalo;
+            sh = datahi;
+        }
+
+        tcg_out_insn(s, 3306, LDXP, TCG_REG_XZR, ll, lh, base);
+        tcg_out_insn(s, 3306, STXP, TCG_REG_TMP0, sl, sh, base);
+        tcg_out_insn(s, 3201, CBNZ, 0, TCG_REG_TMP0, -2);
+
+        if (use_pair) {
+            /* "b .+8", branching across the one insn of use_pair. */
+            tcg_out_insn(s, 3206, B, 2);
+            reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
+        }
+    }
+
+    if (use_pair) {
+        if (is_ld) {
+            tcg_out_insn(s, 3314, LDP, datalo, datahi, base, 0, 1, 0);
+        } else {
+            tcg_out_insn(s, 3314, STP, datalo, datahi, base, 0, 1, 0);
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
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
@@ -2157,6 +2280,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_st_a64_i64:
         tcg_out_qemu_st(s, REG0(0), a1, a2, ext);
         break;
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
+        break;
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_out_qemu_ldst_i128(s, REG0(0), REG0(1), a2, args[3], false);
+        break;
 
     case INDEX_op_bswap64_i64:
         tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
@@ -2796,11 +2927,17 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_ld_a32_i64:
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        return C_O2_I1(r, r, r);
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
     case INDEX_op_qemu_st_a32_i64:
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        return C_O0_I3(rZ, rZ, r);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-- 
2.34.1


