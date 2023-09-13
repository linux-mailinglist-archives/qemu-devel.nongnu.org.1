Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D879E56A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVO-0007f8-RO; Wed, 13 Sep 2023 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVI-0007cl-O5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:53 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVG-0006Qp-4X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+YKoijfKIss+Dz9laxsX8YfPM3ZaxOdKriNCqkkdhQ=; b=gs9xNd5aopVilVMASGhfBZY9J3
 1FasR1qCRoejDprktp1fuEdmzGFEkA4gGqmzsFmV3K8PnXBW5u2MFU7Ukw51BGUolkHkOvDoBakaZ
 +fY3cUiq5PUKlElvRzfr0xoI7NHCcBPo2IGg8iTaRWgOFkD9N/b1w/XZXWocPK9Yk9HM=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 07/10] tests/tcg/tricore: Add test from 'max' to 'shas'
Date: Wed, 13 Sep 2023 12:53:23 +0200
Message-ID: <20230913105326.40832-8-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=15, da=182211492, mc=14, sc=0,
 hc=14, sp=0, fso=15, re=0, sd=0, hd=0
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
 tests/tcg/tricore/asm/macros.h     |  13 ++++
 tests/tcg/tricore/asm/test_arith.S | 105 +++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 92f0f7b22b..5bba9dbbf6 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -143,6 +143,14 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, DREG_RS3, imm; \
     )
 
+#define TEST_D_ED(insn, num, result, rs1_lo, rs1_hi, rs2) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,              \
+    LI(EREG_RS1_LO, rs1_lo);                              \
+    LI(EREG_RS1_HI, rs1_hi);                              \
+    LI(DREG_RS2, rs2);                                    \
+    rstv;                                                 \
+    insn DREG_CALC_RESULT, EREG_RS1, DREG_RS2;            \
+    )
 
 #define TEST_D_DDE(insn, num, result, rs1, rs2, rs3_lo, rs3_hi) \
     TEST_CASE(num, DREG_CALC_RESULT, result,                    \
@@ -284,6 +292,11 @@ test_ ## num:                                                    \
     insn EREG_CALC_RESULT, EREG_RS1, DREG_RS2;                    \
     )
 
