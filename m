Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C1761A68
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINr-0008Sf-KC; Tue, 25 Jul 2023 09:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINo-0008Re-Tp; Tue, 25 Jul 2023 09:47:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOINn-0001ho-3Y; Tue, 25 Jul 2023 09:47:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 99CBD16103;
 Tue, 25 Jul 2023 16:45:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 431F5194C4;
 Tue, 25 Jul 2023 16:45:35 +0300 (MSK)
Received: (nullmailer pid 3370858 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 25/31] tcg/{i386,
 s390x}: Add earlyclobber to the op_add2's first output
Date: Tue, 25 Jul 2023 16:45:10 +0300
Message-Id: <20230725134517.3370706-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

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
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230719221310.1968845-7-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 22d2e5351a18aff5a9c7e3984b50ecce61ff8975)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 91ceb0e1da..5ea3a292f0 100644
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
index 5c7c180799..d00800d18a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3356,7 +3356,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, 0, 1, re, re);
+        return C_N1_O1_I4(r, r, 0, 1, re, re);
 
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 15f1c55103..31daa5daca 100644
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
 C_O0_I2(L, L)
@@ -41,6 +44,5 @@ C_O1_I4(r, r, rA, rI, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
-C_O2_I4(r, r, 0, 1, rA, r)
-C_O2_I4(r, r, 0, 1, ri, r)
-C_O2_I4(r, r, 0, 1, r, r)
+C_N1_O1_I4(r, r, 0, 1, ri, r)
+C_N1_O1_I4(r, r, 0, 1, rA, r)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 844532156b..2e5fd4968c 100644
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
index f3bf471274..09f345fa1b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -368,6 +368,7 @@ void tcg_raise_tb_overflow(TCGContext *s)
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3),
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4),
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
 #include "tcg-target-con-set.h"
@@ -388,6 +389,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Put all of the constraint sets into an array, indexed by the enum. */
 
@@ -407,6 +409,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
 #define C_O2_I3(O1, O2, I1, I2, I3)     { .args_ct_str = { #O1, #O2, #I1, #I2, #I3 } },
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { #O1, #O2, #I1, #I2, #I3, #I4 } },
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) { .args_ct_str = { "&" #O1, #O2, #I1, #I2, #I3, #I4 } },
 
 static const TCGTargetOpDef constraint_sets[] = {
 #include "tcg-target-con-set.h"
@@ -426,6 +429,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O2_I2
 #undef C_O2_I3
 #undef C_O2_I4
+#undef C_N1_O1_I4
 
 /* Expand the enumerator to be returned from tcg_target_op_def(). */
 
@@ -445,6 +449,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)
 #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3)
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
+#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
 #include "tcg-target.c.inc"
 
@@ -4255,7 +4260,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
2.39.2


