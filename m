Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD95725F08
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sAl-0001tl-Qw; Wed, 07 Jun 2023 08:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAg-0001su-SV
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:50 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAd-0004hp-IZ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686140507; x=1717676507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=22bPqZniORfbwP80DXRIlKxrommfl/Onji2JNX5oNKo=;
 b=bqMEqhpJzbkeFjah6TJondKwoP4DuEXBFT/soSJBuZbiaBzuOhWz0i/t
 9iHdSo2u52SLC7VRDHgaPxRsOAGfoNklI5X1EsrWxpsW8miW2XD5bKeHw
 bIuE4JJFfRHZqaidIdsq3MmJiF8PV03p+FUUwh6oBlbN7tQEGF9V16coi
 WMfJ+Mlznn7maloj3RASU9oZriM+4GgoxoaxeDRIDAxTS9cRho7gdW+6s
 WZPh+ic4wkrAzbSF2Wsvx4dwiaqF2yxGGy1x2Cj//vTsZxY9QnrYXPw9w
 ZB5ZRqUTgGlT3yAd4RN7DHJTkLJcrdKtteveZ3f5aYGNr/sjBZ+ifzuMq g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420527913"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="420527913"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686970017"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="686970017"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 05:21:44 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 03/10] accel: collecting TB execution count
Date: Wed,  7 Jun 2023 20:24:04 +0800
Message-Id: <20230607122411.3394702-4-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607122411.3394702-1-fei2.wu@intel.com>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=fei2.wu@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 accel/tcg/cpu-exec.c          |  6 ++++++
 accel/tcg/tb-stats.c          | 18 ++++++++++++++++++
 accel/tcg/tcg-runtime.c       |  1 +
 accel/tcg/translate-all.c     |  6 ++++--
 accel/tcg/translator.c        | 25 +++++++++++++++++++++++++
 include/exec/gen-icount.h     |  1 +
 include/exec/tb-stats-flags.h |  6 ++++++
 include/exec/tb-stats.h       |  8 ++++++++
 8 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0e741960da..c0d8f26237 100644
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
index e4e030043f..11c6192064 100644
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
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4fc41a63b5..5963cd6fe4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -382,9 +382,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
index 6120ef2a92..80ffbfb455 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-temp-internal.h"
 #include "exec/exec-all.h"
 #include "exec/gen-icount.h"
 #include "exec/log.h"
@@ -18,6 +19,29 @@
 #include "exec/plugin-gen.h"
 #include "exec/replay-core.h"
 
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
 bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
 {
     /* Suppress goto_tb if requested. */
@@ -56,6 +80,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
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
index b519465665..b935c3235a 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -47,10 +47,18 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
+
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
 void init_tb_stats_htable(void);
+bool tb_stats_enabled(TranslationBlock *tb, uint32_t flag);
 
 #endif
-- 
2.25.1


