Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B370835D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze81-0003ej-HZ; Thu, 18 May 2023 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7r-0003Lc-PZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:04 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7i-0002Nb-0b
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418213; x=1715954213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/gZ1PedlpAhomQcxVZxkJ2uY5o2S3xnuNgEuP+lHrrE=;
 b=HpbUeReckes9cQ+aK4i4xIXmcybHJXnCH6Eaiqtw4tIpf4e+HTqGGyuw
 JnnCOQXtBe/O7jalyngpEE2nilCziZ0wxAwTFJEGSTuaPZSLukv/Txow+
 5hA8QHpKIIRb3hlkwMWvQxxoALwTN0lREKkJDaCUFskzWSf9WM3++r30q
 4t3i3VQMw37eC3/cYNE4Tl1wwe0rWLd+hQKAjA7McIf/PzETy5QO8oOHL
 q6us8+cGQ4O89kMRDW316GyZsKTGSjU1zvMUOAB3MvcP7UIJ8CJGttYOT
 vyeBsTCaWXcw8TJx9OYl54Gu4D0Fx1pj3aXUicBi2HgnaWS4zhmka6Dmk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685752"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685752"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428831"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428831"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:56:50 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 07/15] accel/tcg: convert profiling of code generation to
 TBStats
Date: Thu, 18 May 2023 21:57:49 +0800
Message-Id: <20230518135757.1442654-8-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518135757.1442654-1-fei2.wu@intel.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

We continue the conversion of CONFIG_PROFILER data to TBStats by
measuring the time it takes to generate code. Instead of calculating
elapsed time as we do we simply store key timestamps in the profiler
structure and then calculate the totals and add them to TBStats under
lock.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/tb-stats.c      | 33 -------------------
 accel/tcg/translate-all.c | 69 ++++++++++++++++++++++-----------------
 include/exec/tb-stats.h   |  7 ++++
 include/tcg/tcg.h         | 14 ++++----
 tcg/tcg.c                 | 17 ++++------
 5 files changed, 59 insertions(+), 81 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 7deb617446..c40c9a748e 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -88,39 +88,6 @@ void dump_jit_profile_info(TCGProfile *s, GString *buf)
                 jpi->host / (double) jpi->translations);
         g_string_append_printf(buf, "avg search data/TB  %0.1f\n",
                 jpi->search_data / (double) jpi->translations);
-
-        if (s) {
-            int64_t tot = s->interm_time + s->code_time;
-            g_string_append_printf(buf, "JIT cycles          %" PRId64
-                    " (%0.3f s at 2.4 GHz)\n",
-                    tot, tot / 2.4e9);
-            g_string_append_printf(buf, "cycles/op           %0.1f\n",
-                    jpi->ops ? (double)tot / jpi->ops : 0);
-            g_string_append_printf(buf, "cycles/in byte      %0.1f\n",
-                    jpi->guest ? (double)tot / jpi->guest : 0);
-            g_string_append_printf(buf, "cycles/out byte     %0.1f\n",
-                    jpi->host ? (double)tot / jpi->host : 0);
-            g_string_append_printf(buf, "cycles/search byte     %0.1f\n",
-                    jpi->search_data ? (double)tot / jpi->search_data : 0);
-            if (tot == 0) {
-                tot = 1;
-            }
-            g_string_append_printf(buf, "  gen_interm time   %0.1f%%\n",
-                    (double)s->interm_time / tot * 100.0);
-            g_string_append_printf(buf, "  gen_code time     %0.1f%%\n",
-                    (double)s->code_time / tot * 100.0);
-            g_string_append_printf(buf, "optim./code time    %0.1f%%\n",
-                    (double)s->opt_time / (s->code_time ? s->code_time : 1)
-                        * 100.0);
-            g_string_append_printf(buf, "liveness/code time  %0.1f%%\n",
-                    (double)s->la_time / (s->code_time ? s->code_time : 1)
-                        * 100.0);
-            g_string_append_printf(buf, "cpu_restore count   %" PRId64 "\n",
-                    s->restore_count);
-            g_string_append_printf(buf, "  avg cycles        %0.1f\n",
-                    s->restore_count ?
-                        (double)s->restore_time / s->restore_count : 0);
-        }
     }
     g_free(jpi);
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index beaef03902..ea2b648ffd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -282,8 +282,9 @@ void page_init(void)
  */
 static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
                            target_ulong pc, void *host_pc,
-                           int *max_insns, int64_t *ti)
+                           int *max_insns)
 {
+    TCGProfile *prof = &tcg_ctx->prof;
     int ret = sigsetjmp(tcg_ctx->jmp_trans, 0);
     if (unlikely(ret != 0)) {
         return ret;
@@ -297,11 +298,9 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     tcg_ctx->cpu = NULL;
     *max_insns = tb->icount;
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&tcg_ctx->prof.interm_time,
-                tcg_ctx->prof.interm_time + profile_getclock() - *ti);
-    *ti = profile_getclock();
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        prof->gen_ir_done_time = profile_getclock();
+    }
 
     return tcg_gen_code(tcg_ctx, tb, pc);
 }
