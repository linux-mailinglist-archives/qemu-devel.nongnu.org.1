Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A30735BAE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEp-0006oF-PS; Mon, 19 Jun 2023 11:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEc-0006iN-E5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEX-0004y8-Kq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so9033476a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190160; x=1689782160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7lk/E8K2T92xJtdifgAUd49agVz7yhxbZ29mTnMmUg=;
 b=QPG1G5K+2xgfVmOL9RXOPpuu+oXLtm3xwRG0fiIUyCY9rXoH7nsJdxdHKdQaUGdVP2
 dSvSswozGJyKyMIlFcppJcWotNmHHyfxCjmqbKdP2EB+BIZRvdP7yi4VS+bE5nXnQiZq
 BHhsG2u2+1rezjWuFXSx/rk+Nhvu/zT0YXasRSev8lCP0e0sAtYRTF28NYAdtvm6Q05y
 vwyXS5Vv+/bj07zKhnYTuitM8eVXa3Mei/Y0r+JODL2cRfVVUWtF22IGnEh31zSLlEPE
 24hnjESN+Mrla74sc5FcIsW9XZwyoWwrtPe1dkSNe/qqDufC4LyyTUj/8lsCgnTOh+ny
 hgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190160; x=1689782160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7lk/E8K2T92xJtdifgAUd49agVz7yhxbZ29mTnMmUg=;
 b=QOhN3hAg5B/WoSHQghtXj+1M4AtPLkpElEFQ0RSpBdYNQv8DrcD5C+PSI5ZwgNyOys
 dEb8+q/CS42rTZs5ng6o2W1DG603TOotWAuNGu+ivI6WkMOf4sX0pAExk1KILtIiIfxN
 9iki38EffejxQ14bY0R/G41Vb62k8Bi+uMmZOk2wfmgVUgAO0J3Gcm/zDCkHAYMjV/1l
 pM1kTIB84NUK3p+RrkHyrFYOedYppMUoI9H/6RRz2q9/RB268UQxnhBlvymjxuqgZ7hs
 tT4ieqoCClWscVE1tct7QZi+0FOXdBvao7gzyX4pHmvUuYngNyX2KAobxPl7seViKStq
 8ujQ==
X-Gm-Message-State: AC+VfDwzSxW53m7RISWLFNRDbQ/TQtznbQ6NaykZtWf0LO6rFsHQjMsG
 YRh3r7guEyyJJbQuf90lcuQuc50UhVLILTAtgdCumw==
X-Google-Smtp-Source: ACHHUZ4oIVpI2/8TywDzSlWTLrJ9vmT14TSpb4KrpyrAkVNtrtlWp3ptgK8jfqNmuB1NTSrz3FC6Sw==
X-Received: by 2002:a05:6402:3595:b0:50d:8bc9:41c8 with SMTP id
 y21-20020a056402359500b0050d8bc941c8mr13923014edc.13.1687190157875; 
 Mon, 19 Jun 2023 08:55:57 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 n6-20020a056402514600b0051a313a66e8sm4312129edd.45.2023.06.19.08.55.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:55:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/34] target/arm/tcg: Extract generic vector helpers to
 translate-gvec.c
Date: Mon, 19 Jun 2023 17:54:52 +0200
Message-Id: <20230619155510.80991-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Extract 1600 lines from the big enough translate.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate-gvec.c | 1644 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate.c      | 1630 ------------------------------
 target/arm/tcg/meson.build      |    1 +
 3 files changed, 1645 insertions(+), 1630 deletions(-)
 create mode 100644 target/arm/tcg/translate-gvec.c

