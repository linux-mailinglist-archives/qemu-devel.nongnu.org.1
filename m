Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97475874F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLsMp-0007aS-Mr; Tue, 18 Jul 2023 17:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMd-0007V0-6R; Tue, 18 Jul 2023 17:36:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMb-0003uI-Eb; Tue, 18 Jul 2023 17:36:10 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ILWCvw002507; Tue, 18 Jul 2023 21:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4Cw+bYqMFH0fGAsvrrjxKB7O+h3mER8m3G0w6VwZmxU=;
 b=O1r8iHRWmV73rj15qcnc6u7ajsXsh0V7T6W0CpOWWK2W7OkQ2fVYj6y3wXThWmHyIzv1
 LFCzbu4GM0jYLl/gSzaWdB0fMgx2NJgubfCDx7vwjM3q6d4KdgXeW3nwubeuyuo2lQ9g
 WADm/WfP0RJgVfCmndCHvnM1ger0dX/GpUDdu2EOzTrjgCtl8stfbRblmb5JE8FuKwLT
 Kzb1LuToN/QWZSwB/iZpLi0MAqrhh0XUeo12LrikHtsIuS6Nbh0g9NYP+uc6Vc/d5Z4z
 tNJ+kBDerC58GleG4i1B6rsA2wdZopxvMtEFqF15M0G9l9SieXlDuWuMTmlbMA18d+Ka BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx2qyg4kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ILYpYm012270;
 Tue, 18 Jul 2023 21:36:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx2qyg4j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IJdGQo003394; Tue, 18 Jul 2023 21:36:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xekq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ILa2t520644494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 21:36:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56A222004F;
 Tue, 18 Jul 2023 21:36:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB6BA20040;
 Tue, 18 Jul 2023 21:36:01 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.14.165])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 21:36:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 09/14] tests/tcg/s390x: Test CLGEBR and CGEBRA
Date: Tue, 18 Jul 2023 23:21:10 +0200
Message-ID: <20230718213531.117976-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718213531.117976-1-iii@linux.ibm.com>
References: <20230718213531.117976-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vxl9clknpZfPuyVAJCiNpmwv6tDRncMG
X-Proofpoint-ORIG-GUID: JfKXJ6VQOtA4iGBosm5umrYZ4_ypRmu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_17,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=962
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180196
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


