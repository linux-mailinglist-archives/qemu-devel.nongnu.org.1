Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2B7386D5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBykR-0001iD-5u; Wed, 21 Jun 2023 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBykP-0001ha-Bj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:23:49 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qBykN-00011n-Mi
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5JByFDjZ9Ua7QQpoM28cwc6cgKhU516ZKfqLIc1/N0=; b=Y3j2geDw9uP777QKSkX3l+RBm2
 2X5kubk/Niks9qu+umg2dfPa/X9Azu5qPHiSlk8g2+jTLncjU8zAIVsY+lznuRyZp5scwM77uiIM/
 KiQgmoFi+Fn05SLy0IENP/YaVSgcR1NdDacVHoiYD5twuRDf0TAh7kzoIlqxaByE0U0c=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v4 3/8] target/tricore: ENABLE exit to main-loop
Date: Wed, 21 Jun 2023 16:22:57 +0200
Message-Id: <20230621142302.1648383-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621142302.1648383-1-kbastian@mail.uni-paderborn.de>
References: <20230621142302.1648383-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.21.141517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.21.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1202316, da=174966489, mc=129, sc=0,
 hc=129, sp=0, fso=1202316, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
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

so we can recognize exceptions after re-enabling interrupts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index d4f7415158..025b12567a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -38,6 +38,7 @@
 #undef  HELPER_H
 
 #define DISAS_EXIT        DISAS_TARGET_0
+#define DISAS_EXIT_UPDATE DISAS_TARGET_1
 
 /*
  * TCG registers
@@ -7892,6 +7893,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_ENABLE:
         tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
+        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
         break;
     case OPC2_32_SYS_ISYNC:
         break;
@@ -8379,6 +8381,9 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
+    case DISAS_EXIT_UPDATE:
+        gen_save_pc(ctx->base.pc_next);
+        /* fall through */
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.40.1


