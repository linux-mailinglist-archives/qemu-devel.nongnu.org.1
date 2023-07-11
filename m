Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B474F64A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGjF-0001bd-Cr; Tue, 11 Jul 2023 13:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGj5-0001Wf-9b
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:36 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qJGj3-00015n-M9
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:00:34 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b71cdb47e1so5279980a34.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689094832; x=1691686832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xDe6ao5et/ZVTD0N/e+3YtPZieiXMeFZa1ZZNtKffc=;
 b=cP5I/X9t/Xnc7PG4eazkJ0aioBwJY6PDfXerZsgfAFHqZlfokMdcDefaq8dsr+V+tJ
 kWTwaabjSZo/zqbbKAG4pB7DlCiEggZDYBYPZc+bd6af1ulRekczv4NsDKptq9CkLRio
 6PlRQtFqfSqp7k10faD6GQJ7pwx+4T0VQc8EiqAA2aPn1TlV13dz3JhKy0fZjpsaIA4E
 3p3cjnA1a+w6ASERMChq5jAZuQw8BHCmVKJGBrLz1T2bMEXq80oar12nF8KzmY7z3/cH
 mnl+Io/37Snvr1WX7xAhZK0ochC+K7i3TIlhWAwKxHveqzrP2bSRX6mKGpvwg3DKrJHX
 qVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094832; x=1691686832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xDe6ao5et/ZVTD0N/e+3YtPZieiXMeFZa1ZZNtKffc=;
 b=Qju/6CLQO+LuaZSFh4tDvSHRw1qiQIXhBl31bpFhEsns2WC915KnxKRSfNTJA6Z+Oz
 H9MihVFP0FcOtfYeUcUU7+huR0a+HwwknhofYt0TxvQXDfczLJntynri3u/58uqxap0y
 tgTivkgW/xeLEQy8loWc/RelGFCBqSPiMsuwd3kVlO96LTlxVdF+NiJ1xoK88gHv9/0y
 rke+b29wumyf7/+R7Bh4zHa+MU44Ap+mlP6bBAsCZpAJhLRNVEnHn3Z4i7RUYzMXqwBv
 J0UMNuYBetkcu2pjsCJ6RgEX9kHJ7aGDIKtRJM8GtXUgGdw93PeNPceFxUrVlII8OMNR
 YKWw==
X-Gm-Message-State: ABy/qLZRHGLK2yQC0gXKDEKwz9aJbccjLfgVgcOcig2YBbJWJoVZObKA
 7nDDz5TepNTm+g4kNmakys3+rIRJJdnBlNKmXtmVXE/l5OqgGOmIuWTf2Fx4/lPB6+KJz2nXnTN
 srGhCScP/5vChGn2sFhrsGQUET8qa+m4sifBFYYWySBM7uMDwNcbcyp+XzinCAP5h0OOkqgHeXg
 F10CU=
X-Google-Smtp-Source: APBJJlFvMLHhHsW+9UiPsqMwwJAk0Dr1m1/rU2GqTlpSlFabQbnN2NTeLB/XnBdG7NiUqbDfqLqFGg==
X-Received: by 2002:a05:6870:d24d:b0:1b7:4870:9075 with SMTP id
 h13-20020a056870d24d00b001b748709075mr4892613oac.6.1689094832335; 
 Tue, 11 Jul 2023 10:00:32 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 gw10-20020a17090b0a4a00b00262fc84b931sm8381793pjb.44.2023.07.11.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 10:00:32 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 05/15] target/riscv: Move vector translation checks
Date: Wed, 12 Jul 2023 00:59:04 +0800
Message-Id: <20230711165917.2629866-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711165917.2629866-1-max.chou@sifive.com>
References: <20230711165917.2629866-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=max.chou@sifive.com; helo=mail-ot1-x334.google.com
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

From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

Move the checks out of `do_opiv{v,x,i}_gvec{,_shift}` functions
and into the corresponding macros. This enables the functions to be
reused in proceeding commits without check duplication.

Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 28 +++++++++++--------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7e194aae34a..5dfd524c7d2 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1183,9 +1183,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
               gen_helper_gvec_4_ptr *fn)
 {
     TCGLabel *over = gen_new_label();
-    if (!opivv_check(s, a)) {
-        return false;
-    }
 
     tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
@@ -1218,6 +1215,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_helper_##NAME##_b, gen_helper_##NAME##_h,              \
         gen_helper_##NAME##_w, gen_helper_##NAME##_d,              \
     };                                                             \
+    if (!opivv_check(s, a)) {                                      \
+        return false;                                              \
+    }                                                              \
     return do_opivv_gvec(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);   \
 }
 
@@ -1276,10 +1276,6 @@ static inline bool
 do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
               gen_helper_opivx *fn)
 {
-    if (!opivx_check(s, a)) {
-        return false;
-    }
-
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         TCGv_i64 src1 = tcg_temp_new_i64();
 
@@ -1301,6 +1297,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_helper_##NAME##_b, gen_helper_##NAME##_h,              \
         gen_helper_##NAME##_w, gen_helper_##NAME##_d,              \
     };                                                             \
+    if (!opivx_check(s, a)) {                                      \
+        return false;                                              \
+    }                                                              \
     return do_opivx_gvec(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);   \
 }
 
@@ -1432,10 +1431,6 @@ static inline bool
 do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
               gen_helper_opivx *fn, imm_mode_t imm_mode)
 {
-    if (!opivx_check(s, a)) {
-        return false;
-    }
-
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
@@ -1453,6 +1448,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,            \
         gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,            \
     };                                                             \
+    if (!opivx_check(s, a)) {                                      \
+        return false;                                              \
+    }                                                              \
     return do_opivi_gvec(s, a, tcg_gen_gvec_##SUF,                 \
                          fns[s->sew], IMM_MODE);                   \
 }
@@ -1775,10 +1773,6 @@ static inline bool
 do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
                     gen_helper_opivx *fn)
 {
-    if (!opivx_check(s, a)) {
-        return false;
-    }
-
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         TCGv_i32 src1 = tcg_temp_new_i32();
 
@@ -1800,7 +1794,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
         gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
         gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
     };                                                                    \
-                                                                          \
+    if (!opivx_check(s, a)) {                                             \
+        return false;                                                     \
+    }                                                                     \
     return do_opivx_gvec_shift(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);    \
 }
 
-- 
2.34.1


