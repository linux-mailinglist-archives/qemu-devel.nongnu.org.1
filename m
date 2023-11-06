Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B277E2C6F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:54:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04h6-00064W-JX; Mon, 06 Nov 2023 13:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h3-00062o-8H
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gz-0000ys-Hh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32f70391608so2484566f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296680; x=1699901480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xUeFsK/n6NpbgwE1ie7mSUcT/F4//4iG2nP+O0hn98=;
 b=GjPra6NVrHSBss3avzccznKlnCTgYG9jkdukdcPmVvaYdjETqmL0ELvjpHEYhd9m2n
 p441+TYoJb0sQOd25d4KC6P0eqLiPJEt8UT5rzNlHIglQ98CdAOOsMM6UJQSki6yqhNd
 j9vGl4F4XoHhw+rWixX5Hf++cRh0/iun4EcfENufFwUfeYDWqLJUfxmk2BqRzJn+KZ2y
 9MncJQUeK4/BT6JJuWiGKTbhixYvZ5PogwCK8Nfttz0oU3IvrBWa9XJGUsTmrke9JLMf
 7SPpK0CUvGbjTnI39/ax1M48TeHEdqL/bWs7UZx35RLDom+MObg2gWFMJ1/zuIwwqT8o
 HlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296680; x=1699901480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xUeFsK/n6NpbgwE1ie7mSUcT/F4//4iG2nP+O0hn98=;
 b=J5+3QnsGqBcGmUFFhvz8E63evUEXScSVrL3ocSPbzzjLCfXN7CIr++IIRu9Qr/ijSt
 4iuczzCo5Au9dWw5DdhCj9o1FmJQWOfiYogh0GP2K6YAvo4UR8+rlUlSyjhOGSSe/OfK
 RAljK3sqVATZmHdQPnJx7IXIAPoH2DCNnooz5u5PD+WGzuXQXxd1n7fzfjqNUYYJzDJ6
 7YARPcJIRo9OjqK1TxtYy/5CRq4leV2nWofBQG6S+cnvIAFwko1xxTucV2yR2d8gmlSu
 d/5EtpUDKxVSdCHVq9Xhb4AtWCfAsP8F9SIDO+aHwtS2l2OGbedjMUXVyvCiOEzIgWMv
 fSug==
X-Gm-Message-State: AOJu0YxyCLp/Qb3fAhIcfNTO3e2S/oy2zzOeO4igRmv5+qbe6wAbYjLq
 +QZNG2nCfdsX+7hDUd+ZDfDOAQ==
X-Google-Smtp-Source: AGHT+IGIzoKI9gK8tTIEUwdPaKxIFsVA2iU/kKXQJtPydEd3sBy8olCoc+cO/YqAi+0BU105lhpTbQ==
X-Received: by 2002:a05:6000:2aa:b0:32f:7c27:423b with SMTP id
 l10-20020a05600002aa00b0032f7c27423bmr23539072wry.51.1699296679921; 
 Mon, 06 Nov 2023 10:51:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d16-20020adfe850000000b0032da40fd7bdsm326078wrn.24.2023.11.06.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 087F265759;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Luis Machado <luis.machado@linaro.org>
Subject: [PATCH 06/22] tests/tcg: add an explicit gdbstub register tester
Date: Mon,  6 Nov 2023 18:50:56 +0000
Message-Id: <20231106185112.2755262-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

We already do a couple of "info registers" for specific tests but this
is a more comprehensive multiarch test. It also has some output
helpful for debugging the gdbstub by showing which XML features are
advertised and what the underlying register numbers are.

My initial motivation was to see if there are any duplicate register
names exposed via the gdbstub while I was reviewing the proposed
register interface for TCG plugins.

Mismatches between the xml and remote-desc are reported for debugging
but do not fail the test.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Luis Machado <luis.machado@linaro.org>
Message-Id: <20231012170426.1335442-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-7-alex.bennee@linaro.org>

---
v3
  - don't __str__ values when we don't need to
  - handle _exit/_Exit disparity on Microblaze
  - move seen test outside try/except
  - report failed register reads