diff --git a/target/arm/tcg/translate-gvec.c b/target/arm/tcg/translate-gvec.c
new file mode 100644
index 0000000000..8b1d5e283c
--- /dev/null
+++ b/target/arm/tcg/translate-gvec.c
@@ -0,0 +1,1644 @@
+/*
+ * ARM AdvSIMD / SVE Vector Helpers
+ *
+ * Copyright (c) 2020 Linaro
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
+                            uint32_t opr_sz, uint32_t max_sz,
+                            gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(qc_ptr, cpu_env, offsetof(CPUARMState, vfp.qc));
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, qc_ptr,
+                       opr_sz, max_sz, 0, fn);
+}
+
+void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlah_s16, gen_helper_gvec_qrdmlah_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
+void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[2] = {
+        gen_helper_gvec_qrdmlsh_s16, gen_helper_gvec_qrdmlsh_s32
+    };
+    tcg_debug_assert(vece >= 1 && vece <= 2);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
+}
+
+#define GEN_CMP0(NAME, COND)                                            \
+    static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
+    {                                                                   \
+        tcg_gen_setcondi_i32(COND, d, a, 0);                            \
+        tcg_gen_neg_i32(d, d);                                          \
+    }                                                                   \
+    static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
+    {                                                                   \
+        tcg_gen_setcondi_i64(COND, d, a, 0);                            \
+        tcg_gen_neg_i64(d, d);                                          \
+    }                                                                   \
+    static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
+    {                                                                   \
+        TCGv_vec zero = tcg_constant_vec_matching(d, vece, 0);          \
+        tcg_gen_cmp_vec(COND, vece, d, a, zero);                        \
+    }                                                                   \
+    void gen_gvec_##NAME##0(unsigned vece, uint32_t d, uint32_t m,      \
+                            uint32_t opr_sz, uint32_t max_sz)           \
+    {                                                                   \
+        const GVecGen2 op[4] = {                                        \
+            { .fno = gen_helper_gvec_##NAME##0_b,                       \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_8 },                                           \
+            { .fno = gen_helper_gvec_##NAME##0_h,                       \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_16 },                                          \
+            { .fni4 = gen_##NAME##0_i32,                                \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_32 },                                          \
+            { .fni8 = gen_##NAME##0_i64,                                \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,                  \
+              .vece = MO_64 },                                          \
+        };                                                              \
+        tcg_gen_gvec_2(d, m, opr_sz, max_sz, &op[vece]);                \
+    }
+
+static const TCGOpcode vecop_list_cmp[] = {
+    INDEX_op_cmp_vec, 0
+};
+
+GEN_CMP0(ceq, TCG_COND_EQ)
+GEN_CMP0(cle, TCG_COND_LE)
+GEN_CMP0(cge, TCG_COND_GE)
+GEN_CMP0(clt, TCG_COND_LT)
+GEN_CMP0(cgt, TCG_COND_GT)
+
+#undef GEN_CMP0
+
+static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_ssra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_ssra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_sari_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_ssra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_sari_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_sari_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_ssra8_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_ssra16_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_ssra32_i32,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_ssra64_i64,
+          .fniv = gen_ssra_vec,
+          .fno = gen_helper_gvec_ssra_b,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Signed results in all sign bits.
+     */
+    shift = MIN(shift, (8 << vece) - 1);
+    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+}
+
+static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_usra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_usra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_usra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_shri_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_usra8_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8, },
+        { .fni8 = gen_usra16_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16, },
+        { .fni4 = gen_usra32_i32,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32, },
+        { .fni8 = gen_usra64_i64,
+          .fniv = gen_usra_vec,
+          .fno = gen_helper_gvec_usra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64, },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Unsigned results in all zeros as input to accumulate: nop.
+     */
+    if (shift < (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
+
+/*
+ * Shift one less than the requested amount, and the low bit is
+ * the rounding bit.  For the 8 and 16-bit operations, because we
+ * mask the low bit, we can perform a normal integer shift instead
+ * of a vector shift.
+ */
+static void gen_srshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_sar8i_i64(d, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_srshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_sar16i_i64(d, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t;
+
+    /* Handle shift by the input size for the benefit of trans_SRSHR_ri */
+    if (sh == 32) {
+        tcg_gen_movi_i32(d, 0);
+        return;
+    }
+    t = tcg_temp_new_i32();
+    tcg_gen_extract_i32(t, a, sh - 1, 1);
+    tcg_gen_sari_i32(d, a, sh);
+    tcg_gen_add_i32(d, d, t);
+}
+
+void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t, a, sh - 1, 1);
+    tcg_gen_sari_i64(d, a, sh);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shri_vec(vece, t, a, sh - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, t, ones);
+    tcg_gen_sari_vec(vece, d, a, sh);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srshr8_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_srshr16_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_srshr32_i32,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_srshr64_i64,
+          .fniv = gen_srshr_vec,
+          .fno = gen_helper_gvec_srshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Signed results in all sign bits.  With rounding, this produces
+         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+         * I.e. always zero.
+         */
+        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_srsra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr8_i64(t, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_srsra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr16_i64(t, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_srsra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    gen_srshr32_i32(t, a, sh);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_srsra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    gen_srshr64_i64(t, a, sh);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_srsra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    gen_srshr_vec(vece, t, a, sh);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_srsra8_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_srsra16_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_srsra32_i32,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_srsra64_i64,
+          .fniv = gen_srsra_vec,
+          .fno = gen_helper_gvec_srsra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /*
+     * Shifts larger than the element size are architecturally valid.
+     * Signed results in all sign bits.  With rounding, this produces
+     *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
+     * I.e. always zero.  With accumulation, this leaves D unchanged.
+     */
+    if (shift == (8 << vece)) {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_urshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
+    tcg_gen_vec_shr8i_i64(d, a, sh);
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_urshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, sh - 1);
+    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
+    tcg_gen_vec_shr16i_i64(d, a, sh);
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t;
+
+    /* Handle shift by the input size for the benefit of trans_URSHR_ri */
+    if (sh == 32) {
+        tcg_gen_extract_i32(d, a, sh - 1, 1);
+        return;
+    }
+    t = tcg_temp_new_i32();
+    tcg_gen_extract_i32(t, a, sh - 1, 1);
+    tcg_gen_shri_i32(d, a, sh);
+    tcg_gen_add_i32(d, d, t);
+}
+
+void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t, a, sh - 1, 1);
+    tcg_gen_shri_i64(d, a, sh);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec ones = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shri_vec(vece, t, a, shift - 1);
+    tcg_gen_dupi_vec(vece, ones, 1);
+    tcg_gen_and_vec(vece, t, t, ones);
+    tcg_gen_shri_vec(vece, d, a, shift);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_urshr8_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_urshr16_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_urshr32_i32,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_urshr64_i64,
+          .fniv = gen_urshr_vec,
+          .fno = gen_helper_gvec_urshr_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    if (shift == (8 << vece)) {
+        /*
+         * Shifts larger than the element size are architecturally valid.
+         * Unsigned results in zero.  With rounding, this produces a
+         * copy of the most significant bit.
+         */
+        tcg_gen_gvec_shri(vece, rd_ofs, rm_ofs, shift - 1, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_ursra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 8) {
+        tcg_gen_vec_shr8i_i64(t, a, 7);
+    } else {
+        gen_urshr8_i64(t, a, sh);
+    }
+    tcg_gen_vec_add8_i64(d, d, t);
+}
+
+static void gen_ursra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 16) {
+        tcg_gen_vec_shr16i_i64(t, a, 15);
+    } else {
+        gen_urshr16_i64(t, a, sh);
+    }
+    tcg_gen_vec_add16_i64(d, d, t);
+}
+
+static void gen_ursra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    if (sh == 32) {
+        tcg_gen_shri_i32(t, a, 31);
+    } else {
+        gen_urshr32_i32(t, a, sh);
+    }
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_ursra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    if (sh == 64) {
+        tcg_gen_shri_i64(t, a, 63);
+    } else {
+        gen_urshr64_i64(t, a, sh);
+    }
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_ursra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    if (sh == (8 << vece)) {
+        tcg_gen_shri_vec(vece, t, a, sh - 1);
+    } else {
+        gen_urshr_vec(vece, t, a, sh);
+    }
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_shri_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen2i ops[4] = {
+        { .fni8 = gen_ursra8_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_ursra16_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_ursra32_i32,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_ursra64_i64,
+          .fniv = gen_ursra_vec,
+          .fno = gen_helper_gvec_ursra_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize] */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+}
+
+static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_8, 0xff >> shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff >> shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_shr32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_deposit_i32(d, d, a, 0, 32 - shift);
+}
+
+static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_deposit_i64(d, d, a, 0, 64 - shift);
+}
+
+static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
+    tcg_gen_shri_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+}
+
+void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shr8_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shr16_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shr32_ins_i32,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shr64_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /* Shift of esize leaves destination unchanged. */
+    if (shift < (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
+
+static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_8, 0xff << shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff << shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+}
+
+static void gen_shl32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_deposit_i32(d, d, a, shift, 32 - shift);
+}
+
+static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_deposit_i64(d, d, a, shift, 64 - shift);
+}
+
+static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_shli_vec(vece, t, a, sh);
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+}
+
+void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shl8_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shl16_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shl32_ins_i32,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shl64_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+
+    /* tszimm encoding produces immediates in the range [0..esize-1]. */
+    tcg_debug_assert(shift >= 0);
+    tcg_debug_assert(shift < (8 << vece));
+
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, rd_ofs, rm_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
+
+static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_add_u8(d, d, a);
+}
+
+static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_sub_u8(d, d, a);
+}
+
+static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_add_u16(d, d, a);
+}
+
+static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_sub_u16(d, d, a);
+}
+
+static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_sub_i32(d, d, a);
+}
+
+static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_sub_i64(d, d, a);
+}
+
+static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_sub_vec(vece, d, d, a);
+}
+
+/* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
+ * these tables are shared with AArch64 which does support them.
+ */
+void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mla8_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mla16_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mla32_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mla64_i64,
+          .fniv = gen_mla_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mls8_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mls16_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mls32_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mls64_i64,
+          .fniv = gen_mls_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+/* CMTST : test is "if (X & Y != 0)". */
+static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_and_i32(d, a, b);
+    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_and_vec(vece, d, a, b);
+    tcg_gen_dupi_vec(vece, a, 0);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
+}
+
+void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_cmp_vec, 0 };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_helper_neon_tst_u8,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_tst_u16,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_cmtst_i32,
+          .fniv = gen_cmtst_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_cmtst_i64,
+          .fniv = gen_cmtst_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+void gen_ushl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_constant_i32(0);
+    TCGv_i32 max = tcg_constant_i32(32);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, shift);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, src, lsh);
+    tcg_gen_shr_i32(rval, src, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LTU, dst, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LTU, dst, rsh, max, rval, dst);
+}
+
+void gen_ushl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 max = tcg_constant_i64(64);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, shift);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, src, lsh);
+    tcg_gen_shr_i64(rval, src, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LTU, dst, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LTU, dst, rsh, max, rval, dst);
+}
+
+static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
+                         TCGv_vec src, TCGv_vec shift)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec msk, max;
+
+    tcg_gen_neg_vec(vece, rsh, shift);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, shift);
+    } else {
+        msk = tcg_temp_new_vec_matching(dst);
+        tcg_gen_dupi_vec(vece, msk, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, msk);
+        tcg_gen_and_vec(vece, rsh, rsh, msk);
+    }
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_shlv_vec(vece, lval, src, lsh);
+    tcg_gen_shrv_vec(vece, rval, src, rsh);
+
+    max = tcg_temp_new_vec_matching(dst);
+    tcg_gen_dupi_vec(vece, max, 8 << vece);
+
+    /*
+     * The choice of LT (signed) and GEU (unsigned) are biased toward
+     * the instructions of the x86_64 host.  For MO_8, the whole byte
+     * is significant so we must use an unsigned compare; otherwise we
+     * have already masked to a byte and so a signed compare works.
+     * Other tcg hosts have a full set of comparisons and do not care.
+     */
+    if (vece == MO_8) {
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
+        tcg_gen_andc_vec(vece, lval, lval, lsh);
+        tcg_gen_andc_vec(vece, rval, rval, rsh);
+    } else {
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
+        tcg_gen_and_vec(vece, lval, lval, lsh);
+        tcg_gen_and_vec(vece, rval, rval, rsh);
+    }
+    tcg_gen_or_vec(vece, dst, lval, rval);
+}
+
+void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_neg_vec, INDEX_op_shlv_vec,
+        INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_ushl_vec,
+          .fno = gen_helper_gvec_ushl_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_ushl_vec,
+          .fno = gen_helper_gvec_ushl_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_ushl_i32,
+          .fniv = gen_ushl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_ushl_i64,
+          .fniv = gen_ushl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+void gen_sshl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
+{
+    TCGv_i32 lval = tcg_temp_new_i32();
+    TCGv_i32 rval = tcg_temp_new_i32();
+    TCGv_i32 lsh = tcg_temp_new_i32();
+    TCGv_i32 rsh = tcg_temp_new_i32();
+    TCGv_i32 zero = tcg_constant_i32(0);
+    TCGv_i32 max = tcg_constant_i32(31);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i32(lsh, shift);
+    tcg_gen_neg_i32(rsh, lsh);
+    tcg_gen_shl_i32(lval, src, lsh);
+    tcg_gen_umin_i32(rsh, rsh, max);
+    tcg_gen_sar_i32(rval, src, rsh);
+    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i32(TCG_COND_LT, dst, lsh, zero, rval, lval);
+}
+
+void gen_sshl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
+{
+    TCGv_i64 lval = tcg_temp_new_i64();
+    TCGv_i64 rval = tcg_temp_new_i64();
+    TCGv_i64 lsh = tcg_temp_new_i64();
+    TCGv_i64 rsh = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 max = tcg_constant_i64(63);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_ext8s_i64(lsh, shift);
+    tcg_gen_neg_i64(rsh, lsh);
+    tcg_gen_shl_i64(lval, src, lsh);
+    tcg_gen_umin_i64(rsh, rsh, max);
+    tcg_gen_sar_i64(rval, src, rsh);
+    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
+    tcg_gen_movcond_i64(TCG_COND_LT, dst, lsh, zero, rval, lval);
+}
+
+static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
+                         TCGv_vec src, TCGv_vec shift)
+{
+    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
+    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
+    TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
+
+    /*
+     * Rely on the TCG guarantee that out of range shifts produce
+     * unspecified results, not undefined behaviour (i.e. no trap).
+     * Discard out-of-range results after the fact.
+     */
+    tcg_gen_neg_vec(vece, rsh, shift);
+    if (vece == MO_8) {
+        tcg_gen_mov_vec(lsh, shift);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0xff);
+        tcg_gen_and_vec(vece, lsh, shift, tmp);
+        tcg_gen_and_vec(vece, rsh, rsh, tmp);
+    }
+
+    /* Bound rsh so out of bound right shift gets -1.  */
+    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
+    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
+    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
+
+    tcg_gen_shlv_vec(vece, lval, src, lsh);
+    tcg_gen_sarv_vec(vece, rval, src, rsh);
+
+    /* Select in-bound left shift.  */
+    tcg_gen_andc_vec(vece, lval, lval, tmp);
+
+    /* Select between left and right shift.  */
+    if (vece == MO_8) {
+        tcg_gen_dupi_vec(vece, tmp, 0);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, rval, lval);
+    } else {
+        tcg_gen_dupi_vec(vece, tmp, 0x80);
+        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, lval, rval);
+    }
+}
+
+void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
+        INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_sshl_vec,
+          .fno = gen_helper_gvec_sshl_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_sshl_vec,
+          .fno = gen_helper_gvec_sshl_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_sshl_i32,
+          .fniv = gen_sshl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_sshl_i64,
+          .fniv = gen_sshl_vec,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_add_vec(vece, x, a, b);
+    tcg_gen_usadd_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_b,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_h,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_s,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_d,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_add_vec(vece, x, a, b);
+    tcg_gen_ssadd_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_sub_vec(vece, x, a, b);
+    tcg_gen_ussub_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_sub_vec(vece, x, a, b);
+    tcg_gen_sssub_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_sabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, a, b, d, t);
+}
+
+static void gen_sabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, a, b, d, t);
+}
+
+static void gen_sabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_smin_vec(vece, t, a, b);
+    tcg_gen_smax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_sabd_i32,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_sabd_i64,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, d, t);
+}
+
+static void gen_uabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, d, t);
+}
+
+static void gen_uabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_umin_vec(vece, t, a, b);
+    tcg_gen_umax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+}
+
+void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_umin_vec, INDEX_op_umax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uabd_i32,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_uabd_i64,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_saba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    gen_sabd_i32(t, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_saba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_sabd_i64(t, a, b);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_saba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    gen_sabd_vec(vece, t, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_add_vec,
+        INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_saba_i32,
+          .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_saba_i64,
+          .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uaba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    gen_uabd_i32(t, a, b);
+    tcg_gen_add_i32(d, d, t);
+}
+
+static void gen_uaba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_uabd_i64(t, a, b);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_uaba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    gen_uabd_vec(vece, t, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+}
+
+void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_add_vec,
+        INDEX_op_umin_vec, INDEX_op_umax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_uaba_i32,
+          .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_uaba_i64,
+          .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index adefa737c9..ddc9baeafb 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1659,1636 +1659,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
-                            uint32_t opr_sz, uint32_t max_sz,
-                            gen_helper_gvec_3_ptr *fn)
-{
-    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(qc_ptr, cpu_env, offsetof(CPUARMState, vfp.qc));
-    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, qc_ptr,
-                       opr_sz, max_sz, 0, fn);
-}
-
-void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static gen_helper_gvec_3_ptr * const fns[2] = {
-        gen_helper_gvec_qrdmlah_s16, gen_helper_gvec_qrdmlah_s32
-    };
-    tcg_debug_assert(vece >= 1 && vece <= 2);
-    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
-}
-
-void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                          uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static gen_helper_gvec_3_ptr * const fns[2] = {
-        gen_helper_gvec_qrdmlsh_s16, gen_helper_gvec_qrdmlsh_s32
-    };
-    tcg_debug_assert(vece >= 1 && vece <= 2);
-    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
-}
-
-#define GEN_CMP0(NAME, COND)                                            \
-    static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
-    {                                                                   \
-        tcg_gen_setcondi_i32(COND, d, a, 0);                            \
-        tcg_gen_neg_i32(d, d);                                          \
-    }                                                                   \
-    static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
-    {                                                                   \
-        tcg_gen_setcondi_i64(COND, d, a, 0);                            \
-        tcg_gen_neg_i64(d, d);                                          \
-    }                                                                   \
-    static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
-    {                                                                   \
-        TCGv_vec zero = tcg_constant_vec_matching(d, vece, 0);          \
-        tcg_gen_cmp_vec(COND, vece, d, a, zero);                        \
-    }                                                                   \
-    void gen_gvec_##NAME##0(unsigned vece, uint32_t d, uint32_t m,      \
-                            uint32_t opr_sz, uint32_t max_sz)           \
-    {                                                                   \
-        const GVecGen2 op[4] = {                                        \
-            { .fno = gen_helper_gvec_##NAME##0_b,                       \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_8 },                                           \
-            { .fno = gen_helper_gvec_##NAME##0_h,                       \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_16 },                                          \
-            { .fni4 = gen_##NAME##0_i32,                                \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_32 },                                          \
-            { .fni8 = gen_##NAME##0_i64,                                \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .prefer_i64 = TCG_TARGET_REG_BITS == 64,                  \
-              .vece = MO_64 },                                          \
-        };                                                              \
-        tcg_gen_gvec_2(d, m, opr_sz, max_sz, &op[vece]);                \
-    }
-
-static const TCGOpcode vecop_list_cmp[] = {
-    INDEX_op_cmp_vec, 0
-};
-
-GEN_CMP0(ceq, TCG_COND_EQ)
-GEN_CMP0(cle, TCG_COND_LE)
-GEN_CMP0(cge, TCG_COND_GE)
-GEN_CMP0(clt, TCG_COND_LT)
-GEN_CMP0(cgt, TCG_COND_GT)
-
-#undef GEN_CMP0
-
-static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_sar8i_i64(a, a, shift);
-    tcg_gen_vec_add8_i64(d, d, a);
-}
-
-static void gen_ssra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_sar16i_i64(a, a, shift);
-    tcg_gen_vec_add16_i64(d, d, a);
-}
-
-static void gen_ssra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_sari_i32(a, a, shift);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_ssra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_sari_i64(a, a, shift);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    tcg_gen_sari_vec(vece, a, a, sh);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
-void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sari_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_ssra8_i64,
-          .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_b,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni8 = gen_ssra16_i64,
-          .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_h,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_ssra32_i32,
-          .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_s,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_ssra64_i64,
-          .fniv = gen_ssra_vec,
-          .fno = gen_helper_gvec_ssra_b,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize]. */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    /*
-     * Shifts larger than the element size are architecturally valid.
-     * Signed results in all sign bits.
-     */
-    shift = MIN(shift, (8 << vece) - 1);
-    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-}
-
-static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_shr8i_i64(a, a, shift);
-    tcg_gen_vec_add8_i64(d, d, a);
-}
-
-static void gen_usra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_shr16i_i64(a, a, shift);
-    tcg_gen_vec_add16_i64(d, d, a);
-}
-
-static void gen_usra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_shri_i32(a, a, shift);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_usra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_shri_i64(a, a, shift);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    tcg_gen_shri_vec(vece, a, a, sh);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
-void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_shri_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_usra8_i64,
-          .fniv = gen_usra_vec,
-          .fno = gen_helper_gvec_usra_b,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8, },
-        { .fni8 = gen_usra16_i64,
-          .fniv = gen_usra_vec,
-          .fno = gen_helper_gvec_usra_h,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16, },
-        { .fni4 = gen_usra32_i32,
-          .fniv = gen_usra_vec,
-          .fno = gen_helper_gvec_usra_s,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32, },
-        { .fni8 = gen_usra64_i64,
-          .fniv = gen_usra_vec,
-          .fno = gen_helper_gvec_usra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64, },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize]. */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    /*
-     * Shifts larger than the element size are architecturally valid.
-     * Unsigned results in all zeros as input to accumulate: nop.
-     */
-    if (shift < (8 << vece)) {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    } else {
-        /* Nop, but we do need to clear the tail. */
-        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
-    }
-}
-
-/*
- * Shift one less than the requested amount, and the low bit is
- * the rounding bit.  For the 8 and 16-bit operations, because we
- * mask the low bit, we can perform a normal integer shift instead
- * of a vector shift.
- */
-static void gen_srshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, sh - 1);
-    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
-    tcg_gen_vec_sar8i_i64(d, a, sh);
-    tcg_gen_vec_add8_i64(d, d, t);
-}
-
-static void gen_srshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, sh - 1);
-    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
-    tcg_gen_vec_sar16i_i64(d, a, sh);
-    tcg_gen_vec_add16_i64(d, d, t);
-}
-
-void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
-{
-    TCGv_i32 t;
-
-    /* Handle shift by the input size for the benefit of trans_SRSHR_ri */
-    if (sh == 32) {
-        tcg_gen_movi_i32(d, 0);
-        return;
-    }
-    t = tcg_temp_new_i32();
-    tcg_gen_extract_i32(t, a, sh - 1, 1);
-    tcg_gen_sari_i32(d, a, sh);
-    tcg_gen_add_i32(d, d, t);
-}
-
-void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_extract_i64(t, a, sh - 1, 1);
-    tcg_gen_sari_i64(d, a, sh);
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_shri_vec(vece, t, a, sh - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
-    tcg_gen_and_vec(vece, t, t, ones);
-    tcg_gen_sari_vec(vece, d, a, sh);
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_srshr8_i64,
-          .fniv = gen_srshr_vec,
-          .fno = gen_helper_gvec_srshr_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni8 = gen_srshr16_i64,
-          .fniv = gen_srshr_vec,
-          .fno = gen_helper_gvec_srshr_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_srshr32_i32,
-          .fniv = gen_srshr_vec,
-          .fno = gen_helper_gvec_srshr_s,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_srshr64_i64,
-          .fniv = gen_srshr_vec,
-          .fno = gen_helper_gvec_srshr_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize] */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    if (shift == (8 << vece)) {
-        /*
-         * Shifts larger than the element size are architecturally valid.
-         * Signed results in all sign bits.  With rounding, this produces
-         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
-         * I.e. always zero.
-         */
-        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
-    } else {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    }
-}
-
-static void gen_srsra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    gen_srshr8_i64(t, a, sh);
-    tcg_gen_vec_add8_i64(d, d, t);
-}
-
-static void gen_srsra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    gen_srshr16_i64(t, a, sh);
-    tcg_gen_vec_add16_i64(d, d, t);
-}
-
-static void gen_srsra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    gen_srshr32_i32(t, a, sh);
-    tcg_gen_add_i32(d, d, t);
-}
-
-static void gen_srsra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    gen_srshr64_i64(t, a, sh);
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_srsra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-
-    gen_srshr_vec(vece, t, a, sh);
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_srsra8_i64,
-          .fniv = gen_srsra_vec,
-          .fno = gen_helper_gvec_srsra_b,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fni8 = gen_srsra16_i64,
-          .fniv = gen_srsra_vec,
-          .fno = gen_helper_gvec_srsra_h,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_srsra32_i32,
-          .fniv = gen_srsra_vec,
-          .fno = gen_helper_gvec_srsra_s,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_srsra64_i64,
-          .fniv = gen_srsra_vec,
-          .fno = gen_helper_gvec_srsra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize] */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    /*
-     * Shifts larger than the element size are architecturally valid.
-     * Signed results in all sign bits.  With rounding, this produces
-     *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
-     * I.e. always zero.  With accumulation, this leaves D unchanged.
-     */
-    if (shift == (8 << vece)) {
-        /* Nop, but we do need to clear the tail. */
-        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
-    } else {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    }
-}
-
-static void gen_urshr8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, sh - 1);
-    tcg_gen_andi_i64(t, t, dup_const(MO_8, 1));
-    tcg_gen_vec_shr8i_i64(d, a, sh);
-    tcg_gen_vec_add8_i64(d, d, t);
-}
-
-static void gen_urshr16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, sh - 1);
-    tcg_gen_andi_i64(t, t, dup_const(MO_16, 1));
-    tcg_gen_vec_shr16i_i64(d, a, sh);
-    tcg_gen_vec_add16_i64(d, d, t);
-}
-
-void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
-{
-    TCGv_i32 t;
-
-    /* Handle shift by the input size for the benefit of trans_URSHR_ri */
-    if (sh == 32) {
-        tcg_gen_extract_i32(d, a, sh - 1, 1);
-        return;
-    }
-    t = tcg_temp_new_i32();
-    tcg_gen_extract_i32(t, a, sh - 1, 1);
-    tcg_gen_shri_i32(d, a, sh);
-    tcg_gen_add_i32(d, d, t);
-}
-
-void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_extract_i64(t, a, sh - 1, 1);
-    tcg_gen_shri_i64(d, a, sh);
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_urshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t shift)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec ones = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_shri_vec(vece, t, a, shift - 1);
-    tcg_gen_dupi_vec(vece, ones, 1);
-    tcg_gen_and_vec(vece, t, t, ones);
-    tcg_gen_shri_vec(vece, d, a, shift);
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_shri_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_urshr8_i64,
-          .fniv = gen_urshr_vec,
-          .fno = gen_helper_gvec_urshr_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni8 = gen_urshr16_i64,
-          .fniv = gen_urshr_vec,
-          .fno = gen_helper_gvec_urshr_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_urshr32_i32,
-          .fniv = gen_urshr_vec,
-          .fno = gen_helper_gvec_urshr_s,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_urshr64_i64,
-          .fniv = gen_urshr_vec,
-          .fno = gen_helper_gvec_urshr_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize] */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    if (shift == (8 << vece)) {
-        /*
-         * Shifts larger than the element size are architecturally valid.
-         * Unsigned results in zero.  With rounding, this produces a
-         * copy of the most significant bit.
-         */
-        tcg_gen_gvec_shri(vece, rd_ofs, rm_ofs, shift - 1, opr_sz, max_sz);
-    } else {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    }
-}
-
-static void gen_ursra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    if (sh == 8) {
-        tcg_gen_vec_shr8i_i64(t, a, 7);
-    } else {
-        gen_urshr8_i64(t, a, sh);
-    }
-    tcg_gen_vec_add8_i64(d, d, t);
-}
-
-static void gen_ursra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    if (sh == 16) {
-        tcg_gen_vec_shr16i_i64(t, a, 15);
-    } else {
-        gen_urshr16_i64(t, a, sh);
-    }
-    tcg_gen_vec_add16_i64(d, d, t);
-}
-
-static void gen_ursra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    if (sh == 32) {
-        tcg_gen_shri_i32(t, a, 31);
-    } else {
-        gen_urshr32_i32(t, a, sh);
-    }
-    tcg_gen_add_i32(d, d, t);
-}
-
-static void gen_ursra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    if (sh == 64) {
-        tcg_gen_shri_i64(t, a, 63);
-    } else {
-        gen_urshr64_i64(t, a, sh);
-    }
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_ursra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-
-    if (sh == (8 << vece)) {
-        tcg_gen_shri_vec(vece, t, a, sh - 1);
-    } else {
-        gen_urshr_vec(vece, t, a, sh);
-    }
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_shri_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen2i ops[4] = {
-        { .fni8 = gen_ursra8_i64,
-          .fniv = gen_ursra_vec,
-          .fno = gen_helper_gvec_ursra_b,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fni8 = gen_ursra16_i64,
-          .fniv = gen_ursra_vec,
-          .fno = gen_helper_gvec_ursra_h,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_ursra32_i32,
-          .fniv = gen_ursra_vec,
-          .fno = gen_helper_gvec_ursra_s,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_ursra64_i64,
-          .fniv = gen_ursra_vec,
-          .fno = gen_helper_gvec_ursra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize] */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-}
-
-static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_8, 0xff >> shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_16, 0xffff >> shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_shr32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_shri_i32(a, a, shift);
-    tcg_gen_deposit_i32(d, d, a, 0, 32 - shift);
-}
-
-static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_shri_i64(a, a, shift);
-    tcg_gen_deposit_i64(d, d, a, 0, 64 - shift);
-}
-
-static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
-    tcg_gen_shri_vec(vece, t, a, sh);
-    tcg_gen_and_vec(vece, d, d, m);
-    tcg_gen_or_vec(vece, d, d, t);
-}
-
-void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
-    const GVecGen2i ops[4] = {
-        { .fni8 = gen_shr8_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .fno = gen_helper_gvec_sri_b,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni8 = gen_shr16_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .fno = gen_helper_gvec_sri_h,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_shr32_ins_i32,
-          .fniv = gen_shr_ins_vec,
-          .fno = gen_helper_gvec_sri_s,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_shr64_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .fno = gen_helper_gvec_sri_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [1..esize]. */
-    tcg_debug_assert(shift > 0);
-    tcg_debug_assert(shift <= (8 << vece));
-
-    /* Shift of esize leaves destination unchanged. */
-    if (shift < (8 << vece)) {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    } else {
-        /* Nop, but we do need to clear the tail. */
-        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
-    }
-}
-
-static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_8, 0xff << shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shli_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_16, 0xffff << shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shli_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-}
-
-static void gen_shl32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_deposit_i32(d, d, a, shift, 32 - shift);
-}
-
-static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_deposit_i64(d, d, a, shift, 64 - shift);
-}
-
-static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_shli_vec(vece, t, a, sh);
-    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
-    tcg_gen_and_vec(vece, d, d, m);
-    tcg_gen_or_vec(vece, d, d, t);
-}
-
-void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
-    const GVecGen2i ops[4] = {
-        { .fni8 = gen_shl8_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .fno = gen_helper_gvec_sli_b,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni8 = gen_shl16_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .fno = gen_helper_gvec_sli_h,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_shl32_ins_i32,
-          .fniv = gen_shl_ins_vec,
-          .fno = gen_helper_gvec_sli_s,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_shl64_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .fno = gen_helper_gvec_sli_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-
-    /* tszimm encoding produces immediates in the range [0..esize-1]. */
-    tcg_debug_assert(shift >= 0);
-    tcg_debug_assert(shift < (8 << vece));
-
-    if (shift == 0) {
-        tcg_gen_gvec_mov(vece, rd_ofs, rm_ofs, opr_sz, max_sz);
-    } else {
-        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
-    }
-}
-
-static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u8(a, a, b);
-    gen_helper_neon_add_u8(d, d, a);
-}
-
-static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u8(a, a, b);
-    gen_helper_neon_sub_u8(d, d, a);
-}
-
-static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u16(a, a, b);
-    gen_helper_neon_add_u16(d, d, a);
-}
-
-static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u16(a, a, b);
-    gen_helper_neon_sub_u16(d, d, a);
-}
-
-static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_mul_i32(a, a, b);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_mul_i32(a, a, b);
-    tcg_gen_sub_i32(d, d, a);
-}
-
-static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mul_i64(a, a, b);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mul_i64(a, a, b);
-    tcg_gen_sub_i64(d, d, a);
-}
-
-static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_mul_vec(vece, a, a, b);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
-static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_mul_vec(vece, a, a, b);
-    tcg_gen_sub_vec(vece, d, d, a);
-}
-
-/* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
- * these tables are shared with AArch64 which does support them.
- */
-void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_mul_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fni4 = gen_mla8_i32,
-          .fniv = gen_mla_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni4 = gen_mla16_i32,
-          .fniv = gen_mla_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_mla32_i32,
-          .fniv = gen_mla_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_mla64_i64,
-          .fniv = gen_mla_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_mul_vec, INDEX_op_sub_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fni4 = gen_mls8_i32,
-          .fniv = gen_mls_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni4 = gen_mls16_i32,
-          .fniv = gen_mls_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_mls32_i32,
-          .fniv = gen_mls_vec,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_mls64_i64,
-          .fniv = gen_mls_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-/* CMTST : test is "if (X & Y != 0)". */
-static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_and_i32(d, a, b);
-    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_and_i64(d, a, b);
-    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_and_vec(vece, d, a, b);
-    tcg_gen_dupi_vec(vece, a, 0);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
-}
-
-void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = { INDEX_op_cmp_vec, 0 };
-    static const GVecGen3 ops[4] = {
-        { .fni4 = gen_helper_neon_tst_u8,
-          .fniv = gen_cmtst_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fni4 = gen_helper_neon_tst_u16,
-          .fniv = gen_cmtst_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_cmtst_i32,
-          .fniv = gen_cmtst_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_cmtst_i64,
-          .fniv = gen_cmtst_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-void gen_ushl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
-{
-    TCGv_i32 lval = tcg_temp_new_i32();
-    TCGv_i32 rval = tcg_temp_new_i32();
-    TCGv_i32 lsh = tcg_temp_new_i32();
-    TCGv_i32 rsh = tcg_temp_new_i32();
-    TCGv_i32 zero = tcg_constant_i32(0);
-    TCGv_i32 max = tcg_constant_i32(32);
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_ext8s_i32(lsh, shift);
-    tcg_gen_neg_i32(rsh, lsh);
-    tcg_gen_shl_i32(lval, src, lsh);
-    tcg_gen_shr_i32(rval, src, rsh);
-    tcg_gen_movcond_i32(TCG_COND_LTU, dst, lsh, max, lval, zero);
-    tcg_gen_movcond_i32(TCG_COND_LTU, dst, rsh, max, rval, dst);
-}
-
-void gen_ushl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
-{
-    TCGv_i64 lval = tcg_temp_new_i64();
-    TCGv_i64 rval = tcg_temp_new_i64();
-    TCGv_i64 lsh = tcg_temp_new_i64();
-    TCGv_i64 rsh = tcg_temp_new_i64();
-    TCGv_i64 zero = tcg_constant_i64(0);
-    TCGv_i64 max = tcg_constant_i64(64);
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_ext8s_i64(lsh, shift);
-    tcg_gen_neg_i64(rsh, lsh);
-    tcg_gen_shl_i64(lval, src, lsh);
-    tcg_gen_shr_i64(rval, src, rsh);
-    tcg_gen_movcond_i64(TCG_COND_LTU, dst, lsh, max, lval, zero);
-    tcg_gen_movcond_i64(TCG_COND_LTU, dst, rsh, max, rval, dst);
-}
-
-static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
-                         TCGv_vec src, TCGv_vec shift)
-{
-    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
-    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
-    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec msk, max;
-
-    tcg_gen_neg_vec(vece, rsh, shift);
-    if (vece == MO_8) {
-        tcg_gen_mov_vec(lsh, shift);
-    } else {
-        msk = tcg_temp_new_vec_matching(dst);
-        tcg_gen_dupi_vec(vece, msk, 0xff);
-        tcg_gen_and_vec(vece, lsh, shift, msk);
-        tcg_gen_and_vec(vece, rsh, rsh, msk);
-    }
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_shlv_vec(vece, lval, src, lsh);
-    tcg_gen_shrv_vec(vece, rval, src, rsh);
-
-    max = tcg_temp_new_vec_matching(dst);
-    tcg_gen_dupi_vec(vece, max, 8 << vece);
-
-    /*
-     * The choice of LT (signed) and GEU (unsigned) are biased toward
-     * the instructions of the x86_64 host.  For MO_8, the whole byte
-     * is significant so we must use an unsigned compare; otherwise we
-     * have already masked to a byte and so a signed compare works.
-     * Other tcg hosts have a full set of comparisons and do not care.
-     */
-    if (vece == MO_8) {
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
-        tcg_gen_andc_vec(vece, lval, lval, lsh);
-        tcg_gen_andc_vec(vece, rval, rval, rsh);
-    } else {
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
-        tcg_gen_and_vec(vece, lval, lval, lsh);
-        tcg_gen_and_vec(vece, rval, rval, rsh);
-    }
-    tcg_gen_or_vec(vece, dst, lval, rval);
-}
-
-void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_neg_vec, INDEX_op_shlv_vec,
-        INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_ushl_vec,
-          .fno = gen_helper_gvec_ushl_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fniv = gen_ushl_vec,
-          .fno = gen_helper_gvec_ushl_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_ushl_i32,
-          .fniv = gen_ushl_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_ushl_i64,
-          .fniv = gen_ushl_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-void gen_sshl_i32(TCGv_i32 dst, TCGv_i32 src, TCGv_i32 shift)
-{
-    TCGv_i32 lval = tcg_temp_new_i32();
-    TCGv_i32 rval = tcg_temp_new_i32();
-    TCGv_i32 lsh = tcg_temp_new_i32();
-    TCGv_i32 rsh = tcg_temp_new_i32();
-    TCGv_i32 zero = tcg_constant_i32(0);
-    TCGv_i32 max = tcg_constant_i32(31);
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_ext8s_i32(lsh, shift);
-    tcg_gen_neg_i32(rsh, lsh);
-    tcg_gen_shl_i32(lval, src, lsh);
-    tcg_gen_umin_i32(rsh, rsh, max);
-    tcg_gen_sar_i32(rval, src, rsh);
-    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
-    tcg_gen_movcond_i32(TCG_COND_LT, dst, lsh, zero, rval, lval);
-}
-
-void gen_sshl_i64(TCGv_i64 dst, TCGv_i64 src, TCGv_i64 shift)
-{
-    TCGv_i64 lval = tcg_temp_new_i64();
-    TCGv_i64 rval = tcg_temp_new_i64();
-    TCGv_i64 lsh = tcg_temp_new_i64();
-    TCGv_i64 rsh = tcg_temp_new_i64();
-    TCGv_i64 zero = tcg_constant_i64(0);
-    TCGv_i64 max = tcg_constant_i64(63);
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_ext8s_i64(lsh, shift);
-    tcg_gen_neg_i64(rsh, lsh);
-    tcg_gen_shl_i64(lval, src, lsh);
-    tcg_gen_umin_i64(rsh, rsh, max);
-    tcg_gen_sar_i64(rval, src, rsh);
-    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
-    tcg_gen_movcond_i64(TCG_COND_LT, dst, lsh, zero, rval, lval);
-}
-
-static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
-                         TCGv_vec src, TCGv_vec shift)
-{
-    TCGv_vec lval = tcg_temp_new_vec_matching(dst);
-    TCGv_vec rval = tcg_temp_new_vec_matching(dst);
-    TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
-
-    /*
-     * Rely on the TCG guarantee that out of range shifts produce
-     * unspecified results, not undefined behaviour (i.e. no trap).
-     * Discard out-of-range results after the fact.
-     */
-    tcg_gen_neg_vec(vece, rsh, shift);
-    if (vece == MO_8) {
-        tcg_gen_mov_vec(lsh, shift);
-    } else {
-        tcg_gen_dupi_vec(vece, tmp, 0xff);
-        tcg_gen_and_vec(vece, lsh, shift, tmp);
-        tcg_gen_and_vec(vece, rsh, rsh, tmp);
-    }
-
-    /* Bound rsh so out of bound right shift gets -1.  */
-    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
-    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
-
-    tcg_gen_shlv_vec(vece, lval, src, lsh);
-    tcg_gen_sarv_vec(vece, rval, src, rsh);
-
-    /* Select in-bound left shift.  */
-    tcg_gen_andc_vec(vece, lval, lval, tmp);
-
-    /* Select between left and right shift.  */
-    if (vece == MO_8) {
-        tcg_gen_dupi_vec(vece, tmp, 0);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, rval, lval);
-    } else {
-        tcg_gen_dupi_vec(vece, tmp, 0x80);
-        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, tmp, lval, rval);
-    }
-}
-
-void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
-        INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_sshl_vec,
-          .fno = gen_helper_gvec_sshl_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fniv = gen_sshl_vec,
-          .fno = gen_helper_gvec_sshl_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_sshl_i32,
-          .fniv = gen_sshl_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_sshl_i64,
-          .fniv = gen_sshl_vec,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
-                          TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec x = tcg_temp_new_vec_matching(t);
-    tcg_gen_add_vec(vece, x, a, b);
-    tcg_gen_usadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
-}
-
-void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen4 ops[4] = {
-        { .fniv = gen_uqadd_vec,
-          .fno = gen_helper_gvec_uqadd_b,
-          .write_aofs = true,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fniv = gen_uqadd_vec,
-          .fno = gen_helper_gvec_uqadd_h,
-          .write_aofs = true,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fniv = gen_uqadd_vec,
-          .fno = gen_helper_gvec_uqadd_s,
-          .write_aofs = true,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fniv = gen_uqadd_vec,
-          .fno = gen_helper_gvec_uqadd_d,
-          .write_aofs = true,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
-                          TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec x = tcg_temp_new_vec_matching(t);
-    tcg_gen_add_vec(vece, x, a, b);
-    tcg_gen_ssadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
-}
-
-void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-    };
-    static const GVecGen4 ops[4] = {
-        { .fniv = gen_sqadd_vec,
-          .fno = gen_helper_gvec_sqadd_b,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_8 },
-        { .fniv = gen_sqadd_vec,
-          .fno = gen_helper_gvec_sqadd_h,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_16 },
-        { .fniv = gen_sqadd_vec,
-          .fno = gen_helper_gvec_sqadd_s,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_32 },
-        { .fniv = gen_sqadd_vec,
-          .fno = gen_helper_gvec_sqadd_d,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
-                          TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec x = tcg_temp_new_vec_matching(t);
-    tcg_gen_sub_vec(vece, x, a, b);
-    tcg_gen_ussub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
-}
-
-void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-    };
-    static const GVecGen4 ops[4] = {
-        { .fniv = gen_uqsub_vec,
-          .fno = gen_helper_gvec_uqsub_b,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_8 },
-        { .fniv = gen_uqsub_vec,
-          .fno = gen_helper_gvec_uqsub_h,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_16 },
-        { .fniv = gen_uqsub_vec,
-          .fno = gen_helper_gvec_uqsub_s,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_32 },
-        { .fniv = gen_uqsub_vec,
-          .fno = gen_helper_gvec_uqsub_d,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
-                          TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec x = tcg_temp_new_vec_matching(t);
-    tcg_gen_sub_vec(vece, x, a, b);
-    tcg_gen_sssub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
-}
-
-void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-    };
-    static const GVecGen4 ops[4] = {
-        { .fniv = gen_sqsub_vec,
-          .fno = gen_helper_gvec_sqsub_b,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_8 },
-        { .fniv = gen_sqsub_vec,
-          .fno = gen_helper_gvec_sqsub_h,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_16 },
-        { .fniv = gen_sqsub_vec,
-          .fno = gen_helper_gvec_sqsub_s,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_32 },
-        { .fniv = gen_sqsub_vec,
-          .fno = gen_helper_gvec_sqsub_d,
-          .opt_opc = vecop_list,
-          .write_aofs = true,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_sabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_sub_i32(d, b, a);
-    tcg_gen_movcond_i32(TCG_COND_LT, d, a, b, d, t);
-}
-
-static void gen_sabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_sub_i64(d, b, a);
-    tcg_gen_movcond_i64(TCG_COND_LT, d, a, b, d, t);
-}
-
-static void gen_sabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_smin_vec(vece, t, a, b);
-    tcg_gen_smax_vec(vece, d, a, b);
-    tcg_gen_sub_vec(vece, d, d, t);
-}
-
-void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sub_vec, INDEX_op_smin_vec, INDEX_op_smax_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_sabd_vec,
-          .fno = gen_helper_gvec_sabd_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fniv = gen_sabd_vec,
-          .fno = gen_helper_gvec_sabd_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_sabd_i32,
-          .fniv = gen_sabd_vec,
-          .fno = gen_helper_gvec_sabd_s,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_sabd_i64,
-          .fniv = gen_sabd_vec,
-          .fno = gen_helper_gvec_sabd_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_uabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_sub_i32(d, b, a);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, d, t);
-}
-
-static void gen_uabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_sub_i64(d, b, a);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, d, t);
-}
-
-static void gen_uabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_umin_vec(vece, t, a, b);
-    tcg_gen_umax_vec(vece, d, a, b);
-    tcg_gen_sub_vec(vece, d, d, t);
-}
-
-void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sub_vec, INDEX_op_umin_vec, INDEX_op_umax_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_uabd_vec,
-          .fno = gen_helper_gvec_uabd_b,
-          .opt_opc = vecop_list,
-          .vece = MO_8 },
-        { .fniv = gen_uabd_vec,
-          .fno = gen_helper_gvec_uabd_h,
-          .opt_opc = vecop_list,
-          .vece = MO_16 },
-        { .fni4 = gen_uabd_i32,
-          .fniv = gen_uabd_vec,
-          .fno = gen_helper_gvec_uabd_s,
-          .opt_opc = vecop_list,
-          .vece = MO_32 },
-        { .fni8 = gen_uabd_i64,
-          .fniv = gen_uabd_vec,
-          .fno = gen_helper_gvec_uabd_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_saba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-    gen_sabd_i32(t, a, b);
-    tcg_gen_add_i32(d, d, t);
-}
-
-static void gen_saba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-    gen_sabd_i64(t, a, b);
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_saba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    gen_sabd_vec(vece, t, a, b);
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sub_vec, INDEX_op_add_vec,
-        INDEX_op_smin_vec, INDEX_op_smax_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_saba_vec,
-          .fno = gen_helper_gvec_saba_b,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fniv = gen_saba_vec,
-          .fno = gen_helper_gvec_saba_h,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_saba_i32,
-          .fniv = gen_saba_vec,
-          .fno = gen_helper_gvec_saba_s,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_saba_i64,
-          .fniv = gen_saba_vec,
-          .fno = gen_helper_gvec_saba_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
-static void gen_uaba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_new_i32();
-    gen_uabd_i32(t, a, b);
-    tcg_gen_add_i32(d, d, t);
-}
-
-static void gen_uaba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-    gen_uabd_i64(t, a, b);
-    tcg_gen_add_i64(d, d, t);
-}
-
-static void gen_uaba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    gen_uabd_vec(vece, t, a, b);
-    tcg_gen_add_vec(vece, d, d, t);
-}
-
-void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
-{
-    static const TCGOpcode vecop_list[] = {
-        INDEX_op_sub_vec, INDEX_op_add_vec,
-        INDEX_op_umin_vec, INDEX_op_umax_vec, 0
-    };
-    static const GVecGen3 ops[4] = {
-        { .fniv = gen_uaba_vec,
-          .fno = gen_helper_gvec_uaba_b,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fniv = gen_uaba_vec,
-          .fno = gen_helper_gvec_uaba_h,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_uaba_i32,
-          .fniv = gen_uaba_vec,
-          .fno = gen_helper_gvec_uaba_s,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_uaba_i64,
-          .fniv = gen_uaba_vec,
-          .fno = gen_helper_gvec_uaba_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .opt_opc = vecop_list,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
-}
-
 static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
                            int opc1, int crn, int crm, int opc2,
                            bool isread, int rt, int rt2)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index fca9912a0a..0a9b4be332 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -21,6 +21,7 @@ arm_ss.add(gen)
 arm_ss.add(files(
   'cpu32.c',
   'translate.c',
+  'translate-gvec.c',
   'translate-iwmmxt.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.38.1


