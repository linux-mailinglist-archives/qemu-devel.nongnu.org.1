Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1FA770C72
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4Mv-0000JI-Mk; Fri, 04 Aug 2023 19:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Mt-0000IK-Sp; Fri, 04 Aug 2023 19:38:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Mq-000847-O6; Fri, 04 Aug 2023 19:38:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374NVWUb010391; Fri, 4 Aug 2023 23:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0itJ4qmO9NXVrwd1l5CXGLamNUmmPNY6Ge45CNbDlk0=;
 b=PcoX7Dt2RJPSJbFHZGGIxuM2le6oMMEsZZcrbU/VqgXZ/4V9dwDM65BnAhw/QxUdS2rZ
 8NlHLexxdd8actb5ZZPJRV0bolKuOv6AOt0FPPKKsPTuGrzCoEHpTO5k6EtIUYwTzTbF
 Hj7Cks+7NRsBrccfHDkp9pM/y7WWKjuzAtTW0Skpy9BN2rC9K9AuHCT9nsfa83FtoteY
 /XgR0ZpNIe7ipOal7mFZM24mGkSG+oeFG36JXPHTT9pFZ2FQdqq7FNvhjmDdGsoCNoS/
 0iHehmFFGivT6qCTe5rkTy6AQJjpUkrOFncayukvYZoPUH22Q151RkTSlzeozZ8Edr6g 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b3283pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:58 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374NXa06016037;
 Fri, 4 Aug 2023 23:37:57 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b3283nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374MlEq3018450; Fri, 4 Aug 2023 23:37:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp51wts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NbtLC5440154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:37:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20B4E20043;
 Fri,  4 Aug 2023 23:37:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87A4420040;
 Fri,  4 Aug 2023 23:37:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:37:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/3] target/s390x: Fix the "ignored match" case in VSTRS
Date: Sat,  5 Aug 2023 01:03:18 +0200
Message-ID: <20230804233748.218935-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804233748.218935-1-iii@linux.ibm.com>
References: <20230804233748.218935-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gFizbqYJlbb_MFrYLnDZhZvDMTf-0_o0
X-Proofpoint-ORIG-GUID: g047sEAy0S79wvxP8Bk8fpOWcxtI5pSa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040213
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently the emulation of VSTRS recognizes partial matches in presence
of \0 in the haystack, which, according to PoP, is not correct:

    If the ZS flag is one and a zero byte was detected
    in the second operand, then there can not be a
    partial match ...

Add a check for this. While at it, fold a number of explicitly handled
special cases into the generic logic.

Cc: qemu-stable@nongnu.org
Reported-by: Claudio Fontana <cfontana@suse.de>
Closes: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00633.html
Fixes: 1d706f314191 ("target/s390x: vxeh2: vector string search")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/vec_string_helper.c | 54 +++++++++-------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/target/s390x/tcg/vec_string_helper.c b/target/s390x/tcg/vec_string_helper.c
index 9b85becdfbf..a19f429768f 100644
--- a/target/s390x/tcg/vec_string_helper.c
+++ b/target/s390x/tcg/vec_string_helper.c
@@ -474,9 +474,9 @@ DEF_VSTRC_CC_RT_HELPER(32)
 static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
                  const S390Vector *v4, uint8_t es, bool zs)
 {
-    int substr_elen, substr_0, str_elen, i, j, k, cc;
+    int substr_elen, i, j, k, cc;
     int nelem = 16 >> es;
-    bool eos = false;
+    int str_leftmost_0;
 
     substr_elen = s390_vec_read_element8(v4, 7) >> es;
 
@@ -498,47 +498,20 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
     }
 
     /* If ZS, look for eos in the searched string. */
+    str_leftmost_0 = nelem;
     if (zs) {
         for (k = 0; k < nelem; k++) {
             if (s390_vec_read_element(v2, k, es) == 0) {
-                eos = true;
+                str_leftmost_0 = k;
                 break;
             }
         }
-        str_elen = k;
-    } else {
-        str_elen = nelem;
     }
 
-    substr_0 = s390_vec_read_element(v3, 0, es);
-
-    for (k = 0; ; k++) {
-        for (; k < str_elen; k++) {
-            if (s390_vec_read_element(v2, k, es) == substr_0) {
-                break;
-            }
-        }
-
-        /* If we reached the end of the string, no match. */
-        if (k == str_elen) {
-            cc = eos; /* no match (with or without zero char) */
-            goto done;
-        }
-
-        /* If the substring is only one char, match. */
-        if (substr_elen == 1) {
-            cc = 2; /* full match */
-            goto done;
-        }
-
-        /* If the match begins at the last char, we have a partial match. */
-        if (k == str_elen - 1) {
-            cc = 3; /* partial match */
-            goto done;
-        }
-
+    cc = str_leftmost_0 == nelem ? 0 : 1;  /* No match. */
+    for (k = 0; k < nelem; k++) {
         i = MIN(nelem, k + substr_elen);
-        for (j = k + 1; j < i; j++) {
+        for (j = k; j < i; j++) {
             uint32_t e2 = s390_vec_read_element(v2, j, es);
             uint32_t e3 = s390_vec_read_element(v3, j - k, es);
             if (e2 != e3) {
@@ -546,9 +519,16 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
             }
         }
         if (j == i) {
-            /* Matched up until "end". */
-            cc = i - k == substr_elen ? 2 : 3; /* full or partial match */
-            goto done;
+            /* All elements matched. */
+            if (k > str_leftmost_0) {
+                cc = 1;  /* Ignored match. */
+                k = nelem;
+            } else if (i - k == substr_elen) {
+                cc = 2;  /* Full match. */
+            } else {
+                cc = 3;  /* Partial match. */
+            }
+            break;
         }
     }
 
-- 
2.41.0


