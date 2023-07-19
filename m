Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1375759208
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3ly-0003IT-Ix; Wed, 19 Jul 2023 05:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lS-0002eJ-RK; Wed, 19 Jul 2023 05:46:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lQ-0002tW-D1; Wed, 19 Jul 2023 05:46:34 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J9bVQR004156; Wed, 19 Jul 2023 09:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wuewFn9+mjftNlQVoEU9jSk2WVLqt3pAE8L0Y9tE4GA=;
 b=D4SUBlYY67AipQtoI+oQjMcIDF/Zt9/44TiGnZP7l3oiRUmOHCdsFsegdbctqJJzKIKM
 VzZgsaYMPniV2eUWG+1dp8ipXhiONjr1FwKw0wZANGUqmswM5pg5RCCRfuqmEodt9dOW
 Dv1Rwq+XO+Tt4BKwISq24joFjHeo9hZHWs7/2LHLIrzqVjP+hUm/EipN6MzwUEjDMUP1
 tjhLuEia9tR+FzT1Exsxn5kT/vfV1KDR1jgt8ghFYugLO8z8mzJ3s6S/CUJACpxkIrq0
 72jjste7/Kq+HyMwXoPj8F71ma+dwdWIf4KrwpzSHPtU5ze78AU35l8tehJoH8/ri1Oa aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxcs41jbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9bf9I004648;
 Wed, 19 Jul 2023 09:46:28 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxcs41jbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J90o7I004149; Wed, 19 Jul 2023 09:46:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g11s1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9kPId40632744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:46:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C8820040;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8030C2004B;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 11/14] tests/tcg/s390x: Test ICM
Date: Wed, 19 Jul 2023 11:44:21 +0200
Message-ID: <20230719094620.363206-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719094620.363206-1-iii@linux.ibm.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qQ4GYiAMSfTHOJwx47jj6B_M7Q9JRFe_
X-Proofpoint-GUID: X3B5TcvTwOR2W3j3RtNzU6u2oUeGjsVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=809
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307190087
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
 tests/tcg/s390x/icm.S                   | 32 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tests/tcg/s390x/icm.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 062d8e368aa..58684d7da71 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -19,6 +19,7 @@ ASM_TESTS =                                                                    \
     cksm                                                                       \
     clm                                                                        \
     exrl-ssm-early                                                             \
+    icm                                                                        \
     sam                                                                        \
     lpsw                                                                       \
     lpswe-early                                                                \
diff --git a/tests/tcg/s390x/icm.S b/tests/tcg/s390x/icm.S
new file mode 100644
index 00000000000..d24d1f52fb8
--- /dev/null
+++ b/tests/tcg/s390x/icm.S
@@ -0,0 +1,32 @@
+    .org 0x8e
+program_interruption_code:
+    .org 0x1d0                         /* program new PSW */
+    .quad 0,pgm
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lgrl %r0,op1
+    icm %r0,10,op2
+    cg %r0,exp
+    jne failure
+    lgrl %r1,bad_addr
+    icm %r0,0,0(%r1)
+failure:
+    lpswe failure_psw
+pgm:
+    chhsi program_interruption_code,5  /* addressing exception? */
+    jne failure
+    lpswe success_psw
+    .align 8
+op1:
+    .quad 0x1234567887654321
+op2:
+    .quad 0x0011223344556677
+exp:
+    .quad 0x1234567800651121
+bad_addr:
+    .quad 0xffffffff00000000
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.41.0


