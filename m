Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB5746BB0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:17:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbCf-0003bL-8B; Tue, 04 Jul 2023 04:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCN-0003U7-9X; Tue, 04 Jul 2023 04:15:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCL-0002gV-Ga; Tue, 04 Jul 2023 04:15:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36488744000944; Tue, 4 Jul 2023 08:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iiXS9URlFc0KH/qyExB8DDARTlrUp01TaEBlCCSCNhg=;
 b=aI2SEGBDS6Si/xu4ZMrIFhomF3baAB7ML9ilLdggH+U9b4SxtpXPg6FSHD/7Gg+JVVtI
 hgBV/AhLyskehbM6JyZfLngzwnd8hnD4WrV3D2iR+X0sHT6n95lgMfvZQZugfzTuoBpF
 vMzhaK3dAmJ7WWNDIsfg3lliyfgC7Hf+tkNlfp9Wg704NdLj5Sc8Iwvl2bwmUNLDX1R+
 vOU2cSw3krbdetK/g1HRDKZJYDyMwnkTANaKOE4QwxCGnn53Q5H+qVkrX6xt52HoEt6e
 V0C51spXoNKWA7Z1LYsPVaW6AffICpEniPVO2Wgy7lK2OFTjc7WFKBPphA/7K0o+lsRi mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdt8eu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3648AuNS011145;
 Tue, 4 Jul 2023 08:15:42 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdt8esq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3644YVTH016650;
 Tue, 4 Jul 2023 08:15:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rjbs51cmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648Fbt322217368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D999920043;
 Tue,  4 Jul 2023 08:15:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50B0D20049;
 Tue,  4 Jul 2023 08:15:37 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 09/12] tests/tcg/s390x: Test LARL with a large offset
Date: Tue,  4 Jul 2023 10:12:33 +0200
Message-ID: <20230704081506.276055-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hZyO1RTIAyuedUdubfSvOeYDxQCjjcYM
X-Proofpoint-GUID: W3gpP_vd3jftazgqcz6zwaZyzRzG_0uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040065
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/larl.c          | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tests/tcg/s390x/larl.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 2ef22c88d95..dbf64c991e9 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -37,6 +37,7 @@ TESTS+=ex-relative-long
 TESTS+=ex-branch
 TESTS+=mxdb
 TESTS+=epsw
+TESTS+=larl
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/larl.c b/tests/tcg/s390x/larl.c
new file mode 100644
index 00000000000..7c95f89be73
--- /dev/null
+++ b/tests/tcg/s390x/larl.c
@@ -0,0 +1,21 @@
+/*
+ * Test the LARL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdlib.h>
+
+int main(void)
+{
+    long algfi = (long)main;
+    long larl;
+
+    /*
+     * The compiler may emit larl for the C addition, so compute the expected
+     * value using algfi.
+     */
+    asm("algfi %[r],0xd0000000" : [r] "+r" (algfi) : : "cc");
+    asm("larl %[r],main+0xd0000000" : [r] "=r" (larl));
+
+    return algfi == larl ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.41.0


