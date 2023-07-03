Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3E74603F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwW-0002VU-10; Mon, 03 Jul 2023 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwT-0002M3-2T; Mon, 03 Jul 2023 11:58:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwR-0004g1-3z; Mon, 03 Jul 2023 11:58:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FqQpt031422; Mon, 3 Jul 2023 15:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GUOPLJIiHZBLXz+SRwiXxAkytPWKOaxNIWjMVdKHCko=;
 b=qMXAqIxuDsciC7wO8yXpLTFPVjB04s966t2PnTg+DC+9Q9GquQtHxdBJ7nNHle4k/tvj
 YgBgnygZaz23O/+NpXxunVr5aSBtkk5fAGf1g6Q4SgWtJVso3pDuDhUpMcL0j9xPrWxi
 Hnt9cPwPGTjUQ3Fs6qkNsdDaUXvwNEn2tHHpdUZhMvpjpHeK2hV620QMxj6XLQlMGRkJ
 r0IruUk/IhXa/TB+DqpWyFdz+CipvnkaItgOSo0NLK7P5laL9IpHRXDRU8sewg36hje8
 a5Z/AbPlVwOw7BSzuy4sqedKiice91qOWjFdJwjLQ/huAO3wS47xJfMzZ+E1bQ4my9ax Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:16 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FqpuH001267;
 Mon, 3 Jul 2023 15:58:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 362Nq54j000478;
 Mon, 3 Jul 2023 15:58:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sdd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwBHd38732430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95D6720043;
 Mon,  3 Jul 2023 15:58:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60F3C20040;
 Mon,  3 Jul 2023 15:58:11 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 02/12] target/s390x: Fix EPSW CC reporting
Date: Mon,  3 Jul 2023 17:50:28 +0200
Message-ID: <20230703155801.179167-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BKGreyoMhaz8jNEPjJjPJVR2pRoPF_gr
X-Proofpoint-GUID: KS0yvvGva-dshk8K1lakiSG1ctFELAKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030141
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

EPSW should explicitly calculate and insert CC, like IPM does.

Fixes: e30a9d3fea58 ("target-s390: Implement EPSW")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a6ee2d44234..0cef6efbef4 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2383,10 +2383,14 @@ static DisasJumpType op_epsw(DisasContext *s, DisasOps *o)
     int r1 = get_field(s, r1);
     int r2 = get_field(s, r2);
     TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 t_cc = tcg_temp_new_i64();
 
     /* Note the "subsequently" in the PoO, which implies a defined result
        if r1 == r2.  Thus we cannot defer these writes to an output hook.  */
+    gen_op_calc_cc(s);
+    tcg_gen_extu_i32_i64(t_cc, cc_op);
     tcg_gen_shri_i64(t, psw_mask, 32);
+    tcg_gen_deposit_i64(t, t, t_cc, 12, 2);
     store_reg32_i64(r1, t);
     if (r2 != 0) {
         store_reg32_i64(r2, psw_mask);
-- 
2.41.0


