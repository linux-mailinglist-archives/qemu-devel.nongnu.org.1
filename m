Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F45772310
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyjz-0007jm-Ae; Mon, 07 Aug 2023 07:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSyjt-0007jT-Rs; Mon, 07 Aug 2023 07:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSyjr-00072H-NV; Mon, 07 Aug 2023 07:49:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377BfEYd024891; Mon, 7 Aug 2023 11:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u8PbF4C/BdyBy3te61zsAsS/C4MMsKbgrURDz34c4nk=;
 b=ZqOScx4yKq2scL7Lk/oCO62cZyJaMT0oPgXKuhLPCALBH9mFlxYYseyuc8OWrS3brgyJ
 7rbMB0CvA3+QOyYPi4PVFXqtnBUc7fUtY3jr7ZdUfORxTt+Wgey3S6w4XNBAQySb0ZzA
 HQUgNQUgnsfISUGiCtMR0V3CoV0UdxRy9lanNmKtPGGbVu11o3G/3QMli8bLINz2Wt4I
 EZ/Z3++8Ruvl2ptw69aHlLN767LVx4Kn0qSC9/VUiAUWRTUACPThJ0NwzTR+8VNjHhwZ
 os+lkw/SaPwih5TpoEPJB2KWMj0idsHz/QBquxO7ljawz3jg4+FFTe6D04hVjpSB9t2G FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sayqyreew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 11:49:28 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377Bhk8i032003;
 Mon, 7 Aug 2023 11:49:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sayqyreeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 11:49:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377A95mf007543; Mon, 7 Aug 2023 11:49:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14xw0dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 11:49:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377BnP6N59638252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 11:49:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A478D20049;
 Mon,  7 Aug 2023 11:49:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82E0320040;
 Mon,  7 Aug 2023 11:49:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 11:49:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test precise self-modifying code handling
Date: Mon,  7 Aug 2023 13:48:21 +0200
Message-ID: <20230807114921.438881-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807114921.438881-1-iii@linux.ibm.com>
References: <20230807114921.438881-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g_4HrDBDVIjgTZILMSB1q7taEBo1ardD
X-Proofpoint-ORIG-GUID: 6cCITDaFUbfx57azgUCbXQ2vctDbMjYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_10,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add small softmmu and user tests to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/Makefile.target         |  1 +
 tests/tcg/s390x/precise-smc-softmmu.S   | 63 +++++++++++++++++++++++++
 tests/tcg/s390x/precise-smc-user.c      | 39 +++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 tests/tcg/s390x/precise-smc-softmmu.S
 create mode 100644 tests/tcg/s390x/precise-smc-user.c

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 76345b6e643..1a1f088b280 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -25,6 +25,7 @@ ASM_TESTS =                                                                    \
     lpswe-early                                                                \
     lra                                                                        \
     mc                                                                         \
+    precise-smc-softmmu                                                        \
     ssm-early                                                                  \
     stosm-early                                                                \
     stpq                                                                       \
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 4f3793532bf..b5f88c20fc6 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -60,6 +60,7 @@ Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
+Z13_TESTS+=precise-smc-user
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/precise-smc-softmmu.S b/tests/tcg/s390x/precise-smc-softmmu.S
new file mode 100644
index 00000000000..f7fa57d899d
--- /dev/null
+++ b/tests/tcg/s390x/precise-smc-softmmu.S
@@ -0,0 +1,63 @@
+/*
+ * Test s390x-softmmu precise self-modifying code handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .org 0x8e
+program_interruption_code:
+    .org 0x150
+program_old_psw:
+    .org 0x1D0                         /* program new PSW */
+    .quad 0x180000000,pgm              /* 64-bit mode */
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lctlg %c0,%c0,c0
+    lghi %r0,15
+
+    /* Test 1: replace sgr with agr. */
+    lghi %r1,21
+    vl %v0,patch1
+    jg 1f                              /* start a new TB */
+0:
+    .org . + 6                         /* pad patched code to 16 bytes */
+1:
+    vstl %v0,%r0,0b                    /* start writing before TB */
+    sgr %r1,%r1                        /* this becomes `agr %r1,%r1` */
+    cgijne %r1,42,failure
+
+    /* Test 2: replace agr with division by zero. */
+    vl %v0,patch2
+    jg 1f                              /* start a new TB */
+0:
+    .org . + 6                         /* pad patched code to 16 bytes */
+1:
+    vstl %v0,%r0,0b                    /* start writing before TB */
+    sgr %r1,%r1                        /* this becomes `d %r0,zero` */
+failure:
+    lpswe failure_psw
+
+pgm:
+    chhsi program_interruption_code,0x9          /* divide exception? */
+    jne failure
+    clc program_old_psw(16),expected_old_psw2    /* correct old PSW? */
+    jne failure
+    lpswe success_psw
+
+patch1:
+    .fill 12                           /* replaces padding and stpq */
+    agr %r1,%r1                        /* replaces sgr */
+patch2:
+    .fill 12                           /* replaces padding and stpq */
+    d %r0,zero                         /* replaces sgr */
+zero:
+    .long 0
+expected_old_psw2:
+    .quad 0x200180000000,failure       /* cc is from addition */
+    .align 8
+c0:
+    .quad 0x60000                      /* AFP, VX */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
diff --git a/tests/tcg/s390x/precise-smc-user.c b/tests/tcg/s390x/precise-smc-user.c
new file mode 100644
index 00000000000..33a5270865c
--- /dev/null
+++ b/tests/tcg/s390x/precise-smc-user.c
@@ -0,0 +1,39 @@
+/*
+ * Test s390x-linux-user precise self-modifying code handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <sys/mman.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+extern __uint128_t __attribute__((__aligned__(1))) smc;
+extern __uint128_t __attribute__((__aligned__(1))) patch;
+
+int main(void)
+{
+    char *aligned_smc = (char *)((uintptr_t)&smc & ~0xFFFULL);
+    char *smc_end = (char *)&smc + sizeof(smc);
+    uint64_t value = 21;
+    int err;
+
+    err = mprotect(aligned_smc, smc_end - aligned_smc,
+                   PROT_READ | PROT_WRITE | PROT_EXEC);
+    assert(err == 0);
+
+    asm("jg 0f\n"                           /* start a new TB */
+        "patch: .byte 0,0,0,0,0,0\n"        /* replaces padding */
+        ".byte 0,0,0,0,0,0\n"               /* replaces vstl */
+        "agr %[value],%[value]\n"           /* replaces sgr */
+        "smc: .org . + 6\n"                 /* pad patched code to 16 bytes */
+        "0: vstl %[patch],%[idx],%[smc]\n"  /* start writing before TB */
+        "sgr %[value],%[value]"             /* this becomes `agr %r0,%r0` */
+        : [smc] "=R" (smc)
+        , [value] "+r" (value)
+        : [patch] "v" (patch)
+        , [idx] "r" (sizeof(patch) - 1)
+        : "cc");
+
+    return value == 42 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.41.0