+#define TEST_E_I(insn, num, res_lo, res_hi, imm) \
+    TEST_CASE_E(num, res_lo, res_hi,             \
+    insn EREG_CALC_RESULT, imm;                  \
+    )
+
 #define TEST_E_IDI(insn, num, res_lo, res_hi, imm1, rs1, imm2) \
     TEST_CASE_E(num, res_lo, res_hi,                           \
     LI(DREG_RS1, rs1);                                         \
diff --git a/tests/tcg/tricore/asm/test_arith.S b/tests/tcg/tricore/asm/test_arith.S
index 68b6715cb9..728509cfa9 100644
--- a/tests/tcg/tricore/asm/test_arith.S
+++ b/tests/tcg/tricore/asm/test_arith.S
@@ -137,5 +137,110 @@ _start:
     TEST_D_DD(lt.u, 133, 0x1, 0x10fedada ,0x265af026 )
     TEST_D_DD(lt.w, 134, 0xffffffff, 0xbc8a0b22 ,0x3dd6d1a2 )
     TEST_D_DD(lt.wu, 135, 0x0, 0xcc92a312 ,0x133c8a9d )
+    TEST_D_DI(max, 136, 0xe0d4d31, 0xe0d4d31 ,0x58 )
+    TEST_D_DD(max, 137, 0x787135d1, 0x787135d1 ,0x14c4da7b )
+    TEST_D_DD(max.b, 138, 0x316b2c0f, 0x316bd4cb ,0x2b2c0f )
+    TEST_D_DD(max.bu, 139, 0x5f88a94e, 0x4675a04e ,0x5f88a92b )
+    TEST_D_DD(max.h, 140, 0x532f72fd, 0x532fad08 ,0x4b1272fd )
+    TEST_D_DD(max.hu, 141, 0xeed88225, 0x116b7eea ,0xeed88225 )
+    TEST_D_DI(max.u, 142, 0xf342d496, 0xf342d496 ,0x38 )
+    TEST_D_DD(max.u, 143, 0xdd15066d, 0xdd15066d ,0xf556c66 )
+    TEST_D_DI(min, 144, 0xdd, 0x731a9dec ,0xdd )
+    TEST_D_DD(min, 145, 0x23ed2038, 0x2e3f1040 ,0x23ed2038 )
+    TEST_D_DD(min.b, 146, 0xf1aba6b6, 0x26aba6b6 ,0xf17eb628 )
+    TEST_D_DD(min.bu, 147, 0x3f500949, 0x8a500c52 ,0x3fe70949 )
+    TEST_D_DD(min.h, 148, 0xad296b7, 0xe917617 ,0xad296b7 )
+    TEST_D_DD(min.hu, 149, 0x859351e, 0xc6a351e ,0x8595c29 )
+    TEST_D_DI(min.u, 150, 0x3, 0x8e14bfbf ,0x3 )
+    TEST_D_DD(min.u, 151, 0x371cf628, 0x371cf628 ,0xe837ca8f )
+    TEST_D_I(mov, 152, 0x391, 0x391 )
+    TEST_E_I(mov, 153, 0x4612 ,0x0, 0x4612 )
+    TEST_D_D(mov, 154, 0x57de4d85, 0x57de4d85 )
+    TEST_E_D(mov, 155, 0x81fcfe47 ,0xffffffff, 0x81fcfe47 )
+    TEST_E_DD(mov, 156, 0xa33b7b80 ,0x8a2a74b7, 0x8a2a74b7 ,0xa33b7b80 )
+    TEST_D15_I(mov, 157, 0x3b, 0x3b )
+    TEST_D_I(mov, 158, 0x2, 0x2 )
+    TEST_E_I(mov, 159, 0x1 ,0x0, 0x1 )
+    TEST_D_D(mov, 160, 0x1557688b, 0x1557688b )
+    TEST_D_I(mov.u, 161, 0x502, 0x502 )
+    TEST_D_I(movh, 162, 0x60ea0000, 0x60ea)
+    TEST_D_DI(nand, 163, 0xfffffffe, 0x291af609 ,0xd7 )
+    TEST_D_DD(nand, 164, 0xfaffe4fe, 0x270e5faf ,0xcd613b01 )
+    TEST_D_DIDI(nand.t, 165, 0x1, 0xe10d5151 ,0x1 ,0x84f18d6b ,0x7 )
+    TEST_D_DI(ne, 166, 0x1, 0xed148b6 ,0x66 )
+    TEST_D_DD(ne, 167, 0x1, 0x9b38284a ,0x25948edd )
+    TEST_D_DI(nor, 168, 0x77f45c1a, 0x880ba324 ,0xe5 )
+    TEST_D_DD(nor, 169, 0x2c8103c0, 0x93382c3f ,0x5266d42b )
+    TEST_D_DIDI(nor.t, 170, 0x1, 0x3f964a10 ,0x7 ,0x54e26b8e ,0x3 )
+    TEST_D_DI(or, 171, 0xbf29afdf, 0xbf29afd3 ,0x4e )
+    TEST_D_DD(or, 172, 0xfbefe7cf, 0x2a896747 ,0xdb66a2ce )
+    TEST_D15_I(or, 173, 0xb, 0xb )
+    TEST_D_D(or, 174, 0x3ef404a0, 0x3ef404a0 )
+    TEST_D_DIDI(or.and.t, 175, 0x1, 0x1e09424a ,0x3 ,0xe427b416 ,0x3 )
+    TEST_D_DIDI(or.andn.t, 176, 0x0, 0x4a560efb ,0x1 ,0xf0596f84 ,0x3 )
+    TEST_D_DI(or.eq, 177, 0x0, 0xee8c7017 ,0xcf )
+    TEST_D_DD(or.eq, 178, 0x0, 0xc33e8cf0 ,0x139c3f75 )
+    TEST_D_DI(or.ge, 179, 0x1, 0x4845ad04 ,0xf1 )
+    TEST_D_DD(or.ge, 180, 0x1, 0x687040a1 ,0xf61bdd8c )
+    TEST_D_DI(or.ge.u, 181, 0x1, 0x55edca06 ,0xa1 )
+    TEST_D_DD(or.ge.u, 182, 0x0, 0x8c975e46 ,0xd26c95ea )
+    TEST_D_DI(or.lt, 183, 0x1, 0xbcb87506 ,0x43 )
+    TEST_D_DD(or.lt, 184, 0x0, 0x2c9ea431 ,0x1d1515 )
+    TEST_D_DI(or.lt.u, 185, 0x0, 0x7bbfdf3b ,0xe7 )
+    TEST_D_DD(or.lt.u, 186, 0x1, 0x2f71485e ,0xe9219409 )
+    TEST_D_DI(or.ne, 187, 0x1, 0xc9b87ffc ,0x65 )
+    TEST_D_DD(or.ne, 188, 0x1, 0xd5746862 ,0x72d5cbc1 )
+    TEST_D_DIDI(or.nor.t, 189, 0x0, 0xa0d6cc1 ,0x7 ,0x38e6fc83 ,0x1 )
+    TEST_D_DIDI(or.or.t, 190, 0x1, 0x85546ea7 ,0x4 ,0xffd58bc6 ,0x2 )
+    TEST_D_DIDI(or.t, 191, 0x0, 0xd594ef27 ,0x3 ,0xdb878237 ,0x4 )
+    TEST_D_DI(orn, 192, 0xffffffdf, 0xc8b4cb5d ,0x64 )
+    TEST_D_DD(orn, 193, 0xf2ffd5eb, 0xe2ef556a ,0xaf6d3a3e )
+    TEST_D_DIDI(orn.t, 194, 0x1, 0xb511c09 ,0x3 ,0x209bbd86 ,0x7 )
+    TEST_D_ED(pack, 195, 0x803d04a8, 0x3d04a871 ,0x50637a2d ,0x86ec2f85 )
+    TEST_D_D(parity, 196, 0x101, 0x6033fd4c )
+    TEST_D_D(popcnt.w, 197, 0x15, 0xed7dcbc6 )
+    TEST_D_DI(rsub, 198, 0x4ee91cd3, 0xb116e3bc ,0x8f )
+    TEST_D_DI(rsubs, 199, 0x923eddd7, 0x6dc122fb ,0xd2 )
+    TEST_D_DI(rsubs.u, 200, 0x0, 0xeea32363 ,0xae )
+    TEST_D_D(sat.b, 201, 0xffffff80, 0x9933174e )
+    TEST_D_D(sat.bu, 202, 0xff, 0x917808d7 )
+    TEST_D_D(sat.h, 203, 0xffff8000, 0xa6d33749 )
+    TEST_D_D(sat.hu, 204, 0xffff, 0x534af788 )
+    TEST_D_DDI(sel, 205, 0x620aac73, 0xf617d4dc ,0x620aac73 ,0x53 )
+    TEST_D_DDD(sel, 206, 0x133a028, 0xb8a3faae ,0x133a028 ,0x9042e62e )
+    TEST_D_DDI(seln, 207, 0x8, 0x4a449741 ,0x5354950a ,0x8 )
+    TEST_D_DDD(seln, 208, 0x4f8b1cda, 0x9e3173c3 ,0x4a6f65e9 ,0x4f8b1cda )
+    TEST_D_DI(sh, 209, 0x97000000, 0x56ffbcb8 ,0xd5 )
+    TEST_D_DD(sh, 210, 0x225, 0x112c2fff ,0x5f7f64ad )
+    TEST_D_I(sh, 211, 0x0, 0x6 )
+    TEST_D_DIDI(sh.and.t, 212, 0x1, 0xfba22cf9 ,0x5 ,0xfda859c ,0x6 )
+    TEST_D_DIDI(sh.andn.t, 213, 0x1, 0xf22e1491 ,0x7 ,0x23ac3c36 ,0x3 )
+    TEST_D_DI(sh.eq, 214, 0x0, 0xda3960 ,0x9d )
+    TEST_D_DD(sh.eq, 215, 0x0, 0xf76d811e ,0x6eaa1a5e )
+    TEST_D_DI(sh.ge, 216, 0x0, 0xbb006b34 ,0x4 )
+    TEST_D_DD(sh.ge, 217, 0x0, 0xee02bc23 ,0xdaf2111 )
+    TEST_D_DI(sh.ge.u, 218, 0x1, 0xc8909dce ,0x53 )
+    TEST_D_DD(sh.ge.u, 219, 0x1, 0x5ebe1b63 ,0x2c380da6 )
+    TEST_D_DI(sh.h, 220, 0x32002d00, 0x6032a92d ,0xc8 )
+    TEST_D_DD(sh.h, 221, 0x780878, 0xc00fc10f ,0x670e07a3 )
+    TEST_D_DI(sh.lt, 222, 0x1, 0xd55620a0 ,0x28 )
+    TEST_D_DD(sh.lt, 223, 0x1, 0xbab4c4f8 ,0xd6b23303 )
+    TEST_D_DI(sh.lt.u, 224, 0x0, 0x6d1e8ad ,0xbb )
+    TEST_D_DD(sh.lt.u, 225, 0x1, 0xbdc4998 ,0x660a4b5f )
+    TEST_D_DIDI(sh.nand.t, 226, 0x1, 0xfb3bb8d0 ,0x3 ,0x237800c5 ,0x3 )
+    TEST_D_DI(sh.ne, 227, 0x1, 0x5e6bff56 ,0x83 )
+    TEST_D_DD(sh.ne, 228, 0x1, 0x5f53e44b ,0x4aaa9437 )
+    TEST_D_DIDI(sh.nor.t, 229, 0x0, 0x6ee37832 ,0x6 ,0x6296e652 ,0x5 )
+    TEST_D_DIDI(sh.or.t, 230, 0x1, 0xc6079a4e ,0x6 ,0xa81b155a ,0x1 )
+    TEST_D_DIDI(sh.orn.t, 231, 0x1, 0x188eb9ff ,0x6 ,0x35916e9 ,0x2 )
+    TEST_D_DIDI(sh.xnor.t, 232, 0x1, 0x4babd924 ,0x1 ,0x6f28e657 ,0x6 )
+    TEST_D_DIDI(sh.xor.t, 233, 0x0, 0x759dfc75 ,0x3 ,0xac541f56 ,0x3 )
+    TEST_D_DI(sha, 234, 0xb69145c0, 0x62da4517 ,0x46 )
+    TEST_D_DD(sha, 235, 0xccd8e400, 0x25333639 ,0xb4e65a0a )
+    TEST_D_I(sha, 236, 0x0, 0x5 )
+    TEST_D_DI(sha.h, 237, 0xf8404f80, 0x8fe1d53e ,0x6 )
+    TEST_D_DD(sha.h, 238, 0x10006000, 0x84010b96 ,0xc20875ac )
+    TEST_D_DI(shas, 239, 0x7fffffff, 0x539952ab ,0x1f )
+    TEST_D_DD(shas, 240, 0x20b5a5, 0x416b4be8 ,0x11eb83b7 )
 
     TEST_PASSFAIL
-- 
2.42.0


