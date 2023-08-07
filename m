Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2A772B13
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3DL-0005Xg-O3; Mon, 07 Aug 2023 12:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3D9-0005WB-0b; Mon, 07 Aug 2023 12:36:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3D7-0002O6-7p; Mon, 07 Aug 2023 12:36:02 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377GV2OI009644; Mon, 7 Aug 2023 16:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+xYybXbIKfS9RFeeE0c9zMZUlSCmlaTZRkFBOABZcNI=;
 b=D7Frau4HtUCnSUHmeupbDKfmDAQVvXkp/7nly4C5NuvqhtDzklXWgGx48h6x3d6meFxS
 +TpVpcLe7+B8QzQEuwqfCYq+ubIR4p/1X7eS00AyM3d28xLvSALAlJI5pnu0efy5VhYM
 lOZVAT8oXXTvIk3MRVxmNQbVt9s2aPD7P2ErKFNYDLsn2WgoV3DNGgJZduMj4fXZx+wT
 6/UtAgRqniniB7rbsLtDgnR5++dNmgBpTgZzAZEll24apbXWutOyZ7Vh9UPLBKeyjZkw
 HZV4CGwf0wjN6p7dCd+oUfCZ9meh/lQhtcmxzeUskrIb8ayF4NcejlK8xwnMDqcrjgFo UA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb46x0414-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:55 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377GV1Dk009137;
 Mon, 7 Aug 2023 16:35:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb46x040p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377FlZOg015405; Mon, 7 Aug 2023 16:35:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f2gaca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377GZqMV27722328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 16:35:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F1D920043;
 Mon,  7 Aug 2023 16:35:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DACB20040;
 Mon,  7 Aug 2023 16:35:51 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.26.52])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 16:35:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test VREP
Date: Mon,  7 Aug 2023 18:34:32 +0200
Message-ID: <20230807163459.849766-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163459.849766-1-iii@linux.ibm.com>
References: <20230807163459.849766-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KHzGFRgn7qdaL4kiCwQAvnHExSnj4Bp_
X-Proofpoint-GUID: vlYLLxygZ6RYqWIBE89l9lfEVIkSHfNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=969
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/vrep.c          | 81 +++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tests/tcg/s390x/vrep.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 1fc98099070..9548b6d4f51 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -59,6 +59,7 @@ Z13_TESTS=vistr
 Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
+Z13_TESTS+=vrep
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/vrep.c b/tests/tcg/s390x/vrep.c
new file mode 100644
index 00000000000..d5a3bd8eb20
--- /dev/null
+++ b/tests/tcg/s390x/vrep.c
@@ -0,0 +1,81 @@
+/*
+ * Test the VREP instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "vx.h"
+
+static void handle_sigill(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+    char *insn = (char *)info->si_addr;
+
+    if (insn[0] != 0xe7 || insn[5] != 0x4d) {
+        _exit(EXIT_FAILURE);
+    }
+
+    mcontext->gregs[2] = SIGILL;
+}
+
+static inline __attribute__((__always_inline__)) unsigned long
+vrep(S390Vector *v1, const S390Vector *v3, const uint16_t i2, const uint8_t m4)
+{
+    register unsigned long sig asm("r2") = -1;
+
+    asm("vrep %[v1],%[v3],%[i2],%[m4]\n"
+        : [v1] "=v" (v1->v)
+        , [sig] "+r" (sig)
+        : [v3] "v" (v3->v)
+        , [i2] "i" (i2)
+        , [m4] "i" (m4));
+
+    return sig;
+}
+
+int main(int argc, char *argv[])
+{
+    S390Vector v3 = {.d[0] = 1, .d[1] = 2};
+    struct sigaction act;
+    S390Vector v1;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGILL, &act, NULL);
+    assert(err == 0);
+
+    assert(vrep(&v1, &v3, 7, 0) == -1);
+    assert(v1.d[0] == 0x0101010101010101ULL);
+    assert(v1.d[1] == 0x0101010101010101ULL);
+
+    assert(vrep(&v1, &v3, 7, 1) == -1);
+    assert(v1.d[0] == 0x0002000200020002ULL);
+    assert(v1.d[1] == 0x0002000200020002ULL);
+
+    assert(vrep(&v1, &v3, 1, 2) == -1);
+    assert(v1.d[0] == 0x0000000100000001ULL);
+    assert(v1.d[1] == 0x0000000100000001ULL);
+
+    assert(vrep(&v1, &v3, 1, 3) == -1);
+    assert(v1.d[0] == 2);
+    assert(v1.d[1] == 2);
+
+    assert(vrep(&v1, &v3, 0x10, 0) == SIGILL);
+    assert(vrep(&v1, &v3, 0x101, 0) == SIGILL);
+    assert(vrep(&v1, &v3, 0x8, 1) == SIGILL);
+    assert(vrep(&v1, &v3, 0x108, 1) == SIGILL);
+    assert(vrep(&v1, &v3, 0x4, 2) == SIGILL);
+    assert(vrep(&v1, &v3, 0x104, 2) == SIGILL);
+    assert(vrep(&v1, &v3, 0x2, 3) == SIGILL);
+    assert(vrep(&v1, &v3, 0x102, 3) == SIGILL);
+
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


