Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D80746049
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:01:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwe-0002mC-68; Mon, 03 Jul 2023 11:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwb-0002l5-Nq; Mon, 03 Jul 2023 11:58:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwa-0004iz-9H; Mon, 03 Jul 2023 11:58:29 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FlJP2008797; Mon, 3 Jul 2023 15:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CsguvEs4uO/a5sJwDVVLYdPbsLnj4azHh/t+gBvkynU=;
 b=VEWXw4eXyaRQPMy6CHwQ3bE1MclQvO1sY5Nd9sKBcnCUB8Df4hkZF0pRCkxDfsYl0PXt
 vhKpPijAi+jG2y/FMYO6Y+Xg6Nu/54Nhid4OgQvyDz1mL/QjXLEIuQpEIBv67qAmROEf
 TWr3hiEsCUxFL+MndDFI9Gxh5qFW8CHtyfHrq/fzE0gmTG6XyhkI0ytb5yv7eTwJhG8C
 i95GuCNtctFapfhI47VBnTkCuWae1l1VuAfEidWFOLrLGUu9NcGXewiu/Z4JAHJQAW0B
 JTrqmKfWS4LRHITOCXtHNvuzouegxxDwjq6JWYtNVwou4d3onodJwShMYTUmDT+K1j+I IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm197g8nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:26 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FmCG5010417;
 Mon, 3 Jul 2023 15:58:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm197g8nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 363ExCJ4023894;
 Mon, 3 Jul 2023 15:58:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sdda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwLnD45744526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EBC52004D;
 Mon,  3 Jul 2023 15:58:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DC8120043;
 Mon,  3 Jul 2023 15:58:21 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 07/12] target/s390x: Fix relative long instructions with large
 offsets
Date: Mon,  3 Jul 2023 17:50:33 +0200
Message-ID: <20230703155801.179167-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uBh3NCwM8SWbwPO573UHMqXkl9KqGt4_
X-Proofpoint-ORIG-GUID: c_ty1LD8ge7d0bXlM8xGsp31rwn1hEcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030141
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

The expression "imm * 2" in gen_ri2() can wrap around if imm is large
enough.

Fix by casting imm to int64_t, like it's done in disas_jdest().

Fixes: e8ecdfeb30f0 ("Fix EXECUTE of relative branches")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a6079ab7b4f..6661b27efa4 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5794,7 +5794,7 @@ static TCGv gen_ri2(DisasContext *s)
 
     disas_jdest(s, i2, is_imm, imm, ri2);
     if (is_imm) {
-        ri2 = tcg_constant_i64(s->base.pc_next + imm * 2);
+        ri2 = tcg_constant_i64(s->base.pc_next + (int64_t)imm * 2);
     }
 
     return ri2;
-- 
2.41.0


