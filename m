Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193BD711FBE
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QoB-00082t-Ex; Fri, 26 May 2023 02:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2Qo7-0007yk-VY
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:11 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2Qo5-0008Av-FW
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wvwDbaa8YrxTAWuX98sJ0aAQayZEqQjCW2QqYnaBvGo=; b=Jx4swuMvZpLBYrePQxGU9I7xfy
 ACkSmT0Dj9mqLmaomDLEr/axtogZrmoCSUa+EjnRCVjgHn9e9/T1D6mfachwCi+7l4Qn6RtVlEMvY
 hYJPuwdiDisI+8B6RHd5bf/GytumRDS1hMx9ty1VvFHEGE4IMwoEiI4cZ2IFKAvAjYuY=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 2/6] tests/tcg/tricore: Uses label for memory addresses
Date: Fri, 26 May 2023 08:19:42 +0200
Message-Id: <20230526061946.54514-3-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
References: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.26.60617, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.184.48.71, fs=405231, da=172691071, mc=5, sc=0,
 hc=5, sp=0, fso=405231, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

the linker might rearrange sections, so lets reference memory by label
name instead of addr + off.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/asm/macros.h     | 1 -
 tests/tcg/tricore/asm/test_ld_bu.S | 4 ++--
 tests/tcg/tricore/asm/test_ld_h.S  | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 3df2e0de82..b5087b5c97 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -25,7 +25,6 @@
 
 #define AREG_ADDR %a0
 #define AREG_CORRECT_RESULT %a3
-#define MEM_BASE_ADDR 0xd0000000
 
 #define DREG_DEV_ADDR %a15
 
diff --git a/tests/tcg/tricore/asm/test_ld_bu.S b/tests/tcg/tricore/asm/test_ld_bu.S
index ff9dac128b..4a1f40c37b 100644
--- a/tests/tcg/tricore/asm/test_ld_bu.S
+++ b/tests/tcg/tricore/asm/test_ld_bu.S
@@ -9,7 +9,7 @@ _start:
 #                            expect. addr reg val after load
 #           insn  num  expect. load value |          pattern for loading
 #             |    |     |                |              |
-    TEST_LD(ld.bu, 1, 0xff, MEM_BASE_ADDR + 4, [+AREG_ADDR]4) # pre_inc
-    TEST_LD(ld.bu, 2, 0xad, MEM_BASE_ADDR + 4, [AREG_ADDR+]4) # post_inc
+    TEST_LD(ld.bu, 1, 0xff, test_data + 4, [+AREG_ADDR]4) # pre_inc
+    TEST_LD(ld.bu, 2, 0xad, test_data + 4, [AREG_ADDR+]4) # post_inc
 
     TEST_PASSFAIL
diff --git a/tests/tcg/tricore/asm/test_ld_h.S b/tests/tcg/tricore/asm/test_ld_h.S
index d3c157a046..f5e4959198 100644
--- a/tests/tcg/tricore/asm/test_ld_h.S
+++ b/tests/tcg/tricore/asm/test_ld_h.S
@@ -7,9 +7,9 @@ test_data:
 .global _start
 _start:
 #                               expect. addr reg val after load
-#              insn  num  expect. load value |          pattern for loading
-#                |    |     |                |              |
-    TEST_LD    (ld.h, 1, 0xffffaffe, MEM_BASE_ADDR, [AREG_ADDR]2)
-    TEST_LD_SRO(ld.h, 2, 0x000022ff, MEM_BASE_ADDR, [AREG_ADDR]4)
+#              insn  num expect. load value |    pattern for loading
+#                |    |     |               |          |
+    TEST_LD    (ld.h, 1, 0xffffaffe, test_data, [AREG_ADDR]2)
+    TEST_LD_SRO(ld.h, 2, 0x000022ff, test_data, [AREG_ADDR]4)
 
     TEST_PASSFAIL
-- 
2.40.1


