Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF53708352
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze7W-0002kY-3Y; Thu, 18 May 2023 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7U-0002hE-JF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:40 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7R-0002LC-U7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418197; x=1715954197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O0CQW1bqgE1OGMeg4d3gEy+QT5FIgjlGDCXFIzI4prU=;
 b=F0SCOEDW7rXJoO7dlihs+jYRCu13K568OTNbYJm5jZRcJds4pT7P/Bj+
 yCvB7cbof5abrzThVSHbBw3leMRlN8IsBabkJalkiYuQysKEmvrGodpP0
 C2vzYtC/wOKzFQaJbAb6VZXVqZSh3wXzx9jWT32zMPTM1upMBECdAZsKR
 /My5E33j96kOk4fpEy+Zy0FtYcaoiiNAKTiIuBzVDLhSuLiCx4HakqZhB
 tHtriuZ/pIpKQF+LTOztWVwbQqzQ/TWOaoDBj9dtrQPgAy1MXqN6FUsui
 pOIfuLhkdahV3wTSpnFNV5dsGZy+RYVWMqyiSoCgG5LSiJJkVmouiEfOY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685675"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685675"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428809"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428809"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:56:34 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 02/15] accel: collecting TB execution count
Date: Thu, 18 May 2023 21:57:44 +0800
Message-Id: <20230518135757.1442654-3-fei2.wu@intel.com>
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
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
enabled, then we instrument the start code of this TB
to atomically count the number of times it is executed.
We count both the number of "normal" executions and atomic
executions of a TB.

The execution count of the TB is stored in its respective
TBS.

All TBStatistics are created by default with the flags from
default_tbstats_flag.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
[AJB: Fix author]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/cpu-exec.c          |  6 ++++++
 accel/tcg/tb-stats.c          |  6 ++++++
 accel/tcg/tcg-runtime.c       |  8 ++++++++
 accel/tcg/tcg-runtime.h       |  1 +
 accel/tcg/translate-all.c     |  7 +++++--
 accel/tcg/translator.c        | 10 ++++++++++
 include/exec/gen-icount.h     |  1 +
 include/exec/tb-stats-flags.h |  5 +++++
 include/exec/tb-stats.h       | 13 +++++++++++++
 9 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index bc0e1c3299..a3f24c62a0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/tb-stats.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
@@ -564,7 +565,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
             mmap_unlock();
         }
 
+        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         cpu_exec_enter(cpu);
+
         /* execute the generated code */
         trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb, &tb_exit);
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index f988bd8a31..143a52ef5c 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -22,6 +22,7 @@ enum TBStatsStatus {
 };
 
 static enum TBStatsStatus tcg_collect_tb_stats;
+static uint32_t default_tbstats_flag;
 
 void init_tb_stats_htable(void)
 {
@@ -56,3 +57,8 @@ bool tb_stats_collection_paused(void)
 {
     return tcg_collect_tb_stats == TB_STATS_PAUSED;
 }
+
+uint32_t get_default_tbstats_flag(void)
+{
+    return default_tbstats_flag;
+}
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index e4e030043f..85cb795732 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/tb-stats.h"
 #include "disas/disas.h"
 #include "exec/log.h"
 #include "tcg/tcg.h"
@@ -148,3 +149,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TBStatistics *stats = (TBStatistics *) ptr;
+    tcg_debug_assert(stats);
+    ++stats->executions.normal;
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 6f8c2061d0..8d310e39c0 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -41,6 +41,7 @@ DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
 
 DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
 DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
+DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a5ebc5e9e2..31d4ddf4ab 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -312,6 +312,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
     new_stats->pc = pc;
     new_stats->cs_base = cs_base;
     new_stats->flags = flags;
+    new_stats->stats_enabled = get_default_tbstats_flag();
 
     /*
      * All initialisation must be complete before we insert into qht
@@ -408,9 +409,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     /*
      * We want to fetch the stats structure before we start code
      * generation so we can count interesting things about this
-     * generation.
+     * generation. If dfilter is in effect we will only collect stats
+     * for the specified range.
      */
-    if (tb_stats_collection_enabled()) {
+    if (tb_stats_collection_enabled() &&
+        qemu_log_in_addr_range(tb->pc)) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
     } else {
         tb->tb_stats = NULL;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 7bda43ff61..165072c8c3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,6 +18,15 @@
 #include "exec/plugin-gen.h"
 #include "exec/replay-core.h"
 
+static inline void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+        TCGv_ptr ptr = tcg_temp_new_ptr();
+        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
+        gen_helper_inc_exec_freq(ptr);
+    }
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
 {
     /* Suppress goto_tb if requested. */
@@ -56,6 +65,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Start translating.  */
     gen_tb_start(db->tb);
+    gen_tb_exec_count(tb);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f6de79a6b4..20e7835ff0 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -2,6 +2,7 @@
 #define GEN_ICOUNT_H
 
 #include "exec/exec-all.h"
+#include "exec/tb-stats.h"
 
 /* Helpers for instruction counting code generation.  */
 
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index 87ee3d902e..fa71eb6f0c 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -11,6 +11,9 @@
 #ifndef TB_STATS_FLAGS
 #define TB_STATS_FLAGS
 
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
@@ -18,4 +21,6 @@ void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+uint32_t get_default_tbstats_flag(void);
+
 #endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index b519465665..eb1fa92a4e 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -31,6 +31,9 @@
 #include "exec/tb-stats-flags.h"
 #include "tcg/tcg.h"
 
+#define tb_stats_enabled(tb, JIT_STATS) \
+    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -47,6 +50,16 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    /* which stats are enabled for this TBStats */
+    uint32_t stats_enabled;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
+
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
-- 
2.25.1


