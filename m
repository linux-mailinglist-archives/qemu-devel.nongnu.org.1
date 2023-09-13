Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D00A479E563
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVN-0007dl-TP; Wed, 13 Sep 2023 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVI-0007ci-9z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:52 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVE-0006QI-ER
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=45hu+bY3SjAenm8VmDBrQV9K2bkVwwE168q6l//h/LM=; b=la1IBuQdzZ9TV7Ly4nVzhOagsB
 z+BNUXhNpLg6lsTFVDAw5IudZ/3pFlG/+DQxUoQ6PdbgS9V6jM9xO86b7ZQAgTevm5ONIUtCmWz+s
 yh9HRPQZYRI1iK0pQ4mSReUHVRmz2kffKrOhYua9KKDuIcNIb1Vnb4vL8OF0jLhSmZTk=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 06/10] tests/tcg/tricore: Add from dextr to lt
Date: Wed, 13 Sep 2023 12:53:22 +0200
Message-ID: <20230913105326.40832-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=13, da=182211490, mc=12, sc=0,
 hc=12, sp=0, fso=13, re=0, sd=0, hd=0
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
 tests/tcg/tricore/asm/macros.h     | 51 ++++++++++++++++++++++++++--
 tests/tcg/tricore/asm/test_arith.S | 53 ++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 3000e15590..92f0f7b22b 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -34,6 +34,9 @@
 #define EREG_RS2 %e2
 #define EREG_RS2_LO %d2
 #define EREG_RS2_HI %d3
+#define EREG_RS3 %e4
+#define EREG_RS3_LO %d4
+#define EREG_RS3_HI %d5
 #define EREG_CALC_RESULT %e6
 #define EREG_CALC_RESULT_LO %d6
 #define EREG_CALC_RESULT_HI %d7
@@ -131,6 +134,26 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, DREG_RS3; \
     )
 
+#define TEST_D_DDDI(insn, num, result, rs1, rs2, rs3, imm)    \
+    TEST_CASE(num, DREG_CALC_RESULT, result,                  \
+    LI(DREG_RS1, rs1);                                        \
+    LI(DREG_RS2, rs2);                                        \
+    LI(DREG_RS3, rs3);                                        \
+    rstv;                                                     \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, DREG_RS3, imm; \
+    )
+
+
+#define TEST_D_DDE(insn, num, result, rs1, rs2, rs3_lo, rs3_hi) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,                    \
+    LI(DREG_RS1, rs1);                                          \
+    LI(DREG_RS2, rs2);                                          \
+    LI(EREG_RS3_LO, rs3_lo);                                    \
+    LI(EREG_RS3_HI, rs3_hi);                                    \
+    rstv;                                                       \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, EREG_RS3;        \
+    )
+
 #define TEST_D_DD_PSW(insn, num, result, psw, rs1, rs2) \
     TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,   \
     LI(DREG_RS1, rs1);                                  \
@@ -209,6 +232,12 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, imm;           \
     )
 
+#define TEST_E_DII(insn, num, res_lo, res_hi, rs1, imm1, imm2) \
+    TEST_CASE_E(num, res_lo, res_hi,                           \
+    LI(DREG_RS1, rs1);                                         \
+    insn EREG_CALC_RESULT, DREG_RS1, imm1, imm2;               \
+    )
+
 #define TEST_D_DIDI(insn, num, result, rs1, imm1, rs2, imm2) \
     TEST_CASE(num, DREG_CALC_RESULT, result,                 \
     LI(DREG_RS1, rs1);                                       \
@@ -247,7 +276,7 @@ test_ ## num:                                                    \
     insn EREG_CALC_RESULT, DREG_RS1;             \
     )
 
-#define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
+#define TEST_E_ED(insn, num, res_lo, res_hi, rs1_lo, rs1_hi, rs2) \
     TEST_CASE_E(num, res_lo, res_hi,                              \
     LI(EREG_RS1_LO, rs1_lo);                                      \
     LI(EREG_RS1_HI, rs1_hi);                                      \
@@ -255,14 +284,32 @@ test_ ## num:                                                    \
     insn EREG_CALC_RESULT, EREG_RS1, DREG_RS2;                    \
     )
 
-#define TEST_E_IDI(insn, num, res_hi, res_lo, imm1, rs1, imm2) \
+#define TEST_E_IDI(insn, num, res_lo, res_hi, imm1, rs1, imm2) \
     TEST_CASE_E(num, res_lo, res_hi,                           \
     LI(DREG_RS1, rs1);                                         \
     rstv;                                                      \
     insn EREG_CALC_RESULT, imm1, DREG_RS1, imm2;               \
     )
 
