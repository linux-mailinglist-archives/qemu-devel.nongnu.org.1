Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AA746045
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwe-0002mb-T6; Mon, 03 Jul 2023 11:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwd-0002mB-Gx; Mon, 03 Jul 2023 11:58:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwc-0004jT-1A; Mon, 03 Jul 2023 11:58:31 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363Fl6qL017300; Mon, 3 Jul 2023 15:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GbBIEYnIpa3QJ12Y9nc/ydOKTvCTNyYPZm8ipQ77YKI=;
 b=rNH1OAKLe6sESzfBevT+X8d2F9dMkxigYa1UHiGrJ/hxk87RGdWJ/MbrGbjyI1/WVzQg
 g2qFGGWjGAU41V2KbChXN8EvuSP5iqvfqGgSINFPp0sNM/UxDVr0j5ZQj+OqI0ax5k0v
 MM4AjRZBmBye3cb744VYzLtV5oWDSWO3YAXVYmAZ1mG/wsGPt8GbqG9QsL5Xk9eXuXMm
 mcHbcpooUAdJrzAvxCArNBIUkWxMOEw+PK8FAVRn7vsGeDXYLbH4ZpId3a0JboQhuB7H
 6glQxR4+o1HHk/6W17obYWOj0k8SSXgoKXYUwfo24rz0Rbjay4Qlwn2Wv6M43qbSeqjz Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19dr8p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:28 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363Fnb25022875;
 Mon, 3 Jul 2023 15:58:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19dr8nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 362LFMIM017254;
 Mon, 3 Jul 2023 15:58:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sd7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwNhB16253574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5564B20040;
 Mon,  3 Jul 2023 15:58:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D7B42004B;
 Mon,  3 Jul 2023 15:58:23 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 08/12] tests/tcg/s390x: Test EPSW
Date: Mon,  3 Jul 2023 17:50:34 +0200
Message-ID: <20230703155801.179167-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NYQn9Ey8wnLm6QOPuM3Y8P2-Zcmfp0Oi
X-Proofpoint-GUID: I_l4VAksfQsw5m-OhLrPwpIHmMA_5eLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=854 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030141
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/epsw.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tests/tcg/s390x/epsw.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 85abfbb98c0..2ef22c88d95 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -36,6 +36,7 @@ TESTS+=rxsbg
 TESTS+=ex-relative-long
 TESTS+=ex-branch
 TESTS+=mxdb
+TESTS+=epsw
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/epsw.c b/tests/tcg/s390x/epsw.c
new file mode 100644
index 00000000000..affb1a5e3a1
--- /dev/null
+++ b/tests/tcg/s390x/epsw.c
@@ -0,0 +1,23 @@
+/*
+ * Test the EPSW instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    unsigned long r1 = 0x1234567887654321UL, r2 = 0x8765432112345678UL;
+
+    asm("cr %[r1],%[r2]\n"  /* cc = 1 */
+        "epsw %[r1],%[r2]"
+        : [r1] "+r" (r1), [r2] "+r" (r2) : : "cc");
+
+    /* Do not check the R and RI bits. */
+    r1 &= ~0x40000008UL;
+    assert(r1 == 0x1234567807051001UL);
+    assert(r2 == 0x8765432180000000UL);
+
+    return EXIT_SUCCESS;
+}
-- 
2.41.0


