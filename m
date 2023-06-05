Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4E723138
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcq-0001we-Vo; Mon, 05 Jun 2023 16:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gci-0001uj-RX
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcf-0003ri-JD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-650c89c7e4fso5357538b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996172; x=1688588172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiNBFteZnKnv2DFn9PJfwp5Vpck7RigEqXHrl2bvYfo=;
 b=WSK3lTP5c6TE9Q9OqIEA5EGgIp99g6z4SN2Pqb3qeSlTK3Dt93X4eNkjbTTZO/ZLXh
 2koFGb9d5eoigmb3ZsXDVVt5xpWvsE+rXJ9Vu676pKXwkE2I7RqjmksOxPGRc9SBTdva
 UGk6xccIIaE8CMC36sJHgxYbqNL4ROygtd9SjqO+RinnGx4TQvnhGOpF5Tror11MYkIO
 kKaRWAmnYDdnZ+FXVO5G7nvzKV6QDF96fRn613OTG/vbFaK0ueS8Sv4EkgOfkOy4d6Nf
 paIu099A2c06MOkAWipcNwZQtSa8MYZV5u70LppmPXCHNeKKm4APqaL/YgmnFzZa0zDB
 EdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996172; x=1688588172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiNBFteZnKnv2DFn9PJfwp5Vpck7RigEqXHrl2bvYfo=;
 b=fov9oLmniCmN0tbYTE+y+XBSQ/pdaBaFTFgjl+C0apQrlwOMdJgsj7kxW6D9DpF0oM
 nlsmG2NZwbtZHAOKbIBnugaPMu8Y173L+b7OYhbCstFBQs3XXn4+ci2Q1jnKor1R6m6g
 ZAQivTyF2nRnS7Afm766jeQNf31AxAXCWpojvwfNBPL1B4O08NdvQ/gQw5QoY6AQdrhr
 aZjJE/2lQcLTSsuLn7nPxHfa4FZpv4o+95q1+Do1vyPLKYYxQL7u885V5CWxkC0qYz45
 bq3Y1OdNTwzM+SY2s7boPtQrao77ISAtNIwE1mAleazWkyyzBEgH8jqjA1fojpmTCKho
 jZOA==
X-Gm-Message-State: AC+VfDyDzmrlbYEdEqTN354YtRFG7W2evTyztbI6rWSz+1LI9YryjuO1
 keneuJLlv0l5qv2j7VEEepdydEYSQ3rg4sxRojk=
X-Google-Smtp-Source: ACHHUZ4qeZ/JEfZHTs4C2IzD+0a9o19e/0wCB0BHrNG1S58D3nooBDpzo+WLTtYXMZbTTpg4Wic9eA==
X-Received: by 2002:a05:6a00:2d83:b0:65b:a187:d433 with SMTP id
 fb3-20020a056a002d8300b0065ba187d433mr757043pfb.6.1685996172604; 
 Mon, 05 Jun 2023 13:16:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 26/52] tcg: Add insn_start_words to TCGContext
Date: Mon,  5 Jun 2023 13:15:22 -0700
Message-Id: <20230605201548.1596865-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
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

This will enable replacement of TARGET_INSN_START_WORDS in tcg.c.
Split out "tcg/insn-start-words.h" and use it in target/.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 17 +++++++++++++++++
 include/tcg/tcg-op.h           |  8 ++++----
 include/tcg/tcg-opc.h          |  6 +++---
 include/tcg/tcg.h              |  9 ++-------
 accel/tcg/perf.c               |  8 ++++++--
 accel/tcg/translate-all.c      | 20 +++++++++++++-------
 target/i386/helper.c           |  2 +-
 target/openrisc/sys_helper.c   |  2 +-
 tcg/tcg.c                      | 16 +++++++++++-----
 9 files changed, 58 insertions(+), 30 deletions(-)
 create mode 100644 include/tcg/insn-start-words.h

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
new file mode 100644
index 0000000000..50c18bd326
--- /dev/null
+++ b/include/tcg/insn-start-words.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define TARGET_INSN_START_WORDS
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TARGET_INSN_START_WORDS
+
+#include "cpu.h"
+
+#ifndef TARGET_INSN_START_EXTRA_WORDS
+# define TARGET_INSN_START_WORDS 1
+#else
+# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
+#endif
+
+#endif /* TARGET_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 47f1dce816..d63683c47b 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -22,20 +22,20 @@
 # error
 #endif
 
-#if TARGET_INSN_START_WORDS == 1
+#ifndef TARGET_INSN_START_EXTRA_WORDS
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
 }
-#elif TARGET_INSN_START_WORDS == 2
+#elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
 }
-#elif TARGET_INSN_START_WORDS == 3
+#elif TARGET_INSN_START_EXTRA_WORDS == 2
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
@@ -45,7 +45,7 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
     tcg_set_insn_start_param(op, 2, a2);
 }
 #else
-# error "Unhandled number of operands to insn_start"
+#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
 #endif
 
 #if TARGET_LONG_BITS == 32
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 21594c1590..acfa5ba753 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -188,9 +188,9 @@ DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
-/* QEMU specific */
-DEF(insn_start, 0, 0, DATA64_ARGS * TARGET_INSN_START_WORDS,
-    TCG_OPF_NOT_PRESENT)
+/* There are tcg_ctx->insn_start_words here, not just one. */
+DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
+
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7c1bbba673..813c733910 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -173,12 +173,6 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_v256             0
 #endif
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
-# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
-
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
 #include "tcg/tcg-opc.h"
