Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CD7E1D57
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzw4i-00009a-LL; Mon, 06 Nov 2023 04:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw4f-00008p-BQ; Mon, 06 Nov 2023 04:39:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw4d-0005F9-OL; Mon, 06 Nov 2023 04:39:13 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A69AmBY001921; Mon, 6 Nov 2023 09:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lSaFxJPvT7e8nzANNa19smtci0ZflBpCT5v4zjDKZ/g=;
 b=s1npyrALc1o95EEriCR0HSUJ+2u57hHxYDMSFgFVb3wyCZepXg4tfRkoJCs+xVuz5hsV
 Dly01El+LBKlzS5UikhPjnHDFMrWAhkOnmGjkJyjsRsYrnh8EYB7ogRGsDIzt5VgQcIk
 nOXmwb8I9U1fMlUw2g1tSWEdbjRVBIeVR3/AY4VTwCk+zkYYNNDg5hjGjfRsl+jsQF7A
 AXz1Hp86toz80d0Kec/WxIQASfOq1D90UpMcTCykiUrNS/z3vJA1vZZubbDjgV22mn0R
 WOjg4ofsf9IZC9LLaqD5/M6rbhog4Pg7vhZVRC+ne4fZUk8bw8Pkrw45tWp3x9rBtAWP 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vn5a2mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:39:07 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A68RPtI013721;
 Mon, 6 Nov 2023 09:39:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vn5a1pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:39:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A68S0T3025671; Mon, 6 Nov 2023 09:36:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619n8a2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69aFGn45351616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:36:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 068322004B;
 Mon,  6 Nov 2023 09:36:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD2620040;
 Mon,  6 Nov 2023 09:36:14 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:36:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/5] tests/tcg/s390x: Test CLC with inaccessible second
 operand
Date: Mon,  6 Nov 2023 10:31:23 +0100
Message-ID: <20231106093605.1349201-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106093605.1349201-1-iii@linux.ibm.com>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qaae0zSGPSPK9hBkSwFwDYAyBIIXFG0a
X-Proofpoint-ORIG-GUID: SUGKdnFD6_D5AZmib-_JHeEJf6dDY5m9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=836
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060082
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/clc.c           | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/s390x/clc.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 826f0a18e43..ccd4f4e68de 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -41,6 +41,7 @@ TESTS+=larl
 TESTS+=mdeb
 TESTS+=cgebra
 TESTS+=clgebr
+TESTS+=clc
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/clc.c b/tests/tcg/s390x/clc.c
new file mode 100644
index 00000000000..e14189bd75e
--- /dev/null
+++ b/tests/tcg/s390x/clc.c
@@ -0,0 +1,48 @@
+/*
+ * Test the CLC instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void handle_sigsegv(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+    if (mcontext->gregs[0] != 600) {
+        write(STDERR_FILENO, "bad r0\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    if (((mcontext->psw.mask >> 44) & 3) != 1) {
+        write(STDERR_FILENO, "bad cc\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    _exit(EXIT_SUCCESS);
+}
+
+int main(void)
+{
+    register unsigned long r0 asm("r0");
+    unsigned long mem = 42, rhs = 500;
+    struct sigaction act;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigsegv;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGSEGV, &act, NULL);
+    assert(err == 0);
+
+    r0 = 100;
+    asm("algr %[r0],%[rhs]\n"
+        "clc 0(8,%[mem]),0(0)\n"  /* The 2nd operand will cause a SEGV. */
+        : [r0] "+r" (r0)
+        : [mem] "r" (&mem)
+        , [rhs] "r" (rhs)
+        : "cc", "memory");
+
+    return EXIT_FAILURE;
+}
-- 
2.41.0


