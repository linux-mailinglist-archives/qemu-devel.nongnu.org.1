Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A478AED6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 13:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaaPa-0000Vh-0F; Mon, 28 Aug 2023 07:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaP0-0008Is-Cn
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:28 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaaOu-0002i6-Pk
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 07:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTxkIcw/jBCixEpWMYft5TbETwLO+hj174dbfoHfFNA=; b=Om8jcze4sr0vERukSVrgNuajIM
 DFFGRfmFmFJCfVK7GF7z5GqotcB46VfmBulkeVm4fWSCULsckU0x2WLQW/XCUl3/g/R/pFNzNi0oW
 ZQzdbTZmzx0Td4zdl5i/PzJW6HEgRXESk/iWzNxj3pmpttKApPAFMsWPudodeYCWYDp4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me, richard.henderson@linaro.org,
 kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 09/11] target/tricore: Swap src and dst reg for RCRR_INSERT
Date: Mon, 28 Aug 2023 13:26:49 +0200
Message-ID: <20230828112651.522058-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.28.111517, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.28.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17265250, da=180831102, mc=32,
 sc=0, hc=32, sp=0, fso=17265250, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
 target/tricore/translate.c          | 8 ++++----
 tests/tcg/tricore/asm/macros.h      | 9 +++++++++
 tests/tcg/tricore/asm/test_insert.S | 5 +++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ee04434f26..403533c564 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8227,12 +8227,12 @@ static void decode_32Bit_opc(DisasContext *ctx)
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
2.41.0


