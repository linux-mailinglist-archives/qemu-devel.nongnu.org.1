Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190577557F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedX-00047I-4s; Wed, 09 Aug 2023 04:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedV-000470-Dx
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:45 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedS-0001o0-OG
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:45 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 906DB44026;
 Wed,  9 Aug 2023 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570021; bh=Pb26ArMgG1DeAx9wd73HUqgWtxFxbSpsYl8xHeaIfZA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PxX7pYVW1ggzbXgRUkOXvLeaWj100RL6M+5b/7RXfbqP9GjwYGVxj+SF6gKIPFlNC
 XmgDp9GRKp3lJYx4x9xjbKaO2UuH2wIPodFK/eiS9OCFznZlBJnuXGfRCtMyRexiVa
 FdOyuafygLXxWbgANyfvAj9P276CKnnzKv0MP3QI=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 08/11] target/loongarch: Reject la64-only instructions in
 la32 mode
Date: Wed,  9 Aug 2023 16:26:36 +0800
Message-ID: <20230809083258.1787464-9-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

LoongArch64-only instructions are marked with regard to the instruction
manual Table 2. LSX instructions are not marked for now for lack of
public manual.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/insn_trans/trans_arith.c.inc | 30 ++++----
 .../loongarch/insn_trans/trans_atomic.c.inc   | 76 +++++++++----------
 target/loongarch/insn_trans/trans_bit.c.inc   | 28 +++----
 .../loongarch/insn_trans/trans_branch.c.inc   |  4 +-
 target/loongarch/insn_trans/trans_extra.c.inc | 16 ++--
 target/loongarch/insn_trans/trans_fmov.c.inc  |  4 +-
 .../loongarch/insn_trans/trans_memory.c.inc   | 68 ++++++++---------
 target/loongarch/insn_trans/trans_shift.c.inc | 14 ++--
 target/loongarch/translate.h                  |  7 ++
 9 files changed, 127 insertions(+), 120 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index 43d6cf261d..4c21d8b037 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -249,9 +249,9 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
 }
 
 TRANS(add_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
-TRANS(add_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
+TRANS_64(add_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
 TRANS(sub_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
-TRANS(sub_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
+TRANS_64(sub_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
 TRANS(and, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
 TRANS(or, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
 TRANS(xor, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
@@ -261,32 +261,32 @@ TRANS(orn, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
 TRANS(slt, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltu, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(mul_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
-TRANS(mul_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mul_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
 TRANS(mulh_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
 TRANS(mulh_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
-TRANS(mulh_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
-TRANS(mulh_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
-TRANS(mulw_d_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
-TRANS(mulw_d_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mulh_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
+TRANS_64(mulh_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
+TRANS_64(mulw_d_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
+TRANS_64(mulw_d_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
 TRANS(div_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
 TRANS(mod_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
 TRANS(div_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
 TRANS(mod_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
-TRANS(div_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
-TRANS(mod_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
-TRANS(div_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
-TRANS(mod_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
+TRANS_64(div_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
+TRANS_64(mod_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
+TRANS_64(div_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
+TRANS_64(mod_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
 TRANS(slti, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
 TRANS(sltui, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(addi_w, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
-TRANS(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
+TRANS_64(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
 TRANS(alsl_w, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
-TRANS(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
-TRANS(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
+TRANS_64(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
+TRANS_64(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
 TRANS(pcaddi, gen_pc, gen_pcaddi)
 TRANS(pcalau12i, gen_pc, gen_pcalau12i)
 TRANS(pcaddu12i, gen_pc, gen_pcaddu12i)
-TRANS(pcaddu18i, gen_pc, gen_pcaddu18i)
+TRANS_64(pcaddu18i, gen_pc, gen_pcaddu18i)
 TRANS(andi, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
 TRANS(ori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
 TRANS(xori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index 612709f2a7..c69f31bc78 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -70,41 +70,41 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
 
 TRANS(ll_w, gen_ll, MO_TESL)
 TRANS(sc_w, gen_sc, MO_TESL)
-TRANS(ll_d, gen_ll, MO_TEUQ)
-TRANS(sc_d, gen_sc, MO_TEUQ)
-TRANS(amswap_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_db_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_db_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_db_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_db_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_db_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_db_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_db_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_db_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_db_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS_64(ll_d, gen_ll, MO_TEUQ)
+TRANS_64(sc_d, gen_sc, MO_TEUQ)
+TRANS_64(amswap_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS_64(amswap_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS_64(amadd_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS_64(amadd_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS_64(amand_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS_64(amand_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS_64(amor_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS_64(amor_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS_64(amxor_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS_64(amxor_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS_64(ammax_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS_64(ammax_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS_64(ammin_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS_64(ammin_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS_64(ammax_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS_64(ammax_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS_64(ammin_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS_64(ammin_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS_64(amswap_db_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS_64(amswap_db_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS_64(amadd_db_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS_64(amadd_db_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS_64(amand_db_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS_64(amand_db_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS_64(amor_db_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS_64(amor_db_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS_64(amxor_db_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS_64(amxor_db_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS_64(ammax_db_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS_64(ammax_db_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS_64(ammin_db_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS_64(ammin_db_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS_64(ammax_db_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS_64(ammax_db_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS_64(ammin_db_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS_64(ammin_db_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 25b4d7858b..4907b67379 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -184,25 +184,25 @@ TRANS(clo_w, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
 TRANS(clz_w, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
 TRANS(cto_w, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
 TRANS(ctz_w, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
-TRANS(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
-TRANS(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
-TRANS(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
-TRANS(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
+TRANS_64(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
+TRANS_64(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
+TRANS_64(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
+TRANS_64(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
 TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
-TRANS(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
-TRANS(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS_64(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS_64(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
+TRANS_64(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS_64(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
+TRANS_64(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
 TRANS(bitrev_4b, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS_64(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
 TRANS(bitrev_w, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS_64(bitrev_d, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
 TRANS(maskeqz, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-TRANS(bytepick_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
+TRANS_64(bytepick_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
 TRANS(bstrins_w, gen_bstrins, EXT_SIGN)
-TRANS(bstrins_d, gen_bstrins, EXT_NONE)
+TRANS_64(bstrins_d, gen_bstrins, EXT_NONE)
 TRANS(bstrpick_w, gen_bstrpick, EXT_SIGN)
-TRANS(bstrpick_d, gen_bstrpick, EXT_NONE)
+TRANS_64(bstrpick_d, gen_bstrpick, EXT_NONE)
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index a860f7e733..29b81a9843 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -79,5 +79,5 @@ TRANS(bltu, gen_rr_bc, TCG_COND_LTU)
 TRANS(bgeu, gen_rr_bc, TCG_COND_GEU)
 TRANS(beqz, gen_rz_bc, TCG_COND_EQ)
 TRANS(bnez, gen_rz_bc, TCG_COND_NE)
-TRANS(bceqz, gen_cz_bc, TCG_COND_EQ)
-TRANS(bcnez, gen_cz_bc, TCG_COND_NE)
+TRANS_64(bceqz, gen_cz_bc, TCG_COND_EQ)
+TRANS_64(bcnez, gen_cz_bc, TCG_COND_NE)
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index 06f4de4515..596f707c45 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -89,11 +89,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(crc_w_b_w, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
-TRANS(crc_w_h_w, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
-TRANS(crc_w_w_w, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS(crc_w_d_w, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
-TRANS(crcc_w_b_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
-TRANS(crcc_w_h_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
-TRANS(crcc_w_w_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS(crcc_w_d_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS_64(crc_w_b_w, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
+TRANS_64(crc_w_h_w, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
+TRANS_64(crc_w_w_w, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
+TRANS_64(crc_w_d_w, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS_64(crcc_w_b_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
+TRANS_64(crcc_w_h_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
+TRANS_64(crcc_w_w_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
+TRANS_64(crcc_w_d_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index 5af0dd1b66..c58c5c6534 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -181,8 +181,8 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
 TRANS(fmov_s, gen_f2f, tcg_gen_mov_tl, true)
 TRANS(fmov_d, gen_f2f, tcg_gen_mov_tl, false)
 TRANS(movgr2fr_w, gen_r2f, gen_movgr2fr_w)
-TRANS(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
+TRANS_64(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
 TRANS(movgr2frh_w, gen_r2f, gen_movgr2frh_w)
 TRANS(movfr2gr_s, gen_f2r, tcg_gen_ext32s_tl)
-TRANS(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
+TRANS_64(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
 TRANS(movfrh2gr_s, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index 75cfdf59ad..858c97951b 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -162,42 +162,42 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 TRANS(ld_b, gen_load, MO_SB)
 TRANS(ld_h, gen_load, MO_TESW)
 TRANS(ld_w, gen_load, MO_TESL)
-TRANS(ld_d, gen_load, MO_TEUQ)
+TRANS_64(ld_d, gen_load, MO_TEUQ)
 TRANS(st_b, gen_store, MO_UB)
 TRANS(st_h, gen_store, MO_TEUW)
 TRANS(st_w, gen_store, MO_TEUL)
-TRANS(st_d, gen_store, MO_TEUQ)
+TRANS_64(st_d, gen_store, MO_TEUQ)
 TRANS(ld_bu, gen_load, MO_UB)
 TRANS(ld_hu, gen_load, MO_TEUW)
-TRANS(ld_wu, gen_load, MO_TEUL)
-TRANS(ldx_b, gen_loadx, MO_SB)
-TRANS(ldx_h, gen_loadx, MO_TESW)
-TRANS(ldx_w, gen_loadx, MO_TESL)
-TRANS(ldx_d, gen_loadx, MO_TEUQ)
-TRANS(stx_b, gen_storex, MO_UB)
-TRANS(stx_h, gen_storex, MO_TEUW)
-TRANS(stx_w, gen_storex, MO_TEUL)
-TRANS(stx_d, gen_storex, MO_TEUQ)
-TRANS(ldx_bu, gen_loadx, MO_UB)
-TRANS(ldx_hu, gen_loadx, MO_TEUW)
-TRANS(ldx_wu, gen_loadx, MO_TEUL)
-TRANS(ldptr_w, gen_ldptr, MO_TESL)
-TRANS(stptr_w, gen_stptr, MO_TEUL)
-TRANS(ldptr_d, gen_ldptr, MO_TEUQ)
-TRANS(stptr_d, gen_stptr, MO_TEUQ)
-TRANS(ldgt_b, gen_load_gt, MO_SB)
-TRANS(ldgt_h, gen_load_gt, MO_TESW)
-TRANS(ldgt_w, gen_load_gt, MO_TESL)
-TRANS(ldgt_d, gen_load_gt, MO_TEUQ)
-TRANS(ldle_b, gen_load_le, MO_SB)
-TRANS(ldle_h, gen_load_le, MO_TESW)
-TRANS(ldle_w, gen_load_le, MO_TESL)
-TRANS(ldle_d, gen_load_le, MO_TEUQ)
-TRANS(stgt_b, gen_store_gt, MO_UB)
-TRANS(stgt_h, gen_store_gt, MO_TEUW)
-TRANS(stgt_w, gen_store_gt, MO_TEUL)
-TRANS(stgt_d, gen_store_gt, MO_TEUQ)
-TRANS(stle_b, gen_store_le, MO_UB)
-TRANS(stle_h, gen_store_le, MO_TEUW)
-TRANS(stle_w, gen_store_le, MO_TEUL)
-TRANS(stle_d, gen_store_le, MO_TEUQ)
+TRANS_64(ld_wu, gen_load, MO_TEUL)
+TRANS_64(ldx_b, gen_loadx, MO_SB)
+TRANS_64(ldx_h, gen_loadx, MO_TESW)
+TRANS_64(ldx_w, gen_loadx, MO_TESL)
+TRANS_64(ldx_d, gen_loadx, MO_TEUQ)
+TRANS_64(stx_b, gen_storex, MO_UB)
+TRANS_64(stx_h, gen_storex, MO_TEUW)
+TRANS_64(stx_w, gen_storex, MO_TEUL)
+TRANS_64(stx_d, gen_storex, MO_TEUQ)
+TRANS_64(ldx_bu, gen_loadx, MO_UB)
+TRANS_64(ldx_hu, gen_loadx, MO_TEUW)
+TRANS_64(ldx_wu, gen_loadx, MO_TEUL)
+TRANS_64(ldptr_w, gen_ldptr, MO_TESL)
+TRANS_64(stptr_w, gen_stptr, MO_TEUL)
+TRANS_64(ldptr_d, gen_ldptr, MO_TEUQ)
+TRANS_64(stptr_d, gen_stptr, MO_TEUQ)
+TRANS_64(ldgt_b, gen_load_gt, MO_SB)
+TRANS_64(ldgt_h, gen_load_gt, MO_TESW)
+TRANS_64(ldgt_w, gen_load_gt, MO_TESL)
+TRANS_64(ldgt_d, gen_load_gt, MO_TEUQ)
+TRANS_64(ldle_b, gen_load_le, MO_SB)
+TRANS_64(ldle_h, gen_load_le, MO_TESW)
+TRANS_64(ldle_w, gen_load_le, MO_TESL)
+TRANS_64(ldle_d, gen_load_le, MO_TEUQ)
+TRANS_64(stgt_b, gen_store_gt, MO_UB)
+TRANS_64(stgt_h, gen_store_gt, MO_TEUW)
+TRANS_64(stgt_w, gen_store_gt, MO_TEUL)
+TRANS_64(stgt_d, gen_store_gt, MO_TEUQ)
+TRANS_64(stle_b, gen_store_le, MO_UB)
+TRANS_64(stle_h, gen_store_le, MO_TEUW)
+TRANS_64(stle_w, gen_store_le, MO_TEUL)
+TRANS_64(stle_d, gen_store_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_shift.c.inc b/target/loongarch/insn_trans/trans_shift.c.inc
index bf5428a2ba..7bbbfe6c8c 100644
--- a/target/loongarch/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/insn_trans/trans_shift.c.inc
@@ -81,15 +81,15 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
 TRANS(sll_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
 TRANS(srl_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_srl_w)
 TRANS(sra_w, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
-TRANS(sll_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
-TRANS(srl_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
-TRANS(sra_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
+TRANS_64(sll_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
+TRANS_64(srl_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
+TRANS_64(sra_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
 TRANS(rotr_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
-TRANS(rotr_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
+TRANS_64(rotr_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
-TRANS(slli_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
+TRANS_64(slli_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
 TRANS(srli_w, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
-TRANS(srai_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
+TRANS_64(srai_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
 TRANS(rotri_w, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
-TRANS(rotri_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
+TRANS_64(rotri_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index b6fa5df82d..6f8ff57923 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -14,6 +14,13 @@
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     { return FUNC(ctx, a, __VA_ARGS__); }
 
+/* for LoongArch64-only instructions */
+#define TRANS_64(NAME, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+    { \
+        return ctx->la64 && FUNC(ctx, a, __VA_ARGS__); \
+    }
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
-- 
2.41.0


