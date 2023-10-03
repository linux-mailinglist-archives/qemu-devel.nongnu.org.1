Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958C7B70E2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAw-000877-6o; Tue, 03 Oct 2023 14:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAu-00086b-JK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAp-0001gE-NL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c3f97f2239so10080975ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357869; x=1696962669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD25jSGXV56D96OuAdfZq5dSUt2s3HFUz4HxD2v8rb0=;
 b=wH1VXlWCJ2Mh3egL1omTGdqNB29L5dbjwuAyNzwXOiu+8/OvOj772lWj9KdVkiT74P
 VisN9Ps4GKc0zyF2JyAW835QLj+A+JqU6CsW5lM53g848+vFOfDRZbXXyb5cvrZSqR7W
 cV9aS6Tjk2lnEA/btr6dbTt2nEJXeBfQbBL11SPWMJSZCQHYTe6XZ+ZChCAIegz2U3lK
 4b6RAkct684yHvA0Zs8v2f/KypZBeiBnqQMhcOBdIgP0BjJxzEeurfW2Z55y2zym0lRc
 6wrA7djQwqgtSHXnCGitROM2079/sher+7oKimsTZMTYu42Ekw4ciHIP3j/zUYGTFWw0
 Ecgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357869; x=1696962669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD25jSGXV56D96OuAdfZq5dSUt2s3HFUz4HxD2v8rb0=;
 b=Pu1qUJC4UhN1OL1nMtI27NKF0K38Xbov13KwnpgSVHxRvtcJPy83URBVVc2NHxgec7
 VgYeiGnu2AOGqsygA6K5NCXew3+FcNl1WiRFrQpCE7m46HNmjanar9FGNijs6p9PLOv/
 8W89KiCZqXv6aZ+rhd+b5gkn+LNfiQ2p9XtfwP33y5Di8HvdsGWizOUAGU7RVwtZ9e3I
 fpDP8oS6DdRtouadZor4b1lYDtqc0dtLJEQNNF9SJGpzNV2t1vNUAWAs6ZYbX3yuIbn+
 kQ1soAyCNo5LQ9NIBNERpKnImtfu9GOYWE4ENbyBz7p2G2FOlWlJvxPSzOSVX8aPD0kF
 OscA==
X-Gm-Message-State: AOJu0YwEguaWxmZeWSOEL5RmTwp93dVA6RdFRU0+7vUpb890WoVpjCey
 fdF2BT7h0WNShrNqOkMbCr3QN/qf9oNsf5e1Gag=
X-Google-Smtp-Source: AGHT+IFJt9dSRz8GOEyNeZb7mfMi1tLIWduJPqsFNkQ+7SNABkYzDQuP+EjKIOmt3D27lZ+6vk+fjQ==
X-Received: by 2002:a17:903:1c1:b0:1c0:c4be:62ca with SMTP id
 e1-20020a17090301c100b001c0c4be62camr417335plh.17.1696357869317; 
 Tue, 03 Oct 2023 11:31:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 10/16] util/log: Add -d tb_stats
Date: Tue,  3 Oct 2023 11:30:52 -0700
Message-Id: <20231003183058.1639121-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Enable TBStatistics collection from startup.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Change "tb_stats_foo" to "tb_stats:foo"]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 stubs/tb-stats.c  | 16 ++++++++++++++++
 util/log.c        | 36 +++++++++++++++++++++++++++++++-----
 stubs/meson.build |  1 +
 3 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100644 stubs/tb-stats.c

diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
new file mode 100644
index 0000000000..ceaa1622ce
--- /dev/null
+++ b/stubs/tb-stats.c
@@ -0,0 +1,16 @@
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
+#include "tcg/tb-stats.h"
+
+void tb_stats_init(uint32_t flags)
+{
+}
diff --git a/util/log.c b/util/log.c
index b5f08db202..0cb987fb74 100644
--- a/util/log.c
+++ b/util/log.c
@@ -30,6 +30,9 @@
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
+#ifdef CONFIG_TCG
+#include "tcg/tb-stats.h"
+#endif
 
 
 typedef struct RCUCloseFILE {
@@ -509,22 +512,41 @@ int qemu_str_to_log_mask(const char *str, Error **errp)
     char **tmp;
 
     for (tmp = parts; tmp && *tmp; tmp++) {
-        if (g_str_equal(*tmp, "all")) {
+        char *t = *tmp;
+
+        if (g_str_equal(t, "all")) {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 mask |= item->mask;
             }
 #ifdef CONFIG_TRACE_LOG
-        } else if (g_str_has_prefix(*tmp, "trace:") && (*tmp)[6] != '\0') {
-            trace_enable_events((*tmp) + 6);
+        } else if (g_str_has_prefix(t, "trace:") && t[6] != '\0') {
+            trace_enable_events(t + 6);
             mask |= LOG_TRACE;
+#endif
+#ifdef CONFIG_TCG
+        } else if (g_str_has_prefix(t, "tb_stats:") && t[9] != '\0') {
+            int flags = TB_STATS_NONE;
+            char *v = t + 9;
+
+            if (g_str_equal(v, "all")) {
+                flags = TB_STATS_ALL;
+            } else if (g_str_equal(v, "jit")) {
+                flags = TB_STATS_JIT;
+            } else if (g_str_equal(v, "exec")) {
+                flags = TB_STATS_EXEC;
+            } else {
+                error_setg(errp, "Invalid -d option \"%s\"", t);
+                goto error;
+            }
+            tb_stats_init(flags);
 #endif
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
-                if (g_str_equal(*tmp, item->name)) {
+                if (g_str_equal(t, item->name)) {
                     goto found;
                 }
             }
-            error_setg(errp, "Invalid -d option \"%s\"", *tmp);
+            error_setg(errp, "Invalid -d option \"%s\"", t);
             goto error;
         found:
             mask |= item->mask;
@@ -546,6 +568,10 @@ void qemu_print_log_usage(FILE *f)
     for (item = qemu_log_items; item->mask != 0; item++) {
         fprintf(f, "%-15s %s\n", item->name, item->help);
     }
+#ifdef CONFIG_TCG
+    fprintf(f, "tb_stats:WHICH  enable translation block statistics"
+            " (all, exec, jit)\n");
+#endif
 #ifdef CONFIG_TRACE_LOG
     fprintf(f, "trace:PATTERN   enable trace events\n");
     fprintf(f, "\nUse \"-d trace:help\" to get a list of trace events.\n\n");
diff --git a/stubs/meson.build b/stubs/meson.build
index ef6e39a64d..37ca25ea01 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -65,4 +65,5 @@ else
   stub_ss.add(files('qdev.c'))
 endif
 stub_ss.add(files('semihost-all.c'))
+stub_ss.add(files('tb-stats.c'))
 stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
-- 
2.34.1


