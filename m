Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA1827BA9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:41:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzCj-000251-LF; Mon, 08 Jan 2024 18:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rMzCf-00020d-0i; Mon, 08 Jan 2024 18:38:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rMzCa-0005de-0Z; Mon, 08 Jan 2024 18:38:44 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408NBeHc021941; Mon, 8 Jan 2024 23:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dZ+xaDDcxWjOrjft2MIdhUXVN0DBh7GdHtmsvFjfKAU=;
 b=cCXpwx7Bfi/kRsoeimSKwrMEMBzDPkYSDk/5Z+w+ql1uMiQ7UWjTP2wgjsBWmB/sI1Lv
 YxaYiBDZYwWaYj9uMjhu4M7UQt1GbIQzHmw3wE7OcgeFTsXLpaw3lMPGjpNEOe5XYyY0
 elksxsOceNFHJ82AGdtPoc/EIQ/Kbnupqnt070ePPBvMjaQolnNFJBN8PwdaWIxvuz9P
 3/67tNtWkbj3nhRIP9E+oe3AVj/qgSnIlgMnbdNY8Yb7lraO9h3MKIpeJn3Ny3wdXzi8
 6plgffI05ceZfiEpZ5PwL1WyPd6Q2KhZWQSsbeLCHYmngyRUr9K1YfB3LbuY6kYkbj90 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgsf9a04c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:37 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408NcXMW011408;
 Mon, 8 Jan 2024 23:38:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgsf9a03x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 408KubBI022859; Mon, 8 Jan 2024 23:38:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6nb8m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jan 2024 23:38:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 408NcXM322807086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jan 2024 23:38:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A20B820043;
 Mon,  8 Jan 2024 23:38:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E30C020040;
 Mon,  8 Jan 2024 23:38:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.15.162])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jan 2024 23:38:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] tests/tcg: Factor out gdbstub test functions
Date: Tue,  9 Jan 2024 00:34:07 +0100
Message-ID: <20240108233821.201325-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108233821.201325-1-iii@linux.ibm.com>
References: <20240108233821.201325-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _7WGZU11gg_GeQ8CBOqNs51K7O1SsLHW
X-Proofpoint-GUID: FrgN18lTwrwxfpASSnYLLYZfrDSwxEGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_10,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=942 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080192
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Both the report() function as well as the initial gdbstub test sequence
are copy-pasted into ~10 files with slight modifications. This
indicates that they are indeed generic, so factor them out. While
at it, add a few newlines to make the formatting closer to PEP-8.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/guest-debug/run-test.py                 |  7 ++-
 tests/guest-debug/test_gdbstub.py             | 56 +++++++++++++++++++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +----------
 tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +----------
 tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++--------------
 tests/tcg/multiarch/gdbstub/memory.py         | 41 +-------------
 tests/tcg/multiarch/gdbstub/registers.py      | 41 ++------------
 tests/tcg/multiarch/gdbstub/sha1.py           | 40 ++-----------
 .../multiarch/gdbstub/test-proc-mappings.py   | 39 +------------
 .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +-----------
 .../gdbstub/test-thread-breakpoint.py         | 37 +-----------
 tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +-------------
 tests/tcg/s390x/gdbstub/test-svc.py           | 39 +------------
 13 files changed, 96 insertions(+), 397 deletions(-)
 create mode 100644 tests/guest-debug/test_gdbstub.py

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index b13b27d4b19..368ff8a8903 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -97,7 +97,12 @@ def log(output, msg):
     sleep(1)
     log(output, "GDB CMD: %s" % (gdb_cmd))
 
-    result = subprocess.call(gdb_cmd, shell=True, stdout=output, stderr=stderr)
+    gdb_env = dict(os.environ)
+    gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)
+    gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
+    gdb_env["PYTHONPATH"] = os.pathsep.join(gdb_pythonpath)
+    result = subprocess.call(gdb_cmd, shell=True, stdout=output, stderr=stderr,
+                             env=gdb_env)
 
     # A result of greater than 128 indicates a fatal signal (likely a
     # crash due to gdb internal failure). That's a problem for GDB and
diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
new file mode 100644
index 00000000000..1bc4ed131f4
--- /dev/null
+++ b/tests/guest-debug/test_gdbstub.py
@@ -0,0 +1,56 @@
+"""Helper functions for gdbstub testing
+
+"""
+from __future__ import print_function
+import gdb
+import sys
+
+fail_count = 0
+
+
+def report(cond, msg):
+    """Report success/fail of a test"""
+    if cond:
+        print("PASS: {}".format(msg))
+    else:
+        print("FAIL: {}".format(msg))
+        global fail_count
+        fail_count += 1
+
+
+def main(test, expected_arch=None):
+    """Run a test function
+
+    This runs as the script it sourced (via -x, via run-test.py)."""
+    try:
+        inferior = gdb.selected_inferior()
+        arch = inferior.architecture()
+        print("ATTACHED: {}".format(arch))
+        if expected_arch is not None:
+            report(arch.name() == expected_arch,
+                   "connected to {}".format(expected_arch))
+    except (gdb.error, AttributeError):
+        print("SKIP: not connected")
+        exit(0)
+
+    if gdb.parse_and_eval("$pc") == 0:
+        print("SKIP: PC not set")
+        exit(0)
+
+    try:
+        test()
+    except:
+        print("GDB Exception: {}".format(sys.exc_info()[0]))
+        global fail_count
+        fail_count += 1
+        import code
+        code.InteractiveConsole(locals=globals()).interact()
+        raise
+
+    try:
+        gdb.execute("kill")
+    except gdb.error:
+        pass
+
+    print("All tests complete: %d failures".format(fail_count))
+    exit(fail_count)
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index ee8d467e59d..a78a3a2514d 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -8,19 +8,10 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
 initial_vlen = 0
-failcount = 0
 
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 class TestBreakpoint(gdb.Breakpoint):
     def __init__(self, sym_name="__sve_ld_done"):
@@ -64,26 +55,5 @@ def run_test():
 
     gdb.execute("c")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    report(arch.name() == "aarch64", "connected to aarch64")
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except:
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    import code
-    code.InteractiveConsole(locals=globals()).interact()
-    raise
 
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test, expected_arch="aarch64")
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index afd8ece98dd..84cdcd4a32e 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -6,20 +6,10 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
 MAGIC = 0xDEADBEEF
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -54,24 +44,5 @@ def run_test():
             report(str(v.type) == "uint64_t", "size of %s" % (reg))
             report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    report(arch.name() == "aarch64", "connected to aarch64")
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except:
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-
-print("All tests complete: %d failures" % failcount)
 
-exit(failcount)
+main(run_test, expected_arch="aarch64")
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
index c016e7afbbf..90a45b5140a 100644
--- a/tests/tcg/multiarch/gdbstub/interrupt.py
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -8,19 +8,7 @@
 #
 
 import gdb
-import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def check_interrupt(thread):
@@ -59,6 +47,9 @@ def run_test():
     Test if interrupting the code always lands us on the same thread when
     running with scheduler-lock enabled.
     """
+    if len(gdb.selected_inferior().threads()) == 1:
+        print("SKIP: set to run on a single thread")
+        exit(0)
 
     gdb.execute("set scheduler-locking on")
     for thread in gdb.selected_inferior().threads():
@@ -66,32 +57,4 @@ def run_test():
                "thread %d resumes correctly on interrupt" % thread.num)
 
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-if len(gdb.selected_inferior().threads()) == 1:
-    print("SKIP: set to run on a single thread")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-# Finally kill the inferior and exit gdb with a count of failures
-gdb.execute("kill")
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/gdbstub/memory.py
index fb1d06b7bb7..532b92e7fb3 100644
--- a/tests/tcg/multiarch/gdbstub/memory.py
+++ b/tests/tcg/multiarch/gdbstub/memory.py
@@ -9,18 +9,7 @@
 
 import gdb
 import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def check_step():
@@ -99,29 +88,5 @@ def run_test():
 
     report(cbp.hit_count == 0, "didn't reach backstop")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-# Finally kill the inferior and exit gdb with a count of failures
-gdb.execute("kill")
-exit(failcount)
+
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/registers.py b/tests/tcg/multiarch/gdbstub/registers.py
index 688c0611072..b3d13cb077f 100644
--- a/tests/tcg/multiarch/gdbstub/registers.py
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -7,20 +7,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import gdb
-import sys
 import xml.etree.ElementTree as ET
+from test_gdbstub import main, report
 
-initial_vlen = 0
-failcount = 0
 
-def report(cond, msg):
-    "Report success/fail of test."
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+initial_vlen = 0
 
 
 def fetch_xml_regmap():
@@ -75,6 +66,7 @@ def fetch_xml_regmap():
 
     return reg_map
 
+
 def get_register_by_regnum(reg_map, regnum):
     """
     Helper to find a register from the map via its XML regnum
@@ -84,6 +76,7 @@ def get_register_by_regnum(reg_map, regnum):
             return entry
     return None
 
+
 def crosscheck_remote_xml(reg_map):
     """
     Cross-check the list of remote-registers with the XML info.
@@ -144,6 +137,7 @@ def crosscheck_remote_xml(reg_map):
         elif "seen" not in x_reg:
             print(f"{x_reg} wasn't seen in remote-registers")
 
+
 def initial_register_read(reg_map):
     """
     Do an initial read of all registers that we know gdb cares about
@@ -214,27 +208,4 @@ def run_test():
         complete_and_diff(reg_map)
 
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 416728415f9..1ce711a402c 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -7,19 +7,11 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
+
 
 initial_vlen = 0
-failcount = 0
 
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def check_break(sym_name):
     "Setup breakpoint, continue and check we stopped."
