Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB1285CAB7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 23:27:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYa0-0003a3-G3; Tue, 20 Feb 2024 17:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYc-0002U8-3l
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYX-0003bV-Kd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so54380175ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467939; x=1709072739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1dI8otuAdd5FGg9dKP87bjFZso3vwiwO0sNHgxqtR4=;
 b=B+nivvwxLz1nnKJm9joRZDY7FPRK5cbGn9eKPUN3gclaGhMj1hHG9bdDsWt90+L/e4
 NDELSFJ8ALxEfy6WYms5pKDFhaT1seC8zeduTzFme81grsCQ5wiLH888S1DsljS0bHk5
 JqEjePcLauXuuAIg5/2N/NlQ3N5ZJXT9m511q0PacOE4tYZ9rqWJsP3WUA+zsc3NjMud
 G8rY3oiWHRSGKJ33EWt4mDIv9utisvk+pdSfl9Fy+BwvfGrMmfQ9m16GnhAMKqu/ZI0a
 OnCJ3uXgyC3N1Oz7o5SS9sjtu71156wwpLZ31jyT9bOXIYkftN4f86oNcOUxGHn78Bs1
 +U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467939; x=1709072739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1dI8otuAdd5FGg9dKP87bjFZso3vwiwO0sNHgxqtR4=;
 b=dgKXL8dg8u7LI92uf80+C8EzZph+2kM0QlLEEviQ1nzSCfFZbrLGjzBZp14bhVqz8B
 72xIFZSe+0NcReDsaDuMSMLhhMJ+kTB0V4bL7gUf8N8hxeb1iuHukypJy4mByYAyJaxH
 H6WH9ZER5302B0DGJbjTkVi94t3Ngx2FpFN2QuGDQMr2DAp09hUysYoth9gcYJX2TCIi
 cGCZBlPr/T5iv+rZvkOL0kygw+Hne501gmVps44GlIVeO1vSkarX5Lnf6lJ1pBwwEQSS
 o2ZxFkkD4UQNUPyeolNyjR20xbZMrNRcmpwXqrVAuRFJoU37ChkC2D/dNbOyr5YRJ8W8
 Vr5A==
X-Gm-Message-State: AOJu0Yy7NGVOxrOWB5br4dN5NTqxrgUhbJzadg28353OnN8AZixb3dEv
 YsmcGCvuVky/gP8BbYvXXd4PoCCG2ygOzfppdUEav7hpNfLNsUdFfE8w0p2OzUZlbFfJG4SuAdK
 G
X-Google-Smtp-Source: AGHT+IH4/CmrlruiPNVb43Rc/3XeuRtvyVFi+BeTIqL5MtzQq0uanZtT3+o8LyE9JcWyllI16ns/7A==
X-Received: by 2002:a17:903:945:b0:1dc:d12:193b with SMTP id
 ma5-20020a170903094500b001dc0d12193bmr5267403plb.66.1708467939074; 
 Tue, 20 Feb 2024 14:25:39 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:38 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Ivan Klokov <ivan.klokov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 6/6] target/riscv: Clear vstart_qe_zero flag
Date: Tue, 20 Feb 2024 19:25:10 -0300
Message-ID: <20240220222510.209448-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220222510.209448-1-dbarboza@ventanamicro.com>
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

The vstart_qe_zero flag is set at the beginning of the translation
phase from the env->vstart variable. During the execution phase all
functions will set env->vstart = 0 after a successful execution,
but the vstart_eq_zero flag remains the same as at the start of the
block. This will wrongly cause SIGILLs in translations that requires
env->vstart = 0 and might be reading vstart_eq_zero = false.

This patch adds a new finalize_rvv_inst() helper that is called at the
end of each vector instruction that will both update vstart_eq_zero and
do a mark_vs_dirty().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1976
Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  6 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 78 ++++++++++++----------
 target/riscv/insn_trans/trans_rvvk.c.inc   | 12 ++--
 target/riscv/translate.c                   |  6 ++
 4 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 8ee99df3f3..96e3e73530 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -86,7 +86,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
