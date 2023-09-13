Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E579E569
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVK-0007dF-DG; Wed, 13 Sep 2023 06:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVG-0007bs-9T
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:50 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVC-0006Pd-Mo
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N501HXmFkxmMt7uB5nNxBzP4tNg4mkPuaGMnn1wSmMY=; b=Ez+ZB7cUPmixrDdW+QJjAtv266
 srdv9rCMo/bR0V9IuiJuWyxIFZwIuMK3uc+oLJsN9SwArB/ed/8fOkychIWliz22zNCm1SlvCX+kN
 VdrIuh4zZUWM1RKRw6Tu6wCAv9dOTnXxN4tEgRM9LwmQMqPoCvW7ray4+EFTV2D3/R9I=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 04/10] tests/tcg/tricore: Add test for all arith insns up to
 addx
Date: Wed, 13 Sep 2023 12:53:20 +0200
Message-ID: <20230913105326.40832-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=8, da=182211485, mc=8, sc=0, hc=8,
 sp=0, fso=8, re=0, sd=0, hd=0
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
 tests/tcg/tricore/Makefile.softmmu-target |  3 +-
 tests/tcg/tricore/asm/macros.h            | 50 +++++++++++++++++++++++
 tests/tcg/tricore/asm/test_arith.S        | 41 +++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/tricore/asm/test_arith.S

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index afcf41a977..018858c592 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -6,6 +6,7 @@ LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
 ASFLAGS = -mtc162
 CFLAGS = -mtc162 -c -I$(TESTS_PATH)
 
+TESTS += test_arith.asm.tst
 TESTS += test_abs.asm.tst
 TESTS += test_bmerge.asm.tst
 TESTS += test_clz.asm.tst
@@ -29,7 +30,7 @@ TESTS += test_muls.asm.tst
 TESTS += test_boot_to_main.c.tst
 TESTS += test_context_save_areas.c.tst
 
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
+QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -d guest_errors -kernel 
 
 %.pS: $(ASM_TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index e831f73721..8ed2249b0d 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -112,6 +112,11 @@ test_ ## num:                                                    \
     insn DREG_CORRECT_RESULT, DREG_RS1;               \
     )
 
+#define TEST_D_I(insn, num, result, imm)      \
+    TEST_CASE(num, DREG_CALC_RESULT, result,  \
+    insn DREG_CALC_RESULT, imm;               \
+    )
+
 #define TEST_D_DDD(insn, num, result, rs1, rs2, rs3)        \
     TEST_CASE(num, DREG_CALC_RESULT, result,                \
     LI(DREG_RS1, rs1);                                      \
@@ -129,6 +134,51 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
     )
 
+#define TEST_D_DI(insn, num, result, rs1, imm1) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,     \
+    LI(DREG_RS1, rs1);                          \
+    rstv;                                       \
+    insn DREG_CALC_RESULT, DREG_RS1, imm1;      \
+    )
+
+#define TEST_D_D15I(insn, num, result, rs1, imm1) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,       \
+    LI(%d15, rs1);                                \
+    rstv;                                         \
+    insn DREG_CALC_RESULT, %d15, imm1;            \
+    )
+
+#define TEST_D15_DD(insn, num, result, rs1, rs2) \
+    TEST_CASE(num, %d15, result,                 \
+    LI(DREG_RS1, rs1);                           \
+    LI(DREG_RS2, rs2);                           \
+    rstv;                                        \
+    insn %d15, DREG_RS1, DREG_RS2;               \
+    )
+
+#define TEST_D15_DI(insn, num, result, rs1, imm) \
+    TEST_CASE(num, %d15, result,                 \
+    LI(DREG_RS1, rs1);                           \
+    rstv;                                        \
+    insn %d15, DREG_RS1, imm;                    \
+    )
+
+#define TEST_D_DD(insn, num, result, rs1, rs2) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,   \
+    LI(DREG_RS1, rs1);                         \
+    LI(DREG_RS2, rs2);                         \
+    rstv;                                      \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2; \
+    )
+
+#define TEST_D_D15D(insn, num, result, rs1, rs2) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,   \
+    LI(%d15, rs1);                             \
+    LI(DREG_RS2, rs2);                         \
+    rstv;                                      \
+    insn DREG_CALC_RESULT, %d15, DREG_RS2;     \
+    )
+
 #define TEST_D_DDD_PSW(insn, num, result, psw, rs1, rs2, rs3) \
     TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,         \
     LI(DREG_RS1, rs1);                                        \
