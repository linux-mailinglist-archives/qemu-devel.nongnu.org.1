Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67973EAFD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrRs-0004Hb-RB; Mon, 26 Jun 2023 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrRJ-00027X-TS; Mon, 26 Jun 2023 14:59:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrRH-0007BY-0N; Mon, 26 Jun 2023 14:59:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D213EFB0;
 Mon, 26 Jun 2023 21:59:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 22EB9F7EC;
 Mon, 26 Jun 2023 21:59:08 +0300 (MSK)
Received: (nullmailer pid 1575321 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 15/43] tests/tcg/s390x: Test LCBB
Date: Mon, 26 Jun 2023 21:58:33 +0300
Message-Id: <20230626185902.1575177-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230526181240.1425579-3-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 05d000fb4dcac4bc02ffa08fcf14b51683b878f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 07fcc6d0ce..24576fda22 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -26,6 +26,7 @@ TESTS+=branch-relative-long
 TESTS+=noexec
 
 Z13_TESTS=vistr
+Z13_TESTS+=lcbb
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/lcbb.c b/tests/tcg/s390x/lcbb.c
new file mode 100644
index 0000000000..8d368e0998
--- /dev/null
+++ b/tests/tcg/s390x/lcbb.c
@@ -0,0 +1,51 @@
+/*
+ * Test the LCBB instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static inline __attribute__((__always_inline__)) void
+lcbb(long *r1, void *dxb2, int m3, int *cc)
+{
+    asm("lcbb %[r1],%[dxb2],%[m3]\n"
+        "ipm %[cc]"
+        : [r1] "+r" (*r1), [cc] "=r" (*cc)
+        : [dxb2] "R" (*(char *)dxb2), [m3] "i" (m3)
+        : "cc");
+    *cc = (*cc >> 28) & 3;
+}
+
+static char buf[0x1000] __attribute__((aligned(0x1000)));
+
+static inline __attribute__((__always_inline__)) void
+test_lcbb(void *p, int m3, int exp_r1, int exp_cc)
+{
+    long r1 = 0xfedcba9876543210;
+    int cc;
+
+    lcbb(&r1, p, m3, &cc);
+    assert(r1 == (0xfedcba9800000000 | exp_r1));
+    assert(cc == exp_cc);
+}
+
+int main(void)
+{
+    test_lcbb(&buf[0],    0, 16, 0);
+    test_lcbb(&buf[63],   0,  1, 3);
+    test_lcbb(&buf[0],    1, 16, 0);
+    test_lcbb(&buf[127],  1,  1, 3);
+    test_lcbb(&buf[0],    2, 16, 0);
+    test_lcbb(&buf[255],  2,  1, 3);
+    test_lcbb(&buf[0],    3, 16, 0);
+    test_lcbb(&buf[511],  3,  1, 3);
+    test_lcbb(&buf[0],    4, 16, 0);
+    test_lcbb(&buf[1023], 4,  1, 3);
+    test_lcbb(&buf[0],    5, 16, 0);
+    test_lcbb(&buf[2047], 5,  1, 3);
+    test_lcbb(&buf[0],    6, 16, 0);
+    test_lcbb(&buf[4095], 6,  1, 3);
+
+    return EXIT_SUCCESS;
+}
-- 
2.39.2


