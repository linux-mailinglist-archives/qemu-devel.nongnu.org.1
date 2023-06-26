Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6673EAA4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrNH-0004cT-Kc; Mon, 26 Jun 2023 14:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMQ-0001zl-3Z; Mon, 26 Jun 2023 14:54:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrLr-0005ht-HR; Mon, 26 Jun 2023 14:54:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AAE5AEF43;
 Mon, 26 Jun 2023 21:50:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3D074F7D2;
 Mon, 26 Jun 2023 21:50:28 +0300 (MSK)
Received: (nullmailer pid 1574091 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Siqi Chen <coc.cyqh@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 44/54] target/tricore: Add CHECK_REG_PAIR() for insn
 accessing 64 bit regs
Date: Mon, 26 Jun 2023 21:49:51 +0300
Message-Id: <20230626185002.1573836-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

some insns were not checking if an even index was used to access a 64
bit register. In the worst case that could lead to a buffer overflow as
reported in https://gitlab.com/qemu-project/qemu/-/issues/1698.

Reported-by: Siqi Chen <coc.cyqh@gmail.com>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230612113245.56667-4-kbastian@mail.uni-paderborn.de>
(cherry picked from commit 6991777ec4b2a344d47bddec62744bedd9883d78)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1921b7bfb5..43920b20ee 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -305,6 +305,7 @@ static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
 {
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
+    CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_movcond_tl(TCG_COND_EQ, temp2, cpu_gpr_d[reg+1], temp,
                        cpu_gpr_d[reg], temp);
@@ -317,7 +318,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     TCGv temp3 = tcg_temp_new();
-
+    CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_and_tl(temp2, cpu_gpr_d[reg], cpu_gpr_d[reg+1]);
     tcg_gen_andc_tl(temp3, temp, cpu_gpr_d[reg+1]);
@@ -3215,6 +3216,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
         break;
     case OPC1_16_SRC_MOV_E:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r1);
             tcg_gen_movi_tl(cpu_gpr_d[r1], const4);
             tcg_gen_sari_tl(cpu_gpr_d[r1+1], cpu_gpr_d[r1], 31);
         } else {
@@ -6168,6 +6170,7 @@ static void decode_rr_divide(DisasContext *ctx)
         tcg_gen_sari_tl(cpu_gpr_d[r3+1], cpu_gpr_d[r1], 31);
         break;
     case OPC2_32_RR_DVINIT_U:
+        CHECK_REG_PAIR(r3);
         /* overflow = (D[b] == 0) */
         tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
         tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
@@ -6196,6 +6199,7 @@ static void decode_rr_divide(DisasContext *ctx)
         break;
     case OPC2_32_RR_DIV:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r3);
             GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
                           cpu_gpr_d[r2]);
         } else {
@@ -6204,6 +6208,7 @@ static void decode_rr_divide(DisasContext *ctx)
         break;
     case OPC2_32_RR_DIV_U:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            CHECK_REG_PAIR(r3);
             GEN_HELPER_RR(divide_u, cpu_gpr_d[r3], cpu_gpr_d[r3+1],
                           cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
@@ -6730,6 +6735,8 @@ static void decode_rrr2_msub(DisasContext *ctx)
                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MSUB_U_64:
+        CHECK_REG_PAIR(r4);
+        CHECK_REG_PAIR(r3);
         gen_msubu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
         break;
@@ -7813,7 +7820,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
         break;
     case OPC2_32_RRRW_IMASK:
         temp2 = tcg_temp_new();
-
+        CHECK_REG_PAIR(r4);
         tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_tl(temp2, (1 << width) - 1);
         tcg_gen_shl_tl(temp2, temp2, temp);
-- 
2.39.2


