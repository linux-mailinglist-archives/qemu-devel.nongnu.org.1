Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5EB8BC548
	for <lists+qemu-devel@lfdr.de>; Mon,  6 May 2024 03:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmH-0007br-IW; Sun, 05 May 2024 21:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm6-0007aF-Pb
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm0-0002Pp-Tc
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f45f1179c3so619432b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957447; x=1715562247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jb3AxAP081FEipu6aXqpjbraoNzvtui72rWtrD3OSnA=;
 b=gegL7o6AWPbLVEveYqKjbjdRpEqqIZbUa0n68TbK3DlegETP+QupvCwiZCXWSPCBTr
 vTCZmK5jaXClOrycaQ8FoQKTa4ajfkZMHm8tQFOA7l5fF9aGXGNsyD5t1RQpRvY578Mo
 Ca+NMAQVCmVXzxrb3gKew3GPIOf0nusQdo9OzX5szRUUrBDv7EvxtF/tP7tWRv07gD+C
 xrNqsrzJyWxQ+rtLS4rAYu3TFhgPWsn8GtEeCmNsihAIgxIz1oamgtbcuOhLASqu03xL
 VnppvSjX1W7A243ss5yOkYAfmxKIBBl1GjQoi7aw8G9yLx/hx/mrGuNhWaTG7aJ64pLi
 s/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957447; x=1715562247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jb3AxAP081FEipu6aXqpjbraoNzvtui72rWtrD3OSnA=;
 b=ZeVW81Xl53wkv9YGUACA/w81zHogQTobmyuwu6K03WhZXdAOJE/VtGnpAnwHWZBeAu
 TSqsOvUmgo4rux5u3ytrhKeDV5XskDT/PzyqaXxcF45j4vxwDv+c9IvV6lnlI301A+Mw
 zSXMkaUpnzhJEvQ5cUSFeh1v/ahlso+Ae5Kt881Bidg42duAOovC3a5SigCd9N2NkctX
 JpX2j/vCq4GcGe2kLuYsMvhLbbvC2NYQszFay7jz/taZp/Q0XXaTkmwE/dyhgwNG6CfJ
 Itv3lLQM/kVNMFsgXhMke+eEirbqLqLZKjVZSK/wZAoy2mZym+WxdNz1bACxYUpfphay
 lcTA==
X-Gm-Message-State: AOJu0Yzja2cyqyILBCvu6Vrh1l6EjlX7nYVfrYz8w8C/v5W80FjZtTVt
 QGczVv2NHTKPRg9XpODizI7qEMcGtwijNaizl4Sz8JzdifDZ2/Bxe79HOv/OithO5NOSkaG6wcO
 +
X-Google-Smtp-Source: AGHT+IHFEB9xHjM+hEoRFHaGduGAjGyi7HRi04IPlxsFEct9z59F9Qls4IleE28Ej5HLUgwK2EUThg==
X-Received: by 2002:a05:6a21:47c7:b0:1ae:42b1:abb2 with SMTP id
 as7-20020a056a2147c700b001ae42b1abb2mr9800757pzc.2.1714957446529; 
 Sun, 05 May 2024 18:04:06 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/57] target/arm: Split out gengvec.c
Date: Sun,  5 May 2024 18:03:07 -0700
Message-Id: <20240506010403.6204-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h |    5 +
 target/arm/tcg/gengvec.c   | 1612 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate.c | 1588 -----------------------------------
 target/arm/tcg/meson.build |    1 +
 4 files changed, 1618 insertions(+), 1588 deletions(-)
 create mode 100644 target/arm/tcg/gengvec.c

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index dc66ff2190..80e85096a8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -445,6 +445,11 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh);
+void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh);
+void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh);
+void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh);
+
 void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                     int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
new file mode 100644
index 0000000000..7a1856253f
--- /dev/null
+++ b/target/arm/tcg/gengvec.c
@@ -0,0 +1,1612 @@
+/*
+ *  ARM generic vector expansion
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2005-2007 CodeSourcery
+ *  Copyright (c) 2007 OpenedHand, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+
+static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
+                            uint32_t opr_sz, uint32_t max_sz,
+                            gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
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
+#define GEN_CMP0(NAME, COND)                              \
+    void NAME(unsigned vece, uint32_t d, uint32_t m,      \
+              uint32_t opr_sz, uint32_t max_sz)           \
+    { tcg_gen_gvec_cmpi(COND, vece, d, m, 0, opr_sz, max_sz); }
+
+GEN_CMP0(gen_gvec_ceq0, TCG_COND_EQ)
+GEN_CMP0(gen_gvec_cle0, TCG_COND_LE)
+GEN_CMP0(gen_gvec_cge0, TCG_COND_GE)
+GEN_CMP0(gen_gvec_clt0, TCG_COND_LT)
+GEN_CMP0(gen_gvec_cgt0, TCG_COND_GT)
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
+          .fno = gen_helper_gvec_ssra_d,
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
+ void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
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
+    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
+}
+
+void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
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
index dc49a8d806..e5653c6117 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2913,1594 +2913,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
-                            uint32_t opr_sz, uint32_t max_sz,
-                            gen_helper_gvec_3_ptr *fn)
-{
-    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
-
-    tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
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
-#define GEN_CMP0(NAME, COND)                              \
-    void NAME(unsigned vece, uint32_t d, uint32_t m,      \
-              uint32_t opr_sz, uint32_t max_sz)           \
-    { tcg_gen_gvec_cmpi(COND, vece, d, m, 0, opr_sz, max_sz); }
-
-GEN_CMP0(gen_gvec_ceq0, TCG_COND_EQ)
-GEN_CMP0(gen_gvec_cle0, TCG_COND_LE)
-GEN_CMP0(gen_gvec_cge0, TCG_COND_GE)
-GEN_CMP0(gen_gvec_clt0, TCG_COND_LT)
-GEN_CMP0(gen_gvec_cgt0, TCG_COND_GT)
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
-          .fno = gen_helper_gvec_ssra_d,
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
-static void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
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
-static void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
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
-static void gen_urshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
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
-static void gen_urshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
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
-    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
-}
-
-void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_and_i64(d, a, b);
-    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
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
 static bool aa32_cpreg_encoding_in_impdef_space(uint8_t crn, uint8_t crm)
 {
     static const uint16_t mask[3] = {
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3b1a9f0fc5..bdb5c7352f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -24,6 +24,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 
 arm_ss.add(files(
   'cpu32.c',
+  'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.34.1


