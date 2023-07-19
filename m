Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3975920B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:50:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3lf-0002xM-5K; Wed, 19 Jul 2023 05:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lQ-0002dc-95; Wed, 19 Jul 2023 05:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lO-0002sY-7P; Wed, 19 Jul 2023 05:46:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J98exw008338; Wed, 19 Jul 2023 09:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4Cw+bYqMFH0fGAsvrrjxKB7O+h3mER8m3G0w6VwZmxU=;
 b=ZJAwnpQsufUEPpztFaxq73AOywU4kuiiG8UwXUKSe0lgrgkrOaLZbcNSGuKvNeGNQW1r
 s7Fch8jbXcvlR+kdqE4UQn6pNmjHI8j1tjAYFmcA2esuYm881+YHkT2IyrIXN95CpTyB
 GoNbSaISvb4S0H6qzLaWOfvPKri6qHu6w2J7W1CuZXpOQBFVv1kMWurFo2OWbE9CZp7C
 5axx9QCjAlgGJmY/F4aKq+9m+/BO2iFTHMcUOachn4WCWEeg+UmCtYlJAIhRWwDg2rmf
 s4v36EyOmNz1fvhyJAT7WrlSpG1En9DVdSfubnnEZlLv83n4BI4X4Ilx6lMLFqHlgxun gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc9ea4w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9kSN1001011;
 Wed, 19 Jul 2023 09:46:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc9ea4vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J70AC2030687; Wed, 19 Jul 2023 09:46:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jpqgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9kPSH40632740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:46:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51AFD20040;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FD762004B;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 09/14] tests/tcg/s390x: Test CLGEBR and CGEBRA
Date: Wed, 19 Jul 2023 11:44:19 +0200
Message-ID: <20230719094620.363206-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719094620.363206-1-iii@linux.ibm.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bnfOyAwYF2Wdo_g4Os02qVdYvXSoKmPz
X-Proofpoint-ORIG-GUID: XbuPAuHALJTM_x52ufuiDT50L27P44g9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=962 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
 tests/tcg/s390x/Makefile.target |  5 +++++
 tests/tcg/s390x/cgebra.c        | 32 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/clgebr.c        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/s390x/cgebra.c
 create mode 100644 tests/tcg/s390x/clgebr.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 19fbbc6e531..71bf39b78d3 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -39,12 +39,17 @@ TESTS+=mxdb
 TESTS+=epsw
 TESTS+=larl
 TESTS+=mdeb
+TESTS+=cgebra
+TESTS+=clgebr
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
 
 rxsbg: CFLAGS+=-O2
 
+cgebra: LDFLAGS+=-lm
+clgebr: LDFLAGS+=-lm
+
 include $(S390X_SRC)/pgm-specification.mak
 $(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
 $(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
diff --git a/tests/tcg/s390x/cgebra.c b/tests/tcg/s390x/cgebra.c
new file mode 100644
index 00000000000..f91e10d2d3c
--- /dev/null
+++ b/tests/tcg/s390x/cgebra.c
@@ -0,0 +1,32 @@
+/*
+ * Test the CGEBRA instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fenv.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    float r2 = 1E+300;
+    long long r1;
+    int cc;
+
+    feclearexcept(FE_ALL_EXCEPT);
+    asm("cgebra %[r1],%[m3],%[r2],%[m4]\n"
+        "ipm %[cc]\n"
+        : [r1] "=r" (r1)
+        , [cc] "=r" (cc)
+        : [m3] "i" (5) /* round toward 0 */
+        , [r2] "f" (r2)
+        , [m4] "i" (8) /* bit 0 is set, but must be ignored; XxC is not set */
+        : "cc");
+    cc >>= 28;
+
+    assert(r1 == 0x7fffffffffffffffLL);
+    assert(cc == 3);
+    assert(fetestexcept(FE_ALL_EXCEPT) == (FE_INVALID | FE_INEXACT));
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/clgebr.c b/tests/tcg/s390x/clgebr.c
new file mode 100644
index 00000000000..d491899b56e
--- /dev/null
+++ b/tests/tcg/s390x/clgebr.c
@@ -0,0 +1,32 @@
+/*
+ * Test the CLGEBR instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fenv.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    float r2 = -1;
+    long long r1;
+    int cc;
+
+    feclearexcept(FE_ALL_EXCEPT);
+    asm("clgebr %[r1],%[m3],%[r2],%[m4]\n"
+        "ipm %[cc]\n"
+        : [r1] "=r" (r1)
+        , [cc] "=r" (cc)
+        : [m3] "i" (5) /* round toward 0 */
+        , [r2] "f" (r2)
+        , [m4] "i" (8) /* bit 0 is set, but must be ignored; XxC is not set */
+        : "cc");
+    cc >>= 28;
+
+    assert(r1 == 0);
+    assert(cc == 3);
+    assert(fetestexcept(FE_ALL_EXCEPT) == (FE_INVALID | FE_INEXACT));
+
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


