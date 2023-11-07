Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E17E41DC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0M-0004XG-P9; Tue, 07 Nov 2023 09:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzy-0004FH-FP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:12 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzv-0007ac-JY
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:10 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so75539991fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367045; x=1699971845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mkk1WmfSZh50CCsgGgBZhn4Gb3d1L0DReMlnN2yJA0U=;
 b=DI5z4PdkfLN5+HF+Kn+ylfbrRoYZ3oL9Exex3vpbASa9RfVt1itfGTmHyXXMN6+PRX
 fNFMzdLxZf7Z7mXE2vWLenO4h4f/u6SnH4QhBa8cTBvxdSsMXws9+ZYD9KlHI/DGHa9P
 GTurQM81PC0yI+nvBQ+Ow/JE8e7Le45uwH50gATMKf3Tbxa5sk0kSaU86Mr3QSVFrJRv
 jG/PpKeVrv2h9QDpFyu3JM0oILaTtb0qsVlMN1Q7C5zmljuSWOWuFSByiDJODfIQr5mG
 LwaPNUWhk+rg8VKhGADY8pUVxTEMn3UP0hiDH0yd0HOgEqbnGUUwuCkRyPsBKJC5npXj
 TvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367045; x=1699971845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mkk1WmfSZh50CCsgGgBZhn4Gb3d1L0DReMlnN2yJA0U=;
 b=ZdJnPU/RaXTNOGX6JPJQjvSroILbszLM/ZSnKIkCU5rsJXxrVC8W1c2VseQHqiUQUZ
 6reoUwAXWbC8NFX22VdBEiAATAjTHRITTe+JhBqhou+PusMaqlMjK8NjZqdejyrIHwet
 fDoijQ+GiAAd/2aV4cTCf5cVz845zKtKsOkzTDnayE1zEXmxQnH7Sd0x2ZKuKhATMNW+
 TEbm63ZwnWJbpAj8R01rwij2Tq2iaIeD/QgQIpGOlpeXuy6ErzmX5ibhmPcITlHqFk/r
 ZVnOOwcVnd6KzKWN1zxWnCgh46AoWnVe71PbKiqXXiv1/TTzv1oDoo6RBnTGrUMkWqDn
 Didw==
X-Gm-Message-State: AOJu0Yxpvo+Z97JN75G83olfckNCizSDscrc7zvGBZDuRjKXsELH+Pf/
 if0KnhAZQzIxjon6AlGOcFmjcPoK4BDyaeobixjUEQ==
X-Google-Smtp-Source: AGHT+IGF+cDd0DfVLJsGrcHnkcOHnRnY4YkegBIYKLTe4aEDjKvYA1l2LKG12XxpAaktyxe0Yp779g==
X-Received: by 2002:a05:651c:2109:b0:2c2:c1f6:3097 with SMTP id
 a9-20020a05651c210900b002c2c1f63097mr33089719ljq.22.1699367045439; 
 Tue, 07 Nov 2023 06:24:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m26-20020a05600c3b1a00b00407752bd834sm16056503wms.1.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F7386575C;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Luis Machado <luis.machado@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 06/23] tests/tcg: add an explicit gdbstub register tester
Date: Tue,  7 Nov 2023 14:23:37 +0000
Message-Id: <20231107142354.3151266-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
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

We already do a couple of "info registers" for specific tests but this
is a more comprehensive multiarch test. It also has some output
helpful for debugging the gdbstub by showing which XML features are
advertised and what the underlying register numbers are.

My initial motivation was to see if there are any duplicate register
names exposed via the gdbstub while I was reviewing the proposed
register interface for TCG plugins.

Mismatches between the xml and remote-desc are reported for debugging
but do not fail the test.

We also skip the tests for the following arches for now until we can
investigate and fix any issues:

  - s390x (fails to read v0l->v15l, not seen in remote-registers)
  - ppc64 (fails to read vs0h->vs31h, not seen in remote-registers)

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Luis Machado <luis.machado@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-7-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index b86ea7f75a..26e7633346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2927,7 +2927,7 @@ F: gdbstub/*
 F: include/exec/gdbstub.h
 F: include/gdbstub/*
 F: gdb-xml/
-F: tests/tcg/multiarch/gdbstub/
+F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
 
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
index 0000000000..ff6076b09e
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -0,0 +1,197 @@
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
+        print(f"xml-tdesc has ({total_regs}) registers")
+        print(f"remote-registers has ({total_r_regs}) registers")
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
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 5721c159f2..1d08076756 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -38,4 +38,11 @@ PPC64_TESTS += signal_save_restore_xer
 PPC64_TESTS += xxspltw
 PPC64_TESTS += test-aes
 
+ifneq ($(GDB),)
+# Skip for now until vsx registers sorted out
+run-gdbstub-registers:
+	$(call skip-test, $<, "BROKEN reading VSX registers")
+endif
+
+
 TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 826f0a18e4..49af091c38 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -100,6 +100,10 @@ run-gdbstub-svc: hello-s390x-asm
 		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
 	single-stepping svc)
 
+# Skip for now until vx registers sorted out
+run-gdbstub-registers:
+	$(call skip-test, $<, "BROKEN reading VX registers")
+
 EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
 endif
 
-- 
2.39.2


