Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C6879E564
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVT-0007gR-1Y; Wed, 13 Sep 2023 06:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVG-0007br-92
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:50 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVC-0006Pr-Lt
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dqwCAOtPvJ9gF/Ymjs1qOqGF8CY2z7YYHyI/eZmKqBs=; b=ua0xqT6KS+y7lHHzmrAxZKeSft
 zFueayKhTNED5qtmPz3EDzfDH9dGbI1Hfo96q0tSvJYAoAmztjLAhNfStwKuTrp+y5tDndO9JhGmH
 lDc9csYzJ3r02uKvn2QTBZ3ZprzEPzVAE9pkvBYx7Rct5ApPhFIhBpAI3Zp9KZ2r9AW8=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 05/10] tests/tcg/tricore: Add test for and to csub
Date: Wed, 13 Sep 2023 12:53:21 +0200
Message-ID: <20230913105326.40832-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=10, da=182211487, mc=10, sc=0,
 hc=10, sp=0, fso=10, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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
 tests/tcg/tricore/asm/macros.h     | 11 +++++++
 tests/tcg/tricore/asm/test_arith.S | 47 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 8ed2249b0d..3000e15590 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -117,6 +117,11 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, imm;               \
     )
 
+#define TEST_D15_I(insn, num, result, imm)      \
+    TEST_CASE(num, %d15, result,  \
+    insn %d15, imm;               \
+    )
+
 #define TEST_D_DDD(insn, num, result, rs1, rs2, rs3)        \
     TEST_CASE(num, DREG_CALC_RESULT, result,                \
     LI(DREG_RS1, rs1);                                      \
@@ -236,6 +241,12 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, imm1, imm2, imm3;       \
     )
 
