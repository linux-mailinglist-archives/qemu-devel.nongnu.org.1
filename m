Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC67158A3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3umu-0001Oo-Qe; Tue, 30 May 2023 04:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3ums-0001OS-Bk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:02 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3umo-00013Q-SN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685435578; x=1716971578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+V9+tRHz+TEmcQg+Afy+Dm6RP3CVKrQilwjxCBw1avU=;
 b=js2NkFspyaDITVRU8woABb6rRONV33WtLfA/H4/wFH9CmlYzf9xvNG1a
 93tncpNBSlzJIX+d1Ju0DOfjDVFt/50dKPwsg3lvjlSWRkR30yvJtvJLC
 RAnJBMr4hfF4SPnXq5TyjJkbcTy7vFoIDdZlpolYkSqwI/paWxUEUQARV
 Bu3SO4c0fk0jYFSGjPOUSab6fjbSnL3alxwyVkkCDTg9LyIIqEXiCXYBA
 iK+RtlVEC8Ivikf5/pBfG++fBdcqxmp+u5e+ks1+Q6u3eOsuCtmh+QPdR
 aMmmn8mcYkhuVKYatttujZv8lB1oKRYfPNb4Ak/KQ0Y7EKBp9ERaLdEbr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335202101"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="335202101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 01:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="796188244"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="796188244"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 01:32:54 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v14 04/10] accel/tcg: add jit stats and time to TBStatistics
Date: Tue, 30 May 2023 16:35:20 +0800
Message-Id: <20230530083526.2174430-5-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530083526.2174430-1-fei2.wu@intel.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=fei2.wu@intel.com;
 helo=mga17.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This collects all the statistics for TBStatistics, not only for the
whole emulation but for each TB.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/monitor.c           |  20 ++++-
 accel/tcg/tb-stats.c          | 146 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-accel-ops.c     |   7 ++
 accel/tcg/translate-all.c     |  70 +++++++++++++++-
 accel/tcg/translator.c        |   7 +-
 include/exec/tb-stats-flags.h |   2 +
 include/exec/tb-stats.h       |  46 +++++++++++
 include/qemu/timer.h          |   6 ++
 include/tcg/tcg.h             |  28 ++++++-
 softmmu/runstate.c            |   9 +++
 tcg/tcg.c                     |  88 ++++++++++++++++++--
 tests/qtest/qmp-cmd-test.c    |   3 +
 12 files changed, 417 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index e903dd1d2e..2bc87f2642 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -15,6 +15,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
+#include "exec/tb-stats.h"
 #include "internal.h"
 
 
