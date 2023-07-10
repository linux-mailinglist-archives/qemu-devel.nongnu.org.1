Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A574D595
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5w-0004Bx-A0; Mon, 10 Jul 2023 08:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5V-00034l-7N
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:57 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5T-0004mL-Ah
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:56 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-262e839647eso3365183a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992434; x=1691584434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpEfDyBrVJqDU0QXLq2iInnF0CEU4fJ7tlxiogiIhsU=;
 b=lSJY/oa6N9nQp533GlUO38w1Z9/7/9D4H3oW4SnOOwWvBXXRRhDJ3SstJZKsYPjvtB
 cV5PZPNHohTHq+XWuOZyyolgsBSGMrEYrCRLXc82pHWBsjOCDNQ02CdMAAdhko2OAerg
 gyRuKGfxMkoGoCUc/5Tm2a/5xxAWyrKxOqTrbDxs2sCuPJ0PXQfIITlNLqCou9MZkzP9
 hhazieDMeKAAtyihLz8xsWCQmUgm2LBFwZvoMgKv0wexDJWQCF66VqZOyziJ1CRSLMac
 hLE5j5M+CLCK12aMRRl+Q1XLHdCsZLed3ii/SWVRLjaMqUjSf4c8YK789Riujdny/BAn
 6aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992434; x=1691584434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpEfDyBrVJqDU0QXLq2iInnF0CEU4fJ7tlxiogiIhsU=;
 b=LmzdrrbKVNZYelOoajCGps+sUa+WyKlWz/32+AGzLsVCbi00mcUMnBKw1rYcLaMmDA
 xkRo+TRc+KVKeJQj1C78KEXzr6W6X+srfBc2DnOZ4X4z4Y9ZU/1WvLXZX7sYps1+vekI
 ZFCKxJKp91o//hc3LxzIC792sI1lTGmf0eBIicRWXa+GVX9fC5mOk0ybpOcRgwoXdWBj
 RVTHIRfn9FingqBF57XsI94XNlHZDnNWlJr5v6vMsfHk8tpYlPqWQcM/PKoC3ciahcxe
 Ia8Z9oj2FwB+AaFFIQNFqEb3erHCwDAHQy185TsnSiNJw+kb9uMxrE85N/qiYbBmgvuk
 Azvg==
X-Gm-Message-State: ABy/qLbS+9EmnzKZyo3QfojDdh/bU0ytVe8NXAGpMbrsYYlfWZbrFqAT
 YmUtcmWlwFYOAGbECCvMJ9B6HSOdiOLLZg==
X-Google-Smtp-Source: APBJJlEuWlj0rvcLYYnjkfnu2Dl94tWWEF98gyHs2F47m0nBDBJlTZSeJdQXHsnyjQmD1s8QKiaAOw==
X-Received: by 2002:a17:90a:fa8c:b0:263:c247:6d1b with SMTP id
 cu12-20020a17090afa8c00b00263c2476d1bmr12361720pjb.40.1688992433704; 
 Mon, 10 Jul 2023 05:33:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/54] target/riscv: Add support for Zvfbfmin extension
Date: Mon, 10 Jul 2023 22:31:38 +1000
Message-Id: <20230710123205.2441106-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Add trans_* and helper function for Zvfbfmin instructions.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230615063302.102409-4-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                      |  3 +
 target/riscv/insn32.decode                 |  4 ++
 target/riscv/vector_helper.c               |  6 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc | 64 ++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ef8487f1ee..fc48853e07 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1157,3 +1157,6 @@ DEF_HELPER_FLAGS_2(cm_jalt, TCG_CALL_NO_WG, tl, env, i32)
 /* BF16 functions */
 DEF_HELPER_FLAGS_2(fcvt_bf16_s, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_s_bf16, TCG_CALL_NO_RWG, i64, env, i64)
+
+DEF_HELPER_5(vfncvtbf16_f_f_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 45fdcad185..10d001f14d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -912,3 +912,7 @@ czero_nez   0000111  ..... ..... 111 ..... 0110011 @r
 # *** Zfbfmin Standard Extension ***
 fcvt_bf16_s       0100010  01000 ..... ... ..... 1010011 @r2_rm
 fcvt_s_bf16       0100000  00110 ..... ... ..... 1010011 @r2_rm
+
+# *** Zvfbfmin Standard Extension ***
+vfncvtbf16_f_f_w  010010 . ..... 11101 001 ..... 1010111 @r2_vm
+vfwcvtbf16_f_f_v  010010 . ..... 01101 001 ..... 1010111 @r2_vm
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1e06e7447c..4d2bd42155 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4535,6 +4535,9 @@ RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 4)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 8)
 
+RVVCALL(OPFVV1, vfwcvtbf16_f_f_v, WOP_UU_H, H4, H2, bfloat16_to_float32)
+GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
+
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
 #define NOP_UU_B uint8_t,  uint16_t, uint32_t
@@ -4581,6 +4584,9 @@ RVVCALL(OPFVV1, vfncvt_f_f_w_w, NOP_UU_W, H4, H8, float64_to_float32)
 GEN_VEXT_V_ENV(vfncvt_f_f_w_h, 2)
 GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
 
+RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
+GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
+
 /*
  * Vector Reduction Operations
  */
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 8cafde505f..f794a3f745 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -22,6 +22,12 @@
     } \
 } while (0)
 
+#define REQUIRE_ZVFBFMIN(ctx) do { \
+    if (!ctx->cfg_ptr->ext_zvfbfmin) { \
+        return false; \
+    } \
+} while (0)
+
 static bool trans_fcvt_bf16_s(DisasContext *ctx, arg_fcvt_bf16_s *a)
 {
     REQUIRE_FPU;
@@ -51,3 +57,61 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
     mark_fs_dirty(ctx);
     return true;
 }
+
+static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFBFMIN(ctx);
+
+    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), cpu_env,
+                           ctx->cfg_ptr->vlen / 8,
+                           ctx->cfg_ptr->vlen / 8, data,
+                           gen_helper_vfncvtbf16_f_f_w);
+        mark_vs_dirty(ctx);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFBFMIN(ctx);
+
+    if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), cpu_env,
+                           ctx->cfg_ptr->vlen / 8,
+                           ctx->cfg_ptr->vlen / 8, data,
+                           gen_helper_vfwcvtbf16_f_f_v);
+        mark_vs_dirty(ctx);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
-- 
2.40.1


