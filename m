Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D27AA736828
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXp3-00079n-7l; Tue, 20 Jun 2023 05:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp1-00079F-Ij
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXov-0006Mp-RK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:44 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNumUc5FkuyUHAA--.12676S3;
 Tue, 20 Jun 2023 17:38:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S26; 
 Tue, 20 Jun 2023 17:38:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 24/46] target/loongarch: Implement LASX logic instructions
Date: Tue, 20 Jun 2023 17:37:52 +0800
Message-Id: <20230620093814.123650-25-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S26
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
- XV{AND/OR/XOR/NOR/ANDN/ORN}.V;
- XV{AND/OR/XOR/NOR}I.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 12 ++++++
 target/loongarch/helper.h                    |  2 +
 target/loongarch/insn_trans/trans_lasx.c.inc | 42 ++++++++++++++++++++
 target/loongarch/insns.decode                | 13 ++++++
 target/loongarch/lasx_helper.c               | 11 +++++
 5 files changed, 80 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 82a9826eb7..2f1da9db80 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2028,6 +2028,18 @@ INSN_LASX(xvmsknz_b,         xx)
 
 INSN_LASX(xvldi,             x_i)
 
+INSN_LASX(xvand_v,           xxx)
+INSN_LASX(xvor_v,            xxx)
+INSN_LASX(xvxor_v,           xxx)
+INSN_LASX(xvnor_v,           xxx)
+INSN_LASX(xvandn_v,          xxx)
+INSN_LASX(xvorn_v,           xxx)
+
+INSN_LASX(xvandi_b,          xx_i)
+INSN_LASX(xvori_b,           xx_i)
+INSN_LASX(xvxori_b,          xx_i)
+INSN_LASX(xvnori_b,          xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b7ba78ee06..4e0a900318 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -929,3 +929,5 @@ DEF_HELPER_3(xvmskltz_w, void, env, i32, i32)
 DEF_HELPER_3(xvmskltz_d, void, env, i32, i32)
 DEF_HELPER_3(xvmskgez_b, void, env, i32, i32)
 DEF_HELPER_3(xvmsknz_b, void, env, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index bf277e1fd9..d48f76f118 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1935,6 +1935,48 @@ static bool trans_xvldi(DisasContext *ctx, arg_xvldi * a)
     return true;
 }
 
+TRANS(xvand_v, gvec_xxx, MO_64, tcg_gen_gvec_and)
+TRANS(xvor_v, gvec_xxx, MO_64, tcg_gen_gvec_or)
+TRANS(xvxor_v, gvec_xxx, MO_64, tcg_gen_gvec_xor)
+TRANS(xvnor_v, gvec_xxx, MO_64, tcg_gen_gvec_nor)
+
+static bool trans_xvandn_v(DisasContext *ctx, arg_xxx * a)
+{
+    uint32_t xd_ofs, xj_ofs, xk_ofs;
+
+    CHECK_ASXE;
+
+    xd_ofs = vec_full_offset(a->xd);
+    xj_ofs = vec_full_offset(a->xj);
+    xk_ofs = vec_full_offset(a->xk);
+
+    tcg_gen_gvec_andc(MO_64, xd_ofs, xk_ofs, xj_ofs, 32, ctx->vl / 8);
+    return true;
+}
+TRANS(xvorn_v, gvec_xxx, MO_64, tcg_gen_gvec_orc)
+TRANS(xvandi_b, gvec_xx_i, MO_8, tcg_gen_gvec_andi)
+TRANS(xvori_b, gvec_xx_i, MO_8, tcg_gen_gvec_ori)
+TRANS(xvxori_b, gvec_xx_i, MO_8, tcg_gen_gvec_xori)
+
+static void do_xvnori_b(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_nor_vec, 0
+        };
+    static const GVecGen2i op = {
+       .fni8 = gen_vnori_b,
+       .fniv = gen_vnori,
+       .fnoi = gen_helper_xvnori_b,
+       .opt_opc = vecop_list,
+       .vece = MO_8
+    };
+
+    tcg_gen_gvec_2i(xd_ofs, xj_ofs, oprsz, maxsz, imm, &op);
+}
+
+TRANS(xvnori_b, gvec_xx_i, MO_8, do_xvnori_b)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fbd0dd229a..ce2ad47b88 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1320,6 +1320,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx_ui4          .... ........ ..... . imm:4 xj:5 xd:5    &xx_i
 @xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
 @xx_ui6             .... ........ .... imm:6 xj:5 xd:5    &xx_i
+@xx_ui8               .... ........ .. imm:8 xj:5 xd:5    &xx_i
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1628,6 +1629,18 @@ xvmsknz_b        0111 01101001 11000 11000 ..... .....    @xx
 
 xvldi            0111 01111110 00 ............. .....     @x_i13
 
+xvand_v          0111 01010010 01100 ..... ..... .....    @xxx
+xvor_v           0111 01010010 01101 ..... ..... .....    @xxx
+xvxor_v          0111 01010010 01110 ..... ..... .....    @xxx
+xvnor_v          0111 01010010 01111 ..... ..... .....    @xxx
+xvandn_v         0111 01010010 10000 ..... ..... .....    @xxx
+xvorn_v          0111 01010010 10001 ..... ..... .....    @xxx
+
+xvandi_b         0111 01111101 00 ........ ..... .....    @xx_ui8
+xvori_b          0111 01111101 01 ........ ..... .....    @xx_ui8
+xvxori_b         0111 01111101 10 ........ ..... .....    @xx_ui8
+xvnori_b         0111 01111101 11 ........ ..... .....    @xx_ui8
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 6aec554645..8e8860c1bb 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -804,3 +804,14 @@ void HELPER(xvmsknz_b)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
         Xd->XD(2 * i + 1) = 0;
     }
 }
+
+void HELPER(xvnori_b)(void *xd, void *xj, uint64_t imm, uint32_t v)
+{
+    int i;
+    XReg *Xd = (XReg *)xd;
+    XReg *Xj = (XReg *)xj;
+
+    for (i = 0; i < LASX_LEN / 8; i++) {
+        Xd->XB(i) = ~(Xj->XB(i) | (uint8_t)imm);
+    }
+}
-- 
2.39.1


