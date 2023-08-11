Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F822778A95
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOyT-0006h2-MQ; Fri, 11 Aug 2023 06:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qUOyO-0006Sg-4M
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qUOyF-0002ES-Vg
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxyOgkB9ZkwoAVAA--.10103S3;
 Fri, 11 Aug 2023 18:02:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSMhB9ZkBcpUAA--.61494S4; 
 Fri, 11 Aug 2023 18:02:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, c@jia.je
Subject: [PATCH v2 2/8] target/loongarch: Add a check parameter to the TRANS
 macro
Date: Fri, 11 Aug 2023 18:02:02 +0800
Message-Id: <20230811100208.271649-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230811100208.271649-1-gaosong@loongson.cn>
References: <20230811100208.271649-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSMhB9ZkBcpUAA--.61494S4
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

The default check parmeter is ALL, remove TRANS_64 marco.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_arith.c.inc |   84 +-
 .../loongarch/insn_trans/trans_atomic.c.inc   |   80 +-
 target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
 .../loongarch/insn_trans/trans_branch.c.inc   |   20 +-
 target/loongarch/insn_trans/trans_extra.c.inc |   16 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   72 +-
 target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  |   32 +-
 target/loongarch/insn_trans/trans_fmov.c.inc  |   16 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   | 1322 ++++++++---------
 .../loongarch/insn_trans/trans_memory.c.inc   |   84 +-
 .../insn_trans/trans_privileged.c.inc         |   16 +-
 target/loongarch/insn_trans/trans_shift.c.inc |   30 +-
 target/loongarch/translate.c                  |    3 +
 target/loongarch/translate.h                  |   13 +-
 15 files changed, 950 insertions(+), 950 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index e3b7979e15..d7f69a7553 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -248,45 +248,45 @@ static bool trans_addu16i_d(DisasContext *ctx, arg_addu16i_d *a)
     return true;
 }
 