---
 tests/tcg/multiarch/Makefile.target           |  11 +-
 tests/tcg/multiarch/gdbstub/registers.py      | 196 ++++++++++++++++++
 .../multiarch/system/Makefile.softmmu-target  |  13 +-
 3 files changed, 218 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/registers.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f3bfaf1a22..d31ba8d6ae 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -93,12 +93,21 @@ run-gdbstub-thread-breakpoint: testthread
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
 	hitting a breakpoint on non-main thread)
+
+run-gdbstub-registers: sha512
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
+	checking register enumeration)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
-	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
+	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
+	      run-gdbstub-registers
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
new file mode 100644
index 0000000000..4ae63f1cf0
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -0,0 +1,196 @@
+# Exercise the register functionality by exhaustively iterating
+# through all supported registers on the system.
+#
+# This is launched via tests/guest-debug/run-test.py but you can also
+# call it directly if using it for debugging/introspection:
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+    # First check the XML descriptions we have sent. Most arches
+    # support XML but a few of the ancient ones don't in which case we
+    # need to gracefully fail.
+
+    try:
+        xml = gdb.execute("maint print xml-tdesc", False, True)
+    except (gdb.error):
+        print("SKIP: target does not support XML")
+        return None
+
+    total_regs = 0
+    reg_map = {}
+    frame = gdb.selected_frame()
+
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
+            regnum = int(r.attrib["regnum"])
+            try:
+                value = frame.read_register(name)
+            except ValueError:
+                report(False, f"failed to read reg: {name}")
+
+            entry = { "name": name, "initial": value, "regnum": regnum }
+
+            if name in reg_map:
+                report(False, f"duplicate register {entry} vs {reg_map[name]}")
+                continue
+
+            reg_map[name] = entry
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
+            r_regnum = int(fields[6])
+
+            # check in the XML
+            try:
+                x_reg = reg_map[r_name]
+            except KeyError:
+                report(False, f"{r_name} not in XML description")
+                continue
+
+            x_reg["seen"] = True
+            x_regnum = x_reg["regnum"]
+            if r_regnum != x_regnum:
+                report(False, f"{r_name} {r_regnum} == {x_regnum} (xml)")
+            else:
+                total_r_regs += 1
+
+    # Just print a mismatch in totals as gdb will filter out 64 bit
+    # registers on a 32 bit machine. Also print what is missing to
+    # help with debug.
+    if total_regs != total_r_regs:
+        print(f"xml-tdesc ({total_regs}) and remote-registers ({total_r_regs}) do not agree")
+
+        for x_key in reg_map.keys():
+            x_reg = reg_map[x_key]
+            if "seen" not in x_reg:
+                print(f"{x_reg} wasn't seen in remote-registers")
+
+def complete_and_diff(reg_map):
+    """
+    Let the program run to (almost) completion and then iterate
+    through all the registers we know about and report which ones have
+    changed.
+    """
+    # Let the program get to the end and we can check what changed
+    b = gdb.Breakpoint("_exit")
+    if b.pending: # workaround Microblaze weirdness
+        b.delete()
+        gdb.Breakpoint("_Exit")
+
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
+            new_val = frame.read_register(name)
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
+    if reg_map is not None:
+        crosscheck_remote_xml(reg_map)
+        complete_and_diff(reg_map)
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
index dee4f58dea..32dc0f9830 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -48,9 +48,20 @@ run-gdbstub-untimely-packet: hello
 	$(call quiet-command, \
 		(! grep -Fq 'Packet instead of Ack, ignoring it' untimely-packet.gdb.err), \
 		"GREP", file untimely-packet.gdb.err)
+
+run-gdbstub-registers: memory
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) \
+		--output $<.registers.gdb.out \
+		--qargs \
+		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
+	softmmu gdbstub support)
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 
-MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt run-gdbstub-untimely-packet
+MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
+	run-gdbstub-untimely-packet run-gdbstub-registers
-- 
2.39.2


