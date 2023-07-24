Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899A75ED55
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqoi-0001GO-D0; Mon, 24 Jul 2023 04:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqoV-0001B2-4Y; Mon, 24 Jul 2023 04:21:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqoN-0001Q4-VN; Mon, 24 Jul 2023 04:21:06 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O89boC006054; Mon, 24 Jul 2023 08:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mvJQBXPlED2yKNKvIzdGCe/uN49apiAKQHUiRAqXFuE=;
 b=AOFXIKr+TgtnzRdrKkPtdWufe95C831nfhOSJgsgiTg0C5eTp50YPDatitP4tCBpdwnT
 W/jnCqJHbD8ZeoGgPdEut3zPDw1aPVX077IA3ZwJ8MBrbtezZJWSjwPSrvbG1R10aXRT
 CpzeMp5GbVRC3qjmTM4P5o1swZHEdyd1TZQ9P4zbEL6+MPJrQJ4oSNqZkkQ+wGM2vyeo
 pwW6W4h9e7a4t6Or83j5R/ofE33ped1siRpEc+e2fC/eZqJ9bbdaz2X7Lsgkz61z7T15
 mblAbpxUhhhrZgoepX3bMxn9sMtkUfWFGBixtDiE/UlYyz4a5f9ApxoRgUUM7KfWv6J2 rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1hscdw4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36O7dFol030049;
 Mon, 24 Jul 2023 08:20:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1hscdw47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O6CGfW002013; Mon, 24 Jul 2023 08:20:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0temhgnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36O8Kqlv3801614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jul 2023 08:20:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF3BA20040;
 Mon, 24 Jul 2023 08:20:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C81720043;
 Mon, 24 Jul 2023 08:20:51 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.11.212])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jul 2023 08:20:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 06/14] tcg/{i386,
 s390x}: Add earlyclobber to the op_add2's first output
Date: Mon, 24 Jul 2023 10:15:59 +0200
Message-ID: <20230724082032.66864-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724082032.66864-1-iii@linux.ibm.com>
References: <20230724082032.66864-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: InZeNReFEUmt63G8RvP2ZsGs0a4zVQHj
X-Proofpoint-ORIG-GUID: rwpNlzp_SboM2p3JVGZtj0I1Gwr64v65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

i386 and s390x implementations of op_add2 require an earlyclobber,
which is currently missing. This breaks VCKSM in s390x guests. E.g., on
x86_64 the following op:

    add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2   dead: 0 2 3 4 5  pref=none,0xffff

is translated to:

    addl     %ebx, %r12d
    adcl     %r12d, %ebx

Introduce a new C_N1_O1_I4 constraint, and make sure that earlyclobber
of aliased outputs is honored.

Cc: qemu-stable@nongnu.org
Fixes: 82790a870992 ("tcg: Add markup for output requires new register")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tcg/i386/tcg-target-con-set.h  | 5 ++++-
 tcg/i386/tcg-target.c.inc      | 2 +-
 tcg/s390x/tcg-target-con-set.h | 8 +++++---
 tcg/s390x/tcg-target.c.inc     | 4 ++--
 tcg/tcg.c                      | 8 +++++++-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 91ceb0e1da2..5ea3a292f0f 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -11,6 +11,9 @@
  *
  * C_N1_Im(...) defines a constraint set with 1 output and <m> inputs,
  * except that the output must use a new register.
+ *
+ * C_Nn_Om_Ik(...) defines a constraint set with <n + m> outputs and <k>
+ * inputs, except that the first <n> outputs must use new registers.
  */
 C_O0_I1(r)
 C_O0_I2(L, L)
@@ -53,4 +56,4 @@ C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
-C_O2_I4(r, r, 0, 1, re, re)
+C_N1_O1_I4(r, r, 0, 1, re, re)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ab997b5fb39..77482da0709 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3335,7 +3335,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, 0, 1, re, re);
+        return C_N1_O1_I4(r, r, 0, 1, re, re);
 
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index cbad91b2b56..9a420374999 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -8,6 +8,9 @@
  * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
  * Each operand should be a sequence of constraint letters as defined by
  * tcg-target-con-str.h; the constraint combination is inclusive or.
+ *
+ * C_Nn_Om_Ik(...) defines a constraint set with <n + m> outputs and <k>
+ * inputs, except that the first <n> outputs must use new registers.
  */
 C_O0_I1(r)
 C_O0_I2(r, r)
@@ -41,6 +44,5 @@ C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
-C_O2_I4(r, r, 0, 1, rA, r)
-C_O2_I4(r, r, 0, 1, ri, r)
-C_O2_I4(r, r, 0, 1, r, r)
+C_N1_O1_I4(r, r, 0, 1, ri, r)
+C_N1_O1_I4(r, r, 0, 1, rA, r)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a878acd8ca6..a94f7908d64 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3229,11 +3229,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, 0, 1, ri, r);
+        return C_N1_O1_I4(r, r, 0, 1, ri, r);
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, 0, 1, rA, r);
+        return C_N1_O1_I4(r, r, 0, 1, rA, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 652e8ea6b93..ddfe9a96cb7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -648,6 +648,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3),
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4),
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
 #include "tcg-target-con-set.h"
@@ -668,6 +669,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Put all of the constraint sets into an array, indexed by the enum. */
 
@@ -687,6 +689,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
 #define C_O2_I3(O1, O2, I1, I2, I3)     { .args_ct_str = { #O1, #O2, #I1, #I2, #I3 } },
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { #O1, #O2, #I1, #I2, #I3, #I4 } },
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { "&" #O1, #O2, #I1, #I2, #I3, #I4 } },
 
 static const TCGTargetOpDef constraint_sets[] = {
 #include "tcg-target-con-set.h"
@@ -706,6 +709,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Expand the enumerator to be returned from tcg_target_op_def(). */
 
@@ -725,6 +729,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3)
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
 #include "tcg-target.c.inc"
 
@@ -4703,7 +4708,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                  * dead after the instruction, we must allocate a new
                  * register and move it.
                  */
-                if (temp_readonly(ts) || !IS_DEAD_ARG(i)) {
+                if (temp_readonly(ts) || !IS_DEAD_ARG(i)
+                    || def->args_ct[arg_ct->alias_index].newreg) {
                     allocate_new_reg = true;
                 } else if (ts->val_type == TEMP_VAL_REG) {
                     /*
-- 
2.41.0


