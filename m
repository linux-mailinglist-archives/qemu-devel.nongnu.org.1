Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F4799757
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevDC-0000po-QI; Sat, 09 Sep 2023 06:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevD9-0000fB-Lh; Sat, 09 Sep 2023 06:29:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevD7-0004W1-1f; Sat, 09 Sep 2023 06:29:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E279D204A3;
 Sat,  9 Sep 2023 13:29:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E750F26D01;
 Sat,  9 Sep 2023 13:28:17 +0300 (MSK)
Received: (nullmailer pid 346686 invoked by uid 1000);
 Sat, 09 Sep 2023 10:28:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 16/34] target/i386: raise FERR interrupt with iothread
 locked
Date: Sat,  9 Sep 2023 13:27:09 +0300
Message-Id: <20230909102747.346522-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Otherwise tcg_handle_interrupt() triggers an assertion failure:

  #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
  #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
  #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
  #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
  #9  0x00007fffa42bde14 in code_gen_buffer ()
  #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
Co-developed-by: Richard Henderson <richard.henderson@linaro.org>'
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit c1f27a0c6ae4059a1d809e9c2bc4d47b823c32a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sysemu/fpu_helper.c
index 1c3610da3b..93506cdd94 100644
--- a/target/i386/tcg/sysemu/fpu_helper.c
+++ b/target/i386/tcg/sysemu/fpu_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/irq.h"
 
@@ -31,7 +32,9 @@ void x86_register_ferr_irq(qemu_irq irq)
 void fpu_check_raise_ferr_irq(CPUX86State *env)
 {
     if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
+        qemu_mutex_lock_iothread();
         qemu_irq_raise(ferr_irq);
+        qemu_mutex_unlock_iothread();
         return;
     }
 }
@@ -45,6 +48,9 @@ void cpu_clear_ignne(void)
 void cpu_set_ignne(void)
 {
     CPUX86State *env = &X86_CPU(first_cpu)->env;
+
+    assert(qemu_mutex_iothread_locked());
+
     env->hflags2 |= HF2_IGNNE_MASK;
     /*
      * We get here in response to a write to port F0h.  The chipset should
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f36..e0a622941c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4619,7 +4619,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                 case 0x0a: /* grp d9/2 */
                     switch (rm) {
                     case 0: /* fnop */
-                        /* check exceptions (FreeBSD FPU probe) */
+                        /*
+                         * check exceptions (FreeBSD FPU probe)
+                         * needs to be treated as I/O because of ferr_irq
+                         */
+                        translator_io_start(&s->base);
                         gen_helper_fwait(cpu_env);
                         update_fip = false;
                         break;
@@ -5548,6 +5552,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             (HF_MP_MASK | HF_TS_MASK)) {
             gen_exception(s, EXCP07_PREX);
         } else {
+            /* needs to be treated as I/O because of ferr_irq */
+            translator_io_start(&s->base);
             gen_helper_fwait(cpu_env);
         }
         break;
-- 
2.39.2


