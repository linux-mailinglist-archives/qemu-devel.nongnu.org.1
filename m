Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532E7EE616
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:41:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gLW-0007S2-GV; Thu, 16 Nov 2023 12:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3gLU-0007R5-1X
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:40:04 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3gLQ-0002HK-JI
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:40:03 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so1641247e87.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700156398; x=1700761198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxiBxgizXxK7mYgGCXZupqgfAgLBpE6WJd+Ge0SGnUw=;
 b=DKzm95geiaPCOxetteb5iNvzswayWjzGNeWGBS1PubVDeDu2oij4ATXQTbUVLm/XyE
 fYJ+NG9cZBI3Lmo/s/JAdYu24UeAqXn6jRkUzLOheUFIMD7BzV133mBl38kWyR+RDR26
 fBHgkaxtJwEImZCvrKj4Hy8gJwifHFhHSxn5fclYvdV2Vnl9XH3dTmHtUQtjDueTKKDR
 sNtv9zIXjCHXasGA40kJZ199If51IuJNiioPR7v0dXTMj1iK0kYg6bNqzPQ5e+wn9heQ
 lTwfJqIlSFWPkTl9ghx98mRNtXtWPLjzoVEMfLhRp/ngKbL6CyJvVijIYvs1gJZZH23Q
 jbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700156398; x=1700761198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxiBxgizXxK7mYgGCXZupqgfAgLBpE6WJd+Ge0SGnUw=;
 b=sM2a39xhyEFwQLX949Qcr9kPYgFriWhonNOd4QxFbsGlXEguDarqgZbdgvJhsFKP8X
 ccQ0aupSfNYq0xGQ7M0KZuCtgiwbPFlXRgQ+d1mbWcTd3gTDDjm0bPsYWIgPVTAVMkwW
 ZSonvp3u8OyV/6nvTc7iQYl8TbbZqe8I+vtY0pKayzFcp6UCKrdEZCZgHqTw++OyWxEE
 yafoX56hBC2/NrKcJRvXzUy6e6g5aOboYHoZCm0MDxatrPKTD26jYugDbEqgEeamvSR3
 ultKT2XuIfJI1YJp5om5pGOz9ao+gTlfy5yq5XJ4UpQQxG4oL7WE8k2aEvlEeM0fbres
 HiLw==
X-Gm-Message-State: AOJu0YwquYFRrwmlw+eKRsmLz2Df2EcVbK2yEUOr0LCwYzxtXCmironL
 Qv+8sXfAXXrhSP0S+uvkpm0U3A==
X-Google-Smtp-Source: AGHT+IE5ChRmYjHo5qn1Z7daKxnjrHkGL0AoPVEJ5Q7D7sMOfqv9pZgrl50mB6l6UqidVbQR4RPXNg==
X-Received: by 2002:a05:6512:10c4:b0:507:96e5:2ff4 with SMTP id
 k4-20020a05651210c400b0050796e52ff4mr15179457lfg.52.1700156398623; 
 Thu, 16 Nov 2023 09:39:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q15-20020a5d574f000000b0032d893d8dc8sm5107wrw.2.2023.11.16.09.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 09:39:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0B755F7B6;
 Thu, 16 Nov 2023 17:39:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Luis Machado <luis.machado@arm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH] tests/tcg: finesse the registers check for "hidden" regs
Date: Thu, 16 Nov 2023 17:39:53 +0000
Message-Id: <20231116173953.2501204-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

The reason the ppc64 and s390x test where failing was because gdb
hides them although they are still accessible via regnum. We can
re-arrange the test a little bit and include these two arches in our
test.

We still don't explicitly fail for registers that just disappear like
in the ARM case:

  xml-tdesc has 228 registers
  remote-registers has 219 registers
  of which 0 are hidden
  {'name': 'CNTP_CVAL', 'regnum': 96} wasn't seen in remote-registers
  {'name': 'CNTV_CVAL', 'regnum': 101} wasn't seen in remote-registers
  {'name': 'PAR', 'regnum': 113} wasn't seen in remote-registers
  {'name': 'CPUACTLR', 'regnum': 114} wasn't seen in remote-registers
  {'name': 'CPUECTLR', 'regnum': 127} wasn't seen in remote-registers
  {'name': 'CPUMERRSR', 'regnum': 140} wasn't seen in remote-registers
  {'name': 'TTBR1', 'regnum': 148} wasn't seen in remote-registers
  {'name': 'L2MERRSR', 'regnum': 161} wasn't seen in remote-registers
  {'name': 'TTBR0', 'regnum': 168} wasn't seen in remote-registers

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org
Cc: Luis Machado <luis.machado@arm.com>
---
 tests/tcg/multiarch/gdbstub/registers.py | 80 ++++++++++++++++++------
 tests/tcg/ppc64/Makefile.target          |  7 ---
 tests/tcg/s390x/Makefile.target          |  4 --
 3 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
index ff6076b09e..342d6fd78f 100644
--- a/tests/tcg/multiarch/gdbstub/registers.py
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -44,7 +44,6 @@ def fetch_xml_regmap():
 
     total_regs = 0
     reg_map = {}
-    frame = gdb.selected_frame()
 
     tree = ET.fromstring(xml)
     for f in tree.findall("feature"):