+#define TEST_E_DD(insn, num, res_lo, res_hi, rs1, rs2) \
+    TEST_CASE_E(num, res_lo, res_hi,                   \
+    LI(DREG_RS1, rs1);                                 \
+    LI(DREG_RS2, rs2);                                 \
+    insn EREG_CALC_RESULT, DREG_RS1, DREG_RS2;         \
+    )
 
+#define TEST_E_DDI(insn, num, res_lo, res_hi, rs1, rs2, imm) \
+    TEST_CASE_E(num, res_lo, res_hi,                         \
+    LI(DREG_RS1, rs1);                                       \
+    LI(DREG_RS2, rs2);                                       \
+    insn EREG_CALC_RESULT, DREG_RS1, DREG_RS2, imm;          \
+    )
+
+#define TEST_E_III(insn, num, res_lo, res_hi, imm1, imm2, imm3) \
+    TEST_CASE_E(num, res_lo, res_hi,                            \
+    rstv;                                                       \
+    insn EREG_CALC_RESULT, imm1, imm2, imm3;                    \
+    )
 
 /* Pass/Fail handling part */
 #define TEST_PASSFAIL                       \
diff --git a/tests/tcg/tricore/asm/test_arith.S b/tests/tcg/tricore/asm/test_arith.S
index ec87413777..68b6715cb9 100644
--- a/tests/tcg/tricore/asm/test_arith.S
+++ b/tests/tcg/tricore/asm/test_arith.S
@@ -84,5 +84,58 @@ _start:
     TEST_D_DD(crc32l.w, 80, 0x1707579b, 0x87572060 ,0x8cdfa395 )
     TEST_D_DDD(csub, 81, 0xf389f12f, 0xae9c7e04 ,0x63247211 ,0x6f9a80e2 )
     TEST_D_DDD(csubn, 82, 0x2a7dd20d, 0xc39caf46 ,0x2a7dd20d ,0xa8ab6269 )
