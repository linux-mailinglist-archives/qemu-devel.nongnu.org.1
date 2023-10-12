Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC37C73B4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 19:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqz7O-0004Ln-3A; Thu, 12 Oct 2023 13:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqz78-0004KS-2G
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 13:04:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqz72-0007se-GA
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 13:04:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d885e97e2so1198486f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697130277; x=1697735077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lLSH3GmogzWJR9HjA0OdsI6Yovqo2h8HV5jvFWGd684=;
 b=QHV1VUouecx8rOFtzMv7LMAA7lsNte7daWVhT+6IWnuhjBRyOxGr4SPkjSbL2t8MSy
 mmC6ddOGvFYDRSeWdnXR+MZ3gvNtkYYINomVklNJwIzPoYVhujK1t0bKN3aNu2sQThB2
 jzexpHAiGCTTKphC/MRxP3KMTMlw3I6saeikOBYFZszXjO9hNCrldXNxDWiCvsrtFhSq
 mAcbXNHGRgMa6uJowRWjJ/B+RQbG+odeIGJDbO27IfIj3K4wbj8A5JMyyWuxDRe3cZhk
 kK0Dqw9Ja959ObmXrrY+XpaaN4eLqLE/WaROEiWCQz0m41A93CUHZ0dTKs2b5SUwoTim
 KSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697130277; x=1697735077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lLSH3GmogzWJR9HjA0OdsI6Yovqo2h8HV5jvFWGd684=;
 b=PJ2iUesMak3k2O2sus7NzK1BzpgXRTvKXpHtNKJAutdRj5Ta4gVP3RcDaAP9o4i6Od
 FkFHVh6gSbTbqMEsk4D9GdX089TDIN328IgyIUY1oxR+yTUbYuzzY/FoawwL2BOJH+FC
 1BpntSZRxiCf/iWCMlKoPiPnvZ1JGUqKoufRrcrCpVNPOjIKzWyPbWB+eSmNtL9wvsKz
 I2aWU9NsjCXMf0QAyfLory99ZlyOqZAa0rfzI1b76kdWInA5o4pacXaqc8uZKd+Iq9lP
 /NjBghHOCVLhN++MZ9jWrMszo9WvhSaw4JbvhoA6QQBpDwfM+MpcKkIFRCmj+DFk3UtD
 Mg+w==
X-Gm-Message-State: AOJu0Yx1M/nF0xtat40TVKu3Atqwz+zPvrZaceKttxiF3otaYLCBo6AS
 jOJsbhpyb6Oh8qFtmp0SgsBBoQ==
X-Google-Smtp-Source: AGHT+IExB7T9O/v2QvNE/iA5pFmd4krXoAFGyxWaYbcwVvAbsMk0IKIhGdDEnwC/IWpbqUMufqN4Zg==
X-Received: by 2002:adf:f3c2:0:b0:31a:e6bf:9032 with SMTP id
 g2-20020adff3c2000000b0031ae6bf9032mr22471103wrp.4.1697130277217; 
 Thu, 12 Oct 2023 10:04:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adffd12000000b0031980783d78sm18839568wrr.54.2023.10.12.10.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 10:04:36 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90D9C1FFBB;
 Thu, 12 Oct 2023 18:04:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tests/tcg: add an explicit gdbstub register tester
Date: Thu, 12 Oct 2023 18:04:26 +0100
Message-Id: <20231012170426.1335442-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We already do a couple of "info registers" for specific tests but this
is a more comprehensive multiarch test. It also has some output
helpful for debugging the gdbstub by showing which XML features are
advertised and what the underlying register numbers are.

My initial motivation was to see if there are any duplicate register
names exposed via the gdbstub while I was reviewing the proposed
register interface for TCG plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/multiarch/Makefile.target           |  10 +-
 tests/tcg/multiarch/gdbstub/registers.py      | 173 ++++++++++++++++++
 .../multiarch/system/Makefile.softmmu-target  |  14 +-
 3 files changed, 195 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/registers.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf21..d5e05ac343 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -95,6 +95,13 @@ run-gdbstub-thread-breakpoint: testthread
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
 	hitting a breakpoint on non-main thread)
 
