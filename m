Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92547B70EC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAu-00086D-Pp; Tue, 03 Oct 2023 14:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAr-00084L-QQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAp-0001gU-Mw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c735473d1aso9837995ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357870; x=1696962670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBfciibLofu5L0+I9/ztUVWgK/K31GmArzTT+bxRF1g=;
 b=F66fFEaYnoF5sb+kI28ylJu78XhYquQsEA02+Clzk30mFzJD6ap9y13otp7VCYH11E
 KNOAHXawZzDL4mAZpqhuFQyPkd9EX+O7Cod2t6iv/ap4EbIxXiMkuZLPhuZ1RI/rfq6W
 3MZ/PBXFc8TvKjSWVfyJ1vsdxBNfwg52WuXy94tvj1HFI8hJvYInP5dyivXf0DmOavog
 Gj44yHnGRcSjbpZxlOXOFY/HKdsOkXVPBwwQ+UeQxUEwJzDVGBtYHXOM+4rFNE/7l3CO
 d4O2Y9OGNr+D8DFT/ys5PGqnLy29PoIhKT3Dop1C366zg1GIm28ptK5HeeasuMMzCm3+
 OwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357870; x=1696962670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBfciibLofu5L0+I9/ztUVWgK/K31GmArzTT+bxRF1g=;
 b=XL8Q7NxO+wx04FE6U24Ffm+gbYd1TDjYMvsosPNVUqGZWqrhg52wH412P6GqvD6fof
 /DxSzo5Cz2v44yvOjUBiUyZSDUODnFg8HvCu5aCru6J/4WBvDOg/slyMQyrnUHoPj/jL
 HFaAPJAeH6Tgc1z6GzvMUH0tK2uPownl7LACI0M4njKSLGsCkvnp7Yed2I/QZY6JLn0J
 c77TJJXfT/7ammCgdvy0ADQXY8A1d+f/Y5tV//zDv28nCTIq7YMEPORwEwmFtR/XbI0U
 93JIY+pDQtzUiXoaIDPOEMt6P1FexHGycnzHohNZYL4VEpbiP9Hoyt+I5rhCuYLaUjWz
 zaFQ==
X-Gm-Message-State: AOJu0Yy4slHssrQ/aGJOaB+ud40SkLxSJ+euEy2t2289xl57QpYyqQn1
 Wbj0zjTvLt3+O1Dv49LQ6bTS0x5jZabo1YA7qtE=
X-Google-Smtp-Source: AGHT+IF1Xd5tKaRWBYyeb65ftz89AWYNFHHWmgHy76esRgicr8/LYaar8yJNwlwVJLEl5F0GYW2W4Q==
X-Received: by 2002:a17:902:d511:b0:1c3:a2ea:64cb with SMTP id
 b17-20020a170902d51100b001c3a2ea64cbmr503207plg.53.1696357870324; 
 Tue, 03 Oct 2023 11:31:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 11/16] accel/tcg: Add tb_stats_collect and tb_stats_dump
Date: Tue,  3 Oct 2023 11:30:53 -0700
Message-Id: <20231003183058.1639121-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

These functions will be used together to output statistics.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tb-stats.h |  25 +++++++++
 accel/tcg/tb-stats.c   | 119 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/include/tcg/tb-stats.h b/include/tcg/tb-stats.h
index 1ec0d13eff..edee73b63b 100644
--- a/include/tcg/tb-stats.h
+++ b/include/tcg/tb-stats.h
@@ -129,4 +129,29 @@ void tb_stats_reset_tbs(void);
 TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc, vaddr pc,
                               uint32_t flags, uint64_t flags2);
 
+/**
+ * tb_stats_collect:
+ * @max: maximum number of results
+ * @sort: sort function
+ *
+ * Collect all TBStatistics and return the first @max items,
+ * as dictated by the sort criteria.
+ */
+GPtrArray *tb_stats_collect(unsigned max, GCompareFunc sort);
+
+/* Sort functions for tb_stats_collect. */
+gint tb_stats_sort_by_spills(gconstpointer, gconstpointer);
+gint tb_stats_sort_by_coverage(gconstpointer, gconstpointer);
+gint tb_stats_sort_by_hg(gconstpointer, gconstpointer);
+
+/**
+ * tb_stats_dump:
+ * @s: structure to dump
+ * @index: label to emit
+ *
+ * Return a string with the rendering of the data in @s;
+ * @index is included in the output.
+ */
+GString *tb_stats_dump(TBStatistics *s, unsigned index);
+
 #endif /* TCG_TB_STATS_H */
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 424c9a90ec..b2c9445b67 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -83,3 +83,122 @@ TBStatistics *tb_stats_lookup(tb_page_addr_t phys_pc, vaddr pc,
     }
     return s;
 }
