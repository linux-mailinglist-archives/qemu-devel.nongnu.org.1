Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AC8868C0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Mar 2024 10:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnamg-0004Qt-9w; Fri, 22 Mar 2024 05:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnam3-00044E-7h
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:01:18 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnals-0002Ir-I1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:01:07 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e682dbd84bso1074611a34.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098063; x=1711702863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzkJtzrD2AZguEnLS9WQcNcwiid6ehuxGtzXZnitJe4=;
 b=f1/O59xpDS4zk7rA0tzHAdf1xLmUhj2xlBzqg4acmk8fpnCXZAN2lUy/Pj5gi+ztqL
 DpA7AIm1nRhQ7Ho9LBjls1e5vmHORzp1Qizvm3FMaE5VblqT6bH9ni4CzQvXNHMe4oTv
 ctLOZzrvceke5ffiFQrHdog9/6Hoe/SwFxsNjdYBrtDQRPlZ9xuScNfmdRMXi8/oSj7g
 dOHrDtixEqtQ10itnweBQw3fqr2ULwRy+OY05RdP2XZC4wXa/JKvWK+qUoleCVsunzJ6
 SV7LAciOYyBwLMrkcEvwSEyMtBWAi7XeS/ijpvxuU2n+HTlcaE2Xp6X/Rk0SQ6rlCkG/
 4c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098063; x=1711702863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzkJtzrD2AZguEnLS9WQcNcwiid6ehuxGtzXZnitJe4=;
 b=rpPBGLUfZ6Uipa0DqkM8Rt0MWA/bStcncU9+j/U8M3XjT/6kwPOAu3G2WYpruLdEKR
 rOWpIh+Frcp8rcaZUr+eKHcL47B2S0gt1rY+nTIsj63MyipMApinQVGSC6v6mu5sC96Q
 QK9znc/2SVc57/+aL9daXEX58wjVafkzof1PdzbMZvRXfaulP+mBiOPpsKgbJaw5xLSf
 sUhpFUjqhxoPWTxYW7lT7k8zIAckUeyAKeRwDuBY5+aigOUfJGmAtUe1czL95cBfU3pJ
 aDEvL0Or4ZwbBEuig94HHbkZdNzkeFiyJsWFzm1dgZNSGaGz55bTCbC8tVvbLH51NtBP
 A9hw==
X-Gm-Message-State: AOJu0YxWmkdw8AlDBd78IJZv1heqv8MkCYyNEJRZ/9n/0VFEH7XcDA7O
 pJpeLZnm5vXVq0/IPWRGrIC4QFApY0fltSreG96jXMzKq/ui1bas9RFt+waGlsNMMA==
X-Google-Smtp-Source: AGHT+IHwqv/deqV5zgpjCzyHMjJ+ZTFkX/ftR4m6i8LpO3G7q5qpZxxK0apbaD4mZdKV/hPbE+phIw==
X-Received: by 2002:a05:6a21:789d:b0:1a3:5090:7268 with SMTP id
 bf29-20020a056a21789d00b001a350907268mr2219119pzc.47.1711097636249; 
 Fri, 22 Mar 2024 01:53:56 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/15] target/riscv: remove 'over' brconds from vector trans
Date: Fri, 22 Mar 2024 18:53:12 +1000
Message-ID: <20240322085319.1758843-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

All helpers that rely on vstart >= vl are now doing early exits using
the VSTART_CHECK_EARLY_EXIT() macro. This macro will not only exit the
helper but also clear vstart.

We're still left with brconds that are skipping the helper, which is the
only place where we're clearing vstart. The pattern goes like this:

    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
    (... calls helper that clears vstart ...)
    gen_set_label(over);
    return true;

This means that every time we jump to 'over' we're not clearing vstart,
which is an oversight that we're doing across the board.

Instead of setting vstart = 0 manually after each 'over' jump, remove
those brconds that are skipping helpers. The exception will be
trans_vmv_s_x() and trans_vfmv_s_f(): they don't use a helper and are
already clearing vstart manually in the 'over' label.

While we're at it, remove the (vl == 0) brconds from trans_rvbf16.c.inc
too since they're unneeded.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240314175704.478276-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 12 ---
 target/riscv/insn_trans/trans_rvv.c.inc    | 99 ----------------------
 target/riscv/insn_trans/trans_rvvk.c.inc   | 18 ----
 3 files changed, 129 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 8ee99df3f3..a842e76a6b 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -71,11 +71,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 
     if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
@@ -87,7 +84,6 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -100,11 +96,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
 
     if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
@@ -116,7 +109,6 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -130,11 +122,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
     if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
         vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
