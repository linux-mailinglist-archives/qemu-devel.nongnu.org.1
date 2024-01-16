Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD282E550
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 01:37:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXRJ-0005iZ-NO; Mon, 15 Jan 2024 19:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPXRB-0005dl-Fn; Mon, 15 Jan 2024 19:36:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPXR8-00086a-A7; Mon, 15 Jan 2024 19:36:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FNwd5b027362; Tue, 16 Jan 2024 00:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yHR/ROIVHnEEoiARJUniG8e0cZDOc3zEQr2XoI/ghDE=;
 b=U176WwEWxvJUVhRPpRGIl4306+Z5mtcYBoPAlCyp+CehN1vff3xb1cggMLh9t4289Kxj
 qZ/BsSNhLsU3syZe6/x0Nv//Yz8Gbjs2gHOwDImvpWp9AVMs50yb9d6z+0a4ANePVLMO
 jBxUURgGpWEzawOYvoa/vZZx0ToEYS82xfaVe3UaYX7qSK4+mrcGYjlFQ16GWrfVfOm5
 cDdN9+gjp/n85o/in3rtZ/gjC0WkNuj3UIIHRJIJjcWwgKKj7Ku32zgrwkH1ZnzGHcqa
 ptchoq8VFSwfZeI20eVclFpkWU6i5CmodjooDXyHcCNoAnZ+RMyWwBkYY6dB8iLJzvQ7 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vneusrqd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40G004g2031202;
 Tue, 16 Jan 2024 00:36:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vneusrqcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FN0CIQ023659; Tue, 16 Jan 2024 00:36:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1jyd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:36:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G0a6vE39518782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 00:36:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 593FE2004B;
 Tue, 16 Jan 2024 00:36:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB5D92004E;
 Tue, 16 Jan 2024 00:36:05 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 00:36:05 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/3] tests/tcg: Add the PROT_NONE gdbstub test
Date: Tue, 16 Jan 2024 01:31:42 +0100
Message-ID: <20240116003551.75168-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116003551.75168-1-iii@linux.ibm.com>
References: <20240116003551.75168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Iv91j7IGw3vGMi_uIW68CGdubxxYZM8
X-Proofpoint-GUID: UemQ3Cq7r2CHpyjTwaQ1wEOKtFY7oYXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
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

Make sure that qemu gdbstub, like gdbserver, allows reading from and
writing to PROT_NONE pages.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target      |  9 +++++-
 tests/tcg/multiarch/gdbstub/prot-none.py | 22 +++++++++++++
 tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py
 create mode 100644 tests/tcg/multiarch/prot-none.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index d31ba8d6ae4..315a2e13588 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -101,13 +101,20 @@ run-gdbstub-registers: sha512
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
 	checking register enumeration)
 
+run-gdbstub-prot-none: prot-none
+	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
+	accessing PROT_NONE memory)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers
+	      run-gdbstub-registers run-gdbstub-prot-none
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
new file mode 100644
index 00000000000..f1f1dd82cbe
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -0,0 +1,22 @@
+"""Test that GDB can access PROT_NONE pages.
+
+This runs as a sourced script (via -x, via run-test.py).
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.Breakpoint("break_here")
+    gdb.execute("continue")
+    val = gdb.parse_and_eval("*(char[2] *)q").string()
+    report(val == "42", "{} == 42".format(val))
+    gdb.execute("set *(char[3] *)q = \"24\"")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
diff --git a/tests/tcg/multiarch/prot-none.c b/tests/tcg/multiarch/prot-none.c
new file mode 100644
index 00000000000..dc56aadb3c5
--- /dev/null
+++ b/tests/tcg/multiarch/prot-none.c
@@ -0,0 +1,40 @@
+/*
+ * Test that GDB can access PROT_NONE pages.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+void break_here(void *q)
+{
+}
+
+int main(void)
+{
+    long pagesize = sysconf(_SC_PAGESIZE);
+    void *p, *q;
+    int err;
+
+    p = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(p != MAP_FAILED);
+    q = p + pagesize - 1;
+    strcpy(q, "42");
+
+    err = mprotect(p, pagesize * 2, PROT_NONE);
+    assert(err == 0);
+
+    break_here(q);
+
+    err = mprotect(p, pagesize * 2, PROT_READ);
+    assert(err == 0);
+    if (getenv("PROT_NONE_PY")) {
+        assert(strcmp(q, "24") == 0);
+    }
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


