Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F6711FC5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QpR-0000Xq-7d; Fri, 26 May 2023 02:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2Qod-0000I8-IS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:45 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q2QoT-0008TU-6Y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6dS65BHceE/gk9tf87DHKXirrrBzDS/IfWiY+wR9vZ0=; b=L202/95f69L8Y32nI0s46NnUoy
 4W61AlAFVsShqT9Ee6Qnxs9kiCQB06Op2MydQvJLGVmXhzdYWPlNpu6oo5/bESfcek48XbEEiVRx0
 +5LZUFicrs4KDmBPEJsv5hKq3a8tFkD90LkS0ukplXORBAYbMSMaDLqmguXZctQACI00=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH v2 6/6] tests/tcg/tricore: Add recursion test for CSAs
Date: Fri, 26 May 2023 08:19:46 +0200
Message-Id: <20230526061946.54514-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
References: <20230526061946.54514-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.26.61217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.184.48.71, fs=405255, da=172691095, mc=13, sc=0,
 hc=13, sp=0, fso=405255, re=0, sd=0, hd=0
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target     |  3 ++-
 tests/tcg/tricore/c/test_context_save_areas.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/tricore/c/test_context_save_areas.c

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index f051444991..aff7c1b580 100644
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


