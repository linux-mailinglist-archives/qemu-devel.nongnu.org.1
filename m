Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A57410AC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsi-0007WF-Vi; Wed, 28 Jun 2023 08:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsZ-0007Tm-Ax
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:35 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsO-0006fL-7z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953744; x=1719489744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UITAbsHPAO3cWSt8CcG4QwPpQLcHTwuhR8EaY218itU=;
 b=gS6BZ3xWMOPOpJ9Aem46gJPmrLlGPkkSkXc5g9LtnRh/6/Zi3q1ig0XM
 Xbege16Hb+7pLSbop7/EbLVGmepbNc+cK3mQpSWOtGxDhwsmoar5UMWxz
 /sJc3QT7Cnl8ayxmiVUC/YEizujeumhc+2d+Vo25N3EZC1EGbvTRslQjM
 pKjav7sXvVYDde5ALyoe+NTFs8GLk8vpwbOhq8uiy4y0+IrZO9xXNwTMh
 xRKCy331EAlyswyNQVgaFlqeXyJWRNukTBzmWDWaz16x3fzqjnoh91Og4
 PsR5gvHKZtVUDmP6fDR2lPYyPQ8vaDvmNkDSv4NhpQEX6jy4/LldWLASr A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547283"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047486"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047486"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:15 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 3/9] accel/tcg: add jit stats to TBStatistics
Date: Wed, 28 Jun 2023 20:04:24 +0800
Message-Id: <20230628120430.73777-4-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628120430.73777-1-fei2.wu@intel.com>
References: <20230628120430.73777-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=fei2.wu@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 accel/tcg/monitor.c           |  6 +++
 accel/tcg/tb-stats.c          | 69 +++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c     | 31 ++++++++++++++--
 accel/tcg/translator.c        |  5 +++
 include/exec/tb-stats-flags.h |  1 +
 include/exec/tb-stats.h       | 30 +++++++++++++++
 include/tcg/tcg.h             | 10 +++++
 tcg/tcg.c                     | 47 ++++++++++++++++++++++--
 8 files changed, 193 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index d48de23999..567950a7ed 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,6 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
+#include "exec/tb-stats.h"
 #include "internal.h"
 
 
@@ -70,6 +71,11 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
+    if (!tb_stats_collection_enabled()) {
+        error_setg(errp, "TB information not being recorded");
+        return NULL;
+    }
+
     if (!tcg_enabled()) {
         error_setg(errp,
                    "Opcode count information is only available with accel=tcg");
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 2b7321b548..11322359c7 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -9,6 +9,10 @@
 #include "qemu/osdep.h"
 
 #include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg/tcg.h"
+
+#include "qemu/qemu-print.h"
 
 #include "exec/tb-stats.h"
 #include "tb-context.h"
@@ -22,6 +26,71 @@ enum TBStatsStatus {
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t tbstats_flag;
 
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
+};
+
+#define stat_per_translation(stat, name) \
+    (stat->translations.total ? stat->name / stat->translations.total : 0)
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
+}
+
+/* dump JIT statistics using TBStats */
+void dump_jit_profile_info(GString *buf)
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
+    }
+    g_free(jpi);
+}
+
 void init_tb_stats_htable(void)
 {
     if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d7a35e0ea5..4f1d3b4612 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -266,7 +266,7 @@ void page_init(void)
  */
 static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
                            vaddr pc, void *host_pc,
-                           int *max_insns, int64_t *ti)
+                           int *max_insns)
 {
     int ret = sigsetjmp(tcg_ctx->jmp_trans, 0);
     if (unlikely(ret != 0)) {
@@ -294,6 +294,8 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
     new_stats->pc = pc;
     new_stats->cs_base = cs_base;
     new_stats->flags = flags;
+    new_stats->tbs = g_ptr_array_new();
+    qemu_mutex_init(&new_stats->jit_stats_lock);
 
     /*
      * All initialisation must be complete before we insert into qht
@@ -307,6 +309,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
          * If there is already a TBStatistic for this TB from a previous flush
          * then just make the new TB point to the older TBStatistic
          */
+        g_ptr_array_free(new_stats->tbs, true);
         g_free(new_stats);
         return existing_stats;
     } else {
@@ -325,7 +328,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
-    int64_t ti;
     void *host_pc;
 
     assert_memory_lock();
@@ -399,7 +401,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         tb->tb_stats = NULL;
     }
 
-    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
+    gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
         case -1:
@@ -553,6 +555,29 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         return tb;
     }
 
