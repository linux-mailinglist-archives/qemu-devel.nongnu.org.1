Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 556417148E4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bMr-00052m-PI; Mon, 29 May 2023 07:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMk-0004ys-Ql
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:46 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMi-0004W3-Pk
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685360924; x=1716896924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ITREj1vVGPNThztVZaxpq0j8lNeCjKqaFFJBxm6Bn0=;
 b=KnQzeeuacVIx168bnLAKZdiCtyW2Lw5QIASSLQJPZ07b+vL12FPbXy2+
 mIr9u0hOoWOBwHhMDgvNNwv6wrf/DruGrywX9nB6B8VodAHMus61944mX
 JVBJf5bL2SMFxFLmCr4t7c+jvy88rfpxxuddsrCbXNljiA3dNaHbv62Zo
 J4kWCR3I25jbtaJhEL+JF3C9n71u/cCUzMOTYH7K0fdb/6FaFaCSLgfwm
 KSuViNw1ARC09Q+VDyTyxCEcuLOE+MDcvAAEWAQnjPI3X32HNwYmKCWM5
 1DKyrVl3W+nMnI6QJcH1u0M1gP9FFCLIWlBjqupQ8AZ726lTiJVMtGm8U Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357939702"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357939702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 04:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="683554498"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="683554498"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 29 May 2023 04:48:30 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v13 09/10] tb-stats: dump hot TBs at the end of the execution
Date: Mon, 29 May 2023 19:49:46 +0800
Message-Id: <20230529114947.2123652-10-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529114947.2123652-1-fei2.wu@intel.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
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

Dump the hottest TBs if -d tb_stats,dump_limit=N is used.

Example of output for the 3 hottest TBs:

TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
        | exec:4828932/0 guest inst cov:16.38%
        | trans:1 ints: g:3 op:82 op_opt:34 spills:3
        | h/g (host bytes / guest insts): 90.666664
        | time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
        | targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
        | exec:4825842/0 guest inst cov:21.82%
        | trans:1 ints: g:4 op:80 op_opt:38 spills:2
        | h/g (host bytes / guest insts): 84.000000
        | time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
        | targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)

TB id:3 | phys:0xec1c1 virt:0x00000000000ec1c1 flags:0x0000b0
        | exec:872032/0 guest inst cov:1.97%
        | trans:1 ints: g:2 op:56 op_opt:26 spills:1
        | h/g (host bytes / guest insts): 68.000000
        | time to gen at 2.4GHz => code:1692.08(ns) IR:473.75(ns)
        | targets: 0x00000000000ec1c5 (id:4), 0x00000000000ec1cb (id:13)

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-12-vandersonmr2@gmail.com>
[AJB: fix authorship, ad softmmu support]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/tb-stats.c          | 21 +++++++++++++++++++++
 include/exec/tb-stats-dump.h  | 21 +++++++++++++++++++++
 include/exec/tb-stats-flags.h |  1 +
 linux-user/exit.c             |  2 ++
 softmmu/runstate.c            |  2 ++
 stubs/tb-stats.c              |  5 +++++
 util/log.c                    |  4 ++--
 7 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 include/exec/tb-stats-dump.h

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 4b358cb421..d77891492a 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -19,6 +19,7 @@
 
 #include "exec/tb-stats.h"
 #include "exec/tb-flush.h"
+#include "exec/tb-stats-dump.h"
 #include "tb-context.h"
 
 #include "internal.h"
@@ -32,6 +33,7 @@ enum TBStatsStatus {
 
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
+static int max_dump_tbs;
 /* only accessed in safe work */
 static GList *last_search;
 
@@ -616,6 +618,20 @@ void dump_tb_info(int id, int log_mask, bool use_monitor)
 }
 
 
