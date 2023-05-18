Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2E708359
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze7n-00036D-4x; Thu, 18 May 2023 09:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7g-000311-2E
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:52 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7d-0002Mt-UA
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418209; x=1715954209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UewUYScSJzMgwxbTkmjVN4d/9L8PVOCdLPtUgmCIYWg=;
 b=A0gTHQnTXk6jrKQMGwC9dbCpri7IOioQJbtHUbOTijGKH/zWlgGSorov
 jCBU5sq6l+JQwsHHW405xCW3OfZIJK7PgZVbYyu3usmltttNUwlkMt9Lk
 F7Gw1Ab50iWvSZI91V/YaSljnL9rSu1Oy6qqUAg5qxSowcPJYqmSGkrFM
 +xuA0FDhi2+/hBonEtPKQX3eG0aJ4n5cqrknBKwTBKC6FE3wCgFW7agLp
 Y9i5VZ71w/c7oAaIUBChVG7EyNuB9VyyuUApQFE52envX/fC9hUg+3T+B
 8pQdtwckP+Lb5yhppWt6RDGCs3dbmy79lkJ49MQKmI9QkwRCRTBVUUNun g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685738"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428827"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428827"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:56:47 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 06/15] accel/tcg: convert profiling of restore operations
 to TBStats
Date: Thu, 18 May 2023 21:57:48 +0800
Message-Id: <20230518135757.1442654-7-fei2.wu@intel.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

This starts the conversion of CONFIG_PROFILER data collection to under
the TBStats system. We introduce a new flag TB_JIT_TIME and start
tracking how much time is spent restoring execution state from a given
TB.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/translate-all.c     | 23 ++++++++++++++---------
 include/exec/tb-stats-flags.h |  1 +
 include/exec/tb-stats.h       |  5 +++++
 include/qemu/timer.h          |  3 ---
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 48ce7df121..beaef03902 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -204,10 +204,12 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
     uint64_t data[TARGET_INSN_START_WORDS];
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-    int64_t ti = profile_getclock();
-#endif
+    uint64_t ti = 0;
+
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        ti = profile_getclock();
+    }
+
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -225,11 +227,14 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
 
-#ifdef CONFIG_PROFILER
-    qatomic_set(&prof->restore_time,
-                prof->restore_time + profile_getclock() - ti);
-    qatomic_set(&prof->restore_count, prof->restore_count + 1);
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        TBStatistics *ts = tb->tb_stats;
+        uint64_t elapsed = profile_getclock() - ti;
+        qemu_mutex_lock(&ts->jit_stats_lock);
+        ts->tb_restore_time += elapsed;
+        ts->tb_restore_count++;
+        qemu_mutex_unlock(&ts->jit_stats_lock);
+    }
 }
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index b62eaaca50..f29eff7576 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -14,6 +14,7 @@
 #define TB_NOTHING    (1 << 0)
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
+#define TB_JIT_TIME   (1 << 3)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 43722ff59d..cc9ab686b8 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -92,6 +92,11 @@ struct TBStatistics {
      * this TBStats structure. Has to be reset on a tb_flush.
      */
     GPtrArray *tbs;
+
+    /* Recover state from TB */
+    uint64_t tb_restore_time;
+    uint64_t tb_restore_count;
+
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index d86fc73a17..ad0da18a5f 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -989,7 +989,6 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 #endif
 
-#ifdef CONFIG_PROFILER
 static inline int64_t profile_getclock(void)
 {
     return get_clock();
@@ -997,5 +996,3 @@ static inline int64_t profile_getclock(void)
 
 extern uint64_t dev_time;
 #endif
-
-#endif
-- 
2.25.1


