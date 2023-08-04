Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE12770C74
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4Mv-0000JJ-Ot; Fri, 04 Aug 2023 19:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Mu-0000IM-1P; Fri, 04 Aug 2023 19:38:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Mr-00084S-6r; Fri, 04 Aug 2023 19:38:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374NVCAL025578; Fri, 4 Aug 2023 23:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wJuUNSSwABW8DkVKRSIaBGDkfLVnBspOXeju8Scoc2M=;
 b=lOqk/hIsoUWqEgUPu+mHlvV9vJCOduZfggu+QmE+oQyQOXY+shESHmJkIeLbVKK+cBTj
 9To8W6hldSQroQQZPCiPbxe0khnvZqi7Jk8TfmDfkrmLv3rcCESwciCZVCrplEPC77gR
 CTau0wis7jr2OG2OuMo0Zp4rWfUq8qQ4oyQx1dKoyE/JamLzj5sRquIZG5KttmCHcHET
 QvMyJ8GksyL1tUmi3ToY9MrQkQPsUzuJTBVozmfB7S1+/PVxpeYCmq9iFnYMMH6VQxzI
 aqJR8YaQn25qWkTzQJkbsd6S6516PdY+2+M39W3k/VFmRSaQl+7UxWI+ywvIlrpRbB9S 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b2qg4dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374NZXEi004305;
 Fri, 4 Aug 2023 23:37:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b2qg4d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374Msj7X023506; Fri, 4 Aug 2023 23:37:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9sx3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NbuqY18743954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:37:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D66820043;
 Fri,  4 Aug 2023 23:37:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A17A020040;
 Fri,  4 Aug 2023 23:37:55 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:37:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] tests/tcg/s390x: Test VSTRS
Date: Sat,  5 Aug 2023 01:03:19 +0200
Message-ID: <20230804233748.218935-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804233748.218935-1-iii@linux.ibm.com>
References: <20230804233748.218935-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iVOLavr7oDjunkltH_dXlLbwpGj-ZRl0
X-Proofpoint-GUID: Gk9HrlmkAg6HpOTfuxpCnmbRL3hdUI1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040213
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/vxeh2_vstrs.c   | 88 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 1fc98099070..8ba36e5985b 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -73,6 +73,7 @@ ifneq ($(CROSS_CC_HAS_Z15),)
 Z15_TESTS=vxeh2_vs
 Z15_TESTS+=vxeh2_vcvt
 Z15_TESTS+=vxeh2_vlstr
+Z15_TESTS+=vxeh2_vstrs
 $(Z15_TESTS): CFLAGS+=-march=z15 -O2
 TESTS+=$(Z15_TESTS)
 endif
diff --git a/tests/tcg/s390x/vxeh2_vstrs.c b/tests/tcg/s390x/vxeh2_vstrs.c
new file mode 100644
index 00000000000..313ec1d728f
--- /dev/null
+++ b/tests/tcg/s390x/vxeh2_vstrs.c
@@ -0,0 +1,88 @@
+/*
+ * Test the VSTRS instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "vx.h"
+
+static inline __attribute__((__always_inline__)) int
+vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
+      const S390Vector *v4, const uint8_t m5, const uint8_t m6)
+{
+    int cc;
+
+    asm("vstrs %[v1],%[v2],%[v3],%[v4],%[m5],%[m6]\n"
+        "ipm %[cc]"
+        : [v1] "=v" (v1->v)
+        , [cc] "=r" (cc)
+        : [v2] "v" (v2->v)
+        , [v3] "v" (v3->v)
+        , [v4] "v" (v4->v)
+        , [m5] "i" (m5)
+        , [m6]  "i" (m6)
+        : "cc");
+
+    return (cc >> 28) & 3;
+}
+
+static void test_ignored_match(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x222000205e410000ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0x205e410000000000ULL, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 3, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
+    assert(v1.d[0] == 16);
+    assert(v1.d[1] == 0);
+}
+
+static void test_empty_needle(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x5300000000000000ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 0, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 2);
+    assert(v1.d[0] == 0);
+    assert(v1.d[1] == 0);
+}
+
+static void test_max_length(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x1122334455667700ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 16, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 3);
+    assert(v1.d[0] == 7);
+    assert(v1.d[1] == 0);
+}
+
+static void test_no_match(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0xffffff000fffff00ULL, .d[1] = 0x82b};
+    S390Vector v3 = {.d[0] = 0xfffffffeffffffffULL,
+                     .d[1] = 0xffffffff00000000ULL};
+    S390Vector v4 = {.d[0] = 11, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
+    assert(v1.d[0] == 16);
+    assert(v1.d[1] == 0);
+}
+
+int main(void)
+{
+    test_ignored_match();
+    test_empty_needle();
+    test_max_length();
+    test_no_match();
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


