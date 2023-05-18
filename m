Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A170834C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:56:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze7S-0002XQ-0X; Thu, 18 May 2023 09:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7K-0002T3-8R
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:30 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7H-0002Jo-Rl
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418187; x=1715954187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dicsL1Sgg+9kcUTjdCRPATdgp46CaH6ElptVmxTH39Q=;
 b=R/1jiQktN65ZlY8NAGLN1lII9a+qLPKZvdj00uOSvQb6qwzDfKM1YxO7
 8/eBfeguoYa0vZ0xBaeCMEB/TEYoRuLjcvG1oh5wT6EdhbHa9hkZK25f8
 gHm3x+c6XmbVIGSAikOKmtA+kn3BTkW5nnlamOzi1H7GEfQAznMcarP88
 Cdmnktrxor2Nedlm4/3VxW20r2HTDz59SNDLeU+mnl/SB6y2JxxoOB54g
 M+J3rv3PPk1oM7fQ314L3Fl/Gjkw11QFBc0FnZKHHihVoKyrQppCM7dXD
 +WKODd1rlHggmAX2TigG1DygzuGQYkFJaxllSnU2fT4JMnHCOufkmJ098 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685583"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428767"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428767"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:56:22 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 01/15] accel/tcg: introduce TBStatistics structure
Date: Thu, 18 May 2023 21:57:43 +0800
Message-Id: <20230518135757.1442654-2-fei2.wu@intel.com>
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

To store statistics for each TB, we created a TBStatistics structure
which is linked with the TBs. TBStatistics can stay alive after
tb_flush and be relinked to a regenerated TB. So the statistics can
be accumulated even through flushes.

The goal is to have all present and future qemu/tcg statistics and
meta-data stored in this new structure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-2-vandersonmr2@gmail.com>
[AJB: fix git author, review comments]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 MAINTAINERS                   |  1 +
 accel/tcg/meson.build         |  1 +
 accel/tcg/tb-context.h        |  1 +
 accel/tcg/tb-hash.h           |  7 +++++
 accel/tcg/tb-maint.c          | 19 ++++++++++++
 accel/tcg/tb-stats.c          | 58 +++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c     | 43 ++++++++++++++++++++++++++
 include/exec/exec-all.h       |  3 ++
 include/exec/tb-stats-flags.h | 21 +++++++++++++
 include/exec/tb-stats.h       | 56 +++++++++++++++++++++++++++++++++
 10 files changed, 210 insertions(+)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 50585117a0..1e5a972be6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -153,6 +153,7 @@ F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/tb-flush.h
 F: include/exec/target_long.h
+F: include/exec/tb-stats*.h
 F: include/exec/helper*.h
 F: include/sysemu/cpus.h
 F: include/sysemu/tcg.h
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index aeb20a6ef0..9263bdde11 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -4,6 +4,7 @@ tcg_ss.add(files(
   'cpu-exec-common.c',
   'cpu-exec.c',
   'tb-maint.c',
+  'tb-stats.c',
   'tcg-runtime-gvec.c',
   'tcg-runtime.c',
   'translate-all.c',
diff --git a/accel/tcg/tb-context.h b/accel/tcg/tb-context.h
index cac62d9749..d7910d586b 100644
--- a/accel/tcg/tb-context.h
+++ b/accel/tcg/tb-context.h
@@ -35,6 +35,7 @@ struct TBContext {
     /* statistics */
     unsigned tb_flush_count;
     unsigned tb_phys_invalidate_count;
+    struct qht tb_stats;
 };
 
 extern TBContext tb_ctx;
diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 83dc610e4c..87d657a1c6 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -67,4 +67,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
     return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
 }
 
+static inline
+uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+                            uint32_t flags)
+{
+    return qemu_xxhash5(phys_pc, pc, flags);
+}
+
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 991746f80f..0980fca358 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -24,6 +24,7 @@
 #include "exec/log.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
+#include "exec/tb-stats.h"
 #include "exec/translate-all.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
@@ -41,6 +42,23 @@
 #define TB_FOR_EACH_JMP(head_tb, tb, n)                                 \
     TB_FOR_EACH_TAGGED((head_tb)->jmp_list_head, tb, n, jmp_list_next)
 
+/*
+ * This is the more or less the same compare as tb_cmp(), but the
+ * data persists over tb_flush. We also aggregate the various
+ * variations of cflags under one record and ignore the details of
+ * page overlap (although we can count it).
+ */
+bool tb_stats_cmp(const void *ap, const void *bp)
+{
+    const TBStatistics *a = ap;
+    const TBStatistics *b = bp;
+
+    return a->phys_pc == b->phys_pc &&
+        a->pc == b->pc &&
+        a->cs_base == b->cs_base &&
+        a->flags == b->flags;
+}
+
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -60,6 +78,7 @@ void tb_htable_init(void)
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    init_tb_stats_htable();
 }
 
 typedef struct PageDesc PageDesc;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
