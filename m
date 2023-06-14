Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20C72F9F7
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 12:02:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9NKK-0000vJ-72; Wed, 14 Jun 2023 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9NKI-0000v3-9u
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 06:02:06 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9NKF-0005Ns-Qj
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 06:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cCMlVNUWvmevmX+q3j23/iIOt2KJheKFPAH1juLKDhs=; b=WT0dYetnrSHcHUY3xhZlNmcN/B
 lpzNAoU9ThR4ZiYUta7b4smrGI0TWBXTH/Qp3Dipww8/PhFsyU3pn5Ip43BceRKImUk5FqJgq2dLA
 q3piL7Zm/Fhwj8gIvcTaY3rz6bWKK5i7Ld7m4MssqrNXEPxALi1g0CnQG2e/xzJVnq20=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v3 8/8] target/tricore: Add DISABLE insn variant
Date: Wed, 14 Jun 2023 12:00:39 +0200
Message-Id: <20230614100039.1337971-9-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
References: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.14.95116, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=581812, da=174345985, mc=70, sc=0,
 hc=70, sp=0, fso=581812, re=0, sd=0, hd=0
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

this variant saves the 'IE' bit to a 'd' register. The 'IE' bitfield
changed from ISA version 1.6.1, so we add icr_ie_offset to DisasContext
as with the other DISABLE insn.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c       | 11 ++++++++++-
 target/tricore/tricore-opcodes.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index f01000efd4..6712d98f6e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -75,7 +75,7 @@ typedef struct DisasContext {
     int mem_idx;
     uint32_t hflags, saved_hflags;
     uint64_t features;
-    uint32_t icr_ie_mask;
+    uint32_t icr_ie_mask, icr_ie_offset;
 } DisasContext;
 
 static int has_feature(DisasContext *ctx, int feature)
@@ -7883,6 +7883,13 @@ static void decode_sys_interrupts(DisasContext *ctx)
     case OPC2_32_SYS_DISABLE:
         tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
         break;
+    case OPC2_32_SYS_DISABLE_D:
+        if (has_feature(ctx, TRICORE_FEATURE_16)) {
+            tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR, ctx->icr_ie_offset, 1);
+            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
     case OPC2_32_SYS_DSYNC:
         break;
     case OPC2_32_SYS_ENABLE:
@@ -8302,8 +8309,10 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->features = env->features;
     if (has_feature(ctx, TRICORE_FEATURE_161)) {
         ctx->icr_ie_mask = R_ICR_IE_161_MASK;
+        ctx->icr_ie_offset = R_ICR_IE_161_SHIFT;
     } else {
         ctx->icr_ie_mask = R_ICR_IE_13_MASK;
+        ctx->icr_ie_offset = R_ICR_IE_13_SHIFT;
     }
 }
 
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index af63926731..bc62b73173 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1467,6 +1467,7 @@ enum {
 enum {
     OPC2_32_SYS_DEBUG                            = 0x04,
     OPC2_32_SYS_DISABLE                          = 0x0d,
+    OPC2_32_SYS_DISABLE_D                        = 0x0f, /* 1.6 up */
     OPC2_32_SYS_DSYNC                            = 0x12,
     OPC2_32_SYS_ENABLE                           = 0x0c,
     OPC2_32_SYS_ISYNC                            = 0x13,
-- 
2.40.1


