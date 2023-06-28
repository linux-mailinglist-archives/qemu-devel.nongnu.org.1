Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B517410B4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsk-0007WZ-5k; Wed, 28 Jun 2023 08:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsb-0007UN-8l
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:42 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsX-0006gJ-5K
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953753; x=1719489753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rdyvIQY1vMsq7QenLkKjezYRM2l/kzmqU/Pzp2JhkJA=;
 b=IoFhhf0k0LPP6+u2TUb+Vr41aXxpN8reDKMIpgnA31VDmcvU98wKKER3
 zUeVxQW7ni2DBBbB0AmN9v1a5n1seobbfH5+gVkcn0ye4O75H0y580jMV
 05/8PvBIWPyK0UeneGjJuEDz14ak2YyDyB2LGZ61yWXsLIPZsaeBOfz2v
 LdUQfMD/qs5wsH5BywQqClISFu6a4SXNu5dpNJAKTb86p74C+IPoIoePh
 NhAJ9i1Voq/aLG/yIs9C3pPerObAMHa7G4/Lhj+NPTsia9c5x74s62EXb
 QRTueVop6Ff8vvjOQ/LRVpDtpDt1Z8X4VKS0eN8VLORpkA5utndMAtUCB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547299"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047489"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047489"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:18 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v16 4/9] monitor: adding tb_stats hmp command
Date: Wed, 28 Jun 2023 20:04:25 +0800
Message-Id: <20230628120430.73777-5-fei2.wu@intel.com>
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

Adding tb_stats [start|stop|status] command to hmp.
This allows controlling the collection of statistics.
It is also possible to set the flag of collection:
all, jit, or exec.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
[AJB: fix authorship]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/monitor.c           | 98 +++++++++++++++++++++++++++++++++++
 accel/tcg/tb-stats.c          | 17 ++++++
 hmp-commands.hx               | 16 ++++++
 include/exec/tb-stats-flags.h |  1 +
 include/exec/tb-stats.h       |  4 ++
 include/monitor/hmp.h         |  1 +
 6 files changed, 137 insertions(+)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 567950a7ed..60b66f16ff 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -11,14 +11,19 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qapi/qmp/qdict.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
 #include "exec/tb-stats.h"
+#include "exec/tb-flush.h"
 #include "internal.h"
+#include "tb-context.h"
 
