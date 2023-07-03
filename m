Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6EC74603E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwl-0002r0-R6; Mon, 03 Jul 2023 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwj-0002oP-G3; Mon, 03 Jul 2023 11:58:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwh-0004oT-Ob; Mon, 03 Jul 2023 11:58:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FkvZt008008; Mon, 3 Jul 2023 15:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l/B8RHm+YUichHWCJ2ZPZJMv5Y4S2yjy7YqZT3+ZIgc=;
 b=tcYXQiMZeRIwx9hiyBhth6EaXB2z8df4Lnkxn+lp8Uq91RnIikyr1lGGAF3PWtm0Gujt
 BDymAhFfdFctYiFX9XKJCVK0uz9Z4Tlef3917jmSpTf0R7lgwj8lk02YD4nBJhQbT8rS
 SF886pY9zQuNHuh4D3zHLQVCqJg8ZbTl5hnT13YCiX8kXRDHxaWrc6jWk3wD1NjuOWdl
 KDjBS9mS7SoLQISaxyNbdUuBLqe8LyJDOCU/GaisXgvaw7HrVC47UqoKXPqD025QdN0U
 X9LSPK3kxf1keKWF9OGAQsBtchRDzMAfd6AxgLXa+Cnp69mCYhxiKF9D+aSIAB8emBh7 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19b88bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:32 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FlbxH010193;
 Mon, 3 Jul 2023 15:58:32 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19b88bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 362C45AN006641;
 Mon, 3 Jul 2023 15:58:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde1d9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwRCK40632796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2494920043;
 Mon,  3 Jul 2023 15:58:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0C3620040;
 Mon,  3 Jul 2023 15:58:26 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 10/12] tests/tcg/s390x: Test LRA
Date: Mon,  3 Jul 2023 17:50:36 +0200
Message-ID: <20230703155801.179167-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OLp8FP-6l8oczPZ1-rFNO21ScrTQtVJd
X-Proofpoint-ORIG-GUID: KpbNswQq8I1d-D8e5ngdMRFZrDh9ffoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030141
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
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/lra.S                   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tests/tcg/s390x/lra.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 44dfd716291..242c7b0f83c 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -20,6 +20,7 @@ ASM_TESTS =                                                                    \
     sam                                                                        \
     lpsw                                                                       \
     lpswe-early                                                                \
+    lra                                                                        \
     ssm-early                                                                  \
     stosm-early                                                                \
     unaligned-lowcore
diff --git a/tests/tcg/s390x/lra.S b/tests/tcg/s390x/lra.S
new file mode 100644
index 00000000000..79ab86f36bb
--- /dev/null
+++ b/tests/tcg/s390x/lra.S
@@ -0,0 +1,19 @@
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lgrl %r1,initial_r1
+    lra %r1,0(%r1)
+    cgrl %r1,expected_r1
+    jne 1f
+    lpswe success_psw
+1:
+    lpswe failure_psw
+    .align 8
+initial_r1:
+    .quad 0x8765432112345678
+expected_r1:
+    .quad 0x8765432180000038           /* ASCE type exception */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.41.0


