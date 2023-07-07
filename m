Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3E74B47D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnbz-0001WI-Hq; Fri, 07 Jul 2023 11:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qHnbx-0001Vq-Ml; Fri, 07 Jul 2023 11:43:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qHnbi-0003xK-SQ; Fri, 07 Jul 2023 11:43:09 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 367FUBM8008142; Fri, 7 Jul 2023 15:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2Yzl2lOCMGuFmZBlaFBiqRx/gCjjOMejyF5NVeX1hqU=;
 b=cQfbSA7s8V97+NCOZIDLNPPS9uFka02TxWcKqcTogmPHKOBTYuXSYkPbSLr/B06ypZCT
 RZCSC7EHf/iosaYSuCqcLl52InSqtlyIL7VNUt+oHY3PsP6FSW/7elTVIco2g5pQ7xEw
 /zcA0Cs9XzKfITLUzT9XWJOeTIG4HDhQshfmKC08cAwPuPrRmpqvgN0UsTiQJ4PwzlzY
 R92abmyAG3ASqtBMHpvgZ/4Ln+w9Mbhv/D6A7hAP0Y/MDwZ4w++K7xv4vD+u2HlyGWL/
 DFmSHNDViB+ufC9VQLtf2ZKOSRPDi/HZEJJrHATVcojPqYi3fFLbMmsTxkN6mYWBgLca Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpndcrmdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 15:42:49 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367FUxrN012237;
 Fri, 7 Jul 2023 15:42:48 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpndcrmd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 15:42:48 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 366NsORB031301;
 Fri, 7 Jul 2023 15:42:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4u0hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 15:42:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 367Fgisr57147856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jul 2023 15:42:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87DC020043;
 Fri,  7 Jul 2023 15:42:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 173AA20040;
 Fri,  7 Jul 2023 15:42:44 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.83.128])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jul 2023 15:42:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg/s390x: Fix test-svc with clang
Date: Fri,  7 Jul 2023 17:42:21 +0200
Message-ID: <20230707154242.457706-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lXB9tYu8o3BF3BbX46p5grbFMre_3HKi
X-Proofpoint-GUID: HoACYBMqX7Vm3tfnP8XpeuhhdDRCD-D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=996
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070144
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

clang does not support expressions involving symbols in instructions
like lghi yet, so building hello-s390x-asm.S with it fails.

Move the expression to the literal pool and load it from there.

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: be4a4cb42961 ("tests/tcg/s390x: Test single-stepping SVC")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/gdbstub/test-svc.py | 2 +-
 tests/tcg/s390x/hello-s390x-asm.S   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstub/test-svc.py
index 7851ca72846..18fad3f163d 100644
--- a/tests/tcg/s390x/gdbstub/test-svc.py
+++ b/tests/tcg/s390x/gdbstub/test-svc.py
@@ -25,7 +25,7 @@ def run_test():
     gdb.execute("si")
     report("larl\t" in gdb.execute("x/i $pc", False, True), "insn #2")
     gdb.execute("si")
-    report("lghi\t" in gdb.execute("x/i $pc", False, True), "insn #3")
+    report("lgrl\t" in gdb.execute("x/i $pc", False, True), "insn #3")
     gdb.execute("si")
     report("svc\t" in gdb.execute("x/i $pc", False, True), "insn #4")
     gdb.execute("si")
diff --git a/tests/tcg/s390x/hello-s390x-asm.S b/tests/tcg/s390x/hello-s390x-asm.S
index 2e9faa16047..4dbda12d35d 100644
--- a/tests/tcg/s390x/hello-s390x-asm.S
+++ b/tests/tcg/s390x/hello-s390x-asm.S
@@ -8,7 +8,7 @@ _start:
 /* puts("Hello, World!"); */
 lghi %r2,1
 larl %r3,foo
-lghi %r4,foo_end-foo
+lgrl %r4,foo_len
 svc 4
 
 /* exit(0); */
@@ -18,3 +18,5 @@ svc 1
 .align 2
 foo: .asciz "Hello, World!\n"
 foo_end:
+.align 8
+foo_len: .quad foo_end-foo
-- 
2.41.0


