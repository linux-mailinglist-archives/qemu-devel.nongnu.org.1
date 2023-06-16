Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD767334CE
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABNL-0004dR-EI; Fri, 16 Jun 2023 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNJ-0004cy-Or
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:33 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qABNI-0000mn-71
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VmKB0Au6tZltAgih9z19y10VR0aO5yFTs/18vTsT9DM=; b=iUse/YQZQAOyo8XMbHAqn8K+DW
 wakxbEBT35q3BmIHUQiqVduhQNzwbr2dj868bbnq5G5QVaV6QvDOZtF2gsK2P8eDXKzy6MKcqHdMx
 pJD0UtHoGwlcv5MbfogbA2RQZvGuxAN7j6A/nHAf3+PZ4NiZcylrx/gp6HyPLNoUcBcQ=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 3/8] target/tricore: ENABLE/DISABLE exit to main-loop
Date: Fri, 16 Jun 2023 17:28:03 +0200
Message-Id: <20230616152808.1499082-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.16.151517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=774201, da=174538374, mc=90, sc=0,
 hc=90, sp=0, fso=774201, re=0, sd=0, hd=0
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

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index d4f7415158..6164ba6539 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -38,6 +38,7 @@
 #undef  HELPER_H
 
 #define DISAS_EXIT        DISAS_TARGET_0
+#define DISAS_EXIT_UPDATE DISAS_TARGET_1
 
 /*
  * TCG registers
@@ -7880,11 +7881,13 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_DISABLE:
         tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
         break;
     case OPC2_32_SYS_DISABLE_D:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR, ctx->icr_ie_offset, 1);
             tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -7892,6 +7895,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_ENABLE:
         tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
+        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
         break;
     case OPC2_32_SYS_ISYNC:
         break;
@@ -8379,6 +8383,9 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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


