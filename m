Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E0736836
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:45:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpT-0007Md-Ny; Tue, 20 Jun 2023 05:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp8-0007Cr-3L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp5-0006P3-BR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxvOqec5Fk3CUHAA--.14674S3;
 Tue, 20 Jun 2023 17:38:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S42; 
 Tue, 20 Jun 2023 17:38:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 40/46] target/loongarch: Implement xvbitsel xvset
Date: Tue, 20 Jun 2023 17:38:08 +0800
Message-Id: <20230620093814.123650-41-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S42
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch includes:
- XVBITSEL.V;
- XVBITSELI.B;
- XVSET{EQZ/NEZ}.V;
- XVSETANYEQZ.{B/H/W/D};
- XVSETALLNEZ.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 19 +++++
 target/loongarch/helper.h                    | 11 +++
 target/loongarch/insn_trans/trans_lasx.c.inc | 76 ++++++++++++++++++++
 target/loongarch/insns.decode                | 17 +++++
 target/loongarch/lasx_helper.c               | 37 ++++++++++
 target/loongarch/lsx_helper.c                |  2 +-
 target/loongarch/vec.h                       |  2 +
 7 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index c3bcb9d84a..5c2a81ee80 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1703,6 +1703,11 @@ static bool trans_##insn(DisasContext *ctx, arg_##type * a) \
     return true;                                            \
 }
 
