Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7D757163
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 03:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLZd7-0008Nq-8A; Mon, 17 Jul 2023 21:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLZd4-0008Lj-QP
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 21:35:54 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLZd3-0007ir-3Z
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 21:35:54 -0400
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7659cb9c42aso421838585a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 18:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689644151; x=1692236151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XSC7TRhF4x/D+7CSA6CQbeJFzO7VmEZkfATTpaM1HK8=;
 b=j2YlCk5mUrIDZPVTL7MimXm2UOIGpELn2rubu+hLFrNbcmzyVDOD0mxkAfjOodUDla
 +PwRxgc9Z3GZ9YDN5MoCN0mITcp76Bo5dYPDZVEw2oeKPO5bg4Jd7TazkvEhdOAwwH5W
 GaXHCGP4v6EG20a1oe3oQHQhi1MNiUnPyYZ6uCcegvqkLmkWxHJY3P8gAc9i6m7PsEWI
 zpmHQ4Qs2JgKlIbHPyZH+aqYkANEism2IJHfq6T9M2liyM3bH1bKBO+P7QXs8/n3ogWN
 fkHqig1e6FZt1f3w+h48PXdAoii0ylBiBwYpkxa9TQ1lZKuUZEUfFt1Q/rKRJenrjUVq
 plQg==
X-Gm-Message-State: ABy/qLbz3nvDC3Gl1DFYFS8Vhju8Fj9uSwUBFFLF0IFsM1dyUhlXh+J9
 6b2WZR3crwv8F45mQXl0XAD/i0mvFEXIBUHV
X-Google-Smtp-Source: APBJJlGPp5fmq4O7tAXt6P9o/dF9AM5EmzUBt2JoRpMTW5pTdKpBnOqKFIimYdEy4Tw8bajML7fNig==
X-Received: by 2002:a05:620a:430c:b0:765:7a1e:a456 with SMTP id
 u12-20020a05620a430c00b007657a1ea456mr16703462qko.54.1689644151359; 
 Mon, 17 Jul 2023 18:35:51 -0700 (PDT)
Received: from neon.. (ip68-106-29-136.ph.ph.cox.net. [68.106.29.136])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a17090aad8500b00263b9e75aecsm359956pjq.41.2023.07.17.18.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 18:35:50 -0700 (PDT)
From: Matt Borgerson <contact@mborgerson.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Matt Borgerson <contact@mborgerson.com>
Subject: [PATCH] accel/tcg: Fix guest instruction address in output assembly
 log
Date: Mon, 17 Jul 2023 18:35:31 -0700
Message-Id: <20230718013531.1669100-1-contact@mborgerson.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.222.180; envelope-from=mborgerson@gmail.com;
 helo=mail-qk1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If CF_PCREL is enabled, generated host assembly logging (command line
option `-d out_asm`) may incorrectly report guest instruction virtual
addresses as page offsets instead of absolute addresses. This patch
corrects the reported guest address.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
---
 accel/tcg/translate-all.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a1782db5dd..859db95cf7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -283,6 +283,24 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     return tcg_gen_code(tcg_ctx, tb, pc);
 }
 
+static vaddr get_guest_insn_vaddr(TranslationBlock *tb, vaddr pc, size_t insn)
+{
+    g_assert(insn < tb->icount);
+
+    /* FIXME: This replicates the restore_state_to_opc() logic. */
+    vaddr addr = tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS];
+
+    if (tb_cflags(tb) & CF_PCREL) {
+        addr |= (pc & TARGET_PAGE_MASK);
+    } else {
+#if defined(TARGET_I386)
+        addr -= tb->cs_base;
+#endif
+    }
+
+    return addr;
+}
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
                               vaddr pc, uint64_t cs_base,
@@ -458,7 +476,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             fprintf(logfile, "OUT: [size=%d]\n", gen_code_size);
             fprintf(logfile,
                     "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",
-                    tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                    get_guest_insn_vaddr(tb, pc, insn));
             chunk_start = tcg_ctx->gen_insn_end_off[insn];
             disas(logfile, tb->tc.ptr, chunk_start);
 
@@ -471,7 +489,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
                 if (chunk_end > chunk_start) {
                     fprintf(logfile, "  -- guest addr 0x%016" PRIx64 "\n",
-                            tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                            get_guest_insn_vaddr(tb, pc, insn));
                     disas(logfile, tb->tc.ptr + chunk_start,
                           chunk_end - chunk_start);
                     chunk_start = chunk_end;
-- 
2.34.1


