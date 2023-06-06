Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D923F723706
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgR-0004oR-QP; Tue, 06 Jun 2023 01:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgP-0004nS-5e
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgM-00047n-CV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686030997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6R/39GPqskQ+7PH8eIN8cruERLA6l7OCtIbdQDVg8Eg=;
 b=S3LASlyI+hAigym5wmaO39tryqxCAHORny6S3pRnTsAm6brwpd0sJmtwSH2t2xi1B+sFb9
 diR/EuYx4rQ418M4L0RlOXjz2JiduK6LdM2d+SiHZ3Lr51Np65nXDEUAB1icbQkI/9Vts7
 9RPHQAq1BsseptM+W1TbzUhJuobFKUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-MgCGhmi7OB-m2BZ8455JXA-1; Tue, 06 Jun 2023 01:56:34 -0400
X-MC-Unique: MgCGhmi7OB-m2BZ8455JXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0265A85A5A8;
 Tue,  6 Jun 2023 05:56:34 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C41BF2166B25;
 Tue,  6 Jun 2023 05:56:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/18] tests/tcg/s390x: Test single-stepping SVC
Date: Tue,  6 Jun 2023 07:56:09 +0200
Message-Id: <20230606055621.523175-7-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 tests/tcg/s390x/Makefile.target     | 11 ++++-
 tests/tcg/s390x/gdbstub/test-svc.py | 64 +++++++++++++++++++++++++++++
 tests/tcg/s390x/hello-s390x-asm.S   | 20 +++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/s390x/gdbstub/test-svc.py
 create mode 100644 tests/tcg/s390x/hello-s390x-asm.S

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
2.31.1


