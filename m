Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2637410B5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsb-0007T5-3a; Wed, 28 Jun 2023 08:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsV-0007RI-EI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:31 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsL-0006gJ-IU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953741; x=1719489741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aaJLbVtXWOrEQkF11Ofk/Wyc6O9RkGgE5iisLJpkf50=;
 b=nk/g2nshWLuaLAyrsUpJCn1u+62kAFv5vFwTPT/uajqBI1/QELM586+y
 DdtkVL1zKftXAOxEd3LFujhBGSf1atKpBouLcbLZUkkxzFA1gJnGzMCPp
 3lKYc+3upEImeXlYQwqlfP4KHuvXZtOd9hPDbd/j+WOQeuH+N7YlxFe30
 fPZZk9DfP5OOjgyq7WVF9fVXG4IXQDATW5lCERMRfdmlBHGeA+fccqOHk
 DHqP4mTQDjhyGDWv2EtcXM1X9SLFwXzb45txLEclGDNblSqa81ZKDBccM
 R+7jXsudEAxsSdFMRNSdRMrMCcdOWkDpXHXP7YpGGRz4HK38RBublgzTQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547248"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047471"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047471"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:10 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Fei Wu <fei2.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 1/9] accel/tcg: introduce TBStatistics structure
Date: Wed, 28 Jun 2023 20:04:22 +0800
Message-Id: <20230628120430.73777-2-fei2.wu@intel.com>
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
 MAINTAINERS                      |  1 +
 accel/tcg/meson.build            |  1 +
 accel/tcg/tb-context.h           |  1 +
 accel/tcg/tb-hash.h              |  7 ++++
 accel/tcg/tb-maint.c             | 19 +++++++++++
 accel/tcg/tb-stats.c             | 46 ++++++++++++++++++++++++++
 accel/tcg/translate-all.c        | 44 +++++++++++++++++++++++++
 include/exec/tb-stats-flags.h    | 19 +++++++++++
 include/exec/tb-stats.h          | 56 ++++++++++++++++++++++++++++++++
 include/exec/translation-block.h |  3 ++
 10 files changed, 197 insertions(+)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e07746ac7d..f11c58f371 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -153,6 +153,7 @@ F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/tb-flush.h
 F: include/exec/target_long.h
+F: include/exec/tb-stats*.h
 F: include/exec/helper*.h
 F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 166bef173b..239120c933 100644
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
index a0c61f25cd..638fe58270 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -67,4 +67,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
     return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask);
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
index 3541419845..264bdd84b3 100644
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
@@ -59,6 +77,7 @@ void tb_htable_init(void)
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    init_tb_stats_htable();
 }
 
 typedef struct PageDesc PageDesc;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
new file mode 100644
index 0000000000..2b6be943ef
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,46 @@
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
+    TB_STATS_STOPPED = 0,
+    TB_STATS_RUNNING
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
+bool tb_stats_collection_enabled(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_RUNNING;
+}
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3d4fbc1a4..5f47b862d8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -53,6 +53,7 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
+#include "exec/tb-stats.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
@@ -283,6 +284,37 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
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
                               vaddr pc, uint64_t cs_base,
@@ -353,6 +385,18 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     trace_translate_block(tb, pc, tb->tc.ptr);
 
+    /*
+     * We want to fetch the stats structure before we start code
+     * generation so we can count interesting things about this
+     * generation.
+     */
+    if (tb_stats_collection_enabled()) {
+        tb->tb_stats = tb_get_stats(phys_pc, cflags & CF_PCREL ? 0 : pc,
+                                    cs_base, flags);
+    } else {
+        tb->tb_stats = NULL;
+    }
+
     gen_code_size = setjmp_gen_code(env, tb, pc, host_pc, &max_insns, &ti);
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
new file mode 100644
index 0000000000..c994cf3b9d
--- /dev/null
+++ b/include/exec/tb-stats-flags.h
@@ -0,0 +1,19 @@
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
+bool tb_stats_collection_enabled(void);
+
+#endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
new file mode 100644
index 0000000000..8feb50e87d
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
+#include "exec/translation-block.h"
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
+    vaddr pc;
+    uint32_t flags;
+    /* cs_base isn't included in the hash but we do check for matches */
+    uint64_t cs_base;
+};
+
+bool tb_stats_cmp(const void *ap, const void *bp);
+
+void init_tb_stats_htable(void);
+
+#endif
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5119924927..6fd8c8bc48 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -141,6 +141,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    struct TBStatistics *tb_stats;
 };
 
 /* The alignment given to TranslationBlock during allocation. */
-- 
2.25.1


