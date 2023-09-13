Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D979E562
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVK-0007dG-EM; Wed, 13 Sep 2023 06:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVG-0007bl-6l
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:50 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVC-0006OX-NP
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JA/jaHD1OimTEX0NYZbiPC9BNWNP5BAEeUYIDSJTSaI=; b=plp1t1x3Fiab76Rmsg+WRYBT57
 l7YX6+qIs9Zti4uo3e5AyhtLMlUTNWZshpf1ohmT83LjlsDXvU5OBSgER4xgbzallgGNTeFZXm8ew
 /FVgbnIAn4d9mYLdZLQDw5SGQjwlHfUUU/wdhOn8qtXI4qG1Oq8C7g7MsyYO3e7iy2HA=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 01/10] tests/tcg/tricore: Extended and non-extened regs now
 match
Date: Wed, 13 Sep 2023 12:53:17 +0200
Message-ID: <20230913105326.40832-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=2, da=182211479, mc=2, sc=0, hc=2,
 sp=0, fso=2, re=0, sd=0, hd=0
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

RSx for d regs and e regs now use the same numbering. This makes sure
that mixing d and e registers in an insn test will not overwrite data
between registers.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/asm/macros.h | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 17e696bef5..0f349dbf1e 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -12,31 +12,31 @@
 #define TESTDEV_ADDR 0xf0000000
 /* Register definitions */
 #define DREG_RS1 %d0
-#define DREG_RS2 %d1
-#define DREG_RS3 %d2
-#define DREG_CALC_RESULT %d3
-#define DREG_CALC_PSW %d4
-#define DREG_CORRECT_PSW %d5
-#define DREG_TEMP_LI %d10
-#define DREG_TEMP %d11
-#define DREG_TEST_NUM %d14
-#define DREG_CORRECT_RESULT %d15
-#define DREG_CORRECT_RESULT_2 %d13
+#define DREG_RS2 %d2
+#define DREG_RS3 %d4
+#define DREG_CALC_RESULT %d5
+#define DREG_CALC_PSW %d6
+#define DREG_CORRECT_PSW %d7
+#define DREG_TEMP_LI %d13
+#define DREG_TEMP %d14
+#define DREG_TEST_NUM %d8
+#define DREG_CORRECT_RESULT %d9
+#define DREG_CORRECT_RESULT_2 %d10
 
 #define AREG_ADDR %a0
 #define AREG_CORRECT_RESULT %a3
 
 #define DREG_DEV_ADDR %a15
 
-#define EREG_RS1 %e6
-#define EREG_RS1_LO %d6
-#define EREG_RS1_HI %d7
-#define EREG_RS2 %e8
-#define EREG_RS2_LO %d8
-#define EREG_RS2_HI %d9
-#define EREG_CALC_RESULT %e8
-#define EREG_CALC_RESULT_HI %d9
-#define EREG_CALC_RESULT_LO %d8
+#define EREG_RS1 %e0
+#define EREG_RS1_LO %d0
+#define EREG_RS1_HI %d1
+#define EREG_RS2 %e2
+#define EREG_RS2_LO %d2
+#define EREG_RS2_HI %d3
+#define EREG_CALC_RESULT %e6
+#define EREG_CALC_RESULT_LO %d6
+#define EREG_CALC_RESULT_HI %d7
 #define EREG_CORRECT_RESULT_LO %d0
 #define EREG_CORRECT_RESULT_HI %d1
 
-- 
2.42.0


