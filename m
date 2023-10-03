Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0557B70E9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkB2-00088O-3a; Tue, 03 Oct 2023 14:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAw-00087B-C4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAu-0001hT-AA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so9569675ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357875; x=1696962675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU5PrzEh8RB8pR6X9cq1FoT7Iyzl/Xdd//HRPtAH/3k=;
 b=os2wkwbnjEnWR4VqxbOz+4Zhia/xT6n4++S+MjvIXmKMXc4qpifcDw7jIUVRPl0LnW
 J+1apyn3b9dwqhmuBvjPXH506DOuK9cwTZeXDpQbBpxPwb/iULjsmuEPisqm31U3AewB
 Ywu1K8gDsUept5M209FR/7kwa3VTpBR9TrUJW5jea2YGsEAk7wTrCvZrVk/B0Yyo9o6i
 TFjmsGKGhlo/bftwcegmz17/s6TCg8tYBbeFWJfqKXaTt1CEfNCMxp1xV7Nn/yEeRprm
 E0SW5yCHKN6J/VM4UtIPMkJJs0gOSSxsUa3IQkj6Vua/MkdvzNpO39J3UcgwrWCnkfXK
 5vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357875; x=1696962675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dU5PrzEh8RB8pR6X9cq1FoT7Iyzl/Xdd//HRPtAH/3k=;
 b=ZXVis++V0SPFE58TLzvokPoiLMI91DPeLv5/lH0VFmgQ2qetu0VaIRZqsaQ1ySiy6O
 MBPtSEQ7zkjWH1A9EwITRq04wAVjPaoNOyrEIW0WucTyEBMVP5ah/eIqXkQY8te49CBw
 j2ZQPUSo0+wTF3FfN8xb7ky1CT7W9+odRy/qf3vyiIowEAOVWjW3uskiM4WO3XkShS2F
 PU3XaYlqz9Crrk6OtagIjS6kI6B6IjBWQqih+Os9lGAAk/nMlcnSReTtGrpKEskQbd4r
 sP+X2dROv2OxzLHqVyK5e5vw+V+a6a6iUF8hAcLccn6ZkVOGqoE2yN28e+82XFI8Mz8b
 95Lg==
X-Gm-Message-State: AOJu0YzZ4DATKISnuWSnGGY+fDOuC+Iej0xGPebiEgcqxX5/sDFQkgw3
 gF1W3LJZlwzWpWlI6YY73wR7KkeSSzqKY/nDXAc=
X-Google-Smtp-Source: AGHT+IEAzuUI0ayhTfiVbttnuYL8ngf3eaoDwAHk2JkHOGe6HytwB9D180PHWPeF5TChjtnhbSJX2g==
X-Received: by 2002:a17:902:720a:b0:1bc:7001:6e62 with SMTP id
 ba10-20020a170902720a00b001bc70016e62mr291906plb.35.1696357875010; 
 Tue, 03 Oct 2023 11:31:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 16/16] accel/tcg: Dump hot TBs at the end of the execution
Date: Tue,  3 Oct 2023 11:30:58 -0700
Message-Id: <20231003183058.1639121-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Fei Wu <fei2.wu@intel.com>

Dump the hottest TBs if -d tb_stats:{all,jit,exec}[:dump_num_at_exit]

Signed-off-by: Fei Wu <fei2.wu@intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.h    |  2 ++
 include/tcg/tb-stats.h | 10 +++++++++-
 accel/tcg/monitor.c    |  8 +++++---
 accel/tcg/tb-stats.c   | 27 ++++++++++++++++++++++++++-
 linux-user/exit.c      | 10 ++++++----
 softmmu/runstate.c     |  2 ++
 stubs/tb-stats.c       |  6 +++++-
 util/log.c             | 20 ++++++++++++++++----
 8 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 0e1d461c4c..84b52b399a 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -21,12 +21,14 @@
 #define BSD_PROC_H_
 
 #include <sys/resource.h>
+#include "tcg/tb-stats.h"
 
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
     gdb_exit(arg1);
     qemu_plugin_user_exit();
+    tb_stats_dump_atexit();
     _exit(arg1);
 
     return 0;
diff --git a/include/tcg/tb-stats.h b/include/tcg/tb-stats.h
index edee73b63b..d3cca94f84 100644
--- a/include/tcg/tb-stats.h
+++ b/include/tcg/tb-stats.h
@@ -41,11 +41,12 @@ extern uint32_t tb_stats_enabled;
 /**
  * tb_stats_init:
  * @flags: TB_STATS_* flags to enable.
+ * @atexit: count of hottest tbs to log.
  *
  * Initialize translation block statistics, enabling @flags.
  * If @flags is 0, disable all statistics.
  */
-void tb_stats_init(uint32_t flags);
+void tb_stats_init(uint32_t flags, uint32_t atexit);
 
 /*
  * This struct stores statistics such as execution count of the
@@ -154,4 +155,11 @@ gint tb_stats_sort_by_hg(gconstpointer, gconstpointer);
  */
 GString *tb_stats_dump(TBStatistics *s, unsigned index);
 
+/**
+ * tb_stats_dump_atexit:
+ *
+ * Log any requested TBs at end of execution.
+ */
+void tb_stats_dump_atexit(void);
+
 #endif /* TCG_TB_STATS_H */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 1be3218715..7719583654 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -245,7 +245,7 @@ static void tb_stats_init_safe(CPUState *cpu, run_on_cpu_data icmd)
 {
     uint32_t flags = icmd.host_int;
 
-    tb_stats_init(flags);
+    tb_stats_init(flags, 0);
     tb_flush(cpu);
 }
 