-TRANS(add_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
-TRANS_64(add_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
-TRANS(sub_w, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
-TRANS_64(sub_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
-TRANS(and, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
-TRANS(or, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
-TRANS(xor, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
-TRANS(nor, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_nor_tl)
-TRANS(andn, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_andc_tl)
-TRANS(orn, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
-TRANS(slt, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
-TRANS(sltu, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
-TRANS(mul_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
-TRANS_64(mul_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
-TRANS(mulh_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
-TRANS(mulh_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
-TRANS_64(mulh_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
-TRANS_64(mulh_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
-TRANS_64(mulw_d_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
-TRANS_64(mulw_d_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
-TRANS(div_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
-TRANS(mod_w, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
-TRANS(div_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
-TRANS(mod_wu, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
-TRANS_64(div_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
-TRANS_64(mod_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
-TRANS_64(div_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
-TRANS_64(mod_du, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
-TRANS(slti, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
-TRANS(sltui, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
-TRANS(addi_w, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
-TRANS_64(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
-TRANS(alsl_w, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
-TRANS_64(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
-TRANS_64(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
-TRANS(pcaddi, gen_pc, gen_pcaddi)
-TRANS(pcalau12i, gen_pc, gen_pcalau12i)
-TRANS(pcaddu12i, gen_pc, gen_pcaddu12i)
-TRANS_64(pcaddu18i, gen_pc, gen_pcaddu18i)
-TRANS(andi, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
-TRANS(ori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
-TRANS(xori, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
+TRANS(add_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
+TRANS(add_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_add_tl)
+TRANS(sub_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_sub_tl)
+TRANS(sub_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_sub_tl)
+TRANS(and, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_and_tl)
+TRANS(or, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_or_tl)
+TRANS(xor, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_xor_tl)
+TRANS(nor, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_nor_tl)
+TRANS(andn, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_andc_tl)
+TRANS(orn, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_orc_tl)
+TRANS(slt, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_slt)
+TRANS(sltu, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
+TRANS(mul_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
+TRANS(mul_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulh_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
+TRANS(mulh_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
+TRANS(mulh_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
+TRANS(mulh_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
+TRANS(mulw_d_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)
+TRANS(mulw_d_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, tcg_gen_mul_tl)
+TRANS(div_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_div_w)
+TRANS(mod_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, gen_rem_w)
+TRANS(div_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_div_du)
+TRANS(mod_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_SIGN, gen_rem_du)
+TRANS(div_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_d)
+TRANS(mod_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_d)
+TRANS(div_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_div_du)
+TRANS(mod_du, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rem_du)
+TRANS(slti, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_slt)
+TRANS(sltui, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_sltu)
+TRANS(addi_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_addi_tl)
+TRANS(addi_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
+TRANS(alsl_w, ALL, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
+TRANS(alsl_wu, ALL, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
+TRANS(alsl_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
+TRANS(pcaddi, ALL, gen_pc, gen_pcaddi)
+TRANS(pcalau12i, ALL, gen_pc, gen_pcalau12i)
+TRANS(pcaddu12i, ALL, gen_pc, gen_pcaddu12i)
+TRANS(pcaddu18i, ALL, gen_pc, gen_pcaddu18i)
+TRANS(andi, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_andi_tl)
+TRANS(ori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_ori_tl)
+TRANS(xori, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_xori_tl)
diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
index d90312729b..0a02f0dbf3 100644
--- a/target/loongarch/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/insn_trans/trans_atomic.c.inc
@@ -69,43 +69,43 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(ll_w, gen_ll, MO_TESL)
-TRANS(sc_w, gen_sc, MO_TESL)
-TRANS_64(ll_d, gen_ll, MO_TEUQ)
-TRANS_64(sc_d, gen_sc, MO_TEUQ)
-TRANS_64(amswap_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS_64(amswap_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS_64(amadd_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS_64(amadd_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS_64(amand_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS_64(amand_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS_64(amor_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS_64(amor_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS_64(amxor_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS_64(amxor_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS_64(ammax_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS_64(ammax_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS_64(ammin_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS_64(ammin_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS_64(ammax_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS_64(ammax_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS_64(ammin_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS_64(ammin_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS_64(amswap_db_w, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS_64(amswap_db_d, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS_64(amadd_db_w, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS_64(amadd_db_d, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS_64(amand_db_w, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS_64(amand_db_d, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS_64(amor_db_w, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS_64(amor_db_d, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS_64(amxor_db_w, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS_64(amxor_db_d, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS_64(ammax_db_w, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS_64(ammax_db_d, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS_64(ammin_db_w, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS_64(ammin_db_d, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS_64(ammax_db_wu, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS_64(ammax_db_du, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS_64(ammin_db_wu, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS_64(ammin_db_du, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(ll_w, ALL, gen_ll, MO_TESL)
+TRANS(sc_w, ALL, gen_sc, MO_TESL)
+TRANS(ll_d, ALL, gen_ll, MO_TEUQ)
+TRANS(sc_d, ALL, gen_sc, MO_TEUQ)
+TRANS(amswap_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(amswap_db_w, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
+TRANS(amswap_db_d, ALL, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS(amadd_db_w, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
+TRANS(amadd_db_d, ALL, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS(amand_db_w, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
+TRANS(amand_db_d, ALL, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS(amor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
+TRANS(amor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS(amxor_db_w, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
+TRANS(amxor_db_d, ALL, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS(ammax_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
+TRANS(ammax_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS(ammin_db_w, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
+TRANS(ammin_db_d, ALL, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS(ammax_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
+TRANS(ammax_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS(ammin_db_wu, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
+TRANS(ammin_db_du, ALL, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 4907b67379..d2a7ac28f7 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -178,31 +178,31 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
-TRANS(ext_w_h, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
-TRANS(ext_w_b, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
-TRANS(clo_w, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
-TRANS(clz_w, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
-TRANS(cto_w, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
-TRANS(ctz_w, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
-TRANS_64(clo_d, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
-TRANS_64(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
-TRANS_64(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
-TRANS_64(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
-TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS_64(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
-TRANS_64(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS_64(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
-TRANS_64(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS_64(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS_64(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
-TRANS(bitrev_w, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS_64(bitrev_d, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
-TRANS(maskeqz, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
-TRANS(masknez, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
-TRANS(bytepick_w, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-TRANS_64(bytepick_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
-TRANS(bstrins_w, gen_bstrins, EXT_SIGN)
-TRANS_64(bstrins_d, gen_bstrins, EXT_NONE)
-TRANS(bstrpick_w, gen_bstrpick, EXT_SIGN)
-TRANS_64(bstrpick_d, gen_bstrpick, EXT_NONE)
+TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
+TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
+TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
+TRANS(clz_w, ALL, gen_rr, EXT_ZERO, EXT_NONE, gen_clz_w)
+TRANS(cto_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_w)
+TRANS(ctz_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_w)
+TRANS(clo_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_d)
+TRANS(clz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
+TRANS(cto_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
+TRANS(ctz_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
+TRANS(revb_2h, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
+TRANS(revb_4h, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS(revb_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
+TRANS(revb_d, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS(revh_2w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
+TRANS(revh_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
+TRANS(bitrev_8b, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
+TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
+TRANS(bitrev_d, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
+TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
+TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
+TRANS(bytepick_d, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
+TRANS(bstrins_w, ALL, gen_bstrins, EXT_SIGN)
+TRANS(bstrins_d, ALL, gen_bstrins, EXT_NONE)
+TRANS(bstrpick_w, ALL, gen_bstrpick, EXT_SIGN)
+TRANS(bstrpick_d, ALL, gen_bstrpick, EXT_NONE)
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index cf035e44ff..50f7eb640a 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -72,13 +72,13 @@ static bool gen_cz_bc(DisasContext *ctx, arg_c_offs *a, TCGCond cond)
     return true;
 }
 
-TRANS(beq, gen_rr_bc, TCG_COND_EQ)
-TRANS(bne, gen_rr_bc, TCG_COND_NE)
-TRANS(blt, gen_rr_bc, TCG_COND_LT)
-TRANS(bge, gen_rr_bc, TCG_COND_GE)
-TRANS(bltu, gen_rr_bc, TCG_COND_LTU)
-TRANS(bgeu, gen_rr_bc, TCG_COND_GEU)
-TRANS(beqz, gen_rz_bc, TCG_COND_EQ)
-TRANS(bnez, gen_rz_bc, TCG_COND_NE)
-TRANS_64(bceqz, gen_cz_bc, TCG_COND_EQ)
-TRANS_64(bcnez, gen_cz_bc, TCG_COND_NE)
+TRANS(beq, ALL, gen_rr_bc, TCG_COND_EQ)
+TRANS(bne, ALL, gen_rr_bc, TCG_COND_NE)
+TRANS(blt, ALL, gen_rr_bc, TCG_COND_LT)
+TRANS(bge, ALL, gen_rr_bc, TCG_COND_GE)
+TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
+TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
+TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
+TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
+TRANS(bceqz, ALL, gen_cz_bc, TCG_COND_EQ)
+TRANS(bcnez, ALL, gen_cz_bc, TCG_COND_NE)
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index 596f707c45..b354ca0f86 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -89,11 +89,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS_64(crc_w_b_w, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
-TRANS_64(crc_w_h_w, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
-TRANS_64(crc_w_w_w, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS_64(crc_w_d_w, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
-TRANS_64(crcc_w_b_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
-TRANS_64(crcc_w_h_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
-TRANS_64(crcc_w_w_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS_64(crcc_w_d_w, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS(crc_w_b_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
+TRANS(crc_w_h_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
+TRANS(crc_w_w_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
+TRANS(crc_w_d_w, ALL, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS(crcc_w_b_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
+TRANS(crcc_w_h_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
+TRANS(crcc_w_w_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
+TRANS(crcc_w_d_w, ALL, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/insn_trans/trans_farith.c.inc b/target/loongarch/insn_trans/trans_farith.c.inc
index 21ea47308b..b1a1dc7b01 100644
--- a/target/loongarch/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/insn_trans/trans_farith.c.inc
@@ -143,41 +143,41 @@ static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
     return true;
 }
 
-TRANS(fadd_s, gen_fff, gen_helper_fadd_s)
-TRANS(fadd_d, gen_fff, gen_helper_fadd_d)
-TRANS(fsub_s, gen_fff, gen_helper_fsub_s)
-TRANS(fsub_d, gen_fff, gen_helper_fsub_d)
-TRANS(fmul_s, gen_fff, gen_helper_fmul_s)
-TRANS(fmul_d, gen_fff, gen_helper_fmul_d)
-TRANS(fdiv_s, gen_fff, gen_helper_fdiv_s)
-TRANS(fdiv_d, gen_fff, gen_helper_fdiv_d)
-TRANS(fmax_s, gen_fff, gen_helper_fmax_s)
-TRANS(fmax_d, gen_fff, gen_helper_fmax_d)
-TRANS(fmin_s, gen_fff, gen_helper_fmin_s)
-TRANS(fmin_d, gen_fff, gen_helper_fmin_d)
-TRANS(fmaxa_s, gen_fff, gen_helper_fmaxa_s)
-TRANS(fmaxa_d, gen_fff, gen_helper_fmaxa_d)
-TRANS(fmina_s, gen_fff, gen_helper_fmina_s)
-TRANS(fmina_d, gen_fff, gen_helper_fmina_d)
-TRANS(fscaleb_s, gen_fff, gen_helper_fscaleb_s)
-TRANS(fscaleb_d, gen_fff, gen_helper_fscaleb_d)
-TRANS(fsqrt_s, gen_ff, gen_helper_fsqrt_s)
-TRANS(fsqrt_d, gen_ff, gen_helper_fsqrt_d)
-TRANS(frecip_s, gen_ff, gen_helper_frecip_s)
-TRANS(frecip_d, gen_ff, gen_helper_frecip_d)
-TRANS(frsqrt_s, gen_ff, gen_helper_frsqrt_s)
-TRANS(frsqrt_d, gen_ff, gen_helper_frsqrt_d)
-TRANS(flogb_s, gen_ff, gen_helper_flogb_s)
-TRANS(flogb_d, gen_ff, gen_helper_flogb_d)
-TRANS(fclass_s, gen_ff, gen_helper_fclass_s)
-TRANS(fclass_d, gen_ff, gen_helper_fclass_d)
-TRANS(fmadd_s, gen_muladd, gen_helper_fmuladd_s, 0)
-TRANS(fmadd_d, gen_muladd, gen_helper_fmuladd_d, 0)
-TRANS(fmsub_s, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
-TRANS(fmsub_d, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
-TRANS(fnmadd_s, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
-TRANS(fnmadd_d, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
-TRANS(fnmsub_s, gen_muladd, gen_helper_fmuladd_s,
+TRANS(fadd_s, ALL, gen_fff, gen_helper_fadd_s)
+TRANS(fadd_d, ALL, gen_fff, gen_helper_fadd_d)
+TRANS(fsub_s, ALL, gen_fff, gen_helper_fsub_s)
+TRANS(fsub_d, ALL, gen_fff, gen_helper_fsub_d)
+TRANS(fmul_s, ALL, gen_fff, gen_helper_fmul_s)
+TRANS(fmul_d, ALL, gen_fff, gen_helper_fmul_d)
+TRANS(fdiv_s, ALL, gen_fff, gen_helper_fdiv_s)
+TRANS(fdiv_d, ALL, gen_fff, gen_helper_fdiv_d)
+TRANS(fmax_s, ALL, gen_fff, gen_helper_fmax_s)
+TRANS(fmax_d, ALL, gen_fff, gen_helper_fmax_d)
+TRANS(fmin_s, ALL, gen_fff, gen_helper_fmin_s)
+TRANS(fmin_d, ALL, gen_fff, gen_helper_fmin_d)
+TRANS(fmaxa_s, ALL, gen_fff, gen_helper_fmaxa_s)
+TRANS(fmaxa_d, ALL, gen_fff, gen_helper_fmaxa_d)
+TRANS(fmina_s, ALL, gen_fff, gen_helper_fmina_s)
+TRANS(fmina_d, ALL, gen_fff, gen_helper_fmina_d)
+TRANS(fscaleb_s, ALL, gen_fff, gen_helper_fscaleb_s)
+TRANS(fscaleb_d, ALL, gen_fff, gen_helper_fscaleb_d)
+TRANS(fsqrt_s, ALL, gen_ff, gen_helper_fsqrt_s)
+TRANS(fsqrt_d, ALL, gen_ff, gen_helper_fsqrt_d)
+TRANS(frecip_s, ALL, gen_ff, gen_helper_frecip_s)
+TRANS(frecip_d, ALL, gen_ff, gen_helper_frecip_d)
+TRANS(frsqrt_s, ALL, gen_ff, gen_helper_frsqrt_s)
+TRANS(frsqrt_d, ALL, gen_ff, gen_helper_frsqrt_d)
+TRANS(flogb_s, ALL, gen_ff, gen_helper_flogb_s)
+TRANS(flogb_d, ALL, gen_ff, gen_helper_flogb_d)
+TRANS(fclass_s, ALL, gen_ff, gen_helper_fclass_s)
+TRANS(fclass_d, ALL, gen_ff, gen_helper_fclass_d)
+TRANS(fmadd_s, ALL, gen_muladd, gen_helper_fmuladd_s, 0)
+TRANS(fmadd_d, ALL, gen_muladd, gen_helper_fmuladd_d, 0)
+TRANS(fmsub_s, ALL, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
+TRANS(fmsub_d, ALL, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
+TRANS(fnmadd_s, ALL, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
+TRANS(fnmadd_d, ALL, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
+TRANS(fnmsub_s, ALL, gen_muladd, gen_helper_fmuladd_s,
       float_muladd_negate_c | float_muladd_negate_result)
-TRANS(fnmsub_d, gen_muladd, gen_helper_fmuladd_d,
+TRANS(fnmsub_d, ALL, gen_muladd, gen_helper_fmuladd_d,
       float_muladd_negate_c | float_muladd_negate_result)
diff --git a/target/loongarch/insn_trans/trans_fcnv.c.inc b/target/loongarch/insn_trans/trans_fcnv.c.inc
index c1c6918ad1..329a2d6872 100644
--- a/target/loongarch/insn_trans/trans_fcnv.c.inc
+++ b/target/loongarch/insn_trans/trans_fcnv.c.inc
@@ -3,31 +3,31 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-TRANS(fcvt_s_d, gen_ff, gen_helper_fcvt_s_d)
-TRANS(fcvt_d_s, gen_ff, gen_helper_fcvt_d_s)
-TRANS(ftintrm_w_s, gen_ff, gen_helper_ftintrm_w_s)
-TRANS(ftintrm_w_d, gen_ff, gen_helper_ftintrm_w_d)
-TRANS(ftintrm_l_s, gen_ff, gen_helper_ftintrm_l_s)
-TRANS(ftintrm_l_d, gen_ff, gen_helper_ftintrm_l_d)
-TRANS(ftintrp_w_s, gen_ff, gen_helper_ftintrp_w_s)
-TRANS(ftintrp_w_d, gen_ff, gen_helper_ftintrp_w_d)
-TRANS(ftintrp_l_s, gen_ff, gen_helper_ftintrp_l_s)
-TRANS(ftintrp_l_d, gen_ff, gen_helper_ftintrp_l_d)
-TRANS(ftintrz_w_s, gen_ff, gen_helper_ftintrz_w_s)
-TRANS(ftintrz_w_d, gen_ff, gen_helper_ftintrz_w_d)
-TRANS(ftintrz_l_s, gen_ff, gen_helper_ftintrz_l_s)
-TRANS(ftintrz_l_d, gen_ff, gen_helper_ftintrz_l_d)
-TRANS(ftintrne_w_s, gen_ff, gen_helper_ftintrne_w_s)
-TRANS(ftintrne_w_d, gen_ff, gen_helper_ftintrne_w_d)
-TRANS(ftintrne_l_s, gen_ff, gen_helper_ftintrne_l_s)
-TRANS(ftintrne_l_d, gen_ff, gen_helper_ftintrne_l_d)
-TRANS(ftint_w_s, gen_ff, gen_helper_ftint_w_s)
-TRANS(ftint_w_d, gen_ff, gen_helper_ftint_w_d)
-TRANS(ftint_l_s, gen_ff, gen_helper_ftint_l_s)
-TRANS(ftint_l_d, gen_ff, gen_helper_ftint_l_d)
-TRANS(ffint_s_w, gen_ff, gen_helper_ffint_s_w)
-TRANS(ffint_s_l, gen_ff, gen_helper_ffint_s_l)
-TRANS(ffint_d_w, gen_ff, gen_helper_ffint_d_w)
-TRANS(ffint_d_l, gen_ff, gen_helper_ffint_d_l)
-TRANS(frint_s, gen_ff, gen_helper_frint_s)
-TRANS(frint_d, gen_ff, gen_helper_frint_d)
+TRANS(fcvt_s_d, ALL, gen_ff, gen_helper_fcvt_s_d)
+TRANS(fcvt_d_s, ALL, gen_ff, gen_helper_fcvt_d_s)
+TRANS(ftintrm_w_s, ALL, gen_ff, gen_helper_ftintrm_w_s)
+TRANS(ftintrm_w_d, ALL, gen_ff, gen_helper_ftintrm_w_d)
+TRANS(ftintrm_l_s, ALL, gen_ff, gen_helper_ftintrm_l_s)
+TRANS(ftintrm_l_d, ALL, gen_ff, gen_helper_ftintrm_l_d)
+TRANS(ftintrp_w_s, ALL, gen_ff, gen_helper_ftintrp_w_s)
+TRANS(ftintrp_w_d, ALL, gen_ff, gen_helper_ftintrp_w_d)
+TRANS(ftintrp_l_s, ALL, gen_ff, gen_helper_ftintrp_l_s)
+TRANS(ftintrp_l_d, ALL, gen_ff, gen_helper_ftintrp_l_d)
+TRANS(ftintrz_w_s, ALL, gen_ff, gen_helper_ftintrz_w_s)
+TRANS(ftintrz_w_d, ALL, gen_ff, gen_helper_ftintrz_w_d)
+TRANS(ftintrz_l_s, ALL, gen_ff, gen_helper_ftintrz_l_s)
+TRANS(ftintrz_l_d, ALL, gen_ff, gen_helper_ftintrz_l_d)
+TRANS(ftintrne_w_s, ALL, gen_ff, gen_helper_ftintrne_w_s)
+TRANS(ftintrne_w_d, ALL, gen_ff, gen_helper_ftintrne_w_d)
+TRANS(ftintrne_l_s, ALL, gen_ff, gen_helper_ftintrne_l_s)
+TRANS(ftintrne_l_d, ALL, gen_ff, gen_helper_ftintrne_l_d)
+TRANS(ftint_w_s, ALL, gen_ff, gen_helper_ftint_w_s)
+TRANS(ftint_w_d, ALL, gen_ff, gen_helper_ftint_w_d)
+TRANS(ftint_l_s, ALL, gen_ff, gen_helper_ftint_l_s)
+TRANS(ftint_l_d, ALL, gen_ff, gen_helper_ftint_l_d)
+TRANS(ffint_s_w, ALL, gen_ff, gen_helper_ffint_s_w)
+TRANS(ffint_s_l, ALL, gen_ff, gen_helper_ffint_s_l)
+TRANS(ffint_d_w, ALL, gen_ff, gen_helper_ffint_d_w)
+TRANS(ffint_d_l, ALL, gen_ff, gen_helper_ffint_d_l)
+TRANS(frint_s, ALL, gen_ff, gen_helper_frint_s)
+TRANS(frint_d, ALL, gen_ff, gen_helper_frint_d)
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index bd3aba2c49..8e3b4522c9 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -140,19 +140,19 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-TRANS(fld_s, gen_fload_i, MO_TEUL)
-TRANS(fst_s, gen_fstore_i, MO_TEUL)
-TRANS(fld_d, gen_fload_i, MO_TEUQ)
-TRANS(fst_d, gen_fstore_i, MO_TEUQ)
-TRANS(fldx_s, gen_floadx, MO_TEUL)
-TRANS(fldx_d, gen_floadx, MO_TEUQ)
-TRANS(fstx_s, gen_fstorex, MO_TEUL)
-TRANS(fstx_d, gen_fstorex, MO_TEUQ)
-TRANS(fldgt_s, gen_fload_gt, MO_TEUL)
-TRANS(fldgt_d, gen_fload_gt, MO_TEUQ)
-TRANS(fldle_s, gen_fload_le, MO_TEUL)
-TRANS(fldle_d, gen_fload_le, MO_TEUQ)
-TRANS(fstgt_s, gen_fstore_gt, MO_TEUL)
-TRANS(fstgt_d, gen_fstore_gt, MO_TEUQ)
-TRANS(fstle_s, gen_fstore_le, MO_TEUL)
-TRANS(fstle_d, gen_fstore_le, MO_TEUQ)
+TRANS(fld_s, ALL, gen_fload_i, MO_TEUL)
+TRANS(fst_s, ALL, gen_fstore_i, MO_TEUL)
+TRANS(fld_d, ALL, gen_fload_i, MO_TEUQ)
+TRANS(fst_d, ALL, gen_fstore_i, MO_TEUQ)
+TRANS(fldx_s, ALL, gen_floadx, MO_TEUL)
+TRANS(fldx_d, ALL, gen_floadx, MO_TEUQ)
+TRANS(fstx_s, ALL, gen_fstorex, MO_TEUL)
+TRANS(fstx_d, ALL, gen_fstorex, MO_TEUQ)
+TRANS(fldgt_s, ALL, gen_fload_gt, MO_TEUL)
+TRANS(fldgt_d, ALL, gen_fload_gt, MO_TEUQ)
+TRANS(fldle_s, ALL, gen_fload_le, MO_TEUL)
+TRANS(fldle_d, ALL, gen_fload_le, MO_TEUQ)
+TRANS(fstgt_s, ALL, gen_fstore_gt, MO_TEUL)
+TRANS(fstgt_d, ALL, gen_fstore_gt, MO_TEUQ)
+TRANS(fstle_s, ALL, gen_fstore_le, MO_TEUL)
+TRANS(fstle_d, ALL, gen_fstore_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_fmov.c.inc b/target/loongarch/insn_trans/trans_fmov.c.inc
index c58c5c6534..aa7fea67b5 100644
--- a/target/loongarch/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/insn_trans/trans_fmov.c.inc
@@ -178,11 +178,11 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
     return true;
 }
 
-TRANS(fmov_s, gen_f2f, tcg_gen_mov_tl, true)
-TRANS(fmov_d, gen_f2f, tcg_gen_mov_tl, false)
-TRANS(movgr2fr_w, gen_r2f, gen_movgr2fr_w)
-TRANS_64(movgr2fr_d, gen_r2f, tcg_gen_mov_tl)
-TRANS(movgr2frh_w, gen_r2f, gen_movgr2frh_w)
-TRANS(movfr2gr_s, gen_f2r, tcg_gen_ext32s_tl)
-TRANS_64(movfr2gr_d, gen_f2r, tcg_gen_mov_tl)
-TRANS(movfrh2gr_s, gen_f2r, gen_movfrh2gr_s)
+TRANS(fmov_s, ALL, gen_f2f, tcg_gen_mov_tl, true)
+TRANS(fmov_d, ALL, gen_f2f, tcg_gen_mov_tl, false)
+TRANS(movgr2fr_w, ALL, gen_r2f, gen_movgr2fr_w)
+TRANS(movgr2fr_d, ALL, gen_r2f, tcg_gen_mov_tl)
+TRANS(movgr2frh_w, ALL, gen_r2f, gen_movgr2frh_w)
+TRANS(movfr2gr_s, ALL, gen_f2r, tcg_gen_ext32s_tl)
+TRANS(movfr2gr_d, ALL, gen_f2r, tcg_gen_mov_tl)
+TRANS(movfrh2gr_s, ALL, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 50153d6d0b..45e0e738ad 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -135,10 +135,10 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     return true;
 }
 
-TRANS(vadd_b, gvec_vvv, MO_8, tcg_gen_gvec_add)
-TRANS(vadd_h, gvec_vvv, MO_16, tcg_gen_gvec_add)
-TRANS(vadd_w, gvec_vvv, MO_32, tcg_gen_gvec_add)
-TRANS(vadd_d, gvec_vvv, MO_64, tcg_gen_gvec_add)
+TRANS(vadd_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_add)
+TRANS(vadd_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_add)
+TRANS(vadd_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_add)
+TRANS(vadd_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_add)
 
 #define VADDSUB_Q(NAME)                                        \
 static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
@@ -170,58 +170,58 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 VADDSUB_Q(add)
 VADDSUB_Q(sub)
 
-TRANS(vsub_b, gvec_vvv, MO_8, tcg_gen_gvec_sub)
-TRANS(vsub_h, gvec_vvv, MO_16, tcg_gen_gvec_sub)
-TRANS(vsub_w, gvec_vvv, MO_32, tcg_gen_gvec_sub)
-TRANS(vsub_d, gvec_vvv, MO_64, tcg_gen_gvec_sub)
-
-TRANS(vaddi_bu, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
-TRANS(vaddi_hu, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
-TRANS(vaddi_wu, gvec_vv_i, MO_32, tcg_gen_gvec_addi)
-TRANS(vaddi_du, gvec_vv_i, MO_64, tcg_gen_gvec_addi)
-TRANS(vsubi_bu, gvec_subi, MO_8)
-TRANS(vsubi_hu, gvec_subi, MO_16)
-TRANS(vsubi_wu, gvec_subi, MO_32)
-TRANS(vsubi_du, gvec_subi, MO_64)
-
-TRANS(vneg_b, gvec_vv, MO_8, tcg_gen_gvec_neg)
-TRANS(vneg_h, gvec_vv, MO_16, tcg_gen_gvec_neg)
-TRANS(vneg_w, gvec_vv, MO_32, tcg_gen_gvec_neg)
-TRANS(vneg_d, gvec_vv, MO_64, tcg_gen_gvec_neg)
-
-TRANS(vsadd_b, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
-TRANS(vsadd_h, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
-TRANS(vsadd_w, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
-TRANS(vsadd_d, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
-TRANS(vsadd_bu, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
-TRANS(vsadd_hu, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
-TRANS(vsadd_wu, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
-TRANS(vsadd_du, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
-TRANS(vssub_b, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
-TRANS(vssub_h, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
-TRANS(vssub_w, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
-TRANS(vssub_d, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
-TRANS(vssub_bu, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
-TRANS(vssub_hu, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
-TRANS(vssub_wu, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
-TRANS(vssub_du, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
-
-TRANS(vhaddw_h_b, gen_vvv, gen_helper_vhaddw_h_b)
-TRANS(vhaddw_w_h, gen_vvv, gen_helper_vhaddw_w_h)
-TRANS(vhaddw_d_w, gen_vvv, gen_helper_vhaddw_d_w)
-TRANS(vhaddw_q_d, gen_vvv, gen_helper_vhaddw_q_d)
-TRANS(vhaddw_hu_bu, gen_vvv, gen_helper_vhaddw_hu_bu)
-TRANS(vhaddw_wu_hu, gen_vvv, gen_helper_vhaddw_wu_hu)
-TRANS(vhaddw_du_wu, gen_vvv, gen_helper_vhaddw_du_wu)
-TRANS(vhaddw_qu_du, gen_vvv, gen_helper_vhaddw_qu_du)
-TRANS(vhsubw_h_b, gen_vvv, gen_helper_vhsubw_h_b)
-TRANS(vhsubw_w_h, gen_vvv, gen_helper_vhsubw_w_h)
-TRANS(vhsubw_d_w, gen_vvv, gen_helper_vhsubw_d_w)
-TRANS(vhsubw_q_d, gen_vvv, gen_helper_vhsubw_q_d)
-TRANS(vhsubw_hu_bu, gen_vvv, gen_helper_vhsubw_hu_bu)
-TRANS(vhsubw_wu_hu, gen_vvv, gen_helper_vhsubw_wu_hu)
-TRANS(vhsubw_du_wu, gen_vvv, gen_helper_vhsubw_du_wu)
-TRANS(vhsubw_qu_du, gen_vvv, gen_helper_vhsubw_qu_du)
+TRANS(vsub_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sub)
+TRANS(vsub_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sub)
+TRANS(vsub_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sub)
+TRANS(vsub_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sub)
+
+TRANS(vaddi_bu, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
+TRANS(vaddi_hu, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
+TRANS(vaddi_wu, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_addi)
+TRANS(vaddi_du, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_addi)
+TRANS(vsubi_bu, ALL, gvec_subi, MO_8)
+TRANS(vsubi_hu, ALL, gvec_subi, MO_16)
+TRANS(vsubi_wu, ALL, gvec_subi, MO_32)
+TRANS(vsubi_du, ALL, gvec_subi, MO_64)
+
+TRANS(vneg_b, ALL, gvec_vv, MO_8, tcg_gen_gvec_neg)
+TRANS(vneg_h, ALL, gvec_vv, MO_16, tcg_gen_gvec_neg)
+TRANS(vneg_w, ALL, gvec_vv, MO_32, tcg_gen_gvec_neg)
+TRANS(vneg_d, ALL, gvec_vv, MO_64, tcg_gen_gvec_neg)
+
+TRANS(vsadd_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
+TRANS(vsadd_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
+TRANS(vsadd_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
+TRANS(vsadd_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
+TRANS(vsadd_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
+TRANS(vsadd_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
+TRANS(vsadd_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
+TRANS(vsadd_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
+TRANS(vssub_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
+TRANS(vssub_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
+TRANS(vssub_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
+TRANS(vssub_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
+TRANS(vssub_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
+TRANS(vssub_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
+TRANS(vssub_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
+TRANS(vssub_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
+
+TRANS(vhaddw_h_b, ALL, gen_vvv, gen_helper_vhaddw_h_b)
+TRANS(vhaddw_w_h, ALL, gen_vvv, gen_helper_vhaddw_w_h)
+TRANS(vhaddw_d_w, ALL, gen_vvv, gen_helper_vhaddw_d_w)
+TRANS(vhaddw_q_d, ALL, gen_vvv, gen_helper_vhaddw_q_d)
+TRANS(vhaddw_hu_bu, ALL, gen_vvv, gen_helper_vhaddw_hu_bu)
+TRANS(vhaddw_wu_hu, ALL, gen_vvv, gen_helper_vhaddw_wu_hu)
+TRANS(vhaddw_du_wu, ALL, gen_vvv, gen_helper_vhaddw_du_wu)
+TRANS(vhaddw_qu_du, ALL, gen_vvv, gen_helper_vhaddw_qu_du)
+TRANS(vhsubw_h_b, ALL, gen_vvv, gen_helper_vhsubw_h_b)
+TRANS(vhsubw_w_h, ALL, gen_vvv, gen_helper_vhsubw_w_h)
+TRANS(vhsubw_d_w, ALL, gen_vvv, gen_helper_vhsubw_d_w)
+TRANS(vhsubw_q_d, ALL, gen_vvv, gen_helper_vhsubw_q_d)
+TRANS(vhsubw_hu_bu, ALL, gen_vvv, gen_helper_vhsubw_hu_bu)
+TRANS(vhsubw_wu_hu, ALL, gen_vvv, gen_helper_vhsubw_wu_hu)
+TRANS(vhsubw_du_wu, ALL, gen_vvv, gen_helper_vhsubw_du_wu)
+TRANS(vhsubw_qu_du, ALL, gen_vvv, gen_helper_vhsubw_qu_du)
 
 static void gen_vaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -301,10 +301,10 @@ static void do_vaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_b, gvec_vvv, MO_8, do_vaddwev_s)
-TRANS(vaddwev_w_h, gvec_vvv, MO_16, do_vaddwev_s)
-TRANS(vaddwev_d_w, gvec_vvv, MO_32, do_vaddwev_s)
-TRANS(vaddwev_q_d, gvec_vvv, MO_64, do_vaddwev_s)
+TRANS(vaddwev_h_b, ALL, gvec_vvv, MO_8, do_vaddwev_s)
+TRANS(vaddwev_w_h, ALL, gvec_vvv, MO_16, do_vaddwev_s)
+TRANS(vaddwev_d_w, ALL, gvec_vvv, MO_32, do_vaddwev_s)
+TRANS(vaddwev_q_d, ALL, gvec_vvv, MO_64, do_vaddwev_s)
 
 static void gen_vaddwod_w_h(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -380,10 +380,10 @@ static void do_vaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_b, gvec_vvv, MO_8, do_vaddwod_s)
-TRANS(vaddwod_w_h, gvec_vvv, MO_16, do_vaddwod_s)
-TRANS(vaddwod_d_w, gvec_vvv, MO_32, do_vaddwod_s)
-TRANS(vaddwod_q_d, gvec_vvv, MO_64, do_vaddwod_s)
+TRANS(vaddwod_h_b, ALL, gvec_vvv, MO_8, do_vaddwod_s)
+TRANS(vaddwod_w_h, ALL, gvec_vvv, MO_16, do_vaddwod_s)
+TRANS(vaddwod_d_w, ALL, gvec_vvv, MO_32, do_vaddwod_s)
+TRANS(vaddwod_q_d, ALL, gvec_vvv, MO_64, do_vaddwod_s)
 
 static void gen_vsubwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -463,10 +463,10 @@ static void do_vsubwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_b, gvec_vvv, MO_8, do_vsubwev_s)
-TRANS(vsubwev_w_h, gvec_vvv, MO_16, do_vsubwev_s)
-TRANS(vsubwev_d_w, gvec_vvv, MO_32, do_vsubwev_s)
-TRANS(vsubwev_q_d, gvec_vvv, MO_64, do_vsubwev_s)
+TRANS(vsubwev_h_b, ALL, gvec_vvv, MO_8, do_vsubwev_s)
+TRANS(vsubwev_w_h, ALL, gvec_vvv, MO_16, do_vsubwev_s)
+TRANS(vsubwev_d_w, ALL, gvec_vvv, MO_32, do_vsubwev_s)
+TRANS(vsubwev_q_d, ALL, gvec_vvv, MO_64, do_vsubwev_s)
 
 static void gen_vsubwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -542,10 +542,10 @@ static void do_vsubwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_b, gvec_vvv, MO_8, do_vsubwod_s)
-TRANS(vsubwod_w_h, gvec_vvv, MO_16, do_vsubwod_s)
-TRANS(vsubwod_d_w, gvec_vvv, MO_32, do_vsubwod_s)
-TRANS(vsubwod_q_d, gvec_vvv, MO_64, do_vsubwod_s)
+TRANS(vsubwod_h_b, ALL, gvec_vvv, MO_8, do_vsubwod_s)
+TRANS(vsubwod_w_h, ALL, gvec_vvv, MO_16, do_vsubwod_s)
+TRANS(vsubwod_d_w, ALL, gvec_vvv, MO_32, do_vsubwod_s)
+TRANS(vsubwod_q_d, ALL, gvec_vvv, MO_64, do_vsubwod_s)
 
 static void gen_vaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -617,10 +617,10 @@ static void do_vaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu, gvec_vvv, MO_8, do_vaddwev_u)
-TRANS(vaddwev_w_hu, gvec_vvv, MO_16, do_vaddwev_u)
-TRANS(vaddwev_d_wu, gvec_vvv, MO_32, do_vaddwev_u)
-TRANS(vaddwev_q_du, gvec_vvv, MO_64, do_vaddwev_u)
+TRANS(vaddwev_h_bu, ALL, gvec_vvv, MO_8, do_vaddwev_u)
+TRANS(vaddwev_w_hu, ALL, gvec_vvv, MO_16, do_vaddwev_u)
+TRANS(vaddwev_d_wu, ALL, gvec_vvv, MO_32, do_vaddwev_u)
+TRANS(vaddwev_q_du, ALL, gvec_vvv, MO_64, do_vaddwev_u)
 
 static void gen_vaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -696,10 +696,10 @@ static void do_vaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu, gvec_vvv, MO_8, do_vaddwod_u)
-TRANS(vaddwod_w_hu, gvec_vvv, MO_16, do_vaddwod_u)
-TRANS(vaddwod_d_wu, gvec_vvv, MO_32, do_vaddwod_u)
-TRANS(vaddwod_q_du, gvec_vvv, MO_64, do_vaddwod_u)
+TRANS(vaddwod_h_bu, ALL, gvec_vvv, MO_8, do_vaddwod_u)
+TRANS(vaddwod_w_hu, ALL, gvec_vvv, MO_16, do_vaddwod_u)
+TRANS(vaddwod_d_wu, ALL, gvec_vvv, MO_32, do_vaddwod_u)
+TRANS(vaddwod_q_du, ALL, gvec_vvv, MO_64, do_vaddwod_u)
 
 static void gen_vsubwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -771,10 +771,10 @@ static void do_vsubwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_bu, gvec_vvv, MO_8, do_vsubwev_u)
-TRANS(vsubwev_w_hu, gvec_vvv, MO_16, do_vsubwev_u)
-TRANS(vsubwev_d_wu, gvec_vvv, MO_32, do_vsubwev_u)
-TRANS(vsubwev_q_du, gvec_vvv, MO_64, do_vsubwev_u)
+TRANS(vsubwev_h_bu, ALL, gvec_vvv, MO_8, do_vsubwev_u)
+TRANS(vsubwev_w_hu, ALL, gvec_vvv, MO_16, do_vsubwev_u)
+TRANS(vsubwev_d_wu, ALL, gvec_vvv, MO_32, do_vsubwev_u)
+TRANS(vsubwev_q_du, ALL, gvec_vvv, MO_64, do_vsubwev_u)
 
 static void gen_vsubwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -850,10 +850,10 @@ static void do_vsubwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_bu, gvec_vvv, MO_8, do_vsubwod_u)
-TRANS(vsubwod_w_hu, gvec_vvv, MO_16, do_vsubwod_u)
-TRANS(vsubwod_d_wu, gvec_vvv, MO_32, do_vsubwod_u)
-TRANS(vsubwod_q_du, gvec_vvv, MO_64, do_vsubwod_u)
+TRANS(vsubwod_h_bu, ALL, gvec_vvv, MO_8, do_vsubwod_u)
+TRANS(vsubwod_w_hu, ALL, gvec_vvv, MO_16, do_vsubwod_u)
+TRANS(vsubwod_d_wu, ALL, gvec_vvv, MO_32, do_vsubwod_u)
+TRANS(vsubwod_q_du, ALL, gvec_vvv, MO_64, do_vsubwod_u)
 
 static void gen_vaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -933,10 +933,10 @@ static void do_vaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu_b, gvec_vvv, MO_8, do_vaddwev_u_s)
-TRANS(vaddwev_w_hu_h, gvec_vvv, MO_16, do_vaddwev_u_s)
-TRANS(vaddwev_d_wu_w, gvec_vvv, MO_32, do_vaddwev_u_s)
-TRANS(vaddwev_q_du_d, gvec_vvv, MO_64, do_vaddwev_u_s)
+TRANS(vaddwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vaddwev_u_s)
+TRANS(vaddwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vaddwev_u_s)
+TRANS(vaddwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vaddwev_u_s)
+TRANS(vaddwev_q_du_d, ALL, gvec_vvv, MO_64, do_vaddwev_u_s)
 
 static void gen_vaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1013,10 +1013,10 @@ static void do_vaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu_b, gvec_vvv, MO_8, do_vaddwod_u_s)
-TRANS(vaddwod_w_hu_h, gvec_vvv, MO_16, do_vaddwod_u_s)
-TRANS(vaddwod_d_wu_w, gvec_vvv, MO_32, do_vaddwod_u_s)
-TRANS(vaddwod_q_du_d, gvec_vvv, MO_64, do_vaddwod_u_s)
+TRANS(vaddwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vaddwod_u_s)
+TRANS(vaddwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vaddwod_u_s)
+TRANS(vaddwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vaddwod_u_s)
+TRANS(vaddwod_q_du_d, ALL, gvec_vvv, MO_64, do_vaddwod_u_s)
 
 static void do_vavg(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*gen_shr_vec)(unsigned, TCGv_vec,
@@ -1125,14 +1125,14 @@ static void do_vavg_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavg_b, gvec_vvv, MO_8, do_vavg_s)
-TRANS(vavg_h, gvec_vvv, MO_16, do_vavg_s)
-TRANS(vavg_w, gvec_vvv, MO_32, do_vavg_s)
-TRANS(vavg_d, gvec_vvv, MO_64, do_vavg_s)
-TRANS(vavg_bu, gvec_vvv, MO_8, do_vavg_u)
-TRANS(vavg_hu, gvec_vvv, MO_16, do_vavg_u)
-TRANS(vavg_wu, gvec_vvv, MO_32, do_vavg_u)
-TRANS(vavg_du, gvec_vvv, MO_64, do_vavg_u)
+TRANS(vavg_b, ALL, gvec_vvv, MO_8, do_vavg_s)
+TRANS(vavg_h, ALL, gvec_vvv, MO_16, do_vavg_s)
+TRANS(vavg_w, ALL, gvec_vvv, MO_32, do_vavg_s)
+TRANS(vavg_d, ALL, gvec_vvv, MO_64, do_vavg_s)
+TRANS(vavg_bu, ALL, gvec_vvv, MO_8, do_vavg_u)
+TRANS(vavg_hu, ALL, gvec_vvv, MO_16, do_vavg_u)
+TRANS(vavg_wu, ALL, gvec_vvv, MO_32, do_vavg_u)
+TRANS(vavg_du, ALL, gvec_vvv, MO_64, do_vavg_u)
 
 static void do_vavgr_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -1206,14 +1206,14 @@ static void do_vavgr_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavgr_b, gvec_vvv, MO_8, do_vavgr_s)
-TRANS(vavgr_h, gvec_vvv, MO_16, do_vavgr_s)
-TRANS(vavgr_w, gvec_vvv, MO_32, do_vavgr_s)
-TRANS(vavgr_d, gvec_vvv, MO_64, do_vavgr_s)
-TRANS(vavgr_bu, gvec_vvv, MO_8, do_vavgr_u)
-TRANS(vavgr_hu, gvec_vvv, MO_16, do_vavgr_u)
-TRANS(vavgr_wu, gvec_vvv, MO_32, do_vavgr_u)
-TRANS(vavgr_du, gvec_vvv, MO_64, do_vavgr_u)
+TRANS(vavgr_b, ALL, gvec_vvv, MO_8, do_vavgr_s)
+TRANS(vavgr_h, ALL, gvec_vvv, MO_16, do_vavgr_s)
+TRANS(vavgr_w, ALL, gvec_vvv, MO_32, do_vavgr_s)
+TRANS(vavgr_d, ALL, gvec_vvv, MO_64, do_vavgr_s)
+TRANS(vavgr_bu, ALL, gvec_vvv, MO_8, do_vavgr_u)
+TRANS(vavgr_hu, ALL, gvec_vvv, MO_16, do_vavgr_u)
+TRANS(vavgr_wu, ALL, gvec_vvv, MO_32, do_vavgr_u)
+TRANS(vavgr_du, ALL, gvec_vvv, MO_64, do_vavgr_u)
 
 static void gen_vabsd_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1301,14 +1301,14 @@ static void do_vabsd_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vabsd_b, gvec_vvv, MO_8, do_vabsd_s)
-TRANS(vabsd_h, gvec_vvv, MO_16, do_vabsd_s)
-TRANS(vabsd_w, gvec_vvv, MO_32, do_vabsd_s)
-TRANS(vabsd_d, gvec_vvv, MO_64, do_vabsd_s)
-TRANS(vabsd_bu, gvec_vvv, MO_8, do_vabsd_u)
-TRANS(vabsd_hu, gvec_vvv, MO_16, do_vabsd_u)
-TRANS(vabsd_wu, gvec_vvv, MO_32, do_vabsd_u)
-TRANS(vabsd_du, gvec_vvv, MO_64, do_vabsd_u)
+TRANS(vabsd_b, ALL, gvec_vvv, MO_8, do_vabsd_s)
+TRANS(vabsd_h, ALL, gvec_vvv, MO_16, do_vabsd_s)
+TRANS(vabsd_w, ALL, gvec_vvv, MO_32, do_vabsd_s)
+TRANS(vabsd_d, ALL, gvec_vvv, MO_64, do_vabsd_s)
+TRANS(vabsd_bu, ALL, gvec_vvv, MO_8, do_vabsd_u)
+TRANS(vabsd_hu, ALL, gvec_vvv, MO_16, do_vabsd_u)
+TRANS(vabsd_wu, ALL, gvec_vvv, MO_32, do_vabsd_u)
+TRANS(vabsd_du, ALL, gvec_vvv, MO_64, do_vabsd_u)
 
 static void gen_vadda(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1358,28 +1358,28 @@ static void do_vadda(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vadda_b, gvec_vvv, MO_8, do_vadda)
-TRANS(vadda_h, gvec_vvv, MO_16, do_vadda)
-TRANS(vadda_w, gvec_vvv, MO_32, do_vadda)
-TRANS(vadda_d, gvec_vvv, MO_64, do_vadda)
-
-TRANS(vmax_b, gvec_vvv, MO_8, tcg_gen_gvec_smax)
-TRANS(vmax_h, gvec_vvv, MO_16, tcg_gen_gvec_smax)
-TRANS(vmax_w, gvec_vvv, MO_32, tcg_gen_gvec_smax)
-TRANS(vmax_d, gvec_vvv, MO_64, tcg_gen_gvec_smax)
-TRANS(vmax_bu, gvec_vvv, MO_8, tcg_gen_gvec_umax)
-TRANS(vmax_hu, gvec_vvv, MO_16, tcg_gen_gvec_umax)
-TRANS(vmax_wu, gvec_vvv, MO_32, tcg_gen_gvec_umax)
-TRANS(vmax_du, gvec_vvv, MO_64, tcg_gen_gvec_umax)
-
-TRANS(vmin_b, gvec_vvv, MO_8, tcg_gen_gvec_smin)
-TRANS(vmin_h, gvec_vvv, MO_16, tcg_gen_gvec_smin)
-TRANS(vmin_w, gvec_vvv, MO_32, tcg_gen_gvec_smin)
-TRANS(vmin_d, gvec_vvv, MO_64, tcg_gen_gvec_smin)
-TRANS(vmin_bu, gvec_vvv, MO_8, tcg_gen_gvec_umin)
-TRANS(vmin_hu, gvec_vvv, MO_16, tcg_gen_gvec_umin)
-TRANS(vmin_wu, gvec_vvv, MO_32, tcg_gen_gvec_umin)
-TRANS(vmin_du, gvec_vvv, MO_64, tcg_gen_gvec_umin)
+TRANS(vadda_b, ALL, gvec_vvv, MO_8, do_vadda)
+TRANS(vadda_h, ALL, gvec_vvv, MO_16, do_vadda)
+TRANS(vadda_w, ALL, gvec_vvv, MO_32, do_vadda)
+TRANS(vadda_d, ALL, gvec_vvv, MO_64, do_vadda)
+
+TRANS(vmax_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_smax)
+TRANS(vmax_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_smax)
+TRANS(vmax_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_smax)
+TRANS(vmax_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_smax)
+TRANS(vmax_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_umax)
+TRANS(vmax_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_umax)
+TRANS(vmax_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_umax)
+TRANS(vmax_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_umax)
+
+TRANS(vmin_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_smin)
+TRANS(vmin_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_smin)
+TRANS(vmin_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_smin)
+TRANS(vmin_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_smin)
+TRANS(vmin_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_umin)
+TRANS(vmin_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_umin)
+TRANS(vmin_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_umin)
+TRANS(vmin_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_umin)
 
 static void gen_vmini_s(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -1473,14 +1473,14 @@ static void do_vmini_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmini_b, gvec_vv_i, MO_8, do_vmini_s)
-TRANS(vmini_h, gvec_vv_i, MO_16, do_vmini_s)
-TRANS(vmini_w, gvec_vv_i, MO_32, do_vmini_s)
-TRANS(vmini_d, gvec_vv_i, MO_64, do_vmini_s)
-TRANS(vmini_bu, gvec_vv_i, MO_8, do_vmini_u)
-TRANS(vmini_hu, gvec_vv_i, MO_16, do_vmini_u)
-TRANS(vmini_wu, gvec_vv_i, MO_32, do_vmini_u)
-TRANS(vmini_du, gvec_vv_i, MO_64, do_vmini_u)
+TRANS(vmini_b, ALL, gvec_vv_i, MO_8, do_vmini_s)
+TRANS(vmini_h, ALL, gvec_vv_i, MO_16, do_vmini_s)
+TRANS(vmini_w, ALL, gvec_vv_i, MO_32, do_vmini_s)
+TRANS(vmini_d, ALL, gvec_vv_i, MO_64, do_vmini_s)
+TRANS(vmini_bu, ALL, gvec_vv_i, MO_8, do_vmini_u)
+TRANS(vmini_hu, ALL, gvec_vv_i, MO_16, do_vmini_u)
+TRANS(vmini_wu, ALL, gvec_vv_i, MO_32, do_vmini_u)
+TRANS(vmini_du, ALL, gvec_vv_i, MO_64, do_vmini_u)
 
 static void do_vmaxi_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -1554,19 +1554,19 @@ static void do_vmaxi_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmaxi_b, gvec_vv_i, MO_8, do_vmaxi_s)
-TRANS(vmaxi_h, gvec_vv_i, MO_16, do_vmaxi_s)
-TRANS(vmaxi_w, gvec_vv_i, MO_32, do_vmaxi_s)
-TRANS(vmaxi_d, gvec_vv_i, MO_64, do_vmaxi_s)
-TRANS(vmaxi_bu, gvec_vv_i, MO_8, do_vmaxi_u)
-TRANS(vmaxi_hu, gvec_vv_i, MO_16, do_vmaxi_u)
-TRANS(vmaxi_wu, gvec_vv_i, MO_32, do_vmaxi_u)
-TRANS(vmaxi_du, gvec_vv_i, MO_64, do_vmaxi_u)
+TRANS(vmaxi_b, ALL, gvec_vv_i, MO_8, do_vmaxi_s)
+TRANS(vmaxi_h, ALL, gvec_vv_i, MO_16, do_vmaxi_s)
+TRANS(vmaxi_w, ALL, gvec_vv_i, MO_32, do_vmaxi_s)
+TRANS(vmaxi_d, ALL, gvec_vv_i, MO_64, do_vmaxi_s)
+TRANS(vmaxi_bu, ALL, gvec_vv_i, MO_8, do_vmaxi_u)
+TRANS(vmaxi_hu, ALL, gvec_vv_i, MO_16, do_vmaxi_u)
+TRANS(vmaxi_wu, ALL, gvec_vv_i, MO_32, do_vmaxi_u)
+TRANS(vmaxi_du, ALL, gvec_vv_i, MO_64, do_vmaxi_u)
 
-TRANS(vmul_b, gvec_vvv, MO_8, tcg_gen_gvec_mul)
-TRANS(vmul_h, gvec_vvv, MO_16, tcg_gen_gvec_mul)
-TRANS(vmul_w, gvec_vvv, MO_32, tcg_gen_gvec_mul)
-TRANS(vmul_d, gvec_vvv, MO_64, tcg_gen_gvec_mul)
+TRANS(vmul_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_mul)
+TRANS(vmul_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_mul)
+TRANS(vmul_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_mul)
+TRANS(vmul_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_mul)
 
 static void gen_vmuh_w(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1607,10 +1607,10 @@ static void do_vmuh_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_b, gvec_vvv, MO_8, do_vmuh_s)
-TRANS(vmuh_h, gvec_vvv, MO_16, do_vmuh_s)
-TRANS(vmuh_w, gvec_vvv, MO_32, do_vmuh_s)
-TRANS(vmuh_d, gvec_vvv, MO_64, do_vmuh_s)
+TRANS(vmuh_b, ALL, gvec_vvv, MO_8, do_vmuh_s)
+TRANS(vmuh_h, ALL, gvec_vvv, MO_16, do_vmuh_s)
+TRANS(vmuh_w, ALL, gvec_vvv, MO_32, do_vmuh_s)
+TRANS(vmuh_d, ALL, gvec_vvv, MO_64, do_vmuh_s)
 
 static void gen_vmuh_wu(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1651,10 +1651,10 @@ static void do_vmuh_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_bu, gvec_vvv, MO_8,  do_vmuh_u)
-TRANS(vmuh_hu, gvec_vvv, MO_16, do_vmuh_u)
-TRANS(vmuh_wu, gvec_vvv, MO_32, do_vmuh_u)
-TRANS(vmuh_du, gvec_vvv, MO_64, do_vmuh_u)
+TRANS(vmuh_bu, ALL, gvec_vvv, MO_8,  do_vmuh_u)
+TRANS(vmuh_hu, ALL, gvec_vvv, MO_16, do_vmuh_u)
+TRANS(vmuh_wu, ALL, gvec_vvv, MO_32, do_vmuh_u)
+TRANS(vmuh_du, ALL, gvec_vvv, MO_64, do_vmuh_u)
 
 static void gen_vmulwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1724,9 +1724,9 @@ static void do_vmulwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_b, gvec_vvv, MO_8, do_vmulwev_s)
-TRANS(vmulwev_w_h, gvec_vvv, MO_16, do_vmulwev_s)
-TRANS(vmulwev_d_w, gvec_vvv, MO_32, do_vmulwev_s)
+TRANS(vmulwev_h_b, ALL, gvec_vvv, MO_8, do_vmulwev_s)
+TRANS(vmulwev_w_h, ALL, gvec_vvv, MO_16, do_vmulwev_s)
+TRANS(vmulwev_d_w, ALL, gvec_vvv, MO_32, do_vmulwev_s)
 
 static void tcg_gen_mulus2_i64(TCGv_i64 rl, TCGv_i64 rh,
                                TCGv_i64 arg1, TCGv_i64 arg2)
@@ -1828,9 +1828,9 @@ static void do_vmulwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_b, gvec_vvv, MO_8, do_vmulwod_s)
-TRANS(vmulwod_w_h, gvec_vvv, MO_16, do_vmulwod_s)
-TRANS(vmulwod_d_w, gvec_vvv, MO_32, do_vmulwod_s)
+TRANS(vmulwod_h_b, ALL, gvec_vvv, MO_8, do_vmulwod_s)
+TRANS(vmulwod_w_h, ALL, gvec_vvv, MO_16, do_vmulwod_s)
+TRANS(vmulwod_d_w, ALL, gvec_vvv, MO_32, do_vmulwod_s)
 
 static void gen_vmulwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1898,9 +1898,9 @@ static void do_vmulwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu, gvec_vvv, MO_8, do_vmulwev_u)
-TRANS(vmulwev_w_hu, gvec_vvv, MO_16, do_vmulwev_u)
-TRANS(vmulwev_d_wu, gvec_vvv, MO_32, do_vmulwev_u)
+TRANS(vmulwev_h_bu, ALL, gvec_vvv, MO_8, do_vmulwev_u)
+TRANS(vmulwev_w_hu, ALL, gvec_vvv, MO_16, do_vmulwev_u)
+TRANS(vmulwev_d_wu, ALL, gvec_vvv, MO_32, do_vmulwev_u)
 
 static void gen_vmulwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1968,9 +1968,9 @@ static void do_vmulwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu, gvec_vvv, MO_8, do_vmulwod_u)
-TRANS(vmulwod_w_hu, gvec_vvv, MO_16, do_vmulwod_u)
-TRANS(vmulwod_d_wu, gvec_vvv, MO_32, do_vmulwod_u)
+TRANS(vmulwod_h_bu, ALL, gvec_vvv, MO_8, do_vmulwod_u)
+TRANS(vmulwod_w_hu, ALL, gvec_vvv, MO_16, do_vmulwod_u)
+TRANS(vmulwod_d_wu, ALL, gvec_vvv, MO_32, do_vmulwod_u)
 
 static void gen_vmulwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2040,9 +2040,9 @@ static void do_vmulwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu_b, gvec_vvv, MO_8, do_vmulwev_u_s)
-TRANS(vmulwev_w_hu_h, gvec_vvv, MO_16, do_vmulwev_u_s)
-TRANS(vmulwev_d_wu_w, gvec_vvv, MO_32, do_vmulwev_u_s)
+TRANS(vmulwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vmulwev_u_s)
+TRANS(vmulwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vmulwev_u_s)
+TRANS(vmulwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vmulwev_u_s)
 
 static void gen_vmulwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2109,9 +2109,9 @@ static void do_vmulwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu_b, gvec_vvv, MO_8, do_vmulwod_u_s)
-TRANS(vmulwod_w_hu_h, gvec_vvv, MO_16, do_vmulwod_u_s)
-TRANS(vmulwod_d_wu_w, gvec_vvv, MO_32, do_vmulwod_u_s)
+TRANS(vmulwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vmulwod_u_s)
+TRANS(vmulwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vmulwod_u_s)
+TRANS(vmulwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vmulwod_u_s)
 
 static void gen_vmadd(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2182,10 +2182,10 @@ static void do_vmadd(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmadd_b, gvec_vvv, MO_8, do_vmadd)
-TRANS(vmadd_h, gvec_vvv, MO_16, do_vmadd)
-TRANS(vmadd_w, gvec_vvv, MO_32, do_vmadd)
-TRANS(vmadd_d, gvec_vvv, MO_64, do_vmadd)
+TRANS(vmadd_b, ALL, gvec_vvv, MO_8, do_vmadd)
+TRANS(vmadd_h, ALL, gvec_vvv, MO_16, do_vmadd)
+TRANS(vmadd_w, ALL, gvec_vvv, MO_32, do_vmadd)
+TRANS(vmadd_d, ALL, gvec_vvv, MO_64, do_vmadd)
 
 static void gen_vmsub(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2256,10 +2256,10 @@ static void do_vmsub(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmsub_b, gvec_vvv, MO_8, do_vmsub)
-TRANS(vmsub_h, gvec_vvv, MO_16, do_vmsub)
-TRANS(vmsub_w, gvec_vvv, MO_32, do_vmsub)
-TRANS(vmsub_d, gvec_vvv, MO_64, do_vmsub)
+TRANS(vmsub_b, ALL, gvec_vvv, MO_8, do_vmsub)
+TRANS(vmsub_h, ALL, gvec_vvv, MO_16, do_vmsub)
+TRANS(vmsub_w, ALL, gvec_vvv, MO_32, do_vmsub)
+TRANS(vmsub_d, ALL, gvec_vvv, MO_64, do_vmsub)
 
 static void gen_vmaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2331,9 +2331,9 @@ static void do_vmaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_b, gvec_vvv, MO_8, do_vmaddwev_s)
-TRANS(vmaddwev_w_h, gvec_vvv, MO_16, do_vmaddwev_s)
-TRANS(vmaddwev_d_w, gvec_vvv, MO_32, do_vmaddwev_s)
+TRANS(vmaddwev_h_b, ALL, gvec_vvv, MO_8, do_vmaddwev_s)
+TRANS(vmaddwev_w_h, ALL, gvec_vvv, MO_16, do_vmaddwev_s)
+TRANS(vmaddwev_d_w, ALL, gvec_vvv, MO_32, do_vmaddwev_s)
 
 #define VMADD_Q(NAME, FN, idx1, idx2)                     \
 static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
@@ -2435,9 +2435,9 @@ static void do_vmaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_b, gvec_vvv, MO_8, do_vmaddwod_s)
-TRANS(vmaddwod_w_h, gvec_vvv, MO_16, do_vmaddwod_s)
-TRANS(vmaddwod_d_w, gvec_vvv, MO_32, do_vmaddwod_s)
+TRANS(vmaddwod_h_b, ALL, gvec_vvv, MO_8, do_vmaddwod_s)
+TRANS(vmaddwod_w_h, ALL, gvec_vvv, MO_16, do_vmaddwod_s)
+TRANS(vmaddwod_d_w, ALL, gvec_vvv, MO_32, do_vmaddwod_s)
 
 static void gen_vmaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2505,9 +2505,9 @@ static void do_vmaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu, gvec_vvv, MO_8, do_vmaddwev_u)
-TRANS(vmaddwev_w_hu, gvec_vvv, MO_16, do_vmaddwev_u)
-TRANS(vmaddwev_d_wu, gvec_vvv, MO_32, do_vmaddwev_u)
+TRANS(vmaddwev_h_bu, ALL, gvec_vvv, MO_8, do_vmaddwev_u)
+TRANS(vmaddwev_w_hu, ALL, gvec_vvv, MO_16, do_vmaddwev_u)
+TRANS(vmaddwev_d_wu, ALL, gvec_vvv, MO_32, do_vmaddwev_u)
 
 static void gen_vmaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2576,9 +2576,9 @@ static void do_vmaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu, gvec_vvv, MO_8, do_vmaddwod_u)
-TRANS(vmaddwod_w_hu, gvec_vvv, MO_16, do_vmaddwod_u)
-TRANS(vmaddwod_d_wu, gvec_vvv, MO_32, do_vmaddwod_u)
+TRANS(vmaddwod_h_bu, ALL, gvec_vvv, MO_8, do_vmaddwod_u)
+TRANS(vmaddwod_w_hu, ALL, gvec_vvv, MO_16, do_vmaddwod_u)
+TRANS(vmaddwod_d_wu, ALL, gvec_vvv, MO_32, do_vmaddwod_u)
 
 static void gen_vmaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2649,9 +2649,9 @@ static void do_vmaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu_b, gvec_vvv, MO_8, do_vmaddwev_u_s)
-TRANS(vmaddwev_w_hu_h, gvec_vvv, MO_16, do_vmaddwev_u_s)
-TRANS(vmaddwev_d_wu_w, gvec_vvv, MO_32, do_vmaddwev_u_s)
+TRANS(vmaddwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vmaddwev_u_s)
+TRANS(vmaddwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vmaddwev_u_s)
+TRANS(vmaddwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vmaddwev_u_s)
 
 static void gen_vmaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2721,26 +2721,26 @@ static void do_vmaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu_b, gvec_vvv, MO_8, do_vmaddwod_u_s)
-TRANS(vmaddwod_w_hu_h, gvec_vvv, MO_16, do_vmaddwod_u_s)
-TRANS(vmaddwod_d_wu_w, gvec_vvv, MO_32, do_vmaddwod_u_s)
-
-TRANS(vdiv_b, gen_vvv, gen_helper_vdiv_b)
-TRANS(vdiv_h, gen_vvv, gen_helper_vdiv_h)
-TRANS(vdiv_w, gen_vvv, gen_helper_vdiv_w)
-TRANS(vdiv_d, gen_vvv, gen_helper_vdiv_d)
-TRANS(vdiv_bu, gen_vvv, gen_helper_vdiv_bu)
-TRANS(vdiv_hu, gen_vvv, gen_helper_vdiv_hu)
-TRANS(vdiv_wu, gen_vvv, gen_helper_vdiv_wu)
-TRANS(vdiv_du, gen_vvv, gen_helper_vdiv_du)
-TRANS(vmod_b, gen_vvv, gen_helper_vmod_b)
-TRANS(vmod_h, gen_vvv, gen_helper_vmod_h)
-TRANS(vmod_w, gen_vvv, gen_helper_vmod_w)
-TRANS(vmod_d, gen_vvv, gen_helper_vmod_d)
-TRANS(vmod_bu, gen_vvv, gen_helper_vmod_bu)
-TRANS(vmod_hu, gen_vvv, gen_helper_vmod_hu)
-TRANS(vmod_wu, gen_vvv, gen_helper_vmod_wu)
-TRANS(vmod_du, gen_vvv, gen_helper_vmod_du)
+TRANS(vmaddwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vmaddwod_u_s)
+TRANS(vmaddwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vmaddwod_u_s)
+TRANS(vmaddwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vmaddwod_u_s)
+
+TRANS(vdiv_b, ALL, gen_vvv, gen_helper_vdiv_b)
+TRANS(vdiv_h, ALL, gen_vvv, gen_helper_vdiv_h)
+TRANS(vdiv_w, ALL, gen_vvv, gen_helper_vdiv_w)
+TRANS(vdiv_d, ALL, gen_vvv, gen_helper_vdiv_d)
+TRANS(vdiv_bu, ALL, gen_vvv, gen_helper_vdiv_bu)
+TRANS(vdiv_hu, ALL, gen_vvv, gen_helper_vdiv_hu)
+TRANS(vdiv_wu, ALL, gen_vvv, gen_helper_vdiv_wu)
+TRANS(vdiv_du, ALL, gen_vvv, gen_helper_vdiv_du)
+TRANS(vmod_b, ALL, gen_vvv, gen_helper_vmod_b)
+TRANS(vmod_h, ALL, gen_vvv, gen_helper_vmod_h)
+TRANS(vmod_w, ALL, gen_vvv, gen_helper_vmod_w)
+TRANS(vmod_d, ALL, gen_vvv, gen_helper_vmod_d)
+TRANS(vmod_bu, ALL, gen_vvv, gen_helper_vmod_bu)
+TRANS(vmod_hu, ALL, gen_vvv, gen_helper_vmod_hu)
+TRANS(vmod_wu, ALL, gen_vvv, gen_helper_vmod_wu)
+TRANS(vmod_du, ALL, gen_vvv, gen_helper_vmod_du)
 
 static void gen_vsat_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -2789,10 +2789,10 @@ static void do_vsat_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64((1ll<< imm) -1), &op[vece]);
 }
 
-TRANS(vsat_b, gvec_vv_i, MO_8, do_vsat_s)
-TRANS(vsat_h, gvec_vv_i, MO_16, do_vsat_s)
-TRANS(vsat_w, gvec_vv_i, MO_32, do_vsat_s)
-TRANS(vsat_d, gvec_vv_i, MO_64, do_vsat_s)
+TRANS(vsat_b, ALL, gvec_vv_i, MO_8, do_vsat_s)
+TRANS(vsat_h, ALL, gvec_vv_i, MO_16, do_vsat_s)
+TRANS(vsat_w, ALL, gvec_vv_i, MO_32, do_vsat_s)
+TRANS(vsat_d, ALL, gvec_vv_i, MO_64, do_vsat_s)
 
 static void gen_vsat_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -2838,19 +2838,19 @@ static void do_vsat_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64(max), &op[vece]);
 }
 
-TRANS(vsat_bu, gvec_vv_i, MO_8, do_vsat_u)
-TRANS(vsat_hu, gvec_vv_i, MO_16, do_vsat_u)
-TRANS(vsat_wu, gvec_vv_i, MO_32, do_vsat_u)
-TRANS(vsat_du, gvec_vv_i, MO_64, do_vsat_u)
+TRANS(vsat_bu, ALL, gvec_vv_i, MO_8, do_vsat_u)
+TRANS(vsat_hu, ALL, gvec_vv_i, MO_16, do_vsat_u)
+TRANS(vsat_wu, ALL, gvec_vv_i, MO_32, do_vsat_u)
+TRANS(vsat_du, ALL, gvec_vv_i, MO_64, do_vsat_u)
 
-TRANS(vexth_h_b, gen_vv, gen_helper_vexth_h_b)
-TRANS(vexth_w_h, gen_vv, gen_helper_vexth_w_h)
-TRANS(vexth_d_w, gen_vv, gen_helper_vexth_d_w)
-TRANS(vexth_q_d, gen_vv, gen_helper_vexth_q_d)
-TRANS(vexth_hu_bu, gen_vv, gen_helper_vexth_hu_bu)
-TRANS(vexth_wu_hu, gen_vv, gen_helper_vexth_wu_hu)
-TRANS(vexth_du_wu, gen_vv, gen_helper_vexth_du_wu)
-TRANS(vexth_qu_du, gen_vv, gen_helper_vexth_qu_du)
+TRANS(vexth_h_b, ALL, gen_vv, gen_helper_vexth_h_b)
+TRANS(vexth_w_h, ALL, gen_vv, gen_helper_vexth_w_h)
+TRANS(vexth_d_w, ALL, gen_vv, gen_helper_vexth_d_w)
+TRANS(vexth_q_d, ALL, gen_vv, gen_helper_vexth_q_d)
+TRANS(vexth_hu_bu, ALL, gen_vv, gen_helper_vexth_hu_bu)
+TRANS(vexth_wu_hu, ALL, gen_vv, gen_helper_vexth_wu_hu)
+TRANS(vexth_du_wu, ALL, gen_vv, gen_helper_vexth_du_wu)
+TRANS(vexth_qu_du, ALL, gen_vv, gen_helper_vexth_qu_du)
 
 static void gen_vsigncov(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2900,17 +2900,17 @@ static void do_vsigncov(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsigncov_b, gvec_vvv, MO_8, do_vsigncov)
-TRANS(vsigncov_h, gvec_vvv, MO_16, do_vsigncov)
-TRANS(vsigncov_w, gvec_vvv, MO_32, do_vsigncov)
-TRANS(vsigncov_d, gvec_vvv, MO_64, do_vsigncov)
+TRANS(vsigncov_b, ALL, gvec_vvv, MO_8, do_vsigncov)
+TRANS(vsigncov_h, ALL, gvec_vvv, MO_16, do_vsigncov)
+TRANS(vsigncov_w, ALL, gvec_vvv, MO_32, do_vsigncov)
+TRANS(vsigncov_d, ALL, gvec_vvv, MO_64, do_vsigncov)
 
-TRANS(vmskltz_b, gen_vv, gen_helper_vmskltz_b)
-TRANS(vmskltz_h, gen_vv, gen_helper_vmskltz_h)
-TRANS(vmskltz_w, gen_vv, gen_helper_vmskltz_w)
-TRANS(vmskltz_d, gen_vv, gen_helper_vmskltz_d)
-TRANS(vmskgez_b, gen_vv, gen_helper_vmskgez_b)
-TRANS(vmsknz_b, gen_vv, gen_helper_vmsknz_b)
+TRANS(vmskltz_b, ALL, gen_vv, gen_helper_vmskltz_b)
+TRANS(vmskltz_h, ALL, gen_vv, gen_helper_vmskltz_h)
+TRANS(vmskltz_w, ALL, gen_vv, gen_helper_vmskltz_w)
+TRANS(vmskltz_d, ALL, gen_vv, gen_helper_vmskltz_d)
+TRANS(vmskgez_b, ALL, gen_vv, gen_helper_vmskgez_b)
+TRANS(vmsknz_b, ALL, gen_vv, gen_helper_vmsknz_b)
 
 #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
 
@@ -3049,10 +3049,10 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
     return true;
 }
 
-TRANS(vand_v, gvec_vvv, MO_64, tcg_gen_gvec_and)
-TRANS(vor_v, gvec_vvv, MO_64, tcg_gen_gvec_or)
-TRANS(vxor_v, gvec_vvv, MO_64, tcg_gen_gvec_xor)
-TRANS(vnor_v, gvec_vvv, MO_64, tcg_gen_gvec_nor)
+TRANS(vand_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_and)
+TRANS(vor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_or)
+TRANS(vxor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_xor)
+TRANS(vnor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_nor)
 
 static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
 {
@@ -3067,10 +3067,10 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
     return true;
 }
-TRANS(vorn_v, gvec_vvv, MO_64, tcg_gen_gvec_orc)
-TRANS(vandi_b, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
-TRANS(vori_b, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
-TRANS(vxori_b, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
+TRANS(vorn_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_orc)
+TRANS(vandi_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
+TRANS(vori_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
+TRANS(vxori_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
 
 static void gen_vnori(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -3103,176 +3103,176 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op);
 }
 
-TRANS(vnori_b, gvec_vv_i, MO_8, do_vnori_b)
-
-TRANS(vsll_b, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
-TRANS(vsll_h, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
-TRANS(vsll_w, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
-TRANS(vsll_d, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
-TRANS(vslli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
-TRANS(vslli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
-TRANS(vslli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
-TRANS(vslli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
-
-TRANS(vsrl_b, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
-TRANS(vsrl_h, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
-TRANS(vsrl_w, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
-TRANS(vsrl_d, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
-TRANS(vsrli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
-TRANS(vsrli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
-TRANS(vsrli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
-TRANS(vsrli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
-
-TRANS(vsra_b, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
-TRANS(vsra_h, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
-TRANS(vsra_w, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
-TRANS(vsra_d, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
-TRANS(vsrai_b, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
-TRANS(vsrai_h, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
-TRANS(vsrai_w, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
-TRANS(vsrai_d, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
-
-TRANS(vrotr_b, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
-TRANS(vrotr_h, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
-TRANS(vrotr_w, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
-TRANS(vrotr_d, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
-TRANS(vrotri_b, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
-TRANS(vrotri_h, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
-TRANS(vrotri_w, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
-TRANS(vrotri_d, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
-
-TRANS(vsllwil_h_b, gen_vv_i, gen_helper_vsllwil_h_b)
-TRANS(vsllwil_w_h, gen_vv_i, gen_helper_vsllwil_w_h)
-TRANS(vsllwil_d_w, gen_vv_i, gen_helper_vsllwil_d_w)
-TRANS(vextl_q_d, gen_vv, gen_helper_vextl_q_d)
-TRANS(vsllwil_hu_bu, gen_vv_i, gen_helper_vsllwil_hu_bu)
-TRANS(vsllwil_wu_hu, gen_vv_i, gen_helper_vsllwil_wu_hu)
-TRANS(vsllwil_du_wu, gen_vv_i, gen_helper_vsllwil_du_wu)
-TRANS(vextl_qu_du, gen_vv, gen_helper_vextl_qu_du)
-
-TRANS(vsrlr_b, gen_vvv, gen_helper_vsrlr_b)
-TRANS(vsrlr_h, gen_vvv, gen_helper_vsrlr_h)
-TRANS(vsrlr_w, gen_vvv, gen_helper_vsrlr_w)
-TRANS(vsrlr_d, gen_vvv, gen_helper_vsrlr_d)
-TRANS(vsrlri_b, gen_vv_i, gen_helper_vsrlri_b)
-TRANS(vsrlri_h, gen_vv_i, gen_helper_vsrlri_h)
-TRANS(vsrlri_w, gen_vv_i, gen_helper_vsrlri_w)
-TRANS(vsrlri_d, gen_vv_i, gen_helper_vsrlri_d)
-
-TRANS(vsrar_b, gen_vvv, gen_helper_vsrar_b)
-TRANS(vsrar_h, gen_vvv, gen_helper_vsrar_h)
-TRANS(vsrar_w, gen_vvv, gen_helper_vsrar_w)
-TRANS(vsrar_d, gen_vvv, gen_helper_vsrar_d)
-TRANS(vsrari_b, gen_vv_i, gen_helper_vsrari_b)
-TRANS(vsrari_h, gen_vv_i, gen_helper_vsrari_h)
-TRANS(vsrari_w, gen_vv_i, gen_helper_vsrari_w)
-TRANS(vsrari_d, gen_vv_i, gen_helper_vsrari_d)
-
-TRANS(vsrln_b_h, gen_vvv, gen_helper_vsrln_b_h)
-TRANS(vsrln_h_w, gen_vvv, gen_helper_vsrln_h_w)
-TRANS(vsrln_w_d, gen_vvv, gen_helper_vsrln_w_d)
-TRANS(vsran_b_h, gen_vvv, gen_helper_vsran_b_h)
-TRANS(vsran_h_w, gen_vvv, gen_helper_vsran_h_w)
-TRANS(vsran_w_d, gen_vvv, gen_helper_vsran_w_d)
-
-TRANS(vsrlni_b_h, gen_vv_i, gen_helper_vsrlni_b_h)
-TRANS(vsrlni_h_w, gen_vv_i, gen_helper_vsrlni_h_w)
-TRANS(vsrlni_w_d, gen_vv_i, gen_helper_vsrlni_w_d)
-TRANS(vsrlni_d_q, gen_vv_i, gen_helper_vsrlni_d_q)
-TRANS(vsrani_b_h, gen_vv_i, gen_helper_vsrani_b_h)
-TRANS(vsrani_h_w, gen_vv_i, gen_helper_vsrani_h_w)
-TRANS(vsrani_w_d, gen_vv_i, gen_helper_vsrani_w_d)
-TRANS(vsrani_d_q, gen_vv_i, gen_helper_vsrani_d_q)
-
-TRANS(vsrlrn_b_h, gen_vvv, gen_helper_vsrlrn_b_h)
-TRANS(vsrlrn_h_w, gen_vvv, gen_helper_vsrlrn_h_w)
-TRANS(vsrlrn_w_d, gen_vvv, gen_helper_vsrlrn_w_d)
-TRANS(vsrarn_b_h, gen_vvv, gen_helper_vsrarn_b_h)
-TRANS(vsrarn_h_w, gen_vvv, gen_helper_vsrarn_h_w)
-TRANS(vsrarn_w_d, gen_vvv, gen_helper_vsrarn_w_d)
-
-TRANS(vsrlrni_b_h, gen_vv_i, gen_helper_vsrlrni_b_h)
-TRANS(vsrlrni_h_w, gen_vv_i, gen_helper_vsrlrni_h_w)
-TRANS(vsrlrni_w_d, gen_vv_i, gen_helper_vsrlrni_w_d)
-TRANS(vsrlrni_d_q, gen_vv_i, gen_helper_vsrlrni_d_q)
-TRANS(vsrarni_b_h, gen_vv_i, gen_helper_vsrarni_b_h)
-TRANS(vsrarni_h_w, gen_vv_i, gen_helper_vsrarni_h_w)
-TRANS(vsrarni_w_d, gen_vv_i, gen_helper_vsrarni_w_d)
-TRANS(vsrarni_d_q, gen_vv_i, gen_helper_vsrarni_d_q)
-
-TRANS(vssrln_b_h, gen_vvv, gen_helper_vssrln_b_h)
-TRANS(vssrln_h_w, gen_vvv, gen_helper_vssrln_h_w)
-TRANS(vssrln_w_d, gen_vvv, gen_helper_vssrln_w_d)
-TRANS(vssran_b_h, gen_vvv, gen_helper_vssran_b_h)
-TRANS(vssran_h_w, gen_vvv, gen_helper_vssran_h_w)
-TRANS(vssran_w_d, gen_vvv, gen_helper_vssran_w_d)
-TRANS(vssrln_bu_h, gen_vvv, gen_helper_vssrln_bu_h)
-TRANS(vssrln_hu_w, gen_vvv, gen_helper_vssrln_hu_w)
-TRANS(vssrln_wu_d, gen_vvv, gen_helper_vssrln_wu_d)
-TRANS(vssran_bu_h, gen_vvv, gen_helper_vssran_bu_h)
-TRANS(vssran_hu_w, gen_vvv, gen_helper_vssran_hu_w)
-TRANS(vssran_wu_d, gen_vvv, gen_helper_vssran_wu_d)
-
-TRANS(vssrlni_b_h, gen_vv_i, gen_helper_vssrlni_b_h)
-TRANS(vssrlni_h_w, gen_vv_i, gen_helper_vssrlni_h_w)
-TRANS(vssrlni_w_d, gen_vv_i, gen_helper_vssrlni_w_d)
-TRANS(vssrlni_d_q, gen_vv_i, gen_helper_vssrlni_d_q)
-TRANS(vssrani_b_h, gen_vv_i, gen_helper_vssrani_b_h)
-TRANS(vssrani_h_w, gen_vv_i, gen_helper_vssrani_h_w)
-TRANS(vssrani_w_d, gen_vv_i, gen_helper_vssrani_w_d)
-TRANS(vssrani_d_q, gen_vv_i, gen_helper_vssrani_d_q)
-TRANS(vssrlni_bu_h, gen_vv_i, gen_helper_vssrlni_bu_h)
-TRANS(vssrlni_hu_w, gen_vv_i, gen_helper_vssrlni_hu_w)
-TRANS(vssrlni_wu_d, gen_vv_i, gen_helper_vssrlni_wu_d)
-TRANS(vssrlni_du_q, gen_vv_i, gen_helper_vssrlni_du_q)
-TRANS(vssrani_bu_h, gen_vv_i, gen_helper_vssrani_bu_h)
-TRANS(vssrani_hu_w, gen_vv_i, gen_helper_vssrani_hu_w)
-TRANS(vssrani_wu_d, gen_vv_i, gen_helper_vssrani_wu_d)
-TRANS(vssrani_du_q, gen_vv_i, gen_helper_vssrani_du_q)
-
-TRANS(vssrlrn_b_h, gen_vvv, gen_helper_vssrlrn_b_h)
-TRANS(vssrlrn_h_w, gen_vvv, gen_helper_vssrlrn_h_w)
-TRANS(vssrlrn_w_d, gen_vvv, gen_helper_vssrlrn_w_d)
-TRANS(vssrarn_b_h, gen_vvv, gen_helper_vssrarn_b_h)
-TRANS(vssrarn_h_w, gen_vvv, gen_helper_vssrarn_h_w)
-TRANS(vssrarn_w_d, gen_vvv, gen_helper_vssrarn_w_d)
-TRANS(vssrlrn_bu_h, gen_vvv, gen_helper_vssrlrn_bu_h)
-TRANS(vssrlrn_hu_w, gen_vvv, gen_helper_vssrlrn_hu_w)
-TRANS(vssrlrn_wu_d, gen_vvv, gen_helper_vssrlrn_wu_d)
-TRANS(vssrarn_bu_h, gen_vvv, gen_helper_vssrarn_bu_h)
-TRANS(vssrarn_hu_w, gen_vvv, gen_helper_vssrarn_hu_w)
-TRANS(vssrarn_wu_d, gen_vvv, gen_helper_vssrarn_wu_d)
-
-TRANS(vssrlrni_b_h, gen_vv_i, gen_helper_vssrlrni_b_h)
-TRANS(vssrlrni_h_w, gen_vv_i, gen_helper_vssrlrni_h_w)
-TRANS(vssrlrni_w_d, gen_vv_i, gen_helper_vssrlrni_w_d)
-TRANS(vssrlrni_d_q, gen_vv_i, gen_helper_vssrlrni_d_q)
-TRANS(vssrarni_b_h, gen_vv_i, gen_helper_vssrarni_b_h)
-TRANS(vssrarni_h_w, gen_vv_i, gen_helper_vssrarni_h_w)
-TRANS(vssrarni_w_d, gen_vv_i, gen_helper_vssrarni_w_d)
-TRANS(vssrarni_d_q, gen_vv_i, gen_helper_vssrarni_d_q)
-TRANS(vssrlrni_bu_h, gen_vv_i, gen_helper_vssrlrni_bu_h)
-TRANS(vssrlrni_hu_w, gen_vv_i, gen_helper_vssrlrni_hu_w)
-TRANS(vssrlrni_wu_d, gen_vv_i, gen_helper_vssrlrni_wu_d)
-TRANS(vssrlrni_du_q, gen_vv_i, gen_helper_vssrlrni_du_q)
-TRANS(vssrarni_bu_h, gen_vv_i, gen_helper_vssrarni_bu_h)
-TRANS(vssrarni_hu_w, gen_vv_i, gen_helper_vssrarni_hu_w)
-TRANS(vssrarni_wu_d, gen_vv_i, gen_helper_vssrarni_wu_d)
-TRANS(vssrarni_du_q, gen_vv_i, gen_helper_vssrarni_du_q)
-
-TRANS(vclo_b, gen_vv, gen_helper_vclo_b)
-TRANS(vclo_h, gen_vv, gen_helper_vclo_h)
-TRANS(vclo_w, gen_vv, gen_helper_vclo_w)
-TRANS(vclo_d, gen_vv, gen_helper_vclo_d)
-TRANS(vclz_b, gen_vv, gen_helper_vclz_b)
-TRANS(vclz_h, gen_vv, gen_helper_vclz_h)
-TRANS(vclz_w, gen_vv, gen_helper_vclz_w)
-TRANS(vclz_d, gen_vv, gen_helper_vclz_d)
-
-TRANS(vpcnt_b, gen_vv, gen_helper_vpcnt_b)
-TRANS(vpcnt_h, gen_vv, gen_helper_vpcnt_h)
-TRANS(vpcnt_w, gen_vv, gen_helper_vpcnt_w)
-TRANS(vpcnt_d, gen_vv, gen_helper_vpcnt_d)
+TRANS(vnori_b, ALL, gvec_vv_i, MO_8, do_vnori_b)
+
+TRANS(vsll_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
+TRANS(vsll_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
+TRANS(vsll_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
+TRANS(vsll_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
+TRANS(vslli_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
+TRANS(vslli_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
+TRANS(vslli_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
+TRANS(vslli_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
+
+TRANS(vsrl_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
+TRANS(vsrl_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
+TRANS(vsrl_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
+TRANS(vsrl_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
+TRANS(vsrli_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
+TRANS(vsrli_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
+TRANS(vsrli_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
+TRANS(vsrli_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
+
+TRANS(vsra_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
+TRANS(vsra_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
+TRANS(vsra_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
+TRANS(vsra_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
+TRANS(vsrai_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
+TRANS(vsrai_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
+TRANS(vsrai_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
+TRANS(vsrai_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
+
+TRANS(vrotr_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
+TRANS(vrotr_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
+TRANS(vrotr_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
+TRANS(vrotr_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
+TRANS(vrotri_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
+TRANS(vrotri_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
+TRANS(vrotri_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
+TRANS(vrotri_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
+
+TRANS(vsllwil_h_b, ALL, gen_vv_i, gen_helper_vsllwil_h_b)
+TRANS(vsllwil_w_h, ALL, gen_vv_i, gen_helper_vsllwil_w_h)
+TRANS(vsllwil_d_w, ALL, gen_vv_i, gen_helper_vsllwil_d_w)
+TRANS(vextl_q_d, ALL, gen_vv, gen_helper_vextl_q_d)
+TRANS(vsllwil_hu_bu, ALL, gen_vv_i, gen_helper_vsllwil_hu_bu)
+TRANS(vsllwil_wu_hu, ALL, gen_vv_i, gen_helper_vsllwil_wu_hu)
+TRANS(vsllwil_du_wu, ALL, gen_vv_i, gen_helper_vsllwil_du_wu)
+TRANS(vextl_qu_du, ALL, gen_vv, gen_helper_vextl_qu_du)
+
+TRANS(vsrlr_b, ALL, gen_vvv, gen_helper_vsrlr_b)
+TRANS(vsrlr_h, ALL, gen_vvv, gen_helper_vsrlr_h)
+TRANS(vsrlr_w, ALL, gen_vvv, gen_helper_vsrlr_w)
+TRANS(vsrlr_d, ALL, gen_vvv, gen_helper_vsrlr_d)
+TRANS(vsrlri_b, ALL, gen_vv_i, gen_helper_vsrlri_b)
+TRANS(vsrlri_h, ALL, gen_vv_i, gen_helper_vsrlri_h)
+TRANS(vsrlri_w, ALL, gen_vv_i, gen_helper_vsrlri_w)
+TRANS(vsrlri_d, ALL, gen_vv_i, gen_helper_vsrlri_d)
+
+TRANS(vsrar_b, ALL, gen_vvv, gen_helper_vsrar_b)
+TRANS(vsrar_h, ALL, gen_vvv, gen_helper_vsrar_h)
+TRANS(vsrar_w, ALL, gen_vvv, gen_helper_vsrar_w)
+TRANS(vsrar_d, ALL, gen_vvv, gen_helper_vsrar_d)
+TRANS(vsrari_b, ALL, gen_vv_i, gen_helper_vsrari_b)
+TRANS(vsrari_h, ALL, gen_vv_i, gen_helper_vsrari_h)
+TRANS(vsrari_w, ALL, gen_vv_i, gen_helper_vsrari_w)
+TRANS(vsrari_d, ALL, gen_vv_i, gen_helper_vsrari_d)
+
+TRANS(vsrln_b_h, ALL, gen_vvv, gen_helper_vsrln_b_h)
+TRANS(vsrln_h_w, ALL, gen_vvv, gen_helper_vsrln_h_w)
+TRANS(vsrln_w_d, ALL, gen_vvv, gen_helper_vsrln_w_d)
+TRANS(vsran_b_h, ALL, gen_vvv, gen_helper_vsran_b_h)
+TRANS(vsran_h_w, ALL, gen_vvv, gen_helper_vsran_h_w)
+TRANS(vsran_w_d, ALL, gen_vvv, gen_helper_vsran_w_d)
+
+TRANS(vsrlni_b_h, ALL, gen_vv_i, gen_helper_vsrlni_b_h)
+TRANS(vsrlni_h_w, ALL, gen_vv_i, gen_helper_vsrlni_h_w)
+TRANS(vsrlni_w_d, ALL, gen_vv_i, gen_helper_vsrlni_w_d)
+TRANS(vsrlni_d_q, ALL, gen_vv_i, gen_helper_vsrlni_d_q)
+TRANS(vsrani_b_h, ALL, gen_vv_i, gen_helper_vsrani_b_h)
+TRANS(vsrani_h_w, ALL, gen_vv_i, gen_helper_vsrani_h_w)
+TRANS(vsrani_w_d, ALL, gen_vv_i, gen_helper_vsrani_w_d)
+TRANS(vsrani_d_q, ALL, gen_vv_i, gen_helper_vsrani_d_q)
+
+TRANS(vsrlrn_b_h, ALL, gen_vvv, gen_helper_vsrlrn_b_h)
+TRANS(vsrlrn_h_w, ALL, gen_vvv, gen_helper_vsrlrn_h_w)
+TRANS(vsrlrn_w_d, ALL, gen_vvv, gen_helper_vsrlrn_w_d)
+TRANS(vsrarn_b_h, ALL, gen_vvv, gen_helper_vsrarn_b_h)
+TRANS(vsrarn_h_w, ALL, gen_vvv, gen_helper_vsrarn_h_w)
+TRANS(vsrarn_w_d, ALL, gen_vvv, gen_helper_vsrarn_w_d)
+
+TRANS(vsrlrni_b_h, ALL, gen_vv_i, gen_helper_vsrlrni_b_h)
+TRANS(vsrlrni_h_w, ALL, gen_vv_i, gen_helper_vsrlrni_h_w)
+TRANS(vsrlrni_w_d, ALL, gen_vv_i, gen_helper_vsrlrni_w_d)
+TRANS(vsrlrni_d_q, ALL, gen_vv_i, gen_helper_vsrlrni_d_q)
+TRANS(vsrarni_b_h, ALL, gen_vv_i, gen_helper_vsrarni_b_h)
+TRANS(vsrarni_h_w, ALL, gen_vv_i, gen_helper_vsrarni_h_w)
+TRANS(vsrarni_w_d, ALL, gen_vv_i, gen_helper_vsrarni_w_d)
+TRANS(vsrarni_d_q, ALL, gen_vv_i, gen_helper_vsrarni_d_q)
+
+TRANS(vssrln_b_h, ALL, gen_vvv, gen_helper_vssrln_b_h)
+TRANS(vssrln_h_w, ALL, gen_vvv, gen_helper_vssrln_h_w)
+TRANS(vssrln_w_d, ALL, gen_vvv, gen_helper_vssrln_w_d)
+TRANS(vssran_b_h, ALL, gen_vvv, gen_helper_vssran_b_h)
+TRANS(vssran_h_w, ALL, gen_vvv, gen_helper_vssran_h_w)
+TRANS(vssran_w_d, ALL, gen_vvv, gen_helper_vssran_w_d)
+TRANS(vssrln_bu_h, ALL, gen_vvv, gen_helper_vssrln_bu_h)
+TRANS(vssrln_hu_w, ALL, gen_vvv, gen_helper_vssrln_hu_w)
+TRANS(vssrln_wu_d, ALL, gen_vvv, gen_helper_vssrln_wu_d)
+TRANS(vssran_bu_h, ALL, gen_vvv, gen_helper_vssran_bu_h)
+TRANS(vssran_hu_w, ALL, gen_vvv, gen_helper_vssran_hu_w)
+TRANS(vssran_wu_d, ALL, gen_vvv, gen_helper_vssran_wu_d)
+
+TRANS(vssrlni_b_h, ALL, gen_vv_i, gen_helper_vssrlni_b_h)
+TRANS(vssrlni_h_w, ALL, gen_vv_i, gen_helper_vssrlni_h_w)
+TRANS(vssrlni_w_d, ALL, gen_vv_i, gen_helper_vssrlni_w_d)
+TRANS(vssrlni_d_q, ALL, gen_vv_i, gen_helper_vssrlni_d_q)
+TRANS(vssrani_b_h, ALL, gen_vv_i, gen_helper_vssrani_b_h)
+TRANS(vssrani_h_w, ALL, gen_vv_i, gen_helper_vssrani_h_w)
+TRANS(vssrani_w_d, ALL, gen_vv_i, gen_helper_vssrani_w_d)
+TRANS(vssrani_d_q, ALL, gen_vv_i, gen_helper_vssrani_d_q)
+TRANS(vssrlni_bu_h, ALL, gen_vv_i, gen_helper_vssrlni_bu_h)
+TRANS(vssrlni_hu_w, ALL, gen_vv_i, gen_helper_vssrlni_hu_w)
+TRANS(vssrlni_wu_d, ALL, gen_vv_i, gen_helper_vssrlni_wu_d)
+TRANS(vssrlni_du_q, ALL, gen_vv_i, gen_helper_vssrlni_du_q)
+TRANS(vssrani_bu_h, ALL, gen_vv_i, gen_helper_vssrani_bu_h)
+TRANS(vssrani_hu_w, ALL, gen_vv_i, gen_helper_vssrani_hu_w)
+TRANS(vssrani_wu_d, ALL, gen_vv_i, gen_helper_vssrani_wu_d)
+TRANS(vssrani_du_q, ALL, gen_vv_i, gen_helper_vssrani_du_q)
+
+TRANS(vssrlrn_b_h, ALL, gen_vvv, gen_helper_vssrlrn_b_h)
+TRANS(vssrlrn_h_w, ALL, gen_vvv, gen_helper_vssrlrn_h_w)
+TRANS(vssrlrn_w_d, ALL, gen_vvv, gen_helper_vssrlrn_w_d)
+TRANS(vssrarn_b_h, ALL, gen_vvv, gen_helper_vssrarn_b_h)
+TRANS(vssrarn_h_w, ALL, gen_vvv, gen_helper_vssrarn_h_w)
+TRANS(vssrarn_w_d, ALL, gen_vvv, gen_helper_vssrarn_w_d)
+TRANS(vssrlrn_bu_h, ALL, gen_vvv, gen_helper_vssrlrn_bu_h)
+TRANS(vssrlrn_hu_w, ALL, gen_vvv, gen_helper_vssrlrn_hu_w)
+TRANS(vssrlrn_wu_d, ALL, gen_vvv, gen_helper_vssrlrn_wu_d)
+TRANS(vssrarn_bu_h, ALL, gen_vvv, gen_helper_vssrarn_bu_h)
+TRANS(vssrarn_hu_w, ALL, gen_vvv, gen_helper_vssrarn_hu_w)
+TRANS(vssrarn_wu_d, ALL, gen_vvv, gen_helper_vssrarn_wu_d)
+
+TRANS(vssrlrni_b_h, ALL, gen_vv_i, gen_helper_vssrlrni_b_h)
+TRANS(vssrlrni_h_w, ALL, gen_vv_i, gen_helper_vssrlrni_h_w)
+TRANS(vssrlrni_w_d, ALL, gen_vv_i, gen_helper_vssrlrni_w_d)
+TRANS(vssrlrni_d_q, ALL, gen_vv_i, gen_helper_vssrlrni_d_q)
+TRANS(vssrarni_b_h, ALL, gen_vv_i, gen_helper_vssrarni_b_h)
+TRANS(vssrarni_h_w, ALL, gen_vv_i, gen_helper_vssrarni_h_w)
+TRANS(vssrarni_w_d, ALL, gen_vv_i, gen_helper_vssrarni_w_d)
+TRANS(vssrarni_d_q, ALL, gen_vv_i, gen_helper_vssrarni_d_q)
+TRANS(vssrlrni_bu_h, ALL, gen_vv_i, gen_helper_vssrlrni_bu_h)
+TRANS(vssrlrni_hu_w, ALL, gen_vv_i, gen_helper_vssrlrni_hu_w)
+TRANS(vssrlrni_wu_d, ALL, gen_vv_i, gen_helper_vssrlrni_wu_d)
+TRANS(vssrlrni_du_q, ALL, gen_vv_i, gen_helper_vssrlrni_du_q)
+TRANS(vssrarni_bu_h, ALL, gen_vv_i, gen_helper_vssrarni_bu_h)
+TRANS(vssrarni_hu_w, ALL, gen_vv_i, gen_helper_vssrarni_hu_w)
+TRANS(vssrarni_wu_d, ALL, gen_vv_i, gen_helper_vssrarni_wu_d)
+TRANS(vssrarni_du_q, ALL, gen_vv_i, gen_helper_vssrarni_du_q)
+
+TRANS(vclo_b, ALL, gen_vv, gen_helper_vclo_b)
+TRANS(vclo_h, ALL, gen_vv, gen_helper_vclo_h)
+TRANS(vclo_w, ALL, gen_vv, gen_helper_vclo_w)
+TRANS(vclo_d, ALL, gen_vv, gen_helper_vclo_d)
+TRANS(vclz_b, ALL, gen_vv, gen_helper_vclz_b)
+TRANS(vclz_h, ALL, gen_vv, gen_helper_vclz_h)
+TRANS(vclz_w, ALL, gen_vv, gen_helper_vclz_w)
+TRANS(vclz_d, ALL, gen_vv, gen_helper_vclz_d)
+
+TRANS(vpcnt_b, ALL, gen_vv, gen_helper_vpcnt_b)
+TRANS(vpcnt_h, ALL, gen_vv, gen_helper_vpcnt_h)
+TRANS(vpcnt_w, ALL, gen_vv, gen_helper_vpcnt_w)
+TRANS(vpcnt_d, ALL, gen_vv, gen_helper_vpcnt_d)
 
 static void do_vbit(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3340,10 +3340,10 @@ static void do_vbitclr(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitclr_b, gvec_vvv, MO_8, do_vbitclr)
-TRANS(vbitclr_h, gvec_vvv, MO_16, do_vbitclr)
-TRANS(vbitclr_w, gvec_vvv, MO_32, do_vbitclr)
-TRANS(vbitclr_d, gvec_vvv, MO_64, do_vbitclr)
+TRANS(vbitclr_b, ALL, gvec_vvv, MO_8, do_vbitclr)
+TRANS(vbitclr_h, ALL, gvec_vvv, MO_16, do_vbitclr)
+TRANS(vbitclr_w, ALL, gvec_vvv, MO_32, do_vbitclr)
+TRANS(vbitclr_d, ALL, gvec_vvv, MO_64, do_vbitclr)
 
 static void do_vbiti(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm,
                      void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3410,10 +3410,10 @@ static void do_vbitclri(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitclri_b, gvec_vv_i, MO_8, do_vbitclri)
-TRANS(vbitclri_h, gvec_vv_i, MO_16, do_vbitclri)
-TRANS(vbitclri_w, gvec_vv_i, MO_32, do_vbitclri)
-TRANS(vbitclri_d, gvec_vv_i, MO_64, do_vbitclri)
+TRANS(vbitclri_b, ALL, gvec_vv_i, MO_8, do_vbitclri)
+TRANS(vbitclri_h, ALL, gvec_vv_i, MO_16, do_vbitclri)
+TRANS(vbitclri_w, ALL, gvec_vv_i, MO_32, do_vbitclri)
+TRANS(vbitclri_d, ALL, gvec_vv_i, MO_64, do_vbitclri)
 
 static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3451,10 +3451,10 @@ static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitset_b, gvec_vvv, MO_8, do_vbitset)
-TRANS(vbitset_h, gvec_vvv, MO_16, do_vbitset)
-TRANS(vbitset_w, gvec_vvv, MO_32, do_vbitset)
-TRANS(vbitset_d, gvec_vvv, MO_64, do_vbitset)
+TRANS(vbitset_b, ALL, gvec_vvv, MO_8, do_vbitset)
+TRANS(vbitset_h, ALL, gvec_vvv, MO_16, do_vbitset)
+TRANS(vbitset_w, ALL, gvec_vvv, MO_32, do_vbitset)
+TRANS(vbitset_d, ALL, gvec_vvv, MO_64, do_vbitset)
 
 static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3492,10 +3492,10 @@ static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitseti_b, gvec_vv_i, MO_8, do_vbitseti)
-TRANS(vbitseti_h, gvec_vv_i, MO_16, do_vbitseti)
-TRANS(vbitseti_w, gvec_vv_i, MO_32, do_vbitseti)
-TRANS(vbitseti_d, gvec_vv_i, MO_64, do_vbitseti)
+TRANS(vbitseti_b, ALL, gvec_vv_i, MO_8, do_vbitseti)
+TRANS(vbitseti_h, ALL, gvec_vv_i, MO_16, do_vbitseti)
+TRANS(vbitseti_w, ALL, gvec_vv_i, MO_32, do_vbitseti)
+TRANS(vbitseti_d, ALL, gvec_vv_i, MO_64, do_vbitseti)
 
 static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3533,10 +3533,10 @@ static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitrev_b, gvec_vvv, MO_8, do_vbitrev)
-TRANS(vbitrev_h, gvec_vvv, MO_16, do_vbitrev)
-TRANS(vbitrev_w, gvec_vvv, MO_32, do_vbitrev)
-TRANS(vbitrev_d, gvec_vvv, MO_64, do_vbitrev)
+TRANS(vbitrev_b, ALL, gvec_vvv, MO_8, do_vbitrev)
+TRANS(vbitrev_h, ALL, gvec_vvv, MO_16, do_vbitrev)
+TRANS(vbitrev_w, ALL, gvec_vvv, MO_32, do_vbitrev)
+TRANS(vbitrev_d, ALL, gvec_vvv, MO_64, do_vbitrev)
 
 static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3574,112 +3574,112 @@ static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitrevi_b, gvec_vv_i, MO_8, do_vbitrevi)
-TRANS(vbitrevi_h, gvec_vv_i, MO_16, do_vbitrevi)
-TRANS(vbitrevi_w, gvec_vv_i, MO_32, do_vbitrevi)
-TRANS(vbitrevi_d, gvec_vv_i, MO_64, do_vbitrevi)
-
-TRANS(vfrstp_b, gen_vvv, gen_helper_vfrstp_b)
-TRANS(vfrstp_h, gen_vvv, gen_helper_vfrstp_h)
-TRANS(vfrstpi_b, gen_vv_i, gen_helper_vfrstpi_b)
-TRANS(vfrstpi_h, gen_vv_i, gen_helper_vfrstpi_h)
-
-TRANS(vfadd_s, gen_vvv, gen_helper_vfadd_s)
-TRANS(vfadd_d, gen_vvv, gen_helper_vfadd_d)
-TRANS(vfsub_s, gen_vvv, gen_helper_vfsub_s)
-TRANS(vfsub_d, gen_vvv, gen_helper_vfsub_d)
-TRANS(vfmul_s, gen_vvv, gen_helper_vfmul_s)
-TRANS(vfmul_d, gen_vvv, gen_helper_vfmul_d)
-TRANS(vfdiv_s, gen_vvv, gen_helper_vfdiv_s)
-TRANS(vfdiv_d, gen_vvv, gen_helper_vfdiv_d)
-
-TRANS(vfmadd_s, gen_vvvv, gen_helper_vfmadd_s)
-TRANS(vfmadd_d, gen_vvvv, gen_helper_vfmadd_d)
-TRANS(vfmsub_s, gen_vvvv, gen_helper_vfmsub_s)
-TRANS(vfmsub_d, gen_vvvv, gen_helper_vfmsub_d)
-TRANS(vfnmadd_s, gen_vvvv, gen_helper_vfnmadd_s)
-TRANS(vfnmadd_d, gen_vvvv, gen_helper_vfnmadd_d)
-TRANS(vfnmsub_s, gen_vvvv, gen_helper_vfnmsub_s)
-TRANS(vfnmsub_d, gen_vvvv, gen_helper_vfnmsub_d)
-
-TRANS(vfmax_s, gen_vvv, gen_helper_vfmax_s)
-TRANS(vfmax_d, gen_vvv, gen_helper_vfmax_d)
-TRANS(vfmin_s, gen_vvv, gen_helper_vfmin_s)
-TRANS(vfmin_d, gen_vvv, gen_helper_vfmin_d)
-
-TRANS(vfmaxa_s, gen_vvv, gen_helper_vfmaxa_s)
-TRANS(vfmaxa_d, gen_vvv, gen_helper_vfmaxa_d)
-TRANS(vfmina_s, gen_vvv, gen_helper_vfmina_s)
-TRANS(vfmina_d, gen_vvv, gen_helper_vfmina_d)
-
-TRANS(vflogb_s, gen_vv, gen_helper_vflogb_s)
-TRANS(vflogb_d, gen_vv, gen_helper_vflogb_d)
-
-TRANS(vfclass_s, gen_vv, gen_helper_vfclass_s)
-TRANS(vfclass_d, gen_vv, gen_helper_vfclass_d)
-
-TRANS(vfsqrt_s, gen_vv, gen_helper_vfsqrt_s)
-TRANS(vfsqrt_d, gen_vv, gen_helper_vfsqrt_d)
-TRANS(vfrecip_s, gen_vv, gen_helper_vfrecip_s)
-TRANS(vfrecip_d, gen_vv, gen_helper_vfrecip_d)
-TRANS(vfrsqrt_s, gen_vv, gen_helper_vfrsqrt_s)
-TRANS(vfrsqrt_d, gen_vv, gen_helper_vfrsqrt_d)
-
-TRANS(vfcvtl_s_h, gen_vv, gen_helper_vfcvtl_s_h)
-TRANS(vfcvth_s_h, gen_vv, gen_helper_vfcvth_s_h)
-TRANS(vfcvtl_d_s, gen_vv, gen_helper_vfcvtl_d_s)
-TRANS(vfcvth_d_s, gen_vv, gen_helper_vfcvth_d_s)
-TRANS(vfcvt_h_s, gen_vvv, gen_helper_vfcvt_h_s)
-TRANS(vfcvt_s_d, gen_vvv, gen_helper_vfcvt_s_d)
-
-TRANS(vfrintrne_s, gen_vv, gen_helper_vfrintrne_s)
-TRANS(vfrintrne_d, gen_vv, gen_helper_vfrintrne_d)
-TRANS(vfrintrz_s, gen_vv, gen_helper_vfrintrz_s)
-TRANS(vfrintrz_d, gen_vv, gen_helper_vfrintrz_d)
-TRANS(vfrintrp_s, gen_vv, gen_helper_vfrintrp_s)
-TRANS(vfrintrp_d, gen_vv, gen_helper_vfrintrp_d)
-TRANS(vfrintrm_s, gen_vv, gen_helper_vfrintrm_s)
-TRANS(vfrintrm_d, gen_vv, gen_helper_vfrintrm_d)
-TRANS(vfrint_s, gen_vv, gen_helper_vfrint_s)
-TRANS(vfrint_d, gen_vv, gen_helper_vfrint_d)
-
-TRANS(vftintrne_w_s, gen_vv, gen_helper_vftintrne_w_s)
-TRANS(vftintrne_l_d, gen_vv, gen_helper_vftintrne_l_d)
-TRANS(vftintrz_w_s, gen_vv, gen_helper_vftintrz_w_s)
-TRANS(vftintrz_l_d, gen_vv, gen_helper_vftintrz_l_d)
-TRANS(vftintrp_w_s, gen_vv, gen_helper_vftintrp_w_s)
-TRANS(vftintrp_l_d, gen_vv, gen_helper_vftintrp_l_d)
-TRANS(vftintrm_w_s, gen_vv, gen_helper_vftintrm_w_s)
-TRANS(vftintrm_l_d, gen_vv, gen_helper_vftintrm_l_d)
-TRANS(vftint_w_s, gen_vv, gen_helper_vftint_w_s)
-TRANS(vftint_l_d, gen_vv, gen_helper_vftint_l_d)
-TRANS(vftintrz_wu_s, gen_vv, gen_helper_vftintrz_wu_s)
-TRANS(vftintrz_lu_d, gen_vv, gen_helper_vftintrz_lu_d)
-TRANS(vftint_wu_s, gen_vv, gen_helper_vftint_wu_s)
-TRANS(vftint_lu_d, gen_vv, gen_helper_vftint_lu_d)
-TRANS(vftintrne_w_d, gen_vvv, gen_helper_vftintrne_w_d)
-TRANS(vftintrz_w_d, gen_vvv, gen_helper_vftintrz_w_d)
-TRANS(vftintrp_w_d, gen_vvv, gen_helper_vftintrp_w_d)
-TRANS(vftintrm_w_d, gen_vvv, gen_helper_vftintrm_w_d)
-TRANS(vftint_w_d, gen_vvv, gen_helper_vftint_w_d)
-TRANS(vftintrnel_l_s, gen_vv, gen_helper_vftintrnel_l_s)
-TRANS(vftintrneh_l_s, gen_vv, gen_helper_vftintrneh_l_s)
-TRANS(vftintrzl_l_s, gen_vv, gen_helper_vftintrzl_l_s)
-TRANS(vftintrzh_l_s, gen_vv, gen_helper_vftintrzh_l_s)
-TRANS(vftintrpl_l_s, gen_vv, gen_helper_vftintrpl_l_s)
-TRANS(vftintrph_l_s, gen_vv, gen_helper_vftintrph_l_s)
-TRANS(vftintrml_l_s, gen_vv, gen_helper_vftintrml_l_s)
-TRANS(vftintrmh_l_s, gen_vv, gen_helper_vftintrmh_l_s)
-TRANS(vftintl_l_s, gen_vv, gen_helper_vftintl_l_s)
-TRANS(vftinth_l_s, gen_vv, gen_helper_vftinth_l_s)
-
-TRANS(vffint_s_w, gen_vv, gen_helper_vffint_s_w)
-TRANS(vffint_d_l, gen_vv, gen_helper_vffint_d_l)
-TRANS(vffint_s_wu, gen_vv, gen_helper_vffint_s_wu)
-TRANS(vffint_d_lu, gen_vv, gen_helper_vffint_d_lu)
-TRANS(vffintl_d_w, gen_vv, gen_helper_vffintl_d_w)
-TRANS(vffinth_d_w, gen_vv, gen_helper_vffinth_d_w)
-TRANS(vffint_s_l, gen_vvv, gen_helper_vffint_s_l)
+TRANS(vbitrevi_b, ALL, gvec_vv_i, MO_8, do_vbitrevi)
+TRANS(vbitrevi_h, ALL, gvec_vv_i, MO_16, do_vbitrevi)
+TRANS(vbitrevi_w, ALL, gvec_vv_i, MO_32, do_vbitrevi)
+TRANS(vbitrevi_d, ALL, gvec_vv_i, MO_64, do_vbitrevi)
+
+TRANS(vfrstp_b, ALL, gen_vvv, gen_helper_vfrstp_b)
+TRANS(vfrstp_h, ALL, gen_vvv, gen_helper_vfrstp_h)
+TRANS(vfrstpi_b, ALL, gen_vv_i, gen_helper_vfrstpi_b)
+TRANS(vfrstpi_h, ALL, gen_vv_i, gen_helper_vfrstpi_h)
+
+TRANS(vfadd_s, ALL, gen_vvv, gen_helper_vfadd_s)
+TRANS(vfadd_d, ALL, gen_vvv, gen_helper_vfadd_d)
+TRANS(vfsub_s, ALL, gen_vvv, gen_helper_vfsub_s)
+TRANS(vfsub_d, ALL, gen_vvv, gen_helper_vfsub_d)
+TRANS(vfmul_s, ALL, gen_vvv, gen_helper_vfmul_s)
+TRANS(vfmul_d, ALL, gen_vvv, gen_helper_vfmul_d)
+TRANS(vfdiv_s, ALL, gen_vvv, gen_helper_vfdiv_s)
+TRANS(vfdiv_d, ALL, gen_vvv, gen_helper_vfdiv_d)
+
+TRANS(vfmadd_s, ALL, gen_vvvv, gen_helper_vfmadd_s)
+TRANS(vfmadd_d, ALL, gen_vvvv, gen_helper_vfmadd_d)
+TRANS(vfmsub_s, ALL, gen_vvvv, gen_helper_vfmsub_s)
+TRANS(vfmsub_d, ALL, gen_vvvv, gen_helper_vfmsub_d)
+TRANS(vfnmadd_s, ALL, gen_vvvv, gen_helper_vfnmadd_s)
+TRANS(vfnmadd_d, ALL, gen_vvvv, gen_helper_vfnmadd_d)
+TRANS(vfnmsub_s, ALL, gen_vvvv, gen_helper_vfnmsub_s)
+TRANS(vfnmsub_d, ALL, gen_vvvv, gen_helper_vfnmsub_d)
+
+TRANS(vfmax_s, ALL, gen_vvv, gen_helper_vfmax_s)
+TRANS(vfmax_d, ALL, gen_vvv, gen_helper_vfmax_d)
+TRANS(vfmin_s, ALL, gen_vvv, gen_helper_vfmin_s)
+TRANS(vfmin_d, ALL, gen_vvv, gen_helper_vfmin_d)
+
+TRANS(vfmaxa_s, ALL, gen_vvv, gen_helper_vfmaxa_s)
+TRANS(vfmaxa_d, ALL, gen_vvv, gen_helper_vfmaxa_d)
+TRANS(vfmina_s, ALL, gen_vvv, gen_helper_vfmina_s)
+TRANS(vfmina_d, ALL, gen_vvv, gen_helper_vfmina_d)
+
+TRANS(vflogb_s, ALL, gen_vv, gen_helper_vflogb_s)
+TRANS(vflogb_d, ALL, gen_vv, gen_helper_vflogb_d)
+
+TRANS(vfclass_s, ALL, gen_vv, gen_helper_vfclass_s)
+TRANS(vfclass_d, ALL, gen_vv, gen_helper_vfclass_d)
+
+TRANS(vfsqrt_s, ALL, gen_vv, gen_helper_vfsqrt_s)
+TRANS(vfsqrt_d, ALL, gen_vv, gen_helper_vfsqrt_d)
+TRANS(vfrecip_s, ALL, gen_vv, gen_helper_vfrecip_s)
+TRANS(vfrecip_d, ALL, gen_vv, gen_helper_vfrecip_d)
+TRANS(vfrsqrt_s, ALL, gen_vv, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrt_d, ALL, gen_vv, gen_helper_vfrsqrt_d)
+
+TRANS(vfcvtl_s_h, ALL, gen_vv, gen_helper_vfcvtl_s_h)
+TRANS(vfcvth_s_h, ALL, gen_vv, gen_helper_vfcvth_s_h)
+TRANS(vfcvtl_d_s, ALL, gen_vv, gen_helper_vfcvtl_d_s)
+TRANS(vfcvth_d_s, ALL, gen_vv, gen_helper_vfcvth_d_s)
+TRANS(vfcvt_h_s, ALL, gen_vvv, gen_helper_vfcvt_h_s)
+TRANS(vfcvt_s_d, ALL, gen_vvv, gen_helper_vfcvt_s_d)
+
+TRANS(vfrintrne_s, ALL, gen_vv, gen_helper_vfrintrne_s)
+TRANS(vfrintrne_d, ALL, gen_vv, gen_helper_vfrintrne_d)
+TRANS(vfrintrz_s, ALL, gen_vv, gen_helper_vfrintrz_s)
+TRANS(vfrintrz_d, ALL, gen_vv, gen_helper_vfrintrz_d)
+TRANS(vfrintrp_s, ALL, gen_vv, gen_helper_vfrintrp_s)
+TRANS(vfrintrp_d, ALL, gen_vv, gen_helper_vfrintrp_d)
+TRANS(vfrintrm_s, ALL, gen_vv, gen_helper_vfrintrm_s)
+TRANS(vfrintrm_d, ALL, gen_vv, gen_helper_vfrintrm_d)
+TRANS(vfrint_s, ALL, gen_vv, gen_helper_vfrint_s)
+TRANS(vfrint_d, ALL, gen_vv, gen_helper_vfrint_d)
+
+TRANS(vftintrne_w_s, ALL, gen_vv, gen_helper_vftintrne_w_s)
+TRANS(vftintrne_l_d, ALL, gen_vv, gen_helper_vftintrne_l_d)
+TRANS(vftintrz_w_s, ALL, gen_vv, gen_helper_vftintrz_w_s)
+TRANS(vftintrz_l_d, ALL, gen_vv, gen_helper_vftintrz_l_d)
+TRANS(vftintrp_w_s, ALL, gen_vv, gen_helper_vftintrp_w_s)
+TRANS(vftintrp_l_d, ALL, gen_vv, gen_helper_vftintrp_l_d)
+TRANS(vftintrm_w_s, ALL, gen_vv, gen_helper_vftintrm_w_s)
+TRANS(vftintrm_l_d, ALL, gen_vv, gen_helper_vftintrm_l_d)
+TRANS(vftint_w_s, ALL, gen_vv, gen_helper_vftint_w_s)
+TRANS(vftint_l_d, ALL, gen_vv, gen_helper_vftint_l_d)
+TRANS(vftintrz_wu_s, ALL, gen_vv, gen_helper_vftintrz_wu_s)
+TRANS(vftintrz_lu_d, ALL, gen_vv, gen_helper_vftintrz_lu_d)
+TRANS(vftint_wu_s, ALL, gen_vv, gen_helper_vftint_wu_s)
+TRANS(vftint_lu_d, ALL, gen_vv, gen_helper_vftint_lu_d)
+TRANS(vftintrne_w_d, ALL, gen_vvv, gen_helper_vftintrne_w_d)
+TRANS(vftintrz_w_d, ALL, gen_vvv, gen_helper_vftintrz_w_d)
+TRANS(vftintrp_w_d, ALL, gen_vvv, gen_helper_vftintrp_w_d)
+TRANS(vftintrm_w_d, ALL, gen_vvv, gen_helper_vftintrm_w_d)
+TRANS(vftint_w_d, ALL, gen_vvv, gen_helper_vftint_w_d)
+TRANS(vftintrnel_l_s, ALL, gen_vv, gen_helper_vftintrnel_l_s)
+TRANS(vftintrneh_l_s, ALL, gen_vv, gen_helper_vftintrneh_l_s)
+TRANS(vftintrzl_l_s, ALL, gen_vv, gen_helper_vftintrzl_l_s)
+TRANS(vftintrzh_l_s, ALL, gen_vv, gen_helper_vftintrzh_l_s)
+TRANS(vftintrpl_l_s, ALL, gen_vv, gen_helper_vftintrpl_l_s)
+TRANS(vftintrph_l_s, ALL, gen_vv, gen_helper_vftintrph_l_s)
+TRANS(vftintrml_l_s, ALL, gen_vv, gen_helper_vftintrml_l_s)
+TRANS(vftintrmh_l_s, ALL, gen_vv, gen_helper_vftintrmh_l_s)
+TRANS(vftintl_l_s, ALL, gen_vv, gen_helper_vftintl_l_s)
+TRANS(vftinth_l_s, ALL, gen_vv, gen_helper_vftinth_l_s)
+
+TRANS(vffint_s_w, ALL, gen_vv, gen_helper_vffint_s_w)
+TRANS(vffint_d_l, ALL, gen_vv, gen_helper_vffint_d_l)
+TRANS(vffint_s_wu, ALL, gen_vv, gen_helper_vffint_s_wu)
+TRANS(vffint_d_lu, ALL, gen_vv, gen_helper_vffint_d_lu)
+TRANS(vffintl_d_w, ALL, gen_vv, gen_helper_vffintl_d_w)
+TRANS(vffinth_d_w, ALL, gen_vv, gen_helper_vffinth_d_w)
+TRANS(vffint_s_l, ALL, gen_vvv, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
@@ -3823,48 +3823,48 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 DO_CMPI_U(vslei)
 DO_CMPI_U(vslti)
 
-TRANS(vseq_b, do_cmp, MO_8, TCG_COND_EQ)
-TRANS(vseq_h, do_cmp, MO_16, TCG_COND_EQ)
-TRANS(vseq_w, do_cmp, MO_32, TCG_COND_EQ)
-TRANS(vseq_d, do_cmp, MO_64, TCG_COND_EQ)
-TRANS(vseqi_b, do_vseqi_s, MO_8)
-TRANS(vseqi_h, do_vseqi_s, MO_16)
-TRANS(vseqi_w, do_vseqi_s, MO_32)
-TRANS(vseqi_d, do_vseqi_s, MO_64)
-
-TRANS(vsle_b, do_cmp, MO_8, TCG_COND_LE)
-TRANS(vsle_h, do_cmp, MO_16, TCG_COND_LE)
-TRANS(vsle_w, do_cmp, MO_32, TCG_COND_LE)
-TRANS(vsle_d, do_cmp, MO_64, TCG_COND_LE)
-TRANS(vslei_b, do_vslei_s, MO_8)
-TRANS(vslei_h, do_vslei_s, MO_16)
-TRANS(vslei_w, do_vslei_s, MO_32)
-TRANS(vslei_d, do_vslei_s, MO_64)
-TRANS(vsle_bu, do_cmp, MO_8, TCG_COND_LEU)
-TRANS(vsle_hu, do_cmp, MO_16, TCG_COND_LEU)
-TRANS(vsle_wu, do_cmp, MO_32, TCG_COND_LEU)
-TRANS(vsle_du, do_cmp, MO_64, TCG_COND_LEU)
-TRANS(vslei_bu, do_vslei_u, MO_8)
-TRANS(vslei_hu, do_vslei_u, MO_16)
-TRANS(vslei_wu, do_vslei_u, MO_32)
-TRANS(vslei_du, do_vslei_u, MO_64)
-
-TRANS(vslt_b, do_cmp, MO_8, TCG_COND_LT)
-TRANS(vslt_h, do_cmp, MO_16, TCG_COND_LT)
-TRANS(vslt_w, do_cmp, MO_32, TCG_COND_LT)
-TRANS(vslt_d, do_cmp, MO_64, TCG_COND_LT)
-TRANS(vslti_b, do_vslti_s, MO_8)
-TRANS(vslti_h, do_vslti_s, MO_16)
-TRANS(vslti_w, do_vslti_s, MO_32)
-TRANS(vslti_d, do_vslti_s, MO_64)
-TRANS(vslt_bu, do_cmp, MO_8, TCG_COND_LTU)
-TRANS(vslt_hu, do_cmp, MO_16, TCG_COND_LTU)
-TRANS(vslt_wu, do_cmp, MO_32, TCG_COND_LTU)
-TRANS(vslt_du, do_cmp, MO_64, TCG_COND_LTU)
-TRANS(vslti_bu, do_vslti_u, MO_8)
-TRANS(vslti_hu, do_vslti_u, MO_16)
-TRANS(vslti_wu, do_vslti_u, MO_32)
-TRANS(vslti_du, do_vslti_u, MO_64)
+TRANS(vseq_b, ALL, do_cmp, MO_8, TCG_COND_EQ)
+TRANS(vseq_h, ALL, do_cmp, MO_16, TCG_COND_EQ)
+TRANS(vseq_w, ALL, do_cmp, MO_32, TCG_COND_EQ)
+TRANS(vseq_d, ALL, do_cmp, MO_64, TCG_COND_EQ)
+TRANS(vseqi_b, ALL, do_vseqi_s, MO_8)
+TRANS(vseqi_h, ALL, do_vseqi_s, MO_16)
+TRANS(vseqi_w, ALL, do_vseqi_s, MO_32)
+TRANS(vseqi_d, ALL, do_vseqi_s, MO_64)
+
+TRANS(vsle_b, ALL, do_cmp, MO_8, TCG_COND_LE)
+TRANS(vsle_h, ALL, do_cmp, MO_16, TCG_COND_LE)
+TRANS(vsle_w, ALL, do_cmp, MO_32, TCG_COND_LE)
+TRANS(vsle_d, ALL, do_cmp, MO_64, TCG_COND_LE)
+TRANS(vslei_b, ALL, do_vslei_s, MO_8)
+TRANS(vslei_h, ALL, do_vslei_s, MO_16)
+TRANS(vslei_w, ALL, do_vslei_s, MO_32)
+TRANS(vslei_d, ALL, do_vslei_s, MO_64)
+TRANS(vsle_bu, ALL, do_cmp, MO_8, TCG_COND_LEU)
+TRANS(vsle_hu, ALL, do_cmp, MO_16, TCG_COND_LEU)
+TRANS(vsle_wu, ALL, do_cmp, MO_32, TCG_COND_LEU)
+TRANS(vsle_du, ALL, do_cmp, MO_64, TCG_COND_LEU)
+TRANS(vslei_bu, ALL, do_vslei_u, MO_8)
+TRANS(vslei_hu, ALL, do_vslei_u, MO_16)
+TRANS(vslei_wu, ALL, do_vslei_u, MO_32)
+TRANS(vslei_du, ALL, do_vslei_u, MO_64)
+
+TRANS(vslt_b, ALL, do_cmp, MO_8, TCG_COND_LT)
+TRANS(vslt_h, ALL, do_cmp, MO_16, TCG_COND_LT)
+TRANS(vslt_w, ALL, do_cmp, MO_32, TCG_COND_LT)
+TRANS(vslt_d, ALL, do_cmp, MO_64, TCG_COND_LT)
+TRANS(vslti_b, ALL, do_vslti_s, MO_8)
+TRANS(vslti_h, ALL, do_vslti_s, MO_16)
+TRANS(vslti_w, ALL, do_vslti_s, MO_32)
+TRANS(vslti_d, ALL, do_vslti_s, MO_64)
+TRANS(vslt_bu, ALL, do_cmp, MO_8, TCG_COND_LTU)
+TRANS(vslt_hu, ALL, do_cmp, MO_16, TCG_COND_LTU)
+TRANS(vslt_wu, ALL, do_cmp, MO_32, TCG_COND_LTU)
+TRANS(vslt_du, ALL, do_cmp, MO_64, TCG_COND_LTU)
+TRANS(vslti_bu, ALL, do_vslti_u, MO_8)
+TRANS(vslti_hu, ALL, do_vslti_u, MO_16)
+TRANS(vslti_wu, ALL, do_vslti_u, MO_32)
+TRANS(vslti_du, ALL, do_vslti_u, MO_64)
 
 static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
 {
@@ -3952,14 +3952,14 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
 VSET(vseteqz_v, TCG_COND_EQ)
 VSET(vsetnez_v, TCG_COND_NE)
 
-TRANS(vsetanyeqz_b, gen_cv, gen_helper_vsetanyeqz_b)
-TRANS(vsetanyeqz_h, gen_cv, gen_helper_vsetanyeqz_h)
-TRANS(vsetanyeqz_w, gen_cv, gen_helper_vsetanyeqz_w)
-TRANS(vsetanyeqz_d, gen_cv, gen_helper_vsetanyeqz_d)
-TRANS(vsetallnez_b, gen_cv, gen_helper_vsetallnez_b)
-TRANS(vsetallnez_h, gen_cv, gen_helper_vsetallnez_h)
-TRANS(vsetallnez_w, gen_cv, gen_helper_vsetallnez_w)
-TRANS(vsetallnez_d, gen_cv, gen_helper_vsetallnez_d)
+TRANS(vsetanyeqz_b, ALL, gen_cv, gen_helper_vsetanyeqz_b)
+TRANS(vsetanyeqz_h, ALL, gen_cv, gen_helper_vsetanyeqz_h)
+TRANS(vsetanyeqz_w, ALL, gen_cv, gen_helper_vsetanyeqz_w)
+TRANS(vsetanyeqz_d, ALL, gen_cv, gen_helper_vsetanyeqz_d)
+TRANS(vsetallnez_b, ALL, gen_cv, gen_helper_vsetallnez_b)
+TRANS(vsetallnez_h, ALL, gen_cv, gen_helper_vsetallnez_h)
+TRANS(vsetallnez_w, ALL, gen_cv, gen_helper_vsetallnez_w)
+TRANS(vsetallnez_d, ALL, gen_cv, gen_helper_vsetallnez_d)
 
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
@@ -4079,10 +4079,10 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
     return true;
 }
 
-TRANS(vreplgr2vr_b, gvec_dup, MO_8)
-TRANS(vreplgr2vr_h, gvec_dup, MO_16)
-TRANS(vreplgr2vr_w, gvec_dup, MO_32)
-TRANS(vreplgr2vr_d, gvec_dup, MO_64)
+TRANS(vreplgr2vr_b, ALL, gvec_dup, MO_8)
+TRANS(vreplgr2vr_h, ALL, gvec_dup, MO_16)
+TRANS(vreplgr2vr_w, ALL, gvec_dup, MO_32)
+TRANS(vreplgr2vr_d, ALL, gvec_dup, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
@@ -4145,10 +4145,10 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     return true;
 }
 
-TRANS(vreplve_b, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
-TRANS(vreplve_h, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
-TRANS(vreplve_w, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
-TRANS(vreplve_d, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
+TRANS(vreplve_b, ALL, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
+TRANS(vreplve_h, ALL, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(vreplve_w, ALL, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(vreplve_d, ALL, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
 
 static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
 {
@@ -4210,48 +4210,48 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     return true;
 }
 
-TRANS(vpackev_b, gen_vvv, gen_helper_vpackev_b)
-TRANS(vpackev_h, gen_vvv, gen_helper_vpackev_h)
-TRANS(vpackev_w, gen_vvv, gen_helper_vpackev_w)
-TRANS(vpackev_d, gen_vvv, gen_helper_vpackev_d)
-TRANS(vpackod_b, gen_vvv, gen_helper_vpackod_b)
-TRANS(vpackod_h, gen_vvv, gen_helper_vpackod_h)
-TRANS(vpackod_w, gen_vvv, gen_helper_vpackod_w)
-TRANS(vpackod_d, gen_vvv, gen_helper_vpackod_d)
-
-TRANS(vpickev_b, gen_vvv, gen_helper_vpickev_b)
-TRANS(vpickev_h, gen_vvv, gen_helper_vpickev_h)
-TRANS(vpickev_w, gen_vvv, gen_helper_vpickev_w)
-TRANS(vpickev_d, gen_vvv, gen_helper_vpickev_d)
-TRANS(vpickod_b, gen_vvv, gen_helper_vpickod_b)
-TRANS(vpickod_h, gen_vvv, gen_helper_vpickod_h)
-TRANS(vpickod_w, gen_vvv, gen_helper_vpickod_w)
-TRANS(vpickod_d, gen_vvv, gen_helper_vpickod_d)
-
-TRANS(vilvl_b, gen_vvv, gen_helper_vilvl_b)
-TRANS(vilvl_h, gen_vvv, gen_helper_vilvl_h)
-TRANS(vilvl_w, gen_vvv, gen_helper_vilvl_w)
-TRANS(vilvl_d, gen_vvv, gen_helper_vilvl_d)
-TRANS(vilvh_b, gen_vvv, gen_helper_vilvh_b)
-TRANS(vilvh_h, gen_vvv, gen_helper_vilvh_h)
-TRANS(vilvh_w, gen_vvv, gen_helper_vilvh_w)
-TRANS(vilvh_d, gen_vvv, gen_helper_vilvh_d)
-
-TRANS(vshuf_b, gen_vvvv, gen_helper_vshuf_b)
-TRANS(vshuf_h, gen_vvv, gen_helper_vshuf_h)
-TRANS(vshuf_w, gen_vvv, gen_helper_vshuf_w)
-TRANS(vshuf_d, gen_vvv, gen_helper_vshuf_d)
-TRANS(vshuf4i_b, gen_vv_i, gen_helper_vshuf4i_b)
-TRANS(vshuf4i_h, gen_vv_i, gen_helper_vshuf4i_h)
-TRANS(vshuf4i_w, gen_vv_i, gen_helper_vshuf4i_w)
-TRANS(vshuf4i_d, gen_vv_i, gen_helper_vshuf4i_d)
-
-TRANS(vpermi_w, gen_vv_i, gen_helper_vpermi_w)
-
-TRANS(vextrins_b, gen_vv_i, gen_helper_vextrins_b)
-TRANS(vextrins_h, gen_vv_i, gen_helper_vextrins_h)
-TRANS(vextrins_w, gen_vv_i, gen_helper_vextrins_w)
-TRANS(vextrins_d, gen_vv_i, gen_helper_vextrins_d)
+TRANS(vpackev_b, ALL, gen_vvv, gen_helper_vpackev_b)
+TRANS(vpackev_h, ALL, gen_vvv, gen_helper_vpackev_h)
+TRANS(vpackev_w, ALL, gen_vvv, gen_helper_vpackev_w)
+TRANS(vpackev_d, ALL, gen_vvv, gen_helper_vpackev_d)
+TRANS(vpackod_b, ALL, gen_vvv, gen_helper_vpackod_b)
+TRANS(vpackod_h, ALL, gen_vvv, gen_helper_vpackod_h)
+TRANS(vpackod_w, ALL, gen_vvv, gen_helper_vpackod_w)
+TRANS(vpackod_d, ALL, gen_vvv, gen_helper_vpackod_d)
+
+TRANS(vpickev_b, ALL, gen_vvv, gen_helper_vpickev_b)
+TRANS(vpickev_h, ALL, gen_vvv, gen_helper_vpickev_h)
+TRANS(vpickev_w, ALL, gen_vvv, gen_helper_vpickev_w)
+TRANS(vpickev_d, ALL, gen_vvv, gen_helper_vpickev_d)
+TRANS(vpickod_b, ALL, gen_vvv, gen_helper_vpickod_b)
+TRANS(vpickod_h, ALL, gen_vvv, gen_helper_vpickod_h)
+TRANS(vpickod_w, ALL, gen_vvv, gen_helper_vpickod_w)
+TRANS(vpickod_d, ALL, gen_vvv, gen_helper_vpickod_d)
+
+TRANS(vilvl_b, ALL, gen_vvv, gen_helper_vilvl_b)
+TRANS(vilvl_h, ALL, gen_vvv, gen_helper_vilvl_h)
+TRANS(vilvl_w, ALL, gen_vvv, gen_helper_vilvl_w)
+TRANS(vilvl_d, ALL, gen_vvv, gen_helper_vilvl_d)
+TRANS(vilvh_b, ALL, gen_vvv, gen_helper_vilvh_b)
+TRANS(vilvh_h, ALL, gen_vvv, gen_helper_vilvh_h)
+TRANS(vilvh_w, ALL, gen_vvv, gen_helper_vilvh_w)
+TRANS(vilvh_d, ALL, gen_vvv, gen_helper_vilvh_d)
+
+TRANS(vshuf_b, ALL, gen_vvvv, gen_helper_vshuf_b)
+TRANS(vshuf_h, ALL, gen_vvv, gen_helper_vshuf_h)
+TRANS(vshuf_w, ALL, gen_vvv, gen_helper_vshuf_w)
+TRANS(vshuf_d, ALL, gen_vvv, gen_helper_vshuf_d)
+TRANS(vshuf4i_b, ALL, gen_vv_i, gen_helper_vshuf4i_b)
+TRANS(vshuf4i_h, ALL, gen_vv_i, gen_helper_vshuf4i_h)
+TRANS(vshuf4i_w, ALL, gen_vv_i, gen_helper_vshuf4i_w)
+TRANS(vshuf4i_d, ALL, gen_vv_i, gen_helper_vshuf4i_d)
+
+TRANS(vpermi_w, ALL, gen_vv_i, gen_helper_vpermi_w)
+
+TRANS(vextrins_b, ALL, gen_vv_i, gen_helper_vextrins_b)
+TRANS(vextrins_h, ALL, gen_vv_i, gen_helper_vextrins_h)
+TRANS(vextrins_w, ALL, gen_vv_i, gen_helper_vextrins_w)
+TRANS(vextrins_d, ALL, gen_vv_i, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index 63269e52c9..ad6a4b006d 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -145,45 +145,45 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     return true;
 }
 
-TRANS(ld_b, gen_load, MO_SB)
-TRANS(ld_h, gen_load, MO_TESW)
-TRANS(ld_w, gen_load, MO_TESL)
-TRANS_64(ld_d, gen_load, MO_TEUQ)
-TRANS(st_b, gen_store, MO_UB)
-TRANS(st_h, gen_store, MO_TEUW)
-TRANS(st_w, gen_store, MO_TEUL)
-TRANS_64(st_d, gen_store, MO_TEUQ)
-TRANS(ld_bu, gen_load, MO_UB)
-TRANS(ld_hu, gen_load, MO_TEUW)
-TRANS_64(ld_wu, gen_load, MO_TEUL)
-TRANS_64(ldx_b, gen_loadx, MO_SB)
-TRANS_64(ldx_h, gen_loadx, MO_TESW)
-TRANS_64(ldx_w, gen_loadx, MO_TESL)
-TRANS_64(ldx_d, gen_loadx, MO_TEUQ)
-TRANS_64(stx_b, gen_storex, MO_UB)
-TRANS_64(stx_h, gen_storex, MO_TEUW)
-TRANS_64(stx_w, gen_storex, MO_TEUL)
-TRANS_64(stx_d, gen_storex, MO_TEUQ)
-TRANS_64(ldx_bu, gen_loadx, MO_UB)
-TRANS_64(ldx_hu, gen_loadx, MO_TEUW)
-TRANS_64(ldx_wu, gen_loadx, MO_TEUL)
-TRANS_64(ldptr_w, gen_ldptr, MO_TESL)
-TRANS_64(stptr_w, gen_stptr, MO_TEUL)
-TRANS_64(ldptr_d, gen_ldptr, MO_TEUQ)
-TRANS_64(stptr_d, gen_stptr, MO_TEUQ)
-TRANS_64(ldgt_b, gen_load_gt, MO_SB)
-TRANS_64(ldgt_h, gen_load_gt, MO_TESW)
-TRANS_64(ldgt_w, gen_load_gt, MO_TESL)
-TRANS_64(ldgt_d, gen_load_gt, MO_TEUQ)
-TRANS_64(ldle_b, gen_load_le, MO_SB)
-TRANS_64(ldle_h, gen_load_le, MO_TESW)
-TRANS_64(ldle_w, gen_load_le, MO_TESL)
-TRANS_64(ldle_d, gen_load_le, MO_TEUQ)
-TRANS_64(stgt_b, gen_store_gt, MO_UB)
-TRANS_64(stgt_h, gen_store_gt, MO_TEUW)
-TRANS_64(stgt_w, gen_store_gt, MO_TEUL)
-TRANS_64(stgt_d, gen_store_gt, MO_TEUQ)
-TRANS_64(stle_b, gen_store_le, MO_UB)
-TRANS_64(stle_h, gen_store_le, MO_TEUW)
-TRANS_64(stle_w, gen_store_le, MO_TEUL)
-TRANS_64(stle_d, gen_store_le, MO_TEUQ)
+TRANS(ld_b, ALL, gen_load, MO_SB)
+TRANS(ld_h, ALL, gen_load, MO_TESW)
+TRANS(ld_w, ALL, gen_load, MO_TESL)
+TRANS(ld_d, ALL, gen_load, MO_TEUQ)
+TRANS(st_b, ALL, gen_store, MO_UB)
+TRANS(st_h, ALL, gen_store, MO_TEUW)
+TRANS(st_w, ALL, gen_store, MO_TEUL)
+TRANS(st_d, ALL, gen_store, MO_TEUQ)
+TRANS(ld_bu, ALL, gen_load, MO_UB)
+TRANS(ld_hu, ALL, gen_load, MO_TEUW)
+TRANS(ld_wu, ALL, gen_load, MO_TEUL)
+TRANS(ldx_b, ALL, gen_loadx, MO_SB)
+TRANS(ldx_h, ALL, gen_loadx, MO_TESW)
+TRANS(ldx_w, ALL, gen_loadx, MO_TESL)
+TRANS(ldx_d, ALL, gen_loadx, MO_TEUQ)
+TRANS(stx_b, ALL, gen_storex, MO_UB)
+TRANS(stx_h, ALL, gen_storex, MO_TEUW)
+TRANS(stx_w, ALL, gen_storex, MO_TEUL)
+TRANS(stx_d, ALL, gen_storex, MO_TEUQ)
+TRANS(ldx_bu, ALL, gen_loadx, MO_UB)
+TRANS(ldx_hu, ALL, gen_loadx, MO_TEUW)
+TRANS(ldx_wu, ALL, gen_loadx, MO_TEUL)
+TRANS(ldptr_w, ALL, gen_ldptr, MO_TESL)
+TRANS(stptr_w, ALL, gen_stptr, MO_TEUL)
+TRANS(ldptr_d, ALL, gen_ldptr, MO_TEUQ)
+TRANS(stptr_d, ALL, gen_stptr, MO_TEUQ)
+TRANS(ldgt_b, ALL, gen_load_gt, MO_SB)
+TRANS(ldgt_h, ALL, gen_load_gt, MO_TESW)
+TRANS(ldgt_w, ALL, gen_load_gt, MO_TESL)
+TRANS(ldgt_d, ALL, gen_load_gt, MO_TEUQ)
+TRANS(ldle_b, ALL, gen_load_le, MO_SB)
+TRANS(ldle_h, ALL, gen_load_le, MO_TESW)
+TRANS(ldle_w, ALL, gen_load_le, MO_TESL)
+TRANS(ldle_d, ALL, gen_load_le, MO_TEUQ)
+TRANS(stgt_b, ALL, gen_store_gt, MO_UB)
+TRANS(stgt_h, ALL, gen_store_gt, MO_TEUW)
+TRANS(stgt_w, ALL, gen_store_gt, MO_TEUL)
+TRANS(stgt_d, ALL, gen_store_gt, MO_TEUQ)
+TRANS(stle_b, ALL, gen_store_le, MO_UB)
+TRANS(stle_h, ALL, gen_store_le, MO_TEUW)
+TRANS(stle_w, ALL, gen_store_le, MO_TEUL)
+TRANS(stle_d, ALL, gen_store_le, MO_TEUQ)
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 9c9de090f0..684ff547a7 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -312,14 +312,14 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     return true;
 }
 
-TRANS(iocsrrd_b, gen_iocsrrd, gen_helper_iocsrrd_b)
-TRANS(iocsrrd_h, gen_iocsrrd, gen_helper_iocsrrd_h)
-TRANS(iocsrrd_w, gen_iocsrrd, gen_helper_iocsrrd_w)
-TRANS(iocsrrd_d, gen_iocsrrd, gen_helper_iocsrrd_d)
-TRANS(iocsrwr_b, gen_iocsrwr, gen_helper_iocsrwr_b)
-TRANS(iocsrwr_h, gen_iocsrwr, gen_helper_iocsrwr_h)
-TRANS(iocsrwr_w, gen_iocsrwr, gen_helper_iocsrwr_w)
-TRANS(iocsrwr_d, gen_iocsrwr, gen_helper_iocsrwr_d)
+TRANS(iocsrrd_b, ALL, gen_iocsrrd, gen_helper_iocsrrd_b)
+TRANS(iocsrrd_h, ALL, gen_iocsrrd, gen_helper_iocsrrd_h)
+TRANS(iocsrrd_w, ALL, gen_iocsrrd, gen_helper_iocsrrd_w)
+TRANS(iocsrrd_d, ALL, gen_iocsrrd, gen_helper_iocsrrd_d)
+TRANS(iocsrwr_b, ALL, gen_iocsrwr, gen_helper_iocsrwr_b)
+TRANS(iocsrwr_h, ALL, gen_iocsrwr, gen_helper_iocsrwr_h)
+TRANS(iocsrwr_w, ALL, gen_iocsrwr, gen_helper_iocsrwr_w)
+TRANS(iocsrwr_d, ALL, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
diff --git a/target/loongarch/insn_trans/trans_shift.c.inc b/target/loongarch/insn_trans/trans_shift.c.inc
index 7bbbfe6c8c..849759b94b 100644
--- a/target/loongarch/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/insn_trans/trans_shift.c.inc
@@ -78,18 +78,18 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
     return true;
 }
 
-TRANS(sll_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
-TRANS(srl_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_srl_w)
-TRANS(sra_w, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
-TRANS_64(sll_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
-TRANS_64(srl_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
-TRANS_64(sra_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
-TRANS_64(rotr_d, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
-TRANS(slli_w, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
-TRANS_64(slli_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
-TRANS(srli_w, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
-TRANS(srli_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
-TRANS_64(srai_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
-TRANS_64(rotri_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
+TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
+TRANS(srl_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_srl_w)
+TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
+TRANS(sll_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
+TRANS(srl_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
+TRANS(sra_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
+TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_d, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
+TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
+TRANS(slli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
+TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
+TRANS(srli_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
+TRANS(srai_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
+TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_d, ALL, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index de7c1c5d1f..fd393ed76d 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -127,6 +127,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
 
     ctx->zero = tcg_constant_tl(0);
+
+    ctx->cpucfg1 = env->cpucfg[1];
+    ctx->cpucfg2 = env->cpucfg[2];
 }
 
 static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 6f8ff57923..0fa877975b 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -10,16 +10,11 @@
 
 #include "exec/translator.h"
 
-#define TRANS(NAME, FUNC, ...) \
+#define TRANS(NAME, AVAIL, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
-    { return FUNC(ctx, a, __VA_ARGS__); }
+    { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
 
-/* for LoongArch64-only instructions */
-#define TRANS_64(NAME, FUNC, ...) \
-    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
-    { \
-        return ctx->la64 && FUNC(ctx, a, __VA_ARGS__); \
-    }
+#define avail_ALL(C)   true
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -42,6 +37,8 @@ typedef struct DisasContext {
     TCGv zero;
     bool la64; /* LoongArch64 mode */
     bool va32; /* 32-bit virtual address */
+    uint32_t cpucfg1;
+    uint32_t cpucfg2;
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
-- 
2.39.1


