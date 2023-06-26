Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714C73EA91
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrJy-0007Rc-Ln; Mon, 26 Jun 2023 14:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJv-0007Hx-Ok; Mon, 26 Jun 2023 14:52:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJt-00054R-W5; Mon, 26 Jun 2023 14:52:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 59264EF2D;
 Mon, 26 Jun 2023 21:50:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DA37BF7BC;
 Mon, 26 Jun 2023 21:50:20 +0300 (MSK)
Received: (nullmailer pid 1574024 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 22/54] tests/tcg/s390x: Test single-stepping SVC
Date: Mon, 26 Jun 2023 21:49:29 +0300
Message-Id: <20230626185002.1573836-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230510230213.330134-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit be4a4cb429617a8b6893733b37b6203e4b7bf35b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index b14c0bd84b..a2a15c4a23 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -77,7 +77,16 @@ run-gdbstub-signals-s390x: signals-s390x
 		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
 	mixing signals and debugging)
 
-EXTRA_RUNS += run-gdbstub-signals-s390x
+hello-s390x-asm: CFLAGS+=-nostdlib
+
+run-gdbstub-svc: hello-s390x-asm
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
+	single-stepping svc)
+
+EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
 endif
 
 # MVX versions of sha512
diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
new file mode 100644
index 0000000000..7851ca7284
--- /dev/null
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -0,0 +1,64 @@
+"""Test single-stepping SVC.
+
+This runs as a sourced script (via -x, via run-test.py)."""
+from __future__ import print_function
+import gdb
+import sys
+
+
+n_failures = 0
+
+
+def report(cond, msg):
+    """Report success/fail of a test"""
+    if cond:
+        print("PASS: {}".format(msg))
+    else:
+        print("FAIL: {}".format(msg))
+        global n_failures
+        n_failures += 1
+
+
+def run_test():
+    """Run through the tests one by one"""
+    report("lghi\t" in gdb.execute("x/i $pc", False, True), "insn #1")
+    gdb.execute("si")
+    report("larl\t" in gdb.execute("x/i $pc", False, True), "insn #2")
+    gdb.execute("si")
+    report("lghi\t" in gdb.execute("x/i $pc", False, True), "insn #3")
+    gdb.execute("si")
+    report("svc\t" in gdb.execute("x/i $pc", False, True), "insn #4")
+    gdb.execute("si")
+    report("xgr\t" in gdb.execute("x/i $pc", False, True), "insn #5")
+    gdb.execute("si")
+    report("svc\t" in gdb.execute("x/i $pc", False, True), "insn #6")
+    gdb.execute("si")
+
+
+def main():
+    """Prepare the environment and run through the tests"""
+    try:
+        inferior = gdb.selected_inferior()
+        print("ATTACHED: {}".format(inferior.architecture().name()))
+    except (gdb.error, AttributeError):
+        print("SKIPPING (not connected)")
+        exit(0)
+
+    if gdb.parse_and_eval('$pc') == 0:
+        print("SKIP: PC not set")
+        exit(0)
+
+    try:
+        # These are not very useful in scripts
+        gdb.execute("set pagination off")
+        gdb.execute("set confirm off")
+
+        # Run the actual tests
+        run_test()
+    except gdb.error:
+        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
+    print("All tests complete: %d failures" % n_failures)
+    exit(n_failures)
+
+
+main()
diff --git a/tests/tcg/s390x/hello-s390x-asm.S b/tests/tcg/s390x/hello-s390x-asm.S
new file mode 100644
index 0000000000..2e9faa1604
--- /dev/null
+++ b/tests/tcg/s390x/hello-s390x-asm.S
@@ -0,0 +1,20 @@
+/*
+ * Hello, World! in assembly.
+ */
+
+.globl _start
+_start:
+
+/* puts("Hello, World!"); */
+lghi %r2,1
+larl %r3,foo
+lghi %r4,foo_end-foo
+svc 4
+
+/* exit(0); */
+xgr %r2,%r2
+svc 1
+
+.align 2
+foo: .asciz "Hello, World!\n"
+foo_end:
-- 
2.39.2


