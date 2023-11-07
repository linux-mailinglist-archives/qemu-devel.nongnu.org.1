Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F257E3FC1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:10:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmg-0001v0-3z; Tue, 07 Nov 2023 08:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkl-0008Gn-0W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:26 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0005sV-DI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:22 -0500
Received: (qmail 31102 invoked by uid 484); 7 Nov 2023 13:03:50 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.151891 secs); 07 Nov 2023 13:03:50 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:47 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 06/20] mcdstub: open/close server functions and
 trigger/reset data added. User for initial connection with an mcd client
Date: Tue,  7 Nov 2023 14:03:09 +0100
Message-Id: <20231107130323.4126-7-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h | 84 ++++++++++++++++++++++++++++++++++++
 mcdstub/mcdstub.c         | 90 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 1461d0e1cb..c7e34673a6 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -7,6 +7,24 @@
 #include "mcdstub_common.h"
 
 #define MAX_PACKET_LENGTH 1024
+
+/* trigger defines */
+#define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
+#define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
+
+/* schema defines */
+#define ARG_SCHEMA_QRYHANDLE 'q'
+#define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_INT 'd'
+#define ARG_SCHEMA_UINT64_T 'l'
+#define ARG_SCHEMA_CORENUM 'c'
+#define ARG_SCHEMA_HEXDATA 'h'
+
+/* resets */
+#define RESET_SYSTEM "full_system_reset"
+#define RESET_GPR "gpr_reset"
+#define RESET_MEMORY "memory_reset"
+
 /* misc */
 #define QUERY_TOTAL_NUMBER 12
 #define CMD_SCHEMA_LENGTH 6
@@ -49,6 +67,13 @@ enum RSState {
     RS_DATAEND,
 };
 
+typedef struct mcd_trigger_into_st {
+    char type[ARGUMENT_STRING_LENGTH];
+    char option[ARGUMENT_STRING_LENGTH];
+    char action[ARGUMENT_STRING_LENGTH];
+    uint32_t nr_trigger;
+} mcd_trigger_into_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -81,6 +106,11 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
 
+typedef struct mcd_reset_st {
+    const char *name;
+    uint8_t id;
+} mcd_reset_st;
+
 #ifndef _WIN32
 void mcd_sigterm_handler(int signal);
 #endif
@@ -109,6 +139,38 @@ void mcd_init_mcdserver_state(void);
  * @mcd_query_cmds_table: Lookup table with all query commands.
  */
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
+
+/**
+ * init_resets() - Initializes the resets info.
+ *
+ * This function currently only adds all theoretical possible resets to the
+ * resets GArray. None of the resets work at the moment. The resets are:
+ * "full_system_reset", "gpr_reset" and "memory_reset".
+ * @resets: GArray with possible resets.
+ */
+int init_resets(GArray *resets);
+
+/**
+ * init_trigger() - Initializes the trigger info.
+ *
+ * This function adds the types of trigger, their possible options and actions
+ * to the trigger struct.
+ * @trigger: Struct with all trigger info.
+ */
+int init_trigger(mcd_trigger_into_st *trigger);
+
+/**
+ * mcd_init_debug_class() - initialize mcd-specific DebugClass
+ */
+void mcd_init_debug_class(void);
+
+/**
+ * reset_mcdserver_state() - Resets the mcdserver_state struct.
+ *
+ * This function deletes all processes connected to the mcdserver_state.
+ */
+void reset_mcdserver_state(void);
+
 /**
  * create_processes() - Sorts all processes and calls
  * :c:func:`mcd_create_default_process`.
@@ -357,6 +419,28 @@ CPUState *get_first_cpu_in_process(MCDProcess *process);
  * @thread_id: ID of the desired CPU.
  */
 CPUState *find_cpu(uint32_t thread_id);
+
+/**
+ * handle_close_server() - Handler for closing the MCD server.
+ *
+ * This function detaches the debugger (process) and frees up memory.
+ * Then it start the QEMU VM with :c:func:`mcd_vm_start`.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_close_server(GArray *params, void *user_ctx);
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
+void handle_open_server(GArray *params, void *user_ctx);
+
 /* helpers */
 
 /**
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 6900dcd0ea..d2f6df04c0 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -331,6 +331,25 @@ int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
+    case TCP_CHAR_OPEN_SERVER:
+        {
+            static MCDCmdParseEntry open_server_cmd_desc = {
+                .handler = handle_open_server,
+            };
+            open_server_cmd_desc.cmd = (char[2]) { TCP_CHAR_OPEN_SERVER, '\0' };
+            cmd_parser = &open_server_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_CLOSE_SERVER:
+        {
+            static MCDCmdParseEntry close_server_cmd_desc = {
+                .handler = handle_close_server,
+            };
+            close_server_cmd_desc.cmd =
+                (char[2]) { TCP_CHAR_CLOSE_SERVER, '\0' };
+            cmd_parser = &close_server_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -658,3 +677,74 @@ int int_cmp(gconstpointer a, gconstpointer b)
         return 1;
     }
 }
+
+int init_resets(GArray *resets)
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
+int init_trigger(mcd_trigger_into_st *trigger)
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
+void handle_open_server(GArray *params, void *user_ctx)
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
+
+void handle_close_server(GArray *params, void *user_ctx)
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
-- 
2.34.1


