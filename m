Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB375844938
	for <lists+qemu-devel@lfdr.de>; Wed, 31 Jan 2024 21:55:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHbe-0006Fy-46; Wed, 31 Jan 2024 15:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHbc-0006Fp-GT
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:54:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHbZ-0004u4-S9
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:54:48 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VK2FUJ009375; Wed, 31 Jan 2024 20:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L3Z9+nhyBICaehShvjw4ME9IXqKkq3Uok4wamwkerx4=;
 b=acvQn6Mj1xTwBsIjUlpwTG+ET4xpdtkjIrAr/X7C8Wh1c+DywCQdHYBZk7GOKs09QzMO
 b0/dgoHcOCFF5IVHbUg87q+f/Hm3YO8LrRD9RsSFli+5QdUo8hGBBOvuU8Hd4NEX1Evf
 owtjHd2bHPi8vBaqD+6IkdOesSpq+OfSZB7vzKDJ0S5mv8kAatMnw55LfEB1w18kDhYZ
 LIoTEJVspiN3o9owJ0e3oZLbVJNGAAWjSgDG9TS7GRst3HjnsW1M3Jabs2gYkyEHXGfs
 PRtIIO4/GdMjEyHFmJtRWqEY1dXxvxbWXc8EoVshSyEqaaOdgFtAXmwFmzoneN/LO6S0 Jw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyvvws6n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:54:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VKPCZa017772; Wed, 31 Jan 2024 20:50:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyyxw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VKoghe54919428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 20:50:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04C6B20043;
 Wed, 31 Jan 2024 20:50:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 984EF20040;
 Wed, 31 Jan 2024 20:50:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 20:50:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] tests/tcg: Add two follow-fork-mode tests
Date: Wed, 31 Jan 2024 21:43:41 +0100
Message-ID: <20240131205031.144607-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131205031.144607-1-iii@linux.ibm.com>
References: <20240131205031.144607-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pLYOL3uAl0esaTfYeOYBCQ8nrwAYqnvN
X-Proofpoint-ORIG-GUID: pLYOL3uAl0esaTfYeOYBCQ8nrwAYqnvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=995 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add follow-fork-mode child and and follow-fork-mode parent tests.
Check for the obvious pitfalls, such as lingering breakpoints,
catchpoints, and single-step mode.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target           | 17 +++++-
 tests/tcg/multiarch/follow-fork-mode.c        | 56 +++++++++++++++++++
 .../gdbstub/follow-fork-mode-child.py         | 40 +++++++++++++
 .../gdbstub/follow-fork-mode-parent.py        | 16 ++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index e10951a8016..b8b70c81860 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -115,6 +115,20 @@ run-gdbstub-catch-syscalls: catch-syscalls
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
 	hitting a syscall catchpoint)
 
+run-gdbstub-follow-fork-mode-child: follow-fork-mode
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-child.py, \
+	following children on fork)
+
+run-gdbstub-follow-fork-mode-parent: follow-fork-mode
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
+	following parents on fork)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
@@ -122,7 +136,8 @@ endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls
+	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
+	      run-gdbstub-follow-fork-mode-parent
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/follow-fork-mode.c b/tests/tcg/multiarch/follow-fork-mode.c
new file mode 100644
index 00000000000..cb6b032b388
--- /dev/null
+++ b/tests/tcg/multiarch/follow-fork-mode.c
@@ -0,0 +1,56 @@
+/*
+ * Test GDB's follow-fork-mode.
+ *
+ * fork() a chain of processes.
+ * Parents sends one byte to their children, and children return their
+ * position in the chain, in order to prove that they survived GDB's fork()
+ * handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+void break_after_fork(void)
+{
+}
+
+int main(void)
+{
+    int depth = 42, err, i, fd[2], status;
+    pid_t child, pid;
+    ssize_t n;
+    char b;
+
+    for (i = 0; i < depth; i++) {
+        err = pipe(fd);
+        assert(err == 0);
+        child = fork();
+        break_after_fork();
+        assert(child != -1);
+        if (child == 0) {
+            close(fd[1]);
+
+            n = read(fd[0], &b, 1);
+            close(fd[0]);
+            assert(n == 1);
+            assert(b == (char)i);
+        } else {
+            close(fd[0]);
+
+            b = (char)i;
+            n = write(fd[1], &b, 1);
+            close(fd[1]);
+            assert(n == 1);
+
+            pid = waitpid(child, &status, 0);
+            assert(pid == child);
+            assert(WIFEXITED(status));
+            return WEXITSTATUS(status) - 1;
+        }
+    }
+
+    return depth;
+}
diff --git a/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py b/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
new file mode 100644
index 00000000000..72a6e440c08
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
@@ -0,0 +1,40 @@
+"""Test GDB's follow-fork-mode child.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.execute("set follow-fork-mode child")
+    # Check that the parent breakpoints are unset.
+    gdb.execute("break break_after_fork")
+    # Check that the parent syscall catchpoints are unset.
+    # Skip this check on the architectures that don't have them.
+    have_fork_syscall = False
+    for fork_syscall in ("fork", "clone", "clone2", "clone3"):
+        try:
+            gdb.execute("catch syscall {}".format(fork_syscall))
+        except gdb.error:
+            pass
+        else:
+            have_fork_syscall = True
+    gdb.execute("continue")
+    for i in range(42):
+        if have_fork_syscall:
+            # syscall entry.
+            if i % 2 == 0:
+                # Check that the parent single-stepping is turned off.
+                gdb.execute("si")
+            else:
+                gdb.execute("continue")
+            # syscall exit.
+            gdb.execute("continue")
+        # break_after_fork()
+        gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 42, "{} == 42".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py b/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py
new file mode 100644
index 00000000000..5c2fe722088
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py
@@ -0,0 +1,16 @@
+"""Test GDB's follow-fork-mode parent.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.execute("set follow-fork-mode parent")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.43.0


