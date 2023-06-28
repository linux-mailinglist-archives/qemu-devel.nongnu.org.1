Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB37410AD
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsk-0007YF-Mq; Wed, 28 Jun 2023 08:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsh-0007VA-3z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:43 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsc-0006gJ-Ew
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953758; x=1719489758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qLBNEBjnv9d4StJFq+2PEmcy/WBZor+oo7+NpDLGI2o=;
 b=XMzP6hPOx6w1prAaF+Y3jiz3UNH+H1WbQBE2DVK0RefzDJPb/iq1bXeO
 13DkdYM6lU+QG8uPy6pzGb2sfF8mILRHAVHvXZYBbXr1KxZRzfqjR6x27
 NhrcbbgKF8n+6bf9vpjwQ0NL6hexYrNPeLtMQDhHQVgeK2xc2WHj8ZeQN
 lF9uLprbQscTPSCDwL4XUoe1RJxHa0mck7GSDiZOSAkuBoGpDN4ZkFn14
 rnSXFnmhonxDAYl26MPtRDSkD9jPmojUjctza6HBnyVugZbaUrQ6/+br+
 EbjR+aYyIysn7Bc+gNHlZ0t/H7xvUqsnJW+GJNLVyQu/tqPyEFAwZ7Hg4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547339"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047503"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047503"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:26 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 7/9] debug: add -d tb_stats to control TBStatistics
Date: Wed, 28 Jun 2023 20:04:28 +0800
Message-Id: <20230628120430.73777-8-fei2.wu@intel.com>
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

Capture TBS at startup instead of an explicit 'tb_stats start' command.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 include/exec/tb-stats-flags.h |  1 +
 include/qemu/log.h            |  1 +
 stubs/meson.build             |  1 +
 stubs/tb-stats.c              | 32 ++++++++++++++++++++++++++++++++
 util/log.c                    | 18 ++++++++++++++++++
 5 files changed, 53 insertions(+)
 create mode 100644 stubs/tb-stats.c

diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index d8b844be99..936bd35707 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -14,6 +14,7 @@
 #define TB_NONE_STATS (0)  /* no stats */
 #define TB_EXEC_STATS (1 << 0)
 #define TB_JIT_STATS  (1 << 1)
+#define TB_ALL_STATS  (TB_EXEC_STATS | TB_JIT_STATS)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/include/qemu/log.h b/include/qemu/log.h
index df59bfabcd..eca10f02a3 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -36,6 +36,7 @@ bool qemu_log_separate(void);
 #define LOG_STRACE         (1 << 19)
 #define LOG_PER_THREAD     (1 << 20)
 #define CPU_LOG_TB_VPU     (1 << 21)
+#define CPU_LOG_TB_STATS   (1 << 22)
 
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
index 0000000000..38ee12313e
--- /dev/null
+++ b/stubs/tb-stats.c
@@ -0,0 +1,32 @@
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
+void disable_collect_tb_stats(void)
+{
+    return;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return false;
+}
+
+void set_tbstats_flag(uint32_t flag)
+{
+    return;
+}
diff --git a/util/log.c b/util/log.c
index def88a9402..59c781de36 100644
--- a/util/log.c
+++ b/util/log.c
@@ -27,6 +27,7 @@
 #include "qemu/thread.h"
 #include "qemu/lockable.h"
 #include "qemu/rcu.h"
+#include "exec/tb-stats-flags.h"
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -497,6 +498,8 @@ const QEMULogItem qemu_log_items[] = {
       "open a separate log file per thread; filename must contain '%d'" },
     { CPU_LOG_TB_VPU, "vpu",
       "include VPU registers in the 'cpu' logging" },
+    { CPU_LOG_TB_STATS, "tb_stats_{all,jit,exec}",
+      "enable collection of TBs statistics at startup" },
     { 0, NULL, NULL },
 };
 
@@ -518,6 +521,21 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "tb_stats_")) {
+            char *p = *tmp + 9;
+            uint32_t flag = TB_NONE_STATS;
+            if (g_str_has_prefix(p, "all")) {
+                flag = TB_ALL_STATS;
+            } else if (g_str_has_prefix(p, "jit")) {
+                flag = TB_JIT_STATS;
+            } else if (g_str_has_prefix(p, "exec")) {
+                flag = TB_EXEC_STATS;
+            }
+            if (flag != TB_NONE_STATS) {
+                mask |= CPU_LOG_TB_STATS;
+                set_tbstats_flag(flag);
+                enable_collect_tb_stats();
+            }
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.25.1


