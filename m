Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4B7B70E3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAq-00081h-I1; Tue, 03 Oct 2023 14:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0007xM-72
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAh-0001e9-4h
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c77449a6daso10944525ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357861; x=1696962661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecP8STEStoBluKX5+obvIdHtKNkY82tQDQM5NMPt78I=;
 b=KW1NRT+Vrj7AyajfUuC6QqLBCWkR0VSZlncdq36Um3xAo4QzPdwvZttBWCTbQ/p/k2
 u3q9C0ThNovEW3PXE78jSruMxn/Z0PImFC78RtVp5hpEq/Y0A5BKySX+IobQTlSCeQn2
 QR+Oqo9x6odOP1ArOH5sSSj8XxAX5wBDpc1+f0rRxqgi3xtHY1c0pSpyd/XJSkT12ad9
 /+xxD8VLwMsaSr6LMk6/43t9ObI75N6Zmf7LwmesulCgDGP5hXkqzHI7wS6uorS6KCBW
 F3rMrgAKA78qrBEz7AVoFXJQCVcBiiJoC9P1TLX5BzW6K4pezTg5gPp4jAISf5lJMYl9
 G0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357861; x=1696962661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecP8STEStoBluKX5+obvIdHtKNkY82tQDQM5NMPt78I=;
 b=fqyNULuRu7mXLddMx5lPQhf2hEMbiAF8qvTfHS3xCHQQjoxVPLXWAWRKEboZ7hlvbl
 LZfTuX+jWA4n7gHzswaEDQ4epaDFU1IERl7xTkhZvDt2Ov9nOaaahbZuuRUJDM8f/4m1
 8E6vMUvmpkZO9l54ergxVixD5GNZ6hAnv6ePls40fWhgXOjw+tkgVDTizeSnvAcxLgZn
 KWYHyqduaRpYw81OPRExvg8e42mA/L3TS6HBLFM+7+Pjut8Dk90v1x3ff5tosQbWeyEf
 Sh1/LlbLrMGCCjKGBMQwTMw2FFnXBlgiN9MChDe/s+j+Ugbn03mmFC4ggj2pudEZHLfT
 x8Vw==
X-Gm-Message-State: AOJu0YybJXezpgyJ8otUzJeqgblJkC5W/LIHYV8iMZuv08YWuG4jEp5L
 GD9qo1UowSWvS84AgKNhHIhX9V5wBB6cyYnVpUM=
X-Google-Smtp-Source: AGHT+IHQlWpIxEO9S3yYrFqGl93/YLMJ5HKxZY2wHKp7Iqtx51M1vdHU7WzWc3xbJvC5dMzln8ttOg==
X-Received: by 2002:a17:902:da84:b0:1c1:ed61:e058 with SMTP id
 j4-20020a170902da8400b001c1ed61e058mr467242plx.16.1696357860611; 
 Tue, 03 Oct 2023 11:31:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 01/16] accel/tcg: Move HMP info jit and info opcount code
Date: Tue,  3 Oct 2023 11:30:43 -0700
Message-Id: <20231003183058.1639121-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Move all of it into accel/tcg/monitor.c.  This puts everything
about tcg that is only used by the monitor in the same place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h |   2 -
 include/exec/cputlb.h       |   1 -
 include/tcg/tcg.h           |   3 -
 accel/tcg/cputlb.c          |  15 ----
 accel/tcg/monitor.c         | 154 ++++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c   | 127 -----------------------------
 tcg/tcg.c                   |  10 ---
 7 files changed, 154 insertions(+), 158 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 3b2277e6e9..edefd0dcb7 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -14,8 +14,6 @@
 extern int64_t max_delay;
 extern int64_t max_advance;
 
-void dump_exec_info(GString *buf);
-
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 19b16e58f8..6da1462c4f 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -26,6 +26,5 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-void tlb_flush_counts(size_t *full, size_t *part, size_t *elide);
 #endif
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 680ff00722..82b4625773 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -842,9 +842,6 @@ static inline TCGv_ptr tcg_temp_new_ptr(void)
     return temp_tcgv_ptr(t);
 }
 
-void tcg_dump_info(GString *buf);
-void tcg_dump_op_count(GString *buf);
-
 #define TCG_CT_CONST  1 /* any constant of register size */
 
 typedef struct TCGArgConstraint {
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c5e345b8..13986820fe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -321,21 +321,6 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
     }
 }
 