@@ -335,8 +335,10 @@ static void hmp_info_tblist(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    g_ptr_array_unref(tb_ctx.last_search);
-    tb_ctx.last_search = NULL;
+    if (tb_ctx.last_search) {
+        g_ptr_array_unref(tb_ctx.last_search);
+        tb_ctx.last_search = NULL;
+    }
 
     array = tb_stats_collect(max, sort);
     max = array->len;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 0f84c14a88..62a6228799 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -8,10 +8,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/xxhash.h"
+#include "qemu/log.h"
 #include "tcg/tb-stats.h"
 #include "tb-context.h"
 
 uint32_t tb_stats_enabled;
+static uint32_t tb_stats_atexit;
 
 static bool tb_stats_cmp(const void *ap, const void *bp)
 {
@@ -34,7 +36,7 @@ static void tb_stats_free(void *p, uint32_t hash, void *userp)
     g_free(s);
 }
 
-void tb_stats_init(uint32_t flags)
+void tb_stats_init(uint32_t flags, uint32_t atexit)
 {
     tb_stats_enabled = flags;
     if (flags) {
@@ -48,6 +50,14 @@ void tb_stats_init(uint32_t flags)
         qht_iter(&tb_ctx.stats, tb_stats_free, NULL);
         qht_destroy(&tb_ctx.stats);
     }
+
+    /*
+     * This function is also used by HMP, when atexit is 0.
+     * Preserve the value set from the command-line.
+     */
+    if (atexit) {
+        tb_stats_atexit = atexit;
+    }
 }
 
 static void tb_stats_reset(void *p, uint32_t hash, void *userp)
@@ -204,3 +214,18 @@ GString *tb_stats_dump(TBStatistics *s, unsigned index)
     }
     return buf;
 }
+
+void tb_stats_dump_atexit(void)
+{
+    if (tb_stats_enabled && tb_stats_atexit) {
+        g_autoptr(GPtrArray) array =
+            tb_stats_collect(tb_stats_atexit, tb_stats_sort_by_coverage);
+
+        for (uint32_t i = 0, n = array->len; i < n; ++i) {
+            TBStatistics *s = g_ptr_array_index(array, i);
+            g_autoptr(GString) str = tb_stats_dump(s, i);
+
+            qemu_log("%s\n", str->str);
+        }
+    }
+}
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 50266314e0..4487aaac7e 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "qemu/plugin.h"
+#include "tcg/tb-stats.h"
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
@@ -30,9 +31,10 @@ extern void __gcov_dump(void);
 void preexit_cleanup(CPUArchState *env, int code)
 {
 #ifdef CONFIG_GCOV
-        __gcov_dump();
+    __gcov_dump();
 #endif
-        gdb_exit(code);
-        qemu_plugin_user_exit();
-        perf_exit();
+    gdb_exit(code);
+    qemu_plugin_user_exit();
+    perf_exit();
+    tb_stats_dump_atexit();
 }
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1652ed0439..2c6fb9bff1 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -59,6 +59,7 @@
 #include "sysemu/runstate-action.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tpm.h"
+#include "tcg/tb-stats.h"
 #include "trace.h"
 
 static NotifierList exit_notifiers =
@@ -846,6 +847,7 @@ void qemu_cleanup(void)
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
     replay_finish();
+    tb_stats_dump_atexit();
 
     /*
      * We must cancel all block jobs while the block layer is drained,
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
index ceaa1622ce..f9e4ef5d04 100644
--- a/stubs/tb-stats.c
+++ b/stubs/tb-stats.c
@@ -11,6 +11,10 @@
 #include "qemu/osdep.h"
 #include "tcg/tb-stats.h"
 
-void tb_stats_init(uint32_t flags)
+void tb_stats_init(uint32_t flags, uint32_t atexit)
+{
+}
+
+void tb_stats_dump_atexit(void)
 {
 }
diff --git a/util/log.c b/util/log.c
index 0cb987fb74..789b19a226 100644
--- a/util/log.c
+++ b/util/log.c
@@ -526,19 +526,31 @@ int qemu_str_to_log_mask(const char *str, Error **errp)
 #ifdef CONFIG_TCG
         } else if (g_str_has_prefix(t, "tb_stats:") && t[9] != '\0') {
             int flags = TB_STATS_NONE;
+            unsigned atexit = 0;
             char *v = t + 9;
+            char *e = strchr(v, ':');
+            size_t len;
 
-            if (g_str_equal(v, "all")) {
+            if (e) {
+                len = e - v;
+                if (qemu_strtoui(e + 1, NULL, 10, &atexit) < 0) {
+                    error_setg(errp, "Invalid -d option \"%s\"", t);
+                    goto error;
+                }
+            } else {
+                len = strlen(v);
+            }
+            if (strncmp(v, "all", len) == 0) {
                 flags = TB_STATS_ALL;
-            } else if (g_str_equal(v, "jit")) {
+            } else if (strncmp(v, "jit", len) == 0) {
                 flags = TB_STATS_JIT;
-            } else if (g_str_equal(v, "exec")) {
+            } else if (strncmp(v, "exec", len) == 0) {
                 flags = TB_STATS_EXEC;
             } else {
                 error_setg(errp, "Invalid -d option \"%s\"", t);
                 goto error;
             }
-            tb_stats_init(flags);
+            tb_stats_init(flags, atexit);
 #endif
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
-- 
2.34.1


