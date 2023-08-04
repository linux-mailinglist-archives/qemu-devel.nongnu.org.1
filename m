Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9E770C89
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4et-0005GB-Ly; Fri, 04 Aug 2023 19:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4eq-0005Ek-4b; Fri, 04 Aug 2023 19:56:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4eo-0005F7-BT; Fri, 04 Aug 2023 19:56:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374NXuYE001407; Fri, 4 Aug 2023 23:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LNpWPCezO5e56c/NMr/8umV009uLN4F8E982N5g3p/w=;
 b=fs4ckzGOa2NMPJ1Qjb13zCJMAYWwda7We2MISh75u8L7wsayCm/FuUM8b/VD5qpQewwg
 bD8VO+aF1oFjkE9OFtqyYYBXH4YP8J470y/wkHHSQN7dkVyRuVukq1uHRG4QoB2IRfiY
 oVkX2LIZg4X1OSVxgB3f7jyXyvfPP11/dX+QVUhtnxo4ecvTsIVjpgyv5Sg9hD5uNGLE
 hwOpaVFmVHGkQNbMzdTng3ni9Xd8JS/QGcwClc6CL5z3LfcGqIkL1qaxHMIIojVfQRxQ
 mj5ykn96Wmn8IBQyRgJGW9PNXPUNps7nLHM/D5KMlJZ7OxqXTD5gSFp/DuaG1kFo2oOy +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b448cfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:56:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374NkfbI011084;
 Fri, 4 Aug 2023 23:56:31 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b448cfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:56:31 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374MfRwf021546; Fri, 4 Aug 2023 23:56:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmcj1ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:56:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NuTLE42861232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:56:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C5A20043;
 Fri,  4 Aug 2023 23:56:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0DBE20040;
 Fri,  4 Aug 2023 23:56:28 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:56:28 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] tests/tcg/s390x: Test VSTL
Date: Sat,  5 Aug 2023 01:55:34 +0200
Message-ID: <20230804235624.263260-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804235624.263260-1-iii@linux.ibm.com>
References: <20230804235624.263260-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -dXnsg8nVpO_5jQaq0GDBcnXk7pYYr-X
X-Proofpoint-ORIG-GUID: ezuUsKyDXzSNKD6Q9PEfUT6UweW6gdEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=814 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040213
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
 tests/tcg/s390x/vstl.c          | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/tcg/s390x/vstl.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 649c1e520e6..e3e22c6f7e3 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -60,6 +60,7 @@ Z13_TESTS=vistr
 Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
+Z13_TESTS+=vstl
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/vstl.c b/tests/tcg/s390x/vstl.c
new file mode 100644
index 00000000000..bece952c7ee
--- /dev/null
+++ b/tests/tcg/s390x/vstl.c
@@ -0,0 +1,37 @@
+/*
+ * Test the VSTL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include "vx.h"
+
+static inline void vstl(S390Vector *v1, void *db2, size_t r3)
+{
+    asm("vstl %[v1],%[r3],%[db2]"
+        : [db2] "=Q" (*(char *)db2)
+        : [v1] "v" (v1->v), [r3] "r" (r3)
+        : "memory");
+}
+
+int main(void)
+{
+    uint64_t buf[3] = {0x1122334455667788ULL, 0x99aabbccddeeffULL,
+                       0x5a5a5a5a5a5a5a5aULL};
+    S390Vector v = {.d[0] = 0x1234567887654321ULL,
+                    .d[1] = 0x9abcdef00fedcba9ULL};
+
+    vstl(&v, buf, 0);
+    assert(buf[0] == 0x1222334455667788ULL);
+
+    vstl(&v, buf, 1);
+    assert(buf[0] == 0x1234334455667788ULL);
+
+    vstl(&v, buf, -1);
+    assert(buf[0] == 0x1234567887654321ULL);
+    assert(buf[1] == 0x9abcdef00fedcba9ULL);
+    assert(buf[2] == 0x5a5a5a5a5a5a5a5aULL);
+
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


