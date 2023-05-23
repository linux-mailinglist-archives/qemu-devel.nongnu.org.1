Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD570E9DE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btp-0004LF-FO; Tue, 23 May 2023 19:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btl-0004Jc-VK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bte-0001s5-25
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso102479b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886309; x=1687478309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhKJJweUGQGGXYuCAoB5iwT5c/CX9FC0MQLQONjnrYU=;
 b=aNOUorAGv6sHqA6YaonyfhWTkJNWbk2aTFj2gHzV5mQScW2xUyEqxWJjQqD6k/dDMW
 0kX2T/AR4VtGflnCg8r9S/DvDWkzBtaW7dTonmyKLVxup1kyt5mKE5YTfKQoXElSBEYX
 2dymhpTg/VE/lWeyK8QV91xAAgcLkMIPdspYzteizHN5PTwts82C6MocTGl6h/U2lHfX
 5mCf706/AtB35ogxRDG3Tos+Xueu4IGjc0kfULbl7SUY90yFNOU1az/mRxnBCsUr/5f1
 7tXN3S5ecplpZ4wAbN78YDheQnOQHnHgDsd+n6W59W8vU5KKaXhZul08OnR+jGK3QsAu
 7RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886309; x=1687478309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhKJJweUGQGGXYuCAoB5iwT5c/CX9FC0MQLQONjnrYU=;
 b=j4iyOGwlkWh5k+7uSlKXnZ+NlRANXQk3EH3mmB1Bbdwf1toMQfnvrW1chNDRlKnvap
 Wz/ohE4Aixrazjo/IuL14965XBsG4Jn5WUyRNi7tshZikThULnJ3r7jWLeadGERkGkr4
 QF9WBxrr2bthg3HKo89B1Hh6SLOnktHA4uvGd9VQp1gGZWQdpjnyyhyKEc553qHJe5HS
 usEkGOZUkweMfUfX38DvKiw0Fl5qHBVa1+bjxUF64jvEn5SDEjUroZB+tIiMdJiHKkBA
 z2iLlFU/U3u/W3XubLI3TO8rsFUZlW+WDD6zjBoZhLp5D1fZ0aRK7vEgjqQBHBD3U/HC
 pWlQ==
X-Gm-Message-State: AC+VfDyvhKNN1aOdIdh0a87E4mF30cC7bLplY0Qoyo6q9XrRs4Tlo7Aq
 T6JyShmKvWErGN1chb7gLrUy04W3+Ky6e+N+ziM=
X-Google-Smtp-Source: ACHHUZ6oRkCBuKitWtr+YCRSGp9ysmPmLyTTT1bcWHxvfFiGGjF5uN9o16P7Y6dBPoCKqFqFuhFPzg==
X-Received: by 2002:a05:6a00:1ad0:b0:64d:7314:6596 with SMTP id
 f16-20020a056a001ad000b0064d73146596mr872287pfv.27.1684886308748; 
 Tue, 23 May 2023 16:58:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/28] tcg: Remove DEBUG_DISAS
Date: Tue, 23 May 2023 16:58:03 -0700
Message-Id: <20230523235804.747803-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

This had been set since the beginning, is never undefined,
and it would seem to be harmful to debugging to do so.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 3 ---
 accel/tcg/cpu-exec.c      | 2 --
 accel/tcg/translate-all.c | 2 --
 accel/tcg/translator.c    | 2 --
 target/sh4/translate.c    | 2 --
 target/sparc/translate.c  | 2 --
 tcg/tcg.c                 | 9 +--------
 7 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ecded1f112..4d2b151986 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,9 +27,6 @@
 #include "qemu/interval-tree.h"
 #include "qemu/clang-tsa.h"
 
-/* allow to see translation results - the slowdown should be negligible, so we leave it */
-#define DEBUG_DISAS
-
 /* Page tracking code uses ram addresses in system mode, and virtual
    addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
    type.  */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index bc0e1c3299..0e741960da 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -307,7 +307,6 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
 
-#if defined(DEBUG_DISAS)
         if (qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
             FILE *logfile = qemu_log_trylock();
             if (logfile) {
@@ -323,7 +322,6 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
                 qemu_log_unlock(logfile);
             }
         }
-#endif /* DEBUG_DISAS */
     }
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 353849ca6d..c87648b99e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -432,7 +432,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     qatomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
-#ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(pc)) {
         FILE *logfile = qemu_log_trylock();
@@ -505,7 +504,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
     qatomic_set(&tcg_ctx->code_gen_ptr, (void *)
         ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 7bda43ff61..6120ef2a92 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -122,7 +122,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tb->size = db->pc_next - db->pc_first;
     tb->icount = db->num_insns;
 
-#ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
         FILE *logfile = qemu_log_trylock();
@@ -133,7 +132,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             qemu_log_unlock(logfile);
         }
     }
-#endif
 }
 
 static void *translator_access(CPUArchState *env, DisasContextBase *db,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 0dedbb8210..d9accfa1e7 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -17,8 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#define DEBUG_DISAS
-
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "disas/disas.h"
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 414e014b11..9377798490 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -34,8 +34,6 @@
 #include "asi.h"
 
 
-#define DEBUG_DISAS
-
 #define DYNAMIC_PC  1 /* dynamic pc value */
 #define JUMP_PC     2 /* dynamic pc value which takes only two values
                          according to jump_pc[T2] */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0b0fe9c7ad..bfe3d80fc2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1451,7 +1451,6 @@ void tcg_prologue_init(TCGContext *s)
                         (uintptr_t)s->code_buf, prologue_size);
 #endif
 
-#ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
@@ -1483,7 +1482,6 @@ void tcg_prologue_init(TCGContext *s)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
 #ifndef CONFIG_TCG_INTERPRETER
     /*
@@ -5998,7 +5996,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
-#ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6009,7 +6006,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
@@ -6046,7 +6042,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     liveness_pass_1(s);
 
     if (s->nb_indirects > 0) {
-#ifdef DEBUG_DISAS
         if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
                      && qemu_log_in_addr_range(pc_start))) {
             FILE *logfile = qemu_log_trylock();
@@ -6057,7 +6052,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
                 qemu_log_unlock(logfile);
             }
         }
-#endif
+
         /* Replace indirect temps with direct temps.  */
         if (liveness_pass_2(s)) {
             /* If changes were made, re-run liveness.  */
@@ -6069,7 +6064,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     qatomic_set(&prof->la_time, prof->la_time + profile_getclock());
 #endif
 
-#ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6080,7 +6074,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
     /* Initialize goto_tb jump offsets. */
     tb->jmp_reset_offset[0] = TB_JMP_OFFSET_INVALID;
-- 
2.34.1