@@ -69,6 +70,11 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
+    if (!tb_stats_collection_enabled()) {
+        error_setg(errp, "TB information not being recorded.");
+        return NULL;
+    }
+
     if (!tcg_enabled()) {
         error_setg(errp,
                    "Opcode count information is only available with accel=tcg");
@@ -80,11 +86,23 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+#ifdef CONFIG_TCG
+HumanReadableText *qmp_x_query_profile(Error **errp)
+{
+    g_autoptr(GString) buf = g_string_new("");
+
+    dump_jit_exec_time_info(dev_time, buf);
+    dev_time = 0;
+
+    return human_readable_text_from_str(buf);
+}
+#else
 HumanReadableText *qmp_x_query_profile(Error **errp)
 {
-    error_setg(errp, "Internal profiler not compiled");
+    error_setg(errp, "TCG should be enabled!");
     return NULL;
 }
+#endif
 
 static void hmp_tcg_register(void)
 {
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 143a52ef5c..78a3104c7f 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -9,6 +9,11 @@
 #include "qemu/osdep.h"
 
 #include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg/tcg.h"
+
+#include "qemu/qemu-print.h"
+#include "qemu/timer.h"
 
 #include "exec/tb-stats.h"
 #include "tb-context.h"
@@ -24,6 +29,147 @@ enum TBStatsStatus {
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
 
+uint64_t dev_time;
+
+struct jit_profile_info {
+    uint64_t translations;
+    uint64_t aborted;
+    uint64_t ops;
+    unsigned ops_max;
+    uint64_t del_ops;
+    uint64_t temps;
+    unsigned temps_max;
+    uint64_t host;
+    uint64_t guest;
+    uint64_t search_data;
+
+    uint64_t interm_time;
+    uint64_t code_time;
+    uint64_t restore_count;
+    uint64_t restore_time;
+    uint64_t opt_time;
+    uint64_t la_time;
+};
+
+/* accumulate the statistics from all TBs */
+static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
+{
+    struct jit_profile_info *jpi = userp;
+    TBStatistics *tbs = p;
+
+    jpi->translations += tbs->translations.total;
+    jpi->ops += tbs->code.num_tcg_ops;
+    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
+        jpi->ops_max = stat_per_translation(tbs, code.num_tcg_ops);
+    }
+    jpi->del_ops += tbs->code.deleted_ops;
+    jpi->temps += tbs->code.temps;
+    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
+        jpi->temps_max = stat_per_translation(tbs, code.temps);
+    }
+    jpi->host += tbs->code.out_len;
+    jpi->guest += tbs->code.in_len;
+    jpi->search_data += tbs->code.search_out_len;
+
+    jpi->interm_time += stat_per_translation(tbs, gen_times.ir);
+    jpi->opt_time += stat_per_translation(tbs, gen_times.ir_opt);
+    jpi->la_time += stat_per_translation(tbs, gen_times.la);
+    jpi->code_time += stat_per_translation(tbs, gen_times.code);
+
+    /*
+     * The restore time covers how long we have spent restoring state
+     * from a given TB (e.g. recovering from a fault). It is therefor
+     * not related to the number of translations we have done.
+     */
+    jpi->restore_time += tbs->tb_restore_time;
+    jpi->restore_count += tbs->tb_restore_count;
+}
+
+void dump_jit_exec_time_info(uint64_t dev_time, GString *buf)
+{
+    static uint64_t last_cpu_exec_time;
+    uint64_t cpu_exec_time;
+    uint64_t delta;
+
+    cpu_exec_time = tcg_cpu_exec_time();
+    delta = cpu_exec_time - last_cpu_exec_time;
+
+    g_string_append_printf(buf, "async time  %" PRId64 " (%0.3f)\n",
+                           dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
+    g_string_append_printf(buf, "qemu time   %" PRId64 " (%0.3f)\n",
+                           delta, delta / (double)NANOSECONDS_PER_SECOND);
+    last_cpu_exec_time = cpu_exec_time;
+}
+
+/* dump JIT statisticis using TCGProfile and TBStats */
+void dump_jit_profile_info(TCGProfile *s, GString *buf)
+{
+    if (!tb_stats_collection_enabled()) {
+        return;
+    }
+
+    struct jit_profile_info *jpi = g_new0(struct jit_profile_info, 1);
+
+    qht_iter(&tb_ctx.tb_stats, collect_jit_profile_info, jpi);
+
+    if (jpi->translations) {
+        g_string_append_printf(buf, "translated TBs      %" PRId64 "\n",
+                jpi->translations);
+        g_string_append_printf(buf, "avg ops/TB          %0.1f max=%d\n",
+                jpi->ops / (double) jpi->translations, jpi->ops_max);
+        g_string_append_printf(buf, "deleted ops/TB      %0.2f\n",
+                jpi->del_ops / (double) jpi->translations);
+        g_string_append_printf(buf, "avg temps/TB        %0.2f max=%d\n",
+                jpi->temps / (double) jpi->translations, jpi->temps_max);
+        g_string_append_printf(buf, "avg host code/TB    %0.1f\n",
+                jpi->host / (double) jpi->translations);
+        g_string_append_printf(buf, "avg search data/TB  %0.1f\n",
+                jpi->search_data / (double) jpi->translations);
+
+        uint64_t tot = jpi->interm_time + jpi->code_time;
+
+        g_string_append_printf(buf, "JIT cycles          %" PRId64
+                " (%0.3fs at 2.4 GHz)\n",
+                tot, tot / 2.4e9);
+        g_string_append_printf(buf, "  cycles/op           %0.1f\n",
+                jpi->ops ? (double)tot / jpi->ops : 0);
+        g_string_append_printf(buf, "  cycles/in byte      %0.1f\n",
+                jpi->guest ? (double)tot / jpi->guest : 0);
+        g_string_append_printf(buf, "  cycles/out byte     %0.1f\n",
+                jpi->host ? (double)tot / jpi->host : 0);
+        g_string_append_printf(buf, "  cycles/search byte  %0.1f\n",
+                jpi->search_data ? (double)tot / jpi->search_data : 0);
+        if (tot == 0) {
+            tot = 1;
+        }
+
+        g_string_append_printf(buf, "  gen_interm time     %0.1f%%\n",
+                (double)jpi->interm_time / tot * 100.0);
+        g_string_append_printf(buf, "  gen_code time       %0.1f%%\n",
+                (double)jpi->code_time / tot * 100.0);
+
+        g_string_append_printf(buf, "    optim./code time    %0.1f%%\n",
+                (double)jpi->opt_time / (jpi->code_time ? jpi->code_time : 1)
+                    * 100.0);
+        g_string_append_printf(buf, "    liveness/code time  %0.1f%%\n",
+                (double)jpi->la_time / (jpi->code_time ? jpi->code_time : 1)
+                    * 100.0);
+
+        g_string_append_printf(buf, "cpu_restore count   %" PRId64 "\n",
+                jpi->restore_count);
+        g_string_append_printf(buf, "  avg cycles        %0.1f\n",
+                jpi->restore_count ?
+                    (double)jpi->restore_time / jpi->restore_count : 0);
+
+        if (s) {
+            g_string_append_printf(buf, "cpu exec time  %" PRId64 " (%0.3fs)\n",
+                s->cpu_exec_time,
+                s->cpu_exec_time / (double) NANOSECONDS_PER_SECOND);
+        }
+    }
+    g_free(jpi);
+}
+
 void init_tb_stats_htable(void)
 {
     if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3973591508..749ad182f2 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -70,10 +70,17 @@ void tcg_cpus_destroy(CPUState *cpu)
 int tcg_cpus_exec(CPUState *cpu)
 {
     int ret;
+    uint64_t ti;
+
     assert(tcg_enabled());
+    ti = profile_getclock();
+
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+
+    qatomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
+
     return ret;
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index dadf49954f..8733aec11b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -204,6 +204,12 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
     uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t ti = 0;
+
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        ti = get_clock();
+    }
+
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -220,6 +226,15 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
+
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        TBStatistics *ts = tb->tb_stats;
+        uint64_t elapsed = get_clock() - ti;
+        qemu_mutex_lock(&ts->jit_stats_lock);
+        ts->tb_restore_time += elapsed;
+        ts->tb_restore_count++;
+        qemu_mutex_unlock(&ts->jit_stats_lock);
+    }
 }
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
@@ -267,7 +282,7 @@ void page_init(void)
  */
 static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
                            target_ulong pc, void *host_pc,
-                           int *max_insns, int64_t *ti)
+                           int *max_insns, TCGTime *tcg_time)
 {
     int ret = sigsetjmp(tcg_ctx->jmp_trans, 0);
     if (unlikely(ret != 0)) {
@@ -282,7 +297,11 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     tcg_ctx->cpu = NULL;
     *max_insns = tb->icount;
 
-    return tcg_gen_code(tcg_ctx, tb, pc);
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        tcg_time->ir_done = get_clock();
+    }
+
+    return tcg_gen_code(tcg_ctx, tb, pc, tcg_time);
 }
 
 static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
