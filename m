Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AE831365
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNF9-0001ZR-GL; Thu, 18 Jan 2024 02:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNF7-0001X4-7s; Thu, 18 Jan 2024 02:55:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNF5-0007cg-9A; Thu, 18 Jan 2024 02:55:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB9B34503B;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 20B97661A4;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381679 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 17/38] tcg/ppc: Use new registers for LQ destination
Date: Thu, 18 Jan 2024 10:52:44 +0300
Message-Id: <20240118075404.2381519-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

LQ has a constraint that RTp != RA, else SIGILL.
Therefore, force the destination of INDEX_op_qemu_*_ld128 to be a
new register pair, so that it cannot overlap the input address.

This requires new support in process_op_defs and tcg_reg_alloc_op.

Cc: qemu-stable@nongnu.org
Fixes: 526cd4ec01f ("tcg/ppc: Support 128-bit load/store")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240102013456.131846-1-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit ca5bed07d0e7e0530c2cafbc134c4f74e582ac50)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index bbd7b21247..cb47b29452 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -35,7 +35,7 @@ C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
-C_O2_I1(o, m, r)
+C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rI, rZM, r, r)
 C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 856c3b18f5..54816967bc 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2595,6 +2595,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         tcg_debug_assert(!need_bswap);
         tcg_debug_assert(datalo & 1);
         tcg_debug_assert(datahi == datalo - 1);
+        tcg_debug_assert(!is_ld || datahi != index);
         insn = is_ld ? LQ : STQ;
         tcg_out32(s, insn | TAI(datahi, index, 0));
     } else {
@@ -4071,7 +4072,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_qemu_ld_a32_i128:
     case INDEX_op_qemu_ld_a64_i128:
-        return C_O2_I1(o, m, r);
+        return C_N1O1_I1(o, m, r);
     case INDEX_op_qemu_st_a32_i128:
     case INDEX_op_qemu_st_a64_i128:
         return C_O0_I3(o, m, r);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 896a36caeb..e2c38f6d11 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -653,6 +653,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
+#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1),
 #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
@@ -676,6 +677,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N1O1_I1
 #undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
@@ -696,6 +698,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
 
 #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
+#define C_N1O1_I1(O1, O2, I1)           { .args_ct_str = { "&" #O1, #O2, #I1 } },
 #define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
 
 #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
@@ -718,6 +721,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N1O1_I1
 #undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
@@ -738,6 +742,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
+#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1)
 #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
@@ -2988,6 +2993,7 @@ static void process_op_defs(TCGContext *s)
                     .pair = 2,
                     .pair_index = o,
                     .regs = def->args_ct[o].regs << 1,
+                    .newreg = def->args_ct[o].newreg,
                 };
                 def->args_ct[o].pair = 1;
                 def->args_ct[o].pair_index = i;
@@ -3004,6 +3010,7 @@ static void process_op_defs(TCGContext *s)
                     .pair = 1,
                     .pair_index = o,
                     .regs = def->args_ct[o].regs >> 1,
+                    .newreg = def->args_ct[o].newreg,
                 };
                 def->args_ct[o].pair = 2;
                 def->args_ct[o].pair_index = i;
@@ -5036,17 +5043,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                 break;
 
             case 1: /* first of pair */
-                tcg_debug_assert(!arg_ct->newreg);
                 if (arg_ct->oalias) {
                     reg = new_args[arg_ct->alias_index];
-                    break;
+                } else if (arg_ct->newreg) {
+                    reg = tcg_reg_alloc_pair(s, arg_ct->regs,
+                                             i_allocated_regs | o_allocated_regs,
+                                             output_pref(op, k),
+                                             ts->indirect_base);
+                } else {
+                    reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
+                                             output_pref(op, k),
+                                             ts->indirect_base);
                 }
-                reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
-                                         output_pref(op, k), ts->indirect_base);
                 break;
 
             case 2: /* second of pair */
-                tcg_debug_assert(!arg_ct->newreg);
                 if (arg_ct->oalias) {
                     reg = new_args[arg_ct->alias_index];
                 } else {
-- 
2.39.2


