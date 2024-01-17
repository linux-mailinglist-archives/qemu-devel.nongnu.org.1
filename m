Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECF830A13
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:54:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Eu-0005AR-Ut; Wed, 17 Jan 2024 10:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Er-000513-BM
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Eo-0005uV-89
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705506837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HJFY3PJquz/0Xc0cG6TXdlkZyJldA+TnIjzzCjv69fw=;
 b=dapWBULNOvfLF3A/oDT+p/leGM7jZ7YkL9j2XBIhJJZfVYrVWOoVAdrZWBvNju8KyTYz6l
 5e9iyhRT8ncvIprUgvFyjWVddx99xbm1HKQ7ZqBuLAUsPK5Hs08gjlnt5cNFCB9bnroTO1
 lBFvfbZE1SIAzYIvG7xJCG7bmDW1QlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-hbVWrKqwNwukXLNbYpdLPw-1; Wed, 17 Jan 2024 10:53:53 -0500
X-MC-Unique: hbVWrKqwNwukXLNbYpdLPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05CAC85A589;
 Wed, 17 Jan 2024 15:53:53 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAE8E1BDB1;
 Wed, 17 Jan 2024 15:53:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: pcrel: store low bits of physical address in
 data[0]
Date: Wed, 17 Jan 2024 16:53:49 +0100
Message-ID: <20240117155349.173131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1964
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2012
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/tcg-cpu.c   | 20 ++++++++++++++++----
 target/i386/tcg/translate.c |  1 -
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6e881e9e276..fa956d35ecd 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -68,14 +68,26 @@ static void x86_restore_state_to_opc(CPUState *cs,
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int cc_op = data[1];
+    uint64_t new_pc;
 
     if (tb_cflags(tb) & CF_PCREL) {
-        env->eip = (env->eip & TARGET_PAGE_MASK) | data[0];
-    } else if (tb->flags & HF_CS64_MASK) {
-        env->eip = data[0];
+        /*
+         * To ensure that bits 0..11 do not change across the translation block,
+         * PC-relative TBs use linear addresses, i.e. addresses that have the CS
+         * base added, for data[0].  Add the CS base back before replacing the
+         * low bits, and subtract it below just like for non-PC-relative TBs.
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
index cadf13bce43..e193c74472b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6996,7 +6996,6 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
-        pc_arg -= dc->cs_base;
         pc_arg &= ~TARGET_PAGE_MASK;
     }
     tcg_gen_insn_start(pc_arg, dc->cc_op);
-- 
2.43.0


