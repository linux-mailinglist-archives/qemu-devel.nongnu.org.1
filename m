Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 484857591F4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3ld-0002tw-R0; Wed, 19 Jul 2023 05:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lS-0002eO-SA; Wed, 19 Jul 2023 05:46:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lR-0002u2-37; Wed, 19 Jul 2023 05:46:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J9eIRW010132; Wed, 19 Jul 2023 09:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dy97RmEP1rH6BkWOws0g2ZoPPbyHVVdARrzNn1bWBgE=;
 b=oShXXN/zXvNNtXFvE5F+SR3fXPj3YyZ6XsSJUBLb3acTqscZXriO5fR+GtFHPjO101Cs
 kmwrxIdCmGcLOpwTJSIS4WOSuCaD35XkGNo5WWfRZZA5tLLHOvIIO7W9rvRCWnCXh5Aw
 B1oNM/RbCKuBnqUSZgZAIONpckbLglomxcJb5dYAxym3jQLZrWgSzRju8tcyKx/edIAN
 3TtEcbyHQ+V8iqsM4oGEJE3mYMaI4X/wRWVWv2/SUtW2GtmTt31LYN3/YLfvZ/sDNIW2
 LMyXjbLFCoZwsB6urT1M/3WF7Evkpwypp16Ah5AKpVybA+xCiGkrQTNMW55yLEbJe4bl tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxd4rgshf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9e0tE008430;
 Wed, 19 Jul 2023 09:46:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxd4rgsh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J70AC3030687; Wed, 19 Jul 2023 09:46:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jpqgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9kQ7s54067666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:46:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25C0B20049;
 Wed, 19 Jul 2023 09:46:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042A220040;
 Wed, 19 Jul 2023 09:46:26 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 14/14] tests/tcg/s390x: Test VCKSM
Date: Wed, 19 Jul 2023 11:44:24 +0200
Message-ID: <20230719094620.363206-15-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719094620.363206-1-iii@linux.ibm.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CQggep_dPQwBjKg5DBri3OK9ELvIjyVs
X-Proofpoint-GUID: Fa7eTTo_nHRjeLYVY46vSdQdkDtdCJpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=902 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190087
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
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/vcksm.c         | 31 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/vx.h            |  2 ++
 3 files changed, 34 insertions(+)
 create mode 100644 tests/tcg/s390x/vcksm.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 71bf39b78d3..1fc98099070 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -58,6 +58,7 @@ TESTS += $(PGM_SPECIFICATION_TESTS)
 Z13_TESTS=vistr
 Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
+Z13_TESTS+=vcksm
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/vcksm.c b/tests/tcg/s390x/vcksm.c
new file mode 100644
index 00000000000..452daaae6ce
--- /dev/null
+++ b/tests/tcg/s390x/vcksm.c
@@ -0,0 +1,31 @@
+/*
+ * Test the VCKSM instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include "vx.h"
+
+int main(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {
+        .d[0] = 0xb2261c8140edce49ULL,
+        .d[1] = 0x387bf5a433af39d1ULL,
+    };
+    S390Vector v3 = {
+        .d[0] = 0x73b03d2c7f9e654eULL,
+        .d[1] = 0x23d74e51fb479877ULL,
+    };
+    S390Vector exp = {.d[0] = 0xdedd7f8eULL, .d[1] = 0ULL};
+
+    asm volatile("vcksm %[v1],%[v2],%[v3]"
+                 : [v1] "=v" (v1.v)
+                 : [v2] "v" (v2.v)
+                 , [v3] "v" (v3.v));
+    assert(memcmp(&v1, &exp, sizeof(v1)) == 0);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/vx.h b/tests/tcg/s390x/vx.h
index 02e7fd518a8..00701dbe35f 100644
--- a/tests/tcg/s390x/vx.h
+++ b/tests/tcg/s390x/vx.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_TESTS_S390X_VX_H
 #define QEMU_TESTS_S390X_VX_H
 
+#include <stdint.h>
+
 typedef union S390Vector {
     uint64_t d[2];  /* doubleword */
     uint32_t w[4];  /* word */
-- 
2.41.0


