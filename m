Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AAD759209
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3lx-0003AH-1q; Wed, 19 Jul 2023 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lR-0002dv-3c; Wed, 19 Jul 2023 05:46:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lP-0002sx-BN; Wed, 19 Jul 2023 05:46:32 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J9c8X2008388; Wed, 19 Jul 2023 09:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2aqWHsUW9csB6lutHv/SGm+KWj8k2t1oqI4jbWggXKE=;
 b=UCw92kZbIrZg2SSpgaAklBS9r+63/x8z+ALPd5xRcFxgUEk+o61G8o44p/rQ1M8n0EGg
 VjMIZkPCewZvZMjk9MpNr/O5/2eZpCDWTSNAylEuOWDg+4eiupL+/IF8AYEg8qxlfq/W
 UkyVbBWS7otzemQRog4hVPADuSw2Jo/i/PNdbL6RnctAmxZBJt5hPHUt7Gr5r03OdAo5
 ygjj7mdR5z+wfNn0lKRQ4VSyaV4hChnApMhNejn25eseIM80ApLrGgst6zcvNI7EwmsH
 JDKD7l8fwooUIX1p+mYmR2Cr0OuaWVa+187MyChWq02sp6UQkjBehC1oq9IifZb26NiN nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc8e1syc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:29 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9degF019207;
 Wed, 19 Jul 2023 09:46:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc8e1sxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J8O7EB003394; Wed, 19 Jul 2023 09:46:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xh2qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9kPad43778762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:46:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C954D20040;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7B9520049;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:46:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 12/14] tests/tcg/s390x: Test MC
Date: Wed, 19 Jul 2023 11:44:22 +0200
Message-ID: <20230719094620.363206-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719094620.363206-1-iii@linux.ibm.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8kGqZ3ZUAWZFdFTCk00K1-6NJR-ayZgY
X-Proofpoint-ORIG-GUID: xD8Vw86yKzhI4CKz8NN-RToJocsIb_ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=822
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190087
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
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/mc.S                    | 56 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/s390x/mc.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 58684d7da71..145e0bfde16 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -24,6 +24,7 @@ ASM_TESTS =                                                                    \
     lpsw                                                                       \
     lpswe-early                                                                \
     lra                                                                        \
+    mc                                                                         \
     ssm-early                                                                  \
     stosm-early                                                                \
     unaligned-lowcore
diff --git a/tests/tcg/s390x/mc.S b/tests/tcg/s390x/mc.S
new file mode 100644
index 00000000000..e7466bb4b57
--- /dev/null
+++ b/tests/tcg/s390x/mc.S
@@ -0,0 +1,56 @@
+    .org 0x8d
+ilc:
+    .org 0x8e
+program_interruption_code:
+    .org 0x94
+monitor_class:
+    .org 0xb0
+monitor_code:
+    .org 0x150
+program_old_psw:
+    .org 0x1d0                              /* program new PSW */
+    .quad 0x180000000,pgm                   /* 64-bit mode */
+    .org 0x200                              /* lowcore padding */
+    .globl _start
+_start:
+    stctg %c8,%c8,c8                        /* enable only monitor class 1 */
+    mvhhi c8+6,0x4000
+    lctlg %c8,%c8,c8
+mc_nop:
+    mc 123,0
+mc_monitor_event:
+    mc 321,1
+    j failure
+mc_specification:
+    mc 333,16
+    j failure
+pgm:
+    lgrl %r0,program_old_psw+8              /* ilc adjustment */
+    llgc %r1,ilc
+    sgr %r0,%r1
+    larl %r1,mc_monitor_event               /* dispatch based on old PSW */
+    cgrje %r0,%r1,pgm_monitor_event
+    larl %r1,mc_specification
+    cgrje %r0,%r1,pgm_specification
+    j failure
+pgm_monitor_event:
+    chhsi program_interruption_code,0x40    /* monitor event? */
+    jne failure
+    chhsi monitor_class,1                   /* class from mc_monitor_event? */
+    jne failure
+    cghsi monitor_code,321                  /* code from mc_monitor_event? */
+    jne failure
+    j mc_specification                      /* next test */
+pgm_specification:
+    chhsi program_interruption_code,6       /* specification exception? */
+    jne failure
+    lpswe success_psw
+failure:
+    lpswe failure_psw
+    .align 8
+c8:
+    .quad 0
+success_psw:
+    .quad 0x2000000000000,0xfff             /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0                 /* disabled wait */
-- 
2.41.0