@@ -296,6 +315,8 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
     new_stats->cs_base = cs_base;
     new_stats->flags = flags;
     new_stats->stats_enabled = get_default_tbstats_flag();
+    new_stats->tbs = g_ptr_array_sized_new(4);
+    qemu_mutex_init(&new_stats->jit_stats_lock);
 
     /*
      * All initialisation must be complete before we insert into qht
@@ -309,6 +330,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
          * If there is already a TBStatistic for this TB from a previous flush
          * then just make the new TB point to the older TBStatistic
          */
+        g_ptr_array_free(new_stats->tbs, true);
         g_free(new_stats);
         return existing_stats;
     } else {
@@ -327,8 +349,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
-    int64_t ti;
     void *host_pc;
+    TCGTime tcg_time;
 
     assert_memory_lock();
     qemu_thread_jit_write();
@@ -389,11 +411,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (tb_stats_collection_enabled() &&
         qemu_log_in_addr_range(tb->pc)) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+        if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+            tcg_time.start = get_clock();
+        }
     } else {
         tb->tb_stats = NULL;
     }
 
-    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
+    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns,
+                                    &tcg_time);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
         case -1:
@@ -445,6 +471,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     perf_report_code(pc, tb, tcg_splitwx_to_rx(gen_code_buf));
 
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        tcg_time.code_done = get_clock();
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(pc)) {
         FILE *logfile = qemu_log_trylock();
@@ -547,6 +577,38 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         return tb;
     }
 
