Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74B80BD14
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 21:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCQii-000155-3J; Sun, 10 Dec 2023 15:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1rCP4m-0006Zd-16
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 14:02:52 -0500
Received: from azure-sdnproxy.icoremail.net ([20.231.56.155])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1rCP4i-0000Je-G8
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 14:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=uGsVU33a5l
 wWQyu8nh7hiFh/aTsPWbxdH4SE4KgjmQ0=; b=J3Yt8Ope7LWe43B7eePe55faeX
 pdZumZwY68cvg6LzB+kESkfseAZpqIX9JgoS+YaYMmb5t6nrjX0XoKRyBvCnSK75
 kAGcwmSdNcI3WPpEWuRlR3mZK1Y3lRPvbGti9bg6qPQZ3mPEWTUR0A+IK4y7Tpp0
 3RNxkORQzBYEPUMIE=
Received: from localhost.localdomain (unknown [10.7.136.133])
 by front01 (Coremail) with SMTP id 5oFpogC3vChJC3Zl+BahAA--.19814S2;
 Mon, 11 Dec 2023 03:02:36 +0800 (CST)
From: Ruihan Li <lrh2000@pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Date: Mon, 11 Dec 2023 03:01:48 +0800
Message-ID: <20231210190147.129734-2-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogC3vChJC3Zl+BahAA--.19814S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UAr1kur1DKw45trWfGrg_yoW5GrW5pa
 1xuwnFyr4kXFWUGa1xJa1UWFyYyFs5Kr4j9Fn7tw4rKw4rKryFqFn3KFW5Ka45WFWxuFyY
 vr10yFyjvas8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
 jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw2
 0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
 j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK
 6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
 VFxhVjvjDU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBWVt8iwEdQATs9
Received-SPF: pass client-ip=20.231.56.155; envelope-from=lrh2000@pku.edu.cn;
 helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 10 Dec 2023 15:47:54 -0500
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

When emulated with QEMU, interrupts will never come in the following
loop. However, if the NOP instruction is uncommented, interrupts will
fire as normal.

	loop:
		cli
    		call do_sti
		jmp loop

	do_sti:
		sti
		# nop
		ret

This behavior is different from that of a real processor. For example,
if KVM is enabled, interrupts will always fire regardless of whether the
NOP instruction is commented or not. Also, the Intel Software Developer
Manual states that after the STI instruction is executed, the interrupt
inhibit should end as soon as the next instruction (e.g., the RET
instruction if the NOP instruction is commented) is executed.

This problem is caused because the previous code may choose not to end
the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
case where the RET instruction is immediately followed by the STI
instruction), so that IRQs may not have a change to trigger. This commit
fixes the problem by always terminating the current TB to give IRQs a
chance to trigger when HF_INHIBIT_IRQ_MASK is reset.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
The same problem was discovered two years ago, see [StackOverflow][so].

 [so]: https://stackoverflow.com/questions/68135305/executing-ret-after-sti-doesnt-start-interrupts

 target/i386/tcg/translate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 587d886..6b7deb5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2767,13 +2767,19 @@ static void gen_bnd_jmp(DisasContext *s)
 static void
 do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
+    bool inhibit_reset;
+
     gen_update_cc_op(s);
 
     /* If several instructions disable interrupts, only the first does it.  */
     if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
-    } else {
+        inhibit_reset = false;
+    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
+        inhibit_reset = true;
+    } else {
+        inhibit_reset = false;
     }
 
     if (s->base.tb->flags & HF_RF_MASK) {
@@ -2784,7 +2790,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
         tcg_gen_exit_tb(NULL, 0);
     } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
-    } else if (jr) {
+    } else if (jr &&
+               /* give irqs a chance to happen */
+               !inhibit_reset) {
         tcg_gen_lookup_and_goto_ptr();
     } else {
         tcg_gen_exit_tb(NULL, 0);
-- 
2.43.0


