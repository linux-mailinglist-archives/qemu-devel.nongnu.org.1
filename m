Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F90F7BB3F4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognu-0000LJ-6t; Fri, 06 Oct 2023 05:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognR-0008EL-3e
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:58 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognO-00010O-16
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:55 -0400
Received: (qmail 19808 invoked by uid 484); 6 Oct 2023 09:06:41 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.088364 secs); 06 Oct 2023 09:06:41 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:40 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 18/29] making step and go handlers core-specific
Date: Fri,  6 Oct 2023 11:05:59 +0200
Message-Id: <20231006090610.26171-19-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

From: neder <nicolas.eder@lauterbach.com>

---
 mcdstub/mcdstub.c | 26 ++++++++++++++++++++++----
 mcdstub/mcdstub.h |  3 ++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 4327703bca..8fc95d96a4 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -434,6 +434,8 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_vm_start,
             };
             go_cmd_desc.cmd = (char[2]) { TCP_CHAR_GO, '\0' };
+            strcpy(go_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &go_cmd_desc;
         }
         break;
@@ -606,7 +608,9 @@ int mcd_handle_packet(const char *line_buf)
 void handle_vm_start(GArray *params, void *user_ctx)
 {
     /* TODO: add partial restart with arguments and so on */
-    mcd_vm_start();
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcd_cpu_start(cpu);
 }
 
 void handle_vm_step(GArray *params, void *user_ctx)
@@ -615,7 +619,7 @@ void handle_vm_step(GArray *params, void *user_ctx)
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    int return_value = mcd_vm_sstep(cpu);
+    int return_value = mcd_cpu_sstep(cpu);
     if (return_value != 0) {
         g_assert_not_reached();
     }
@@ -1619,11 +1623,25 @@ void mcd_vm_start(void)
     }
 }
 
-int mcd_vm_sstep(CPUState *cpu)
+void mcd_cpu_start(CPUState *cpu)
+{
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(false)) {
+        mcdserver_state.c_cpu = cpu;
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
+}
+
+int mcd_cpu_sstep(CPUState *cpu)
 {
     mcdserver_state.c_cpu = cpu;
     cpu_single_step(cpu, mcdserver_state.sstep_flags);
-    mcd_vm_start();
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(true)) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
     return 0;
 }
 
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index c2bdaee410..ab44252ba0 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -289,7 +289,8 @@ void handle_close_server(GArray *params, void *user_ctx);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_vm_start(void);
-int mcd_vm_sstep(CPUState *cpu);
+void mcd_cpu_start(CPUState *cpu);
+int mcd_cpu_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
-- 
2.34.1


