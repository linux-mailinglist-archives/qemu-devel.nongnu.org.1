Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F349D7B70F9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAs-00084J-5q; Tue, 03 Oct 2023 14:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAp-00082b-4b
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAj-0001ek-PX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:09 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5859b06509cso864164a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357864; x=1696962664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0G1CiW3vTsjcXjVH+akh2U1DVquXavshsyj/TJNLXs=;
 b=qQMjje2hv4SfrrNt5ttn5/R8/LKV/5MTWOP2uAf3C0EBdPP+Ujy3vP6jCmOvoR5m5L
 2lbsG2fN/c3h1lN22YLXeMIVyZcDe4es7GkMr2FrcR2QhwlUEf2DZ8iq57J7snRFYCv1
 XTMNaOMg1Ld9LSurl8ty2s2oZumVnAqwnnpu+fIcJwl1iT442AD/htdqHZyied8o7uSj
 4jkR+MS6DlM3THABgvTvce037qvC5FJyCVA4/MQgq98ByBypd7AemM9P9nq+S/0KQnhx
 9mXn3h28UhR1tVdvmvdf0aQTph+HWg2ranGwizxYCsmPVc806RKlss9TkFV5XJ2Hgk1c
 soAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357864; x=1696962664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0G1CiW3vTsjcXjVH+akh2U1DVquXavshsyj/TJNLXs=;
 b=t0ufQSZPIF17V/iAycfC2+A0CK48xr4qkZoYhjxQyMC/eFrjgz++Q7TlacrperrNMi
 Rgu+WtmuWf7iRG72+hshw7PeyWk/rpmBLa+wE0f3X7FQnU0KEc3YzBOnBjSKGjtsyDnA
 BbvJHSeixsVXMRoIwTKZRu/fwgKGTt1nyE2wDAXG3jwBQSAhl/axdMG32L162ULf6tlA
 435TwdDtYZyhYyRW7nnc5vUVYeY8HBBt4RxcvwAV70uvGJW/8uPLGoEdn/G/n1GPNacX
 epNRKNzeCp+N56iE2a70E/0lwc1uHMQYW0YrG7v+1H2cJiixzAOs4b2asQwDLRiSqHAo
 CaeA==
X-Gm-Message-State: AOJu0YxLm75eH7s1LW/S+V21ElmOihLQiQQpJvUCC0cFhR/c3kau9ogB
 sEJjg9rKN36SNNi/lBareX/ARH+4fmmox5Cl1tQ=
X-Google-Smtp-Source: AGHT+IFqS4xVLboHxHVfllPSvW5Pwr2+JBk6GbNowku3wkaKWLJVGa1hQZpQyiLwmOQ9aTSjHjFGSw==
X-Received: by 2002:a17:902:d702:b0:1c5:f4c7:b4e4 with SMTP id
 w2-20020a170902d70200b001c5f4c7b4e4mr337594ply.39.1696357864406; 
 Tue, 03 Oct 2023 11:31:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com,
	"Vanderson M . do Rosario" <vandersonmr2@gmail.com>
Subject: [PATCH v17 05/16] accel/tcg: Add TBStatistics structure
Date: Tue,  3 Oct 2023 11:30:47 -0700
Message-Id: <20231003183058.1639121-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add code to allocate, reset, and free the structures along
with their corresponding TranslationBlocks.  We do not yet
collect, display, or enable the statistics.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Significantly reorganized.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-context.h           |   2 +-
 include/exec/translation-block.h |   3 +
 include/qemu/typedefs.h          |   1 +
 include/tcg/tb-stats.h           | 132 +++++++++++++++++++++++++++++++
 accel/tcg/tb-maint.c             |   3 +-
 accel/tcg/tb-stats.c             |  85 ++++++++++++++++++++
 accel/tcg/translate-all.c        |  19 +++++
 accel/tcg/meson.build            |   1 +
 8 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 include/tcg/tb-stats.h
 create mode 100644 accel/tcg/tb-stats.c