+
+static void tb_stats_collect_iter(void *p, uint32_t hash, void *u)
+{
+    g_ptr_array_add(u, p);
+}
+
+static void calculate_coverages(GPtrArray *array)
+{
+    double total_exec_count = 0;
+    guint i, n = array->len;
+
+    for (i = 0; i < n; ++i) {
+        TBStatistics *s = g_ptr_array_index(array, i);
+        double avg_insns = 1;
+        double exec_count;
+
+        if (s->translations.total) {
+            avg_insns = s->code.num_guest_inst / (double)s->translations.total;
+        }
+        exec_count = ((double)s->executions.atomic + s->executions.normal)
+                     / avg_insns;
+        s->executions.coverage = exec_count;
+        total_exec_count += exec_count;
+    }
+
+    for (i = 0; i < n; ++i) {
+        TBStatistics *s = g_ptr_array_index(array, i);
+        s->executions.coverage /= total_exec_count;
+    }
+}
+
+GPtrArray *tb_stats_collect(unsigned max, GCompareFunc sort)
+{
+    GPtrArray *array = g_ptr_array_new();
+
+    /*
+     * Collect all TBStatistics and sort.
+     * Note that coverage data requires both execution and jit collection.
+     */
+    qht_iter(&tb_ctx.stats, tb_stats_collect_iter, array);
+    calculate_coverages(array);
+    g_ptr_array_sort(array, sort);
+
+    /* Truncate to the first MAX entries. */
+    if (max < array->len) {
+        g_ptr_array_set_size(array, max);
+    }
+    return array;
+}
+
+gint tb_stats_sort_by_spills(gconstpointer p1, gconstpointer p2)
+{
+    const TBStatistics *s1 = *(TBStatistics **)p1;
+    const TBStatistics *s2 = *(TBStatistics **)p2;
+    double c1 = (double)s1->code.spills / s1->translations.total;
+    double c2 = (double)s2->code.spills / s2->translations.total;
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
+gint tb_stats_sort_by_coverage(gconstpointer p1, gconstpointer p2)
+{
+    const TBStatistics *s1 = *(TBStatistics **)p1;
+    const TBStatistics *s2 = *(TBStatistics **)p2;
+    double c1 = s1->executions.coverage;
+    double c2 = s2->executions.coverage;
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
+gint tb_stats_sort_by_hg(gconstpointer p1, gconstpointer p2)
+{
+    const TBStatistics *s1 = *(TBStatistics **)p1;
+    const TBStatistics *s2 = *(TBStatistics **)p2;
+    double c1 = (double)s1->code.out_len / s1->code.num_guest_inst;
+    double c2 = (double)s2->code.out_len / s2->code.num_guest_inst;
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
+GString *tb_stats_dump(TBStatistics *s, unsigned index)
+{
+    unsigned n = s->tbs->len;
+    unsigned invalid = 0;
+    GString *buf;
+
+    for (unsigned i = 0; i < n; ++i) {
+        TranslationBlock *tb = g_ptr_array_index(s->tbs, i);
+        if (tb->cflags & CF_INVALID) {
+            invalid += 1;
+        }
+    }
+
+    buf = g_string_new("");
+    g_string_append_printf(buf,
+        "TB id:%u | phys:0x" TB_PAGE_ADDR_FMT " virt=%" VADDR_PRIx
+        " flags:0x%08x invalid:%u/%u\n",
+        index, s->phys_pc, s->pc, s->flags, invalid, n - invalid);
+
+    if (tb_stats_enabled & TB_STATS_EXEC) {
+        g_string_append_printf(buf,
+            "\t| exec:%lu/%lu coverage:%.2f%%\n",
+            s->executions.normal, s->executions.atomic,
+            s->executions.coverage * 100);
+    }
+
+    if (tb_stats_enabled & TB_STATS_JIT) {
+        g_string_append_printf(buf,
+            "\t| trans:%lu inst: g:%lu op:%lu op_opt:%lu spills:%ld\n"
+            "\t| h/g (host bytes / guest insts): %f\n",
+            s->translations.total,
+            s->code.num_guest_inst / s->translations.total,
+            s->code.num_tcg_ops / s->translations.total,
+            s->code.num_tcg_ops_opt / s->translations.total,
+            s->code.spills / s->translations.total,
+            (double)s->code.out_len / s->code.num_guest_inst);
+    }
+    return buf;
+}
-- 
2.34.1


