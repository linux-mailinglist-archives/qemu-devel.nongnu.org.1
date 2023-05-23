Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8C70DE66
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SUZ-0000bJ-Md; Tue, 23 May 2023 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSX-00059H-RX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSV-00032E-Rj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso4408125b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850031; x=1687442031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9LPVzQHA3yh4eIvBgA5mt6K1nxPIQ/WmRZegTc9VdCE=;
 b=xg1tsK02u9UXgGbGJIDI+/vLyuohWIMjYueZP8mInFEwNKKACDBYEviLcrALcAxXXB
 3R5sJt7BSm375LsnnWaQ4fgE1EqYX8x95lsfhszVl+LsQUoQNCsbu/AZtFeZYYLNHpuB
 s6x2/VQNGpkdsiR0V6BeRRzVWjddkg8MiMYpIYocpx35xuPR1IRhj9rvG4A6oKf2h6Bv
 NcubDKbtWm/WdkAUeId7TcLsH9MFM2l0ejF/zrzNznkuLBag2UYQdp61EdYDH5MgWlW6
 p4ZkgKmlstuHYvsTVCQ0/ELpMWtbJBSU3wQaz7fP1RNVJReg9kegFBwJEimFM5w/xzvG
 Tl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850031; x=1687442031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LPVzQHA3yh4eIvBgA5mt6K1nxPIQ/WmRZegTc9VdCE=;
 b=WzsSDsIK1So10zCg38EXfip5WSko3x3xhQMyJS/y2DU0X/xSfM/oqSJZZx7QSQsGVW
 ZOs7KsJwn3PB3YCi5muX9Ro1f6QFJah5C318Erzzc1hA13q4uPVVqymZKkFzWozRAVpb
 jyxfYxU08gix9WkoS7Sf4pnzTbyohQTKLrR2QKtkEc+IqEVIIEtzKobkIuoWUcj/HUDJ
 pBgy3lK1bRHA1ZBOnP3cd+AC8YzhWZ9QnWIBP2ogk4QWLlLHIZUoJ3MtGzxQHWcPLiZY
 j7gPCt721FS1SU3tszSXITRrpg6kdQo6RSezmtUOz+QD4B1wh1p9G9nbvS4bvjAq75IO
 qEpQ==
X-Gm-Message-State: AC+VfDw6VPOG7ZI2UoZIsaLNqKtz6NlgmXMnQLO3C9t4FV7ZafO3Kupt
 +AS/QU0QtLEZ+nKCG1Y7QezFQKQh0QwYvJO+zGE=
X-Google-Smtp-Source: ACHHUZ79vbrHKAI6PiUEaMNcvDJoznlkNqiFYBqrW0yYm5BXyuGONF8dwTUEBjn05zpRLoSKuSIVYQ==
X-Received: by 2002:a05:6a20:428a:b0:10b:cdb1:3563 with SMTP id
 o10-20020a056a20428a00b0010bcdb13563mr7046193pzj.46.1684850031004; 
 Tue, 23 May 2023 06:53:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 33/52] tcg: Remove DEBUG_DISAS
Date: Tue, 23 May 2023 06:53:03 -0700
Message-Id: <20230523135322.678948-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
index 58ac1a91c2..a09d754624 100644
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
index 9fe07c31fb..f1eae7b8e5 100644
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
index 347768b979..dd19b3ca78 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -441,7 +441,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     qatomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
-#ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(pc)) {
         FILE *logfile = qemu_log_trylock();
@@ -514,7 +513,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
index 350f88a99f..9d2c7a3337 100644
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
index a3fed5e01b..ebaf376500 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,8 +37,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#define DEBUG_DISAS
-
 #define DYNAMIC_PC  1 /* dynamic pc value */
 #define JUMP_PC     2 /* dynamic pc value which takes only two values
                          according to jump_pc[T2] */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a976e851d5..f7e61e736f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1420,7 +1420,6 @@ void tcg_prologue_init(TCGContext *s)
                         (uintptr_t)s->code_buf, prologue_size);
 #endif
 
-#ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
@@ -1452,7 +1451,6 @@ void tcg_prologue_init(TCGContext *s)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
 #ifndef CONFIG_TCG_INTERPRETER
     /*
@@ -6048,7 +6046,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
-#ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6059,7 +6056,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
@@ -6096,7 +6092,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     liveness_pass_1(s);
 
     if (s->nb_indirects > 0) {
-#ifdef DEBUG_DISAS
         if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
                      && qemu_log_in_addr_range(pc_start))) {
             FILE *logfile = qemu_log_trylock();
@@ -6107,7 +6102,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
                 qemu_log_unlock(logfile);
             }
         }
-#endif
+
         /* Replace indirect temps with direct temps.  */
         if (liveness_pass_2(s)) {
             /* If changes were made, re-run liveness.  */
@@ -6119,7 +6114,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     qatomic_set(&prof->la_time, prof->la_time + profile_getclock());
 #endif
 
-#ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6130,7 +6124,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             qemu_log_unlock(logfile);
         }
     }
-#endif
 
     /* Initialize goto_tb jump offsets. */
     tb->jmp_reset_offset[0] = TB_JMP_OFFSET_INVALID;
-- 
2.34.1


