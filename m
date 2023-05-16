Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8687057E0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0et-00035P-Lx; Tue, 16 May 2023 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c7-0000Ba-9O
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:44 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c1-0003jH-Ln
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-24e3a0aa408so58595a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266332; x=1686858332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6zv6CFBl/KpfAciWHv+fKXujm15Kfs396M2WZzhU80=;
 b=icy1VDCWgA3RxUGOdwxBJHDIhqtfvcW1ZHPQEKHvet8RDKxEMf4MaaTVoAfXLrSBQq
 Np8FY5eBl3Ak1iJ+uNG8yC/SBxj7BS4Mgxi8rEepuD/LKN4YtJM6qbUvxMp3qiUbES0G
 g1c02x3dzBo9gqoS2D1S2kthVrrboVOvDnwEqch93TDqxA49LPt7dDmA6j9NV18JIcLw
 T8LtAcsviO0+3m76h+U5K43hhIfzXb/zKOgIlw8plwCBD4Ic4SSPF+8dT7Wa0dOn1IRl
 pZXfZYpJVIsyLx2aDQku0PP97wl5wbzT7DPenGoX08FmOGQbyFvIL7lNaQ7HHbPj2FvJ
 HSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266332; x=1686858332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6zv6CFBl/KpfAciWHv+fKXujm15Kfs396M2WZzhU80=;
 b=YnYLhCnAsOD/DZV+63gkLWANm3x4s2bp/VBbFk2gnmyOd9Ha1z/m0YxmD7/7YM+oCS
 tCoWMH7W3h1qR1YwXC2g8KG5+lW353USnxA8z2oP2QlUS/OIH+sdnAdJJRhKtEJ42oMN
 cbynr3wPeVHp74Xo65iV3ddj7k1LRHlFjQ+VyeH+JTrlBt+CKVIp320W+xdUh8aSCdkO
 4RKV4zZdgZ5rb/t6myLKyAAYOQDP9VCtAElrNL+jLvngvaf20Nfkod8s4Qo/L97AF1eU
 vIBXlrftTwCOKK0AF2fYq89uyfbUmQdWX0RqinFFAPdvJEnbMD66bpw2q/76EJAzFCDf
 P1ow==
X-Gm-Message-State: AC+VfDxotP9oD8sL9YQzMQ9+FLYmtFvrV4f5YufJcNz7btWxloJ+szVU
 p6Ev0Y1sB4fVdkW1EzZgkQaGiS3nhTF/CFrYa4E=
X-Google-Smtp-Source: ACHHUZ4zKdxGq8wipoi2Z8oAIBHraDdg7NddKVI+DboShhCEpPJ2MhogGCk5GBjDyWRCiIXvGBJGyA==
X-Received: by 2002:a17:90a:65c6:b0:24e:4b1c:74d2 with SMTP id
 i6-20020a17090a65c600b0024e4b1c74d2mr38679667pjs.32.1684266332206; 
 Tue, 16 May 2023 12:45:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 50/80] tcg/aarch64: Support 128-bit load/store
Date: Tue, 16 May 2023 12:41:15 -0700
Message-Id: <20230516194145.1749305-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Use LDXP+STXP when LSE2 is not present and 16-byte atomicity is required,
and LDP/STP otherwise.  This requires allocating a second general-purpose
temporary, as Rs cannot overlap Rn in STXP.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |   2 +
 tcg/aarch64/tcg-target.h         |  11 +-
 tcg/aarch64/tcg-target.c.inc     | 179 ++++++++++++++++++++++++++++++-
 3 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index d6c6866878..74065c7098 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(lZ, l)
 C_O0_I2(r, rA)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
+C_O0_I3(lZ, lZ, l)
 C_O1_I1(r, l)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
@@ -33,4 +34,5 @@ C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, r, rA, rZ, rZ)
+C_O2_I1(r, r, l)
 C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 74ee2ed255..2c079f21c2 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -129,7 +129,16 @@ extern bool have_lse2;
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
index 1ed5be2c00..893b3514bb 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -81,6 +81,7 @@ bool have_lse;
 bool have_lse2;
 
 #define TCG_REG_TMP0 TCG_REG_X30
+#define TCG_REG_TMP1 TCG_REG_X17
 #define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
