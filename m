Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C970624A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC76-0003kM-4E; Wed, 17 May 2023 04:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6p-0002sh-F9; Wed, 17 May 2023 04:02:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6i-0000m6-FT; Wed, 17 May 2023 04:02:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F6FE676B;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0B3685E23;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: (nullmailer pid 3624181 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v8.0.1 34/36] target/s390x: Fix EXECUTE of relative branches
Date: Wed, 17 May 2023 11:00:54 +0300
Message-Id: <20230517080056.3623993-34-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
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

Fix a problem similar to the one fixed by commit 703d03a4aaf3
("target/s390x: Fix EXECUTE of relative long instructions"), but now
for relative branches.

Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230426235813.198183-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e8ecdfeb30f087574191cde523e846e023911c8d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/s390x/tcg/translate.c | 81 ++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2d9b4bbb1f..056594300a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1534,18 +1534,51 @@ static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
     }
 }
 
+/*
+ * Disassemble the target of a branch. The results are returned in a form
+ * suitable for passing into help_branch():
+ *
+ * - bool IS_IMM reflects whether the target is fixed or computed. Non-EXECUTEd
+ *   branches, whose DisasContext *S contains the relative immediate field RI,
+ *   are considered fixed. All the other branches are considered computed.
+ * - int IMM is the value of RI.
+ * - TCGv_i64 CDEST is the address of the computed target.
+ */
+#define disas_jdest(s, ri, is_imm, imm, cdest) do {                            \
+    if (have_field(s, ri)) {                                                   \
+        if (unlikely(s->ex_value)) {                                           \
+            cdest = tcg_temp_new_i64();                                        \
+            tcg_gen_ld_i64(cdest, cpu_env, offsetof(CPUS390XState, ex_target));\
+            tcg_gen_addi_i64(cdest, cdest, (int64_t)get_field(s, ri) * 2);     \
+            is_imm = false;                                                    \
+        } else {                                                               \
+            is_imm = true;                                                     \
+        }                                                                      \
+    } else {                                                                   \
+        is_imm = false;                                                        \
+    }                                                                          \
+    imm = is_imm ? get_field(s, ri) : 0;                                       \
+} while (false)
+
 static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
 {
+    DisasCompare c;
+    bool is_imm;
+    int imm;
+
     pc_to_link_info(o->out, s, s->pc_tmp);
-    return help_goto_direct(s, s->base.pc_next + (int64_t)get_field(s, i2) * 2);
+
+    disas_jdest(s, i2, is_imm, imm, o->in2);
+    disas_jcc(s, &c, 0xf);
+    return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
 static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
 {
     int m1 = get_field(s, m1);
-    bool is_imm = have_field(s, i2);
-    int imm = is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
+    bool is_imm;
+    int imm;
 
     /* BCR with R2 = 0 causes no branching */
     if (have_field(s, r2) && get_field(s, r2) == 0) {
@@ -1562,6 +1595,7 @@ static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
         return DISAS_NEXT;
     }
 
+    disas_jdest(s, i2, is_imm, imm, o->in2);
     disas_jcc(s, &c, m1);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
@@ -1569,10 +1603,10 @@ static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
 static DisasJumpType op_bct32(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, r1);
-    bool is_imm = have_field(s, i2);
-    int imm = is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
+    bool is_imm;
     TCGv_i64 t;
+    int imm;
 
     c.cond = TCG_COND_NE;
     c.is_64 = false;
@@ -1584,6 +1618,7 @@ static DisasJumpType op_bct32(DisasContext *s, DisasOps *o)
     c.u.s32.b = tcg_constant_i32(0);
     tcg_gen_extrl_i64_i32(c.u.s32.a, t);
 
+    disas_jdest(s, i2, is_imm, imm, o->in2);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
@@ -1611,9 +1646,9 @@ static DisasJumpType op_bcth(DisasContext *s, DisasOps *o)
 static DisasJumpType op_bct64(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, r1);
-    bool is_imm = have_field(s, i2);
-    int imm = is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
+    bool is_imm;
+    int imm;
 
     c.cond = TCG_COND_NE;
     c.is_64 = true;
@@ -1622,6 +1657,7 @@ static DisasJumpType op_bct64(DisasContext *s, DisasOps *o)
     c.u.s64.a = regs[r1];
     c.u.s64.b = tcg_constant_i64(0);
 
+    disas_jdest(s, i2, is_imm, imm, o->in2);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
@@ -1629,10 +1665,10 @@ static DisasJumpType op_bx32(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, r1);
     int r3 = get_field(s, r3);
-    bool is_imm = have_field(s, i2);
-    int imm = is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
+    bool is_imm;
     TCGv_i64 t;
+    int imm;
 
     c.cond = (s->insn->data ? TCG_COND_LE : TCG_COND_GT);
     c.is_64 = false;
@@ -1645,6 +1681,7 @@ static DisasJumpType op_bx32(DisasContext *s, DisasOps *o)
     tcg_gen_extrl_i64_i32(c.u.s32.b, regs[r3 | 1]);
     store_reg32_i64(r1, t);
 
+    disas_jdest(s, i2, is_imm, imm, o->in2);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
@@ -1652,9 +1689,9 @@ static DisasJumpType op_bx64(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, r1);
     int r3 = get_field(s, r3);
-    bool is_imm = have_field(s, i2);
-    int imm = is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
+    bool is_imm;
+    int imm;
 
     c.cond = (s->insn->data ? TCG_COND_LE : TCG_COND_GT);
     c.is_64 = true;
@@ -1668,6 +1705,7 @@ static DisasJumpType op_bx64(DisasContext *s, DisasOps *o)
     tcg_gen_add_i64(regs[r1], regs[r1], regs[r3]);
     c.u.s64.a = regs[r1];
 
+    disas_jdest(s, i2, is_imm, imm, o->in2);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
 
@@ -1685,10 +1723,9 @@ static DisasJumpType op_cj(DisasContext *s, DisasOps *o)
     c.u.s64.a = o->in1;
     c.u.s64.b = o->in2;
 
-    is_imm = have_field(s, i4);
-    if (is_imm) {
-        imm = get_field(s, i4);
-    } else {
+    o->out = NULL;
+    disas_jdest(s, i4, is_imm, imm, o->out);
+    if (!is_imm && !o->out) {
         imm = 0;
         o->out = get_address(s, 0, get_field(s, b4),
                              get_field(s, d4));
@@ -5774,15 +5811,13 @@ static void in2_a2(DisasContext *s, DisasOps *o)
 
 static TCGv gen_ri2(DisasContext *s)
 {
-    int64_t delta = (int64_t)get_field(s, i2) * 2;
-    TCGv ri2;
+    TCGv ri2 = NULL;
+    bool is_imm;
+    int imm;
 
-    if (unlikely(s->ex_value)) {
-        ri2 = tcg_temp_new_i64();
-        tcg_gen_ld_i64(ri2, cpu_env, offsetof(CPUS390XState, ex_target));
-        tcg_gen_addi_i64(ri2, ri2, delta);
-    } else {
-        ri2 = tcg_constant_i64(s->base.pc_next + delta);
+    disas_jdest(s, i2, is_imm, imm, ri2);
+    if (is_imm) {
+        ri2 = tcg_constant_i64(s->base.pc_next + imm * 2);
     }
 
     return ri2;
-- 
2.39.2