+    /*
+     * Collect JIT stats when enabled. We batch them all up here to
+     * avoid spamming the cache with atomic accesses
+     */
+    if (tb_stats_enabled(tb, (TB_JIT_STATS | TB_JIT_TIME))) {
+        TBStatistics *ts = tb->tb_stats;
+        qemu_mutex_lock(&ts->jit_stats_lock);
+
+        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+            ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
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
+        }
+
+        if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+            ts->gen_times.ir += tcg_time.ir_done - tcg_time.start;
+            ts->gen_times.ir_opt += tcg_time.opt_done - tcg_time.ir_done;
+            ts->gen_times.la += tcg_time.la_done - tcg_time.opt_done;
+            ts->gen_times.code += tcg_time.code_done - tcg_time.la_done;
+        }
+
+        qemu_mutex_unlock(&ts->jit_stats_lock);
+    }
+
     /*
      * Insert TB into the corresponding region tree before publishing it
      * through QHT. Otherwise rewinding happened in the TB might fail to
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 80ffbfb455..a60a92091b 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -19,7 +19,7 @@
 #include "exec/plugin-gen.h"
 #include "exec/replay-core.h"
 
-static void gen_tb_exec_count(TranslationBlock *tb)
+static inline void gen_tb_exec_count(TranslationBlock *tb)
 {
     if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
         TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
@@ -147,6 +147,11 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tb->size = db->pc_next - db->pc_first;
     tb->icount = db->num_insns;
 
+    /* Save number of guest instructions for TB_JIT_STATS */
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        tb->tb_stats->code.num_guest_inst += db->num_insns;
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
         FILE *logfile = qemu_log_trylock();
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index fa71eb6f0c..f29eff7576 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -13,6 +13,8 @@
 
 #define TB_NOTHING    (1 << 0)
 #define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
+#define TB_JIT_TIME   (1 << 3)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index eb1fa92a4e..d93d42e085 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -34,6 +34,9 @@
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
+#define stat_per_translation(stat, name) \
+    (stat->translations.total ? stat->name / stat->translations.total : 0)
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -60,10 +63,53 @@ struct TBStatistics {
         unsigned long atomic;
     } executions;
 