@@ -404,6 +405,10 @@ typedef enum {
     I3305_LDR_v64   = 0x5c000000,
     I3305_LDR_v128  = 0x9c000000,
 
+    /* Load/store exclusive. */
+    I3306_LDXP      = 0xc8600000,
+    I3306_STXP      = 0xc8200000,
+
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
@@ -468,6 +473,9 @@ typedef enum {
     I3406_ADR       = 0x10000000,
     I3406_ADRP      = 0x90000000,
 
+    /* Add/subtract extended register instructions. */
+    I3501_ADD       = 0x0b200000,
+
     /* Add/subtract shifted register instructions (without a shift).  */
     I3502_ADD       = 0x0b000000,
     I3502_ADDS      = 0x2b000000,
@@ -638,6 +646,12 @@ static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn,
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
@@ -720,6 +734,14 @@ static void tcg_out_insn_3406(TCGContext *s, AArch64Insn insn,
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
@@ -1647,16 +1669,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     TCGType addr_type = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
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
     TCGReg x3;
@@ -1837,6 +1859,148 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static TCGLabelQemuLdst *
+prepare_host_addr_base_only(TCGContext *s, HostAddress *h, TCGReg addr_reg,
+                            MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+
+    ldst = prepare_host_addr(s, h, addr_reg, oi, true);
+
+    /* Compose the final address, as LDP/STP have no indexing. */
+    if (h->index != TCG_REG_XZR) {
+        tcg_out_insn(s, 3501, ADD, TCG_TYPE_I64, TCG_REG_TMP0,
+                     h->base, h->index,
+                     h->index_ext == TCG_TYPE_I32 ? MO_32 : MO_64, 0);
+        h->base = TCG_REG_TMP0;
+        h->index = TCG_REG_XZR;
+        h->index_ext = TCG_TYPE_I64;
+    }
+
+    return ldst;
+}
+
+static void tcg_out_qemu_ld128(TCGContext *s, TCGReg datalo, TCGReg datahi,
+                               TCGReg addr_reg, MemOpIdx oi)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr_base_only(s, &h, addr_reg, oi, true);
+
+    if (h.aa.atom < MO_128 || have_lse2) {
+        tcg_out_insn(s, 3314, LDP, datalo, datahi, h.base, 0, 0, 0);
+    } else {
+        TCGLabel *l0, *l1 = NULL;
+
+        /*
+         * 16-byte atomicity without LSE2 requires LDXP+STXP loop:
+         * 1: ldxp lo,hi,[addr]
+         *    stxp tmp1,lo,hi,[addr]
+         *    cbnz tmp1, 1b
+         *
+         * If we have already checked for 16-byte alignment, that's all
+         * we need. Otherwise we have determined that misaligned atomicity
+         * may be handled with two 8-byte loads.
+         */
+        if (h.aa.align < MO_128) {
+            /*
+             * TODO: align should be MO_64, so we only need test bit 3,
+             * which means we could use TBNZ instead of AND+CBNE.
+             */
+            l1 = gen_new_label();
+            tcg_out_logicali(s, I3404_ANDI, 0, TCG_REG_TMP1, addr_reg, 15);
+            tcg_out_brcond(s, TCG_TYPE_I32, TCG_COND_NE,
+                           TCG_REG_TMP1, 0, 1, l1);
+        }
+
+        l0 = gen_new_label();
+        tcg_out_label(s, l0);
+
+        tcg_out_insn(s, 3306, LDXP, TCG_REG_XZR, datalo, datahi, h.base);
+        tcg_out_insn(s, 3306, STXP, TCG_REG_TMP1, datalo, datahi, h.base);
+        tcg_out_brcond(s, TCG_TYPE_I32, TCG_COND_NE, TCG_REG_TMP1, 0, 1, l0);
+
+        if (l1) {
+            TCGLabel *l2 = gen_new_label();
+            tcg_out_goto_label(s, l2);
+
+            tcg_out_label(s, l1);
+            tcg_out_insn(s, 3314, LDP, datalo, datahi, h.base, 0, 0, 0);
+
+            tcg_out_label(s, l2);
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
+static void tcg_out_qemu_st128(TCGContext *s, TCGReg datalo, TCGReg datahi,
+                               TCGReg addr_reg, MemOpIdx oi)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr_base_only(s, &h, addr_reg, oi, false);
+
+    if (h.aa.atom < MO_128 || have_lse2) {
+        tcg_out_insn(s, 3314, STP, datalo, datahi, h.base, 0, 0, 0);
+    } else {
+        TCGLabel *l0, *l1 = NULL;
+
+        /*
+         * 16-byte atomicity without LSE2 requires LDXP+STXP loop:
+         * 1: ldxp xzr,tmp1,[addr]
+         *    stxp tmp1,lo,hi,[addr]
+         *    cbnz tmp1, 1b
+         *
+         * If we have already checked for 16-byte alignment, that's all
+         * we need. Otherwise we have determined that misaligned atomicity
+         * may be handled with two 8-byte stores.
+         */
+        if (h.aa.align < MO_128) {
+            /*
+             * TODO: align should be MO_64, so we only need test bit 3,
+             * which means we could use TBNZ instead of AND+CBNE.
+             */
+            l1 = gen_new_label();
+            tcg_out_logicali(s, I3404_ANDI, 0, TCG_REG_TMP1, addr_reg, 15);
+            tcg_out_brcond(s, TCG_TYPE_I32, TCG_COND_NE,
+                           TCG_REG_TMP1, 0, 1, l1);
+        }
+
+        l0 = gen_new_label();
+        tcg_out_label(s, l0);
+
+        tcg_out_insn(s, 3306, LDXP, TCG_REG_XZR,
+                     TCG_REG_XZR, TCG_REG_TMP1, h.base);
+        tcg_out_insn(s, 3306, STXP, TCG_REG_TMP1, datalo, datahi, h.base);
+        tcg_out_brcond(s, TCG_TYPE_I32, TCG_COND_NE, TCG_REG_TMP1, 0, 1, l0);
+
+        if (l1) {
+            TCGLabel *l2 = gen_new_label();
+            tcg_out_goto_label(s, l2);
+
+            tcg_out_label(s, l1);
+            tcg_out_insn(s, 3314, STP, datalo, datahi, h.base, 0, 0, 0);
+
+            tcg_out_label(s, l2);
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
@@ -2172,6 +2336,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_st_i64:
         tcg_out_qemu_st(s, REG0(0), a1, a2, ext);
         break;
+    case INDEX_op_qemu_ld_i128:
+        tcg_out_qemu_ld128(s, a0, a1, a2, args[3]);
+        break;
+    case INDEX_op_qemu_st_i128:
+        tcg_out_qemu_st128(s, REG0(0), REG0(1), a2, args[3]);
+        break;
 
     case INDEX_op_bswap64_i64:
         tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
@@ -2809,9 +2979,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, l);
+    case INDEX_op_qemu_ld_i128:
+        return C_O2_I1(r, r, l);
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(lZ, l);
+    case INDEX_op_qemu_st_i128:
+        return C_O0_I3(lZ, lZ, l);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
@@ -2940,6 +3114,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
     tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
 }
 
-- 
2.34.1


