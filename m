Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814A7410A8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsh-0007Uv-SQ; Wed, 28 Jun 2023 08:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsV-0007RJ-E9
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:31 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsN-0006hC-50
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953743; x=1719489743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LzRwM6iUAnwAGkBm1Wss6OjnmIf7taC0KbSVByqzQqk=;
 b=QYeD+8ByW838OKNHB+Zx97KNIA5tF6HX6cHSQZj/IMsGUA1xWvoRe4YB
 b6lvEkMHYtyfueHaV8bgEWGLjq6g9/5z9BQHpf9NezMgiysMazDbdiWg7
 vaoOWlum5nBNbWm7xd3cNnUhS82V16dhkkIWDYxCrMVV4L9SWDksVcnMP
 giUHjKKBmOEfUvOpLxIRbiNiLaImTtdfGPvfZiyK9JtcpWwGHFmbKv2LD
 J6QHi8EN7c1E6+P2cpXnwX0WdjoSM/YXcFrerwUW8hSQ0qWpmXqLYbfgW
 9SywOx8A1XKo8hAN0vbfeNxqetptwU05KD5tKMkPGjnXMTtT+WcoBY1J3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547271"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547271"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047478"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047478"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:13 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 2/9] accel: collecting TB execution count
Date: Wed, 28 Jun 2023 20:04:23 +0800
Message-Id: <20230628120430.73777-3-fei2.wu@intel.com>
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

[Richard Henderson created the inline gen_tb_exec_count]

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
[AJB: Fix author]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/cpu-exec.c            |  6 ++++++
 accel/tcg/tb-stats.c            | 18 ++++++++++++++++++
 accel/tcg/tcg-runtime.c         |  1 +
 accel/tcg/translate-all.c       |  6 ++++--
 accel/tcg/translator.c          | 26 ++++++++++++++++++++++++++
 include/exec/tb-stats-flags.h   |  6 ++++++
 include/exec/tb-stats.h         |  7 +++++++
 include/tcg/tcg-temp-internal.h |  2 ++
 8 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba1890a373..ba8ac61069 100644
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
@@ -562,7 +563,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
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
index 2b6be943ef..2b7321b548 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -20,6 +20,7 @@ enum TBStatsStatus {
 };
 
 static enum TBStatsStatus tcg_collect_tb_stats;
+static uint32_t tbstats_flag;
 
 void init_tb_stats_htable(void)
 {
@@ -44,3 +45,20 @@ bool tb_stats_collection_enabled(void)
 {
     return tcg_collect_tb_stats == TB_STATS_RUNNING;
 }
+
+uint32_t get_tbstats_flag(void)
+{
+    return tbstats_flag;
+}
+
+void set_tbstats_flag(uint32_t flag)
+{
+    tbstats_flag = flag;
+}
+
+bool tb_stats_enabled(TranslationBlock *tb, uint32_t flag)
+{
+    return tb_stats_collection_enabled() &&
+           tb->tb_stats &&
+           (tbstats_flag & flag);
+}
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d..14d684c2ee 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto-common.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/tb-stats.h"
 #include "disas/disas.h"
 #include "exec/log.h"
 #include "tcg/tcg.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5f47b862d8..d7a35e0ea5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -388,9 +388,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
         tb->tb_stats = tb_get_stats(phys_pc, cflags & CF_PCREL ? 0 : pc,
                                     cs_base, flags);
     } else {
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0fd9efceba..4743fa7d01 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -10,10 +10,12 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "tcg/tcg-temp-internal.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/translate-all.h"
 #include "exec/plugin-gen.h"
+#include "exec/tb-stats.h"
 #include "tcg/tcg-op-common.h"
 
 static void gen_io_start(void)
@@ -117,6 +119,29 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
     }
 }
 
+static void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
+        if (sizeof(tb->tb_stats->executions.normal) == 4) {
+            TCGv_i32 t = tcg_temp_ebb_new_i32();
+            tcg_gen_ld_i32(t, ptr, 0);
+            tcg_gen_addi_i32(t, t, 1);
+            tcg_gen_st_i32(t, ptr, 0);
+            tcg_temp_free_i32(t);
+        } else {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            tcg_gen_ld_i64(t, ptr, 0);
+            tcg_gen_addi_i64(t, t, 1);
+            tcg_gen_st_i64(t, ptr, 0);
+            tcg_temp_free_i64(t);
+        }
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
@@ -156,6 +181,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Start translating.  */
     icount_start_insn = gen_tb_start(cflags);
+    gen_tb_exec_count(tb);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index c994cf3b9d..c0e63408e2 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -11,9 +11,15 @@
 #ifndef TB_STATS_FLAGS
 #define TB_STATS_FLAGS
 
+#define TB_NONE_STATS (0)  /* no stats */
+#define TB_EXEC_STATS (1 << 0)
+
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 
+uint32_t get_tbstats_flag(void);
+void set_tbstats_flag(uint32_t flag);
+
 #endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 8feb50e87d..a8abab269c 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -47,10 +47,17 @@ struct TBStatistics {
     uint32_t flags;
     /* cs_base isn't included in the hash but we do check for matches */
     uint64_t cs_base;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
 void init_tb_stats_htable(void);
+bool tb_stats_enabled(TranslationBlock *tb, uint32_t flag);
 
 #endif
diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index dded2917e5..61ef055b92 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -25,6 +25,8 @@
 #ifndef TCG_TEMP_INTERNAL_H
 #define TCG_TEMP_INTERNAL_H
 
+#include "tcg.h"
+
 /*
  * Allocation and freeing of EBB temps is reserved to TCG internals
  */
-- 
2.25.1