+    /* JIT Stats - protected by lock */
+    QemuMutex jit_stats_lock;
+
+    /* Sum of all operations for all translations */
+    struct {
+        unsigned num_guest_inst;
+        unsigned num_tcg_ops;
+        unsigned num_tcg_ops_opt;
+        unsigned spills;
+
+        /* CONFIG_PROFILE */
+        unsigned temps;
+        unsigned deleted_ops;
+        unsigned in_len;
+        unsigned out_len;
+        unsigned search_out_len;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long uncached;
+        unsigned long spanning;
+    } translations;
+
+    /*
+     * All persistent (cached) TranslationBlocks using
+     * this TBStats structure. Has to be reset on a tb_flush.
+     */
+    GPtrArray *tbs;
+
+    /* Recover state from TB */
+    uint64_t tb_restore_time;
+    uint64_t tb_restore_count;
+
+    struct {
+        uint64_t ir;
+        uint64_t ir_opt;
+        uint64_t la;
+        uint64_t code;
+    } gen_times;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
 void init_tb_stats_htable(void);
 
+void dump_jit_profile_info(TCGProfile *s, GString *buf);
+void dump_jit_exec_time_info(uint64_t dev_time, GString *buf);
+
 #endif
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a91cb1248..ad0da18a5f 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -989,4 +989,10 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 #endif
 
+static inline int64_t profile_getclock(void)
+{
+    return get_clock();
+}
+
+extern uint64_t dev_time;
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 083cbd6580..85bf6fb78e 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -522,6 +522,26 @@ static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
     return i < ARRAY_SIZE(op->output_pref) ? op->output_pref[i] : 0;
 }
 
+/* Timestamps during translation  */
+typedef struct TCGTime {
+    uint64_t start;
+    uint64_t ir_done;
+    uint64_t opt_done;
+    uint64_t la_done;
+    uint64_t code_done;
+} TCGTime;
+
+/*
+ * The TCGProfile structure holds data for the lifetime of the translator.
+ */
+typedef struct TCGProfile {
+    /* exec time of this vcpu */
+    int64_t cpu_exec_time;
+
+    /* Lifetime count of TCGOps per TCGContext when tb_stats enabled */
+    size_t table_op_count[NB_OPS];
+} TCGProfile;
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -548,6 +568,8 @@ struct TCGContext {
     tcg_insn_unit *code_buf;      /* pointer for start of tb */
     tcg_insn_unit *code_ptr;      /* pointer for running end of tb */
 
+    TCGProfile prof;
+
 #ifdef CONFIG_DEBUG_TCG
     int goto_tb_issue_mask;
     const TCGOpcode *vecop_list;
@@ -608,6 +630,7 @@ struct TCGContext {
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
+    TranslationBlock *current_tb;
 };
 
 static inline bool temp_readonly(TCGTemp *ts)
@@ -827,7 +850,8 @@ void tcg_register_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
-int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
+int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start,
+                 TCGTime *tcg_time);
 
 void tb_target_set_jmp_target(const TranslationBlock *, int,
                               uintptr_t, uintptr_t);
@@ -885,7 +909,7 @@ static inline TCGv_ptr tcg_temp_new_ptr(void)
     return temp_tcgv_ptr(t);
 }
 
-int64_t tcg_cpu_exec_time(void);
+uint64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(GString *buf);
 void tcg_dump_op_count(GString *buf);
 
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index bd50062ed0..37390799f1 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -728,9 +728,18 @@ static bool main_loop_should_exit(int *status)
 int qemu_main_loop(void)
 {
     int status = EXIT_SUCCESS;
+#ifdef CONFIG_TCG
+    uint64_t ti;
+#endif
 
     while (!main_loop_should_exit(&status)) {
+#ifdef CONFIG_TCG
+        ti = profile_getclock();
+#endif
         main_loop_wait(false);
+#ifdef CONFIG_TCG
+        dev_time += profile_getclock() - ti;
+#endif
     }
 
     return status;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 47befdfcae..dc6b3226e2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -41,6 +41,7 @@
 #define NO_CPU_IO_DEFS
 
 #include "exec/exec-all.h"
+#include "exec/tb-stats.h"
 #include "tcg/tcg-op.h"
 
 #if UINTPTR_MAX == UINT32_MAX
@@ -2983,6 +2984,10 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
+    /* ? won't this end up op_opt - op = del_op_count ? */
+    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
+        s->gen_tb->tb_stats->code.deleted_ops++;
+    }
 }
 
 void tcg_remove_ops_after(TCGOp *op)