@@ -61,12 +60,8 @@ def fetch_xml_regmap():
         for r in regs:
             name = r.attrib["name"]
             regnum = int(r.attrib["regnum"])
-            try:
-                value = frame.read_register(name)
-            except ValueError:
-                report(False, f"failed to read reg: {name}")
 
-            entry = { "name": name, "initial": value, "regnum": regnum }
+            entry = { "name": name, "regnum": regnum }
 
             if name in reg_map:
                 report(False, f"duplicate register {entry} vs {reg_map[name]}")
@@ -80,6 +75,15 @@ def fetch_xml_regmap():
 
     return reg_map
 
+def get_register_by_regnum(reg_map, regnum):
+    """
+    Helper to find a register from the map via its XML regnum
+    """
+    for regname, entry in reg_map.items():
+        if entry['regnum'] == regnum:
+            return entry
+    return None
+
 def crosscheck_remote_xml(reg_map):
     """
     Cross-check the list of remote-registers with the XML info.
@@ -90,6 +94,7 @@ def crosscheck_remote_xml(reg_map):
 
     total_regs = len(reg_map.keys())
     total_r_regs = 0
+    total_r_elided_regs = 0
 
     for r in r_regs:
         fields = r.split()
@@ -100,6 +105,15 @@ def crosscheck_remote_xml(reg_map):
             r_name = fields[0]
             r_regnum = int(fields[6])
 
+            # Some registers are "hidden" so don't have a name
+            # although they still should have a register number
+            if r_name == "''":
+                total_r_elided_regs += 1
+                x_reg = get_register_by_regnum(reg_map, r_regnum)
+                if x_reg is not None:
+                    x_reg["hidden"] = True
+                continue
+
             # check in the XML
             try:
                 x_reg = reg_map[r_name]
@@ -118,14 +132,40 @@ def crosscheck_remote_xml(reg_map):
     # registers on a 32 bit machine. Also print what is missing to
     # help with debug.
     if total_regs != total_r_regs:
-        print(f"xml-tdesc has ({total_regs}) registers")
-        print(f"remote-registers has ({total_r_regs}) registers")
+        print(f"xml-tdesc has {total_regs} registers")
+        print(f"remote-registers has {total_r_regs} registers")
+        print(f"of which {total_r_elided_regs} are hidden")
 
         for x_key in reg_map.keys():
             x_reg = reg_map[x_key]
-            if "seen" not in x_reg:
+            if "hidden" in x_reg:
+                print(f"{x_reg} elided by gdb")
+            elif "seen" not in x_reg:
                 print(f"{x_reg} wasn't seen in remote-registers")
 
+def initial_register_read(reg_map):
+    """
+    Do an initial read of all registers that we know gdb cares about
+    (so ignore the elided ones).
+    """
+    frame = gdb.selected_frame()
+
+    for e in reg_map.values():
+        name = e["name"]
+        regnum = e["regnum"]
+
+        try:
+            if "hidden" in e:
+                value = frame.read_register(regnum)
+                e["initial"] = value
+            elif "seen" in e:
+                value = frame.read_register(name)
+                e["initial"] = value
+
+        except ValueError:
+                report(False, f"failed to read reg: {name}")
+
+
 def complete_and_diff(reg_map):
     """
     Let the program run to (almost) completion and then iterate
@@ -144,18 +184,19 @@ def complete_and_diff(reg_map):
     changed = 0
 
     for e in reg_map.values():
-        name = e["name"]
-        old_val = e["initial"]
+        if "initial" in e and "hidden" not in e:
+            name = e["name"]
+            old_val = e["initial"]
 
-        try:
-            new_val = frame.read_register(name)
-        except:
-            report(False, f"failed to read {name} at end of run")
-            continue
+            try:
+                new_val = frame.read_register(name)
+            except ValueError:
+                report(False, f"failed to read {name} at end of run")
+                continue
 
-        if new_val != old_val:
-            print(f"{name} changes from {old_val} to {new_val}")
-            changed += 1
+            if new_val != old_val:
+                print(f"{name} changes from {old_val} to {new_val}")
+                changed += 1
 
     # as long as something changed we can be confident its working
     report(changed > 0, f"{changed} registers were changed")
@@ -168,6 +209,7 @@ def run_test():
 
     if reg_map is not None:
         crosscheck_remote_xml(reg_map)
+        initial_register_read(reg_map)
         complete_and_diff(reg_map)
 
 
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 1d08076756..5721c159f2 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -38,11 +38,4 @@ PPC64_TESTS += signal_save_restore_xer
 PPC64_TESTS += xxspltw
 PPC64_TESTS += test-aes
 
-ifneq ($(GDB),)
-# Skip for now until vsx registers sorted out
-run-gdbstub-registers:
-	$(call skip-test, $<, "BROKEN reading VSX registers")
-endif
-
-
 TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 46544fecd4..0e670f3f8b 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -103,10 +103,6 @@ run-gdbstub-svc: hello-s390x-asm
 		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
 	single-stepping svc)
 
-# Skip for now until vx registers sorted out
-run-gdbstub-registers:
-	$(call skip-test, $<, "BROKEN reading VX registers")
-
 EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
 endif
 
-- 
2.39.2


