Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB19737F72
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuxE-0004SK-Mx; Wed, 21 Jun 2023 06:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuxB-0004Rm-Qh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:45 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBuxA-0001ay-8v
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gyf5SndWXVd7F5tVEZC1z1+D566ZF6KbBBeTuj6HsOA=; b=qStRqCku5s6vH8R+UIYhn0Xi0v
 hZRLBZcJscylW47RqNJD4SbNFRx2/b+8gF9rdRRd0/PI5AVq2Qptm0upn/V/nMfdfHJlIx4eu60Y/
 RtoBSxFcd/ynNRHgc8ng90M3ZcwxIkV2AgigPTv2X8WOxtm3sa3XYk3QJptWGc9fOMGs=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v3 8/8] target/tricore: Fix ICR.IE offset in RESTORE insn
Date: Wed, 21 Jun 2023 12:19:50 +0200
Message-Id: <20230621101950.1645420-9-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
References: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.101217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1187733, da=174951906, mc=120, sc=0,
 hc=120, sp=0, fso=1187733, re=0, sd=0, hd=0
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

from ISA v1.6.1 onwards the bit position of ICR.IE changed.
ctx->icr_ie_offset contains the correct value for the ISA version used
by the vCPU.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 71b6209af4..9cab0734dd 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7956,7 +7956,8 @@ static void decode_sys_interrupts(DisasContext *ctx)
     case OPC2_32_SYS_RESTORE:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
+                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1],
+                        ctx->icr_ie_offset, 1);
             } else {
                 generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
             }
-- 
2.40.1


