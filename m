Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A93715897
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3un1-0001Ps-0f; Tue, 30 May 2023 04:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3umy-0001PJ-5b
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:08 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3umq-00016h-OJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685435580; x=1716971580;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y9GP6f1uXj2P+/pAwTksL9tLdT2Uy5/M/dxOtmmXm/A=;
 b=Rgn7ZZIAOBauNgE1pAXpC0JUAt9NODQC9ecJJ5zEwSycwRogA0YWP+eA
 ErJguHPC6wIq/beBN7YCHzZ4RavITGhuxhyEIfH9F5cfUlXm+5pm5Lolt
 djCHg8kSH8gjSNWqb5jO+aUaRLvY+ylgvjzgmz0umYdyJHTB8vYkbRQbg
 Mmrt+qPAWaPANgMnjMcMbDFR6MCu0+1l5rmP+QUrQ+64CBgu657t1GCMe
 L9n3HUTSVQJaa2bqCGMXSJNE4V0w62USx+igjWHhAFil8+p9DecVSXyOm
 uT0TBZlPPepa7CVThbqOFbGUflyqz5KyA4U5GY2B87cK8vP4NIiFmd0zv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335202110"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="335202110"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 01:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="796188247"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="796188247"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 01:32:57 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v14 05/10] debug: add -d tb_stats to control TBStatistics
 collection:
Date: Tue, 30 May 2023 16:35:21 +0800
Message-Id: <20230530083526.2174430-6-fei2.wu@intel.com>
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

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

 -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]

"dump_limit" is used to limit the number of dumped TBStats in
linux-user mode.

[all+jit+exec+time] control the profilling level used
by the TBStats. Can be used as follow:

-d tb_stats
-d tb_stats,level=jit+time
-d tb_stats,dump_limit=15
...

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-7-vandersonmr2@gmail.com>
[AJB: fix authorship, reword title]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/tb-stats.c          |  5 +++++
 include/exec/gen-icount.h     |  1 +
 include/exec/tb-stats-flags.h |  3 +++
 include/exec/tb-stats.h       |  2 ++
 include/qemu/log.h            |  1 +
 stubs/meson.build             |  1 +
 stubs/tb-stats.c              | 27 +++++++++++++++++++++++++
 util/log.c                    | 37 +++++++++++++++++++++++++++++++++++
 8 files changed, 77 insertions(+)
 create mode 100644 stubs/tb-stats.c

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 78a3104c7f..68ac7d3f73 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -208,3 +208,8 @@ uint32_t get_default_tbstats_flag(void)
 {
     return default_tbstats_flag;
 }
+
+void set_default_tbstats_flag(uint32_t flags)
+{
+    default_tbstats_flag = flags;
+}
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 20e7835ff0..4372817951 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -3,6 +3,7 @@
 
 #include "exec/exec-all.h"
 #include "exec/tb-stats.h"
+#include "tb-stats-flags.h"
 
 /* Helpers for instruction counting code generation.  */
 
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index f29eff7576..04adaee8d9 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -15,6 +15,7 @@
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
 #define TB_JIT_TIME   (1 << 3)
+#define TB_ALL_STATS  (TB_EXEC_STATS | TB_JIT_STATS | TB_JIT_TIME)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
@@ -24,5 +25,7 @@ bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
 uint32_t get_default_tbstats_flag(void);
+void set_default_tbstats_flag(uint32_t);
+void set_tbstats_flags(uint32_t flags);
 
 #endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index d93d42e085..72585c448a 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -31,6 +31,8 @@
 #include "exec/tb-stats-flags.h"
 #include "tcg/tcg.h"
 
+#include "exec/tb-stats-flags.h"
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
diff --git a/include/qemu/log.h b/include/qemu/log.h
index c5643d8dd5..6f3b8091cd 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -35,6 +35,7 @@ bool qemu_log_separate(void);
 /* LOG_STRACE is used for user-mode strace logging. */
 #define LOG_STRACE         (1 << 19)
 #define LOG_PER_THREAD     (1 << 20)
+#define CPU_LOG_TB_STATS   (1 << 21)
 
 /* Lock/unlock output. */
 
diff --git a/stubs/meson.build b/stubs/meson.build
index a56645e2f7..e926649d40 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -65,3 +65,4 @@ else
 endif
 stub_ss.add(files('semihost-all.c'))
 stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
+stub_ss.add(files('tb-stats.c'))
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
new file mode 100644
index 0000000000..d212c2a1fa
--- /dev/null
+++ b/stubs/tb-stats.c
@@ -0,0 +1,27 @@
+/*
+ * TB Stats Stubs
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This code is licensed under the GNU GPL v2, or later.
+ */
+
+
+#include "qemu/osdep.h"
+#include "exec/tb-stats-flags.h"
+
+void enable_collect_tb_stats(void)
+{
+    return;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return false;
+}
+
+void set_default_tbstats_flag(uint32_t flags)
+{
+    return;
+}
diff --git a/util/log.c b/util/log.c
index 53b4f6c58e..7ae471d97c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -27,6 +28,7 @@
 #include "qemu/thread.h"
 #include "qemu/lockable.h"
 #include "qemu/rcu.h"
+#include "exec/tb-stats-flags.h"
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -47,6 +49,7 @@ static __thread Notifier qemu_log_thread_cleanup_notifier;
 int qemu_loglevel;
 static bool log_per_thread;
 static GArray *debug_regions;
+int32_t max_num_hot_tbs_to_dump;
 
 /* Returns true if qemu_log() will really write somewhere. */
 bool qemu_log_enabled(void)
@@ -495,6 +498,10 @@ const QEMULogItem qemu_log_items[] = {
       "log every user-mode syscall, its input, and its result" },
     { LOG_PER_THREAD, "tid",
       "open a separate log file per thread; filename must contain '%d'" },
+    { CPU_LOG_TB_STATS,
+      "tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]",
+      "enable collection of TBs statistics"
+      "(and dump until given a limit if in user mode).\n" },
     { 0, NULL, NULL },
 };
 
@@ -516,6 +523,36 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
+            mask |= CPU_LOG_TB_STATS;
+            set_default_tbstats_flag(TB_ALL_STATS);
+            enable_collect_tb_stats();
+        } else if (tb_stats_collection_enabled() &&
+                   g_str_has_prefix(*tmp, "dump_limit=")) {
+            max_num_hot_tbs_to_dump = atoi((*tmp) + 11);
+        } else if (tb_stats_collection_enabled() &&
+                   g_str_has_prefix(*tmp, "level=")) {
+            uint32_t flags = 0;
+            char **level_parts = g_strsplit(*tmp + 6, "+", 0);
+            char **level_tmp;
+            for (level_tmp = level_parts; level_tmp && *level_tmp;
+                    level_tmp++) {
+                if (g_str_equal(*level_tmp, "jit")) {
+                    flags |= TB_JIT_STATS;
+                } else if (g_str_equal(*level_tmp, "exec")) {
+                    flags |= TB_EXEC_STATS;
+                } else if (g_str_equal(*level_tmp, "time")) {
+                    flags |= TB_JIT_TIME;
+                } else if (g_str_equal(*level_tmp, "all")) {
+                    flags |= TB_ALL_STATS;
+                } else {
+                    /* FIXME: set errp */
+                    fprintf(stderr, "no option level=%s, valid options are:"
+                            "all, jit, exec or/and time\n", *level_tmp);
+                    exit(1);
+                }
+                set_default_tbstats_flag(flags);
+            }
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.25.1