diff --git a/tests/tcg/tricore/asm/test_arith.S b/tests/tcg/tricore/asm/test_arith.S
new file mode 100644
index 0000000000..07c4b876e9
--- /dev/null
+++ b/tests/tcg/tricore/asm/test_arith.S
@@ -0,0 +1,41 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(abs, 1, 0x778636a7, 0x778636a7 )
+    TEST_D_D(abs.b, 2, 0x497a4902, 0xb786b702 )
+    TEST_D_D(abs.h, 3, 0x48331698, 0xb7cde968 )
+    TEST_D_DI(absdif, 4, 0x22a52402, 0xdd5adc1a ,0x1c )
+    TEST_D_DD(absdif, 5, 0x1e106273, 0x56f0cea3 ,0x75013116 )
+    TEST_D_DD(absdif.b, 6, 0xa650a3b, 0xa7ee8b2a ,0x9d899565 )
+    TEST_D_DD(absdif.h, 7, 0x7dd06888, 0x88292922 ,0x5f9c09a )
+    TEST_D_DI(absdifs, 8, 0x79adddf7, 0x865222d1 ,0xc8 )
+    TEST_D_DD(absdifs, 9, 0x7fffffff, 0x2ac1008b ,0x80032055 )
+    TEST_D_DD(absdifs.h, 10, 0x65ae7fff, 0xf70a7a05 ,0x915cc1b3 )
+    TEST_D_D(abss, 11, 0x2a671868, 0xd598e798 )
+    TEST_D_D(abss.h, 12, 0x60fc7ce5, 0x9f04831b )
+    TEST_D_DI(add, 13, 0x951ce738, 0x951ce6b4 ,0x84 )
+    TEST_D_DD(add, 14, 0x53975df5, 0xc003e25a ,0x93937b9b )
+    TEST_D_I(add, 15, 0x5, 0x5 )
+    TEST_D_D15I(add, 16, 0x3c330214, 0x3c33020f ,0x5 )
+    TEST_D15_DI(add, 17, 0x55eb1b8, 0x55eb1b8 ,0x0 )
+    TEST_D_D(add, 18, 0xe66ead54, 0xe66ead54 )
+    TEST_D_D15D(add, 19, 0xe450f787, 0xc7100fee ,0x1d40e799 )
+    TEST_D15_DD(add, 20, 0x73f6d886, 0x27ca8a80 ,0x4c2c4e06 )
+    TEST_D_DD(add.b, 21, 0x631bd462, 0xf9702965 ,0x6aababfd )
+    TEST_D_DD(add.h, 22, 0x76ce127a, 0xf5402796 ,0x818eeae4 )
+    TEST_D_DI(addc, 23, 0xcf8399c3, 0xcf839920 ,0xa3 )
+    TEST_D_DD(addc, 24, 0xa455054c, 0x85d0b9ed ,0x1e844b5f )
+    TEST_D_DI(addi, 25, 0xbf202fe6, 0xbf1fd903 ,0x56e3 )
+    TEST_D_DI(addih, 26, 0xf28a99cc, 0xc10499cc ,12678 )
+    TEST_D_DI(adds, 27, 0x233892ad, 0x233892ad ,0x0 )
+    TEST_D_DD(adds, 28, 0xc1b1184d, 0x100a2339 ,0xb1a6f514 )
+    TEST_D_D(adds, 29, 0x19143e9a, 0x19143e9a )
+    TEST_D_DD(adds.h, 30, 0x7fff9de3, 0x668ebcc8 ,0x7462e11b )
+    TEST_D_DD(adds.hu, 31, 0xffffffff, 0xbe0776eb ,0x5d69b388 )
+    TEST_D_DI(adds.u, 32, 0x84c176ba, 0x84c176a9 ,0x11 )
+    TEST_D_DD(adds.u, 33, 0xffffffff, 0xd4a91e39 ,0x55b1baed )
+    TEST_D_DI(addx, 34, 0x38f63b5, 0x38f632b ,0x8a )
+    TEST_D_DD(addx, 35, 0x8b9da5a4, 0x16e32e7 ,0x8a2f72bd )
+
+    TEST_PASSFAIL
-- 
2.42.0


