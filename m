Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345B72B372
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 20:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8QBT-0008VN-S0; Sun, 11 Jun 2023 14:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBR-0008V1-Ra
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:01 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBQ-0001m9-Am
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KqGzTedqVU4LRTzW2IfG3DcILN957WnhfZ8yGfo0e9I=; b=J5+FCIJ2pY6E0zmFIyWnc85xmn
 w8kH3xWeqiz0xOrKaOfpufr72zevxoflUohqPSl0NyE7ONZEsWbSjoN7vapVrM6OPthfOrxnu8CnH
 yWu0uJS2djXgxzoM3Pn0bnIuqEYtp9gPlfIwWytH9ScqjV13FoI4IGdcTmvf5m2iRlwg=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 2/6] target/tricore: Add popcnt.w insn
Date: Sun, 11 Jun 2023 20:52:09 +0200
Message-Id: <20230611185213.51345-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
References: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.11.184517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=354469, da=174118642, mc=32, sc=0,
 hc=32, sp=0, fso=354469, re=0, sd=0, hd=0
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c       | 7 +++++++
 target/tricore/tricore-opcodes.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index cd33a1dcdd..26b284bcec 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6197,6 +6197,13 @@ static void decode_rr_divide(DisasContext *ctx)
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
+    case OPC2_32_RR_POPCNT_W:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            tcg_gen_ctpop_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RR_DIV:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index f7135f183d..59aa39a7a5 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1133,6 +1133,7 @@ enum {
     OPC2_32_RR_PARITY                            = 0x02,
     OPC2_32_RR_UNPACK                            = 0x08,
     OPC2_32_RR_CRC32                             = 0x03,
+    OPC2_32_RR_POPCNT_W                          = 0x22, /* 1.6.2 only */
     OPC2_32_RR_DIV                               = 0x20,
     OPC2_32_RR_DIV_U                             = 0x21,
     OPC2_32_RR_MUL_F                             = 0x04,
-- 
2.40.1


