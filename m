Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F782E56E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 01:42:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXWk-0001Md-3c; Mon, 15 Jan 2024 19:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWi-0001ME-7R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:42:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWg-0000xS-Bd
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:41:59 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40G00MF6027499; Tue, 16 Jan 2024 00:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oj/gpNPd5eHDZ/XSLkNUkxw/MEUtCzSfoyCEj5Ng0T4=;
 b=CYXn7mECIqs/UK/HR1L65bcU7bPPlZe5ymEroz0Kx8aI3KI5itwvJtZ0R4n1uQmb6D32
 tJXC322uiEEyI3BNCNrbV/o8PmzMGtY8Ll/qy20KEYhpbDI7h0giMkvRl/bOUwcEu5D9
 WDQ3WGyewKL/0+0RawKuhxSUpWxpXEYMcd79bc0KUPhDKhwOMtwcLmX36jYNFEnw6fqQ
 d9ptspGrzHrzdlrAPPrl1A9nRfWMsQRDGCn9ioBkttxJizyj4+4dyac1bemk9nyTRzLV
 wX5VqwlLoSbP3p+RPsRiQ/QJekrVnDJjeY0HrAIrWtvnh7lUM+TymF9e2OkhmCk040tw iw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnbwhc8dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FMLgS3026526; Tue, 16 Jan 2024 00:41:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72ju55p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G0foDX29229750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 00:41:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3659720043;
 Tue, 16 Jan 2024 00:41:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB9C720040;
 Tue, 16 Jan 2024 00:41:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 00:41:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg: Add the syscall catchpoint gdbstub test
Date: Tue, 16 Jan 2024 01:40:12 +0100
Message-ID: <20240116004141.78626-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116004141.78626-1-iii@linux.ibm.com>
References: <20240116004141.78626-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nQLJn1TXnvtuVINeIJmyFmzPF4RHPulL
X-Proofpoint-ORIG-GUID: nQLJn1TXnvtuVINeIJmyFmzPF4RHPulL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=967 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160002
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

Check that adding/removing syscall catchpoints works.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target           | 10 +++-
 tests/tcg/multiarch/catch-syscalls.c          | 51 ++++++++++++++++++
 tests/tcg/multiarch/gdbstub/catch-syscalls.py | 52 +++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 315a2e13588..e10951a8016 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -108,13 +108,21 @@ run-gdbstub-prot-none: prot-none
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
 	accessing PROT_NONE memory)
 
+run-gdbstub-catch-syscalls: catch-syscalls
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
+	hitting a syscall catchpoint)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers run-gdbstub-prot-none
+	      run-gdbstub-registers run-gdbstub-prot-none \
+	      run-gdbstub-catch-syscalls
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/catch-syscalls.c b/tests/tcg/multiarch/catch-syscalls.c
new file mode 100644
index 00000000000..d1ff1936a7a
--- /dev/null
+++ b/tests/tcg/multiarch/catch-syscalls.c
@@ -0,0 +1,51 @@
+/*
+ * Test GDB syscall catchpoints.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <unistd.h>
+
+const char *catch_syscalls_state = "start";
+
+void end_of_main(void)
+{
+}
+
+int main(void)
+{
+    int ret = EXIT_FAILURE;
+    char c0 = 'A', c1;
+    int fd[2];
+
+    catch_syscalls_state = "pipe2";
+    if (pipe2(fd, 0)) {
+        goto out;
+    }
+
+    catch_syscalls_state = "write";
+    if (write(fd[1], &c0, sizeof(c0)) != sizeof(c0)) {
+        goto out_close;
+    }
+
+    catch_syscalls_state = "read";
+    if (read(fd[0], &c1, sizeof(c1)) != sizeof(c1)) {
+        goto out_close;
+    }
+
+    catch_syscalls_state = "check";
+    if (c0 == c1) {
+        ret = EXIT_SUCCESS;
+    }
+
+out_close:
+    catch_syscalls_state = "close";
+    close(fd[0]);
+    close(fd[1]);
+
+out:
+    catch_syscalls_state = "end";
+    end_of_main();
+    return ret;
+}
diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
new file mode 100644
index 00000000000..8bab12537fc
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
@@ -0,0 +1,52 @@
+"""Test GDB syscall catchpoints.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def check_state(expected):
+    """Check the catch_syscalls_state value"""
+    actual = gdb.parse_and_eval("catch_syscalls_state").string()
+    report(actual == expected, "{} == {}".format(actual, expected))
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.Breakpoint("main")
+    gdb.execute("continue")
+
+    # Check that GDB stops for pipe2/read calls/returns, but not for write.
+    gdb.execute("delete")
+    try:
+        gdb.execute("catch syscall pipe2 read")
+    except gdb.error as exc:
+        exc_str = str(exc)
+        if "not supported on this architecture" in exc_str:
+            print("SKIP: {}".format(exc_str))
+            return
+    for _ in range(2):
+        gdb.execute("continue")
+        check_state("pipe2")
+    for _ in range(2):
+        gdb.execute("continue")
+        check_state("read")
+
+    # Check that deletion works.
+    gdb.execute("delete")
+    gdb.Breakpoint("end_of_main")
+    gdb.execute("continue")
+    check_state("end")
+
+    # Check that catch-all works (libc should at least call exit).
+    gdb.execute("delete")
+    gdb.execute("catch syscall")
+    gdb.execute("continue")
+    gdb.execute("delete")
+    gdb.execute("continue")
+
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.43.0


