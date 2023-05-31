Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5D7174C7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D48-0007RI-0w; Wed, 31 May 2023 00:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D45-0007Mc-0p
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D42-0006Hv-VU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so6133833b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505837; x=1688097837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YHMznhDZOucZiZnqaYMteWVjZfl00HdpVCrzNF7XO3s=;
 b=Vm5UWtd/g15asgOZLWQ5+opLxlP0WPtoFvTbPeoSc9WrUSdKKRcMslq8skl/g9qTqz
 +IIrXuscvUXCD0fwKqZrAs+g/TWnqLRuSjWhLSRP0FJHcVPWRTk+KiG8W0xNw8tu6Ppl
 lZVS1ePJ+axC5Y/A4A1ZGWywMpC1hjARwc4DhT+d/z4eW++GcTpGfMUkrx2KnJ1TrSVJ
 2GzRBHSy/LPm5GWaogKrUg9eo3G+aiVWn6+QcoIVnOqTba3GdBxXdyjAY902pUJkT/fx
 dm/AuGWTg1k64o4VAqx3XTdTjdja4of/vqnB6hZVFzoc5rCpM+06xoqaUVTRH0DPU+gc
 GE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505837; x=1688097837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHMznhDZOucZiZnqaYMteWVjZfl00HdpVCrzNF7XO3s=;
 b=AyZciXvbo/E067rv91CsIxCUSGeu5kz/ii1QVW/omXotorWTVMhJcqfDgOE93GHcQb
 feYwIkDgMH1U5xVtwis4TMbhKf+qovWTU4rQomXiaY6gm37y3PAdfc/csstVgXvAna5z
 8BisnnLjKlGURIlJtiGtzOPXcRyVoiAxz6yhe+NUQN7J6wFEudUgMVWXY4EkNFtcK5s2
 nD/txkOUG57oA8qi9oSOVxpGweXegq0hAq0p0CeLolLzOAtnT5rNiWBav54psa7NmsTb
 b+G4S4pXkvk7BZC8PZ42d9nn/jwzzdjPZC5lr4GPm3Z4mLGeTOUYTQNQZ2h51+eFmwXs
 zCAQ==
X-Gm-Message-State: AC+VfDz4rN3zPJJ40melvWeW7wSBufbN4zpVAe126HPeRoPHV5IzSJkW
 hk9y5ntvaktXCPFoxF2VOdXQ7P+c6hQrMOwW2kA=
X-Google-Smtp-Source: ACHHUZ4uhZzt6h4BI0XZXwFhwhN4xoBt7SxyUnduA5EN2+CzHtoLWDQC6Z3zWSt/aWZNkf2CUiRYjQ==
X-Received: by 2002:a05:6a20:6a25:b0:109:2f11:8b77 with SMTP id
 p37-20020a056a206a2500b001092f118b77mr5566369pzk.1.1685505837531; 
 Tue, 30 May 2023 21:03:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 34/48] accel/tcg: Move most of gen-icount.h into
 translator.c
Date: Tue, 30 May 2023 21:03:16 -0700
Message-Id: <20230531040330.8950-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


