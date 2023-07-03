Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF37C746040
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwX-0002by-Km; Mon, 03 Jul 2023 11:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwU-0002RW-Jq; Mon, 03 Jul 2023 11:58:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwS-0004gO-QE; Mon, 03 Jul 2023 11:58:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FqPQJ031381; Mon, 3 Jul 2023 15:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=idB/ZACHz9KfBZi4zHVrewq86UJ6nC50Jk6duiAJNEA=;
 b=P41se64fETY2JB2kVWyYboXkPmCWQppH4zFgf0/zzsBq0yw15Xs4A2Jx/UNe5xMWNlHE
 qJgkHo4wfwAO+dpGk7W5aNtqPXxxi24Xik+UybtJd/sg4l7C2TRwqiQQyXh2TvPD1BuB
 cWv6TZ6dJTZuUj/uHYzXjiJga8rOf/pv36RGRw0MyfD0ZJBoJHMGsCbQS0ynqrPu0JSn
 TVIvNpj6hnPfU9UtVjuv1vyWMN+dbYbeHGsLKUHlMQUZponhgn7ws+pljz6ltUzQZIvK
 b/TUB7YYOL5G1/oPFO8KjO2p4cY3D+afiU4qG+Wn64Vr0Wj1WyGMkjHFeG+gl+FxHhhi oA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:18 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FrovC002954;
 Mon, 3 Jul 2023 15:58:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 362AOi62001864;
 Mon, 3 Jul 2023 15:58:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sdd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwDRW35390184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8876A20043;
 Mon,  3 Jul 2023 15:58:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DC7920040;
 Mon,  3 Jul 2023 15:58:13 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 03/12] target/s390x: Fix MDEB and MDEBR
Date: Mon,  3 Jul 2023 17:50:29 +0200
Message-ID: <20230703155801.179167-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8rOP0-D_Jq7RBWqZp1J6sElr3xjTftvk
X-Proofpoint-GUID: vfPBPQHCbecWVAv_RARyKLEz2lFfEkdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=730 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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

These instructions multiply 32 bits by 32 bits, not 32 bits by 64 bits.

Fixes: 83b00736f3d8 ("target-s390: Convert FP MULTIPLY")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/fpu_helper.c    | 3 ++-
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 57e58292833..4b7fa58af3e 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -306,8 +306,9 @@ uint64_t HELPER(mdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 /* 64/32-bit FP multiplication */
 uint64_t HELPER(mdeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
+    float64 f1_64 = float32_to_float64(f1, &env->fpu_status);
     float64 ret = float32_to_float64(f2, &env->fpu_status);
-    ret = float64_mul(f1, ret, &env->fpu_status);
+    ret = float64_mul(f1_64, ret, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0a45dbbcda8..457ed25d2fa 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -667,11 +667,11 @@
     F(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0, IF_BFP)
     F(0xb31c, MDBR,    RRE,   Z,   f1, f2, new, f1, mdb, 0, IF_BFP)
     F(0xb34c, MXBR,    RRE,   Z,   x1, x2, new_x, x1, mxb, 0, IF_BFP)
-    F(0xb30c, MDEBR,   RRE,   Z,   f1, e2, new, f1, mdeb, 0, IF_BFP)
+    F(0xb30c, MDEBR,   RRE,   Z,   e1, e2, new, f1, mdeb, 0, IF_BFP)
     F(0xb307, MXDBR,   RRE,   Z,   f1, f2, new_x, x1, mxdb, 0, IF_BFP)
     F(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0, IF_BFP)
     F(0xed1c, MDB,     RXE,   Z,   f1, m2_64, new, f1, mdb, 0, IF_BFP)
-    F(0xed0c, MDEB,    RXE,   Z,   f1, m2_32u, new, f1, mdeb, 0, IF_BFP)
+    F(0xed0c, MDEB,    RXE,   Z,   e1, m2_32u, new, f1, mdeb, 0, IF_BFP)
     F(0xed07, MXDB,    RXE,   Z,   f1, m2_64, new_x, x1, mxdb, 0, IF_BFP)
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
-- 
2.41.0


