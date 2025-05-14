Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64532AB7527
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 21:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHSH-00005S-MC; Wed, 14 May 2025 15:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHN7-0005g1-NB; Wed, 14 May 2025 15:02:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHN2-0007cl-Ca; Wed, 14 May 2025 15:02:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E2899121D9C;
 Wed, 14 May 2025 22:00:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA9E320BA8E;
 Wed, 14 May 2025 22:00:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 18/23] target/i386: do not block singlestep for STI
Date: Wed, 14 May 2025 22:00:30 +0300
Message-Id: <20250514190041.104759-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
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

STI will trigger a singlestep exception even if it has inhibit-IRQ
behavior.  Do not suppress single-step for all IRQ-inhibiting
instructions, instead special case MOV SS and POP SS.

Cc: qemu-stable@nongnu.org
Fixes: f0f0136abba ("target/i386: no single-step exception after MOV or POP SS", 2024-05-25)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1e94ddc6854431064c94a7d8f2f2886def285829)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 390018fdec..50cf56175f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2013,11 +2013,15 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
      * stop as a special handling must be done to disable hardware
      * interrupts for the next instruction.
      *
+     * This is the last instruction, so it's okay to overwrite
+     * HF_TF_MASK; the next TB will start with the flag set.
+     *
      * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
      * might have been set above.
      */
     if (inhibit_irq) {
         s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
+        s->flags &= ~HF_TF_MASK;
     }
 }
 
@@ -2265,7 +2269,7 @@ gen_eob(DisasContext *s, int mode)
     if (mode == DISAS_EOB_RECHECK_TF) {
         gen_helper_rechecking_single_step(tcg_env);
         tcg_gen_exit_tb(NULL, 0);
-    } else if ((s->flags & HF_TF_MASK) && mode != DISAS_EOB_INHIBIT_IRQ) {
+    } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
     } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
-- 
2.39.5


