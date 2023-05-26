Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E17712C42
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bwG-0005hh-66; Fri, 26 May 2023 14:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bwE-0005hL-1B; Fri, 26 May 2023 14:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvz-0007Ut-Dv; Fri, 26 May 2023 14:13:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QHAfsD003289; Fri, 26 May 2023 18:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2uqWi02uYHbfVUktBnRegSLy301VwK+T/BrknZo+NDE=;
 b=pSBA5/iasK4WKeKtNIq8ix5/gs3khQU+3imq/BaJtGOYEEGYWLy71Cw0OC7RspCpIXhY
 GGeThTGS6D2Yxb70MpD5w2lqxT6sn/E67SexQw1jx6ycBpuAIRqqodLJ1NLgtYIHN/bT
 4EicVJFMpBeRxDi+4l700DLyRAIBMlpfb7j+xEUP0UxXXevfDAGiUILb9BzqNloIBAyY
 CXFdIly/8v0qvG1L7mdFuQQ6jCGxwVSTeZXTpDSx+Kbo0EboenlA2priveQxHkmip6V8
 PW9+RX0+JJt8dXUaI99nYqeH3G9PjpMbt14Gl4UPHZrd5FmRks9TzMXooHq1gqJDn3Wo CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxu14h01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:13:00 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QI7Rp6008389;
 Fri, 26 May 2023 18:12:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxu14gyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q47XVh027277;
 Fri, 26 May 2023 18:12:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk32p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QICsv423659224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 18:12:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D29C20040;
 Fri, 26 May 2023 18:12:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CF5220043;
 Fri, 26 May 2023 18:12:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.7.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 18:12:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 4/4] tests/tcg/s390x: Test LOCFHR
Date: Fri, 26 May 2023 20:12:40 +0200
Message-Id: <20230526181240.1425579-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526181240.1425579-1-iii@linux.ibm.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ER_Z9AOPzHPHyXVMVYLQf3boQZ7ihcC1
X-Proofpoint-ORIG-GUID: zX-fffjjGxNxGLM4XadYAu_zthloTr3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=876 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/locfhr.c        | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/s390x/locfhr.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index c48de439625..3c239fdd082 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -48,6 +48,7 @@ TESTS += $(PGM_SPECIFICATION_TESTS)
 
 Z13_TESTS=vistr
 Z13_TESTS+=lcbb
+Z13_TESTS+=locfhr
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/locfhr.c b/tests/tcg/s390x/locfhr.c
new file mode 100644
index 00000000000..ab9ff6e4490
--- /dev/null
+++ b/tests/tcg/s390x/locfhr.c
@@ -0,0 +1,29 @@
+/*
+ * Test the LOCFHR instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static inline __attribute__((__always_inline__)) long
+locfhr(long r1, long r2, int m3, int cc)
+{
+    cc <<= 28;
+    asm("spm %[cc]\n"
+        "locfhr %[r1],%[r2],%[m3]\n"
+        : [r1] "+r" (r1)
+        : [cc] "r" (cc), [r2] "r" (r2), [m3] "i" (m3)
+        : "cc");
+    return r1;
+}
+
+int main(void)
+{
+    assert(locfhr(0x1111111122222222, 0x3333333344444444, 8, 0) ==
+           0x3333333322222222);
+    assert(locfhr(0x5555555566666666, 0x7777777788888888, 11, 1) ==
+           0x5555555566666666);
+
+    return EXIT_SUCCESS;
+}
-- 
2.40.1


