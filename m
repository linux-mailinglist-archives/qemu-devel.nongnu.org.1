Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C07E3F9F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmz-0002pb-Df; Tue, 07 Nov 2023 08:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Ll2-00009H-3G
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:42 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkr-00061V-QS
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:34 -0500
Received: (qmail 31401 invoked by uid 484); 7 Nov 2023 13:04:09 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.316025 secs); 07 Nov 2023 13:04:09 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:07 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 15/20] mcdstub: added go,
 break and step functionality and all corresponding functions
Date: Tue,  7 Nov 2023 14:03:18 +0100
Message-Id: <20231107130323.4126-16-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

---
 include/mcdstub/mcdstub.h |  53 ++++++++++++++++++++
 mcdstub/mcdstub.c         | 101 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 85ca8b3b62..0375cf7311 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -439,6 +439,33 @@ int process_string_cmd(void *user_ctx, const char *data,
  */
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 
+/**
+ * handle_vm_start() - Handler for the VM start TCP packet.
+ *
+ * Evaluates whether all cores or just a perticular core should get started and
+ * calls :c:func:`mcd_vm_start` or :c:func:`mcd_cpu_start` respectively.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_vm_start(GArray *params, void *user_ctx);
+
+/**
+ * handle_vm_step() - Handler for the VM step TCP packet.
+ *
+ * Calls :c:func:`mcd_cpu_sstep` for the CPU which sould be stepped.
+ * Stepping all CPUs is currently not supported.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_vm_step(GArray *params, void *user_ctx);
+
+/**
+ * handle_vm_stop() - Handler for the VM stop TCP packet.
+ *
+ * Always calls :c:func:`mcd_vm_stop` and stops all cores. Stopping individual
+ * cores is currently not supported.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_vm_stop(GArray *params, void *user_ctx);
+
 /**
  * handle_gen_query() - Handler for all TCP query packets.
  *
@@ -550,6 +577,32 @@ void handle_close_core(GArray *params, void *user_ctx);
  */
 void handle_query_trigger(GArray *params, void *user_ctx);
 
+/**
+ * mcd_vm_start() - Starts all CPUs with the vm_start function.
+ */
+void mcd_vm_start(void);
+
+/**
+ * mcd_cpu_start() - Starts the selected CPU with the cpu_resume function.
+ *
+ * @cpu: The CPU about to be started.
+ */
+void mcd_cpu_start(CPUState *cpu);
+
+/**
+ * mcd_cpu_sstep() - Performes a step on the selected CPU.
+ *
+ * This function first sets the correct single step flags for the CPU with
+ * cpu_single_step and then starts the CPU with cpu_resume.
+ * @cpu: The CPU about to be stepped.
+ */
+int mcd_cpu_sstep(CPUState *cpu);
+
+/**
+ * mcd_vm_stop() - Brings all CPUs in debug state with the vm_stop function.
+ */
+void mcd_vm_stop(void);
+
 /**
  * handle_query_reg_groups_f() - Handler for the first register group query.
  *
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index cd2f5db8e4..6313459bac 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -432,6 +432,37 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &open_server_cmd_desc;
         }
         break;
+    case TCP_CHAR_GO:
+        {
+            static MCDCmdParseEntry go_cmd_desc = {
+                .handler = handle_vm_start,
+            };
+            go_cmd_desc.cmd = (char[2]) { TCP_CHAR_GO, '\0' };
+            strcpy(go_cmd_desc.schema,
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &go_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_STEP:
+        {
+            static MCDCmdParseEntry step_cmd_desc = {
+                .handler = handle_vm_step,
+            };
+            step_cmd_desc.cmd = (char[2]) { TCP_CHAR_STEP, '\0' };
+            strcpy(step_cmd_desc.schema,
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &step_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_BREAK:
+        {
+            static MCDCmdParseEntry break_cmd_desc = {
+                .handler = handle_vm_stop,
+            };
+            break_cmd_desc.cmd = (char[2]) { TCP_CHAR_BREAK, '\0' };
+            cmd_parser = &break_cmd_desc;
+        }
+        break;
     case TCP_CHAR_KILLQEMU:
         /* kill qemu completely */
         error_report("QEMU: Terminated via MCDstub");
@@ -494,6 +525,40 @@ int mcd_handle_packet(const char *line_buf)
     return RS_IDLE;
 }
 
+void handle_vm_start(GArray *params, void *user_ctx)
+{
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        mcd_vm_start();
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        mcd_cpu_start(cpu);
+    }
+}
+
+void handle_vm_step(GArray *params, void *user_ctx)
+{
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        /* TODO: add multicore support */
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        int return_value = mcd_cpu_sstep(cpu);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
+    }
+}
+
+
+void handle_vm_stop(GArray *params, void *user_ctx)
+{
+    /* TODO: add core dependant break option */
+    mcd_vm_stop();
+}
+
 void handle_gen_query(GArray *params, void *user_ctx)
 {
     if (!params->len) {
@@ -1286,6 +1351,42 @@ void handle_query_trigger(GArray *params, void *user_ctx)
     mcd_put_strbuf();
 }
 
+void mcd_vm_start(void)
+{
+    if (!runstate_needs_reset() && !runstate_is_running()) {
+        vm_start();
+    }
+}
+
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
+{
+    mcdserver_state.c_cpu = cpu;
+    cpu_single_step(cpu, mcdserver_state.sstep_flags);
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(true)) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+        cpu_resume(cpu);
+    }
+    return 0;
+}
+
+void mcd_vm_stop(void)
+{
+    if (runstate_is_running()) {
+        vm_stop(RUN_STATE_DEBUG);
+    }
+}
+
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx)
 {
     /* 1. get correct memspaces and set the query_cpu */
-- 
2.34.1