+enum TbstatsCmd { TBS_CMD_START, TBS_CMD_STOP, TBS_CMD_STATUS };
 
 static void dump_drift_info(GString *buf)
 {
@@ -87,6 +92,99 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+struct TbstatsCommand {
+    enum TbstatsCmd cmd;
+    uint32_t flag;
+    Monitor *mon;
+};
+
+static void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
+{
+    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
+    int cmd = cmdinfo->cmd;
+    uint32_t flag = cmdinfo->flag;
+    Monitor *mon = cmdinfo->mon;
+
+    switch (cmd) {
+    case TBS_CMD_START:
+        if (tb_stats_collection_enabled()) {
+            monitor_printf(mon, "TB information already being recorded\n");
+            break;
+        }
+
+        set_tbstats_flag(flag);
+        enable_collect_tb_stats();
+        tb_flush(cpu);
+        break;
+    case TBS_CMD_STOP:
+        if (tb_stats_collection_disabled()) {
+            monitor_printf(mon, "TB information not being recorded\n");
+            break;
+        }
+
+        /* Dissalloc all TBStatistics structures and stop creating new ones */
+        disable_collect_tb_stats();
+        clean_tbstats();
+        tb_flush(cpu);
+        break;
+    case TBS_CMD_STATUS:
+        if (tb_stats_collection_enabled()) {
+            uint32_t flag = get_tbstats_flag();
+            monitor_printf(mon, "tb_stats is enabled with flag:\n");
+            monitor_printf(mon, "    EXEC: %d\n", !!(flag & TB_EXEC_STATS));
+            monitor_printf(mon, "     JIT: %d\n", !!(flag & TB_JIT_STATS));
+        } else {
+            monitor_printf(mon, "tb_stats is disabled\n");
+        }
+        break;
+    default: /* INVALID */
+        g_assert_not_reached();
+        break;
+    }
+
+    g_free(cmdinfo);
+}
+
+void hmp_tbstats(Monitor *mon, const QDict *qdict)
+{
+    if (!tcg_enabled()) {
+        monitor_printf(mon, "Only available with accel=tcg\n");
+        return;
+    }
+
+    char *cmd = (char *) qdict_get_try_str(qdict, "command");
+    enum TbstatsCmd icmd = -1;
+
+    if (strcmp(cmd, "start") == 0) {
+        icmd = TBS_CMD_START;
+    } else if (strcmp(cmd, "stop") == 0) {
+        icmd = TBS_CMD_STOP;
+    } else if (strcmp(cmd, "status") == 0) {
+        icmd = TBS_CMD_STATUS;
+    } else {
+        monitor_printf(mon, "Invalid command\n");
+        return;
+    }
+
+    char *sflag = (char *) qdict_get_try_str(qdict, "flag");
+    uint32_t flag = TB_EXEC_STATS | TB_JIT_STATS;
+    if (sflag) {
+        if (strcmp(sflag, "jit") == 0) {
+            flag = TB_JIT_STATS;
+        } else if (strcmp(sflag, "exec") == 0) {
+            flag = TB_EXEC_STATS;
+        }
+    }
+
+    struct TbstatsCommand *tbscommand = g_new0(struct TbstatsCommand, 1);
+    tbscommand->cmd = icmd;
+    tbscommand->flag = flag;
+    tbscommand->mon = mon;
+    async_safe_run_on_cpu(first_cpu, do_hmp_tbstats_safe,
+                          RUN_ON_CPU_HOST_PTR(tbscommand));
+
+}
+
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 11322359c7..c90dde37d0 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -91,6 +91,18 @@ void dump_jit_profile_info(GString *buf)
     g_free(jpi);
 }
 
+static void free_tbstats(void *p, uint32_t hash, void *userp)
+{
+    g_free(p);
+}
+
+void clean_tbstats(void)
+{
+    /* remove all tb_stats */
+    qht_iter(&tb_ctx.tb_stats, free_tbstats, NULL);
+    qht_destroy(&tb_ctx.tb_stats);
+}
+
 void init_tb_stats_htable(void)
 {
     if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
@@ -115,6 +127,11 @@ bool tb_stats_collection_enabled(void)
     return tcg_collect_tb_stats == TB_STATS_RUNNING;
 }
 
+bool tb_stats_collection_disabled(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_STOPPED;
+}
+
 uint32_t get_tbstats_flag(void)
 {
     return tbstats_flag;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f77a0..639e9d9e53 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1670,6 +1670,22 @@ SRST
   Executes a qemu-io command on the given block device.
 ERST
 
+#if defined(CONFIG_TCG)
+    {
+        .name       = "tb_stats",
+        .args_type  = "command:s,flag:s?",
+        .params     = "command [flag]",
+        .help       = "Control tb statistics collection:"
+                        "tb_stats (start|stop|status) [all|jit|exec]",
+        .cmd        = hmp_tbstats,
+    },
+#endif
+
+SRST
+``tb_stats`` *command* *flag*
+  Control recording tb statistics
+ERST
+
     {
         .name       = "qom-list",
         .args_type  = "path:s?",
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index 286ca93bcc..d8b844be99 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -19,6 +19,7 @@
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
+bool tb_stats_collection_disabled(void);
 
 uint32_t get_tbstats_flag(void);
 void set_tbstats_flag(uint32_t flag);
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 7c445856c9..ef6e8b6388 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -31,6 +31,8 @@
 #include "exec/tb-stats-flags.h"
 #include "tcg/tcg.h"
 
+enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -90,4 +92,6 @@ bool tb_stats_enabled(TranslationBlock *tb, uint32_t flag);
 
 void dump_jit_profile_info(GString *buf);
 
+void clean_tbstats(void);
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2dedb..2e7f141754 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -181,5 +181,6 @@ void hmp_ioport_write(Monitor *mon, const QDict *qdict);
 void hmp_boot_set(Monitor *mon, const QDict *qdict);
 void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
+void hmp_tbstats(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.25.1