@@ -35,6 +27,7 @@ def check_break(sym_name):
 
     bp.delete()
 
+
 def run_test():
     "Run through the tests one by one"
 
@@ -57,28 +50,5 @@ def run_test():
     # finally check we don't barf inspecting registers
     gdb.execute("info registers")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
-
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 04ec61d2197..564613fabf0 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -3,20 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-import sys
-
-
-n_failures = 0
-
-
-def report(cond, msg):
-    """Report success/fail of a test"""
-    if cond:
-        print("PASS: {}".format(msg))
-    else:
-        print("FAIL: {}".format(msg))
-        global n_failures
-        n_failures += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -37,26 +24,4 @@ def run_test():
     # report("/sha1" in mappings, "Found the test binary name in the mappings")
 
 
-def main():
-    """Prepare the environment and run through the tests"""
-    try:
-        inferior = gdb.selected_inferior()
-        print("ATTACHED: {}".format(inferior.architecture().name()))
-    except (gdb.error, AttributeError):
-        print("SKIPPING (not connected)")
-        exit(0)
-
-    if gdb.parse_and_eval('$pc') == 0:
-        print("SKIP: PC not set")
-        exit(0)
-
-    try:
-        # Run the actual tests
-        run_test()
-    except gdb.error:
-        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
-    print("All tests complete: %d failures" % n_failures)
-    exit(n_failures)
-
-
-main()
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
index 926fa962b77..00c26ab4a95 100644
--- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -6,18 +6,8 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -26,28 +16,5 @@ def run_test():
     report(isinstance(auxv, str), "Fetched auxv from inferior")
     report(auxv.find("sha1"), "Found test binary name in auxv")
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
 
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
index e57d2a8db8b..4d6b6b9fbe7 100644
--- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
+++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
@@ -6,18 +6,8 @@
 #
 
 import gdb
-import sys
+from test_gdbstub import main, report
 
-failcount = 0
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
 
 def run_test():
     "Run through the tests one by one"
@@ -29,28 +19,5 @@ def run_test():
     frame = gdb.selected_frame()
     report(str(frame.function()) == "thread1_func", "break @ %s"%frame)
 
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval('$pc') == 0:
-    print("SKIP: PC not set")
-    exit(0)
-
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
 
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
index ca2bbc0b03e..b6b7b39fc46 100644
--- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
+++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
@@ -7,19 +7,7 @@
 #
 
 import gdb
-import sys
-
-failcount = 0
-
-
-def report(cond, msg):
-    """Report success/fail of test"""
-    if cond:
-        print("PASS: %s" % (msg))
-    else:
-        print("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -42,31 +30,7 @@ def run_test():
     gdb.Breakpoint("_exit")
     gdb.execute("c")
     status = int(gdb.parse_and_eval("$r2"))
-    report(status == 0, "status == 0");
-
-
-#
-# This runs as the script it sourced (via -x, via run-test.py)
-#
-try:
-    inferior = gdb.selected_inferior()
-    arch = inferior.architecture()
-    print("ATTACHED: %s" % arch.name())
-except (gdb.error, AttributeError):
-    print("SKIPPING (not connected)", file=sys.stderr)
-    exit(0)
-
-if gdb.parse_and_eval("$pc") == 0:
-    print("SKIP: PC not set")
-    exit(0)
+    report(status == 0, "status == 0")
 
-try:
-    # Run the actual tests
-    run_test()
-except (gdb.error):
-    print("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    pass
 
-print("All tests complete: %d failures" % failcount)
-exit(failcount)
+main(run_test)
diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 804705fede9..17210b4e020 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -3,20 +3,7 @@
 This runs as a sourced script (via -x, via run-test.py)."""
 from __future__ import print_function
 import gdb
-import sys
-
-
-n_failures = 0
-
-
-def report(cond, msg):
-    """Report success/fail of a test"""
-    if cond:
-        print("PASS: {}".format(msg))
-    else:
-        print("FAIL: {}".format(msg))
-        global n_failures
-        n_failures += 1
+from test_gdbstub import main, report
 
 
 def run_test():
@@ -35,26 +22,4 @@ def run_test():
     gdb.execute("si")
 
 
-def main():
-    """Prepare the environment and run through the tests"""
-    try:
-        inferior = gdb.selected_inferior()
-        print("ATTACHED: {}".format(inferior.architecture().name()))
-    except (gdb.error, AttributeError):
-        print("SKIPPING (not connected)")
-        exit(0)
-
-    if gdb.parse_and_eval('$pc') == 0:
-        print("SKIP: PC not set")
-        exit(0)
-
-    try:
-        # Run the actual tests
-        run_test()
-    except gdb.error:
-        report(False, "GDB Exception: {}".format(sys.exc_info()[0]))
-    print("All tests complete: %d failures" % n_failures)
-    exit(n_failures)
-
-
-main()
+main(run_test)
-- 
2.43.0


