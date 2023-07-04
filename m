Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5D746BB1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:17:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbC3-0003PZ-CW; Tue, 04 Jul 2023 04:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbC1-0003OT-GR; Tue, 04 Jul 2023 04:15:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbBz-0002XZ-Um; Tue, 04 Jul 2023 04:15:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647pV5N018017; Tue, 4 Jul 2023 08:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nm5pU/w6416SY50Zq/wk1szUmKSfOTEdtLu0jnZNd9A=;
 b=pTQQZfnHdgkVlEFYJBRhvhPQwAgR/6xJMKdi+rrmkYGDfCsZ6x8nnDEanwil4m8XHtzX
 80d5GiE6IIF5v991C3DZOvfCQ9LeQF7nQNT7l7yJl2umhlLcOacwbSuPI8dIJ1XC/kUM
 W0Idf0S1d3vRyHA3T2GDdtvs63+kH/6QIw1RhdrqvaPPE4sMlwPOQWHA2UdLxsq/D2ij
 TG/SC68PUuewB5Xohm5w4KFc7haQ8kQRwdlhPy8eO95UD1mkDpMqfeDUDow+nrWxRPD1
 JyZkgNRnc/HSLpH9yf+rG1YaFwfajI/+12KsyHjeeybnPu3t3qCbpD25vqeyytVg5n// 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdg8jyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:21 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36484tJk029882;
 Tue, 4 Jul 2023 08:15:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdg8jxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3644dk4t017507;
 Tue, 4 Jul 2023 08:15:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4swmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648FHl640239526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA70620043;
 Tue,  4 Jul 2023 08:15:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49DBC20040;
 Tue,  4 Jul 2023 08:15:16 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 02/12] target/s390x: Fix EPSW CC reporting
Date: Tue,  4 Jul 2023 10:12:26 +0200
Message-ID: <20230704081506.276055-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VaOCBAVXtKvK8fEk2rSKvqVRsgKCsY3D
X-Proofpoint-GUID: sxVCbJXDrO0g6DAgTS8GDWZ38A-HWQD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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


