Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A9705847
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cZ-0000pN-MT; Tue, 16 May 2023 15:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c5-000075-0T
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c0-0003iw-QK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4be0b1f3so542865ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266331; x=1686858331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0UJEF5x7D/tJuynxyknIi5yS26S+uTp0Nck/e1vPAw=;
 b=cqU6Y6Mlxf981nmwHHerhSrJHJiQS4Cn9vg31bfxFadBRz9f8YE+cL+IfrHAZIyHBl
 KRkW/g8GB2JTtB5bR0c5dFUUl2Ld4CvRECTEPTWg4Ipt/qlqjCrnvXINCgZjUAi+bW1p
 kfCCChsTCLgd6076DMGgLmUk7hV55de5xfhAnQB8KfKs7GCTjPByoaGCE2er/se4VVN4
 NKc8b3nRimEa7qz42WfqMYKBvdmSrOoRDlDfvkgZUjjCMOEdpXmreXTFwSGsQ4QPKbYV
 lg5IOFWuXXhsmgMmRujYqLK8rDMUgRxXIGSXHc+9aTsQMqYeHFf7NI1q94TPaQ8AiYbn
 CnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266331; x=1686858331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0UJEF5x7D/tJuynxyknIi5yS26S+uTp0Nck/e1vPAw=;
 b=KCkTgkfnk3TxJm7/Fo/QIBidNMnxZO6CnV2+CaThk6JMX/xOjK2xpdp2Vq0XcXmLDQ
 U42EcnpvaXhgN/TdDcFOnqPNOCRFKklOvBkIqryO5XWbDSaYKXGta4etNAjyZEE9Yb9a
 YmqYJAEg63wx1Vdsa93jtKI50IBarsoPyhAJaaSovBucSwRwIMbz2dhwTTbQpsCGeU/3
 vk0y3lEiiHqgldl5XIbi1UTuJpFkd4+wLg5uLg0IXQb+ge7dVYt/9XDyxFwPMNmQ5jWg
 LH1mxDJxNpXMa24ivPWybV0DFxd8TuWKwUFGLIaWtgJTZaABO606rLQbaL5nMuGP4MEU
 X/3A==
X-Gm-Message-State: AC+VfDxBGkuWBjxXF1/NtZN9ull/Ur3QDDTJ3Iy9uht2NVi4IVeG15hi
 6y2VjfPd9TRU8g8NU7NU5M3Ir1E2yK5tCQ5sY7g=
X-Google-Smtp-Source: ACHHUZ59KC8nr9SjZbegL/NltFYR9EeJEhoVMkyGcOa5ccjIi7ExAohsK6FDcHke/VOIpoRYECp5hQ==
X-Received: by 2002:a17:90b:fd8:b0:24e:4231:ec6b with SMTP id
 gd24-20020a17090b0fd800b0024e4231ec6bmr37281620pjb.21.1684266331365; 
 Tue, 16 May 2023 12:45:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 49/80] tcg/aarch64: Rename temporaries
Date: Tue, 16 May 2023 12:41:14 -0700
Message-Id: <20230516194145.1749305-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index ea4108d59c..1ed5be2c00 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -80,8 +80,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 bool have_lse;
 bool have_lse2;
 
-#define TCG_REG_TMP TCG_REG_X30
-#define TCG_VEC_TMP TCG_REG_V31
+#define TCG_REG_TMP0 TCG_REG_X30
+#define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
 /* Note that XZR cannot be encoded in the address base register slot,
@@ -998,7 +998,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg r, TCGReg base, intptr_t offset)
 {
-    TCGReg temp = TCG_REG_TMP;
+    TCGReg temp = TCG_REG_TMP0;
 
     if (offset < -0xffffff || offset > 0xffffff) {
         tcg_out_movi(s, TCG_TYPE_PTR, temp, offset);
@@ -1150,8 +1150,8 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
     }
 
     /* Worst-case scenario, move offset to temp register, use reg offset.  */
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, offset);
-    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, offset);
+    tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP0);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1367,8 +1367,8 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *target)
     if (offset == sextract64(offset, 0, 26)) {
         tcg_out_insn(s, 3206, BL, offset);
     } else {
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, (intptr_t)target);
-        tcg_out_insn(s, 3207, BLR, TCG_REG_TMP);
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
+        tcg_out_insn(s, 3207, BLR, TCG_REG_TMP0);
     }
 }
 
@@ -1505,7 +1505,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
     AArch64Insn insn;
 
     if (rl == ah || (!const_bh && rl == bh)) {
-        rl = TCG_REG_TMP;
+        rl = TCG_REG_TMP0;
     }
 
     if (const_bl) {
@@ -1522,7 +1522,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
                possibility of adding 0+const in the low part, and the
                immediate add instructions encode XSP not XZR.  Don't try
                anything more elaborate here than loading another zero.  */
-            al = TCG_REG_TMP;
+            al = TCG_REG_TMP0;
             tcg_out_movi(s, ext, al, 0);
         }
         tcg_out_insn_3401(s, insn, ext, rl, al, bl);
@@ -1563,7 +1563,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
 {
     TCGReg a1 = a0;
     if (is_ctz) {
-        a1 = TCG_REG_TMP;
+        a1 = TCG_REG_TMP0;
         tcg_out_insn(s, 3507, RBIT, ext, a1, a0);
     }
     if (const_b && b == (ext ? 64 : 32)) {
@@ -1572,7 +1572,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
         AArch64Insn sel = I3506_CSEL;
 
         tcg_out_cmp(s, ext, a0, 0, 1);
-        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP, a1);
+        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
 
         if (const_b) {
             if (b == -1) {
@@ -1585,7 +1585,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
                 b = d;
             }
         }
-        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP, b, TCG_COND_NE);
+        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP0, b, TCG_COND_NE);
     }
 }
 
@@ -1602,7 +1602,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 }
 
 static const TCGLdstHelperParam ldst_helper_param = {
-    .ntmp = 1, .tmp = { TCG_REG_TMP }
+    .ntmp = 1, .tmp = { TCG_REG_TMP0 }
 };
 
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
@@ -1862,7 +1862,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     set_jmp_insn_offset(s, which);
     tcg_out32(s, I3206_B);
-    tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
+    tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
     set_jmp_reset_offset(s, which);
 }
 
@@ -1881,7 +1881,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
         ptrdiff_t i_offset = i_addr - jmp_rx;
 
         /* Note that we asserted this in range in tcg_out_goto_tb. */
-        insn = deposit32(I3305_LDR | TCG_REG_TMP, 5, 19, i_offset >> 2);
+        insn = deposit32(I3305_LDR | TCG_REG_TMP0, 5, 19, i_offset >> 2);
     }
     qatomic_set((uint32_t *)jmp_rw, insn);
     flush_idcache_range(jmp_rx, jmp_rw, 4);
@@ -2075,13 +2075,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
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
@@ -2125,8 +2125,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (c2) {
             tcg_out_rotl(s, ext, a0, a1, a2);
         } else {
-            tcg_out_insn(s, 3502, SUB, 0, TCG_REG_TMP, TCG_REG_XZR, a2);
-            tcg_out_insn(s, 3508, RORV, ext, a0, a1, TCG_REG_TMP);
+            tcg_out_insn(s, 3502, SUB, 0, TCG_REG_TMP0, TCG_REG_XZR, a2);
+            tcg_out_insn(s, 3508, RORV, ext, a0, a1, TCG_REG_TMP0);
         }
         break;
 
@@ -2528,8 +2528,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2938,9 +2938,9 @@ static void tcg_target_init(TCGContext *s)
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


