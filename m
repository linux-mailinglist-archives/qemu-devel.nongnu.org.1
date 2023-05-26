Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A37711B0F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFC-0002Y1-S7; Thu, 25 May 2023 20:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFB-0002XF-Ko
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF8-00029Q-Aa
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso292964b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060620; x=1687652620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnFiJZaU3RAw6rmWn/CeET2Ge0Ind0gP67YhCDMwmlw=;
 b=wOTcdzHfJLidJwrK2ZGfFideXFVkfNy3hIlZUczETfyt1pLxVUR0ka/S46txtHmieB
 466rfL8rr7mgg7keVqTjfyRX/hk2/Xo64F5pSwFO33ru1gnNt2PQFr1B+1Mpr1/ptERG
 gITCFrurCli8Z7Kuglh7C2fz2Fu7ogIQQwobqi8o+nrr+EvjfaUvDO0xIrSzv0+rfWRr
 C3ry8M8LIIqT7lB8vPEAI5DDenxHjFr7sGtIU+i2FPN4NDTBq+zYAJZKBT2OMy6TeXpU
 IMY6htobFLdTfh09tGV5L/IHPamXLr2iQvyTCKP9A6o9a7wmDySFxKZF0Uh/mnQX9aVd
 uoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060620; x=1687652620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnFiJZaU3RAw6rmWn/CeET2Ge0Ind0gP67YhCDMwmlw=;
 b=lrjjijI9kbt8hqB97L44aXtZyZ0KpesexCOwO+IswU2KJa8SV/xWEIEYyIIVNTi9fo
 ieeihLELYmRIu5iw4qRMuVYnZ5jY2t/0oSMvYqoJWpaDbgog01pGbjSZ7W8B7t1Hsle8
 BI/xJ2uhEt7WDiZcGBFLjQSO6DFQtcgH3axJ6chR2DQVoZJwzsh45s06arWRDbiiCZCu
 KyyuDrJmClwoOe2QLJ2wjt8UB8bdOggibpwNPoPmDpJn3/joJ22JFLvs/Pq/aHB1uspc
 LUJFiNOrGycnS6AJQ7cfqX963PVyR9l9Pgf9BXkWxacR+enPsZOe3L6hPB6Qqvq+BtFe
 x5aQ==
X-Gm-Message-State: AC+VfDw+cXHkzGtXq1vKaRPWxZ6naLPQEqXlDqnlgC+rVKjxpp9ET9+f
 tUgbKAkrwXE8rVRr5AkdbFo7hcgqPrY4HBTJtXA=
X-Google-Smtp-Source: ACHHUZ5rNtIWmjrFMrCoCjsMi1Wdc26ThitZ+Amrjhf1wRdovuaB5TdY2mnYVZhGLsD4+M5iAbxIOA==
X-Received: by 2002:a05:6a00:2e92:b0:643:b489:246d with SMTP id
 fd18-20020a056a002e9200b00643b489246dmr906127pfb.3.1685060620479; 
 Thu, 25 May 2023 17:23:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 06/16] tcg/aarch64: Rename temporaries
Date: Thu, 25 May 2023 17:23:24 -0700
Message-Id: <20230526002334.1760495-7-richard.henderson@linaro.org>
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

We will need to allocate a second general-purpose temporary.
Rename the existing temps to add a distinguishing number.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 84283665e7..8996e29ca9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -71,8 +71,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
-#define TCG_REG_TMP TCG_REG_X30
-#define TCG_VEC_TMP TCG_REG_V31
+#define TCG_REG_TMP0 TCG_REG_X30
+#define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_REG_GUEST_BASE TCG_REG_X28
@@ -984,7 +984,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    TCGReg temp = TCG_REG_TMP;
+    TCGReg temp = TCG_REG_TMP0;
 
     if (offset < -0xffffff || offset > 0xffffff) {
         tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
@@ -1136,8 +1136,8 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
     }
 
     /* Worst-case scenario, move offset to temp register, use reg offset.  */
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, offset);
-    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, offset);
+    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1353,8 +1353,8 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *target)
     if (offset == sextract64(offset, 0, 26)) {
         tcg_out_insn(s, 3206, BL, offset);
     } else {
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, (intptr_t)target);
-        tcg_out_insn(s, 3207, BLR, TCG_REG_TMP);
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
+        tcg_out_insn(s, 3207, BLR, TCG_REG_TMP0);
     }
 }
 
