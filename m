Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C719F309C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 13:35:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAJC-0002hh-Gg; Mon, 16 Dec 2024 07:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tNAIy-0002VH-AI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:34:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tNAIv-0002MP-BA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:34:32 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG865Ar027742;
 Mon, 16 Dec 2024 12:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RbmIvg6WV9A+b3mU/
 FObKmI+mzX05PtGjHKT+QOCS6g=; b=SikZ98iVtF9xkPswYrLzs0P0pSqiZn2Hn
 BYboUGgrT9jqHifUHQ+OywFMV3gj5zh0EDQ3idKbJeYHKwjhopm0sDV7415j/rlk
 AmDwtxoePOZ3Rq7KnJm7ZiH+cb76R8k2Aziu23Ug2U2jmyv86K5rVkCRauwCg65L
 NEfN1vQ066aa94CcPxooY/gXIFpxnPYLRZEk3kdjLKZaBxg7889G/aUo/h0EwPzx
 vU4IrTjYAGQa6XIuK+lljK20dVZJNjdTx631x8pItac1yU7LkWuKUImF6iZUZJty
 GCBYJgt1Kd6BHB2PyHqnplqDH6Bsbj0qEVPMgXcY2M6XO8gUqzmVA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd295yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 12:34:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8tEWC014350;
 Mon, 16 Dec 2024 12:34:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxx0ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 12:34:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGCYKgs47710674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:34:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56EBE20049;
 Mon, 16 Dec 2024 12:34:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFFA120040;
 Mon, 16 Dec 2024 12:34:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.68.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 12:34:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 8/8] tests/tcg: Add late gdbstub attach test
Date: Mon, 16 Dec 2024 13:33:26 +0100
Message-ID: <20241216123412.77450-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216123412.77450-1-iii@linux.ibm.com>
References: <20241216123412.77450-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XT45QtjWq5S6GVaYvOXDFC2HwjLC0BCr
X-Proofpoint-GUID: XT45QtjWq5S6GVaYvOXDFC2HwjLC0BCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.13, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Make sure that host_interrupt_signal is not visible to the guest.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/guest-debug/run-test.py              | 15 ++++++--
 tests/tcg/multiarch/Makefile.target        |  9 ++++-
 tests/tcg/multiarch/gdbstub/late-attach.py | 28 +++++++++++++++
 tests/tcg/multiarch/late-attach.c          | 41 ++++++++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py
 create mode 100644 tests/tcg/multiarch/late-attach.c

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 5a091db8be9..75e9c92e036 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -36,6 +36,8 @@ def get_args():
     parser.add_argument("--gdb-args", help="Additional gdb arguments")
     parser.add_argument("--output", help="A file to redirect output to")
     parser.add_argument("--stderr", help="A file to redirect stderr to")
+    parser.add_argument("--no-suspend", action="store_true",
+                        help="Ask the binary to not wait for GDB connection")
 
     return parser.parse_args()
 
@@ -73,10 +75,19 @@ def log(output, msg):
 
     # Launch QEMU with binary
     if "system" in args.qemu:
+        if args.no_suspend:
+            suspend = ''
+        else:
+            suspend = ' -S'
         cmd = f'{args.qemu} {args.qargs} {args.binary}' \
-            f' -S -gdb unix:path={socket_name},server=on'
+            f'{suspend} -gdb unix:path={socket_name},server=on'
     else:
-        cmd = f'{args.qemu} {args.qargs} -g {socket_name} {args.binary}'
+        if args.no_suspend:
+            suspend = ',suspend=n'
+        else:
+            suspend = ''
+        cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
+            f' {args.binary}'
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 18d3cf4ae00..688a6be203c 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -130,6 +130,13 @@ run-gdbstub-follow-fork-mode-parent: follow-fork-mode
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
 	following parents on fork)
 
+run-gdbstub-late-attach: late-attach
+	$(call run-test, $@, env LATE_ATTACH_PY=1 $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" --no-suspend \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/late-attach.py, \
+	attaching to a running process)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
@@ -139,7 +146,7 @@ EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read
+	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/late-attach.py b/tests/tcg/multiarch/gdbstub/late-attach.py
new file mode 100644
index 00000000000..1d40efb5ec8
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/late-attach.py
@@ -0,0 +1,28 @@
+"""Test attaching GDB to a running process.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    try:
+        phase = gdb.parse_and_eval("phase").string()
+    except gdb.error:
+        # Assume the guest did not reach main().
+        phase = "start"
+
+    if phase == "start":
+        gdb.execute("break sigwait")
+        gdb.execute("continue")
+        phase = gdb.parse_and_eval("phase").string()
+    report(phase == "sigwait", "{} == \"sigwait\"".format(phase))
+
+    gdb.execute("signal SIGUSR1")
+
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/late-attach.c b/tests/tcg/multiarch/late-attach.c
new file mode 100644
index 00000000000..20a364034b5
--- /dev/null
+++ b/tests/tcg/multiarch/late-attach.c
@@ -0,0 +1,41 @@
+/*
+ * Test attaching GDB to a running process.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static const char *phase = "start";
+
+int main(void)
+{
+    sigset_t set;
+    int sig;
+
+    assert(sigfillset(&set) == 0);
+    assert(sigprocmask(SIG_BLOCK, &set, NULL) == 0);
+
+    /* Let GDB know it can send SIGUSR1. */
+    phase = "sigwait";
+    if (getenv("LATE_ATTACH_PY")) {
+        assert(sigwait(&set, &sig) == 0);
+        if (sig != SIGUSR1) {
+            fprintf(stderr, "Unexpected signal %d\n", sig);
+            return EXIT_FAILURE;
+        }
+    }
+
+    /* Check that the guest does not see host_interrupt_signal. */
+    assert(sigpending(&set) == 0);
+    for (sig = 1; sig < NSIG; sig++) {
+        if (sigismember(&set, sig)) {
+            fprintf(stderr, "Unexpected signal %d\n", sig);
+            return EXIT_FAILURE;
+        }
+    }
+
+    return EXIT_SUCCESS;
+}
-- 
2.47.0


