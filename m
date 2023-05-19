Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A4709876
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 15:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q00J6-0006qi-UQ; Fri, 19 May 2023 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00J4-0006hV-NU
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:38:06 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00Ix-0006sj-DW
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Peb1ZR9hlOpT5CVTLrqq2nEJ9wxm4qUnfmxeZklnGAE=; b=k39HAxCPv17s2tlTFvOPzHM8Ry
 +MLPUVmyMpx5YPR2iZcJyEiXcYfeOuFzu12GIt3rhcq37Wk4gh8xwfWKLLeKdzWJhEKBWj6TckuHN
 DPbKwmxVHnhrReEVznNArqMP1uCFTNY+hE3bRx0GN6kuvyrv8l2+RJ0BLOffrbhzhNbE=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 6/6] tests/tcg/tricore: Add recursion test for CSAs
Date: Fri, 19 May 2023 15:36:50 +0200
Message-Id: <20230519133650.575600-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.19.132723, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.154.188.104, fs=36, da=172112521, mc=12, sc=0,
 hc=12, sp=0, fso=36, re=0, sd=0, hd=0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target     |  3 ++-
 tests/tcg/tricore/c/test_context_save_areas.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/tricore/c/test_context_save_areas.c

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index 5d282e0dda..19bec44531 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -4,7 +4,7 @@ C_TESTS_PATH = $(TESTS_PATH)/c
 
 LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
 ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c
+CFLAGS = -mtc162 -c -I$(TESTS_PATH)
 
 TESTS += test_abs.asm.tst
 TESTS += test_bmerge.asm.tst
@@ -23,6 +23,7 @@ TESTS += test_msub.asm.tst
 TESTS += test_muls.asm.tst
 
 TESTS += test_boot_to_main.c.tst
+TESTS += test_context_save_areas.c.tst
 
 QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
diff --git a/tests/tcg/tricore/c/test_context_save_areas.c b/tests/tcg/tricore/c/test_context_save_areas.c
new file mode 100644
index 0000000000..a300ee2f9c
--- /dev/null
+++ b/tests/tcg/tricore/c/test_context_save_areas.c
@@ -0,0 +1,15 @@
+#include "testdev_assert.h"
+
+static int fib(int n)
+{
+    if (n == 1 || n == 2) {
+        return 1;
+    }
+    return fib(n - 2) + fib(n - 1);
+}
+
+int main(int argc, char **argv)
+{
+    testdev_assert(fib(10) == 55);
+    return 0;
+}
-- 
2.40.1


