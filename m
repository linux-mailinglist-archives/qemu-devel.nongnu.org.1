Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F2375ED51
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:22:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqpG-0001N7-4b; Mon, 24 Jul 2023 04:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqof-0001Fw-UU; Mon, 24 Jul 2023 04:21:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqod-0001WU-7E; Mon, 24 Jul 2023 04:21:17 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O8Iold013748; Mon, 24 Jul 2023 08:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rulbBhCzSFCkQrgpbY0rWyJX2Jx/EbYB7vax9vi63hE=;
 b=GxrculnBhIkfrx+FARy3twXaqpNvxRGuGZajUM5vYwf+Q88rUeO7HnmifSXZJsv9IUoi
 yWOE2r0yYriTV4Pwz7944iMq4bzi9cyaJ2DFB2PoZKDJRAenqREXnqTpTvRfPLuWcjnZ
 DJfqMIBeU2/ICB3gqiPZYPFzdAKbQrxLSdLhW/B/FLRXwv36jyHEumm0XQ1iVKh3HlVi
 mDWXu7z8avApgF95Ab/VPLiy8m+qTgQjNTNGOytguco+jtu0e1G6KpFRiy1MlkkkNatS
 JRGJ95ZazFTXoMkt/DeoSpe0Fe6TEECtetNkJh8VMGws9iUfLv9bo63k1Hqj5P/yo0wo 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1jyhks1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:21:13 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36O87aTx004461;
 Mon, 24 Jul 2023 08:21:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1jyhks13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:21:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O6QHhj002079; Mon, 24 Jul 2023 08:21:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0temhgqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:21:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36O8LAKa17170996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jul 2023 08:21:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5A82004B;
 Mon, 24 Jul 2023 08:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A23A20040;
 Mon, 24 Jul 2023 08:21:09 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.11.212])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jul 2023 08:21:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 14/14] tests/tcg/s390x: Test VCKSM
Date: Mon, 24 Jul 2023 10:16:07 +0200
Message-ID: <20230724082032.66864-15-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724082032.66864-1-iii@linux.ibm.com>
References: <20230724082032.66864-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ix-ne93ALq5u3v2d4QYxsBkgKPRUmrRi
X-Proofpoint-ORIG-GUID: 3qvYHoyVhEg6Syw4h6v5MX0UesDhk_5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 mlxlogscore=940 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Tested-by: Thomas Huth <thuth@redhat.com>
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


