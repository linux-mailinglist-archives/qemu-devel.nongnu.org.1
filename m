Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFC75A193
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 00:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMFQQ-00077E-6E; Wed, 19 Jul 2023 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQL-00072M-23; Wed, 19 Jul 2023 18:13:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQH-0002CW-9R; Wed, 19 Jul 2023 18:13:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JM7qjP031777; Wed, 19 Jul 2023 22:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uDBeCrbrvh1hh74xZmG/sCJfICe92sLQVLAz5LlaeU0=;
 b=GQA5RhgceGJkpdh0jOGOZRjdCLe9P0ukzbjCW623ilHwqrEFbvxt9FODTz3wq5KrYzHE
 Fr93CZUlGmWIrAh/rgn81W6FFFFXl12b9QfXNH3vsp7ftru+skEM/nVox36Zsg9xD5bZ
 IZyRJNqAbR03y5xlX7TgrJlRmEW6iR4Y52vVT72iTH6yafkr27c9y/L3v9mPImAGHcVJ
 3ReIIKr3J+JKsZRXY+ErF8vUIzuTI0noWluFY4ZmqqD6DK7gXMF8PLtjkJSDqKvlV3QX
 igE9s6fx7hsT9rn5rm7T60cCvou4L0KsuUW6YnEB4Vx0k24gOn++tAKKBy+Dl4QLmeIz rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxnbn4fq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JM84su002197;
 Wed, 19 Jul 2023 22:13:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxnbn4fpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JKGVpF005272; Wed, 19 Jul 2023 22:13:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xktmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JMDJqD40173958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:13:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA92F20065;
 Wed, 19 Jul 2023 22:13:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B42E2005A;
 Wed, 19 Jul 2023 22:13:19 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.152])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 22:13:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 08/14] tests/tcg/s390x: Test CKSM
Date: Thu, 20 Jul 2023 00:11:20 +0200
Message-ID: <20230719221310.1968845-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719221310.1968845-1-iii@linux.ibm.com>
References: <20230719221310.1968845-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _ajENV-0PCcM_QqImyRtI88jt_lreVqj
X-Proofpoint-ORIG-GUID: xiK_J5zEG4HjQuKmwisShVjSnhIKtpKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=796 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190199
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
 tests/tcg/s390x/cksm.S                  | 29 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/s390x/cksm.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 242c7b0f83c..e813e318db9 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -16,6 +16,7 @@ LDFLAGS=-nostdlib -static
 
 ASM_TESTS =                                                                    \
     bal                                                                        \
+    cksm                                                                       \
     exrl-ssm-early                                                             \
     sam                                                                        \
     lpsw                                                                       \
diff --git a/tests/tcg/s390x/cksm.S b/tests/tcg/s390x/cksm.S
new file mode 100644
index 00000000000..563fd3d233e
--- /dev/null
+++ b/tests/tcg/s390x/cksm.S
@@ -0,0 +1,29 @@
+    .org 0x8e
+program_interruption_code:
+    .org 0x1d0                         /* program new PSW */
+    .quad 0,pgm
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lmg %r0,%r1,cksm_args
+    cksm %r2,%r0
+    c %r2,cksm_exp
+    jne failure
+    .insn rre,0xb2410000,%r2,%r15      /* cksm %r2,%r15 */
+failure:
+    lpswe failure_psw
+pgm:
+    chhsi program_interruption_code,6  /* specification exception? */
+    jne failure
+    lpswe success_psw
+cksm_args:
+    .quad cksm_buf, 16
+cksm_buf:
+    .quad 0xaaaabbbbcccc0000, 0x12345678
+cksm_exp:
+    .long 0x89ab1234
+    .align 8
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.41.0


