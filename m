Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A17B169F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlmmE-0006an-39; Thu, 28 Sep 2023 04:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmmC-0006aQ-1v
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:40 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmmA-0004yn-Hc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BW2JthvgwEqvznp0bOAz776apq7KePSWI1Irh0UoOYU=; b=CSaOZPcBkOKyrcErETIKW2q+GS
 tybQts2PdGbi+zhW7DYKRd52kXN2/6y3ih/xiNdsxeqOPSwdwv2neyLWKfURmAoA7q83Fj8IyQTrK
 hetPkwkhwpFkuSFJZBtouewjimqAQMshSDhvhiAx7ymEXJ7SEiwZiNIe5/+o9EtVKIe0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 10/21] target/tricore: Replace cpu_*_code with translator_*
Date: Thu, 28 Sep 2023 10:52:52 +0200
Message-ID: <20230928085303.511518-11-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
References: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.28.84518, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.28.602000
X-Sophos-SenderHistory: ip=79.202.213.239, fs=83850, da=183500279, mc=29, sc=0,
 hc=29, sp=0, fso=83850, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-11-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 7aba7b067c..2107d1fdd4 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8398,7 +8398,7 @@ static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
      * 4 bytes from the page boundary, so we cross the page if the first
      * 16 bits indicate that this is a 32 bit insn.
      */
-    uint16_t insn = cpu_lduw_code(env, ctx->base.pc_next);
+    uint16_t insn = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
     return !tricore_insn_is_16bit(insn);
 }
@@ -8411,14 +8411,15 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
2.42.0