+run-gdbstub-registers: sha512
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
+	checking register enumeration)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "no guest arch support")
@@ -104,7 +111,8 @@ run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
-	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
+	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
+	      run-gdbstub-registers
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
new file mode 100644
index 0000000000..7f331082cb
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -0,0 +1,173 @@
+from __future__ import print_function
+#
+# Exercise the register functionality by exhaustively iterating
+# through all supported registers on the system.
+#
+# This is launched via tests/guest-debug/run-test.py but you can also
+# call it directly if using it for debugging/introspection:
+#
+#
+#
+
+import gdb
+import sys
+import xml.etree.ElementTree as ET
+
+initial_vlen = 0
+failcount = 0
+
+def report(cond, msg):
+    "Report success/fail of test."
+    if cond:
+        print("PASS: %s" % (msg))
+    else:
+        print("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+
+def fetch_xml_regmap():
+    """
+    Iterate through the XML descriptions and validate.
+
+    We check for any duplicate registers and report them. Return a
+    reg_map hash containing the names, regnums and initial values of
+    all registers.
+    """
+
+    total_regs = 0
+    reg_map = {}
+    frame = gdb.selected_frame()
+
+    # First check the XML descriptions we have sent
+    xml = gdb.execute("maint print xml-tdesc", False, True)
+    tree = ET.fromstring(xml)
+    for f in tree.findall("feature"):
+        name = f.attrib["name"]
+        regs = f.findall("reg")
+
+        total = len(regs)
+        total_regs += total
+        base = int(regs[0].attrib["regnum"])
+        top = int(regs[-1].attrib["regnum"])
+
+        print(f"feature: {name} has {total} registers from {base} to {top}")
+
+        for r in regs:
+            name = r.attrib["name"]
+            value = frame.read_register(name).__str__()
+            regnum = int(r.attrib["regnum"])
+            entry = { "name": name,
+                      "initial": value,
+                      "regnum": regnum }
+            try:
+                reg_map[name] = entry
+            except KeyError:
+                report(False, f"duplicate register {r} vs {reg_map[name]}")
+
+    # Validate we match
+    report(total_regs == len(reg_map.keys()),
+           f"counted all {total_regs} registers in XML")
+
+    return reg_map
+
+def crosscheck_remote_xml(reg_map):
+    """
+    Cross-check the list of remote-registers with the XML info.
+    """
+
+    remote = gdb.execute("maint print remote-registers", False, True)
+    r_regs = remote.split("\n")
+
+    total_regs = len(reg_map.keys())
+    total_r_regs = 0
+
+    for r in r_regs:
+        fields = r.split()
+        # Some of the registers reported here are "pseudo" registers that
+        # gdb invents based on actual registers so we need to filter them
+        # out.
+        if len(fields) == 8:
+            r_name = fields[0]
+            r_regnum = int(fields[1])
+
+            # check in the XML
+            try:
+                x_reg = reg_map[r_name]
+            except KeyError:
+                report(False, "{r_name} not in XML description")
+                continue
+
+            x_regnum = x_reg["regnum"]
+            if r_regnum != x_regnum:
+                report(False, f"{r_name} {r_regnum} == {x_regnum} (xml)")
+            else:
+                total_r_regs += 1
+
+    report(total_regs == total_r_regs, f"xml-tdesc and remote-registers agree")
+
+def complete_and_diff(reg_map):
+    """
+    Let the program run to (almost) completion and then iterate
+    through all the registers we know about and report which ones have
+    changed.
+    """
+    # Let the program get to the end and we can check what changed
+    gdb.Breakpoint("_exit")
+    gdb.execute("continue")
+
+    frame = gdb.selected_frame()
+    changed = 0
+
+    for e in reg_map.values():
+        name = e["name"]
+        old_val = e["initial"]
+
+        try:
+            new_val = frame.read_register(name).__str__()
+        except:
+            report(False, f"failed to read {name} at end of run")
+            continue
+
+        if new_val != old_val:
+            print(f"{name} changes from {old_val} to {new_val}")
+            changed += 1
+
+    # as long as something changed we can be confident its working
+    report(changed > 0, f"{changed} registers were changed")
+
+
+def run_test():
+    "Run through the tests"
+
+    reg_map = fetch_xml_regmap()
+
+    crosscheck_remote_xml(reg_map)
+
+    complete_and_diff(reg_map)
+
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    print("ATTACHED: %s" % arch.name())
+except (gdb.error, AttributeError):
+    print("SKIPPING (not connected)", file=sys.stderr)
+    exit(0)
+
+if gdb.parse_and_eval('$pc') == 0:
+    print("SKIP: PC not set")
+    exit(0)
+
+try:
+    run_test()
+except (gdb.error):
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+    pass
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 90810a32b2..dc97d71e42 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -27,6 +27,17 @@ run-gdbstub-memory: memory
 		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/memory.py, \
 	softmmu gdbstub support)
+
+run-gdbstub-registers: memory
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) \
+		--output $<.registers.gdb.out \
+		--qargs \
+		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
+	softmmu gdbstub support)
+
 run-gdbstub-interrupt: interrupt
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
@@ -58,4 +69,5 @@ run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb")
 endif
 
-MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt run-gdbstub-untimely-packet
+MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-registers \
+		  run-gdbstub-interrupt run-gdbstub-untimely-packet
-- 
2.39.2


