Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1237B2C86
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7Bl-0006Qv-MJ; Fri, 29 Sep 2023 02:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7BP-0005qA-JN
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:41:05 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm7B1-0007PZ-Th
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=imYeFgSVkPI88fieUmbPYNUtifTYEW4YKFSEwBH5gJI=; b=g1sRLYlCRR01zoBiRsM3xqYq0v
 gvKIwtVdtIe+Zhp7nMJJeGL6x7PpDWfxYR3rSpoRyeVraqspU2iG0+Co4WPQdfNQJM/dFLR+RgcZ6
 NF0PTaBMCDjJxuYoi20CRON2JV2Xgef3tFYBfaMGxtoHD/ZbFK/BP3sx9+DZ/5YMp9SA=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 09/16] target/tricore: Swap src and dst reg for RCRR_INSERT
Date: Fri, 29 Sep 2023 08:39:53 +0200
Message-ID: <20230929064000.536923-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
References: <20230929064000.536923-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.63017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.28.602002
X-Sophos-SenderHistory: ip=79.202.213.239, fs=162269, da=183578698, mc=58, sc=0,
 hc=58, sp=0, fso=162269, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-10-kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c          | 8 ++++----
 tests/tcg/tricore/asm/macros.h      | 9 +++++++++
 tests/tcg/tricore/asm/test_insert.S | 5 +++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 3f950ae33b..7aba7b067c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8223,12 +8223,12 @@ static void decode_32Bit_opc(DisasContext *ctx)
         temp2 = tcg_temp_new(); /* width*/
         temp3 = tcg_temp_new(); /* pos */
 
-        CHECK_REG_PAIR(r3);
+        CHECK_REG_PAIR(r2);
 
-        tcg_gen_andi_tl(temp2, cpu_gpr_d[r3+1], 0x1f);
-        tcg_gen_andi_tl(temp3, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_andi_tl(temp2, cpu_gpr_d[r2 + 1], 0x1f);
+        tcg_gen_andi_tl(temp3, cpu_gpr_d[r2], 0x1f);
 
-        gen_insert(cpu_gpr_d[r2], cpu_gpr_d[r1], temp, temp2, temp3);
+        gen_insert(cpu_gpr_d[r3], cpu_gpr_d[r1], temp, temp2, temp3);
         break;
 /* RCRW Format */
     case OPCM_32_RCRW_MASK_INSERT:
diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 51f6191ef2..17e696bef5 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -169,6 +169,15 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, imm1, imm2;   \
     )
 
+#define TEST_D_DIE(insn, num, result, rs1, imm1, rs2_lo, rs2_hi)\
+    TEST_CASE(num, DREG_CALC_RESULT, result,                    \
+    LI(DREG_RS1, rs1);                                          \
+    LI(EREG_RS2_LO, rs2_lo);                                    \
+    LI(EREG_RS2_HI, rs2_hi);                                    \
+    rstv;                                                       \
+    insn DREG_CALC_RESULT, DREG_RS1, imm1, EREG_RS2;            \
+    )
+
 #define TEST_D_DIII(insn, num, result, rs1, imm1, imm2, imm3)\
     TEST_CASE(num, DREG_CALC_RESULT, result,                 \
     LI(DREG_RS1, rs1);                                       \
diff --git a/tests/tcg/tricore/asm/test_insert.S b/tests/tcg/tricore/asm/test_insert.S
index 3978810121..223d7ce796 100644
--- a/tests/tcg/tricore/asm/test_insert.S
+++ b/tests/tcg/tricore/asm/test_insert.S
@@ -15,4 +15,9 @@ _start:
 #                 |     |      |           |           |        |    |
     TEST_D_DDII(insert, 4, 0x03c1e53c, 0x03c1e53c, 0x45821385, 0x7 ,0x0)
 
+#                insn num   result       rs1     imm1      rs2_h       rs2_l
+#                 |    |      |           |        |         |           |
+    TEST_D_DIE(insert, 5, 0xe30c308d, 0xe30c308d ,0x3 , 0x00000000 ,0x00000000)
+    TEST_D_DIE(insert, 6, 0x669b0120, 0x669b2820 ,0x2 , 0x5530a1c7 ,0x3a2b0f67)
+
     TEST_PASSFAIL
-- 
2.42.0


