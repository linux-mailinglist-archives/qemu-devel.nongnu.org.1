Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E886A70DE34
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SUZ-0000b8-LT; Tue, 23 May 2023 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSa-0005AO-Q7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSY-00035U-TR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4743978b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850034; x=1687442034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YHMznhDZOucZiZnqaYMteWVjZfl00HdpVCrzNF7XO3s=;
 b=dtFyH/gIehEeHyrlOeqtpR1mvBqucYh9TlLWarcvBzaxE3lln2ips1szipzoYwl3OQ
 KriTdgBU0VepTwo9l0mF1V1gqjtaFNLZeD3zVvJipXpHTeEs3p7RbUdylucJnne0ABTo
 E/dfeZ6hS4n4bqybM5b21x04ttho4STGQbcmjev9bvdPV8ZiS6uJ5agy9oI+kt4qLpgK
 109GtVE0bDQGpXOo4lekMfT9RBZ6S8e7RlQb3GDcZTSKe59Pc9rFNGVOGQZp/CEKZ+OD
 dl1JaxSy3w7Tyy5gDQhe24z8zga6jrjP6uLxW+noc1lKoMHsu0bPksK4TidccR2GwioB
 4aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850034; x=1687442034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHMznhDZOucZiZnqaYMteWVjZfl00HdpVCrzNF7XO3s=;
 b=MP6+1WrRZyhWPS2PQVvXDEZo1sKkqa0zlGJfkhi90aHYAi/PI4zKy/r0S/jnUQt4Ki
 R/eUXK6h/FZvaOHenUBM43acb2hMQ30EOSybR0+Tl7acdJDtLFn1KA0rQ69tolgW1xFG
 K+IG+VzQv8UQndkLdp5DHzf0g8u2mrMxP+Z8MRs5mQM+Y7pAj2gR48dQDUt/+RUSfNv9
 34aGeijKOHJ57LTEP3oxETyi5GnVrBEKKWmTEwlJK9gWUFLVcqQid+wlm5WVLjGYKqZM
 NvljQvFCaHx4dtNAuVC/PbXuPEDDNsaHcsK4xw6bk8tXNVInlQRyvk21X22znn4mAzyo
 B4OA==
X-Gm-Message-State: AC+VfDxmgfL0AKtqPmpT6ZTdB8heZMvUEX+k9/QN+XqnEiKuJ0hhR60m
 dzD/lDvIVPxcOf9Y8PYg5QyrbfgsZfgNpf625hg=
X-Google-Smtp-Source: ACHHUZ4rhit60VNBmxjHaMQ3iTC0l1o1BYEr2XmU9xIGErGX9U53T2qYJbqxGIOQzPSK85zhOrZDuQ==
X-Received: by 2002:aa7:88c5:0:b0:64a:f8c9:a42c with SMTP id
 k5-20020aa788c5000000b0064af8c9a42cmr17937911pff.18.1684850034010; 
 Tue, 23 May 2023 06:53:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 37/52] accel/tcg: Move most of gen-icount.h into
 translator.c
Date: Tue, 23 May 2023 06:53:07 -0700
Message-Id: <20230523135322.678948-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The only usage of gen_tb_start and gen_tb_end are here.
Move the static icount_start_insn variable into a local
within translator_loop.  Simplify the two subroutines
by passing in the existing local cflags variable.

Leave only the declaration of gen_io_start in gen-icount.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h | 79 +------------------------------------
 accel/tcg/translator.c    | 83 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 80 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f6de79a6b4..6006af4c06 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -1,83 +1,6 @@
 #ifndef GEN_ICOUNT_H
 #define GEN_ICOUNT_H
 
