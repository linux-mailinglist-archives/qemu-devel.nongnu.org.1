Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898347E3F8A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:05:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlB-0008Jz-HT; Tue, 07 Nov 2023 08:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkP-00089d-H3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:05 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkN-0005xn-5O
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:01 -0500
Received: (qmail 31228 invoked by uid 484); 7 Nov 2023 13:03:56 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.073425 secs); 07 Nov 2023 13:03:56 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:55 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 10/20] mcdstub: state query added: this query collects
 information about the state of a specific core. This commit also includes
 mcd_vm_state_change,
 which is called when the cpu state changes because it collects data for the
 query
Date: Tue,  7 Nov 2023 14:03:13 +0100
Message-Id: <20231107130323.4126-11-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h |  41 +++++++++++++++
 mcdstub/mcdstub.c         | 103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index d38106e973..eb46917d00 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -36,6 +36,20 @@
 /* tcp query packet values templates */
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
 
+/* state strings */
+#define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
+#define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
+#define STATE_STR_RUNNING(d) "cpu " #d " running"
+#define STATE_STR_HALTED(d) "cpu " #d " currently halted"
+#define STATE_STR_INIT_HALTED "vm halted since boot"
+#define STATE_STR_INIT_RUNNING "vm running since boot"
+#define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STEP_PERFORMED "stopped beacuse of single step"
+#define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
+#define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
+#define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at " #d
+#define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
+
 typedef struct MCDProcess {
     uint32_t pid;
     bool attached;
@@ -67,6 +81,12 @@ enum RSState {
     RS_DATAEND,
 };
 
+typedef struct breakpoint_st {
+    uint32_t type;
+    uint64_t address;
+    uint32_t id;
+} breakpoint_st;
+
 typedef struct mcd_trigger_into_st {
     char type[ARGUMENT_STRING_LENGTH];
     char option[ARGUMENT_STRING_LENGTH];
@@ -74,6 +94,17 @@ typedef struct mcd_trigger_into_st {
     uint32_t nr_trigger;
 } mcd_trigger_into_st;
 
+typedef struct mcd_cpu_state_st {
+    const char *state;
+    bool memory_changed;
+    bool registers_changed;
+    bool target_was_stopped;
+    uint32_t bp_type;
+    uint64_t bp_address;
+    const char *stop_str;
+    const char *info_str;
+} mcd_cpu_state_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -506,6 +537,16 @@ void handle_close_core(GArray *params, void *user_ctx);
  */
 void handle_open_server(GArray *params, void *user_ctx);
 
+/**
+ * handle_query_state() - Handler for the state query.
+ *
+ * This function collects all data stored in the
+ * cpu_state member of the mcdserver_state and formats and sends it to the
+ * library.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_state(GArray *params, void *user_ctx);
+
 /* helpers */
 
 /**
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index ca98d01ee7..657f80d2a2 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -95,6 +95,15 @@ void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
     mcd_query_cmds_table[cmd_number] = query_cores;
     cmd_number++;
 
+
+    MCDCmdParseEntry query_state = {
+        .handler = handle_query_state,
+        .cmd = QUERY_ARG_STATE,
+    };
+    strcpy(query_state.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_state;
+}
+
 void reset_mcdserver_state(void)
 {
     g_free(mcdserver_state.processes);
@@ -605,6 +614,100 @@ void mcd_sigterm_handler(int signal)
 }
 #endif
 
+void mcd_vm_state_change(void *opaque, bool running, RunState state)
+{
+    CPUState *cpu = mcdserver_state.c_cpu;
+
+    if (mcdserver_state.state == RS_INACTIVE) {
+        return;
+    }
+
+    if (cpu == NULL) {
+        if (running) {
+            /*
+             * this is the case if qemu starts the vm
+             * before a mcd client is connected
+             */
+            const char *mcd_state;
+            mcd_state = CORE_STATE_RUNNING;
+            const char *info_str;
+            info_str = STATE_STR_INIT_RUNNING;
+            mcdserver_state.cpu_state.state = mcd_state;
+            mcdserver_state.cpu_state.info_str = info_str;
+        }
+        return;
+    }
+
+    const char *mcd_state;
+    const char *stop_str;
+    const char *info_str;
+    uint32_t bp_type = 0;
+    uint64_t bp_address = 0;
+    switch (state) {
+    case RUN_STATE_RUNNING:
+        mcd_state = CORE_STATE_RUNNING;
+        info_str = STATE_STR_RUNNING(cpu->cpu_index);
+        stop_str = "";
+        break;
+    case RUN_STATE_DEBUG:
+        mcd_state = CORE_STATE_DEBUG;
+        info_str = STATE_STR_DEBUG(cpu->cpu_index);
+        if (cpu->watchpoint_hit) {
+            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
+            case BP_MEM_READ:
+                bp_type = MCD_BREAKPOINT_READ;
+                stop_str = STATE_STR_BREAK_READ(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_WRITE:
+                bp_type = MCD_BREAKPOINT_WRITE;
+                stop_str = STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_ACCESS:
+                bp_type = MCD_BREAKPOINT_RW;
+                stop_str = STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitaddr);
+                break;
+            default:
+                stop_str = STATE_STR_BREAK_UNKNOWN;
+                break;
+            }
+            bp_address = cpu->watchpoint_hit->hitaddr;
+            cpu->watchpoint_hit = NULL;
+        } else if (cpu->singlestep_enabled) {
+            /* we land here when a single step is performed */
+            stop_str = STATE_STEP_PERFORMED;
+        } else {
+            bp_type = MCD_BREAKPOINT_HW;
+            stop_str = STATE_STR_BREAK_HW;
+            tb_flush(cpu);
+        }
+        /* deactivate single step */
+        cpu_single_step(cpu, 0);
+        break;
+    case RUN_STATE_PAUSED:
+        info_str = STATE_STR_HALTED(cpu->cpu_index);
+        mcd_state = CORE_STATE_HALTED;
+        stop_str = "";
+        break;
+    case RUN_STATE_WATCHDOG:
+        info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state = CORE_STATE_UNKNOWN;
+        stop_str = "";
+        break;
+    default:
+        info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state = CORE_STATE_UNKNOWN;
+        stop_str = "";
+        break;
+    }
+
+    /* set state for c_cpu */
+    mcdserver_state.cpu_state.state = mcd_state;
+    mcdserver_state.cpu_state.bp_type = bp_type;
+    mcdserver_state.cpu_state.bp_address = bp_address;
+    mcdserver_state.cpu_state.stop_str = stop_str;
+    mcdserver_state.cpu_state.info_str = info_str;
+}
+
 int mcd_put_packet(const char *buf)
 {
     return mcd_put_packet_binary(buf, strlen(buf));
-- 
2.34.1