new file mode 100644
index 0000000000..f988bd8a31
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,58 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "disas/disas.h"
+
+#include "exec/tb-stats.h"
+#include "tb-context.h"
+
+/* TBStatistic collection controls */
+enum TBStatsStatus {
+    TB_STATS_DISABLED = 0,
+    TB_STATS_RUNNING,
+    TB_STATS_PAUSED,
+    TB_STATS_STOPPED
+};
+
+static enum TBStatsStatus tcg_collect_tb_stats;
+
+void init_tb_stats_htable(void)
+{
+    if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
+        qht_init(&tb_ctx.tb_stats, tb_stats_cmp,
+                CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
+    }
+}
+
+void enable_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = TB_STATS_RUNNING;
+    init_tb_stats_htable();
+}
+
+void disable_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = TB_STATS_STOPPED;
+}
+
+void pause_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = TB_STATS_PAUSED;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_RUNNING;
+}
+
+bool tb_stats_collection_paused(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_PAUSED;
+}
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 353849ca6d..a5ebc5e9e2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -54,6 +54,7 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
+#include "exec/tb-stats.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
@@ -301,6 +302,37 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     return tcg_gen_code(tcg_ctx, tb, pc);
 }
 
+static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
+                                  target_ulong cs_base, uint32_t flags)
+{
+    TBStatistics *new_stats = g_new0(TBStatistics, 1);
+    uint32_t hash = tb_stats_hash_func(phys_pc, pc, flags);
+    void *existing_stats = NULL;
+    new_stats->phys_pc = phys_pc;
+    new_stats->pc = pc;
+    new_stats->cs_base = cs_base;
+    new_stats->flags = flags;
+
+    /*
+     * All initialisation must be complete before we insert into qht
+     * table otherwise another thread might get a partially created
+     * structure.
+     */
+    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
+
+    if (unlikely(existing_stats)) {
+        /*
+         * If there is already a TBStatistic for this TB from a previous flush
+         * then just make the new TB point to the older TBStatistic
+         */
+        g_free(new_stats);
+        return existing_stats;
+    } else {
+        return new_stats;
+    }
+}
+
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
                               target_ulong pc, target_ulong cs_base,
@@ -373,6 +405,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     trace_translate_block(tb, pc, tb->tc.ptr);
 
+    /*
+     * We want to fetch the stats structure before we start code
+     * generation so we can count interesting things about this
+     * generation.
+     */
+    if (tb_stats_collection_enabled()) {
+        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+    } else {
+        tb->tb_stats = NULL;
+    }
+
     gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ecded1f112..d7038af3df 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -611,6 +611,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    struct TBStatistics *tb_stats;
 };
 
 /* Hide the qatomic_read to make code a little easier on the eyes */
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
new file mode 100644
index 0000000000..87ee3d902e
--- /dev/null
+++ b/include/exec/tb-stats-flags.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * We define the flags and control bits here to avoid complications of
+ * including TCG/CPU information in common code.
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TB_STATS_FLAGS
+#define TB_STATS_FLAGS
+
+/* TBStatistic collection controls */
+void enable_collect_tb_stats(void);
+void disable_collect_tb_stats(void);
+void pause_collect_tb_stats(void);
+bool tb_stats_collection_enabled(void);
+bool tb_stats_collection_paused(void);
+
+#endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
new file mode 100644
index 0000000000..b519465665
--- /dev/null
+++ b/include/exec/tb-stats.h
@@ -0,0 +1,56 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TB_STATS_H
+
+#define TB_STATS_H
+
+#include "exec/cpu-common.h"
+#include "exec/exec-all.h"
+#include "exec/tb-stats-flags.h"
+#include "tcg/tcg.h"
+
+typedef struct TBStatistics TBStatistics;
+
+/*
+ * This struct stores statistics such as execution count of the
+ * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
+ * has its own TBStatistics which will persist over tb_flush.
+ *
+ * We include additional counters to track number of translations as
+ * well as variants for compile flags.
+ */
+struct TBStatistics {
+    tb_page_addr_t phys_pc;
+    target_ulong pc;
+    uint32_t     flags;
+    /* cs_base isn't included in the hash but we do check for matches */
+    target_ulong cs_base;
+};
+
+bool tb_stats_cmp(const void *ap, const void *bp);
+
+void init_tb_stats_htable(void);
+
+#endif
-- 
2.25.1


