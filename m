Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DF812E6D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 12:20:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDjkI-00083I-Lm; Thu, 14 Dec 2023 06:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1rDjkG-00080e-V2; Thu, 14 Dec 2023 06:19:13 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1rDjkD-0004lS-Vi; Thu, 14 Dec 2023 06:19:12 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 48783C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1702552743;
 bh=rAfvYXr2es2x9o+gYMoNb4gykqE7I5l9CzULkAWfqwE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ZHDXkKdWFrFmNY/gRHzG1Nkb239l7EuDTC0Hkqk35ww67PZ0W8TDD1KbIa0gbRwzu
 IqAkc7CPTSlVmkFuSarlQXPUQMORlYoXtcw9A7FBV1xz1SPNwzJbKMX4tf/rxI4jRZ
 3O5lQWxOEx4cey/VdQGvWQKVImNscX9EOfxZraokskZnabW5ynUXkBmEPPxlE+W3LZ
 r17m//z98EM9FOZwBgN0oYtwtyCtP3Yl8ubtn45Qm79fDjNRTkQf6QlGB1Iuqo8ZeQ
 URe7SiT91eLitNxVdVQgn6xuk4L59T/uN6Gsvw0YhrlbLVBc17uSRUOmY4asX8aH4h
 Y8CYPF5isttrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1702552743;
 bh=rAfvYXr2es2x9o+gYMoNb4gykqE7I5l9CzULkAWfqwE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=b5qPqNM9VHx9MNVUwsDiTtmt7jUDERbJ/c9G8ff/Z+JVS9dpRUJ5aiA9IGaSRljym
 VNCFXhDRhOK9Z43rYPntnoxDFRLW4QuQocI0i1N5VxGyXP7d2PuBZahFVbcmhfDBkT
 /mBmJ8FI18TuAdY9QY0QdA/XwuuTR+AqsUGkJZNtyAeRDga2bM4/U94VjlLzvEQGAF
 Nj5gwmBKpk6k9fDAbd+4dQxF2z15Rv/yOL95DrfajpLyFhFPKFkpGkcAALU9OVz4yt
 CW40qWEox4qI5vA4FI+1qzprYcym/yRNluQFRxyLjat+qWJbxC4IOdVapnS5begalp
 7PHcxpt8eoCMQ==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <richard.henderson@linaro.org>, Ivan Klokov
 <ivan.klokov@syntacore.com>
Subject: [PATCH 1/1] target/riscv: Clear vstart_qe_zero flag
Date: Thu, 14 Dec 2023 14:18:51 +0300
Message-ID: <20231214111851.142532-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The vstart_qe_zero flag is set at the beginning of the translation
phase from the env->vstart variable. During the execution phase, some
instructions may change env->vstart, but the flag remains the same as
at the start of the block. With some combinations of instructions this
causes an illegal instruction exception. This patch simultaneously
updates flag and env->vstart and to avoid inconsistency.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  6 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 88 +++++++++++-----------
 target/riscv/insn_trans/trans_rvvk.c.inc   | 12 +--
 target/riscv/translate.c                   | 12 ++-
 4 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 4e39c00884..2867bbc2bb 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -86,7 +86,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
                            ctx->cfg_ptr->vlen / 8,
                            ctx->cfg_ptr->vlen / 8, data,
                            gen_helper_vfncvtbf16_f_f_w);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
@@ -115,7 +115,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
                            ctx->cfg_ptr->vlen / 8,
                            ctx->cfg_ptr->vlen / 8, data,
                            gen_helper_vfwcvtbf16_f_f_v);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
@@ -146,7 +146,7 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
                            ctx->cfg_ptr->vlen / 8,
                            ctx->cfg_ptr->vlen / 8, data,
                            gen_helper_vfwmaccbf16_vv);
-        mark_vs_dirty(ctx);
+        finalize_rvv_inst(ctx);
         gen_set_label(over);
         return true;
     }
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 78bd363310..fcf49f7352 100644
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
@@ -639,7 +639,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     if (!is_store) {
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     }
 
     gen_set_label(over);
@@ -800,7 +800,7 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     fn(dest, mask, base, stride, tcg_env, desc);
 
     if (!is_store) {
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     }
 
     gen_set_label(over);
@@ -907,7 +907,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, base, index, tcg_env, desc);
 
     if (!is_store) {
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     }
 
     gen_set_label(over);
@@ -1044,7 +1044,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     fn(dest, mask, base, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -1105,7 +1105,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     fn(dest, base, tcg_env, desc);
 
     if (!is_store) {
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     }
     gen_set_label(over);
 
@@ -1202,7 +1202,7 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            tcg_env, s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8, data, fn);
     }
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -1257,7 +1257,7 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -1283,7 +1283,7 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1419,7 +1419,7 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
 
     fn(dest, mask, src1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -1434,7 +1434,7 @@ do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 extract_imm(s, a->rs1, imm_mode), MAXSZ(s), MAXSZ(s));
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, imm_mode);
@@ -1495,7 +1495,7 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8,
                            data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -1570,7 +1570,7 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            vreg_ofs(s, a->rs2),
                            tcg_env, s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -1641,7 +1641,7 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
     tcg_gen_gvec_4_ptr(vreg_ofs(s, vd), vreg_ofs(s, 0), vreg_ofs(s, vs1),
                        vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlen / 8,
                        s->cfg_ptr->vlen / 8, data, fn);
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -1775,7 +1775,7 @@ do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
         gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                 src1, MAXSZ(s), MAXSZ(s));
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1834,7 +1834,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2041,7 +2041,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                                fns[s->sew]);
             gen_set_label(over);
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         return true;
     }
     return false;
