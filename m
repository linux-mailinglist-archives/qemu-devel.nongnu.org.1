Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070737B70F3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkB3-00088g-Vi; Tue, 03 Oct 2023 14:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAx-00087h-P8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAu-0001hL-Lc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c62d61dc96so9275535ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357874; x=1696962674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tSjnCwo3pjRgK09vqvCcwYk3QeyeC6thVIvJ/sf7yQ=;
 b=uiXs2b2kPfZBv5r3POhKAuAqyI0JfNAnA+wvBvbcJmOd4opSmIMu0JcrZ6HcUTaxBL
 NtKYXEN9YUcnxArYNvs6yTWWiGxAOaNnfLVALi7YUjUlAxLMHEXokWeC2NmksBe44JLf
 qtJnVG8Mi0oQspKmalHnBwEc2Ig+fDeWXW/elmEAh7IBrSa1+ZmWdI4zaAeZ0V7vY+A/
 CaLHR5jPTROPfPq16GC9ItMiCmc4DL+rMZiX1T0pQn0ne7Dr+Tk92mar9tDo6RGc+ENO
 YyzTIL27VsgpEKvFDKEC1l5LryFSg7MlyYHYhZv7bGiskomZYPXg9wHU4gp0U7zqJYch
 4Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357874; x=1696962674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tSjnCwo3pjRgK09vqvCcwYk3QeyeC6thVIvJ/sf7yQ=;
 b=cnJtr0Vv2pgNphR1NefLrNZ0pBkgGo3gRQ1HZZqBc7pNhy5h2mkrhEx2TM6k5yKNN+
 50BNFJsbqdFXR+JweBtASLtqRRECO14XBVLJDrkaeLm3ZcJZaWAu8l+/gGZ4ndfVe/ES
 yEHJB6mWTJJ+01sbHHPhJR8yBcUgyC+uV1aAMNF44nO8CrU1irM/EPNHXauAf0NBgpv0
 BZowhJOZbhqauAGSz55J/+FrphlvfUfYzGVSMK1Xk6UXzwqiGpxTh7PX9L3qJ3iuxWm3
 VUjtrMkYrTAaaWo28zfRat3hJJMYDk1OTeNGGFrOD2QCYNvNUrhurSx7KnkvAnL1yZOp
 ahVw==
X-Gm-Message-State: AOJu0Yz5/ueZEXOAvgDlK0SbOklsGd11wfihG5E7miJdwNjWE7VxVGNf
 ft4HLjZD9bro7rGrG2VdQto9O5x94efKja2ETw8=
X-Google-Smtp-Source: AGHT+IEN27Rx0b/945NcKwSK0UxmhyhDqnnmxyLKGLqTZV6mb0g617Uk9XIGyUNYBNwl0o+Xi49New==
X-Received: by 2002:a17:902:ee89:b0:1c1:f5a6:bdfa with SMTP id
 a9-20020a170902ee8900b001c1f5a6bdfamr389810pld.7.1696357874205; 
 Tue, 03 Oct 2023 11:31:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 15/16] accel/tcg: Add info [tb-list|tb] commands to HMP
Date: Tue,  3 Oct 2023 11:30:57 -0700
Message-Id: <20231003183058.1639121-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

These commands allow the exploration of TBs generated by the TCG.
Understand which one hotter, with more guest/host instructions,
and examine the guest code.

The goal of this command is to allow the dynamic exploration of
TCG behavior and code quality. Therefore, for now, a corresponding
QMP command is not worthwhile.

Example of output:

------------------------------

TB id:0 | phys:0xa21f562e virt:0x0000000000000000 flags:0x00028010 0 inv/1
        | exec:6171503732/0 guest inst cov:94.77%
        | trans:1 ints: g:8 op:28 op_opt:24 spills:0
        | h/g (host bytes / guest insts): 37.000000

0xa21f562e:  00002797      auipc         a5,8192           # 0xa21f762e
0xa21f5632:  a2278793      addi          a5,a5,-1502
0xa21f5636:  639c          ld            a5,0(a5)
0xa21f5638:  00178713      addi          a4,a5,1
0xa21f563c:  00002797      auipc         a5,8192           # 0xa21f763c
0xa21f5640:  a1478793      addi          a5,a5,-1516
0xa21f5644:  e398          sd            a4,0(a5)
0xa21f5646:  b7e5          j             -24               # 0xa21f562e

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-context.h |  2 +
 accel/tcg/monitor.c    | 91 ++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/tb-stats.c   |  2 +
 hmp-commands-info.hx   | 14 +++++++
 4 files changed, 109 insertions(+)

diff --git a/accel/tcg/tb-context.h b/accel/tcg/tb-context.h
index 4b1abe392b..29d87200b6 100644
--- a/accel/tcg/tb-context.h
+++ b/accel/tcg/tb-context.h
@@ -35,6 +35,8 @@ struct TBContext {
     /* statistics */
     unsigned tb_flush_count;
     unsigned tb_phys_invalidate_count;
+
+    GPtrArray *last_search;
 };
 
 extern TBContext tb_ctx;
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 370fea883c..1be3218715 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -15,12 +15,14 @@
 #include "qapi/qmp/qdict.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-target.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
 #include "tcg/tb-stats.h"
 #include "exec/tb-flush.h"
