Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5566BDC75A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 06:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t5c-0000FN-8n; Wed, 15 Oct 2025 00:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5Y-0000Db-DA; Wed, 15 Oct 2025 00:26:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5S-0002nk-CI; Wed, 15 Oct 2025 00:26:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D1D215D9CE;
 Wed, 15 Oct 2025 07:24:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 111E429FE77;
 Wed, 15 Oct 2025 07:25:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 09/11] target/riscv: rvv: Fix vslide1[up|down].vx
 unexpected result when XLEN=32 and SEW=64
Date: Wed, 15 Oct 2025 07:25:13 +0300
Message-ID: <20251015042520.68556-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

When XLEN is 32 and SEW is 64, the original implementation of
vslide1up.vx and vslide1down.vx helper functions fills the 32-bit value
of rs1 into the first element of the destination vector register (rd),
which is a 64-bit element.

This commit attempted to resolve the issue by extending the rs1 value
to 64 bits during the TCG translation phase to ensure that the helper
functions won't lost the higer 32 bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250124073325.2467664-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 81d1885dcc4424fec6761120f6e251eb3408fb8e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c82bacdc39..b785456ee0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1101,14 +1101,14 @@ DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, i64, ptr, env, i32)
 
 DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 71f98fb350..f4b5460340 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3561,7 +3561,6 @@ static bool slideup_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
-GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
 GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
 
 static bool slidedown_check(DisasContext *s, arg_rmrr *a)
@@ -3572,9 +3571,56 @@ static bool slidedown_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
-GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
+typedef void gen_helper_vslide1_vx(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
+                                TCGv_env, TCGv_i32);
+
+#define GEN_OPIVX_VSLIDE1_TRANS(NAME, CHECK)                            \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        static gen_helper_vslide1_vx * const fns[4] = {                 \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,               \
+        };                                                              \
+                                                                        \
+        TCGv_ptr dest, src2, mask;                                      \
+        TCGv_i64 src1;                                                  \
+        TCGv_i32 desc;                                                  \
+        uint32_t data = 0;                                              \
+                                                                        \
+        dest = tcg_temp_new_ptr();                                      \
+        mask = tcg_temp_new_ptr();                                      \
+        src2 = tcg_temp_new_ptr();                                      \
+        src1 = tcg_temp_new_i64();                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
+                                s->cfg_ptr->vlenb, data));              \
+                                                                        \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
+        tcg_gen_ext_tl_i64(src1, get_gpr(s, a->rs1, EXT_SIGN));         \
+                                                                        \
+        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
+                                                                        \
+        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_OPIVX_VSLIDE1_TRANS(vslide1up_vx, slideup_check)
+GEN_OPIVX_VSLIDE1_TRANS(vslide1down_vx, slidedown_check)
+
 /* Vector Floating-Point Slide Instructions */
 static bool fslideup_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7c67d67a13..41ea223106 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5198,11 +5198,11 @@ GEN_VEXT_VSLIE1UP(16, H2)
 GEN_VEXT_VSLIE1UP(32, H4)
 GEN_VEXT_VSLIE1UP(64, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                     \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);             \
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
@@ -5249,11 +5249,11 @@ GEN_VEXT_VSLIDE1DOWN(16, H2)
 GEN_VEXT_VSLIDE1DOWN(32, H4)
 GEN_VEXT_VSLIDE1DOWN(64, H8)
 
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                   \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
-                  CPURISCVState *env, uint32_t desc)              \
-{                                                                 \
-    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                 \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);         \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
-- 
2.47.3


