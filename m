Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF9AB6C3A
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 15:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBnC-0003ef-Nw; Wed, 14 May 2025 09:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBje-0007hM-Cy; Wed, 14 May 2025 09:01:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBjT-0008Gs-NN; Wed, 14 May 2025 09:01:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82D9A121AFB;
 Wed, 14 May 2025 15:57:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2F6DD20B869;
 Wed, 14 May 2025 15:58:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 29/34] target/i386: do not trigger IRQ shadow for LSS
Date: Wed, 14 May 2025 15:57:51 +0300
Message-Id: <20250514125758.92030-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Because LSS need not trigger an IRQ shadow, gen_movl_seg can't just use
the destination register to decide whether to inhibit IRQs.  Add an
argument.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e54ef98c8a80d16158bab4341d9a898701270528)
(back-ported to 10.0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2a..e7fdec60c5 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -355,7 +355,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         break;
     case X86_OP_SEG:
         /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
-        gen_movl_seg(s, op->n, s->T0);
+        gen_movl_seg(s, op->n, v, op->n == R_SS);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
@@ -2360,7 +2360,7 @@ static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
     gen_op_ld_v(s, MO_16, s->T1, s->A0);
 
     /* load the segment here to handle exceptions properly */
-    gen_movl_seg(s, seg, s->T1);
+    gen_movl_seg(s, seg, s->T1, false);
 }
 
 static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5d729e68c9..77c294d485 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1876,25 +1876,32 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 
 /* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit_irq)
 {
     if (PE(s) && !VM86(s)) {
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
-        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
-        /* abort translation because the addseg value may change or
-           because ss32 may change. For R_SS, translation must always
-           stop as a special handling must be done to disable hardware
-           interrupts for the next instruction */
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        } else if (CODE32(s) && seg_reg < R_FS) {
+        TCGv_i32 sel = tcg_temp_new_i32();
+
+        tcg_gen_trunc_tl_i32(sel, src);
+        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
+
+        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
+        if (CODE32(s) && seg_reg < R_FS) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
         gen_op_movl_seg_real(s, seg_reg, src);
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        }
+    }
+
+    /*
+     * For MOV or POP to SS (but not LSS) translation must always
+     * stop as a special handling must be done to disable hardware
+     * interrupts for the next instruction.
+     *
+     * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
+     * might have been set above.
+     */
+    if (inhibit_irq) {
+        s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
     }
 }
 
-- 
2.39.5


