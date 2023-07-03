Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A2745E1C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK9S-0005f8-1o; Mon, 03 Jul 2023 10:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGK9P-0005eb-DI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:03:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGK9J-00032D-Ps
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:03:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so41492605e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688393008; x=1690985008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L10INYSmGRMwfYRjSmnypN3cJI3i4gGGNLhvyw0OvLw=;
 b=Q3alv+OLG6ICh/CvIFWfuaIunr1LsU3WJ9fnmjnHe7ImeagwTr3XnphHHPZ04ekts0
 Es9cWPFDfS+z1i0BC+5GbGa9X1PwA3PGKFdS8QvEydJ475Z9xRfxA2tC8sKJr8moKGw2
 lhQTNg2xodjYaBkCA03X2Qj3QI9B8Mf+QVnENApYS5S9p0AEfCaGLvOolZ9dSDXpYUEY
 Cb2e6kJ+sCCYcNBUEZsF8t9LlrMQ/nK8bUtxLaTWFTiEZu0GakUI62RKgtZOZoAsFmHl
 +cQtDUBXk6cVxpxmYIJ691LumioAcyBPTkNMjJSZEfyTQCChrG9vcMxh5rlG9aMuD3z8
 nMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688393008; x=1690985008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L10INYSmGRMwfYRjSmnypN3cJI3i4gGGNLhvyw0OvLw=;
 b=LVlHynbmHytnLU/wLRAjmx2hPwIFYwW1JpPiuFo5PWNUq5J9DMni0jqRSWwuc3hAv8
 pMh5m2ciDkhhyoxbGmarafNBr+g8A6ZjInOaixrRxqDj2Jsm+JUJfPtZ+q+O/qSxBS/h
 SBB+Eslc76ci04qOBQHjwMzgx2zaLky+O4Wottv07GBVpL3YSZBeR2XeJzp9gf99XBYc
 zWmXYea5bU0UryUwaAgaE7Rjdy4aubDj4ZudQWLeGI3TdayVnsRTTrY9i2x2GNHSytX4
 V8MSEPgaRDzW9PqE95vihyS7HJJZhVodmPFnt02P2h6Xwys2Xb/NPd2CT1IEHJY3uXAA
 e15w==
X-Gm-Message-State: ABy/qLYeuRGtTaXgrdtdzkZKl5JWqWOEXBc9dLi6s1G3nySOwssOZSWL
 veG0tiH5Ux6VJRj6ovWy+RF5Qg==
X-Google-Smtp-Source: APBJJlHn8ZYYnr7wkJtxLulKPxyFdaIbJNVfnJoxo8U0SRhFV5WUw54dG8ivbsOSxTxnPIyydTSYfg==
X-Received: by 2002:adf:decb:0:b0:314:1e47:8bc2 with SMTP id
 i11-20020adfdecb000000b003141e478bc2mr8509635wrn.0.1688393008118; 
 Mon, 03 Jul 2023 07:03:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z11-20020adfe54b000000b0031128382ed0sm6636413wrm.83.2023.07.03.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 07:03:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 257671FFE5;
 Mon,  3 Jul 2023 14:44:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/38] tests/tcg: Add a test for info proc mappings
Date: Mon,  3 Jul 2023 14:44:27 +0100
Message-Id: <20230703134427.1389440-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Message-Id: <20230621203627.1808446-9-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-39-alex.bennee@linaro.org>

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


