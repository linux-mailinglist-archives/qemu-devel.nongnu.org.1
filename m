Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F0712C44
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bw4-0005f8-Oc; Fri, 26 May 2023 14:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvv-0005eL-3I; Fri, 26 May 2023 14:12:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvt-0007SR-Jb; Fri, 26 May 2023 14:12:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QI50Hd013685; Fri, 26 May 2023 18:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mVknj1D1avJFseqJKHGkL+Et8Iz4sgw4lwNnoJzudOA=;
 b=HuBOXbzpJTjTtKHmH8n6DYxW0Yhqd3Q9mcIpEpR1Bxi3uDblMkaGW8yTBFmaAF5NE0XM
 k/cTJ/GthPRvfL+FxtwBzyqOhZKITFS0MQOlS+vfoi2x6oHtFvFYgXHmA8te4EvvEzkR
 I3LpGfE0ziRSianWnSUOhvnWwcN/e63GlCIgh8o8HPFZhzdUozrHA7W4F/v0tN1Cb812
 890MIHev72QDOVDe5pJ5qJ/DDmn6L5AMfnBmNbn07J5lCapBPd1JWRyrRAgXfghLI8Xd
 OU1Rc4hezCjRNa/V5AhMST4O8QFuqXCEhzKc2z39OU1F+c7BTcGMLoE+HXqBUS/aYinV yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxgh54j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:54 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QHtZ4t021354;
 Fri, 26 May 2023 18:12:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxgh54hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q2tr1a024199;
 Fri, 26 May 2023 18:12:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk32p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QICoTt21365458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 18:12:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFADD20043;
 Fri, 26 May 2023 18:12:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EFBC20040;
 Fri, 26 May 2023 18:12:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.7.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 18:12:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/4] tests/tcg/s390x: Test LCBB
Date: Fri, 26 May 2023 20:12:38 +0200
Message-Id: <20230526181240.1425579-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526181240.1425579-1-iii@linux.ibm.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qpDEAgiet8EO64DOEI4W1QmzM5ol6Iw7
X-Proofpoint-GUID: ECRjKv3rSxmTFUW0Ju0AurdprB84z-H4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=841
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260154
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

Add a test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/lcbb.c          | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 tests/tcg/s390x/lcbb.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 73f7cb828e3..c48de439625 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -47,6 +47,7 @@ $(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
 TESTS += $(PGM_SPECIFICATION_TESTS)
 
 Z13_TESTS=vistr
+Z13_TESTS+=lcbb
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/lcbb.c b/tests/tcg/s390x/lcbb.c
new file mode 100644
index 00000000000..8d368e0998d
--- /dev/null
+++ b/tests/tcg/s390x/lcbb.c
@@ -0,0 +1,51 @@
+/*
+ * Test the LCBB instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static inline __attribute__((__always_inline__)) void
+lcbb(long *r1, void *dxb2, int m3, int *cc)
+{
+    asm("lcbb %[r1],%[dxb2],%[m3]\n"
+        "ipm %[cc]"
+        : [r1] "+r" (*r1), [cc] "=r" (*cc)
+        : [dxb2] "R" (*(char *)dxb2), [m3] "i" (m3)
+        : "cc");
+    *cc = (*cc >> 28) & 3;
+}
+
+static char buf[0x1000] __attribute__((aligned(0x1000)));
+
+static inline __attribute__((__always_inline__)) void
+test_lcbb(void *p, int m3, int exp_r1, int exp_cc)
+{
+    long r1 = 0xfedcba9876543210;
+    int cc;
+
+    lcbb(&r1, p, m3, &cc);
+    assert(r1 == (0xfedcba9800000000 | exp_r1));
+    assert(cc == exp_cc);
+}
+
+int main(void)
+{
+    test_lcbb(&buf[0],    0, 16, 0);
+    test_lcbb(&buf[63],   0,  1, 3);
+    test_lcbb(&buf[0],    1, 16, 0);
+    test_lcbb(&buf[127],  1,  1, 3);
+    test_lcbb(&buf[0],    2, 16, 0);
+    test_lcbb(&buf[255],  2,  1, 3);
+    test_lcbb(&buf[0],    3, 16, 0);
+    test_lcbb(&buf[511],  3,  1, 3);
+    test_lcbb(&buf[0],    4, 16, 0);
+    test_lcbb(&buf[1023], 4,  1, 3);
+    test_lcbb(&buf[0],    5, 16, 0);
+    test_lcbb(&buf[2047], 5,  1, 3);
+    test_lcbb(&buf[0],    6, 16, 0);
+    test_lcbb(&buf[4095], 6,  1, 3);
+
+    return EXIT_SUCCESS;
+}
-- 
2.40.1


