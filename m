Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A626071F5F1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qov-0004q2-Vj; Thu, 01 Jun 2023 18:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qop-0004Ss-0w; Thu, 01 Jun 2023 18:30:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qoj-0005dy-86; Thu, 01 Jun 2023 18:30:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351MHN2S029498; Thu, 1 Jun 2023 22:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CEWC0rQJ9wLpz/6WyVVz/J6BHdnWClQk5Eyp04QXFxA=;
 b=jZGRSGJUOyTiYFiG3WZv53IwX0w/rDbciC58tHdjQTjaWO+ekO9VY7nVdIZPGCBq39Is
 ghEelV771vSDbaWPCPQF3fB+siOhm7I859d5XTgyM0fuUMYsLdvUSSmSGntx+VaPajXZ
 bLgWIZ9QaR9FmRLsRUBBZPqjiVTQ4iduPwfTf7fIeBsBbnVQgFjIb7aRjb7cMfZf6rGA
 Lf9ZnO7ujtyuobZsWUCokoJYjEeEch84Y0MkCuRoVRbezKSwkc1WOL9Spz6iKSuPeper
 WIvb66/n0al9ySrmWa+ROKQ4vEo7y2Uonj2A6p8Eyt3KiaX8Wz1/aAsGOIkAI45H8w1J 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy400r6vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351MJbxA002792;
 Thu, 1 Jun 2023 22:30:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy400r6ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351KOiva012155;
 Thu, 1 Jun 2023 22:30:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e2rmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351MUZvb39649714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 22:30:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1EB920043;
 Thu,  1 Jun 2023 22:30:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8467F20040;
 Thu,  1 Jun 2023 22:30:34 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 22:30:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] tests/tcg/s390x: Test MXDB and MXDBR
Date: Fri,  2 Jun 2023 00:30:27 +0200
Message-Id: <20230601223027.795501-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601223027.795501-1-iii@linux.ibm.com>
References: <20230601223027.795501-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zt6lv07IE-QnRPyCvVtsZnEQUKZNJ0iS
X-Proofpoint-GUID: D5l9S4pgZ4PfZwZxDXZO59nyGZgr5Ujz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=893 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010190
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/mxdb.c          | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tests/tcg/s390x/mxdb.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 3c239fdd082..d33960caa0a 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -35,6 +35,7 @@ TESTS+=chrl
 TESTS+=rxsbg
 TESTS+=ex-relative-long
 TESTS+=ex-branch
+TESTS+=mxdb
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/mxdb.c b/tests/tcg/s390x/mxdb.c
new file mode 100644
index 00000000000..ae922559d3d
--- /dev/null
+++ b/tests/tcg/s390x/mxdb.c
@@ -0,0 +1,30 @@
+/*
+ * Test the MXDB and MXDBR instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    union {
+        double d[2];
+        long double ld;
+    } a;
+    double b;
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdb %[a],%[b]" : [a] "+f" (a.ld) : [b] "R" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdbr %[a],%[b]" : [a] "+f" (a.ld) : [b] "f" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    return EXIT_SUCCESS;
+}
-- 
2.40.1