-#include "exec/exec-all.h"
-
-/* Helpers for instruction counting code generation.  */
-
-static TCGOp *icount_start_insn;
-
-static inline void gen_io_start(void)
-{
-    tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
-}
-
-static inline void gen_tb_start(const TranslationBlock *tb)
-{
-    TCGv_i32 count = tcg_temp_new_i32();
-
-    tcg_gen_ld_i32(count, cpu_env,
-                   offsetof(ArchCPU, neg.icount_decr.u32) -
-                   offsetof(ArchCPU, env));
-
-    if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        /*
-         * We emit a sub with a dummy immediate argument. Keep the insn index
-         * of the sub so that we later (when we know the actual insn count)
-         * can update the argument with the actual insn count.
-         */
-        tcg_gen_sub_i32(count, count, tcg_constant_i32(0));
-        icount_start_insn = tcg_last_op();
-    }
-
-    /*
-     * Emit the check against icount_decr.u32 to see if we should exit
-     * unless we suppress the check with CF_NOIRQ. If we are using
-     * icount and have suppressed interruption the higher level code
-     * should have ensured we don't run more instructions than the
-     * budget.
-     */
-    if (tb_cflags(tb) & CF_NOIRQ) {
-        tcg_ctx->exitreq_label = NULL;
-    } else {
-        tcg_ctx->exitreq_label = gen_new_label();
-        tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
-    }
-
-    if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, cpu_env,
-                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
-                         offsetof(ArchCPU, env));
-        /*
-         * cpu->can_do_io is cleared automatically here at the beginning of
-         * each translation block.  The cost is minimal and only paid for
-         * -icount, plus it would be very easy to forget doing it in the
-         * translator. Doing it here means we don't need a gen_io_end() to
-         * go with gen_io_start().
-         */
-        tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
-                       offsetof(ArchCPU, env));
-    }
-}
-
-static inline void gen_tb_end(const TranslationBlock *tb, int num_insns)
-{
-    if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        /*
-         * Update the num_insn immediate parameter now that we know
-         * the actual insn count.
-         */
-        tcg_set_insn_param(icount_start_insn, 2,
-                           tcgv_i32_arg(tcg_constant_i32(num_insns)));
-    }
-
-    if (tcg_ctx->exitreq_label) {
-        gen_set_label(tcg_ctx->exitreq_label);
-        tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
-    }
-}
+void gen_io_start(void);
 
 #endif
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 6120ef2a92..b0d0015c70 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,6 +18,84 @@
 #include "exec/plugin-gen.h"
 #include "exec/replay-core.h"
 
+
+void gen_io_start(void)
+{
+    tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
+                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, env));
+}
+
+static TCGOp *gen_tb_start(uint32_t cflags)
+{
+    TCGv_i32 count = tcg_temp_new_i32();
+    TCGOp *icount_start_insn = NULL;
+
+    tcg_gen_ld_i32(count, cpu_env,
+                   offsetof(ArchCPU, neg.icount_decr.u32) -
+                   offsetof(ArchCPU, env));
+
+    if (cflags & CF_USE_ICOUNT) {
+        /*
+         * We emit a sub with a dummy immediate argument. Keep the insn index
+         * of the sub so that we later (when we know the actual insn count)
+         * can update the argument with the actual insn count.
+         */
+        tcg_gen_sub_i32(count, count, tcg_constant_i32(0));
+        icount_start_insn = tcg_last_op();
+    }
+
+    /*
+     * Emit the check against icount_decr.u32 to see if we should exit
+     * unless we suppress the check with CF_NOIRQ. If we are using
+     * icount and have suppressed interruption the higher level code
+     * should have ensured we don't run more instructions than the
+     * budget.
+     */
+    if (cflags & CF_NOIRQ) {
+        tcg_ctx->exitreq_label = NULL;
+    } else {
+        tcg_ctx->exitreq_label = gen_new_label();
+        tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
+    }
+
+    if (cflags & CF_USE_ICOUNT) {
+        tcg_gen_st16_i32(count, cpu_env,
+                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
+                         offsetof(ArchCPU, env));
+        /*
+         * cpu->can_do_io is cleared automatically here at the beginning of
+         * each translation block.  The cost is minimal and only paid for
+         * -icount, plus it would be very easy to forget doing it in the
+         * translator. Doing it here means we don't need a gen_io_end() to
+         * go with gen_io_start().
+         */
+        tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
+                       offsetof(ArchCPU, parent_obj.can_do_io) -
+                       offsetof(ArchCPU, env));
+    }
+
+    return icount_start_insn;
+}
+
+static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
+                       TCGOp *icount_start_insn, int num_insns)
+{
+    if (cflags & CF_USE_ICOUNT) {
+        /*
+         * Update the num_insn immediate parameter now that we know
+         * the actual insn count.
+         */
+        tcg_set_insn_param(icount_start_insn, 2,
+                           tcgv_i32_arg(tcg_constant_i32(num_insns)));
+    }
+
+    if (tcg_ctx->exitreq_label) {
+        gen_set_label(tcg_ctx->exitreq_label);
+        tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
+    }
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
 {
     /* Suppress goto_tb if requested. */
@@ -34,6 +112,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
                      const TranslatorOps *ops, DisasContextBase *db)
 {
     uint32_t cflags = tb_cflags(tb);
+    TCGOp *icount_start_insn;
     bool plugin_enabled;
 
     /* Initialize DisasContext */
@@ -55,7 +134,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     /* Start translating.  */
-    gen_tb_start(db->tb);
+    icount_start_insn = gen_tb_start(cflags);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -112,7 +191,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
-    gen_tb_end(db->tb, db->num_insns);
+    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
     if (plugin_enabled) {
         plugin_gen_tb_end(cpu);
-- 
2.34.1


