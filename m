Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E83AF7DC5FF
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 06:38:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxhRj-0003cM-Df; Tue, 31 Oct 2023 01:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRd-0003bU-6T; Tue, 31 Oct 2023 01:37:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRa-00047B-T1; Tue, 31 Oct 2023 01:37:40 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V5AseZ001171; Tue, 31 Oct 2023 05:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FOx/+un1V9DOo22qEIDt33m4WRvAHcnBNF3DKuiWAO0=;
 b=QeHB9IhbJuFfLl/PNzIQsKMVEuabOtU6YvU2DFW68wLOJ4u2Tkn/i0s5XlkuIG1HYMBp
 R25jeDfBjqP6iKhboxypI+FE1GqeR8i5qeWjyAyfnHzr3XAvqgOcZkscsMnPGoyUfSjy
 lXfBePYZiRQllg2KqgoimP9q1dUBVPt8j+kkt+o2lFMiEZxWMIYAWexBWeLoWy2Mbru4
 4Cmmu+MmurNRLueNBe1xqPcK2c73IfwrCM+h8hGsm5AnjQlzpxydDY03A7Aj/6H9uoJa
 3+DGblmvgP2zSxGYIFpHgnHOxzLehZMxVR7c9SgPmnLpWKyUgaZ2q3hwIDhHbGhRqwoR DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u0ps20q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V5Dok6009385;
 Tue, 31 Oct 2023 05:37:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u0ps1ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V2g2YR011548; Tue, 31 Oct 2023 05:37:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4kp30y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39V5bUfw25100950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 05:37:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F94E20043;
 Tue, 31 Oct 2023 05:37:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEFCB2004D;
 Tue, 31 Oct 2023 05:37:29 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Oct 2023 05:37:29 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/4] tests/tcg/s390x: Test LAALG with negative cc_src
Date: Tue, 31 Oct 2023 06:32:30 +0100
Message-ID: <20231031053718.347100-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031053718.347100-1-iii@linux.ibm.com>
References: <20231031053718.347100-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZBqXI-3uVj26svDrE5QWxruaDDEHBGBs
X-Proofpoint-GUID: ehTakbHOeMgAL2cRqdxy0DejA79gILGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=680 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310043
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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
 tests/tcg/s390x/laalg.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tests/tcg/s390x/laalg.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index ccd4f4e68de..a476547b659 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -42,6 +42,7 @@ TESTS+=mdeb
 TESTS+=cgebra
 TESTS+=clgebr
 TESTS+=clc
+TESTS+=laalg
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/laalg.c b/tests/tcg/s390x/laalg.c
new file mode 100644
index 00000000000..797d168bb16
--- /dev/null
+++ b/tests/tcg/s390x/laalg.c
@@ -0,0 +1,27 @@
+/*
+ * Test the LAALG instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    unsigned long cc = 0, op1, op2 = 40, op3 = 2;
+
+    asm("slgfi %[cc],1\n"  /* Set cc_src = -1. */
+        "laalg %[op1],%[op3],%[op2]\n"
+        "ipm %[cc]"
+        : [cc] "+r" (cc)
+        , [op1] "=r" (op1)
+        , [op2] "+T" (op2)
+        : [op3] "r" (op3)
+        : "cc");
+
+    assert(cc == 0xffffffff10ffffff);
+    assert(op1 == 40);
+    assert(op2 == 42);
+
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


