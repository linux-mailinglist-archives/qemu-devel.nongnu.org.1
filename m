Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8EC7970A5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:11:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeA6e-000568-65; Thu, 07 Sep 2023 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeA69-0004nS-Ue
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:10:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeA66-0003lD-LJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:10:45 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxpPAzhflkWDQhAA--.753S3;
 Thu, 07 Sep 2023 16:09:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviMthflkXE1wAA--.31585S12; 
 Thu, 07 Sep 2023 16:09:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v5 10/57] target/loongarch: Replace CHECK_SXE to check_vec(ctx, 16)
Date: Thu,  7 Sep 2023 16:08:29 +0800
Message-Id: <20230907080916.3974502-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907080916.3974502-1-gaosong@loongson.cn>
References: <20230907080916.3974502-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviMthflkXE1wAA--.31585S12
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Intrudce a new function check_vec to replace CHECK_SXE

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_vec.c.inc | 248 +++++++++++++++-----
 1 file changed, 192 insertions(+), 56 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 41c2996e90..0985191c70 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5,14 +5,23 @@
  */
 
 #ifndef CONFIG_USER_ONLY
-#define CHECK_SXE do { \
-    if ((ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0) { \
-        generate_exception(ctx, EXCCODE_SXD); \
-        return true; \
-    } \
-} while (0)
+
+static bool check_vec(DisasContext *ctx, uint32_t oprsz)
+{
+    if ((oprsz == 16) && ((ctx->base.tb->flags & HW_FLAGS_EUEN_SXE) == 0)) {
+        generate_exception(ctx, EXCCODE_SXD);
+        return false;
+    }
+    return true;
+}
+
 #else
-#define CHECK_SXE
+
+static bool check_vec(DisasContext *ctx, uint32_t oprsz)
+{
+    return true;
+}
+
 #endif
 
 static bool gen_vvvv_ptr_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
@@ -30,7 +39,10 @@ static bool gen_vvvv_ptr_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
 static bool gen_vvvv_ptr(DisasContext *ctx, arg_vvvv *a,
                          gen_helper_gvec_4_ptr *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vvvv_ptr_vl(ctx, a, 16, fn);
 }
 
@@ -48,7 +60,10 @@ static bool gen_vvvv_vl(DisasContext *ctx, arg_vvvv *a, uint32_t oprsz,
 static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
                      gen_helper_gvec_4 *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vvvv_vl(ctx, a, 16, fn);
 }
 
@@ -66,7 +81,10 @@ static bool gen_vvv_ptr_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
 static bool gen_vvv_ptr(DisasContext *ctx, arg_vvv *a,
                         gen_helper_gvec_3_ptr *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vvv_ptr_vl(ctx, a, 16, fn);
 }
 
@@ -82,7 +100,10 @@ static bool gen_vvv_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
 
 static bool gen_vvv(DisasContext *ctx, arg_vvv *a, gen_helper_gvec_3 *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vvv_vl(ctx, a, 16, fn);
 }
 
@@ -99,7 +120,10 @@ static bool gen_vv_ptr_vl(DisasContext *ctx, arg_vv *a, uint32_t oprsz,
 static bool gen_vv_ptr(DisasContext *ctx, arg_vv *a,
                        gen_helper_gvec_2_ptr *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vv_ptr_vl(ctx, a, 16, fn);
 }
 
@@ -114,7 +138,10 @@ static bool gen_vv_vl(DisasContext *ctx, arg_vv *a, uint32_t oprsz,
 
 static bool gen_vv(DisasContext *ctx, arg_vv *a, gen_helper_gvec_2 *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vv_vl(ctx, a, 16, fn);
 }
 
@@ -130,7 +157,10 @@ static bool gen_vv_i_vl(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz,
 
 static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a, gen_helper_gvec_2i *fn)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gen_vv_i_vl(ctx, a, 16, fn);
 }
 
@@ -140,7 +170,10 @@ static bool gen_cv(DisasContext *ctx, arg_cv *a,
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 cd = tcg_constant_i32(a->cd);
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     func(cpu_env, cd, vj);
     return true;
 }
@@ -162,7 +195,10 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gvec_vvv_vl(ctx, a, 16, mop, func);
 }
 
@@ -184,7 +220,10 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
                     void (*func)(unsigned, uint32_t, uint32_t,
                                  uint32_t, uint32_t))
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gvec_vv_vl(ctx, a, 16, mop, func);
 }
 
