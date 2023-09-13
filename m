Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8760E79E56C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVI-0007cW-Oh; Wed, 13 Sep 2023 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVG-0007bj-2X
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:50 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVC-0006PP-MX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QfQ/IQgEpuKNF1XoYo8fvmA/nwkfLOiwBnUFXRAmCBI=; b=EfQzPUzhrag1Bf+YwZUeM30dG0
 thG6j5Q1AHhsGAy66Y3AFXMFq6AykSFQIZVybxUj7jLHKFhk4nSAHiPnP5GuWSPrLI6n/4MB42N5o
 Jp/uP8H3dvujCK04ZLgWWl2mgq6+GapiBX3ha4aJfCr6GkMotvjpCxGoI9WHlndB1q1c=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 03/10] tests/tcg: Reset result register after each test
Date: Wed, 13 Sep 2023 12:53:19 +0200
Message-ID: <20230913105326.40832-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=7, da=182211484, mc=6, sc=0, hc=6,
 sp=0, fso=7, re=0, sd=0, hd=0
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

some insns use the result register implicitly as an input. Thus, we
could end up with data from the previous insn spilling over.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/asm/macros.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index 0f349dbf1e..e831f73721 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -46,7 +46,8 @@ test_ ## num:                                     \
     code;                                         \
     LI(DREG_CORRECT_RESULT, correct)              \
     mov DREG_TEST_NUM, num;                       \
-    jne testreg, DREG_CORRECT_RESULT, fail        \
+    jne testreg, DREG_CORRECT_RESULT, fail;       \
+    mov testreg, 0
 
 #define TEST_CASE_E(num, correct_lo, correct_hi, code...)  \
 test_ ## num:                                              \
-- 
2.42.0


