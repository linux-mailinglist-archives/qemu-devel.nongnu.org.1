Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3581A516
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP4-0000Q2-OI; Wed, 20 Dec 2023 11:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOx-0000Mq-EB
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:31 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOr-0004jn-LO
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:29 -0500
Received: (qmail 15324 invoked by uid 484); 20 Dec 2023 16:26:19 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 5e-06 secs); 20 Dec 2023 16:26:19 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:17 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 10/18] mcdstub: open and close server functions added
Date: Wed, 20 Dec 2023 17:25:47 +0100
Message-Id: <20231220162555.19545-11-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 299 ++++++++++++++++++++++++++++------------
 1 file changed, 214 insertions(+), 85 deletions(-)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index 642f3c2826..45daa38689 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -65,6 +65,91 @@ static void mcd_sigterm_handler(int signal)
 }
 #endif
 
+/**
+ * mcd_get_process() - Returns the process of the provided pid.
+ *
+ * @pid: The process ID.
+ */
+static MCDProcess *mcd_get_process(uint32_t pid)
+{
+    int i;
+
+    if (!pid) {
+        /* 0 means any process, we take the first one */
+        return &mcdserver_state.processes[0];
+    }
+
+    for (i = 0; i < mcdserver_state.process_num; i++) {
+        if (mcdserver_state.processes[i].pid == pid) {
+            return &mcdserver_state.processes[i];
+        }
+    }
+
+    return NULL;
+}
+
+/**
+ * mcd_get_cpu_pid() - Returns the process ID of the provided CPU.
+ *
+ * @cpu: The CPU state.
+ */
+static uint32_t mcd_get_cpu_pid(CPUState *cpu)
+{
+    if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
+        /* Return the default process' PID */
+        int index = mcdserver_state.process_num - 1;
+        return mcdserver_state.processes[index].pid;
+    }
+    return cpu->cluster_index + 1;
+}
+
+/**
+ * mcd_get_cpu_process() - Returns the process of the provided CPU.
+ *
+ * @cpu: The CPU state.
+ */
+static MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
+    return mcd_get_process(mcd_get_cpu_pid(cpu));
+}
+
+/**
+ * mcd_next_attached_cpu() - Returns the first CPU with an attached process
+ * starting after the
+ * provided cpu.
+ *
+ * @cpu: The CPU to start from.
+ */
+static CPUState *mcd_next_attached_cpu(CPUState *cpu)
+{
+    cpu = CPU_NEXT(cpu);
+
+    while (cpu) {
+        if (mcd_get_cpu_process(cpu)->attached) {
+            break;
+        }
+
+        cpu = CPU_NEXT(cpu);
+    }
+
+    return cpu;
+}
+
+/**
+ * mcd_first_attached_cpu() - Returns the first CPU with an attached process.
+ */
+static CPUState *mcd_first_attached_cpu(void)
+{
+    CPUState *cpu = first_cpu;
+    MCDProcess *process = mcd_get_cpu_process(cpu);
+
+    if (!process->attached) {
+        return mcd_next_attached_cpu(cpu);
+    }
+
+    return cpu;
+}
+
 /**
  * mcd_vm_state_change() - Handles a state change of the QEMU VM.
  *
@@ -284,6 +369,117 @@ static void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
     }
 }
 
+/**
+ * init_resets() - Initializes the resets info.
+ *
+ * This function currently only adds all theoretical possible resets to the
+ * resets GArray. None of the resets work at the moment. The resets are:
+ * "full_system_reset", "gpr_reset" and "memory_reset".
+ * @resets: GArray with possible resets.
+ */
+static int init_resets(GArray *resets)
+{
+    mcd_reset_st system_reset = { .id = 0, .name = RESET_SYSTEM};
+    mcd_reset_st gpr_reset = { .id = 1, .name = RESET_GPR};
+    mcd_reset_st memory_reset = { .id = 2, .name = RESET_MEMORY};
+    g_array_append_vals(resets, (gconstpointer)&system_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&gpr_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&memory_reset, 1);
+    return 0;
+}
+
+/**
+ * init_trigger() - Initializes the trigger info.
+ *
+ * This function adds the types of trigger, their possible options and actions
+ * to the trigger struct.
+ * @trigger: Struct with all trigger info.
+ */
+static int init_trigger(mcd_trigger_into_st *trigger)
+{
+    snprintf(trigger->type, sizeof(trigger->type),
+        "%d,%d,%d,%d", MCD_BREAKPOINT_HW, MCD_BREAKPOINT_READ,
+        MCD_BREAKPOINT_WRITE, MCD_BREAKPOINT_RW);
+    snprintf(trigger->option, sizeof(trigger->option),
+        "%s", MCD_TRIG_OPT_VALUE);
+    snprintf(trigger->action, sizeof(trigger->action),
+        "%s", MCD_TRIG_ACT_BREAK);
+    /* there can be 16 breakpoints and 16 watchpoints each */
+    trigger->nr_trigger = 16;
+    return 0;
+}
+
+/**
+ * handle_open_server() - Handler for opening the MCD server.
+ *
+ * This is the first function that gets called from the MCD Shared Library.
+ * It initializes core indepent data with the :c:func:`init_resets` and
+ * \reg init_trigger functions. It also send the TCP_HANDSHAKE_SUCCESS
+ * packet back to the library to confirm the mcdstub is ready for further
+ * communication.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_open_server(GArray *params, void *user_ctx)
+{
+    /* initialize core-independent data */
+    int return_value = 0;
+    mcdserver_state.resets = g_array_new(false, true, sizeof(mcd_reset_st));
+    return_value = init_resets(mcdserver_state.resets);
+    if (return_value != 0) {
+        g_assert_not_reached();
+    }
+    return_value = init_trigger(&mcdserver_state.trigger);
+    if (return_value != 0) {
+        g_assert_not_reached();
+    }
+
+    mcd_put_packet(TCP_HANDSHAKE_SUCCESS);
+}
+
+/**
+ * mcd_vm_start() - Starts all CPUs with the vm_start function.
+ */
+static void mcd_vm_start(void)
+{
+    if (!runstate_needs_reset() && !runstate_is_running()) {
+        vm_start();
+    }
+}
+
+/**
+ * handle_close_server() - Handler for closing the MCD server.
+ *
+ * This function detaches the debugger (process) and frees up memory.
+ * Then it start the QEMU VM with :c:func:`mcd_vm_start`.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_close_server(GArray *params, void *user_ctx)
+{
+    uint32_t pid = 1;
+    MCDProcess *process = mcd_get_process(pid);
+
+    /*
+     * 1. free memory
+     * TODO: do this only if there are no processes attached anymore!
+     */
+    g_list_free(mcdserver_state.all_memspaces);
+    g_list_free(mcdserver_state.all_reggroups);
+    g_list_free(mcdserver_state.all_registers);
+    g_array_free(mcdserver_state.resets, TRUE);
+
+    /* 2. detach */
+    process->attached = false;
+
+    /* 3. reset process */
+    if (pid == mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
+        mcdserver_state.c_cpu = mcd_first_attached_cpu();
+    }
+    if (!mcdserver_state.c_cpu) {
+        /* no more processes attached */
+        mcd_vm_start();
+    }
+}
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -302,6 +498,24 @@ static int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
+    case TCP_CHAR_OPEN_SERVER:
+        {
+            static MCDCmdParseEntry open_server_cmd_desc = {
+                .handler = handle_open_server,
+                .cmd = {TCP_CHAR_OPEN_SERVER, '\0'},
+            };
+            cmd_parser = &open_server_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_CLOSE_SERVER:
+        {
+            static MCDCmdParseEntry close_server_cmd_desc = {
+                .handler = handle_close_server,
+                .cmd = {TCP_CHAR_CLOSE_SERVER, '\0'},
+            };
+            cmd_parser = &close_server_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -422,91 +636,6 @@ static void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-/**
- * mcd_get_process() - Returns the process of the provided pid.
- *
- * @pid: The process ID.
- */
-static MCDProcess *mcd_get_process(uint32_t pid)
-{
-    int i;
-
-    if (!pid) {
-        /* 0 means any process, we take the first one */
-        return &mcdserver_state.processes[0];
-    }
-
-    for (i = 0; i < mcdserver_state.process_num; i++) {
-        if (mcdserver_state.processes[i].pid == pid) {
-            return &mcdserver_state.processes[i];
-        }
-    }
-
-    return NULL;
-}
-
-/**
- * mcd_get_cpu_pid() - Returns the process ID of the provided CPU.
- *
- * @cpu: The CPU state.
- */
-static uint32_t mcd_get_cpu_pid(CPUState *cpu)
-{
-    if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
-        /* Return the default process' PID */
-        int index = mcdserver_state.process_num - 1;
-        return mcdserver_state.processes[index].pid;
-    }
-    return cpu->cluster_index + 1;
-}
-
-/**
- * mcd_get_cpu_process() - Returns the process of the provided CPU.
- *
- * @cpu: The CPU state.
- */
-static MCDProcess *mcd_get_cpu_process(CPUState *cpu)
-{
-    return mcd_get_process(mcd_get_cpu_pid(cpu));
-}
-
-/**
- * mcd_next_attached_cpu() - Returns the first CPU with an attached process
- * starting after the
- * provided cpu.
- *
- * @cpu: The CPU to start from.
- */
-static CPUState *mcd_next_attached_cpu(CPUState *cpu)
-{
-    cpu = CPU_NEXT(cpu);
-
-    while (cpu) {
-        if (mcd_get_cpu_process(cpu)->attached) {
-            break;
-        }
-
-        cpu = CPU_NEXT(cpu);
-    }
-
-    return cpu;
-}
-
-/**
- * mcd_first_attached_cpu() - Returns the first CPU with an attached process.
- */
-static CPUState *mcd_first_attached_cpu(void)
-{
-    CPUState *cpu = first_cpu;
-    MCDProcess *process = mcd_get_cpu_process(cpu);
-
-    if (!process->attached) {
-        return mcd_next_attached_cpu(cpu);
-    }
-
-    return cpu;
-}
-
 /**
  * mcd_chr_event() - Handles a TCP client connect.
  *
-- 
2.34.1


