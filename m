Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82467390D8
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4Zg-0007Ef-0K; Wed, 21 Jun 2023 16:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4Zd-00075n-03; Wed, 21 Jun 2023 16:37:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qC4Zb-0008IO-4Z; Wed, 21 Jun 2023 16:37:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LKGx8R008635; Wed, 21 Jun 2023 20:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TdiIGw6EKMH60FCKoexCpccB5g6GF4b9SqalWcn+2hU=;
 b=YdtarQEUn+cuSxunMKEEPvl9cDjKFcaXGb5lX2Eyf7pVjhYdFKAdSntoMyysss5+LIUc
 ggQah6xG6IXK5MAcy+tCODoXqvF3e4A5DQRQMt0KsEXbUyqroE99F8TiP/52qUVHYUY4
 v165z4K8Nd5BGuAmVq1aGhnPxUaRAF00HUKCKJ2q+vQ2ANvPwOPq8GxEWf1OnN3xWd6o
 E+KCV1bNpnf7/pvvvzzb/JS/aSYfJRp0lIKR16A6B+UtBD2fKGNXdpSQP2Uc3kT1sOtu
 YbvHoCrkSozdnr/fO+U8If4MU0EPOPchFrsTzFIYdQ9aYsKMKvnPwnQoowwYNW/jZR9a Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc83wrf94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:37:00 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LKSFPE012981;
 Wed, 21 Jun 2023 20:36:59 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc83wrf7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:59 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L2eYbW023647;
 Wed, 21 Jun 2023 20:36:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5aa8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 20:36:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LKasWY62390638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 20:36:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 713F120043;
 Wed, 21 Jun 2023 20:36:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5D920040;
 Wed, 21 Jun 2023 20:36:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.1.208])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 20:36:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 8/8] tests/tcg: Add a test for info proc mappings
Date: Wed, 21 Jun 2023 22:36:27 +0200
Message-Id: <20230621203627.1808446-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621203627.1808446-1-iii@linux.ibm.com>
References: <20230621203627.1808446-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e155cBitdUeJE5gm05xsc16-QbLiI91g
X-Proofpoint-ORIG-GUID: SRrfTpcgVgZMnpGjRLgOPsVy6-co75nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=866
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210172
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
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
index 0000000000..a23bbcee7f
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
2.40.1