+#include "disas/disas.h"
 #include "internal-common.h"
 #include "tb-context.h"
 
@@ -303,10 +305,99 @@ static void hmp_tbstats(Monitor *mon, const QDict *qdict)
                           RUN_ON_CPU_HOST_INT(flags));
 }
 
+static void hmp_info_tblist(Monitor *mon, const QDict *qdict)
+{
+    int max;
+    const char *sortedby_str;
+    GCompareFunc sort;
+    GPtrArray *array;
+
+    if (!tcg_enabled()) {
+        monitor_printf(mon, "Only available with accel=tcg\n");
+        return;
+    }
+    if (!tb_stats_enabled) {
+        monitor_printf(mon, "TB statistics not being recorded\n");
+        return;
+    }
+
+    max = qdict_get_try_int(qdict, "number", 10);
+    sortedby_str = qdict_get_try_str(qdict, "sortedby");
+
+    if (sortedby_str == NULL || g_str_equal(sortedby_str, "hotness")) {
+        sort = tb_stats_sort_by_coverage;
+    } else if (g_str_equal(sortedby_str, "hg")) {
+        sort = tb_stats_sort_by_hg;
+    } else if (g_str_equal(sortedby_str, "spills")) {
+        sort = tb_stats_sort_by_spills;
+    } else {
+        monitor_printf(mon, "Sort options are: hotness, hg, spills\n");
+        return;
+    }
+
+    g_ptr_array_unref(tb_ctx.last_search);
+    tb_ctx.last_search = NULL;
+
+    array = tb_stats_collect(max, sort);
+    max = array->len;
+    if (max == 0) {
+        monitor_printf(mon, "No TB statistics collected\n");
+        g_ptr_array_free(array, true);
+        return;
+    }
+
+    for (int i = 0; i < max; ++i) {
+        TBStatistics *s = g_ptr_array_index(array, i);
+        g_autoptr(GString) buf = tb_stats_dump(s, i);
+        monitor_puts(mon, buf->str);
+    }
+
+    /* Remember for the next "info tb" */
+    tb_ctx.last_search = array;
+}
+
+static void hmp_info_tb(Monitor *mon, const QDict *qdict)
+{
+    GPtrArray *array;
+    int id;
+
+    if (!tcg_enabled()) {
+        monitor_printf(mon, "Only available with accel=tcg\n");
+        return;
+    }
+
+    array = g_ptr_array_ref(tb_ctx.last_search);
+    if (!array) {
+        monitor_printf(mon, "No TB statistics collected\n");
+        return;
+    }
+
+    id = qdict_get_int(qdict, "id");
+    if (id < array->len) {
+        TBStatistics *s = g_ptr_array_index(array, id);
+        g_autoptr(GString) buf = tb_stats_dump(s, id);
+        monitor_puts(mon, buf->str);
+
+        for (int i = s->tbs->len - 1; i >= 0; --i) {
+            TranslationBlock *tb = g_ptr_array_index(s->tbs, i);
+            if (!(tb->cflags & CF_INVALID)) {
+                monitor_disas(mon, mon_get_cpu(mon), s->phys_pc,
+                              tb->icount, MON_DISAS_GRA);
+            }
+        }
+    } else {
+        monitor_printf(mon, "TB %d information not recorded\n", id);
+    }
+
+    g_ptr_array_unref(array);
+}
+
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
     monitor_register_hmp_info_hrt("opcount", qmp_x_query_opcount);
     monitor_register_hmp("tb_stats", false, hmp_tbstats);
+    monitor_register_hmp("tb-list", true, hmp_info_tblist);
+    monitor_register_hmp("tb", true, hmp_info_tb);
 }
 type_init(hmp_tcg_register);
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index b2c9445b67..0f84c14a88 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -43,6 +43,8 @@ void tb_stats_init(uint32_t flags)
                      CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
         }
     } else {
+        g_ptr_array_unref(tb_ctx.last_search);
+        tb_ctx.last_search = NULL;
         qht_iter(&tb_ctx.stats, tb_stats_free, NULL);
         qht_destroy(&tb_ctx.stats);
     }
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index f5b37eb74a..8e9b64cf7f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -262,6 +262,20 @@ ERST
         .params     = "",
         .help       = "show dynamic compiler info",
     },
+    {
+        .name       = "tb-list",
+        .args_type  = "number:i?,sortedby:s?",
+        .params     = "[number sortedby]",
+        .help       = "show a [number] translated blocks sorted by [sortedby]"
+                      "sortedby opts: hotness hg spills",
+    },
+    {
+        .name       = "tb",
+        .args_type  = "id:i",
+        .params     = "id",
+        .help       = "show information about one translated block by id,"
+                      "from the result of a previous \"info tb-list\"",
+    },
 #endif
 
 SRST
-- 
2.34.1


