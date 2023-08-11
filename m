Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0D778A99
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOyQ-0006Te-8F; Fri, 11 Aug 2023 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qUOyK-0006Mm-UJ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qUOyG-0002Em-El
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjuslB9ZkxYAVAA--.43424S3;
 Fri, 11 Aug 2023 18:02:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSMhB9ZkBcpUAA--.61494S5; 
 Fri, 11 Aug 2023 18:02:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, c@jia.je
Subject: [PATCH v2 3/8] target/loongarch: Add avail_64 to check la64-only
 instructions
Date: Fri, 11 Aug 2023 18:02:03 +0800
Message-Id: <20230811100208.271649-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230811100208.271649-1-gaosong@loongson.cn>
References: <20230811100208.271649-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSMhB9ZkBcpUAA--.61494S5
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

The la32 manual from [1], and it is not the final version.

[1]: https://www.loongson.cn/uploads/images/2023041918122813624.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%8432%E4%BD%8D%E7%B2%BE%E7%AE%80%E7%89%88%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C_r1p03.pdf

Co-authored-by: Jiajie Chen <c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_arith.c.inc | 48 +++++++-----
 .../loongarch/insn_trans/trans_atomic.c.inc   | 76 +++++++++----------
 target/loongarch/insn_trans/trans_bit.c.inc   | 56 +++++++-------
 .../loongarch/insn_trans/trans_branch.c.inc   |  4 +-
 target/loongarch/insn_trans/trans_extra.c.inc | 28 +++++--
 target/loongarch/insn_trans/trans_fmov.c.inc  |  4 +-
 .../loongarch/insn_trans/trans_memory.c.inc   | 68 ++++++++---------
 target/loongarch/insn_trans/trans_shift.c.inc | 24 +++---
 target/loongarch/translate.h                  |  2 +
 9 files changed, 170 insertions(+), 140 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index d7f69a7553..2c8b4e23cd 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -199,6 +199,10 @@ static bool trans_lu32i_d(DisasContext *ctx, arg_lu32i_d *a)
     TCGv src1 = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv src2 = tcg_constant_tl(a->imm);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_deposit_tl(dest, src1, src2, 32, 32);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -211,6 +215,10 @@ static bool trans_lu52i_d(DisasContext *ctx, arg_lu52i_d *a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = tcg_constant_tl(a->imm);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_deposit_tl(dest, src1, src2, 52, 12);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -242,6 +250,10 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_addi_tl(dest, src1, a->imm << 16);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -249,9 +261,9 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
 }
 
 TRANS(add_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
-TRANS(add_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
+TRANS(add_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
 TRANS(sub_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
-TRANS(sub_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
+TRANS(sub_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
 TRANS(and, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
 TRANS(or, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
 TRANS(xor, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
@@ -261,32 +273,32 @@ TRANS(orn, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
 TRANS(slt, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltu, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(mul_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
-TRANS(mul_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mul_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
 TRANS(mulh_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
 TRANS(mulh_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
-TRANS(mulh_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
-TRANS(mulh_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
-TRANS(mulw_d_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
-TRANS(mulw_d_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulh_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
+TRANS(mulh_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
+TRANS(mulw_d_w, 64, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulw_d_wu, 64, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
 TRANS(div_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
 TRANS(mod_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
 TRANS(div_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
 TRANS(mod_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
-TRANS(div_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
-TRANS(mod_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
-TRANS(div_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
-TRANS(mod_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
+TRANS(div_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
+TRANS(mod_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
+TRANS(div_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
+TRANS(mod_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
 TRANS(slti, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltui, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(addi_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
-TRANS(addi_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
-TRANS(alsl_w, ALL, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
-TRANS(alsl_wu, ALL, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
-TRANS(alsl_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
-TRANS(pcaddi, ALL, gen_pc, gen_pcaddi)
-TRANS(pcalau12i, ALL, gen_pc, gen_pcalau12i)
+TRANS(addi_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
+TRANS(alsl_w, 64, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
+TRANS(alsl_wu, 64, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
+TRANS(alsl_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
+TRANS(pcaddi, 64, gen_pc, gen_pcaddi)
+TRANS(pcalau12i, 64, gen_pc, gen_pcalau12i)
 TRANS(pcaddu12i, ALL, gen_pc, gen_pcaddu12i)
-TRANS(pcaddu18i, ALL, gen_pc, gen_pcaddu18i)
+TRANS(pcaddu18i, 64, gen_pc, gen_pcaddu18i)
 TRANS(andi, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
 TRANS(ori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
 TRANS(xori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 0a02f0dbf3..194818d74d 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -71,41 +71,41 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
 TRANS(ll_w, ALL, gen_ll, MO_TESL)
 TRANS(sc_w, ALL, gen_sc, MO_TESL)
-TRANS(ll_d, ALL, gen_ll, MO_TEUQ)
-TRANS(sc_d, ALL, gen_sc, MO_TEUQ)
-TRANS(amswap_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_db_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_db_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_db_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(ll_d, 64, gen_ll, MO_TEUQ)
+TRANS(sc_d, 64, gen_sc, MO_TEUQ)
+TRANS(amswap_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(amswap_db_w, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_db_d, 64, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_db_w, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_db_d, 64, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_db_w, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_db_d, 64, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_db_w, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_db_d, 64, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_db_w, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_db_d, 64, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_db_w, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_db_d, 64, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_db_w, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_db_d, 64, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_db_du, 64, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_db_wu, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_db_du, 64, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index d2a7ac28f7..e4153406fb 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -178,31 +178,31 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
-TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
-TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
-TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
-TRANS(clz_w, ALL, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
-TRANS(cto_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
-TRANS(ctz_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
-TRANS(clo_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
-TRANS(clz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
-TRANS(cto_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
-TRANS(ctz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
-TRANS(revb_2h, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS(revb_4h, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
-TRANS(revb_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS(revb_d, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
-TRANS(revh_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS(revh_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
-TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
-TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
-TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
-TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-TRANS(bytepick_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
-TRANS(bstrins_w, ALL, gen_bstrins, EXT_SIGN)
-TRANS(bstrins_d, ALL, gen_bstrins, EXT_NONE)
-TRANS(bstrpick_w, ALL, gen_bstrpick, EXT_SIGN)
-TRANS(bstrpick_d, ALL, gen_bstrpick, EXT_NONE)
+TRANS(ext_w_h, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
+TRANS(ext_w_b, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
+TRANS(clo_w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
+TRANS(clz_w, 64, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
+TRANS(cto_w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
+TRANS(ctz_w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
+TRANS(clo_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
+TRANS(clz_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
+TRANS(cto_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
+TRANS(ctz_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
+TRANS(revb_2h, 64, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
+TRANS(revb_4h, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
+TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
+TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS(bitrev_4b, 64, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS(bitrev_w, 64, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
+TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(maskeqz, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
+TRANS(masknez, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
+TRANS(bytepick_w, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
+TRANS(bytepick_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
+TRANS(bstrins_w, 64, gen_bstrins, EXT_SIGN)
+TRANS(bstrins_d, 64, gen_bstrins, EXT_NONE)
+TRANS(bstrpick_w, 64, gen_bstrpick, EXT_SIGN)
+TRANS(bstrpick_d, 64, gen_bstrpick, EXT_NONE)
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index 50f7eb640a..a4fd2092e5 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
 TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
 TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
 TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
-TRANS(bceqz, ALL, gen_cz_bc, TCG_COND_EQ)
-TRANS(bcnez, ALL, gen_cz_bc, TCG_COND_NE)
+TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
+TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index b354ca0f86..9a21797951 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -20,6 +20,10 @@ static bool trans_asrtle_d(DisasContext *ctx, arg_asrtle_d * a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     gen_helper_asrtle_d(cpu_env, src1, src2);
     return true;
 }
@@ -29,6 +33,10 @@ static bool trans_asrtgt_d(DisasContext *ctx, arg_asrtgt_d * a)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     gen_helper_asrtgt_d(cpu_env, src1, src2);
     return true;
 }
@@ -69,6 +77,10 @@ static bool trans_cpucfg(DisasContext *ctx, arg_cpucfg *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     gen_helper_cpucfg(dest, cpu_env, src1);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -89,11 +101,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(crc_w_b_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
-TRANS(crc_w_h_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
-TRANS(crc_w_w_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS(crc_w_d_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
-TRANS(crcc_w_b_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
-TRANS(crcc_w_h_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
-TRANS(crcc_w_w_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS(crcc_w_d_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS(crc_w_b_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
+TRANS(crc_w_h_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
+TRANS(crc_w_w_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
+TRANS(crc_w_d_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS(crcc_w_b_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
+TRANS(crcc_w_h_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
+TRANS(crcc_w_w_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
+TRANS(crcc_w_d_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index aa7fea67b5..385bbb7929 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -181,8 +181,8 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
 TRANS(fmov_s, ALL, gen_f2f, tcg_gen_mov_tl, true)
 TRANS(fmov_d, ALL, gen_f2f, tcg_gen_mov_tl, false)
 TRANS(movgr2fr_w, ALL, gen_r2f, gen_movgr2fr_w)
-TRANS(movgr2fr_d, ALL, gen_r2f, tcg_gen_mov_tl)
+TRANS(movgr2fr_d, 64, gen_r2f, tcg_gen_mov_tl)
 TRANS(movgr2frh_w, ALL, gen_r2f, gen_movgr2frh_w)
 TRANS(movfr2gr_s, ALL, gen_f2r, tcg_gen_ext32s_tl)
-TRANS(movfr2gr_d, ALL, gen_f2r, tcg_gen_mov_tl)
+TRANS(movfr2gr_d, 64, gen_f2r, tcg_gen_mov_tl)
 TRANS(movfrh2gr_s, ALL, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index ad6a4b006d..d9d062235a 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -148,42 +148,42 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 TRANS(ld_b, ALL, gen_load, MO_SB)
 TRANS(ld_h, ALL, gen_load, MO_TESW)
 TRANS(ld_w, ALL, gen_load, MO_TESL)
-TRANS(ld_d, ALL, gen_load, MO_TEUQ)
+TRANS(ld_d, 64, gen_load, MO_TEUQ)
 TRANS(st_b, ALL, gen_store, MO_UB)
 TRANS(st_h, ALL, gen_store, MO_TEUW)
 TRANS(st_w, ALL, gen_store, MO_TEUL)
-TRANS(st_d, ALL, gen_store, MO_TEUQ)
+TRANS(st_d, 64, gen_store, MO_TEUQ)
 TRANS(ld_bu, ALL, gen_load, MO_UB)
 TRANS(ld_hu, ALL, gen_load, MO_TEUW)
-TRANS(ld_wu, ALL, gen_load, MO_TEUL)
-TRANS(ldx_b, ALL, gen_loadx, MO_SB)
-TRANS(ldx_h, ALL, gen_loadx, MO_TESW)
-TRANS(ldx_w, ALL, gen_loadx, MO_TESL)
-TRANS(ldx_d, ALL, gen_loadx, MO_TEUQ)
-TRANS(stx_b, ALL, gen_storex, MO_UB)
-TRANS(stx_h, ALL, gen_storex, MO_TEUW)
-TRANS(stx_w, ALL, gen_storex, MO_TEUL)
-TRANS(stx_d, ALL, gen_storex, MO_TEUQ)
-TRANS(ldx_bu, ALL, gen_loadx, MO_UB)
-TRANS(ldx_hu, ALL, gen_loadx, MO_TEUW)
-TRANS(ldx_wu, ALL, gen_loadx, MO_TEUL)
-TRANS(ldptr_w, ALL, gen_ldptr, MO_TESL)
-TRANS(stptr_w, ALL, gen_stptr, MO_TEUL)
-TRANS(ldptr_d, ALL, gen_ldptr, MO_TEUQ)
-TRANS(stptr_d, ALL, gen_stptr, MO_TEUQ)
-TRANS(ldgt_b, ALL, gen_load_gt, MO_SB)
-TRANS(ldgt_h, ALL, gen_load_gt, MO_TESW)
-TRANS(ldgt_w, ALL, gen_load_gt, MO_TESL)
-TRANS(ldgt_d, ALL, gen_load_gt, MO_TEUQ)
-TRANS(ldle_b, ALL, gen_load_le, MO_SB)
-TRANS(ldle_h, ALL, gen_load_le, MO_TESW)
-TRANS(ldle_w, ALL, gen_load_le, MO_TESL)
-TRANS(ldle_d, ALL, gen_load_le, MO_TEUQ)
-TRANS(stgt_b, ALL, gen_store_gt, MO_UB)
-TRANS(stgt_h, ALL, gen_store_gt, MO_TEUW)
-TRANS(stgt_w, ALL, gen_store_gt, MO_TEUL)
-TRANS(stgt_d, ALL, gen_store_gt, MO_TEUQ)
-TRANS(stle_b, ALL, gen_store_le, MO_UB)
-TRANS(stle_h, ALL, gen_store_le, MO_TEUW)
-TRANS(stle_w, ALL, gen_store_le, MO_TEUL)
-TRANS(stle_d, ALL, gen_store_le, MO_TEUQ)
+TRANS(ld_wu, 64, gen_load, MO_TEUL)
+TRANS(ldx_b, 64, gen_loadx, MO_SB)
+TRANS(ldx_h, 64, gen_loadx, MO_TESW)
+TRANS(ldx_w, 64, gen_loadx, MO_TESL)
+TRANS(ldx_d, 64, gen_loadx, MO_TEUQ)
+TRANS(stx_b, 64, gen_storex, MO_UB)
+TRANS(stx_h, 64, gen_storex, MO_TEUW)
+TRANS(stx_w, 64, gen_storex, MO_TEUL)
+TRANS(stx_d, 64, gen_storex, MO_TEUQ)
+TRANS(ldx_bu, 64, gen_loadx, MO_UB)
+TRANS(ldx_hu, 64, gen_loadx, MO_TEUW)
+TRANS(ldx_wu, 64, gen_loadx, MO_TEUL)
+TRANS(ldptr_w, 64, gen_ldptr, MO_TESL)
+TRANS(stptr_w, 64, gen_stptr, MO_TEUL)
+TRANS(ldptr_d, 64, gen_ldptr, MO_TEUQ)
+TRANS(stptr_d, 64, gen_stptr, MO_TEUQ)
+TRANS(ldgt_b, 64, gen_load_gt, MO_SB)
+TRANS(ldgt_h, 64, gen_load_gt, MO_TESW)
+TRANS(ldgt_w, 64, gen_load_gt, MO_TESL)
+TRANS(ldgt_d, 64, gen_load_gt, MO_TEUQ)
+TRANS(ldle_b, 64, gen_load_le, MO_SB)
+TRANS(ldle_h, 64, gen_load_le, MO_TESW)
+TRANS(ldle_w, 64, gen_load_le, MO_TESL)
+TRANS(ldle_d, 64, gen_load_le, MO_TEUQ)
+TRANS(stgt_b, 64, gen_store_gt, MO_UB)
+TRANS(stgt_h, 64, gen_store_gt, MO_TEUW)
+TRANS(stgt_w, 64, gen_store_gt, MO_TEUL)
+TRANS(stgt_d, 64, gen_store_gt, MO_TEUQ)
+TRANS(stle_b, 64, gen_store_le, MO_UB)
+TRANS(stle_h, 64, gen_store_le, MO_TEUW)
+TRANS(stle_w, 64, gen_store_le, MO_TEUL)
+TRANS(stle_d, 64, gen_store_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_shift.c.inc b/target/loongarch/insn_trans/trans_shift.c.inc
index 849759b94b..2f4bd6ff28 100644
--- a/target/loongarch/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/insn_trans/trans_shift.c.inc
@@ -72,6 +72,10 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
 
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -81,15 +85,15 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
 TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
 TRANS(srl_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_srl_w)
 TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
-TRANS(sll_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
-TRANS(srl_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
-TRANS(sra_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
-TRANS(rotr_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
+TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
+TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
+TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
+TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
-TRANS(slli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
+TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
 TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
-TRANS(srli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
-TRANS(srai_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
-TRANS(rotri_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
+TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
+TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
+TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 0fa877975b..86c834dd6b 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -15,6 +15,8 @@
     { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
 
 #define avail_ALL(C)   true
+#define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
+                        CPUCFG1_ARCH_LA64)
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.39.1


