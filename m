Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAE737F74
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuwe-0003MJ-G1; Wed, 21 Jun 2023 06:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuwY-0003I6-11
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:06 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuwW-0000z4-31
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z7MyUypTHEtrgaFGHqECGQzvC/1wJwIBwkgSxgv86/c=; b=bUAiXpuhnS2zXqvW/Jz973j0U7
 W7sFrPPKxE9Ly619/EREjBtQMKgnB1hpfa8RYbeCMWwz8JSqneUNgHUrriq12HX9TEFZyzZb835Og
 Be7qWWB5CT+x2w0+D1ttL7N5k2ep5P9wnrOCOHS86nTMYsXuCNTyvWXTRrnFgjTkObw0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v3 1/8] target/tricore: Fix RR_JLI clobbering reg A[11]
Date: Wed, 21 Jun 2023 12:19:43 +0200
Message-Id: <20230621101950.1645420-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
References: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.101217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1187693, da=174951866, mc=106, sc=0,
 hc=106, sp=0, fso=1187693, re=0, sd=0, hd=0
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

if A[r1] == A[11], then we would overwrite the destination address of
the jump with the return address.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6712d98f6e..1d522d3b50 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6061,8 +6061,8 @@ static void decode_rr_idirect(DisasContext *ctx)
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_JLI:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
+        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
         break;
     case OPC2_32_RR_CALLI:
         gen_helper_1arg(call, ctx->pc_succ_insn);
-- 
2.40.1