@@ -526,6 +520,7 @@ struct TCGContext {
     uint8_t page_bits;
     uint8_t tlb_dyn_max_bits;
 #endif
+    uint8_t insn_start_words;
 
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
@@ -597,7 +592,7 @@ struct TCGContext {
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
-    uint64_t gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
+    uint64_t *gen_insn_data;
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index 65e35ea3b9..f5a1eda39f 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -311,7 +311,8 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
                       const void *start)
 {
     struct debuginfo_query *q;
-    size_t insn;
+    size_t insn, start_words;
+    uint64_t *gen_insn_data;
 
     if (!perfmap && !jitdump) {
         return;
@@ -325,9 +326,12 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
     debuginfo_lock();
 
     /* Query debuginfo for each guest instruction. */
+    gen_insn_data = tcg_ctx->gen_insn_data;
+    start_words = tcg_ctx->insn_start_words;
+
     for (insn = 0; insn < tb->icount; insn++) {
         /* FIXME: This replicates the restore_state_to_opc() logic. */
-        q[insn].address = tcg_ctx->gen_insn_data[insn][0];
+        q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
         } else {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5cea9acd5a..67b838e16b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -64,6 +64,7 @@
 #include "tb-context.h"
 #include "internal.h"
 #include "perf.h"
+#include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
 
@@ -127,22 +128,26 @@ static int64_t decode_sleb128(const uint8_t **pp)
 static int encode_search(TranslationBlock *tb, uint8_t *block)
 {
     uint8_t *highwater = tcg_ctx->code_gen_highwater;
+    uint64_t *insn_data = tcg_ctx->gen_insn_data;
+    uint16_t *insn_end_off = tcg_ctx->gen_insn_end_off;
     uint8_t *p = block;
     int i, j, n;
 
     for (i = 0, n = tb->icount; i < n; ++i) {
-        uint64_t prev;
+        uint64_t prev, curr;
 
         for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
             if (i == 0) {
                 prev = (!(tb_cflags(tb) & CF_PCREL) && j == 0 ? tb->pc : 0);
             } else {
-                prev = tcg_ctx->gen_insn_data[i - 1][j];
+                prev = insn_data[(i - 1) * TARGET_INSN_START_WORDS + j];
             }
-            p = encode_sleb128(p, tcg_ctx->gen_insn_data[i][j] - prev);
+            curr = insn_data[i * TARGET_INSN_START_WORDS + j];
+            p = encode_sleb128(p, curr - prev);
         }
-        prev = (i == 0 ? 0 : tcg_ctx->gen_insn_end_off[i - 1]);
-        p = encode_sleb128(p, tcg_ctx->gen_insn_end_off[i] - prev);
+        prev = (i == 0 ? 0 : insn_end_off[i - 1]);
+        curr = insn_end_off[i];
+        p = encode_sleb128(p, curr - prev);
 
         /* Test for (pending) buffer overflow.  The assumption is that any
            one row beginning below the high water mark cannot overrun
@@ -358,6 +363,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_fast_offset =
         (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
 #endif
+    tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
 
  tb_overflow:
 
@@ -451,7 +457,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             fprintf(logfile, "OUT: [size=%d]\n", gen_code_size);
             fprintf(logfile,
                     "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",
-                    tcg_ctx->gen_insn_data[insn][0]);
+                    tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
             chunk_start = tcg_ctx->gen_insn_end_off[insn];
             disas(logfile, tb->tc.ptr, chunk_start);
 
@@ -464,7 +470,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
                 if (chunk_end > chunk_start) {
                     fprintf(logfile, "  -- guest addr 0x%016" PRIx64 "\n",
-                            tcg_ctx->gen_insn_data[insn][0]);
+                            tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
                     disas(logfile, tb->tc.ptr + chunk_start,
                           chunk_end - chunk_start);
                     chunk_start = chunk_end;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 682d10d98a..36bf2107e7 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -29,7 +29,7 @@
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
-#include "tcg/tcg.h"
+#include "tcg/insn-start-words.h"
 #endif
 
 void cpu_sync_avx_hflag(CPUX86State *env)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 110f157601..782a5751b7 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -26,7 +26,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
-#include "tcg/tcg.h"
+#include "tcg/insn-start-words.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d369367c5a..a339e3e3d8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1501,6 +1501,8 @@ void tcg_func_start(TCGContext *s)
     tcg_debug_assert(s->tlb_fast_offset < 0);
     tcg_debug_assert(s->tlb_fast_offset >= MIN_TLB_MASK_TABLE_OFS);
 #endif
+
+    tcg_debug_assert(s->insn_start_words > 0);
 }
 
 static TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -2445,7 +2447,7 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             nb_oargs = 0;
             col += ne_fprintf(f, "\n ----");
 
-            for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
+            for (i = 0, k = s->insn_start_words; i < k; ++i) {
                 col += ne_fprintf(f, " %016" PRIx64,
                                   tcg_get_insn_start_param(op, i));
             }
@@ -6024,7 +6026,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &s->prof;
 #endif
-    int i, num_insns;
+    int i, start_words, num_insns;
     TCGOp *op;
 
 #ifdef CONFIG_PROFILER
@@ -6147,6 +6149,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->pool_labels = NULL;
 #endif
 
+    start_words = s->insn_start_words;
+    s->gen_insn_data =
+        tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
+
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
@@ -6172,8 +6178,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
                 assert(s->gen_insn_end_off[num_insns] == off);
             }
             num_insns++;
-            for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
-                s->gen_insn_data[num_insns][i] =
+            for (i = 0; i < start_words; ++i) {
+                s->gen_insn_data[num_insns * start_words + i] =
                     tcg_get_insn_start_param(op, i);
             }
             break;
@@ -6219,7 +6225,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             return -2;
         }
     }
-    tcg_debug_assert(num_insns >= 0);
+    tcg_debug_assert(num_insns + 1 == s->gen_tb->icount);
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
 
     /* Generate TB finalization at the end of block */
-- 
2.34.1


