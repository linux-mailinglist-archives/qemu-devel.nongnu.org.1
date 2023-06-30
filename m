Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA877441C6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIVA-000144-1n; Fri, 30 Jun 2023 14:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIU2-0008Lv-Tz
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITy-00071L-D1
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so11306155e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148273; x=1690740273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSkcoehiqyKjiOIAuNJ9AUja3GDxG2+fTHEXVRu0R8c=;
 b=WrZuiQHc5Xg4FMqV4ZTJVVpH+e/kzrFtF+XGvrjXU7RxB7iRfmWF+h7Q51XPWKAjcZ
 j+/D47YeDqv5dDBflkIZQHzcCC0AcD/DejnB6PmhOrSA7gHPzmsn5DRjIBHvQGBJmlix
 RZHXMAGZX2ri8P/Rbm+flKYHodn68xjhh7RVUzFrfOsjZVLWPW7IF6W25h5uLmZKdh2E
 6rOLFyf7Zium9wMlHIE5OTpMfzQWUMGT4FGptAHJ6gw1DLyPvkofxYrrXfWpFgEDHNqB
 Wbwp5UwdRzzUTQNSZmpDiqQzcmAz36p63G9HwTreOW0429tQ6QED0S9UeDrT7JngJZ0/
 KHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148273; x=1690740273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSkcoehiqyKjiOIAuNJ9AUja3GDxG2+fTHEXVRu0R8c=;
 b=BUip+/sgsbQuYRSivQKeBXlSzzhokOqxKXzCqStcUlpOLWQ9RiUqp2PCoAT0ozLvfi
 xrMsct6EYPpZQJ85h1LHW6RdvtP5KF7Bw3ryUj0sJG2FnfHJQC1SE+MF7U7cAgGAdq7A
 WmiiFpLfKl80ybwLlWGcNfwXIbEKESCNFmeZOT/daB7NgOtN+DHuf3oo/JNdZfrGd8Gn
 THbvqPL14MCZO/AbMgupsboigvRPlrdMSKUsXidD7PzMHlSU18B+AR8e532H55BXcBaC
 9df+uNpFh7yJffDGnfHAGPPB2o9WN9hH9dnXnzD0S/yMaa8xTmfl038xjCpFqw4+Rz6r
 3rTA==
X-Gm-Message-State: AC+VfDxBJOqLiSNMQEQr2hEBpwYJj9DmuGIxfqEr4Fs7r2xvqK1Ef5QW
 0U0+OnyJ+3Y85ROqOv8EpSw8TQ==
X-Google-Smtp-Source: ACHHUZ7J5Aj6hZkEHov509h9TufmShNy3CwCumPUDXTmx70q41EDOJkj830hRFxKWZf8Ytzucxa3xw==
X-Received: by 2002:a05:600c:2905:b0:3fb:ba04:6d57 with SMTP id
 i5-20020a05600c290500b003fbba046d57mr2666632wmd.5.1688148272915; 
 Fri, 30 Jun 2023 11:04:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a1cf00a000000b003f8fb02c413sm19696334wmb.8.2023.06.30.11.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 569241FFE9;
 Fri, 30 Jun 2023 19:04:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 38/38] tests/tcg: Add a test for info proc mappings
Date: Fri, 30 Jun 2023 19:04:23 +0100
Message-Id: <20230630180423.558337-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-Id: <20230621203627.1808446-9-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target           |  9 ++-
 .../multiarch/gdbstub/test-proc-mappings.py   | 65 +++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 373db69648..43bddeaf21 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -81,6 +81,13 @@ run-gdbstub-qxfer-auxv-read: sha1
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
 	basic gdbstub qXfer:auxv:read support)
 
+run-gdbstub-proc-mappings: sha1
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappings.py, \
+	proc mappings support)
+
 run-gdbstub-thread-breakpoint: testthread
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
@@ -97,7 +104,7 @@ run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
-	      run-gdbstub-thread-breakpoint
+	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
new file mode 100644
index 0000000000..7b596ac21b
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -0,0 +1,65 @@
+"""Test that gdbstub has access to proc mappings.
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
+    try:
+        mappings = gdb.execute("info proc mappings", False, True)
+    except gdb.error as exc:
+        exc_str = str(exc)
+        if "Not supported on this target." in exc_str:
+            # Detect failures due to an outstanding issue with how GDB handles
+            # the x86_64 QEMU's target.xml, which does not contain the
+            # definition of orig_rax. Skip the test in this case.
+            print("SKIP: {}".format(exc_str))
+            return
+        raise
+    report(isinstance(mappings, str), "Fetched the mappings from the inferior")
+    report("/sha1" in mappings, "Found the test binary name in the mappings")
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
-- 
2.39.2


