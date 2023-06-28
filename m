Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B8B74104C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETd6-0002sZ-G6; Wed, 28 Jun 2023 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcJ-0002dq-HK
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETc3-00057S-Gd
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=140iotHyAXb8nQrPtoMETKLOoTmg8PCnWh1NNG0FORE=; b=xiitRSyP0YlShA3iGk/6J0GCff
 jPh89JzBvwa1jDyqfYApl+zXsMogFSYXqH473W72R/fnTs067Xdyx+JOBVs5ZagvmxcHG2D3wdntb
 nnW92AFw1aWHZEZbHlaC0BWen1kBT7Ej/knCId50zydbaH8OO27J4BZf+zsffIHZq6ePOHod/UWTL
 MPvgBvU/NdlWE9iYmYkMjdVqZ4BWBaqSMGW0Mn1O8YeYcs0iCY0HDut8RDoiUc+79mgwB7BWuoS4f
 D9AhYJYFsf+Z1Wkq7EyqMdtKuXURlJEjSjr4JkiMQL4+XG5gFDN4BEVB/Kr46dekSklvEWxByVb5E
 WU9iyeTm4tTgFhNzLjsfXjakUVkXb5L0JbPM1Wyj628OD4YLlODYjRKUuioL3f9QLNzbalDGVm0xF
 4yJ/+yh3nXPBY3VESKe1J41O2M1642oCMd19RR6h8tpN4xLNEgYWdAOVT/OZFO/RpeHWR/NsLu1a6
 iiXp5KD5gbZWqXbQSMQGrlCSZUG8bq0Fm2CCrmUUEz4JQtEkGyyliNC3HBv653JWPeCJM3Qo21/Ws
 AIYIG9pqSa/d+Nhi5/SLq5rcgT68kDQgUKpPt+8S3nd+Edv09r+NF5JRk1JSjzDZjQ+KLTNZ5ZyZS
 Y0Lc1UZ8mwTuR5aRw6SC1hj/FXRPWJw+WBe3V0yuQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbo-00007c-PI; Wed, 28 Jun 2023 12:45:21 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:58 +0100
Message-Id: <20230628114504.546265-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/10] target/sparc: Drop inline markers from translate.c
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Let the compiler decide about inlining.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-4-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 237 ++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 126 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eec6f9ca67..1312c3e94d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -125,7 +125,7 @@ static int sign_extend(int x, int len)
 
 #define IS_IMM (insn & (1<<13))
 
-static inline void gen_update_fprs_dirty(DisasContext *dc, int rd)
+static void gen_update_fprs_dirty(DisasContext *dc, int rd)
 {
 #if defined(TARGET_SPARC64)
     int bit = (rd < 32) ? 1 : 2;
@@ -264,7 +264,7 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 #endif
 #endif
 
-static inline void gen_address_mask(DisasContext *dc, TCGv addr)
+static void gen_address_mask(DisasContext *dc, TCGv addr)
 {
 #ifdef TARGET_SPARC64
     if (AM_CHECK(dc))
@@ -272,7 +272,7 @@ static inline void gen_address_mask(DisasContext *dc, TCGv addr)
 #endif
 }
 
-static inline TCGv gen_load_gpr(DisasContext *dc, int reg)
+static TCGv gen_load_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
         assert(reg < 32);
@@ -284,7 +284,7 @@ static inline TCGv gen_load_gpr(DisasContext *dc, int reg)
     }
 }
 
-static inline void gen_store_gpr(DisasContext *dc, int reg, TCGv v)
+static void gen_store_gpr(DisasContext *dc, int reg, TCGv v)
 {
     if (reg > 0) {
         assert(reg < 32);
@@ -292,7 +292,7 @@ static inline void gen_store_gpr(DisasContext *dc, int reg, TCGv v)
     }
 }
 
-static inline TCGv gen_dest_gpr(DisasContext *dc, int reg)
+static TCGv gen_dest_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
         assert(reg < 32);
@@ -326,31 +326,31 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
 }
 
 // XXX suboptimal
-static inline void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
+static void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
     tcg_gen_extract_tl(reg, reg, PSR_NEG_SHIFT, 1);
 }
 
-static inline void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
+static void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
     tcg_gen_extract_tl(reg, reg, PSR_ZERO_SHIFT, 1);
 }
 
-static inline void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
+static void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
     tcg_gen_extract_tl(reg, reg, PSR_OVF_SHIFT, 1);
 }
 
-static inline void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
+static void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
     tcg_gen_extract_tl(reg, reg, PSR_CARRY_SHIFT, 1);
 }
 
