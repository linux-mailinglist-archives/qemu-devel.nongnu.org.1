Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A26712C43
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bw0-0005eM-R1; Fri, 26 May 2023 14:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvt-0005dm-D9; Fri, 26 May 2023 14:12:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvr-0007SH-Q1; Fri, 26 May 2023 14:12:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QHlFmQ021033; Fri, 26 May 2023 18:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nOsWPwydeTeB14hdKPi4kKfA4hAxshxxe1narheyvqE=;
 b=WqrDiuR/4NpDbwcM5Wx5aBFGdkJXStYwBTMT53XIWKdW5kkfFGKgrSkoxGF2f3YYooEH
 T0K6HhzMY6nnXiuLlT7exI72T46dU97L7UslV8aPztNMdW1pxKaeNk7cYGtEUKrNNIkr
 1P0j6ZFfBT89xsPsU8Bkr480rQlAeVoBwRIge9JX5eRT1TYBHDqtUjXFrtbuDYXjgP2M
 4nlbsaKEOg86L4v4sjmbG6D45CJFd7mwCxxftg3M7VpZ2YCcV/PbKQ3uIGYenVZOP7dm
 NVjrYZVkPSGdBX/U/rP4ZatRiaVz0sTDEbw2FYXJVs1LHeN0Xy3H13HeWi/Zdw25mTqe aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxu14gx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:52 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QIASNx018139;
 Fri, 26 May 2023 18:12:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxu14gwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBWeRo008475;
 Fri, 26 May 2023 18:12:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcub2sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QICl6M24707616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 18:12:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6960220043;
 Fri, 26 May 2023 18:12:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3D6E20040;
 Fri, 26 May 2023 18:12:46 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.7.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 18:12:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/s390x: Fix LCBB overwriting the top 32 bits
Date: Fri, 26 May 2023 20:12:37 +0200
Message-Id: <20230526181240.1425579-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526181240.1425579-1-iii@linux.ibm.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GDtMzd8iWABPP4EEsytIAWpi59aOQPBG
X-Proofpoint-ORIG-GUID: soZ-9S0NQEITR9_h4JTsbbfvqF18X5ez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=945 clxscore=1011 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260154
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

LCBB is supposed to overwrite only the bottom 32 bits, but QEMU
erroneously overwrites the entire register.

Fixes: 6d9303322ed9 ("s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index bcc70d99ba2..e41672684aa 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -486,7 +486,7 @@
     F(0xb343, LCXBR,   RRE,   Z,   x2h, x2l, new_P, x1_P, negf128, f128, IF_BFP)
     F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2, new, f1, negf64, 0, IF_AFP1 | IF_AFP2)
 /* LOAD COUNT TO BLOCK BOUNDARY */
-    C(0xe727, LCBB,    RXE,   V,   la2, 0, r1, 0, lcbb, 0)
+    C(0xe727, LCBB,    RXE,   V,   la2, 0, new, r1_32, lcbb, 0)
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
-- 
2.40.1