diff --git a/accel/tcg/tb-context.h b/accel/tcg/tb-context.h
index cac62d9749..4b1abe392b 100644
--- a/accel/tcg/tb-context.h
+++ b/accel/tcg/tb-context.h
@@ -29,8 +29,8 @@
 typedef struct TBContext TBContext;
 
 struct TBContext {
-
     struct qht htable;
+    struct qht stats;
 
     /* statistics */
     unsigned tb_flush_count;
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b785751774..4206a72600 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -141,6 +141,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    TBStatistics *tb_stats;
 };
 
 /* The alignment given to TranslationBlock during allocation. */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5abdbc3874..68011da95b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,6 +131,7 @@ typedef struct Range Range;
 typedef struct ReservedRegion ReservedRegion;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
+typedef struct TBStatistics TBStatistics;
 typedef struct TCGHelperInfo TCGHelperInfo;
 typedef struct TranslationBlock TranslationBlock;
 typedef struct VirtIODevice VirtIODevice;
diff --git a/include/tcg/tb-stats.h b/include/tcg/tb-stats.h
new file mode 100644
index 0000000000..1ec0d13eff
--- /dev/null
+++ b/include/tcg/tb-stats.h
@@ -0,0 +1,132 @@
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
+#ifndef TCG_TB_STATS_H
+#define TCG_TB_STATS_H 1
+
+#include "qemu/thread.h"
+#include "exec/translation-block.h"
+
+enum {
+    TB_STATS_EXEC = 1u << 0,
+    TB_STATS_JIT  = 1u << 1,
+
+    TB_STATS_NONE = 0,
+    TB_STATS_ALL  = TB_STATS_EXEC | TB_STATS_JIT,
+};
+
+extern uint32_t tb_stats_enabled;
+
+/**
+ * tb_stats_init:
+ * @flags: TB_STATS_* flags to enable.
+ *
+ * Initialize translation block statistics, enabling @flags.
+ * If @flags is 0, disable all statistics.
+ */
+void tb_stats_init(uint32_t flags);
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
+    uint64_t flags2;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+        /* filled only when dumping x% cover set */
+        double coverage;
+    } executions;
+
+    /* JIT Stats - protected by lock */
+    QemuMutex jit_stats_lock;
+
+    /* Sum of all operations for all translations */
+    struct {
+        unsigned long num_guest_inst;
+        unsigned long num_tcg_ops;
+        unsigned long num_tcg_ops_opt;
+        unsigned long spills;
+
+        unsigned long temps;
+        unsigned long deleted_ops;
+        unsigned long in_len;
+        unsigned long out_len;
+        unsigned long search_out_len;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long spanning;
+    } translations;
+
+    /*
+     * All persistent (cached) TranslationBlocks using
+     * this TBStats structure. Has to be reset on a tb_flush.
+     */
+    GPtrArray *tbs;
+};
+
+/**
+ * tb_stats_enabled:
+ * @tb: TranslationBlock
+ * @f: flag to check
+ *
+ * Return true if any stats are enabled for @tb and
+ * if @f is enabled globally.
+ */
+static inline bool tb_stats_enabled_for_tb(TranslationBlock *tb, uint32_t f)
+{
+    return unlikely(tb_stats_enabled & f) && tb->tb_stats;
+}
+
+/**
+ * tb_stats_reset_tbs: reset the linked array of TBs
+ *
+ * Reset the list of tbs for a given array. Should be called from
+ * safe work during tb_flush.
+ */
+void tb_stats_reset_tbs(void);
+
+/**
+ * tb_stats_lookup:
+ *
+ * If any tb_stats are enabled, return a new or existing struct
+ * for the tuple (phys_pc, pc, flags, flags2).  To be used when
+ * building a new TranslationBlock.
+ */
+TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc, vaddr pc,
+                              uint32_t flags, uint64_t flags2);
+
+#endif /* TCG_TB_STATS_H */
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index e678d20dc2..9025459fb1 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -27,6 +27,7 @@
 #include "exec/translate-all.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
