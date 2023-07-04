Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AFB746BAA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbCi-000491-Nu; Tue, 04 Jul 2023 04:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCR-0003UO-7i; Tue, 04 Jul 2023 04:15:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCP-0002hR-NG; Tue, 04 Jul 2023 04:15:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36487WoW012237; Tue, 4 Jul 2023 08:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l/B8RHm+YUichHWCJ2ZPZJMv5Y4S2yjy7YqZT3+ZIgc=;
 b=AA5dLHCrdGNe7bL9EQt1+OA2ZZhdOlQWhROBLCk9uHi/jFfppImLXn1sZIE4NCwjBds9
 gLr2a2BguF1Tb+jTvsZ+MciObBx8cf+3AEO/YhWSYgRRnlptd9AGoYOPHmi2/9VgicDz
 CEVuj4zIU2MHU/ynFUJ/NwdXCvLW1A74uObmr7HoJUNBkptTW6SFLHF/KqQfGonicZKT
 79aZVioJ4w4eT+UWD6wG1L79p6J9XtOv0+94t2trJCZDxYzB9tOBs/f/iLJa70UgJPdx
 6IgWl0bLtkLKqfSsa2bf+VWYVnu1aO8CNJe9wQlzyFYGy9U/lQvbmxwutX/vVzhdGuCL zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8jwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364896IC019494;
 Tue, 4 Jul 2023 08:15:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8juw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642C6gO006744;
 Tue, 4 Jul 2023 08:15:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde1wby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648Ffon19726934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 328FC2004E;
 Tue,  4 Jul 2023 08:15:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D69F20040;
 Tue,  4 Jul 2023 08:15:40 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 10/12] tests/tcg/s390x: Test LRA
Date: Tue,  4 Jul 2023 10:12:34 +0200
Message-ID: <20230704081506.276055-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T39VCIlviWHVfkANprDTM_S5Hr03mNL2
X-Proofpoint-ORIG-GUID: Pbkmhze98ag7_ppxFnKbwjKs4fkLfiFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
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


