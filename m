Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC558831921
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS1-0003oK-VT; Thu, 18 Jan 2024 07:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRu-0003Wb-SL
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRt-0006Mv-2A
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Eq3T2KCwKLxa+Xmtmtqemqra8k7zrccF6GSVgdJGXI=;
 b=JF0dDk9X6SBQCLGaLEDCeaelh/+GV8ct1ZF3jv6jsqO11L/csp5N1Vu2+aSNSlcpyKBAkH
 hByjl+R6RAZ3Z9Vy8J1OAkUAwQQNEVgaLdeSbTNy/WVM5yX2bG9LEpLn8N9rVOu6DO4XzX
 K6fPCpHtoe0IwoTQQmsVWML+fJYIuYU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Lxn8m6QRPaGKdAOTN3yaFw-1; Thu, 18 Jan 2024 07:24:43 -0500
X-MC-Unique: Lxn8m6QRPaGKdAOTN3yaFw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-558b04cb660so3692577a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580681; x=1706185481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Eq3T2KCwKLxa+Xmtmtqemqra8k7zrccF6GSVgdJGXI=;
 b=TrbDQa2md7KB+O1pTQmD3o3vsEFL2hZTOWqK2X6dDXi8lSV5NTBli6eNX0aQMxrQFH
 NvmbVY93/MwI2l1FhmgCL75fM8wz9euJTe+Ypm3hcp+l6tepuQp9Yjc2AQb4Kn+erDim
 XVztidDNjDqHE5xaVb+4YNm88cxPaG2wT2HNGgwChomuu4ZKmcG8vlqhgU1ONOiYlQT1
 UvK5fUeAUj7hc19gD8fzj8tOlUrcgCY9ikdmZTdgr0AW4htOmv02HgmViciMD+dXD9Eg
 Lyfvmx5N+PKyHeu7vG7e6d23kQcAyiQR2OkTfIxGur0I7yeqr+ICzm3XS4qD1JAjtLBL
 J2lA==
X-Gm-Message-State: AOJu0Yxo4BpENWObnahfhT6ULkwQ0hmYfagX3Maq+xuHo1sUxizyrazK
 aomWWF7Zi/fsDNGAyN6BSkUyH32jAjSISBQvopxg0MsVCOTTKpp3zT0aj6vx2/3WKeDd7dHiw70
 jpwbfFc3yruRbelJL4ZC3oXj55GaqfaanIuOXNN1dHXHDcnIv2er6d1J0oF8Z2fjwQ7Pj7AVYiA
 ahIOkbwEYe1Aw663v8U0xNWjaxIpdf+xQnMoyp
X-Received: by 2002:a17:906:3bca:b0:a26:c83d:e086 with SMTP id
 v10-20020a1709063bca00b00a26c83de086mr403641ejf.103.1705580681306; 
 Thu, 18 Jan 2024 04:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAYUjmVnRPiCWYlEtYFqK8Ms59knADhjJIQe8rQA0b4h9DkIZfFuXiTPR+JjPd88inL1rvoA==
X-Received: by 2002:a17:906:3bca:b0:a26:c83d:e086 with SMTP id
 v10-20020a1709063bca00b00a26c83de086mr403629ejf.103.1705580680929; 
 Thu, 18 Jan 2024 04:24:40 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a1709067c1300b00a2ca9d38654sm8124997ejo.85.2024.01.18.04.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/16] target/i386: pcrel: store low bits of physical address
 in data[0]
Date: Thu, 18 Jan 2024 13:24:13 +0100
Message-ID: <20240118122416.9209-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1759
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1964
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2012
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/tcg-cpu.c   | 20 ++++++++++++++++----
 target/i386/tcg/translate.c |  1 -
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6e881e9e276..1d54164bdfa 100644
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