@@ -115,7 +115,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
@@ -146,7 +146,7 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
                            ctx->cfg_ptr->vlenb,
                            ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 8c9a0246ef..069ddfd477 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -167,7 +167,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 
     gen_helper_vsetvl(dst, tcg_env, s1, s2);
     gen_set_gpr(s, rd, dst);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
 
     gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
@@ -187,7 +187,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     gen_helper_vsetvl(dst, tcg_env, s1, s2);
     gen_set_gpr(s, rd, dst);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
     s->base.is_jmp = DISAS_NORETURN;
@@ -636,6 +636,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -791,6 +792,7 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -892,6 +894,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1022,7 +1025,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1079,6 +1082,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1168,7 +1172,7 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
     }
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1219,7 +1223,7 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1244,7 +1248,7 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1377,7 +1381,7 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1391,7 +1395,7 @@ do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
@@ -1450,7 +1454,7 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb,
                            data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -1522,7 +1526,7 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            vreg_ofs(s, a->rs2),
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -1590,7 +1594,7 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
     tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1),
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -1723,7 +1727,7 @@ do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1780,7 +1784,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -1983,7 +1987,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                                s->cfg_ptr->vlenb, data,
                                fns[s->sew]);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2028,7 +2032,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             fns[s->sew](dest, s1_i64, tcg_env, desc);
         }
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2062,7 +2066,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2210,7 +2214,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2244,7 +2248,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, t1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
@@ -2319,7 +2323,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlenb,                    \
                            s->cfg_ptr->vlenb, data,              \
                            fns[s->sew - 1]);                     \
-        mark_vs_dirty(s);                                        \
+        finalize_rvv_inst(s);                                    \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2390,7 +2394,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2502,7 +2506,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2612,7 +2616,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2684,7 +2688,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2732,7 +2736,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2796,7 +2800,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2842,7 +2846,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data,                \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2928,7 +2932,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            vreg_ofs(s, a->rs2), tcg_env,           \
                            s->cfg_ptr->vlenb,                      \
                            s->cfg_ptr->vlenb, data, fn);           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3027,7 +3031,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            tcg_env, s->cfg_ptr->vlenb,             \
                            s->cfg_ptr->vlenb,                      \
                            data, fn);                              \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                      \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3066,7 +3070,7 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3093,7 +3097,7 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb,
                            data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3272,7 +3276,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         s1 = get_gpr(s, a->rs1, EXT_NONE);
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3320,7 +3324,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3426,7 +3430,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
 
         tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                              MAXSZ(s), MAXSZ(s), dest);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3454,7 +3458,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
                                  endian_ofs(s, a->rs2, a->rs1),
                                  MAXSZ(s), MAXSZ(s));
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3499,7 +3503,7 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            tcg_env, s->cfg_ptr->vlenb,
                            s->cfg_ptr->vlenb, data,
                            fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -3524,7 +3528,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
         }                                                               \
-        mark_vs_dirty(s);                                               \
+        finalize_rvv_inst(s);                                           \
         return true;                                                    \
     }                                                                   \
     return false;                                                       \
@@ -3595,7 +3599,7 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s->cfg_ptr->vlenb,
                        s->cfg_ptr->vlenb, data, fn);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 6d640e4596..ae1f40174a 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -174,7 +174,7 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                vreg_ofs(s, a->rs2), tcg_env,               \
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
                                data, fns[s->sew]);                         \
-            mark_vs_dirty(s);                                              \
+            finalize_rvv_inst(s);                                          \
             return true;                                                   \
         }                                                                  \
         return false;                                                      \
@@ -266,7 +266,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -341,7 +341,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -405,7 +405,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,          \
                                data, gen_helper_##NAME);                      \
                                                                               \
-            mark_vs_dirty(s);                                                 \
+            finalize_rvv_inst(s);                                             \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -457,7 +457,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -488,7 +488,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..09efc5f93c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -674,6 +674,12 @@ static void mark_vs_dirty(DisasContext *ctx)
 static inline void mark_vs_dirty(DisasContext *ctx) { }
 #endif
 
+static void finalize_rvv_inst(DisasContext *ctx)
+{
+    mark_vs_dirty(ctx);
+    ctx->vstart_eq_zero = true;
+}
+
 static void gen_set_rm(DisasContext *ctx, int rm)
 {
     if (ctx->frm == rm) {
-- 
2.43.2


