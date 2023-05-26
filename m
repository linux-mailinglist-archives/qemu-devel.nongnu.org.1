Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5D712C41
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bw9-0005h8-MF; Fri, 26 May 2023 14:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvx-0005ek-Cz; Fri, 26 May 2023 14:13:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvv-0007Sn-9R; Fri, 26 May 2023 14:13:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QHK3cA004254; Fri, 26 May 2023 18:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=u94j3SduoNYGbvixA7Np7TI4LEbvXQFqgsHAdyrplxg=;
 b=TISeG45XiKmoBIhNhpBjWrM/KWrqv81EEabUG3CNB0TwdiQ31AJbfk3OWWPT8gsZYAB5
 aXo7VhyCesJiQz6KralGXpYNQtPwYxH8jqZqrsY/eeiKPutSQqVRzgum7HlnL5zLcfN4
 RB7AGpxWFot6vF1wIhuFaAl3iXqWMpxCOLri2EbbGz4m/6qRaM6QTmt2C1FcRx6f9zz5
 eJZzx8ASVsB/GmFPv3eOzQ3uX7ifhUyX5qtTHV1m2I1uysqgSiMLnqSa3KK+mrJjPozs
 sougnQkTRhL+W4LX0Eck9ywtbvbQOYXxL/5uA7DnWZIbpeugonaHMh/gVsQ9NKg8gjcD hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qu12u0xyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QI7m8Q012962;
 Fri, 26 May 2023 18:12:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qu12u0xye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAjLQc026911;
 Fri, 26 May 2023 18:12:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk32p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QICqq719726950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 18:12:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62D0D20043;
 Fri, 26 May 2023 18:12:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D10D620040;
 Fri, 26 May 2023 18:12:51 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.7.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 18:12:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Mikhail Mitskevich <mitskevichmn@gmail.com>
Subject: [PATCH 3/4] target/s390x: Fix LOCFHR taking the wrong half of R2
Date: Fri, 26 May 2023 20:12:39 +0200
Message-Id: <20230526181240.1425579-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526181240.1425579-1-iii@linux.ibm.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kxZ-JVSGdAUC75oBH_hA1tNdF4YAOPxf
X-Proofpoint-ORIG-GUID: 3mBjic1gc_J4hqWHe_RRuM7xJltpl6IL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=876
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260154
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

LOCFHR should write top-to-top, but QEMU erroneously writes
bottom-to-top.

Fixes: 45aa9aa3b773 ("target/s390x: Implement load-on-condition-2 insns")
Cc: qemu-stable@nongnu.org
Reported-by: Mikhail Mitskevich <mitskevichmn@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1668
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index e41672684aa..937e18ea9d9 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -564,7 +564,7 @@
     C(0xec46, LOCGHI,  RIE_g, LOC2, r1, i2, r1, 0, loc, 0)
     C(0xec4e, LOCHHI,  RIE_g, LOC2, r1_sr32, i2, new, r1_32h, loc, 0)
 /* LOAD HIGH ON CONDITION */
-    C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2, new, r1_32h, loc, 0)
+    C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2_sr32, new, r1_32h, loc, 0)
     C(0xebe0, LOCFH,   RSY_b, LOC2, r1_sr32, m2_32u, new, r1_32h, loc, 0)
 /* LOAD PAIR DISJOINT */
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
-- 
2.40.1


