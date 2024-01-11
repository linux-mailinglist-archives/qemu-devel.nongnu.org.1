Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0B82AAD7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:25:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrIy-0000WZ-1u; Thu, 11 Jan 2024 04:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNrIm-0000P1-C8; Thu, 11 Jan 2024 04:24:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNrIg-0005Kv-LB; Thu, 11 Jan 2024 04:24:38 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B8qBCM002265; Thu, 11 Jan 2024 09:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kD7VTzArvWe4P11JyrI+x4kMWBMgIpnj/Y8Fmpz8Xpk=;
 b=Hg6eSTntwwYPGnxU/AlbS/5e17IIDmxaMTTzPKNbAVZfJ0tw0yhRluTIwAD+2UBBhW2N
 uGLNjvx+NFm39btKzQuVOj1xoLK/qx/rJerB7Q+aUB5WCCSGwqeElzeqA76PpW7/A1Xy
 wsBa4nbIRvxgACuFTkhlUQSV1uHWIyIUe2Nu7fDbIDVIDRTWusbfESkvwTBbe9PQ03bW
 0RmVNw9UBIauyE/XcgjzoNbOVlVDbTnZGk/tGD65PXot67HKj3lArNMCOHZ7C2guAyzc
 L7V34fqnvhlV2+ZaBSFfB8S0dw44J03X5juLUQJMXVaC3n2h/U69E/YXPTyKcVBo/2Me Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd6u14cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:24:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40B8q69Q002133;
 Thu, 11 Jan 2024 09:23:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd6u12q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:23:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B90amS004384; Thu, 11 Jan 2024 09:23:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpm2eru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:23:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40B9NXlL10813976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 09:23:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 180ED2004F;
 Thu, 11 Jan 2024 09:23:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1D202004E;
 Thu, 11 Jan 2024 09:23:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.79.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 09:23:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg/s390x: Test LOAD ADDRESS EXTENDED
Date: Thu, 11 Jan 2024 10:21:27 +0100
Message-ID: <20240111092328.929421-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111092328.929421-1-iii@linux.ibm.com>
References: <20240111092328.929421-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NDT8ATGm4BvbYhYeWoRnLcoh3VGKAIJo
X-Proofpoint-ORIG-GUID: Nse4kp0igK9fScF49ecynnRotGVzFcX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_04,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=701
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Add a small test to prevent regressions. Userspace runs in primary
mode, so LAE should always set the access register to 0.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/lae.c           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 tests/tcg/s390x/lae.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0e670f3f8b9..30994dcf9c2 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -44,6 +44,7 @@ TESTS+=clgebr
 TESTS+=clc
 TESTS+=laalg
 TESTS+=add-logical-with-carry
+TESTS+=lae
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/lae.c b/tests/tcg/s390x/lae.c
new file mode 100644
index 00000000000..59712b5e371
--- /dev/null
+++ b/tests/tcg/s390x/lae.c
@@ -0,0 +1,31 @@
+/*
+ * Test the LOAD ADDRESS EXTENDED instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    unsigned long long ar = -1, b2 = 100000, r, x2 = 500;
+    /*
+     * Hardcode the register number, since clang does not allow using %rN in
+     * place of %aN.
+     */
+    register unsigned long long r2 __asm__("2");
+    int tmp;
+
+    asm("ear %[tmp],%%a2\n"
+        "lae %%r2,42(%[x2],%[b2])\n"
+        "ear %[ar],%%a2\n"
+        "sar %%a2,%[tmp]"
+        : [tmp] "=&r" (tmp), "=&r" (r2), [ar] "+r" (ar)
+        : [b2] "r" (b2), [x2] "r" (x2)
+        : "memory");
+    r = r2;
+    assert(ar == 0xffffffff00000000ULL);
+    assert(r == 100542);
+
+    return EXIT_SUCCESS;
+}
-- 
2.43.0