-void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
-{
-    CPUState *cpu;
-    size_t full = 0, part = 0, elide = 0;
-
-    CPU_FOREACH(cpu) {
-        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
-        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
-        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
-    }
-    *pfull = full;
-    *ppart = part;
-    *pelide = elide;
-}
-
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     uint16_t asked = data.host_int;
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index caf1189e0b..093efe9714 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/qht.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
@@ -17,6 +18,7 @@
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
 #include "internal-common.h"
+#include "tb-context.h"
 
 
 static void dump_drift_info(GString *buf)
@@ -50,6 +52,153 @@ static void dump_accel_info(GString *buf)
                            one_insn_per_tb ? "on" : "off");
 }
 
+static void print_qht_statistics(struct qht_stats hst, GString *buf)
+{
+    uint32_t hgram_opts;
+    size_t hgram_bins;
+    char *hgram;
+
+    if (!hst.head_buckets) {
+        return;
+    }
+    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
+                           "(%0.2f%% head buckets used)\n",
+                           hst.used_head_buckets, hst.head_buckets,
+                           (double)hst.used_head_buckets /
+                           hst.head_buckets * 100);
+
+    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
+    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
+        hgram_opts |= QDIST_PR_NODECIMAL;
+    }
+    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
+    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain occ. "
+                           "Histogram: %s\n",
+                           qdist_avg(&hst.occupancy) * 100, hgram);
+    g_free(hgram);
+
+    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
+    if (hgram_bins > 10) {
+        hgram_bins = 10;
+    } else {
+        hgram_bins = 0;
+        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
+    }
+    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
+    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
+                           "Histogram: %s\n",
+                           qdist_avg(&hst.chain), hgram);
+    g_free(hgram);
+}
+
+struct tb_tree_stats {
+    size_t nb_tbs;
+    size_t host_size;
+    size_t target_size;
+    size_t max_target_size;
+    size_t direct_jmp_count;
+    size_t direct_jmp2_count;
+    size_t cross_page;
+};
+
+static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    struct tb_tree_stats *tst = data;
+
+    tst->nb_tbs++;
+    tst->host_size += tb->tc.size;
+    tst->target_size += tb->size;
+    if (tb->size > tst->max_target_size) {
+        tst->max_target_size = tb->size;
+    }
+    if (tb->page_addr[1] != -1) {
+        tst->cross_page++;
+    }
+    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
+        tst->direct_jmp_count++;
+        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
+            tst->direct_jmp2_count++;
+        }
+    }
+    return false;
+}
+
+static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
+{
+    CPUState *cpu;
+    size_t full = 0, part = 0, elide = 0;
+
+    CPU_FOREACH(cpu) {
+        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
+        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
+        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
+    }
+    *pfull = full;
+    *ppart = part;
+    *pelide = elide;
+}
+
+static void tcg_dump_info(GString *buf)
+{
+    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
+}
+
+static void dump_exec_info(GString *buf)
+{
+    struct tb_tree_stats tst = {};
+    struct qht_stats hst;
+    size_t nb_tbs, flush_full, flush_part, flush_elide;
+
+    tcg_tb_foreach(tb_tree_stats_iter, &tst);
+    nb_tbs = tst.nb_tbs;
+    /* XXX: avoid using doubles ? */
+    g_string_append_printf(buf, "Translation buffer state:\n");
+    /*
+     * Report total code size including the padding and TB structs;
+     * otherwise users might think "-accel tcg,tb-size" is not honoured.
+     * For avg host size we use the precise numbers from tb_tree_stats though.
+     */
+    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
+                           tcg_code_size(), tcg_code_capacity());
+    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
+    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
+                           nb_tbs ? tst.target_size / nb_tbs : 0,
+                           tst.max_target_size);
+    g_string_append_printf(buf, "TB avg host size    %zu bytes "
+                           "(expansion ratio: %0.1f)\n",
+                           nb_tbs ? tst.host_size / nb_tbs : 0,
+                           tst.target_size ?
+                           (double)tst.host_size / tst.target_size : 0);
+    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
+                           tst.cross_page,
+                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
+    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
+                           "(2 jumps=%zu %zu%%)\n",
+                           tst.direct_jmp_count,
+                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
+                           tst.direct_jmp2_count,
+                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
+
+    qht_statistics_init(&tb_ctx.htable, &hst);
+    print_qht_statistics(hst, buf);
+    qht_statistics_destroy(&hst);
+
+    g_string_append_printf(buf, "\nStatistics:\n");
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+    tcg_dump_info(buf);
+}
+
 HumanReadableText *qmp_x_query_jit(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
@@ -66,6 +215,11 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+static void tcg_dump_op_count(GString *buf)
+{
+    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
+}
+
 HumanReadableText *qmp_x_query_opcount(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8cb6ad3511..e579b0891d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -645,133 +645,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu_loop_exit_noexc(cpu);
 }
 
-static void print_qht_statistics(struct qht_stats hst, GString *buf)
-{
-    uint32_t hgram_opts;
-    size_t hgram_bins;
-    char *hgram;
-
-    if (!hst.head_buckets) {
-        return;
-    }
-    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
-                           "(%0.2f%% head buckets used)\n",
-                           hst.used_head_buckets, hst.head_buckets,
-                           (double)hst.used_head_buckets /
-                           hst.head_buckets * 100);
-
-    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
-    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
-        hgram_opts |= QDIST_PR_NODECIMAL;
-    }
-    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
-    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain occ. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.occupancy) * 100, hgram);
-    g_free(hgram);
-
-    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
-    if (hgram_bins > 10) {
-        hgram_bins = 10;
-    } else {
-        hgram_bins = 0;
-        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
-    }
-    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
-    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.chain), hgram);
-    g_free(hgram);
-}
-
-struct tb_tree_stats {
-    size_t nb_tbs;
-    size_t host_size;
-    size_t target_size;
-    size_t max_target_size;
-    size_t direct_jmp_count;
-    size_t direct_jmp2_count;
-    size_t cross_page;
-};
-
-static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
-{
-    const TranslationBlock *tb = value;
-    struct tb_tree_stats *tst = data;
-
-    tst->nb_tbs++;
-    tst->host_size += tb->tc.size;
-    tst->target_size += tb->size;
-    if (tb->size > tst->max_target_size) {
-        tst->max_target_size = tb->size;
-    }
-    if (tb_page_addr1(tb) != -1) {
-        tst->cross_page++;
-    }
-    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
-        tst->direct_jmp_count++;
-        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
-            tst->direct_jmp2_count++;
-        }
-    }
-    return false;
-}
-
-void dump_exec_info(GString *buf)
-{
-    struct tb_tree_stats tst = {};
-    struct qht_stats hst;
-    size_t nb_tbs, flush_full, flush_part, flush_elide;
-
-    tcg_tb_foreach(tb_tree_stats_iter, &tst);
-    nb_tbs = tst.nb_tbs;
-    /* XXX: avoid using doubles ? */
-    g_string_append_printf(buf, "Translation buffer state:\n");
-    /*
-     * Report total code size including the padding and TB structs;
-     * otherwise users might think "-accel tcg,tb-size" is not honoured.
-     * For avg host size we use the precise numbers from tb_tree_stats though.
-     */
-    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
-                           tcg_code_size(), tcg_code_capacity());
-    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
-    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
-                           nb_tbs ? tst.target_size / nb_tbs : 0,
-                           tst.max_target_size);
-    g_string_append_printf(buf, "TB avg host size    %zu bytes "
-                           "(expansion ratio: %0.1f)\n",
-                           nb_tbs ? tst.host_size / nb_tbs : 0,
-                           tst.target_size ?
-                           (double)tst.host_size / tst.target_size : 0);
-    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
-                           tst.cross_page,
-                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
-    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
-                           "(2 jumps=%zu %zu%%)\n",
-                           tst.direct_jmp_count,
-                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
-                           tst.direct_jmp2_count,
-                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
-
-    qht_statistics_init(&tb_ctx.htable, &hst);
-    print_qht_statistics(hst, buf);
-    qht_statistics_destroy(&hst);
-
-    g_string_append_printf(buf, "\nStatistics:\n");
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-    tcg_dump_info(buf);
-}
-
 #else /* CONFIG_USER_ONLY */
 
 void cpu_interrupt(CPUState *cpu, int mask)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f664cf1484..71c25f1974 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5919,11 +5919,6 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-void tcg_dump_op_count(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 {
     int i, start_words, num_insns;
@@ -6120,11 +6115,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     return tcg_current_code_size(s);
 }
 
-void tcg_dump_info(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
 #ifdef ELF_HOST_MACHINE
 /* In order to use this feature, the backend needs to do three things:
 
-- 
2.34.1