+static void output_cx(DisasContext *ctx, arg_cx *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "fcc%d, x%d", a->cd, a->xj);
+}
+
 static void output_x_i(DisasContext *ctx, arg_x_i *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, 0x%x", a->xd, a->imm);
@@ -2478,6 +2483,20 @@ static bool trans_xvfcmp_cond_##suffix(DisasContext *ctx, \
 LASX_FCMP_INSN(s)
 LASX_FCMP_INSN(d)
 
+INSN_LASX(xvbitsel_v,        xxxx)
+INSN_LASX(xvbitseli_b,       xx_i)
+
+INSN_LASX(xvseteqz_v,        cx)
+INSN_LASX(xvsetnez_v,        cx)
+INSN_LASX(xvsetanyeqz_b,     cx)
+INSN_LASX(xvsetanyeqz_h,     cx)
+INSN_LASX(xvsetanyeqz_w,     cx)
+INSN_LASX(xvsetanyeqz_d,     cx)
+INSN_LASX(xvsetallnez_b,     cx)
+INSN_LASX(xvsetallnez_h,     cx)
+INSN_LASX(xvsetallnez_w,     cx)
+INSN_LASX(xvsetallnez_d,     cx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 665bcb812a..f6d64bfde5 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1221,3 +1221,14 @@ DEF_HELPER_5(xvfcmp_c_s, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(xvfcmp_s_s, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(xvfcmp_c_d, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(xvfcmp_s_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvbitseli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_3(xvsetanyeqz_b, void, env, i32, i32)
+DEF_HELPER_3(xvsetanyeqz_h, void, env, i32, i32)
+DEF_HELPER_3(xvsetanyeqz_w, void, env, i32, i32)
+DEF_HELPER_3(xvsetanyeqz_d, void, env, i32, i32)
+DEF_HELPER_3(xvsetallnez_b, void, env, i32, i32)
+DEF_HELPER_3(xvsetallnez_h, void, env, i32, i32)
+DEF_HELPER_3(xvsetallnez_w, void, env, i32, i32)
+DEF_HELPER_3(xvsetallnez_d, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cdcd4a279a..cefb6a4973 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -65,6 +65,17 @@ static bool gen_xx_i(DisasContext *ctx, arg_xx_i *a,
     return true;
 }
 
+static bool gen_cx(DisasContext *ctx, arg_cx *a,
+                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 cd = tcg_constant_i32(a->cd);
+
+    CHECK_ASXE;
+    func(cpu_env, cd, xj);
+    return true;
+}
+
 static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
                      void (*func)(unsigned, uint32_t, uint32_t,
                                   uint32_t, uint32_t, uint32_t))
@@ -2706,6 +2717,71 @@ static bool trans_xvfcmp_cond_d(DisasContext *ctx, arg_xxx_fcond *a)
     return true;
 }
 
+static bool trans_xvbitsel_v(DisasContext *ctx, arg_xxxx *a)
+{
+    CHECK_ASXE;
+
+    tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->xd), vec_full_offset(a->xa),
+                        vec_full_offset(a->xk), vec_full_offset(a->xj),
+                        32, ctx->vl / 8);
+    return true;
+}
+
+static bool trans_xvbitseli_b(DisasContext *ctx, arg_xx_i *a)
+{
+    static const GVecGen2i op = {
+       .fniv = gen_vbitseli,
+       .fnoi = gen_helper_xvbitseli_b,
+       .vece = MO_8,
+       .load_dest = true
+    };
+
+    CHECK_ASXE;
+
+    tcg_gen_gvec_2i(vec_full_offset(a->xd), vec_full_offset(a->xj),
+                    32, ctx->vl / 8, a->imm, &op);
+    return true;
+}
+
+#define XVSET(NAME, COND)                                                      \
+static bool trans_## NAME(DisasContext *ctx, arg_cx * a)                       \
+{                                                                              \
+    TCGv_i64 t1, t2, d[4];                                                     \
+                                                                               \
+    d[0] = tcg_temp_new_i64();                                                 \
+    d[1] = tcg_temp_new_i64();                                                 \
+    d[2] = tcg_temp_new_i64();                                                 \
+    d[3] = tcg_temp_new_i64();                                                 \
+    t1 = tcg_temp_new_i64();                                                   \
+    t2 = tcg_temp_new_i64();                                                   \
+                                                                               \
+    get_xreg64(d[0], a->xj, 0);                                                \
+    get_xreg64(d[1], a->xj, 1);                                                \
+    get_xreg64(d[2], a->xj, 2);                                                \
+    get_xreg64(d[3], a->xj, 3);                                                \
+                                                                               \
+    CHECK_ASXE;                                                                \
+    tcg_gen_or_i64(t1, d[0], d[1]);                                            \
+    tcg_gen_or_i64(t2, d[2], d[3]);                                            \
+    tcg_gen_or_i64(t1, t2, t1);                                                \
+    tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
+    tcg_gen_st8_tl(t1, cpu_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
+                                                                               \
+    return true;                                                               \
+}
+
+XVSET(xvseteqz_v, TCG_COND_EQ)
+XVSET(xvsetnez_v, TCG_COND_NE)
+
+TRANS(xvsetanyeqz_b, gen_cx, gen_helper_xvsetanyeqz_b)
+TRANS(xvsetanyeqz_h, gen_cx, gen_helper_xvsetanyeqz_h)
+TRANS(xvsetanyeqz_w, gen_cx, gen_helper_xvsetanyeqz_w)
+TRANS(xvsetanyeqz_d, gen_cx, gen_helper_xvsetanyeqz_d)
+TRANS(xvsetallnez_b, gen_cx, gen_helper_xvsetallnez_b)
+TRANS(xvsetallnez_h, gen_cx, gen_helper_xvsetallnez_h)
+TRANS(xvsetallnez_w, gen_cx, gen_helper_xvsetallnez_w)
+TRANS(xvsetallnez_d, gen_cx, gen_helper_xvsetallnez_d)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index df45dc3d76..b696d99577 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1308,6 +1308,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &x_i          xd imm
 &xxxx         xd xj xk xa
 &xxx_fcond    xd xj xk fcond
+&cx           cd xj
 
 #
 # LASX Formats
@@ -1326,6 +1327,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx_ui8               .... ........ .. imm:8 xj:5 xd:5    &xx_i
 @xxxx                .... ........ xa:5 xk:5 xj:5 xd:5    &xxxx
 @xxx_fcond        .... ........ fcond:5 xk:5 xj:5 xd:5    &xxx_fcond
+@cx             .... ........ ..... ..... xj:5 .. cd:3    &cx
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1988,6 +1990,21 @@ xvslti_du        0111 01101000 10011 ..... ..... .....    @xx_ui5
 xvfcmp_cond_s    0000 11001001 ..... ..... ..... .....    @xxx_fcond
 xvfcmp_cond_d    0000 11001010 ..... ..... ..... .....    @xxx_fcond
 
+xvbitsel_v       0000 11010010 ..... ..... ..... .....    @xxxx
+
+xvbitseli_b      0111 01111100 01 ........ ..... .....    @xx_ui8
+
+xvseteqz_v       0111 01101001 11001 00110 ..... 00 ...   @cx
+xvsetnez_v       0111 01101001 11001 00111 ..... 00 ...   @cx
+xvsetanyeqz_b    0111 01101001 11001 01000 ..... 00 ...   @cx
+xvsetanyeqz_h    0111 01101001 11001 01001 ..... 00 ...   @cx
+xvsetanyeqz_w    0111 01101001 11001 01010 ..... 00 ...   @cx
+xvsetanyeqz_d    0111 01101001 11001 01011 ..... 00 ...   @cx
+xvsetallnez_b    0111 01101001 11001 01100 ..... 00 ...   @cx
+xvsetallnez_h    0111 01101001 11001 01101 ..... 00 ...   @cx
+xvsetallnez_w    0111 01101001 11001 01110 ..... 00 ...   @cx
+xvsetallnez_d    0111 01101001 11001 01111 ..... 00 ...   @cx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 1d56fe7b22..56dfe10a0d 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2782,3 +2782,40 @@ XVFCMP(xvfcmp_c_s, 32, UXW, float32_compare_quiet)
 XVFCMP(xvfcmp_s_s, 32, UXW, float32_compare)
 XVFCMP(xvfcmp_c_d, 64, UXD, float64_compare_quiet)
 XVFCMP(xvfcmp_s_d, 64, UXD, float64_compare)
+
+void HELPER(xvbitseli_b)(void *xd, void *xj,  uint64_t imm, uint32_t v)
+{
+    int i;
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Xd->XB(i) = (~Xd->XB(i) & Xj->XB(i)) | (Xd->XB(i) & imm);
+    }
+}
+
+#define XSETANYEQZ(NAME, MO)                                        \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t cd, uint32_t xj) \
+{                                                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    env->cf[cd & 0x7] = do_match2(0, Xj->XD(0), Xj->XD(1), MO) ||   \
+                        do_match2(0, Xj->XD(2), Xj->XD(3), MO);     \
+}
+XSETANYEQZ(xvsetanyeqz_b, MO_8)
+XSETANYEQZ(xvsetanyeqz_h, MO_16)
+XSETANYEQZ(xvsetanyeqz_w, MO_32)
+XSETANYEQZ(xvsetanyeqz_d, MO_64)
+
+#define XSETALLNEZ(NAME, MO)                                        \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t cd, uint32_t xj) \
+{                                                                   \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    env->cf[cd & 0x7] = !do_match2(0, Xj->XD(0), Xj->XD(1), MO) &&  \
+                        !do_match2(0, Xj->XD(2), Xj->XD(3), MO);    \
+}
+XSETALLNEZ(xvsetallnez_b, MO_8)
+XSETALLNEZ(xvsetallnez_h, MO_16)
+XSETALLNEZ(xvsetallnez_w, MO_32)
+XSETALLNEZ(xvsetallnez_d, MO_64)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 4a5c1a47a1..00c9835948 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -2688,7 +2688,7 @@ void HELPER(vbitseli_b)(void *vd, void *vj,  uint64_t imm, uint32_t v)
 }
 
 /* Copy from target/arm/tcg/sve_helper.c */
-static inline bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
+bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
 {
     uint64_t bits = 8 << esz;
     uint64_t ones = dup_const(esz, 1);
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 134dd265bf..cfac1c0e1c 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -118,4 +118,6 @@ uint64_t do_frsqrt_64(CPULoongArchState *env, uint64_t fj);
 uint64_t vfcmp_common(CPULoongArchState *env,
                       FloatRelation cmp, uint32_t flags);
 
+bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz);
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