@@ -1491,7 +1491,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
     AArch64Insn insn;
 
     if (rl == ah || (!const_bh && rl == bh)) {
-        rl = TCG_REG_TMP;
+        rl = TCG_REG_TMP0;
     }
 
     if (const_bl) {
@@ -1508,7 +1508,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
                possibility of adding 0+const in the low part, and the
                immediate add instructions encode XSP not XZR.  Don't try
                anything more elaborate here than loading another zero.  */
-            al = TCG_REG_TMP;
+            al = TCG_REG_TMP0;
             tcg_out_movi(s, ext, al, 0);
         }
         tcg_out_insn_3401(s, insn, ext, rl, al, bl);
@@ -1549,7 +1549,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 {
     TCGReg a1 = a0;
     if (is_ctz) {
-        a1 = TCG_REG_TMP;
+        a1 = TCG_REG_TMP0;
         tcg_out_insn(s, 3507, RBIT, ext, a1, a0);
     }
     if (const_b && b == (ext ? 64 : 32)) {
@@ -1558,7 +1558,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
         AArch64Insn sel = I3506_CSEL;
 
         tcg_out_cmp(s, ext, a0, 0, 1);
-        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP, a1);
+        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
 
         if (const_b) {
             if (b == -1) {
@@ -1571,7 +1571,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
                 b = d;
             }
         }
-        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP, b, TCG_COND_NE);
+        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP0, b, TCG_COND_NE);
     }
 }
 
@@ -1588,7 +1588,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 }
 
 static const TCGLdstHelperParam ldst_helper_param = {
-    .ntmp = 1, .tmp = { TCG_REG_TMP }
+    .ntmp = 1, .tmp = { TCG_REG_TMP0 }
 };
 
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
@@ -1847,7 +1847,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     set_jmp_insn_offset(s, which);
     tcg_out32(s, I3206_B);
-    tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
+    tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
     set_jmp_reset_offset(s, which);
 }
 
@@ -1866,7 +1866,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
         ptrdiff_t i_offset = i_addr - jmp_rx;
 
         /* Note that we asserted this in range in tcg_out_goto_tb. */
-        insn = deposit32(I3305_LDR | TCG_REG_TMP, 5, 19, i_offset >> 2);
+        insn = deposit32(I3305_LDR | TCG_REG_TMP0, 5, 19, i_offset >> 2);
     }
     qatomic_set((uint32_t *)jmp_rw, insn);
     flush_idcache_range(jmp_rx, jmp_rw, 4);
@@ -2060,13 +2060,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_rem_i64:
     case INDEX_op_rem_i32:
-        tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP, a1, a2);
-        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP, a2, a1);
+        tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP0, a1, a2);
+        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
         break;
     case INDEX_op_remu_i64:
     case INDEX_op_remu_i32:
-        tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP, a1, a2);
-        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP, a2, a1);
+        tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP0, a1, a2);
+        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
         break;
 
     case INDEX_op_shl_i64:
@@ -2110,8 +2110,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (c2) {
             tcg_out_rotl(s, ext, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3502, SUB, 0, TCG_REG_TMP, TCG_REG_XZR, a2);
-            tcg_out_insn(s, 3508, RORV, ext, a0, a1, TCG_REG_TMP);
+            tcg_out_insn(s, 3502, SUB, 0, TCG_REG_TMP0, TCG_REG_XZR, a2);
+            tcg_out_insn(s, 3508, RORV, ext, a0, a1, TCG_REG_TMP0);
         }
         break;
 
@@ -2517,8 +2517,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                             break;
                         }
                     }
-                    tcg_out_dupi_vec(s, type, MO_8, TCG_VEC_TMP, 0);
-                    a2 = TCG_VEC_TMP;
+                    tcg_out_dupi_vec(s, type, MO_8, TCG_VEC_TMP0, 0);
+                    a2 = TCG_VEC_TMP0;
                 }
                 if (is_scalar) {
                     insn = cmp_scalar_insn[cond];
@@ -2900,9 +2900,9 @@ static void tcg_target_init(TCGContext *s)
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
-    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
-    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
 }
 
 /* Saving pairs: (X19, X20) .. (X27, X28), (X29(fp), X30(lr)).  */
-- 
2.34.1


