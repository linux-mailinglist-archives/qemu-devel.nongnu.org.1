Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA97591EA
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3la-0002mY-TS; Wed, 19 Jul 2023 05:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lQ-0002da-7i; Wed, 19 Jul 2023 05:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qM3lN-0002s5-CB; Wed, 19 Jul 2023 05:46:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J9AJXd017345; Wed, 19 Jul 2023 09:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MVrbDtZCCqPX/jG8h5oVqBcZ6utEwvAK2gZKiHnTt7o=;
 b=SHIamjbVTEh2P7zCsSF8IxJ6WzXjv6HdqFHMwCUMHEcIw1HdSH6fjwJqQvrfq6l/k7ro
 +l6gSItLhYpZ5Z5ZiFq6lODO9Q6f8Dv0Kosbzolkod0mhWaP9B+WTTin39qAf2n2MPAQ
 OJxpruyDbS9QNd651o81IYtMtMCSu1WxpRqPpQU6zBOdzBA5vX50jqcCRd+RxduRVGFE
 H0AJH1o0bu1eFjEUZefhxGq9FAtCOiqruJ94qYDbXZAfF/pa3tSIhI+jQu7XMqH8jwHy
 PmLgI82vQt5GxbxX0R5KxufP4RImRqVCyV1LMC9591nW+3zm/cyAq2l+poXSQ6mp8DHD GA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx86f6vfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J9dYa5018080;
 Wed, 19 Jul 2023 09:46:26 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx86f6vfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J77Y4a007491; Wed, 19 Jul 2023 09:46:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j6q6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:46:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9kO5k7406128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:46:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36D7220040;
 Wed, 19 Jul 2023 09:46:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 088942004B;
 Wed, 19 Jul 2023 09:46:24 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 09:46:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 03/14] target/s390x: Fix CONVERT TO LOGICAL/FIXED with
 out-of-range inputs
Date: Wed, 19 Jul 2023 11:44:13 +0200
Message-ID: <20230719094620.363206-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719094620.363206-1-iii@linux.ibm.com>
References: <20230719094620.363206-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7_JMK_QHRHagwWEEBtNIc1vmLgB4-0SF
X-Proofpoint-ORIG-GUID: eHCSHKtGKSRmjc1EZRNh5eQ2-Zsbeown
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

CONVERT TO LOGICAL/FIXED deviate from IEEE 754 in that they raise an
inexact exception on out-of-range inputs. float_flag_invalid_cvti
aligns nicely with that behavior, so convert it to
S390_IEEE_MASK_INEXACT.

Cc: qemu-stable@nongnu.org
Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/fpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 4b7fa58af3e..3d941ed2d28 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -52,7 +52,8 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
     s390_exc |= (exc & float_flag_divbyzero) ? S390_IEEE_MASK_DIVBYZERO : 0;
     s390_exc |= (exc & float_flag_overflow) ? S390_IEEE_MASK_OVERFLOW : 0;
     s390_exc |= (exc & float_flag_underflow) ? S390_IEEE_MASK_UNDERFLOW : 0;
-    s390_exc |= (exc & float_flag_inexact) ? S390_IEEE_MASK_INEXACT : 0;
+    s390_exc |= (exc & (float_flag_inexact | float_flag_invalid_cvti)) ?
+                S390_IEEE_MASK_INEXACT : 0;
 
     return s390_exc;
 }
-- 
2.41.0


