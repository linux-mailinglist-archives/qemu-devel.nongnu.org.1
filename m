Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A15738ACD
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Ul-0007KK-Vr; Wed, 21 Jun 2023 12:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0Uc-0007B5-Ns
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:38 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0UZ-0007nw-9Y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jwIJc65p+quh09ix6I92wIk7uI3jPFBZcyzzqKVF8qU=; b=RCf4tqf6+9ZPyC2ONVvU0AAfxi
 zej+6TS/6QLnpo9GG7f6ibELIgn3utDICF8/LF0JGYHZ8Fk9LwtVgIOzlj7gXw4BXuqs9XLBXHPpW
 AcHRRB9qmHve+OuqBae8Zifv+3jdTF3rwgKvkdoTDV5oEb+/E51jEnOZlKYYHmVlma7w=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	Siqi Chen <coc.cyqh@gmail.com>
Subject: [PULL 11/20] target/tricore: Add CHECK_REG_PAIR() for insn accessing
 64 bit regs
Date: Wed, 21 Jun 2023 18:14:13 +0200
Message-Id: <20230621161422.1652151-12-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209021, da=174973194, mc=163, sc=0,
 hc=163, sp=0, fso=1209021, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

some insns were not checking if an even index was used to access a 64
bit register. In the worst case that could lead to a buffer overflow as
reported in https://gitlab.com/qemu-project/qemu/-/issues/1698.

Reported-by: Siqi Chen <coc.cyqh@gmail.com>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230612113245.56667-4-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 74faad4794..d1b319e374 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -309,6 +309,7 @@ static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
 {
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
+    CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_movcond_tl(TCG_COND_EQ, temp2, cpu_gpr_d[reg+1], temp,
                        cpu_gpr_d[reg], temp);
@@ -321,7 +322,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     TCGv temp3 = tcg_temp_new();
-
+    CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_and_tl(temp2, cpu_gpr_d[reg], cpu_gpr_d[reg+1]);
     tcg_gen_andc_tl(temp3, temp, cpu_gpr_d[reg+1]);
@@ -3219,6 +3220,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
         break;
     case OPC1_16_SRC_MOV_E:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r1);
             tcg_gen_movi_tl(cpu_gpr_d[r1], const4);
             tcg_gen_sari_tl(cpu_gpr_d[r1+1], cpu_gpr_d[r1], 31);
         } else {
@@ -6180,6 +6182,7 @@ static void decode_rr_divide(DisasContext *ctx)
         tcg_gen_sari_tl(cpu_gpr_d[r3+1], cpu_gpr_d[r1], 31);
         break;
     case OPC2_32_RR_DVINIT_U:
+        CHECK_REG_PAIR(r3);
         /* overflow = (D[b] == 0) */
         tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
         tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
@@ -6230,6 +6233,7 @@ static void decode_rr_divide(DisasContext *ctx)
         break;
     case OPC2_32_RR_DIV:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r3);
             GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
                           cpu_gpr_d[r2]);
         } else {
@@ -6238,6 +6242,7 @@ static void decode_rr_divide(DisasContext *ctx)
         break;
     case OPC2_32_RR_DIV_U:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r3);
             GEN_HELPER_RR(divide_u, cpu_gpr_d[r3], cpu_gpr_d[r3+1],
                           cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
@@ -6764,6 +6769,8 @@ static void decode_rrr2_msub(DisasContext *ctx)
                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MSUB_U_64:
+        CHECK_REG_PAIR(r4);
+        CHECK_REG_PAIR(r3);
         gen_msubu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
         break;
@@ -7847,7 +7854,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
         break;
     case OPC2_32_RRRW_IMASK:
         temp2 = tcg_temp_new();
-
+        CHECK_REG_PAIR(r4);
         tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_tl(temp2, (1 << width) - 1);
         tcg_gen_shl_tl(temp2, temp2, temp);
-- 
2.40.1