@@ -147,7 +136,6 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 1366445e1f..7931fb2f3f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -616,9 +616,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -660,7 +657,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
-    gen_set_label(over);
     return true;
 }
 
@@ -802,9 +798,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     TCGv base, stride;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -819,7 +812,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -906,9 +898,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
@@ -924,7 +913,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -1044,9 +1032,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -1059,7 +1044,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1189,10 +1173,6 @@ static inline bool
 do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
               gen_helper_gvec_4_ptr *fn)
 {
-    TCGLabel *over = gen_new_label();
-
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd),
                 vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
@@ -1210,7 +1190,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            s->cfg_ptr->vlenb, data, fn);
     }
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1242,9 +1221,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1265,7 +1241,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1404,9 +1379,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1427,7 +1399,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1489,8 +1460,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1503,7 +1472,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            s->cfg_ptr->vlenb,
                            data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1565,8 +1533,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (opiwv_widen_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1578,7 +1544,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1637,8 +1602,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                         gen_helper_gvec_4_ptr *fn, DisasContext *s)
 {
     uint32_t data = 0;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -1649,7 +1612,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1828,8 +1790,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -1842,7 +1802,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2039,14 +1998,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
                                tcg_env, s->cfg_ptr->vlenb,
                                s->cfg_ptr->vlenb, data,
                                fns[s->sew]);
-            gen_set_label(over);
         }
         mark_vs_dirty(s);
         return true;
@@ -2062,8 +2018,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         /* vmv.v.x has rs2 = 0 and vm = 1 */
         vext_check_ss(s, a->rd, 0, 1)) {
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         s1 = get_gpr(s, a->rs1, EXT_SIGN);
 
@@ -2096,7 +2050,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         }
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2123,8 +2076,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             s1 = tcg_constant_i64(simm);
             dest = tcg_temp_new_ptr();
@@ -2134,7 +2085,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             fns[s->sew](dest, s1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2269,9 +2219,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_w,                                 \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2286,7 +2234,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2304,9 +2251,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i32 desc;
     TCGv_i64 t1;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -2324,7 +2268,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, t1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -2387,9 +2330,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_gvec_4_ptr * const fns[2] = {          \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        TCGLabel *over = gen_new_label();                        \
         gen_set_rm(s, RISCV_FRM_DYN);                            \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
@@ -2402,7 +2343,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
         mark_vs_dirty(s);                                        \
-        gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2461,9 +2401,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         static gen_helper_gvec_4_ptr * const fns[2] = {            \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2476,7 +2414,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2578,9 +2515,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         gen_set_rm_chkfrm(s, rm);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -2591,7 +2526,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2690,8 +2624,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
                 gen_helper_vmv_v_x_w,
                 gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
@@ -2705,7 +2637,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             fns[s->sew - 1](dest, t1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2767,9 +2698,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2781,7 +2710,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2818,9 +2746,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2832,7 +2758,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2885,9 +2810,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2899,7 +2822,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2934,9 +2856,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -2948,7 +2868,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3025,8 +2944,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         data =                                                     \
@@ -3037,7 +2954,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data, fn);           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3125,8 +3041,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         s->vstart_eq_zero) {                                       \
         uint32_t data = 0;                                         \
         gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -3139,7 +3053,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3165,8 +3078,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         require_align(a->rd, s->lmul) &&
         s->vstart_eq_zero) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3181,7 +3092,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3195,8 +3105,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         require_align(a->rd, s->lmul) &&
         require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -3211,7 +3119,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3624,8 +3531,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
             gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
             gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
         };
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         data = FIELD_DP32(data, VDATA, VTA, s->vta);
@@ -3635,7 +3540,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3689,8 +3593,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_gvec_3_ptr *fn;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     static gen_helper_gvec_3_ptr * const fns[6][4] = {
         {
@@ -3735,7 +3637,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s->cfg_ptr->vlenb, data, fn);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index a5cdd1b67f..6d640e4596 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                 gen_helper_##NAME##_w,                                     \
                 gen_helper_##NAME##_d,                                     \
             };                                                             \
-            TCGLabel *over = gen_new_label();                              \
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);     \
                                                                            \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                     \
             data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                 \
@@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
                                data, fns[s->sew]);                         \
             mark_vs_dirty(s);                                              \
-            gen_set_label(over);                                           \
             return true;                                                   \
         }                                                                  \
         return false;                                                      \
@@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 desc, egs;                                               \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 uimm_v, desc, egs;                                       \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
     {                                                                         \
         if (CHECK(s, a)) {                                                    \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
             TCGv_i32 egs;                                                     \
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
@@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
@@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                data, gen_helper_##NAME);                      \
                                                                               \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
@@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
@@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
-- 
2.44.0


