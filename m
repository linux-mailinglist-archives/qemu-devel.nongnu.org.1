Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D760A7B70EF
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAr-000849-VH; Tue, 03 Oct 2023 14:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAo-00081k-S1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0001fO-O1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c61bde0b4bso10798895ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357867; x=1696962667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnJ57/DCzka0bx3FOdRsvPKfSH9sE7SIww+OcI5Yp3Y=;
 b=IQJOWpj4ZMH2cFnFwIq5NcIk9e0MxkSlc6pz/kQQbELbkNdyWhGT2tXfvpn536VZJK
 pebn8V2gGKSc+3F3CsuHhtnCkSqi9Hl8ATp5XWaW/PAy10fK40YEQwYgR8rHCbUm8OqU
 ttL47BPHrGvWeUMF8ulN9NDdUkSllJEMJbo5aQeUpimu7m+Sy6QH3GG9uPY724Q3wlPG
 xLsvKSm1y/yyvlFG3sb6DOh3xpFu1IOKG/KI4N4cxHkkMGjAAW2xNkDtLwAUAJ/QOysL
 K7vdBEGDoc3ibRxLHEc/re7ooGKeQjdXLuaS8RRa9ldA/E3lm7fkRzmIfDB2KcLqYpzl
 HAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357867; x=1696962667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnJ57/DCzka0bx3FOdRsvPKfSH9sE7SIww+OcI5Yp3Y=;
 b=GgMQK1d4rcDRBkIi6MnmYFOVMwkkhoG7BNifcigAF24HHVldXeUe/aXLHfz9ZaaM7a
 5Gk8fu/9Q0isSkeXzotbbKIYFsQBY+cBiHpTntM4cNfxyD4hJMeVmQv9LDYA3omE4VH6
 bhc/X5L8+PiAQ/MwmZvkVGu/wfvvTpZPDqHPdV6SJOWRg5iGG1yaZ11noAgPu3ZGtmiC
 byTxaHXaj2N2uT48tjcZWT62JfJw60AZwDJeFLSA9uPZUXW9b0u+9b64kMPquE2lBNnL
 YOC0WNAlWIVYCxF4SyzkFWFQR5B1kT8ZEkE2RVb10Gl58OAdO736ERuwFtMHLMMTTmTa
 ZbkA==
X-Gm-Message-State: AOJu0YzxH3ZkreQNMcfrlsaTP+0UFkzmnihSbhm319IP23X21RyUA+mt
 2j3IDBC84HqD/4AOWfS4IzlBZJztpuuYIqeRDmo=
X-Google-Smtp-Source: AGHT+IEIgpsCaWI2GvEOFtGhNbfnvpsLDIQZUw1CjwILewTYC8mhV9c5MQ3ZzRIyveM3DDVGDb7jng==
X-Received: by 2002:a17:903:32cb:b0:1c3:2ee6:3811 with SMTP id
 i11-20020a17090332cb00b001c32ee63811mr425165plr.8.1696357867317; 
 Tue, 03 Oct 2023 11:31:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 08/16] accel/tcg: Add tb_stats hmp command
Date: Tue,  3 Oct 2023 11:30:50 -0700
Message-Id: <20231003183058.1639121-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Add tb_stats [start|stop|status] command to hmp.
This allows controlling the collection of statistics.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality.  Therefore, for now, a
corresponding QMP command is not considered worthwhile.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Significantly reorganized.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/monitor.c | 70 ++++++++++++++++++++++++++++++++++++++++++++-
 hmp-commands.hx     | 15 ++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 093efe9714..370fea883c 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -12,11 +12,15 @@
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
+#include "tcg/tb-stats.h"
+#include "exec/tb-flush.h"
 #include "internal-common.h"
 #include "tb-context.h"
 
@@ -235,10 +239,74 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+static void tb_stats_init_safe(CPUState *cpu, run_on_cpu_data icmd)
+{
+    uint32_t flags = icmd.host_int;
+
+    tb_stats_init(flags);
+    tb_flush(cpu);
+}
+
+static void hmp_tbstats(Monitor *mon, const QDict *qdict)
+{
+    uint32_t flags = TB_STATS_NONE;
+    const char *cmd;
+
+    if (!tcg_enabled()) {
+        monitor_printf(mon, "Only available with accel=tcg\n");
+        return;
+    }
+
+    cmd = qdict_get_try_str(qdict, "command");
+
+    if (strcmp(cmd, "start") == 0) {
+        const char *sflag = qdict_get_try_str(qdict, "flag");
+
+        flags = TB_STATS_ALL;
+        if (sflag) {
+            if (strcmp(sflag, "all") == 0) {
+                flags = TB_STATS_ALL;
+            } else if (strcmp(sflag, "jit") == 0) {
+                flags = TB_STATS_JIT;
+            } else if (strcmp(sflag, "exec") == 0) {
+                flags = TB_STATS_EXEC;
+            } else {
+                monitor_printf(mon, "Invalid argument to tb_stats start\n");
+                return;
+            }
+        }
+
+        if (tb_stats_enabled) {
+            monitor_printf(mon, "TB statistics already being recorded\n");
+            return;
+        }
+    } else if (strcmp(cmd, "stop") == 0) {
+        if (!tb_stats_enabled) {
+            monitor_printf(mon, "TB statistics not being recorded\n");
+            return;
+        }
+    } else if (strcmp(cmd, "status") == 0) {
+        if (tb_stats_enabled) {
+            monitor_printf(mon, "TB statistics are enabled:%s%s\n",
+                           tb_stats_enabled & TB_STATS_EXEC ? " EXEC" : "",
+                           tb_stats_enabled & TB_STATS_JIT ? " JIT" : "");
+        } else {
+            monitor_printf(mon, "TB statistics are disabled\n");
+        }
+        return;
+    } else {
+        monitor_printf(mon, "Invalid command\n");
+        return;
+    }
+
+    async_safe_run_on_cpu(first_cpu, tb_stats_init_safe,
+                          RUN_ON_CPU_HOST_INT(flags));
+}
+
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
     monitor_register_hmp_info_hrt("opcount", qmp_x_query_opcount);
+    monitor_register_hmp("tb_stats", false, hmp_tbstats);
 }
-
 type_init(hmp_tcg_register);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 63eac22734..e1d78ab69d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1673,6 +1673,21 @@ SRST
   Executes a qemu-io command on the given block device.
 ERST
 
+#if defined(CONFIG_TCG)
+    {
+        .name       = "tb_stats",
+        .args_type  = "command:s,flag:s?",
+        .params     = "command [flag]",
+        .help       = "Control tb statistics collection:"
+                        "tb_stats (start|stop|status) [all|jit|exec]",
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
-- 
2.34.1


