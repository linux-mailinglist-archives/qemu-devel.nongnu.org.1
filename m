Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412E75875F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLsMZ-0007Sy-AR; Tue, 18 Jul 2023 17:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMV-0007Qs-Tk; Tue, 18 Jul 2023 17:36:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMU-0003il-9n; Tue, 18 Jul 2023 17:36:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ILHHdn000334; Tue, 18 Jul 2023 21:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tjmW9HgxSG7MZZFemD4xZolrM41gqEK38b3nc9r2mCY=;
 b=lu3i7NZ9PA0L9+7+BI5zvEEXf3JF5MUgwORMMc8tNlxvZrsYJ9BgR1tPAuKE2NwWZj7Y
 +8S0d1ovBRlWho5/W6Q6i8DdJJuBT2BeZ/M9ktRrVXRgJghelDXhEBnNXvbVwmrXQM6R
 N9gP7H8dybxL50SWcQIDE46NJqcrYruXrw4SjSdRCRnLVWF9QBBQasqAKfS/8GsYJE+6
 Nq0FekFKA09VIRanagPIEBjdbbuyO3FoSqJEQO+3380uWfpec1UUcsSyl9EkvN98l5Ab
 JTvjVLx6nJq8Dvz/TA8HloRm04plRNr8LtAj8yKAwlrevWF+6wTxPiRRZavA1rIjEkhr fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwxy3my62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:59 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IKdd9s003266;
 Tue, 18 Jul 2023 21:35:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwxy3my5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IJVU2d016914; Tue, 18 Jul 2023 21:35:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srqgkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ILZucX18022962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 21:35:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD58120043;
 Tue, 18 Jul 2023 21:35:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7373B2004D;
 Tue, 18 Jul 2023 21:35:56 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.14.165])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 21:35:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 07/14] target/s390x: Fix assertion failure in VFMIN/VFMAX with
 reserved type
Date: Tue, 18 Jul 2023 23:21:08 +0200
Message-ID: <20230718213531.117976-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718213531.117976-1-iii@linux.ibm.com>
References: <20230718213531.117976-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f3w9ecQ95pcoLBvi6LqyKkvWUHF5OKuC
X-Proofpoint-GUID: E2LfKhEpWgmRuEDoimoW_6W05wVW9Ef_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_16,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=679 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180192
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

Passing reserved type to VFMIN/VFMAX causes an assertion failure in
vfmin_res() and vfmax_res(). These instructions should raise a
specification exception in this case.

Cc: qemu-stable@nongnu.org
Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/vec_fpu_helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
index 75cf605b9f4..f1671679879 100644
--- a/target/s390x/tcg/vec_fpu_helper.c
+++ b/target/s390x/tcg/vec_fpu_helper.c
@@ -915,7 +915,7 @@ static void vfminmax32(S390Vector *v1, const S390Vector *v2,
         float32 b = s390_vec_read_float32(v3, i);
         float32 result;
 
-        if (type != S390_MINMAX_TYPE_IEEE) {
+        if (type > S390_MINMAX_TYPE_IEEE && type <= S390_MINMAX_TYPE_F) {
             S390MinMaxRes res;
 
             if (is_abs) {
@@ -944,12 +944,14 @@ static void vfminmax32(S390Vector *v1, const S390Vector *v2,
             default:
                 g_assert_not_reached();
             }
-        } else if (!is_abs) {
+        } else if (type == S390_MINMAX_TYPE_IEEE && !is_abs) {
             result = is_min ? float32_minnum(a, b, &env->fpu_status) :
                               float32_maxnum(a, b, &env->fpu_status);
-        } else {
+        } else if (type == S390_MINMAX_TYPE_IEEE) {
             result = is_min ? float32_minnummag(a, b, &env->fpu_status) :
                               float32_maxnummag(a, b, &env->fpu_status);
+        } else {
+            tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
         }
 
         s390_vec_write_float32(&tmp, i, result);
@@ -977,7 +979,7 @@ static void vfminmax64(S390Vector *v1, const S390Vector *v2,
         float64 b = s390_vec_read_float64(v3, i);
         float64 result;
 
-        if (type != S390_MINMAX_TYPE_IEEE) {
+        if (type > S390_MINMAX_TYPE_IEEE && type <= S390_MINMAX_TYPE_F) {
             S390MinMaxRes res;
 
             if (is_abs) {
@@ -1006,12 +1008,14 @@ static void vfminmax64(S390Vector *v1, const S390Vector *v2,
             default:
                 g_assert_not_reached();
             }
-        } else if (!is_abs) {
+        } else if (type == S390_MINMAX_TYPE_IEEE && !is_abs) {
             result = is_min ? float64_minnum(a, b, &env->fpu_status) :
                               float64_maxnum(a, b, &env->fpu_status);
-        } else {
+        } else if (type == S390_MINMAX_TYPE_IEEE) {
             result = is_min ? float64_minnummag(a, b, &env->fpu_status) :
                               float64_maxnummag(a, b, &env->fpu_status);
+        } else {
+            tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
         }
 
         s390_vec_write_float64(&tmp, i, result);
@@ -1035,7 +1039,7 @@ static void vfminmax128(S390Vector *v1, const S390Vector *v2,
     uint8_t vxc, vec_exc = 0;
     float128 result;
 
-    if (type != S390_MINMAX_TYPE_IEEE) {
+    if (type > S390_MINMAX_TYPE_IEEE && type <= S390_MINMAX_TYPE_F) {
         S390MinMaxRes res;
 
         if (is_abs) {
@@ -1064,12 +1068,14 @@ static void vfminmax128(S390Vector *v1, const S390Vector *v2,
         default:
             g_assert_not_reached();
         }
-    } else if (!is_abs) {
+    } else if (type == S390_MINMAX_TYPE_IEEE && !is_abs) {
         result = is_min ? float128_minnum(a, b, &env->fpu_status) :
                           float128_maxnum(a, b, &env->fpu_status);
-    } else {
+    } else if (type == S390_MINMAX_TYPE_IEEE) {
         result = is_min ? float128_minnummag(a, b, &env->fpu_status) :
                           float128_maxnummag(a, b, &env->fpu_status);
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
     }
 
     vxc = check_ieee_exc(env, 0, false, &vec_exc);
-- 
2.41.0