+    /*
+     * Collect JIT stats when enabled. We batch them all up here to
+     * avoid spamming the cache with atomic accesses
+     */
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        TBStatistics *ts = tb->tb_stats;
+        qemu_mutex_lock(&ts->jit_stats_lock);
+
+        ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
+        ts->code.in_len += tb->size;
+        ts->code.out_len += tb->tc.size;
+        ts->code.search_out_len += search_size;
+
+        ts->translations.total++;
+        if (tb_page_addr1(tb) != -1) {
+            ts->translations.spanning++;
+        }
+
+        g_ptr_array_add(ts->tbs, tb);
+
+        qemu_mutex_unlock(&ts->jit_stats_lock);
+    }
+
     /*
      * Insert TB into the corresponding region tree before publishing it
      * through QHT. Otherwise rewinding happened in the TB might fail to
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 4743fa7d01..3995d45a66 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -248,6 +248,11 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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
index c0e63408e2..286ca93bcc 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -13,6 +13,7 @@
 
 #define TB_NONE_STATS (0)  /* no stats */
 #define TB_EXEC_STATS (1 << 0)
+#define TB_JIT_STATS  (1 << 1)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index a8abab269c..7c445856c9 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -53,6 +53,34 @@ struct TBStatistics {
         unsigned long normal;
         unsigned long atomic;
     } executions;
+
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
+        unsigned temps;
+        unsigned deleted_ops;
+        unsigned in_len;
+        unsigned out_len;
+        unsigned search_out_len;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long spanning;
+    } translations;
+
+    /*
+     * All persistent (cached) TranslationBlocks using
+     * this TBStats structure. Has to be reset on a tb_flush.
+     */
+    GPtrArray *tbs;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
@@ -60,4 +88,6 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 void init_tb_stats_htable(void);
 bool tb_stats_enabled(TranslationBlock *tb, uint32_t flag);
 
+void dump_jit_profile_info(GString *buf);
+
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 95541e9474..8c0857fe12 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -478,6 +478,14 @@ static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
     return i < ARRAY_SIZE(op->output_pref) ? op->output_pref[i] : 0;
 }
 
+/*
+ * The TCGProfile structure holds data for the lifetime of the translator.
+ */
+typedef struct TCGProfile {
+    /* Lifetime count of TCGOps per TCGContext when tb_stats enabled */
+    size_t table_op_count[NB_OPS];
+} TCGProfile;
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -507,6 +515,8 @@ struct TCGContext {
     tcg_insn_unit *code_buf;      /* pointer for start of tb */
     tcg_insn_unit *code_ptr;      /* pointer for running end of tb */
 
+    TCGProfile prof;
+
 #ifdef CONFIG_DEBUG_TCG
     int goto_tb_issue_mask;
     const TCGOpcode *vecop_list;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0628fe424..1318220a77 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "exec/translation-block.h"
 #include "exec/tlb-common.h"
+#include "exec/tb-stats.h"
 #include "tcg/tcg-op-common.h"
 
 #if UINTPTR_MAX == UINT32_MAX
@@ -3033,6 +3034,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
+    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
+        s->gen_tb->tb_stats->code.deleted_ops++;
+    }
 }
 
 void tcg_remove_ops_after(TCGOp *op)
@@ -4198,6 +4202,10 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet required_regs,
     }
 
     /* We must spill something.  */
+    if (tb_stats_enabled(s->gen_tb, TB_JIT_STATS)) {
+        s->gen_tb->tb_stats->code.spills++;
+    }
+
     for (j = f; j < 2; j++) {
         TCGRegSet set = reg_ct[j];
 
@@ -5902,9 +5910,17 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-void tcg_dump_op_count(GString *buf)
+static void collect_tcg_profiler(TCGProfile *prof)
 {
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
+    unsigned int n_ctxs = qatomic_read(&tcg_cur_ctxs);
+    unsigned int i;
+
+    for (i = 0; i < n_ctxs; i++) {
+        TCGContext *s = qatomic_read(&tcg_ctxs[i]);
+        for (i = 0; i < NB_OPS; i++) {
+            prof->table_op_count[i] += s->prof.table_op_count[i];
+        }
+    }
 }
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
@@ -5912,6 +5928,12 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     int i, start_words, num_insns;
     TCGOp *op;
 
+    /* save pre-optimisation op count */
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        tb->tb_stats->code.num_tcg_ops += s->nb_ops;
+        tb->tb_stats->code.temps += s->nb_temps;
+    }
+
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
@@ -6003,6 +6025,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->gen_insn_data =
         tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
 
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
@@ -6101,9 +6130,21 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
+    dump_jit_profile_info(buf);
 }
 
 #ifdef ELF_HOST_MACHINE
-- 
2.25.1


