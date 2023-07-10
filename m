Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6774D5C4
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5y-0004JQ-9r; Mon, 10 Jul 2023 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5Z-0003av-WA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:06 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5W-0004n7-W9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:00 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-55ae51a45deso2112284a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992437; x=1691584437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdNu/Kt6GrkCzAV4enDm7WHaEjLHO+9pW7gTbgsL+7Y=;
 b=OSLsLcEUzqqM913WmzTD0dY5Z9GRf2rCpHLyGsp5vEw9ISJVP7kn9Y3aqvHjzV15cb
 W+Fw/OLNEm0PBCJ2DneHy1KEhZAjUzkY/f10/ckCKhGKVuXPX4rMITSYXs1BG/ryx726
 zpVwfEaFIb9dcHaHiuG7+rcnRBrq0yRomcEPBTXnHhyQUiG2V9JY6/YFfjRTXOpcnyYu
 BHIJ6E5LrQ0r5d3pu1CRHeVc5IBSYRbMaU5Ce8p0eO/kZ094BAos3SRUWAIUJOLXA2qW
 7FQL/+E5Cu0H6QFkhY33pNEpFzAzt7oPK9MYQtePQg31eMUoSu6YQRFrLYZCGAghsBlw
 4luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992437; x=1691584437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdNu/Kt6GrkCzAV4enDm7WHaEjLHO+9pW7gTbgsL+7Y=;
 b=SlVa++pn+WugvDzmdrLFys3PwSoYk1zwJb1rRg4JaXpRDSvz2icbbL2DeNNHBzLJpF
 qjle62Wie8AJtiz9l9GfIHEzkGYt0J+L5dFNvsA6hw9/CgsDsR0VnHje04DoCFtX7uIT
 4g+Hy9/6c4VsacXNo7uEabf7Ci1CUDK/E78Chs9sDtRvcsKOiknI19JraER4Dp77qfeG
 mYcIlKdchDql8z5/K/Q0Pet3xuDuikuWOYhTkIX8J89mky1LJ57d3gSjdeA3lO53hu09
 kWI6uJtxFe7/VLmOI9MKPo4RjCCJnPpFA73BvYAo3j2puosc8rIqRFCjpmAXNOgEUZOE
 xfOQ==
X-Gm-Message-State: ABy/qLZ2VRXIkwCiRdh5y+6CsoISw9z9SUgjbNgJQm4SDEklCkyTGuu0
 gHv7Ye+gZaQM/WEskXz4mFoae6uX9pe1Zg==
X-Google-Smtp-Source: APBJJlGAJzSbTVVSfMAo3jw4uIv+Csvzx66dBHwLLSeJ4WCTHSNvAoPgxEUNOcjdlz1TxJUUR0u7xQ==
X-Received: by 2002:a17:90b:1d87:b0:262:d19c:4fee with SMTP id
 pf7-20020a17090b1d8700b00262d19c4feemr9508799pjb.19.1688992437282; 
 Mon, 10 Jul 2023 05:33:57 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/54] target/riscv: Add support for Zvfbfwma extension
Date: Mon, 10 Jul 2023 22:31:39 +1000
Message-Id: <20230710123205.2441106-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

Add trans_* and helper function for Zvfbfwma instructions.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230615063302.102409-5-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                      |  3 ++
 target/riscv/insn32.decode                 |  4 ++
 target/riscv/vector_helper.c               | 11 ++++
 target/riscv/insn_trans/trans_rvbf16.c.inc | 58 ++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fc48853e07..3170b8daa6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1160,3 +1160,6 @@ DEF_HELPER_FLAGS_2(fcvt_s_bf16, TCG_CALL_NO_RWG, i64, env, i64)
 
 DEF_HELPER_5(vfncvtbf16_f_f_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfwmaccbf16_vv, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmaccbf16_vf, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 10d001f14d..8c5d293f07 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -916,3 +916,7 @@ fcvt_s_bf16       0100000  00110 ..... ... ..... 1010011 @r2_rm
 # *** Zvfbfmin Standard Extension ***
 vfncvtbf16_f_f_w  010010 . ..... 11101 001 ..... 1010111 @r2_vm
 vfwcvtbf16_f_f_v  010010 . ..... 01101 001 ..... 1010111 @r2_vm
+
+# *** Zvfbfwma Standard Extension ***
+vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4d2bd42155..71bb9b4457 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3554,6 +3554,17 @@ RVVCALL(OPFVF3, vfwmacc_vf_w, WOP_UUU_W, H8, H4, fwmacc32)
 GEN_VEXT_VF(vfwmacc_vf_h, 4)
 GEN_VEXT_VF(vfwmacc_vf_w, 8)
 
+static uint32_t fwmaccbf16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
+{
+    return float32_muladd(bfloat16_to_float32(a, s),
+                          bfloat16_to_float32(b, s), d, 0, s);
+}
+
+RVVCALL(OPFVV3, vfwmaccbf16_vv, WOP_UUU_H, H4, H2, H2, fwmaccbf16)
+GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
+RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmacc16)
+GEN_VEXT_VF(vfwmaccbf16_vf, 4)
+
 static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index f794a3f745..911bc29908 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -28,6 +28,12 @@
     } \
 } while (0)
 
+#define REQUIRE_ZVFBFWMA(ctx) do { \
+    if (!ctx->cfg_ptr->ext_zvfbfwma) { \
+        return false; \
+    } \
+} while (0)
+
 static bool trans_fcvt_bf16_s(DisasContext *ctx, arg_fcvt_bf16_s *a)
 {
     REQUIRE_FPU;
@@ -115,3 +121,55 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
     }
     return false;
 }
+
+static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFBFWMA(ctx);
+
+    if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
+        vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
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
+        tcg_gen_gvec_4_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs1),
+                           vreg_ofs(ctx, a->rs2), cpu_env,
+                           ctx->cfg_ptr->vlen / 8,
+                           ctx->cfg_ptr->vlen / 8, data,
+                           gen_helper_vfwmaccbf16_vv);
+        mark_vs_dirty(ctx);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vfwmaccbf16_vf(DisasContext *ctx, arg_vfwmaccbf16_vf *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFBFWMA(ctx);
+
+    if (require_rvv(ctx) && (ctx->sew == MO_16) && vext_check_isa_ill(ctx) &&
+        vext_check_ds(ctx, a->rd, a->rs2, a->vm)) {
+        uint32_t data = 0;
+
+        gen_set_rm(ctx, RISCV_FRM_DYN);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,
+                           gen_helper_vfwmaccbf16_vf, ctx);
+    }
+
+    return false;
+}
-- 
2.40.1


