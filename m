Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBA79E561
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVn-0007jX-Mb; Wed, 13 Sep 2023 06:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVX-0007hD-5e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:54:07 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVJ-0006Rc-1o
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JTmRHONtB8mGV3fc8kZycZesdJS6akX+80THiytp6MQ=; b=tEHA+fdqq7DT7fwSgc9dtEMtXQ
 GE5zQDlfE1qJ64lqN71ndOxf3GqPHc8+m8Pt3MPWbmPJGifAeBLuoHhHO6UgRCQKJEgMhNZC5OpJ2
 CEYoJfyRYSiUYjvL8mzsSocVI1Y+OJIIWwPKSJhthN2gi0Ls+tsspqgmZ5mjMWSIAzW4=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 08/10] tests/tcg/tricore: Add test from 'shuffle' to 'xor.t'
Date: Wed, 13 Sep 2023 12:53:24 +0200
Message-ID: <20230913105326.40832-9-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=17, da=182211494, mc=16, sc=0,
 hc=16, sp=0, fso=17, re=0, sd=0, hd=0
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
 tests/tcg/tricore/asm/test_arith.S | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/tcg/tricore/asm/test_arith.S b/tests/tcg/tricore/asm/test_arith.S
index 728509cfa9..02637f89f9 100644
--- a/tests/tcg/tricore/asm/test_arith.S
+++ b/tests/tcg/tricore/asm/test_arith.S
@@ -242,5 +242,39 @@ _start:
     TEST_D_DD(sha.h, 238, 0x10006000, 0x84010b96 ,0xc20875ac )
     TEST_D_DI(shas, 239, 0x7fffffff, 0x539952ab ,0x1f )
     TEST_D_DD(shas, 240, 0x20b5a5, 0x416b4be8 ,0x11eb83b7 )
+    TEST_D_DI(shuffle, 241, 0xed28c9ed, 0x28e9edc9 ,0x71 )
+    TEST_D_DD(sub, 242, 0x3806b676, 0x56f5e4bc ,0x1eef2e46 )
+    TEST_D_D(sub, 243, 0xc98e16b7, 0x3671e949 )
+    TEST_D_D15D(sub, 244, 0xf5bbbabd, 0x6a8db6c ,0x10ed20af )
+    TEST_D15_DD(sub, 245, 0x5618f5a0, 0xa6342636 ,0x501b3096 )
+    TEST_D_DD(sub.b, 246, 0x9ced6d25, 0x28dbb9ee ,0x8cee4cc9 )
+    TEST_D_DD(sub.h, 247, 0xc80b12d0, 0xbe0897d3 ,0xf5fd8503 )
+    TEST_D_DD(subc, 248, 0xbeeccedb, 0x2164d45a ,0x6278057e )
+    TEST_D_DD(subs, 249, 0x90d370bc, 0x95060d13 ,0x4329c57 )
+    TEST_D_D(subs, 250, 0xd89c4149, 0x2763beb7 )
+    TEST_D_DD(subs.h, 251, 0xad93dfea, 0x2c97e0d1 ,0x7f0400e7 )
+    TEST_D_DD(subs.hu, 252, 0x33f6, 0xa768372d ,0xc80b0337 )
+    TEST_D_DD(subs.u, 253, 0x0, 0x7084c694 ,0x90c2f594 )
+    TEST_D_DD(subx, 254, 0xd19a2948, 0x7c40dcf9 ,0xaaa6b3b1 )
+    TEST_E_D(unpack, 255, 0x6405b000 ,0xffffffa5, 0x12480b60 )
+    TEST_D_DI(xnor, 256, 0x83b45e8d, 0x7c4ba167 ,0x15 )
+    TEST_D_DD(xnor, 257, 0x6808b995, 0x2fdb8402 ,0xb82cc268 )
+    TEST_D_DIDI(xnor.t, 258, 0x1, 0x490ac395 ,0x6 ,0x6c41105b ,0x6 )
+    TEST_D_DI(xor, 259, 0x2f27c804, 0x2f27c860 ,0x64 )
+    TEST_D_DD(xor, 260, 0xa020af5b, 0x67f62bea ,0xc7d684b1 )
+    TEST_D_D(xor, 261, 0xbc28874, 0xbc28874 )
+    TEST_D_DI(xor.eq, 262, 0x0, 0xee9e03cc ,0x7b )
+    TEST_D_DD(xor.eq, 263, 0x0, 0x74f79928 ,0x2d3ec476 )
+    TEST_D_DI(xor.ge, 264, 0x0, 0xcf2296f1 ,0xf0 )
+    TEST_D_DD(xor.ge, 265, 0x0, 0xf9915543 ,0x20cb6ab7 )
+    TEST_D_DI(xor.ge.u, 266, 0x1, 0xaa8a78f6 ,0xce )
+    TEST_D_DD(xor.ge.u, 267, 0x0, 0x94e9f87 ,0xab43f3ce )
+    TEST_D_DI(xor.lt, 268, 0x0, 0x3412e315 ,0xcb )
+    TEST_D_DD(xor.lt, 269, 0x1, 0x5571b703 ,0x6a9008a3 )
+    TEST_D_DI(xor.lt.u, 270, 0x0, 0x66a0a3c0 ,0xe1 )
+    TEST_D_DD(xor.lt.u, 271, 0x0, 0xa66deb02 ,0x7dd7b425 )
+    TEST_D_DI(xor.ne, 272, 0x1, 0x147b3e3a ,0xfa )
+    TEST_D_DD(xor.ne, 273, 0x1, 0x92147ec0 ,0xa697f601 )
+    TEST_D_DIDI(xor.t, 274, 0x0, 0xed9ea075 ,0x7 ,0x13f5d03c ,0x7 )
 
     TEST_PASSFAIL
-- 
2.42.0


