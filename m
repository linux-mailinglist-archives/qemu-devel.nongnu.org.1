Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389977F16DD
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55ty-0006gD-M8; Mon, 20 Nov 2023 10:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tU-0005v8-8r
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tG-0001J4-FF
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so18221305e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492924; x=1701097724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8kjzVNoA7e3cvqH6712uj0UfEN18Da8qVe7RzxNxzg=;
 b=s90ZyPdy82Yrqg579JYbDvzGJF3c7EglpDX0o35QKX76cq5VqKFUEJDSgjL6vGNafe
 kx06A0He0O65aLvpQxF3ZhBg8MLslq7Oy5fF/IOESm0QiIB9oXtb3CZKD+DgT3i0N13V
 qkTlv24sMVSfgWtO7Yh7bzos63KUOKjEWig+g9MbwP904/OLuh0iuYOBDe4AO8la5cN5
 fIdAXIhbJZKAU+9ECk1/6eVgTWNfyy6zi8yTGU7tqln87LeyRXuRI6x90tTv4s4lbQfC
 wrWQSEUZK1vTkc484vrtWiO3j/hCGCqsSQaaueonG0mel7U1Kyk+YoKKco4cVjFOWhDx
 qfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492924; x=1701097724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8kjzVNoA7e3cvqH6712uj0UfEN18Da8qVe7RzxNxzg=;
 b=R9q+jnSm6jOmLDXlqKPvgLhpODWmjIJecL9lSuj3OdIetKNHA+gZqTzNgy8nsPzoCD
 k8r7EmUDjEygLVLVMGGfdKKCbOdsYnTJ800zzloy1DebuWN2fqD18x9cITN/0YNQtJEp
 MKXOlnUHuSfWL7j6uiUT8X9Nz8Bdyi5t9HIHhZ5bVVRZYOuBp9Dh9fq+QIk+z8ph4pcF
 fETFNDcjP/wIdMyfjE3aR44P/HSEpsmlcDPvIJ9/08FoReH1gKasJA7bG23lcz06mMFY
 sVJi1izjEWmkVTBI31l9sK9rRVFoppStq2Qf8Sxv8pm9am+yQuv9/LopYRH/XeabVOeB
 Pe0Q==
X-Gm-Message-State: AOJu0Yyjw68sJT0nqRaCg/yzZ/VLwKNKj+YJF93W9+WzlzhvoRJg4EgA
 kJ3Uhay1853X3BNO9MvLMKVfrQ==
X-Google-Smtp-Source: AGHT+IFtrpKoOweyLBVbJYsULSquKdUfZt6SKEqmItg6UkkT+VYKxxReEaau/NnnqZgOpjdO1OuFHw==
X-Received: by 2002:a05:600c:3108:b0:409:7aa9:a903 with SMTP id
 g8-20020a05600c310800b004097aa9a903mr6252825wmo.19.1700492924535; 
 Mon, 20 Nov 2023 07:08:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c190700b004064cd71aa8sm13821581wmq.34.2023.11.20.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 456B16577B;
 Mon, 20 Nov 2023 15:08:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Luis Machado <luis.machado@arm.com>
Subject: [PATCH v2 14/14] tests/tcg: finesse the registers check for "hidden"
 regs
Date: Mon, 20 Nov 2023 15:08:33 +0000
Message-Id: <20231120150833.2552739-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
v2
  - skip if check for total_regs != total_r_regs and always dump what
    is elided/missed
---
 tests/tcg/multiarch/gdbstub/registers.py | 87 +++++++++++++++++-------
 tests/tcg/ppc64/Makefile.target          |  7 --
 tests/tcg/s390x/Makefile.target          |  4 --
 3 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
index ff6076b09e..8ba14099b5 100644
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
@@ -117,14 +131,39 @@ def crosscheck_remote_xml(reg_map):
     # Just print a mismatch in totals as gdb will filter out 64 bit
     # registers on a 32 bit machine. Also print what is missing to
     # help with debug.
-    if total_regs != total_r_regs:
-        print(f"xml-tdesc has ({total_regs}) registers")
-        print(f"remote-registers has ({total_r_regs}) registers")
+    print(f"xml-tdesc has {total_regs} registers")
+    print(f"remote-registers has {total_r_regs} registers")
+    print(f"of which {total_r_elided_regs} are hidden")
+
+    for x_key in reg_map.keys():
+        x_reg = reg_map[x_key]
+        if "hidden" in x_reg:
+            print(f"{x_reg} elided by gdb")
+        elif "seen" not in x_reg:
+            print(f"{x_reg} wasn't seen in remote-registers")
+
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
 
-        for x_key in reg_map.keys():
-            x_reg = reg_map[x_key]
-            if "seen" not in x_reg:
-                print(f"{x_reg} wasn't seen in remote-registers")
 
 def complete_and_diff(reg_map):
     """
@@ -144,18 +183,19 @@ def complete_and_diff(reg_map):
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
@@ -168,6 +208,7 @@ def run_test():
 
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


