Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CC74F657
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGiq-0001NC-BV; Tue, 11 Jul 2023 13:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGil-0001JC-TA
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:15 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGij-00010w-QU
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-553a1f13d9fso4538703a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689094812; x=1691686812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20zjHcE4T1HdyN5trsH0CcJ3coRR5e50EgCGbZ5ivBw=;
 b=h+DPKHrf39UEsr7PcC4CsXpyQ/bGEN/o2iDcDiU3OFBgI+dR2ljqXEKNeSF7+h5e9J
 o1BcWYpIsVFwqtRKpa0C98hRHLZs1tDunHB/SPtAq47+KUm8HTy6fn8VfX+rrofEQ7Ie
 WC9bnpz9qYAK9Dv+w4vMsRSvlAlx6UMbLHPwQMHrNEWIlM5odYPaN5gzxu0VWmHw6kx2
 SvIFinu1RAcvOgWYpChIe/3BvOSsQ+CISTcOyiqZiwrCk0u4W5udaPAq2afrPIHss6IF
 oP+mM6V4vclghdKq9rqu0V89+7yPJi3R367zcV5Hg1mpwWW9faVasWylXqN4CWeAtfdw
 Zoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094812; x=1691686812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20zjHcE4T1HdyN5trsH0CcJ3coRR5e50EgCGbZ5ivBw=;
 b=BaLwbehKQxZ6xbM7EECE5iRVqB2kvO9NnUWlsD+/u4m6l5oomWTPaj7/ZWb0w3KIZW
 l0JlN6XBM2twQP2UC2YZc6hXSxf0KbBfSCRMeguzbvO6OKSRD8R4WypLkChvqKIzmI3a
 DsNzfagi30CbskxiD0eVKBz1va5Lp8bUHM1zAOMfaJp8/DEhqbsVA33CeOrTsiy0xpiu
 a+iGyqQaGilZYVZ0q4ixoz7bxKGajsB6bwois/e0bseYC+BRSz0DGORgdO/8oTy9O3XK
 pCfeDv+c6J+Kv/1m18aqzfShJIQKy+ECo3vBwv1vlLJ00PC4IQqH4ciudIlbEKQH2gkZ
 cgew==
X-Gm-Message-State: ABy/qLbPBNeB+gKTFU1+U+YwUJgS8EC6f5B2EGf5ztTskvVOvJOkHj2h
 txu+a+nCLSGWwa/n29WkNJQK3zlRRcg+cZqdmr93eq/FNHiXjKJlwqkl1zvj+bnNzqs0y0uHHnb
 BZdOqNBPYhsrTOk52F2t/wy6yKn/RQv4/sD7h1PDJakUa9S15GH+z7lZHZOgT/aMAvi7648wqfV
 8KpBg=
X-Google-Smtp-Source: APBJJlF+yjFn0Vfrxj4m1tB/Xh3YzgodYBEDURDZRasfFbPWf/HDqC2gqpPsMhJimo/I2xTK0Gp0VQ==
X-Received: by 2002:a17:90b:390d:b0:262:f99b:a530 with SMTP id
 ob13-20020a17090b390d00b00262f99ba530mr16512272pjb.34.1689094812100; 
 Tue, 11 Jul 2023 10:00:12 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 gw10-20020a17090b0a4a00b00262fc84b931sm8381793pjb.44.2023.07.11.10.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 10:00:11 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Subject: [PATCH v8 03/15] target/riscv: Remove redundant "cpu_vl == 0" checks
Date: Wed, 12 Jul 2023 00:59:02 +0800
Message-Id: <20230711165917.2629866-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711165917.2629866-1-max.chou@sifive.com>
References: <20230711165917.2629866-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x531.google.com
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

From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

Remove the redundant "vl == 0" check which is already included within the  vstart >= vl check, when vl == 0.

Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 31 +------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4a8e62a8bef..7e194aae34a 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -617,7 +617,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv_i32 desc;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -786,7 +785,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     TCGv_i32 desc;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -893,7 +891,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i32 desc;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -1034,7 +1031,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv_i32 desc;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -1191,7 +1187,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
         return false;
     }
 
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
@@ -1241,7 +1236,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     uint32_t data = 0;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -1405,7 +1399,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     uint32_t data = 0;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -1492,7 +1485,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
     if (checkfn(s, a)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -1575,7 +1567,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
     if (opiwv_widen_check(s, a)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -1648,7 +1639,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
 {
     uint32_t data = 0;
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     data = FIELD_DP32(data, VDATA, VM, vm);
@@ -1842,7 +1832,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2054,7 +2043,6 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
             };
             TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
             tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
@@ -2078,7 +2066,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         vext_check_ss(s, a->rd, 0, 1)) {
         TCGv s1;
         TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         s1 = get_gpr(s, a->rs1, EXT_SIGN);
@@ -2140,7 +2127,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
             };
             TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
             tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             s1 = tcg_constant_i64(simm);
@@ -2288,7 +2274,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2323,7 +2308,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i64 t1;
 
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     dest = tcg_temp_new_ptr();
@@ -2408,7 +2392,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         };                                                       \
         TCGLabel *over = gen_new_label();                        \
         gen_set_rm(s, RISCV_FRM_DYN);                            \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
@@ -2483,7 +2466,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2601,7 +2583,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
         gen_set_rm_chkfrm(s, rm);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -2713,7 +2694,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
                 gen_helper_vmv_v_x_d,
             };
             TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
             tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             t1 = tcg_temp_new_i64();
@@ -2792,7 +2772,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2844,7 +2823,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2912,7 +2890,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2962,7 +2939,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -3053,7 +3029,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
         TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
@@ -3224,7 +3199,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         require_vm(a->vm, a->rd)) {
         uint32_t data = 0;
         TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -3411,7 +3385,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         TCGv s1;
         TCGLabel *over = gen_new_label();
 
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
@@ -3468,8 +3441,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         TCGv_i64 t1;
         TCGLabel *over = gen_new_label();
 
-        /* if vl == 0 or vstart >= vl, skip vector register write back */
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        /* if vstart >= vl, skip vector register write back */
         tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
@@ -3720,7 +3692,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
     uint32_t data = 0;
     gen_helper_gvec_3_ptr *fn;
     TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     static gen_helper_gvec_3_ptr * const fns[6][4] = {
-- 
2.34.1


