Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FE783AA7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:14:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLbJ-0000mg-Gk; Tue, 22 Aug 2023 03:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbG-0000fT-Vp
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbE-0002vk-41
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so39478365e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688486; x=1693293286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvQZedijPtJ34ELRwqSS7RfwCk60jvhcOCv1VkYXcvk=;
 b=wO7IGU2fnBG6Mn1I0vtOJP1sErgRhzuMztjjrUBwI+VZDAPpnXGnlFaQX0fKCi5K9F
 0O+v5cerBq3MKD+I/6TuueSZXk3o6wBBJsrrUDbtuRP+a9tUaCHj4IumrxbA4z0f5Csn
 0GVXB52k/c6xgETqiy2cHnPXV9a0r309v2nzPT/aTfCviD9CwP8rrIF50ND2WVRc+osE
 o4K4JUTDS3OxLFjAdAdnupGdon60Imc0M3nnhjKOA6txkd8lL6wGNI5ACI6McrXBh4eI
 jRTuuaki4ARHJrXU+R28jHfrvcEb3N2yBmLAfSXu9TqkOWJS4Azyc0qM3pHXFe8R+m6g
 XVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688486; x=1693293286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvQZedijPtJ34ELRwqSS7RfwCk60jvhcOCv1VkYXcvk=;
 b=dgfqQQje64N7agft8WDnLhcIzD18ZxB1RzTFlQ397WEQS7j4RfmtS7oeY6nVe0+pCI
 FAh1RGDM2PKf8v0pHOFkQZXHiW2152ngRewaN1sceHbDnEm4NUHhq7FnuuJusKCarrLE
 BpJqn9HMbC+CDdNWAPI5l+I3idDd6b6h4c+3X3n5In7YgguS+IS8GGyAFMRPU79xHfZ/
 sN1Z1ggbiNU2+4GV0o5iyP7lWTD9CBo+Q3Ytva4JjGQ6kQu6AtrMIjQqGNx82N97a7Jt
 J3fGFCpqtXVKMLL6PycY7oOzwlBH3YDFyK5ULpyy+hdhHra9IgQEaHbIgk+LYIcZLImZ
 7EYA==
X-Gm-Message-State: AOJu0YwxNCSSs9FVOh9BaNd4s2fliBRyeO08uOz5tvDJ0E+J+GgQaf0x
 LllTBoVVHQJLwBRPryOsB9H8YcJMky+Ox09r9w2t4Q==
X-Google-Smtp-Source: AGHT+IECDMX0Fb22QU2WSj7qlVC2wUc/lJ4OgrkBRF76fMct0gwMA94DIptLpT0B1d4SIW8jS8Bkag==
X-Received: by 2002:a5d:55c3:0:b0:319:72f8:7244 with SMTP id
 i3-20020a5d55c3000000b0031972f87244mr5737000wrw.45.1692688486170; 
 Tue, 22 Aug 2023 00:14:46 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b0031779a6b451sm14859609wrx.83.2023.08.22.00.14.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 06/19] target/loongarch: Extract make_address_i()
 helper
Date: Tue, 22 Aug 2023 09:13:52 +0200
Message-ID: <20230822071405.35386-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/translate.c                  |  6 ++++
 .../loongarch/insn_trans/trans_atomic.c.inc   |  5 +--
 .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  | 12 ++-----
 target/loongarch/insn_trans/trans_lsx.c.inc   | 32 +++++--------------
 .../loongarch/insn_trans/trans_memory.c.inc   | 28 +++++-----------
 6 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index a68a979a55..acc54d7587 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -220,6 +220,12 @@ static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
     return base;
 }
 
+static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
+{
+    TCGv addend = ofs ? tcg_constant_tl(ofs) : NULL;
+    return make_address_x(ctx, base, addend);
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 612709f2a7..fbc081448d 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -7,9 +7,8 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv t0 = tcg_temp_new();
+    TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_addi_tl(t0, src1, a->imm);
     tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
@@ -62,6 +61,8 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
         return false;
     }
 
+    addr = make_address_i(ctx, addr, 0);
+
     func(dest, addr, val, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index a860f7e733..3ad34bcc05 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -23,7 +23,8 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
-    tcg_gen_addi_tl(cpu_pc, src1, a->imm);
+    TCGv addr = make_address_i(ctx, src1, a->imm);
+    tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, ctx->base.pc_next + 4);
     gen_set_gpr(a->rd, dest, EXT_NONE);
     tcg_gen_lookup_and_goto_ptr();
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 88ad209338..bd3aba2c49 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -17,11 +17,7 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 
     CHECK_FPE;
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
@@ -37,11 +33,7 @@ static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 
     CHECK_FPE;
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(src, addr, ctx->mem_idx, mop);
 
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 875cb7d51d..50153d6d0b 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4255,7 +4255,7 @@ TRANS(vextrins_d, gen_vv_i, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
-    TCGv addr, temp;
+    TCGv addr;
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
@@ -4266,11 +4266,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     rl = tcg_temp_new_i64();
     rh = tcg_temp_new_i64();
 
-    if (a->imm) {
-        temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
@@ -4282,7 +4278,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 
 static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
 {
-    TCGv addr, temp;
+    TCGv addr;
     TCGv_i128 val;
     TCGv_i64 ah, al;
 
@@ -4293,11 +4289,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
 
-    if (a->imm) {
-        temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
@@ -4356,7 +4348,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 #define VLDREPL(NAME, MO)                                                 \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
 {                                                                         \
-    TCGv addr, temp;                                                      \
+    TCGv addr;                                                            \
     TCGv_i64 val;                                                         \
                                                                           \
     CHECK_SXE;                                                            \
@@ -4364,11 +4356,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
                                                                           \
-    if (a->imm) {                                                         \
-        temp = tcg_temp_new();                                            \
-        tcg_gen_addi_tl(temp, addr, a->imm);                              \
-        addr = temp;                                                      \
-    }                                                                     \
+    addr = make_address_i(ctx, addr, a->imm);                             \
                                                                           \
     tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, MO);                     \
     tcg_gen_gvec_dup_i64(MO, vec_full_offset(a->vd), 16, ctx->vl/8, val); \
@@ -4384,7 +4372,7 @@ VLDREPL(vldrepl_d, MO_64)
 #define VSTELM(NAME, MO, E)                                                  \
 static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
 {                                                                            \
-    TCGv addr, temp;                                                         \
+    TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
     CHECK_SXE;                                                               \
@@ -4392,11 +4380,7 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
                                                                              \
-    if (a->imm) {                                                            \
-        temp = tcg_temp_new();                                               \
-        tcg_gen_addi_tl(temp, addr, a->imm);                                 \
-        addr = temp;                                                         \
-    }                                                                        \
+    addr = make_address_i(ctx, addr, a->imm);                                \
                                                                              \
     tcg_gen_ld_i64(val, cpu_env,                                             \
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.E(a->imm2))); \
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index ccebd0a4e0..88953f0ab0 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -8,11 +8,7 @@ static bool gen_load(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -24,11 +20,7 @@ static bool gen_store(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
@@ -66,6 +58,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -79,6 +72,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -92,6 +86,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtgt_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -104,6 +99,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
     gen_helper_asrtle_d(cpu_env, src1, src2);
+    src1 = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
 
     return true;
@@ -131,11 +127,7 @@ static bool gen_ldptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -147,11 +139,7 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (a->imm) {
-        TCGv temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, addr, a->imm);
-        addr = temp;
-    }
+    addr = make_address_i(ctx, addr, a->imm);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
     return true;
-- 
2.41.0