-static inline void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
     tcg_gen_mov_tl(cpu_cc_src2, src2);
@@ -465,7 +465,7 @@ static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
     }
 }
 
-static inline void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
     tcg_gen_mov_tl(cpu_cc_src2, src2);
@@ -538,7 +538,7 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     }
 }
 
-static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv r_temp, zero, t0;
 
@@ -577,7 +577,7 @@ static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_mov_tl(dst, cpu_cc_dst);
 }
 
-static inline void gen_op_multiply(TCGv dst, TCGv src1, TCGv src2, int sign_ext)
+static void gen_op_multiply(TCGv dst, TCGv src1, TCGv src2, int sign_ext)
 {
 #if TARGET_LONG_BITS == 32
     if (sign_ext) {
@@ -602,32 +602,32 @@ static inline void gen_op_multiply(TCGv dst, TCGv src1, TCGv src2, int sign_ext)
 #endif
 }
 
-static inline void gen_op_umul(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_umul(TCGv dst, TCGv src1, TCGv src2)
 {
     /* zero-extend truncated operands before multiplication */
     gen_op_multiply(dst, src1, src2, 0);
 }
 
-static inline void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
 {
     /* sign-extend truncated operands before multiplication */
     gen_op_multiply(dst, src1, src2, 1);
 }
 
 // 1
-static inline void gen_op_eval_ba(TCGv dst)
+static void gen_op_eval_ba(TCGv dst)
 {
     tcg_gen_movi_tl(dst, 1);
 }
 
 // Z
-static inline void gen_op_eval_be(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_be(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_Z(dst, src);
 }
 
 // Z | (N ^ V)
-static inline void gen_op_eval_ble(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_ble(TCGv dst, TCGv_i32 src)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_N(t0, src);
@@ -638,7 +638,7 @@ static inline void gen_op_eval_ble(TCGv dst, TCGv_i32 src)
 }
 
 // N ^ V
-static inline void gen_op_eval_bl(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bl(TCGv dst, TCGv_i32 src)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_V(t0, src);
@@ -647,7 +647,7 @@ static inline void gen_op_eval_bl(TCGv dst, TCGv_i32 src)
 }
 
 // C | Z
-static inline void gen_op_eval_bleu(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bleu(TCGv dst, TCGv_i32 src)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_Z(t0, src);
@@ -656,73 +656,73 @@ static inline void gen_op_eval_bleu(TCGv dst, TCGv_i32 src)
 }
 
 // C
-static inline void gen_op_eval_bcs(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bcs(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_C(dst, src);
 }
 
 // V
-static inline void gen_op_eval_bvs(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bvs(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_V(dst, src);
 }
 
 // 0
-static inline void gen_op_eval_bn(TCGv dst)
+static void gen_op_eval_bn(TCGv dst)
 {
     tcg_gen_movi_tl(dst, 0);
 }
 
 // N
-static inline void gen_op_eval_bneg(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bneg(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_N(dst, src);
 }
 
 // !Z
-static inline void gen_op_eval_bne(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bne(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_Z(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !(Z | (N ^ V))
-static inline void gen_op_eval_bg(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bg(TCGv dst, TCGv_i32 src)
 {
     gen_op_eval_ble(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !(N ^ V)
-static inline void gen_op_eval_bge(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bge(TCGv dst, TCGv_i32 src)
 {
     gen_op_eval_bl(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !(C | Z)
-static inline void gen_op_eval_bgu(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bgu(TCGv dst, TCGv_i32 src)
 {
     gen_op_eval_bleu(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !C
-static inline void gen_op_eval_bcc(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bcc(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_C(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !N
-static inline void gen_op_eval_bpos(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bpos(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_N(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !V
-static inline void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
+static void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
 {
     gen_mov_reg_V(dst, src);
     tcg_gen_xori_tl(dst, dst, 0x1);
@@ -735,23 +735,21 @@ static inline void gen_op_eval_bvc(TCGv dst, TCGv_i32 src)
    2 >
    3 unordered
 */
-static inline void gen_mov_reg_FCC0(TCGv reg, TCGv src,
+static void gen_mov_reg_FCC0(TCGv reg, TCGv src,
                                     unsigned int fcc_offset)
 {
     tcg_gen_shri_tl(reg, src, FSR_FCC0_SHIFT + fcc_offset);
     tcg_gen_andi_tl(reg, reg, 0x1);
 }
 
-static inline void gen_mov_reg_FCC1(TCGv reg, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_mov_reg_FCC1(TCGv reg, TCGv src, unsigned int fcc_offset)
 {
     tcg_gen_shri_tl(reg, src, FSR_FCC1_SHIFT + fcc_offset);
     tcg_gen_andi_tl(reg, reg, 0x1);
 }
 
 // !0: FCC0 | FCC1
-static inline void gen_op_eval_fbne(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbne(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -760,8 +758,7 @@ static inline void gen_op_eval_fbne(TCGv dst, TCGv src,
 }
 
 // 1 or 2: FCC0 ^ FCC1
-static inline void gen_op_eval_fblg(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fblg(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -770,15 +767,13 @@ static inline void gen_op_eval_fblg(TCGv dst, TCGv src,
 }
 
 // 1 or 3: FCC0
-static inline void gen_op_eval_fbul(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbul(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     gen_mov_reg_FCC0(dst, src, fcc_offset);
 }
 
 // 1: FCC0 & !FCC1
-static inline void gen_op_eval_fbl(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbl(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -787,15 +782,13 @@ static inline void gen_op_eval_fbl(TCGv dst, TCGv src,
 }
 
 // 2 or 3: FCC1
-static inline void gen_op_eval_fbug(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbug(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     gen_mov_reg_FCC1(dst, src, fcc_offset);
 }
 
 // 2: !FCC0 & FCC1
-static inline void gen_op_eval_fbg(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbg(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -804,8 +797,7 @@ static inline void gen_op_eval_fbg(TCGv dst, TCGv src,
 }
 
 // 3: FCC0 & FCC1
-static inline void gen_op_eval_fbu(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbu(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -814,8 +806,7 @@ static inline void gen_op_eval_fbu(TCGv dst, TCGv src,
 }
 
 // 0: !(FCC0 | FCC1)
-static inline void gen_op_eval_fbe(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbe(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -825,8 +816,7 @@ static inline void gen_op_eval_fbe(TCGv dst, TCGv src,
 }
 
 // 0 or 3: !(FCC0 ^ FCC1)
-static inline void gen_op_eval_fbue(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbue(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -836,16 +826,14 @@ static inline void gen_op_eval_fbue(TCGv dst, TCGv src,
 }
 
 // 0 or 2: !FCC0
-static inline void gen_op_eval_fbge(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbge(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     gen_mov_reg_FCC0(dst, src, fcc_offset);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !1: !(FCC0 & !FCC1)
-static inline void gen_op_eval_fbuge(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbuge(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -855,16 +843,14 @@ static inline void gen_op_eval_fbuge(TCGv dst, TCGv src,
 }
 
 // 0 or 1: !FCC1
-static inline void gen_op_eval_fble(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fble(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     gen_mov_reg_FCC1(dst, src, fcc_offset);
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
 // !2: !(!FCC0 & FCC1)
-static inline void gen_op_eval_fbule(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbule(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -874,8 +860,7 @@ static inline void gen_op_eval_fbule(TCGv dst, TCGv src,
 }
 
 // !3: !(FCC0 & FCC1)
-static inline void gen_op_eval_fbo(TCGv dst, TCGv src,
-                                    unsigned int fcc_offset)
+static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
 {
     TCGv t0 = tcg_temp_new();
     gen_mov_reg_FCC0(dst, src, fcc_offset);
@@ -884,8 +869,8 @@ static inline void gen_op_eval_fbo(TCGv dst, TCGv src,
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
-static inline void gen_branch2(DisasContext *dc, target_ulong pc1,
-                               target_ulong pc2, TCGv r_cond)
+static void gen_branch2(DisasContext *dc, target_ulong pc1,
+                        target_ulong pc2, TCGv r_cond)
 {
     TCGLabel *l1 = gen_new_label();
 
@@ -935,7 +920,7 @@ static void gen_branch_n(DisasContext *dc, target_ulong pc1)
     }
 }
 
-static inline void gen_generic_branch(DisasContext *dc)
+static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
     TCGv npc1 = tcg_constant_tl(dc->jump_pc[1]);
@@ -946,7 +931,7 @@ static inline void gen_generic_branch(DisasContext *dc)
 
 /* call this function before using the condition register as it may
    have been set for a jump */
-static inline void flush_cond(DisasContext *dc)
+static void flush_cond(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
@@ -954,7 +939,7 @@ static inline void flush_cond(DisasContext *dc)
     }
 }
 
-static inline void save_npc(DisasContext *dc)
+static void save_npc(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
@@ -964,7 +949,7 @@ static inline void save_npc(DisasContext *dc)
     }
 }
 
-static inline void update_psr(DisasContext *dc)
+static void update_psr(DisasContext *dc)
 {
     if (dc->cc_op != CC_OP_FLAGS) {
         dc->cc_op = CC_OP_FLAGS;
@@ -972,7 +957,7 @@ static inline void update_psr(DisasContext *dc)
     }
 }
 
-static inline void save_state(DisasContext *dc)
+static void save_state(DisasContext *dc)
 {
     tcg_gen_movi_tl(cpu_pc, dc->pc);
     save_npc(dc);
@@ -990,7 +975,7 @@ static void gen_check_align(TCGv addr, int mask)
     gen_helper_check_align(cpu_env, addr, tcg_constant_i32(mask));
 }
 
-static inline void gen_mov_pc_npc(DisasContext *dc)
+static void gen_mov_pc_npc(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
@@ -1004,7 +989,7 @@ static inline void gen_mov_pc_npc(DisasContext *dc)
     }
 }
 
-static inline void gen_op_next_insn(void)
+static void gen_op_next_insn(void)
 {
     tcg_gen_mov_tl(cpu_pc, cpu_npc);
     tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
@@ -1305,7 +1290,7 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
     cmp->c2 = tcg_constant_tl(0);
 }
 
-static inline void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
+static void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
 {
     DisasCompare cmp;
     gen_compare_reg(&cmp, cond, r_src);
@@ -1414,7 +1399,7 @@ static void do_branch_reg(DisasContext *dc, int32_t offset, uint32_t insn,
     }
 }
 
-static inline void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
+static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
     switch (fccno) {
     case 0:
@@ -1432,7 +1417,7 @@ static inline void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
     }
 }
 
-static inline void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
+static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     switch (fccno) {
     case 0:
@@ -1450,7 +1435,7 @@ static inline void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static inline void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno)
 {
     switch (fccno) {
     case 0:
@@ -1468,7 +1453,7 @@ static inline void gen_op_fcmpq(int fccno)
     }
 }
 
-static inline void gen_op_fcmpes(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
+static void gen_op_fcmpes(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
     switch (fccno) {
     case 0:
@@ -1486,7 +1471,7 @@ static inline void gen_op_fcmpes(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
     }
 }
 
-static inline void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
+static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     switch (fccno) {
     case 0:
@@ -1504,7 +1489,7 @@ static inline void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static inline void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno)
 {
     switch (fccno) {
     case 0:
@@ -1524,32 +1509,32 @@ static inline void gen_op_fcmpeq(int fccno)
 
 #else
 
-static inline void gen_op_fcmps(int fccno, TCGv r_rs1, TCGv r_rs2)
+static void gen_op_fcmps(int fccno, TCGv r_rs1, TCGv r_rs2)
 {
     gen_helper_fcmps(cpu_fsr, cpu_env, r_rs1, r_rs2);
 }
 
-static inline void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
+static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     gen_helper_fcmpd(cpu_fsr, cpu_env, r_rs1, r_rs2);
 }
 
-static inline void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno)
 {
     gen_helper_fcmpq(cpu_fsr, cpu_env);
 }
 
-static inline void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
+static void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
 {
     gen_helper_fcmpes(cpu_fsr, cpu_env, r_rs1, r_rs2);
 }
 
-static inline void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
+static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     gen_helper_fcmped(cpu_fsr, cpu_env, r_rs1, r_rs2);
 }
 
-static inline void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno)
 {
     gen_helper_fcmpeq(cpu_fsr, cpu_env);
 }
@@ -1573,12 +1558,12 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static inline void gen_op_clear_ieee_excp_and_FTT(void)
+static void gen_op_clear_ieee_excp_and_FTT(void)
 {
     tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
 }
 
-static inline void gen_fop_FF(DisasContext *dc, int rd, int rs,
+static void gen_fop_FF(DisasContext *dc, int rd, int rs,
                               void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
 {
     TCGv_i32 dst, src;
@@ -1592,8 +1577,8 @@ static inline void gen_fop_FF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static inline void gen_ne_fop_FF(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_i32, TCGv_i32))
+static void gen_ne_fop_FF(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_i32, TCGv_i32))
 {
     TCGv_i32 dst, src;
 
@@ -1605,7 +1590,7 @@ static inline void gen_ne_fop_FF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static inline void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
+static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 dst, src1, src2;
@@ -1621,8 +1606,8 @@ static inline void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
 }
 
 #ifdef TARGET_SPARC64
-static inline void gen_ne_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
-                                  void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
+static void gen_ne_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
+                           void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 dst, src1, src2;
 
@@ -1636,8 +1621,8 @@ static inline void gen_ne_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
 }
 #endif
 
-static inline void gen_fop_DD(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
+static void gen_fop_DD(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
 {
     TCGv_i64 dst, src;
 
@@ -1651,8 +1636,8 @@ static inline void gen_fop_DD(DisasContext *dc, int rd, int rs,
 }
 
 #ifdef TARGET_SPARC64
-static inline void gen_ne_fop_DD(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_i64, TCGv_i64))
+static void gen_ne_fop_DD(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_i64, TCGv_i64))
 {
     TCGv_i64 dst, src;
 
@@ -1665,7 +1650,7 @@ static inline void gen_ne_fop_DD(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static inline void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
+static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 dst, src1, src2;
@@ -1681,8 +1666,8 @@ static inline void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 }
 
 #ifdef TARGET_SPARC64
-static inline void gen_ne_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                                  void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
+static void gen_ne_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
+                           void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 dst, src1, src2;
 
@@ -1695,8 +1680,8 @@ static inline void gen_ne_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static inline void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                           void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
+                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 dst, src1, src2;
 
@@ -1709,8 +1694,8 @@ static inline void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static inline void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
-                           void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+static void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
+                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 dst, src0, src1, src2;
 
@@ -1725,8 +1710,8 @@ static inline void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
 }
 #endif
 
-static inline void gen_fop_QQ(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_ptr))
+static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_ptr))
 {
     gen_op_load_fpr_QT1(QFPREG(rs));
 
@@ -1738,8 +1723,8 @@ static inline void gen_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 
 #ifdef TARGET_SPARC64
-static inline void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_ptr))
+static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_ptr))
 {
     gen_op_load_fpr_QT1(QFPREG(rs));
 
@@ -1750,8 +1735,8 @@ static inline void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static inline void gen_fop_QQQ(DisasContext *dc, int rd, int rs1, int rs2,
-                               void (*gen)(TCGv_ptr))
+static void gen_fop_QQQ(DisasContext *dc, int rd, int rs1, int rs2,
+                        void (*gen)(TCGv_ptr))
 {
     gen_op_load_fpr_QT0(QFPREG(rs1));
     gen_op_load_fpr_QT1(QFPREG(rs2));
@@ -1763,7 +1748,7 @@ static inline void gen_fop_QQQ(DisasContext *dc, int rd, int rs1, int rs2,
     gen_update_fprs_dirty(dc, QFPREG(rd));
 }
 
-static inline void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
+static void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
     TCGv_i64 dst;
@@ -1779,8 +1764,8 @@ static inline void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static inline void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
-                               void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
+static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
+                        void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 src1, src2;
 
@@ -1795,8 +1780,8 @@ static inline void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
 }
 
 #ifdef TARGET_SPARC64
-static inline void gen_fop_DF(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
+static void gen_fop_DF(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
 {
     TCGv_i64 dst;
     TCGv_i32 src;
@@ -1811,8 +1796,8 @@ static inline void gen_fop_DF(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static inline void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
+static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
 {
     TCGv_i64 dst;
     TCGv_i32 src;
@@ -1825,8 +1810,8 @@ static inline void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static inline void gen_fop_FD(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i64))
+static void gen_fop_FD(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i64))
 {
     TCGv_i32 dst;
     TCGv_i64 src;
@@ -1840,8 +1825,8 @@ static inline void gen_fop_FD(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static inline void gen_fop_FQ(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr))
+static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_i32, TCGv_ptr))
 {
     TCGv_i32 dst;
 
@@ -1854,8 +1839,8 @@ static inline void gen_fop_FQ(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static inline void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i64, TCGv_ptr))
+static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
+                       void (*gen)(TCGv_i64, TCGv_ptr))
 {
     TCGv_i64 dst;
 
@@ -1868,8 +1853,8 @@ static inline void gen_fop_DQ(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static inline void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_ptr, TCGv_i32))
+static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_ptr, TCGv_i32))
 {
     TCGv_i32 src;
 
@@ -1881,8 +1866,8 @@ static inline void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
     gen_update_fprs_dirty(dc, QFPREG(rd));
 }
 
-static inline void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                                 void (*gen)(TCGv_ptr, TCGv_i64))
+static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
+                          void (*gen)(TCGv_ptr, TCGv_i64))
 {
     TCGv_i64 src;
 
@@ -2813,7 +2798,7 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env cpu_env)
+static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env cpu_env)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
 
-- 
2.30.2