@@ -4148,6 +4153,10 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet required_regs,
     }
 
     /* We must spill something.  */
+    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
+        s->gen_tb->tb_stats->code.spills++;
+    }
+
     for (j = f; j < 2; j++) {
         TCGRegSet set = reg_ct[j];
 
@@ -5852,22 +5861,57 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-void tcg_dump_op_count(GString *buf)
+/* avoid copy/paste errors */
+#define PROF_ADD(to, from, field)                       \
+    do {                                                \
+        (to)->field += qatomic_read(&((from)->field));  \
+    } while (0)
+
+static void collect_tcg_profiler(TCGProfile *prof)
 {
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
+    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
+    unsigned int i;
+
+    for (i = 0; i < n_ctxs; i++) {
+        TCGContext *s = qatomic_read(&tcg_ctxs[i]);
+        const TCGProfile *orig = &s->prof;
+
+        PROF_ADD(prof, orig, cpu_exec_time);
+
+        for (i = 0; i < NB_OPS; i++) {
+            PROF_ADD(prof, orig, table_op_count[i]);
+        }
+    }
 }
 
-int64_t tcg_cpu_exec_time(void)
+uint64_t tcg_cpu_exec_time(void)
 {
-    error_report("%s: TCG profiler not compiled", __func__);
-    exit(EXIT_FAILURE);
+    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
+    unsigned int i;
+    uint64_t ret = 0;
+
+    for (i = 0; i < n_ctxs; i++) {
+        const TCGContext *s = qatomic_read(&tcg_ctxs[i]);
+        const TCGProfile *prof = &s->prof;
+
+        ret += qatomic_read(&prof->cpu_exec_time);
+    }
+    return ret;
 }
 
-int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
+int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start,
+                 TCGTime *tcg_time)
 {
     int i, num_insns;
     TCGOp *op;
 
+    s->current_tb = tb;
+    /* save pre-optimisation op count */
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        tb->tb_stats->code.num_tcg_ops += s->nb_ops;
+        tb->tb_stats->code.temps += s->nb_temps;
+    }
+
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -5879,6 +5923,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         }
     }
 
+
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
     {
@@ -5898,6 +5943,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 
     tcg_optimize(s);
 
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        tcg_time->opt_done = get_clock();
+    }
+
     reachable_code_pass(s);
     liveness_pass_0(s);
     liveness_pass_1(s);
@@ -5921,6 +5970,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         }
     }
 
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        tcg_time->la_done = get_clock();
+    }
+
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -5955,6 +6008,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->pool_labels = NULL;
 #endif
 
+    if (tb_stats_collection_enabled()) {
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            TCGOpcode opc = op->opc;
+            s->prof.table_op_count[opc]++;
+        }
+    }
+
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
@@ -6053,9 +6113,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     return tcg_current_code_size(s);
 }
 
+void tcg_dump_op_count(GString *buf)
+{
+    TCGProfile prof = {};
+    int i;
+
+    collect_tcg_profiler(&prof);
+    for (i = 0; i < NB_OPS; i++) {
+        g_string_append_printf(buf, "%s %" PRId64 "\n",
+                tcg_op_defs[i].name, prof.table_op_count[i]);
+    }
+}
+
 void tcg_dump_info(GString *buf)
 {
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
+    TCGProfile prof = {};
+    collect_tcg_profiler(&prof);
+    dump_jit_profile_info(&prof, buf);
 }
 
 #ifdef ELF_HOST_MACHINE
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 73a670e8fa..749aafe4da 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -46,6 +46,9 @@ static int query_error_class(const char *cmd)
         { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
         { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
         { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
+#ifndef CONFIG_TCG
+        { "x-query-profile", ERROR_CLASS_GENERIC_ERROR },
+#endif
         /* Only valid with a USB bus added */
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with accel=tcg */
-- 
2.25.1


