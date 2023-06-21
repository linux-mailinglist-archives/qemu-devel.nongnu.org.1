Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB5738AB5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0V2-0008Gl-QI; Wed, 21 Jun 2023 12:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0V0-0008Ck-Mu
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:02 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qC0Uz-0007xZ-2j
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5IGgMgmqBrconTwc2JIjo5Dwix4qyKWPhUfXJBeZfqs=; b=fDdBzuZi+CVRWkZ6+8BNTRj+XN
 /PL6s6Ua8WSjtjfLuUc/Gaa6OEIkUxx742MKnVlhoiXD96qHS1pbw3Jq53zKFgQQzyFiU3xTibiLM
 Qrgzp613ZFmvdsdJBVJSYOxybbk2LjJLyx0Gim5m+ftsJyps/Ogh550UWwtz68nem6gs=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/20] target/tricore: Indirect jump insns use
 tcg_gen_lookup_and_goto_ptr()
Date: Wed, 21 Jun 2023 18:14:18 +0200
Message-Id: <20230621161422.1652151-17-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.160616, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1209050, da=174973223, mc=173, sc=0,
 hc=173, sp=0, fso=1209050, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230621142302.1648383-5-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 98e2767d21..fb6f0caa24 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -39,6 +39,7 @@
 
 #define DISAS_EXIT        DISAS_TARGET_0
 #define DISAS_EXIT_UPDATE DISAS_TARGET_1
+#define DISAS_JUMP        DISAS_TARGET_2
 
 /*
  * TCG registers
@@ -6077,8 +6078,9 @@ static void decode_rr_idirect(DisasContext *ctx)
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        return;
     }
-    ctx->base.is_jmp = DISAS_EXIT;
+    ctx->base.is_jmp = DISAS_JUMP;
 }
 
 static void decode_rr_divide(DisasContext *ctx)
@@ -8395,6 +8397,9 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
+    case DISAS_JUMP:
+        tcg_gen_lookup_and_goto_ptr();
+        break;
     case DISAS_NORETURN:
         break;
     default:
-- 
2.40.1


