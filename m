Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5B72315F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd0-0001zC-IP; Mon, 05 Jun 2023 16:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcr-0001xT-49
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcn-00049m-Bu
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso4829321a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996180; x=1688588180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY0gdY3mFmvqQJx7Z0kC7jESuG/hEwDX/j1iXrJVIOE=;
 b=a+80+gLAt8FIUPG/B+QoPqpv4GbwyJr7kQJfSPPsEh1k2unjaA7AUlrRn5FXicXE+B
 IxXECb4kqr5GFV6vulzwkJrxabUW1DaX5Vek6NmKHbvSnLV1jbQ3bcbWV3tIW03xyHDr
 l8PxaPA0tnCdv9JzMb5d1bWWmpcvQAQB/0+B6r84hamc+wdk1MRW+CF7upTSzuDjesXH
 gXPOH1KYhcVE/G2KiFV2kiPWD+yF9TDqxCe3Cc/sMfwDc4huLsTb+nje/agpN8Uxtrsv
 kYcpE+TR/1pfigkt33lPsABVQtBACCDtpRWOpMHDrbUg0Bo2aq4FwKI8fuMGdwrK3gFt
 /ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996180; x=1688588180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY0gdY3mFmvqQJx7Z0kC7jESuG/hEwDX/j1iXrJVIOE=;
 b=bDCskQD1GUGcHNAArK3RePvrFgJEQO+/mViy+VcU/NtUL8l+VfKPzdqneRyKdmATHX
 nGjmnL4nz95r6EyKAnD72jWv0ckPePdIhmxAVCIZ0mPlGgvK+M8XJ1/ymT3Z3XhQSZGZ
 s2nzl14uUnsl1+IMlSgNfPUTOyW1yQT4vSkStRCkD0R/p3CgTSTbBSlJnIr5oXEZovHb
 s0t/gtIIl+mklERHL9i6xGGTgL7huxoJQCseR1B1oIzn/rn6a5wsFapu8HTIFxAvPK0c
 OrVRVKyywaG3AuJY+4BuIbGoNr7gwy9FkLNnGvo/ntxo4bnqbOjRotJdjLe2tCinH5Bd
 EbXQ==
X-Gm-Message-State: AC+VfDxmmj5YXiUo6E0UCdYH0ZgDc4myO8nmc6uaLLBT4f8f1GGJoqan
 x+A7IGvWXcGyqllD8KBjL0xZxG3jsaWriPX2eQk=
X-Google-Smtp-Source: ACHHUZ5PAPGFhTA/oXbiGn9MsY5kVr828K2nPJL9s6st0gZ39trDiy5SMr9dK+GVgioJD2yaOoklCQ==
X-Received: by 2002:a05:6a20:d90c:b0:114:b89c:f10b with SMTP id
 jd12-20020a056a20d90c00b00114b89cf10bmr111027pzb.31.1685996180003; 
 Mon, 05 Jun 2023 13:16:20 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/52] accel/tcg: Move most of gen-icount.h into translator.c
Date: Mon,  5 Jun 2023 13:15:31 -0700
Message-Id: <20230605201548.1596865-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