@@ -204,7 +243,10 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
                       void (*func)(unsigned, uint32_t, uint32_t,
                                    int64_t, uint32_t, uint32_t))
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gvec_vv_i_vl(ctx, a, 16, mop, func);
 }
 
@@ -220,7 +262,10 @@ static bool gvec_subi_vl(DisasContext *ctx, arg_vv_i *a,
 
 static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     return gvec_subi_vl(ctx, a, 16, mop);
 }
 
@@ -238,7 +283,9 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
         return false;                                          \
     }                                                          \
                                                                \
-    CHECK_SXE;                                                 \
+    if (!check_vec(ctx, 16)) {                                 \
+        return true;                                           \
+    }                                                          \
                                                                \
     rh = tcg_temp_new_i64();                                   \
     rl = tcg_temp_new_i64();                                   \
@@ -3138,7 +3185,9 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     sel = (a->imm >> 12) & 0x1;
 
@@ -3168,7 +3217,9 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3795,7 +3846,9 @@ static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
@@ -3841,7 +3894,9 @@ static bool do_## NAME ##_s(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    if (!check_vec(ctx, 16)) {                                         \
+        return true;                                                   \
+    }                                                                  \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3890,7 +3945,9 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 {                                                                      \
     uint32_t vd_ofs, vj_ofs;                                           \
                                                                        \
-    CHECK_SXE;                                                         \
+    if (!check_vec(ctx, 16)) {                                         \
+        return true;                                                   \
+    }                                                                  \
                                                                        \
     static const TCGOpcode vecop_list[] = {                            \
         INDEX_op_cmp_vec, 0                                            \
@@ -3988,7 +4045,9 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -4009,7 +4068,9 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
     flags = get_fcmp_flags(a->fcond >> 1);
@@ -4024,7 +4085,9 @@ static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
                         vec_full_offset(a->vk), vec_full_offset(a->vj),
@@ -4050,7 +4113,9 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
                     16, ctx->vl/8, a->imm, &op);
@@ -4073,7 +4138,10 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
         return false;                                                          \
     }                                                                          \
                                                                                \
-    CHECK_SXE;                                                                 \
+    if (!check_vec(ctx, 16)) {                                                 \
+        return true;                                                           \
+    }                                                                          \
+                                                                               \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
     tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
@@ -4101,7 +4169,10 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
@@ -4115,7 +4186,10 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
@@ -4129,7 +4203,10 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
@@ -4143,7 +4220,10 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
@@ -4157,7 +4237,10 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4171,7 +4254,10 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4185,7 +4271,10 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4199,7 +4288,10 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4213,7 +4305,10 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
@@ -4227,7 +4322,10 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
@@ -4241,7 +4339,10 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
@@ -4255,7 +4356,10 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
@@ -4269,7 +4373,9 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
                          16, ctx->vl/8, src);
@@ -4287,7 +4393,10 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.B((a->imm))),
@@ -4301,7 +4410,10 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.H((a->imm))),
@@ -4314,7 +4426,10 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.W((a->imm))),
@@ -4327,7 +4442,10 @@ static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
+
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
                                   fpr[a->vj].vreg.D((a->imm))),
@@ -4346,7 +4464,9 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
     tcg_gen_shli_i64(t0, t0, vece);
@@ -4376,7 +4496,9 @@ static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4410,7 +4532,9 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     desthigh = tcg_temp_new_i64();
     destlow = tcg_temp_new_i64();
@@ -4488,7 +4612,9 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4515,7 +4641,9 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
@@ -4542,7 +4670,9 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
@@ -4569,7 +4699,9 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
         return false;
     }
 
-    CHECK_SXE;
+    if (!check_vec(ctx, 16)) {
+        return true;
+    }
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
@@ -4596,7 +4728,9 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
         return false;                                                     \
     }                                                                     \
                                                                           \
-    CHECK_SXE;                                                            \
+    if (!check_vec(ctx, 16)) {                                            \
+        return true;                                                      \
+    }                                                                     \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
     val = tcg_temp_new_i64();                                             \
@@ -4624,7 +4758,9 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
         return false;                                                        \
     }                                                                        \
                                                                              \
-    CHECK_SXE;                                                               \
+    if (!check_vec(ctx, 16)) {                                               \
+        return true;                                                         \
+    }                                                                        \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
     val = tcg_temp_new_i64();                                                \
-- 
2.39.1