+/*
+ * Dump the final stats
+ */
+void tb_stats_dump(void)
+{
+    if (!tb_stats_collection_enabled()) {
+        return;
+    }
+
+    dump_tbs_info(max_dump_tbs, SORT_BY_HOTNESS, false);
+}
+
+/* TBStatistic collection controls */
+
 void enable_collect_tb_stats(void)
 {
     tcg_collect_tb_stats = TB_STATS_RUNNING;
@@ -669,3 +685,8 @@ void set_default_tbstats_flag(uint32_t flags)
 {
     default_tbstats_flag = flags;
 }
+
+void set_tbstats_max_tbs(int max)
+{
+    max_dump_tbs = max;
+}
diff --git a/include/exec/tb-stats-dump.h b/include/exec/tb-stats-dump.h
new file mode 100644
index 0000000000..197c6148e9
--- /dev/null
+++ b/include/exec/tb-stats-dump.h
@@ -0,0 +1,21 @@
+/*
+ * TB Stats common dump functions across sysemu/linux-user
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#ifndef _TB_STATS_DUMP_H_
+#define _TB_STATS_DUMP_H_
+
+/**
+ * tb_stats_dump: dump final tb_stats at end of execution
+ */
+#ifdef CONFIG_TCG
+void tb_stats_dump(void);
+#else
+static inline void tb_stats_dump(void) { /* do nothing */ };
+#endif
+
+#endif /* _TB_STATS_DUMP_H_ */
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index a3897c99b1..484a4c9c68 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -26,6 +26,7 @@ bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_disabled(void);
 bool tb_stats_collection_paused(void);
 
+void set_tbstats_max_tbs(int max);
 uint32_t get_default_tbstats_flag(void);
 void set_default_tbstats_flag(uint32_t);
 void set_tbstats_flags(uint32_t flags);
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 3017d28a3c..4fd23bcf60 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -25,6 +25,7 @@
 #ifdef CONFIG_GPROF
 #include <sys/gmon.h>
 #endif
+#include "exec/tb-stats-dump.h"
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
@@ -41,4 +42,5 @@ void preexit_cleanup(CPUArchState *env, int code)
         gdb_exit(code);
         qemu_plugin_user_exit();
         perf_exit();
+        tb_stats_dump();
 }
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 37390799f1..b5ceb55ffd 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -30,6 +30,7 @@
 #include "crypto/cipher.h"
 #include "crypto/init.h"
 #include "exec/cpu-common.h"
+#include "exec/tb-stats-dump.h"
 #include "gdbstub/syscalls.h"
 #include "hw/boards.h"
 #include "migration/misc.h"
@@ -827,6 +828,7 @@ void qemu_cleanup(void)
     vm_shutdown();
     replay_finish();
 
+    tb_stats_dump();
     job_cancel_sync_all();
     bdrv_close_all();
 
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
index d212c2a1fa..a3e1406b88 100644
--- a/stubs/tb-stats.c
+++ b/stubs/tb-stats.c
@@ -21,6 +21,11 @@ bool tb_stats_collection_enabled(void)
     return false;
 }
 
+void set_tbstats_max_tbs(int max)
+{
+    return;
+}
+
 void set_default_tbstats_flag(uint32_t flags)
 {
     return;
diff --git a/util/log.c b/util/log.c
index 6477eb5a5f..d159ca6916 100644
--- a/util/log.c
+++ b/util/log.c
@@ -49,7 +49,6 @@ static __thread Notifier qemu_log_thread_cleanup_notifier;
 int qemu_loglevel;
 static bool log_per_thread;
 static GArray *debug_regions;
-int32_t max_num_hot_tbs_to_dump;
 static bool to_monitor;
 bool to_string;
 
@@ -568,7 +567,8 @@ int qemu_str_to_log_mask(const char *str)
             enable_collect_tb_stats();
         } else if (tb_stats_collection_enabled() &&
                    g_str_has_prefix(*tmp, "dump_limit=")) {
-            max_num_hot_tbs_to_dump = atoi((*tmp) + 11);
+            int hot_tbs = atoi((*tmp) + 11);
+            set_tbstats_max_tbs(hot_tbs);
         } else if (tb_stats_collection_enabled() &&
                    g_str_has_prefix(*tmp, "level=")) {
             uint32_t flags = 0;
-- 
2.25.1


