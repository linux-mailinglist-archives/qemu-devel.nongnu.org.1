Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD25838992
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:51:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCSe-0001QI-W0; Tue, 23 Jan 2024 03:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSb-0001N2-EK; Tue, 23 Jan 2024 03:48:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSZ-0004uW-D3; Tue, 23 Jan 2024 03:48:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C125F46672;
 Tue, 23 Jan 2024 11:49:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 772E0699F0;
 Tue, 23 Jan 2024 11:48:31 +0300 (MSK)
Received: (nullmailer pid 3828114 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 13/20] target/i386: pcrel: store low bits of physical
 address in data[0]
Date: Tue, 23 Jan 2024 11:48:23 +0300
Message-Id: <20240123084831.3828060-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

For PC-relative translation blocks, env->eip changes during the
execution of a translation block, Therefore, QEMU must be able to
recover an instruction's PC just from the TranslationBlock struct and
the instruction data with.  Because a TB will not span two pages, QEMU
stores all the low bits of EIP in the instruction data and replaces them
in x86_restore_state_to_opc.  Bits 12 and higher (which may vary between
executions of a PCREL TB, since these only use the physical address in
the hash key) are kept unmodified from env->eip.  The assumption is that
these bits of EIP, unlike bits 0-11, will not change as the translation
block executes.

Unfortunately, this is incorrect when the CS base is not aligned to a page.
Then the linear address of the instructions (i.e. the one with the
CS base addred) indeed will never span two pages, but bits 12+ of EIP
can actually change.  For example, if CS base is 0x80262200 and EIP =
0x6FF4, the first instruction in the translation block will be at linear
address 0x802691F4.  Even a very small TB will cross to EIP = 0x7xxx,
while the linear addresses will remain comfortably within a single page.

The fix is simply to use the low bits of the linear address for data[0],
since those don't change.  Then x86_restore_state_to_opc uses tb->cs_base
to compute a temporary linear address (referring to some unknown
instruction in the TB, but with the correct values of bits 12 and higher);
the low bits are replaced with data[0], and EIP is obtained by subtracting
again the CS base.

Huge thanks to Mark Cave-Ayland for the image and initial debugging,
and to Gitlab user @kjliew for help with bisecting another occurrence
of (hopefully!) the same bug.

It should be relatively easy to write a testcase that performs MMIO on
an EIP with different bits 12+ than the first instruction of the translation
block; any help is welcome.

Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL", 2022-10-11)
Cc: qemu-stable@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1759
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1964
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2012
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 729ba8e933f8af5800c3a92b37e630e9bdaa9f1e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup in target/i386/tcg/tcg-cpu.c target/i386/tcg/translate.c for
 v7.2.0-1839-g2e3afe8e19 "target/i386: Replace `TARGET_TB_PCREL` with `CF_PCREL`")

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 563f42ee4e..cd49f86341 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -68,14 +68,26 @@ static void x86_restore_state_to_opc(CPUState *cs,
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int cc_op = data[1];
+    uint64_t new_pc;
 
     if (TARGET_TB_PCREL) {
-        env->eip = (env->eip & TARGET_PAGE_MASK) | data[0];
-    } else if (tb->flags & HF_CS64_MASK) {
-        env->eip = data[0];
+        /*
+         * data[0] in PC-relative TBs is also a linear address, i.e. an address with
+         * the CS base added, because it is not guaranteed that EIP bits 12 and higher
+         * stay the same across the translation block.  Add the CS base back before
+         * replacing the low bits, and subtract it below just like for !CF_PCREL.
+         */
+        uint64_t pc = env->eip + tb->cs_base;
+        new_pc = (pc & TARGET_PAGE_MASK) | data[0];
     } else {
-        env->eip = (uint32_t)(data[0] - tb->cs_base);
+        new_pc = data[0];
     }
+    if (tb->flags & HF_CS64_MASK) {
+        env->eip = new_pc;
+    } else {
+        env->eip = (uint32_t)(new_pc - tb->cs_base);
+    }
+
     if (cc_op != CC_OP_DYNAMIC) {
         env->cc_op = cc_op;
     }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index fc1d79e866..68c42fd9ff 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6983,7 +6983,6 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->prev_insn_end = tcg_last_op();
     if (TARGET_TB_PCREL) {
-        pc_arg -= dc->cs_base;
         pc_arg &= ~TARGET_PAGE_MASK;
     }
     tcg_gen_insn_start(pc_arg, dc->cc_op);
-- 
2.39.2