@@ -2088,7 +2088,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
             fns[s->sew](dest, s1_i64, tcg_env, desc);
         }
 
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -2105,7 +2105,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
-            mark_vs_dirty(s);
+            finalize_rvv_inst(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -2126,7 +2126,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
             fns[s->sew](dest, s1, tcg_env, desc);
 
-            mark_vs_dirty(s);
+            finalize_rvv_inst(s);
             gen_set_label(over);
         }
         return true;
@@ -2278,7 +2278,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2316,7 +2316,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, t1, src2, tcg_env, desc);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
@@ -2394,7 +2394,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s->cfg_ptr->vlen / 8,                 \
                            s->cfg_ptr->vlen / 8, data,           \
                            fns[s->sew - 1]);                     \
-        mark_vs_dirty(s);                                        \
+        finalize_rvv_inst(s);                                        \
         gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
@@ -2468,7 +2468,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2583,7 +2583,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8, data, fn);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -2671,7 +2671,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
-            mark_vs_dirty(s);
+            finalize_rvv_inst(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2697,7 +2697,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             fns[s->sew - 1](dest, t1, tcg_env, desc);
 
-            mark_vs_dirty(s);
+            finalize_rvv_inst(s);
             gen_set_label(over);
         }
         return true;
@@ -2773,7 +2773,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2824,7 +2824,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2891,7 +2891,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew - 1]);                       \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2940,7 +2940,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data,             \
                            fns[s->sew]);                           \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -3029,7 +3029,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            vreg_ofs(s, a->rs2), tcg_env,           \
                            s->cfg_ptr->vlen / 8,                   \
                            s->cfg_ptr->vlen / 8, data, fn);        \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -3131,7 +3131,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            tcg_env, s->cfg_ptr->vlen / 8,          \
                            s->cfg_ptr->vlen / 8,                   \
                            data, fn);                              \
-        mark_vs_dirty(s);                                          \
+        finalize_rvv_inst(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -3173,7 +3173,7 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            vreg_ofs(s, a->rs2), tcg_env,
                            s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8, data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -3203,7 +3203,7 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            tcg_env, s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8,
                            data, fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -3386,7 +3386,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         s1 = get_gpr(s, a->rs1, EXT_NONE);
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -3439,7 +3439,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
         vec_element_storei(s, a->rd, 0, t1);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -3547,7 +3547,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
 
         tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                              MAXSZ(s), MAXSZ(s), dest);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3576,7 +3576,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
                                  endian_ofs(s, a->rs2, a->rs1),
                                  MAXSZ(s), MAXSZ(s));
         }
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -3623,7 +3623,7 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            tcg_env, s->cfg_ptr->vlen / 8,
                            s->cfg_ptr->vlen / 8, data,
                            fns[s->sew]);
-        mark_vs_dirty(s);
+        finalize_rvv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -3645,13 +3645,13 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
             /* EEW = 8 */                                               \
             tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),                  \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
-            mark_vs_dirty(s);                                           \
+            finalize_rvv_inst(s);                                           \
         } else {                                                        \
             TCGLabel *over = gen_new_label();                           \
             tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
-            mark_vs_dirty(s);                                           \
+            finalize_rvv_inst(s);                                           \
             gen_set_label(over);                                        \
         }                                                               \
         return true;                                                    \
@@ -3726,7 +3726,7 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s->cfg_ptr->vlen / 8,
                        s->cfg_ptr->vlen / 8, data, fn);
 
-    mark_vs_dirty(s);
+    finalize_rvv_inst(s);
     gen_set_label(over);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 3801c16829..1662cbdec4 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -176,7 +176,7 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                vreg_ofs(s, a->rs2), tcg_env,               \
                                s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8, \
                                data, fns[s->sew]);                         \
-            mark_vs_dirty(s);                                              \
+            finalize_rrv_inst(s);                                              \
             gen_set_label(over);                                           \
             return true;                                                   \
         }                                                                  \
@@ -271,7 +271,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
-            mark_vs_dirty(s);                                                 \
+            finalize_rrv_inst(s);                                                 \
             gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
@@ -349,7 +349,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rd_v, tcg_env, vreg_ofs(s, a->rd));              \
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
-            mark_vs_dirty(s);                                                 \
+            finalize_rrv_inst(s);                                                 \
             gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
@@ -416,7 +416,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8,    \
                                data, gen_helper_##NAME);                      \
                                                                               \
-            mark_vs_dirty(s);                                                 \
+            finalize_rrv_inst(s);                                                 \
             gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
@@ -471,7 +471,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rrv_inst(s);
         gen_set_label(over);
         return true;
     }
@@ -505,7 +505,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             s->sew == MO_32 ?
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
-        mark_vs_dirty(s);
+        finalize_rrv_inst(s);
         gen_set_label(over);
         return true;
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..d4147e2dd7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -670,8 +670,18 @@ static void mark_vs_dirty(DisasContext *ctx)
         }
     }
 }
+static void set_vstart_eq_zero(DisasContext *ctx)
+{
+    ctx->vstart_eq_zero = true;
+}
+
+static void finalize_rvv_inst(DisasContext *ctx)
+{
+    mark_vs_dirty(ctx);
+    set_vstart_eq_zero(ctx);
+}
 #else
-static inline void mark_vs_dirty(DisasContext *ctx) { }
+static inline void finalize_rvv_inst(DisasContext *ctx){ }
 #endif
 
 static void gen_set_rm(DisasContext *ctx, int rm)
-- 
2.34.1


