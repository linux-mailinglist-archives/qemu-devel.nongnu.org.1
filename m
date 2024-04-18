Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC328AA19E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 19:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVts-0008Gp-Ga; Thu, 18 Apr 2024 13:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtm-0008Ep-TD; Thu, 18 Apr 2024 13:50:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtl-0007XY-2K; Thu, 18 Apr 2024 13:50:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 204315FD67;
 Thu, 18 Apr 2024 20:50:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7ED1CB933D;
 Thu, 18 Apr 2024 20:49:58 +0300 (MSK)
Received: (nullmailer pid 947824 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zack Buhman <zack@buhman.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 094/116] target/sh4: add missing CHECK_NOT_DELAY_SLOT
Date: Thu, 18 Apr 2024 20:49:24 +0300
Message-Id: <20240418174955.947730-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zack Buhman <zack@buhman.org>

CHECK_NOT_DELAY_SLOT is correctly applied to the branch-related
instructions, but not to the PC-relative mov* instructions.

I verified the existence of an illegal slot exception on a SH7091 when
any of these instructions are attempted inside a delay slot.

This also matches the behavior described in the SH-4 ISA manual.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240407150705.5965-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewd-by: Yoshinori Sato <ysato@users.sourceforge.jp>
(cherry picked from commit b754cb2dcde26a7bc8a9d17bb6900a0ac0dd38e2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index f3e08028f2..5aa10d3946 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -524,6 +524,7 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_movi_i32(REG(B11_8), B7_0s);
         return;
     case 0x9000: /* mov.w @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -531,6 +532,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xd000: /* mov.l @(disp,PC),Rn */
+        CHECK_NOT_DELAY_SLOT
         {
             TCGv addr = tcg_constant_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
@@ -1237,6 +1239,7 @@ static void _decode_opc(DisasContext * ctx)
         }
         return;
     case 0xc700: /* mova @(disp,PC),R0 */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
                                   4 + B7_0 * 4) & ~3);
         return;
-- 
2.39.2