+#define TEST_E_D(insn, num, res_lo, res_hi, rs1) \
+    TEST_CASE_E(num, res_lo, res_hi,             \
+    LI(DREG_RS1, rs1);                           \
+    insn EREG_CALC_RESULT, DREG_RS1;             \
+    )
+
 #define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
     TEST_CASE_E(num, res_lo, res_hi,                              \
     LI(EREG_RS1_LO, rs1_lo);                                      \
diff --git a/tests/tcg/tricore/asm/test_arith.S b/tests/tcg/tricore/asm/test_arith.S
index 07c4b876e9..ec87413777 100644
--- a/tests/tcg/tricore/asm/test_arith.S
+++ b/tests/tcg/tricore/asm/test_arith.S
@@ -37,5 +37,52 @@ _start:
     TEST_D_DD(adds.u, 33, 0xffffffff, 0xd4a91e39 ,0x55b1baed )
     TEST_D_DI(addx, 34, 0x38f63b5, 0x38f632b ,0x8a )
     TEST_D_DD(addx, 35, 0x8b9da5a4, 0x16e32e7 ,0x8a2f72bd )
+    TEST_D_DI(and, 36, 0x1, 0xf9683907 ,0x69 )
+    TEST_D_DD(and, 37, 0x40102090, 0x48d86c91 ,0x511123d0 )
+    TEST_D15_I(and, 38, 0x0, 0x1a )
+    TEST_D_D(and, 39, 0x0, 0x551343d6 )
+    TEST_D_DIDI(and.and.t, 40, 0x0, 0x60343d14 ,0x4 ,0x922020d8 ,0x3 )
+    TEST_D_DIDI(and.andn.t, 41, 0x0, 0xd4f95dad ,0x5 ,0xb9fff576 ,0x3 )
+    TEST_D_DI(and.eq, 42, 0x0, 0x9945aaf ,0xf )
+    TEST_D_DD(and.eq, 43, 0x0, 0x32a94b38 ,0xf53b9463 )
+    TEST_D_DI(and.ge, 44, 0x0, 0xe66d0f6e ,0x55 )
+    TEST_D_DD(and.ge, 45, 0x0, 0x43ea87d0 ,0x5adacf4d )
+    TEST_D_DI(and.ge.u, 46, 0x0, 0x4bef5bd1 ,0xb3 )
+    TEST_D_DD(and.ge.u, 47, 0x0, 0x9b5504c2 ,0x3787f19 )
+    TEST_D_DI(and.lt, 48, 0x0, 0x36daf216 ,0xc8 )
+    TEST_D_DD(and.lt, 49, 0x0, 0x6bf175f7 ,0x769bc7db )
+    TEST_D_DI(and.lt.u, 50, 0x0, 0xbef4b04a ,0x1d )
+    TEST_D_DD(and.lt.u, 51, 0x0, 0xa89ea455 ,0x84dc9898 )
+    TEST_D_DI(and.ne, 52, 0x0, 0xf3bb3559 ,0x5e )
+    TEST_D_DD(and.ne, 53, 0x0, 0xa05258eb ,0x50c5b0e4 )
+    TEST_D_DIDI(and.nor.t, 54, 0x0, 0xd7534767 ,0x1 ,0x5fac529f ,0x6 )
+    TEST_D_DIDI(and.or.t, 55, 0x0, 0xa3dd1690 ,0x7 ,0xe25f7361 ,0x4 )
+    TEST_D_DIDI(and.t, 56, 0x0, 0x9f6f71d5 ,0x1 ,0xe9dfe144 ,0x2 )
+    TEST_D_DI(andn, 57, 0xb2ed0c01, 0xb2ed0cf1 ,0xfc )
+    TEST_D_DD(andn, 58, 0x102d884, 0x494ad98c ,0xf87d077a )
+    TEST_D_DIDI(andn.t, 59, 0x0, 0x24ef957a ,0x5 ,0xaf95e01e ,0x4 )
+    TEST_D_DD(bmerge, 60, 0xbfe56f84, 0x2a0fc78 ,0xf7127bb2 )
+    TEST_E_D(bsplit, 61, 0x1ae2, 0xef60, 0xa9ee7c04 )
+    TEST_D_DDI(cadd, 62, 0x3ac01dec, 0x7770d9a ,0x3ac01d3d ,0xaf )
+    TEST_D_DDD(cadd, 63, 0x48a771b4, 0xdf020dda ,0xb81cdead ,0x908a9307 )
+    TEST_D_D15I(cadd, 64, 0x4, 0x6a766c11 ,0x4 )
+    TEST_D_DDI(caddn, 65, 0xdc0cd85d, 0xfe1fbf45 ,0xdc0cd85d ,0x1c )
+    TEST_D_DDD(caddn, 66, 0xd7bd5cb5, 0x70a930bd ,0xd7bd5cb5 ,0xb5dce80d )
+    TEST_D_D15I(caddn, 67, 0x0, 0xb6051252 ,0x4 )
+    TEST_D_D(clo, 68, 0x1, 0xa15f7ebc )
+    TEST_D_D(clo.h, 69, 0x0, 0x2bf418ef )
+    TEST_D_D(cls, 70, 0x1, 0xcbda5b50 )
+    TEST_D_D(cls.h, 71, 0x10001, 0xd15ac540 )
+    TEST_D_D(clz, 72, 0x1, 0x62ddf743 )
+    TEST_D_D(clz.h, 73, 0x0, 0xa859df54 )
+    TEST_D_D15I(cmov, 74, 0x5, 0x7d06b438 ,0x5 )
+    TEST_D_D15D(cmov, 75, 0x4d24e162, 0xd07651a5 ,0x4d24e162 )
+    TEST_D_D15I(cmovn, 76, 0x0, 0xea576d5 ,0x6 )
+    TEST_D_D15D(cmovn, 77, 0x0, 0x6a1d2b48 ,0xb28bc831 )
+    TEST_D_DD(crc32.b, 78, 0x3baca290, 0xcde828a2 ,0x869b2ea4 )
+    TEST_D_DD(crc32b.w, 79, 0x7f9d8908, 0xdaf396a5 ,0xa9011cf2 )
+    TEST_D_DD(crc32l.w, 80, 0x1707579b, 0x87572060 ,0x8cdfa395 )
+    TEST_D_DDD(csub, 81, 0xf389f12f, 0xae9c7e04 ,0x63247211 ,0x6f9a80e2 )
+    TEST_D_DDD(csubn, 82, 0x2a7dd20d, 0xc39caf46 ,0x2a7dd20d ,0xa8ab6269 )
 
     TEST_PASSFAIL
-- 
2.42.0


