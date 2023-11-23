Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6307F6378
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4H-00063X-AG; Thu, 23 Nov 2023 10:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4E-000625-GV
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C48-0002Oo-Tj
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40b2979a74eso7702325e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754991; x=1701359791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSqXcWmwDT/V/xe8KrlKuVbtZuVfcDSyKh09xHPUjr4=;
 b=cdZbXrNfSApLF+a+XyZtEV9AhVWwmlckHGegHApH1mosmZyAG0sTY8W8z0KuJMT/iG
 kTpIyudU0JC80ioc0S5PsQ91B3EcKzRqpxXh2oQKQPLe8DMOB+Y9t8f1YZBoxIYUvj/d
 OPVI/ZjbRAzV1Uc2G2yIjlLAB6jMhMAP5Sl90UXjtWikvaYfZJzG+Pa7oVDp9umMYGA7
 bRILa4JMg+9n9gecANqulbXnLEqzUMGONppm7N56CpEZRsOXso5boq4+MN34W/PEeRBD
 VvPeUO01WFxWEIL+BQSRpjcCENqyfyCHLpOXxJ6K+ZLDFHoCVAFJ3BpwRlKPEq6bFnL3
 IWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754991; x=1701359791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSqXcWmwDT/V/xe8KrlKuVbtZuVfcDSyKh09xHPUjr4=;
 b=e/8XpRkbwvm231cYVYRGdNJo5yivW4cZ1e1YmWOpY0PXVXPJensfV3eWXygzM6aX2b
 3qp440hyfJCOsUUVBqw0AQkK1XYP7D1TYEyKYItsd/Ohi70dracF/7aVwwXCzyz7+P3y
 THSVgBxFrYf7+ACGwlAKMFglIbQ5Je1OY1W9sNELoxTzMcaIIqKlxSGBd4lNJdJJ4VbI
 HpSYg5oOUJe96uDStKXhMjH+N5pXoYi6DPyL84+6CiirelhCF/RziNeZ7YIoGCXHZ+nW
 bdaIPeJj6exd5kdE8ds7kcI/egp43H7XDbe893HuzBKhB3ehVOxBGGUGp4RrnNe5FAgc
 p6vQ==
X-Gm-Message-State: AOJu0YynaKqms4hrdprr9Jjx2Wm9HZsdvYnqBhLAAaR4bC53xjrt23lh
 Y8ivftrqvfpqupEYe+qmaiKvzQ==
X-Google-Smtp-Source: AGHT+IGjTjUteorPP/oIdoLlCMItsTVodCpxqISqaWRa5gwUGwZAu8Vyxn/SNQnij/P3uS2cX/Om7Q==
X-Received: by 2002:adf:e881:0:b0:329:6b5b:57b8 with SMTP id
 d1-20020adfe881000000b003296b5b57b8mr4304127wrm.25.1700754991114; 
 Thu, 23 Nov 2023 07:56:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x1-20020adfec01000000b003313e4dddecsm2004428wrn.108.2023.11.23.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE55F64601;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
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
Subject: [PULL 14/14] tests/tcg: finesse the registers check for "hidden" regs
Date: Thu, 23 Nov 2023 15:56:20 +0000
Message-Id: <20231123155620.3042891-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We also need to be a bit more careful handling remote-registers as the
format isn't easily parsed with pure white space separation. Once we
fold types like "long long" and "long double" into a single word we
can now assert all registers are either listed or elided.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc:  <qemu-s390x@nongnu.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc:  <qemu-ppc@nongnu.org>
Cc: Luis Machado <luis.machado@arm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231121153606.542101-1-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
index ff6076b09e..688c061107 100644
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
@@ -90,8 +94,11 @@ def crosscheck_remote_xml(reg_map):
 
     total_regs = len(reg_map.keys())
     total_r_regs = 0
+    total_r_elided_regs = 0
 
     for r in r_regs:
+        r = r.replace("long long", "long_long")
+        r = r.replace("long double", "long_double")
         fields = r.split()
         # Some of the registers reported here are "pseudo" registers that
         # gdb invents based on actual registers so we need to filter them
@@ -100,6 +107,15 @@ def crosscheck_remote_xml(reg_map):
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
@@ -114,17 +130,42 @@ def crosscheck_remote_xml(reg_map):
             else:
                 total_r_regs += 1
 
-    # Just print a mismatch in totals as gdb will filter out 64 bit
-    # registers on a 32 bit machine. Also print what is missing to
-    # help with debug.
-    if total_regs != total_r_regs:
-        print(f"xml-tdesc has ({total_regs}) registers")
-        print(f"remote-registers has ({total_r_regs}) registers")
+    report(total_regs == total_r_regs + total_r_elided_regs,
+           "All XML Registers accounted for")
+
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
@@ -144,18 +185,19 @@ def complete_and_diff(reg_map):
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
@@ -168,6 +210,7 @@ def run_test():
 
     if reg_map is not None:
         crosscheck_remote_xml(reg_map)
+        initial_register_read(reg_map)
         complete_and_diff(reg_map)
 
 
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index ca8b929464..8c3e4e4038 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -43,11 +43,4 @@ PPC64_TESTS += signal_save_restore_xer
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