+    TEST_D_DDI(dextr, 83, 0x6b245592, 0x90d648ab ,0x2436a08d ,0x7 )
+    TEST_D_DDD(dextr, 84, 0x4e9d8172, 0x6b8c6274 ,0xec0b9772 ,0x7ab0d8f5 )
+    TEST_E_ED(dvadj, 85, 0xfb793929 ,0xf15f4ecc, 0xfb793928 ,0xf15f4ecc ,0x5de9a7b4 )
+    TEST_E_DD(dvinit, 86, 0xbbd99367 ,0xffffffff, 0xbbd99367 ,0xa248dff9 )
+    TEST_E_DD(dvinit.b, 87, 0x58ffffff ,0x1f3f20, 0x1f3f2058 ,0xfed6c3ec )
+    TEST_E_DD(dvinit.bu, 88, 0xa000000 ,0x8bbf54, 0x8bbf540a ,0xa0bcfdde )
+    TEST_E_DD(dvinit.h, 89, 0xfe59ffff ,0x6d07, 0x6d07fe59 ,0xe4a6e12c )
+    TEST_E_DD(dvinit.hu, 90, 0x8e5d0000 ,0x37bd, 0x37bd8e5d ,0x38c0be4c )
+    TEST_E_DD(dvinit.u, 91, 0x613ca148 ,0x0, 0x613ca148 ,0x79e89e70 )
+    TEST_E_ED(dvstep.u, 92, 0x90388180 ,0x356c3f47, 0x47903881 ,0xd5b131ef ,0xa8f78b60 )
+    TEST_D_DI(eq, 93, 0x0, 0x22cf24bc ,0x3c )
+    TEST_D_DD(eq, 94, 0x0, 0x1b220983 ,0x60d6182 )
+    TEST_D15_DI(eq, 95, 0x0, 0x66b1313e ,0x1 )
+    TEST_D15_DD(eq, 96, 0x0, 0x3a6b6484 ,0xe1bdc794 )
+    TEST_D_DD(eq.b, 97, 0x0, 0x1413e6a2 ,0x8237ab11 )
+    TEST_D_DD(eq.h, 98, 0x0, 0xc2d2cdd3 ,0xfd8576be )
+    TEST_D_DD(eq.w, 99, 0x0, 0x1b6f66d7 ,0x738035d1 )
+    TEST_D_DI(eqany.b, 100, 0x0, 0xfb630c56 ,0x9f )
+    TEST_D_DD(eqany.b, 101, 0x0, 0x5cdbbb44 ,0xf7911917 )
+    TEST_D_DI(eqany.h, 102, 0x0, 0xd31af4d0 ,0xc )
+    TEST_D_DD(eqany.h, 103, 0x0, 0x6bd800e2 ,0x8bea6be7 )
+    TEST_D_DI(ge, 104, 0x1, 0x3d3d0f67 ,0x6d )
+    TEST_D_DD(ge, 105, 0x1, 0x7238ba92 ,0x3d6d3327 )
+    TEST_D_DI(ge.u, 106, 0x1, 0xc34402cb ,0xf2 )
+    TEST_D_DD(ge.u, 107, 0x1, 0xf44ec751 ,0x42f3f12d )
+    TEST_E_III(imask, 108, 0x1c0 ,0x1c0, 0x7 ,0x6 ,0x3 )
+    TEST_E_IDI(imask, 109, 0x1 ,0x7f, 0x1 ,0xa7390380 ,0x7 )
+    TEST_E_DII(imask, 110, 0x3fdaaa80 ,0x1fc0, 0x14ff6aaa ,0x6 ,0x7 )
+    TEST_E_DDI(imask, 111, 0xfc8a94c0 ,0x1f0, 0xafc8a94c ,0x37ceafe4 ,0x5 )
+    TEST_D_DIDI(ins.t, 112, 0x3991c755, 0x3991c755 ,0x2 ,0xa9b171ef ,0x4 )
+    TEST_D_DIII(insert, 113, 0x9997e4d7, 0x9997e497 ,0x6 ,0x5 ,0x2 )
+    TEST_D_DIE(insert, 114, 0x71169ed, 0xaf1169ed ,0x1 ,0xf5abe69a ,0xaef09348 )
+    TEST_D_DIDI(insert, 115, 0x8a228466, 0x8a2284e6 ,0x5 ,0x2c808a7f ,0x2 )
+    TEST_D_DDII(insert, 116, 0xeffef7ec, 0xeffef7e8 ,0xaa92b4ce ,0x1 ,0x3 )
+    TEST_D_DDE(insert, 117, 0x7948cba3, 0x818b7ba3 ,0x70bca465 ,0x47ede909 ,0xbf4f8afe )
+    TEST_D_DDDI(insert, 118, 0x5e974875, 0x5b774875 ,0x27f33374 ,0x4b417135 ,0x7 )
+    TEST_D_DIDI(insn.t, 119, 0xcbbe860a, 0xcbbe860a ,0x4 ,0xd2f483d9 ,0x3 )
+    TEST_E_ED(ixmax, 120, 0x48ef48f1 ,0x6e7e, 0x687e48ef ,0x9afdc6c8 ,0xbd066e7e )
+    TEST_E_ED(ixmax.u, 121, 0xac97ac98 ,0xd968, 0x67b7ac96 ,0x55371874 ,0xd968399e )
+    TEST_E_ED(ixmin, 122, 0x957f9580 ,0xa9de, 0x8ed957e ,0x9519d426 ,0xa9de69e1 )
+    TEST_E_ED(ixmin.u, 123, 0xde48de4a ,0x3660, 0x3dc4de48 ,0x1e5a559d ,0xdbc53660 )
+    TEST_D_DI(lt, 124, 0x1, 0xf156e5c0 ,0x40 )
+    TEST_D_DD(lt, 125, 0x0, 0x51c83765 ,0x1aa7292 )
+    TEST_D15_DI(lt, 126, 0x0, 0x31163fc9 ,0x5 )
+    TEST_D15_DD(lt, 127, 0x1, 0xf9e43e50 ,0x22a3f8d5 )
+    TEST_D_DD(lt.b, 128, 0xff0000, 0x4a374b04 ,0x4869ba92 )
+    TEST_D_DD(lt.bu, 129, 0xff00, 0x4c5bb0c7 ,0x4c3bd2a3 )
+    TEST_D_DD(lt.h, 130, 0xffff0000, 0x326e5bdc ,0x33e03761 )
+    TEST_D_DD(lt.hu, 131, 0x0, 0xf53b8e9b ,0x53cc7810 )
+    TEST_D_DI(lt.u, 132, 0x0, 0xf1f78a54 ,0x4d )
+    TEST_D_DD(lt.u, 133, 0x1, 0x10fedada ,0x265af026 )
+    TEST_D_DD(lt.w, 134, 0xffffffff, 0xbc8a0b22 ,0x3dd6d1a2 )
+    TEST_D_DD(lt.wu, 135, 0x0, 0xcc92a312 ,0x133c8a9d )
 
     TEST_PASSFAIL
-- 
2.42.0