@@ -352,7 +351,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     TCGProfile *prof = &tcg_ctx->prof;
-    int64_t ti;
     void *host_pc;
 
     assert_memory_lock();
@@ -403,10 +401,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
  tb_overflow:
 
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
-
     trace_translate_block(tb, pc, tb->tc.ptr);
 
     /*
@@ -418,11 +412,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (tb_stats_collection_enabled() &&
         qemu_log_in_addr_range(tb->pc)) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+        if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+            prof->gen_start_time = profile_getclock();
+        }
     } else {
         tb->tb_stats = NULL;
     }
 
-    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
+    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
         case -1:
@@ -474,9 +471,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     perf_report_code(pc, tb, tcg_splitwx_to_rx(gen_code_buf));
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        prof->gen_code_done_time = profile_getclock();
+    }
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
@@ -586,26 +583,38 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * Collect JIT stats when enabled. We batch them all up here to
      * avoid spamming the cache with atomic accesses
      */
-    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+    if (tb_stats_enabled(tb, (TB_JIT_STATS | TB_JIT_TIME))) {
         TBStatistics *ts = tb->tb_stats;
         qemu_mutex_lock(&ts->jit_stats_lock);
 
-        ts->code.num_guest_inst += prof->translation.nb_guest_insns;
-        ts->code.num_tcg_ops += prof->translation.nb_ops_pre_opt;
-        ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
-        ts->code.spills += prof->translation.nb_spills;
-        ts->code.temps += prof->translation.temp_count;
-        ts->code.deleted_ops += prof->translation.del_op_count;
-        ts->code.in_len += tb->size;
-        ts->code.out_len += tb->tc.size;
-        ts->code.search_out_len += search_size;
-
-        ts->translations.total++;
-        if (tb_page_addr1(tb) != -1) {
-            ts->translations.spanning++;
+        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+            ts->code.num_guest_inst += prof->translation.nb_guest_insns;
+            ts->code.num_tcg_ops += prof->translation.nb_ops_pre_opt;
+            ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
+            ts->code.spills += prof->translation.nb_spills;
+            ts->code.temps += prof->translation.temp_count;
+            ts->code.deleted_ops += prof->translation.del_op_count;
+            ts->code.in_len += tb->size;
+            ts->code.out_len += tb->tc.size;
+            ts->code.search_out_len += search_size;
+
+            ts->translations.total++;
+            if (tb_page_addr1(tb) != -1) {
+                ts->translations.spanning++;
+            }
+
+            g_ptr_array_add(ts->tbs, tb);
         }
 
-        g_ptr_array_add(ts->tbs, tb);
+        if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+            ts->gen_times.ir += prof->gen_ir_done_time - prof->gen_start_time;
+            ts->gen_times.ir_opt +=
+                prof->gen_opt_done_time - prof->gen_ir_done_time;
+            ts->gen_times.la +=
+                prof->gen_la_done_time - prof->gen_opt_done_time;
+            ts->gen_times.code +=
+                prof->gen_code_done_time - prof->gen_la_done_time;
+        }
 
         qemu_mutex_unlock(&ts->jit_stats_lock);
     }
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index cc9ab686b8..2543367c70 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -97,6 +97,12 @@ struct TBStatistics {
     uint64_t tb_restore_time;
     uint64_t tb_restore_count;
 
+    struct {
+        uint64_t ir;
+        uint64_t ir_opt;
+        uint64_t la;
+        uint64_t code;
+    } gen_times;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
@@ -104,5 +110,6 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 void init_tb_stats_htable(void);
 
 void dump_jit_profile_info(TCGProfile *s, GString *buf);
+void dump_jit_exec_time_info(uint64_t dev_time);
 
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 69df21ce4c..9b74c5acce 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -557,13 +557,13 @@ typedef struct TCGProfile {
     int64_t code_in_len;
     int64_t code_out_len;
     int64_t search_out_len;
-    int64_t interm_time;
-    int64_t code_time;
-    int64_t la_time;
-    int64_t opt_time;
-    int64_t restore_count;
-    int64_t restore_time;
-    int64_t table_op_count[NB_OPS];
+
+    /* Timestamps during translation  */
+    uint64_t gen_start_time;
+    uint64_t gen_ir_done_time;
+    uint64_t gen_opt_done_time;
+    uint64_t gen_la_done_time;
+    uint64_t gen_code_done_time;
 } TCGProfile;
 
 struct TCGContext {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a3a42ef387..9e657719fa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -6005,18 +6005,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
-#endif
-
 #ifdef USE_TCG_OPTIMIZATIONS
     tcg_optimize(s);
 #endif
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
-    qatomic_set(&prof->la_time, prof->la_time - profile_getclock());
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        prof->gen_opt_done_time = profile_getclock();
+    }
 
     reachable_code_pass(s);
     liveness_pass_0(s);
@@ -6042,9 +6037,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         }
     }
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->la_time, prof->la_time + profile_getclock());
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        prof->gen_la_done_time = profile_getclock();
+    }
 
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
-- 
2.25.1