+#include "tcg/tb-stats.h"
 #include "tb-hash.h"
 #include "tb-context.h"
 #include "internal-common.h"
@@ -772,7 +773,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     tb_remove_all();
-
+    tb_stats_reset_tbs();
     tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is expensive */
     qatomic_inc(&tb_ctx.tb_flush_count);
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
new file mode 100644
index 0000000000..424c9a90ec
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,85 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/xxhash.h"
+#include "tcg/tb-stats.h"
+#include "tb-context.h"
+
+uint32_t tb_stats_enabled;
+
+static bool tb_stats_cmp(const void *ap, const void *bp)
+{
+    const TBStatistics *a = ap;
+    const TBStatistics *b = bp;
+
+    return a->phys_pc == b->phys_pc &&
+           a->pc == b->pc &&
+           a->flags == b->flags &&
+           a->flags2 == b->flags2;
+
+}
+
+static void tb_stats_free(void *p, uint32_t hash, void *userp)
+{
+    TBStatistics *s = p;
+
+    qemu_mutex_destroy(&s->jit_stats_lock);
+    g_ptr_array_free(s->tbs, true);
+    g_free(s);
+}
+
+void tb_stats_init(uint32_t flags)
+{
+    tb_stats_enabled = flags;
+    if (flags) {
+        if (!tb_ctx.stats.map) {
+            qht_init(&tb_ctx.stats, tb_stats_cmp,
+                     CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
+        }
+    } else {
+        qht_iter(&tb_ctx.stats, tb_stats_free, NULL);
+        qht_destroy(&tb_ctx.stats);
+    }
+}
+
+static void tb_stats_reset(void *p, uint32_t hash, void *userp)
+{
+    TBStatistics *s = p;
+    g_ptr_array_set_size(s->tbs, 0);
+}
+
+void tb_stats_reset_tbs(void)
+{
+    if (tb_ctx.stats.map) {
+        qht_iter(&tb_ctx.stats, tb_stats_reset, NULL);
+    }
+}
+
+TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc, vaddr pc,
+                              uint32_t flags, uint64_t flags2)
+{
+    TBStatistics *s;
+    uint32_t h;
+    void *existing;
+
+    s = g_new0(TBStatistics, 1);
+    s->phys_pc = phys_pc;
+    s->pc = pc;
+    s->flags = flags;
+    s->flags2 = flags2;
+    s->tbs = g_ptr_array_new();
+    qemu_mutex_init(&s->jit_stats_lock);
+
+    h = qemu_xxhash7(phys_pc, pc, flags2, flags);
+    if (!qht_insert(&tb_ctx.stats, s, h, &existing)) {
+        tb_stats_free(s, 0, NULL);
+        return existing;
+    }
+    return s;
+}
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e579b0891d..6e64ae2dbe 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,6 +65,7 @@
 #include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
+#include "tcg/tb-stats.h"
 
 TBContext tb_ctx;
 
@@ -353,6 +354,24 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->guest_mo = TCG_MO_ALL;
 #endif
 
+    /*
+     * Insert the TB into the corresponding stats structure, if required.
+     * Do this before code generation so that translator_loop can see
+     * the structure address.
+     */
+    tb->tb_stats = NULL;
+    if (unlikely(tb_stats_enabled) && qemu_log_in_addr_range(pc)) {
+        TBStatistics *s = tb_stats_lookup(phys_pc,
+                                          cflags & CF_PCREL ? 0 : pc,
+                                          flags, cs_base);
+        if (s) {
+            tb->tb_stats = s;
+            qemu_mutex_lock(&s->jit_stats_lock);
+            g_ptr_array_add(s->tbs, tb);
+            qemu_mutex_unlock(&s->jit_stats_lock);
+        }
+    }
+
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8783edd06e..34312f7a8b 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -6,6 +6,7 @@ tcg_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
+  'tb-stats.c',
   'tcg-runtime-gvec.c',
   'tcg-runtime.c',
   'translate-all.c',
-- 
2.34.1


