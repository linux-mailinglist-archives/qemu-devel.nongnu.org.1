Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3D73EA9B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrK2-0007kl-OG; Mon, 26 Jun 2023 14:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJz-0007cF-9r; Mon, 26 Jun 2023 14:52:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJx-0005Cz-DA; Mon, 26 Jun 2023 14:52:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0D5CEF2F;
 Mon, 26 Jun 2023 21:50:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 53BEFF7BE;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: (nullmailer pid 1574030 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 24/54] tests/tcg/s390x: Test MXDB and MXDBR
Date: Mon, 26 Jun 2023 21:49:31 +0300
Message-Id: <20230626185002.1573836-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

Add a small test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230601223027.795501-3-iii@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 2b956244a9d1b18b9653bf7453870c2d10df2427)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a2a15c4a23..85abfbb98c 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -35,6 +35,7 @@ TESTS+=chrl
 TESTS+=rxsbg
 TESTS+=ex-relative-long
 TESTS+=ex-branch
+TESTS+=mxdb
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/mxdb.c b/tests/tcg/s390x/mxdb.c
new file mode 100644
index 0000000000..ae922559d3
--- /dev/null
+++ b/tests/tcg/s390x/mxdb.c
@@ -0,0 +1,30 @@
+/*
+ * Test the MXDB and MXDBR instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    union {
+        double d[2];
+        long double ld;
+    } a;
+    double b;
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdb %[a],%[b]" : [a] "+f" (a.ld) : [b] "R" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdbr %[a],%[b]" : [a] "+f" (a.ld) : [b] "f" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    return EXIT_SUCCESS;
+}
-- 
2.39.2


