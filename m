Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40F7125F6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Vyx-00034U-9q; Fri, 26 May 2023 07:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2Vyj-0002m9-TG
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyU-0008C5-Hj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBb13O015384; Fri, 26 May 2023 11:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zd4lCrjLjoqz5ghRmdrKomgn7qst/vUfM9oiWXuRTRk=;
 b=XPn6dra6WXaw1GIdUzkiOyokL/dJcS3+NExirtmC0jAFOWPZMxsr9oFMZ+yEtUXgeYhb
 eoampHsGhfWgu90AUxzvxs0KHeBaMyCZGPtRQGljy2nV31ZIrwv9oRqQyeUZQ6AmjQOk
 DTKnjYj0fFVKVrt1cMGp+Yfj8R9Q7dSp9CTvU6hrpjDgnoi5N3w/ETJnhQj/8E3mePFT
 vLrEyIuAkHpzMLX97YgdPdzBwoTKhdVejycblhTWWyBBYryhUWY9MtsDDNtuWkk3Nq/W
 feoSxtQYrLgh1kP5y27tjfM2yMvXhOoQiKjY4dD8f+HYrtBZsMuKXFiE6Y/h9X5/Ed7a JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtupngpb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:12 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QBcDIa019093;
 Fri, 26 May 2023 11:51:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtupngp6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q4lCpS032233;
 Fri, 26 May 2023 11:51:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcuawtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QBovLc57278778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 11:50:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFC3E20040;
 Fri, 26 May 2023 11:50:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29E2820049;
 Fri, 26 May 2023 11:50:57 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.55.92])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 11:50:57 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 6/6] tests/tcg: Add a test for info proc mappings
Date: Fri, 26 May 2023 13:50:41 +0200
Message-Id: <20230526115041.1362009-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526115041.1362009-1-iii@linux.ibm.com>
References: <20230526115041.1362009-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UFDlw50AXiBdsoyhY45rL4Q2IW9qtcEs
X-Proofpoint-GUID: 8ABaibDmj4lH4LSBqxmRRgIItSw2ZxFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=941
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Since there are issues with how GDB interprets QEMU's target.xml,
enable the test only on aarch64 and s390x for now.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/aarch64/Makefile.target             |  3 +-
 tests/tcg/multiarch/Makefile.target           |  7 +++
 .../multiarch/gdbstub/test-proc-mappings.py   | 55 +++++++++++++++++++
 tests/tcg/s390x/Makefile.target               |  2 +-
 4 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 03157954871..38402b0ba1f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -97,7 +97,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	basic gdbstub SVE ZLEN support)
 
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
+EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls \
+              run-gdbstub-proc-mappings
 endif
 endif
 
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 373db696481..cbc0b75787a 100644
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
diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
new file mode 100644
index 00000000000..657e36a2fc7
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -0,0 +1,55 @@
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
+    mappings = gdb.execute("info proc mappings", False, True)
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
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 23dc8b6a63f..73f7cb828e3 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -75,7 +75,7 @@ run-gdbstub-signals-s390x: signals-s390x
 		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
 	mixing signals and debugging)
 
-EXTRA_RUNS += run-gdbstub-signals-s390x
+EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-proc-mappings
 endif
 
 # MVX versions of sha512
-- 
2.40.1


