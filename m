Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3287E6B89
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:51:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15PI-0005ZB-8R; Thu, 09 Nov 2023 08:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Oc-0004eW-H9; Thu, 09 Nov 2023 08:48:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Oa-0002ez-JG; Thu, 09 Nov 2023 08:48:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6EFF31B2C;
 Thu,  9 Nov 2023 16:43:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B58BD344D3;
 Thu,  9 Nov 2023 16:43:07 +0300 (MSK)
Received: (nullmailer pid 1461919 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 52/55] tests/tcg/s390x: Test CLC with inaccessible
 second operand
Date: Thu,  9 Nov 2023 16:42:56 +0300
Message-Id: <20231109134300.1461632-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231106093605.1349201-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 43fecbe7a53fe8e5a6aff0d6471b1cc624e26b51)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 1fc9809907..3ddbde1a9d 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -41,6 +41,7 @@ TESTS+=larl
 TESTS+=mdeb
 TESTS+=cgebra
 TESTS+=clgebr
+TESTS+=clc
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/clc.c b/tests/tcg/s390x/clc.c
new file mode 100644
index 0000000000..e14189bd75
--- /dev/null
+++ b/tests/tcg/s390x/clc.c
@@ -0,0 +1,48 @@
+/*
+ * Test the CLC instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void handle_sigsegv(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+    if (mcontext->gregs[0] != 600) {
+        write(STDERR_FILENO, "bad r0\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    if (((mcontext->psw.mask >> 44) & 3) != 1) {
+        write(STDERR_FILENO, "bad cc\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    _exit(EXIT_SUCCESS);
+}
+
+int main(void)
+{
+    register unsigned long r0 asm("r0");
+    unsigned long mem = 42, rhs = 500;
+    struct sigaction act;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigsegv;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGSEGV, &act, NULL);
+    assert(err == 0);
+
+    r0 = 100;
+    asm("algr %[r0],%[rhs]\n"
+        "clc 0(8,%[mem]),0(0)\n"  /* The 2nd operand will cause a SEGV. */
+        : [r0] "+r" (r0)
+        : [mem] "r" (&mem)
+        , [rhs] "r" (rhs)
+        : "cc", "memory");
+
+    return EXIT_FAILURE;
+}
-- 
2.39.2


