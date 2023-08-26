Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D17897F1
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvl8-0006ZA-Fi; Sat, 26 Aug 2023 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvku-0006Yz-7m
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:20 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvks-0007vF-2o
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZgNzutcjgqhdLFxPuL+X8Y3Q9jttx+KD3ECJGgSXH0k=; b=aR0cFrs14wle5xQRJ+Z5YDd2Y2
 PLAqKBA9On39UULlMwB/zV+Oty2gGnqMO7wKwNzw8BT5W7IvLPM6SR93yIUE6d4Lxf6VIJrnbPieJ
 C47fKe9Xoq9kT0X8YombncqJ4NNPW+zTWxaWoWburraV/VwjnpUp/NvTYaPfRmPTnGLI=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 09/10] target/tricore: Replace cpu_*_code with translator_*
Date: Sat, 26 Aug 2023 18:02:41 +0200
Message-ID: <20230826160242.312052-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index a68660b326..89ed48c951 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8400,7 +8400,7 @@ static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
      * 4 bytes from the page boundary, so we cross the page if the first
      * 16 bits indicate that this is a 32 bit insn.
      */
-    uint16_t insn = cpu_lduw_code(env, ctx->base.pc_next);
+    uint16_t insn = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
     return !tricore_insn_is_16bit(insn);
 }
@@ -8413,14 +8413,15 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     uint16_t insn_lo;
     bool is_16bit;
 
-    insn_lo = cpu_lduw_code(env, ctx->base.pc_next);
+    insn_lo = translator_lduw(env, &ctx->base, ctx->base.pc_next);
     is_16bit = tricore_insn_is_16bit(insn_lo);
     if (is_16bit) {
         ctx->opcode = insn_lo;
         ctx->pc_succ_insn = ctx->base.pc_next + 2;
         decode_16Bit_opc(ctx);
     } else {
-        uint32_t insn_hi = cpu_lduw_code(env, ctx->base.pc_next + 2);
+        uint32_t insn_hi = translator_lduw(env, &ctx->base,
+                                           ctx->base.pc_next + 2);
         ctx->opcode = insn_hi << 16 | insn_lo;
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         decode_32Bit_opc(ctx);
-- 
2.41.0


