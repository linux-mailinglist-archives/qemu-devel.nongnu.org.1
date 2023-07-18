Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BD75874C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLsN1-0007je-4c; Tue, 18 Jul 2023 17:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMy-0007ft-G7; Tue, 18 Jul 2023 17:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMi-00044h-3A; Tue, 18 Jul 2023 17:36:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ILA0wq006119; Tue, 18 Jul 2023 21:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2aqWHsUW9csB6lutHv/SGm+KWj8k2t1oqI4jbWggXKE=;
 b=eWMhM176nRI0SzPapcLLOGUvCGTybuUOzhq9MQpoUIelfmWnU/F3WjejQSscKhG/rkNC
 4xOlKdIag4MIW7+DJpzN6cR0ZskdCQwsA8H/S7bBUSE0ZKtLnw9htIdItyVaCQr1dbq5
 qlK/yAtlCcdlsCmqn4sMXFXEb1PAkiQ1cXmUJ7yfthY0Q3FNxj55bhtayF6TT/K/NC41
 Dk+tCq3QZ5vJaAH7xVKzWTiWC+mKRomed5TpfXSLtNRw0szfCCiP/ahe7BOHDOVPLvO3
 T6z82cYmgM7jLw3wdvoJiIS+dNgMBhBOxTJYByANa/tkeqGGAEOudv5aDJVSUq+VVZCo lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx10tjtq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:13 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ILCXjX014009;
 Tue, 18 Jul 2023 21:36:13 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx10tjtpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IJLHiV017218; Tue, 18 Jul 2023 21:36:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srqgmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:36:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ILaAcc18022976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 21:36:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974482004B;
 Tue, 18 Jul 2023 21:36:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3502320040;
 Tue, 18 Jul 2023 21:36:10 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.14.165])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 21:36:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 12/14] tests/tcg/s390x: Test MC
Date: Tue, 18 Jul 2023 23:21:13 +0200
Message-ID: <20230718213531.117976-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718213531.117976-1-iii@linux.ibm.com>
References: <20230718213531.117976-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 17sFBLozVTHgMbobkwm8AfghMrQtWMbs
X-Proofpoint-ORIG-GUID: 4A5th6JXhRb5pgaTJU8EhrZwYYyD2LaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_16,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=822 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180192
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


