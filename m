Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95197410AA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsm-0007bw-7q; Wed, 28 Jun 2023 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsh-0007VB-4P
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:43 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETse-0006hC-E4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953760; x=1719489760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nUVTgBldWSPg1rhuCH6gbTPrGBKvjK2pyCkdcPpgTVQ=;
 b=KiLu9GRRhwSpcFBLdcqK8S65JRtqjRk3qzB3IKXgRFcfnLd1DbOMuzw9
 DYFSUN5n+sJz1FrDtyZv5AWGxSP/WLLZtE/sSYIevYLr61k1NEh8anIpJ
 J9Sim8a3D/bZ254x2qfVOU/vS5PTgBczAfcQYWggBDxlt7fvrM0yp/sCD
 7Z2oL/EXr6dBdmZVy0e6PNzeIq6gS1fuK/4kYlOo072BQh1a/atd0qKt9
 2c5hki/1JRNvNJ1PQgjnsG3H+0LSfNglJppmsDoNbc8J/6NIPp571kWmb
 GUMaFjU7DIQW2YtWfcIIz3G8RnoDjnyoEfCI039cIVkJbDDdRG++u5Zip A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547359"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047516"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047516"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:29 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v16 8/9] tb-stats: dump hot TBs at the end of the execution
Date: Wed, 28 Jun 2023 20:04:29 +0800
Message-Id: <20230628120430.73777-9-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628120430.73777-1-fei2.wu@intel.com>
References: <20230628120430.73777-1-fei2.wu@intel.com>
MIME-Version: 1.0
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

Dump the hottest TBs if -d tb_stats_{all,jit,exec}[:dump_num_at_exit]
---
 accel/tcg/tb-stats.c          | 21 +++++++++++++++++++++
 include/exec/tb-stats-dump.h  | 21 +++++++++++++++++++++
 include/exec/tb-stats-flags.h |  1 +
 linux-user/exit.c             |  2 ++
 softmmu/runstate.c            |  2 ++
 stubs/tb-stats.c              |  4 ++++
 util/log.c                    | 12 ++++++++++--
 7 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 include/exec/tb-stats-dump.h

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 73f0a25781..1b038b7b85 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 
 #include "exec/tb-stats.h"
+#include "exec/tb-stats-dump.h"
 #include "tb-context.h"
 
 #include "internal.h"
@@ -29,6 +30,7 @@ enum TBStatsStatus {
 
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t tbstats_flag;
+static int max_dump_tbs;
 
 static GPtrArray *last_search;
 
@@ -300,6 +302,20 @@ void dump_tblist_info(GString *buf, int total, int sort_by)
     }
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
+    g_autoptr(GString) buf = g_string_new("");
+    dump_tblist_info(buf, max_dump_tbs, SORT_BY_HOTNESS);
+    qemu_printf("%s", buf->str);
+}
+
 void enable_collect_tb_stats(void)
 {
     tcg_collect_tb_stats = TB_STATS_RUNNING;
@@ -343,3 +359,8 @@ bool tbs_stats_enabled(struct TBStatistics *tbs, uint32_t flag)
     return tb_stats_collection_enabled() &&
            (tbstats_flag & flag);
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
index 936bd35707..52d0429eeb 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -24,5 +24,6 @@ bool tb_stats_collection_disabled(void);
 
 uint32_t get_tbstats_flag(void);
 void set_tbstats_flag(uint32_t flag);
+void set_tbstats_max_tbs(int max);
 
 #endif
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
index a9fbcf4862..74cc7430c6 100644
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
@@ -817,6 +818,7 @@ void qemu_cleanup(void)
     vm_shutdown();
     replay_finish();
 
+    tb_stats_dump();
     job_cancel_sync_all();
     bdrv_close_all();
 
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
index 38ee12313e..78ae1aa217 100644
--- a/stubs/tb-stats.c
+++ b/stubs/tb-stats.c
@@ -30,3 +30,7 @@ void set_tbstats_flag(uint32_t flag)
 {
     return;
 }
+
+void set_tbstats_max_tbs(int max) {
+    return;
+}
diff --git a/util/log.c b/util/log.c
index 59c781de36..3c15fcac01 100644
--- a/util/log.c
+++ b/util/log.c
@@ -498,8 +498,9 @@ const QEMULogItem qemu_log_items[] = {
       "open a separate log file per thread; filename must contain '%d'" },
     { CPU_LOG_TB_VPU, "vpu",
       "include VPU registers in the 'cpu' logging" },
-    { CPU_LOG_TB_STATS, "tb_stats_{all,jit,exec}",
-      "enable collection of TBs statistics at startup" },
+    { CPU_LOG_TB_STATS, "tb_stats_{all,jit,exec}[:dump_num_at_exit]",
+      "enable collection of TBs statistics at startup "
+      "and dump at exit until given a limit" },
     { 0, NULL, NULL },
 };
 
@@ -526,16 +527,23 @@ int qemu_str_to_log_mask(const char *str)
             uint32_t flag = TB_NONE_STATS;
             if (g_str_has_prefix(p, "all")) {
                 flag = TB_ALL_STATS;
+                p += 3;
             } else if (g_str_has_prefix(p, "jit")) {
                 flag = TB_JIT_STATS;
+                p += 3;
             } else if (g_str_has_prefix(p, "exec")) {
                 flag = TB_EXEC_STATS;
+                p += 4;
             }
             if (flag != TB_NONE_STATS) {
                 mask |= CPU_LOG_TB_STATS;
                 set_tbstats_flag(flag);
                 enable_collect_tb_stats();
             }
+            if (p[0] == ':') {
+                int max_to_dump = atoi(p + 1);
+                set_tbstats_max_tbs(max_to_dump);
+            }
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.25.1


