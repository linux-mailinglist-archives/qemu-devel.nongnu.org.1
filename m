Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C77BB3E2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognG-00089F-Hk; Fri, 06 Oct 2023 05:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognD-00088e-NS
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:43 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogn8-0000wf-Fa
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:43 -0400
Received: (qmail 19580 invoked by uid 484); 6 Oct 2023 09:06:26 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.082053 secs); 06 Oct 2023 09:06:26 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:25 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 11/29] query for the VM state added
Date: Fri,  6 Oct 2023 11:05:52 +0200
Message-Id: <20231006090610.26171-12-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          |  54 ++++++++-
 mcdstub/mcd_shared_defines.h |  13 ++
 mcdstub/mcdstub.c            | 229 ++++++++++++++++++++++++++++-------
 3 files changed, 249 insertions(+), 47 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 0de8d8fd07..2c64cfc0f9 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -22,6 +22,21 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
+typedef uint32_t mcd_core_event_et;
+enum {
+	MCD_CORE_EVENT_NONE            = 0x00000000,   /**< No since the last poll.                                 */
+	MCD_CORE_EVENT_MEMORY_CHANGE   = 0x00000001,   /**< Memory content has changed.                             */
+	MCD_CORE_EVENT_REGISTER_CHANGE = 0x00000002,   /**< Register contents have changed.                         */
+	MCD_CORE_EVENT_TRACE_CHANGE    = 0x00000004,   /**< Trace contents or states have changed.                  */
+	MCD_CORE_EVENT_TRIGGER_CHANGE  = 0x00000008,   /**< Triggers or trigger states have changed.                */
+	MCD_CORE_EVENT_STOPPED         = 0x00000010,   /**< Target was stopped at least once since the last poll,
+		it may already be running again.                        */
+	MCD_CORE_EVENT_CHL_PENDING     = 0x00000020,   /**< A target communication channel request from the target
+		is pending.                                             */
+	MCD_CORE_EVENT_CUSTOM_LO       = 0x00010000,   /**< Begin Range: User defined core events.                  */
+	MCD_CORE_EVENT_CUSTOM_HI       = 0x40000000,   /**< End   Range: User defined core events.                  */
+};
+
 // schema defines
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
@@ -34,13 +49,25 @@
 #define RESET_MEMORY "memory_reset"
 
 // more
-#define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the end
-#define CMD_SCHEMA_LENGTH 3
-#define MAX_SCHEMA_ARGS CMD_SCHEMA_LENGTH-1
+#define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the end
+#define CMD_SCHEMA_LENGTH 2
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
 
+// state strings
+#define STATE_STR_UNKNOWN(d) "cpu " #d " in unknown state"
+#define STATE_STR_DEBUG(d) "cpu " #d " in debug state"
+#define STATE_STR_RUNNING(d) "cpu " #d " running"
+#define STATE_STR_HALTED(d) "cpu " #d " currently halted"
+#define STATE_STR_INIT_HALTED "vm halted since boot"
+#define STATE_STR_INIT_RUNNING "vm running since boot"
+#define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
+#define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
+#define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at " #d
+#define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
+
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
     int base_reg;
@@ -113,6 +140,16 @@ typedef struct mcd_trigger_st {
     uint32_t nr_trigger;
 } mcd_trigger_st;
 
+typedef struct mcd_cpu_state_st {
+    const char *state;
+    bool memory_changed;
+    bool registers_changed;
+    bool target_was_stopped;
+    uint32_t trig_id;
+    const char *stop_str;
+    const char *info_str;
+} mcd_cpu_state_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -134,12 +171,15 @@ typedef struct MCDState {
     int supported_sstep_flags;
 
     // my stuff
+    RunState vm_current_state;
+    RunState vm_previous_state;
     uint32_t query_cpu_id;
     GList *all_memspaces;
     GList *all_reggroups;
     GList *all_registers;
     GArray *resets;
     mcd_trigger_st trigger;
+    mcd_cpu_state_st cpu_state;
     MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
 
@@ -254,9 +294,9 @@ void mcd_exit(int code);
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds);
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
-void handle_continue(GArray *params, void *user_ctx);
+void handle_vm_start(GArray *params, void *user_ctx);
+void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
-void mcd_append_thread_id(CPUState *cpu, GString *buf);
 int mcd_get_cpu_index(CPUState *cpu);
 CPUState* mcd_get_cpu(uint32_t i_cpu_index);
 void handle_query_cores(GArray *params, void *user_ctx);
@@ -269,7 +309,8 @@ void handle_query_reset_c(GArray *params, void *user_ctx);
 void handle_close_server(GArray *params, void *user_ctx);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
-void mcd_continue(void);
+void mcd_vm_start(void);
+void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
@@ -279,6 +320,7 @@ void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
 void handle_reset(GArray *params, void *user_ctx);
+void handle_query_state(GArray *params, void *user_ctx);
 
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 7e96129cdf..8cec2e9f23 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -7,6 +7,7 @@
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'c'
+#define TCP_CHAR_BREAK 'b'
 #define TCP_CHAR_QUERY 'q'
 #define TCP_CHAR_CLOSE_SERVER 'D'
 #define TCP_CHAR_CLOSE_CORE 'd'
@@ -33,6 +34,7 @@
 #define QUERY_ARG_MEMORY "memory"
 #define QUERY_ARG_REGGROUP "reggroup"
 #define QUERY_ARG_REG "reg"
+#define QUERY_ARG_STATE "state"
 
 // tcp query packet argument list
 #define TCP_ARGUMENT_NAME "name"
@@ -48,6 +50,11 @@
 #define TCP_ARGUMENT_MEMSPACEID "memspaceid"
 #define TCP_ARGUMENT_SIZE "size"
 #define TCP_ARGUMENT_THREAD "thread"
+#define TCP_ARGUMENT_TRIGGER_ID "trig_id"
+#define TCP_ARGUMENT_STOP_STRING "stop_str"
+#define TCP_ARGUMENT_INFO_STRING "info_str"
+#define TCP_ARGUMENT_STATE "state"
+#define TCP_ARGUMENT_EVENT "event"
 #define TCP_ARGUMENT_DEVICE "device"
 #define TCP_ARGUMENT_CORE "core"
 #define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
@@ -58,4 +65,10 @@
 // for packets sent to qemu
 #define ARGUMENT_SEPARATOR ';'
 
+// core states
+#define CORE_STATE_RUNNING "running"
+#define CORE_STATE_HALTED "halted"
+#define CORE_STATE_DEBUG "debug"
+#define CORE_STATE_UNKNOWN "unknown"
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 85e0c3a219..dc40a68338 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -68,6 +68,13 @@ void mcd_init_mcdserver_state(void)
 
     // init query table
     init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
+
+    // at this time the cpu hans't been started! -> set cpu_state
+    mcd_cpu_state_st cpu_state =  {
+            .state = CORE_STATE_HALTED,
+            .info_str = STATE_STR_INIT_HALTED,
+    };
+    mcdserver_state.cpu_state = cpu_state;
 }
 
 void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
@@ -156,6 +163,14 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
     };
     strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_regs_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_state = {
+        .handler = handle_query_state,
+        .cmd = QUERY_ARG_STATE,
+    };
+    strcpy(query_state.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_state;
 }
 
 void reset_mcdserver_state(void)
@@ -336,6 +351,7 @@ void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
 	
     for (i = 0; i < size; i++) {
         mcd_read_byte(buf[i]);
+        if (buf[i]==0) break;
     }
 }
 
@@ -366,12 +382,12 @@ void mcd_read_byte(uint8_t ch)
             return;
         }
     }
-    if (runstate_is_running()) {
+    //if (runstate_is_running()) {
         /* when the CPU is running, we cannot do anything except stop
            it when receiving a char */
-        vm_stop(RUN_STATE_PAUSED);
-    }
-    else {
+        //vm_stop(RUN_STATE_PAUSED);
+    //}
+    //else {
         switch(mcdserver_state.state) {
         case RS_IDLE:
             if (ch == TCP_COMMAND_START) {
@@ -434,7 +450,7 @@ void mcd_read_byte(uint8_t ch)
         default:
             abort();
         }
-    }
+    //}
 }
 
 int mcd_handle_packet(const char *line_buf)
@@ -457,12 +473,22 @@ int mcd_handle_packet(const char *line_buf)
         // go command
         {
             static MCDCmdParseEntry go_cmd_desc = {
-                .handler = handle_continue,
+                .handler = handle_vm_start,
             };
             go_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_GO, '\0' };
             cmd_parser = &go_cmd_desc;
         }
         break;
+    case TCP_CHAR_BREAK:
+        // go command
+        {
+            static MCDCmdParseEntry break_cmd_desc = {
+                .handler = handle_vm_stop,
+            };
+            break_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_BREAK, '\0' };
+            cmd_parser = &break_cmd_desc;
+        }
+        break;
     case TCP_CHAR_KILLQEMU:
         // kill qemu completely
         error_report("QEMU: Terminated via MCDstub");
@@ -514,7 +540,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_reset,
             };
             reset_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_RESET, '\0' };
-            strcpy(reset_cmd_desc.schema, (char[3]) { (char) ARG_SCHEMA_INT, ARG_SCHEMA_INT, '\0' });
+            strcpy(reset_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_INT, '\0' });
             cmd_parser = &reset_cmd_desc;
         }
         break;
@@ -532,16 +558,14 @@ int mcd_handle_packet(const char *line_buf)
     return RS_IDLE;
 }
 
-void handle_continue(GArray *params, void *user_ctx)
-{
-    /*
-    if (params->len) {
-        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
-    }
+void handle_vm_start(GArray *params, void *user_ctx) {
+    // todo add partial restart with arguments and so on
+    mcd_vm_start();
+}
 
-    mcdserver_state.signal = 0;
-    gdb_continue();
-    */
+void handle_vm_stop(GArray *params, void *user_ctx) {
+    // todo add partial stop with arguments and so on
+    mcd_vm_stop();
 }
 
 void handle_gen_query(GArray *params, void *user_ctx)
@@ -576,7 +600,7 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
 int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     
     char data_buffer[64] = {0};
-    char *separator = strchr(data_buffer, ARGUMENT_SEPARATOR);
+    char *separator = strchr(data, ARGUMENT_SEPARATOR);
     int seperator_index = (int)(separator - data);
 
     if (separator) {
@@ -586,25 +610,29 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     else {
         strncpy(data_buffer, data, strlen(data));
     }
-    for (int i = 0; i<MAX_SCHEMA_ARGS; i++) {
-        MCDCmdVariant this_param;
-        if (schema[i] == ARG_SCHEMA_STRING) {
-            this_param.data = data_buffer;
+    for (int i = 0; i<strlen(schema); i++) {
+        MCDCmdVariant this_param; 
+        switch (schema[i]) {
+        case ARG_SCHEMA_STRING:
+            this_param.data = data;
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] == ARG_SCHEMA_INT) {
+            break;
+        case ARG_SCHEMA_INT:
             this_param.data_int = atoi(data_buffer);
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] == ARG_SCHEMA_QRYHANDLE) {
+            break;
+        case ARG_SCHEMA_QRYHANDLE:
             this_param.query_handle = atoi(data_buffer);
             g_array_append_val(params, this_param);
-        }
-        else if (schema[i] == ARG_SCHEMA_CORENUM) {
+            break;
+        case ARG_SCHEMA_CORENUM:
             this_param.cpu_id = atoi(data_buffer);
             g_array_append_val(params, this_param);
+            break;
+        default:
+            return -1;
         }
-
+        
         if (separator) {
             // we got two arguments
             strncpy(data_buffer, &data[seperator_index+1], strlen(&data[seperator_index+1]));
@@ -633,7 +661,7 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
         }
 
         // if a schema is provided we need to extract parameters from the data string
-        if (cmd->schema) {
+        if (strlen(cmd->schema)) {
             // this only gets the data from data beginning after the command name
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params)) {
                 return -1;
@@ -679,7 +707,7 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
 
         s->c_cpu = mcd_first_attached_cpu();
 
-        vm_stop(RUN_STATE_PAUSED);
+        //vm_stop(RUN_STATE_PAUSED);
 		//TODO: this might not be necessary
         //replay_gdb_attached();
         //gdb_has_xml = false;
@@ -709,14 +737,98 @@ void mcd_sigterm_handler(int signal)
 
 void mcd_vm_state_change(void *opaque, bool running, RunState state)
 {
-	printf("this calls state_change\n");
+	CPUState *cpu = mcdserver_state.c_cpu;
+
+    // update cpu state
+    mcdserver_state.vm_previous_state = mcdserver_state.vm_current_state;
+    mcdserver_state.vm_current_state = state;
+
+    if (mcdserver_state.state == RS_INACTIVE) {
+        return;
+    }
+
+    if (cpu == NULL) {
+        if (running) {
+            // this is the case if qemu starts the vm before any mcd is connected
+            const char *mcd_state;
+            mcd_state = CORE_STATE_RUNNING;
+            const char *info_str;
+            info_str = STATE_STR_INIT_RUNNING;
+            mcdserver_state.cpu_state.state = mcd_state;
+            mcdserver_state.cpu_state.state = info_str;
+        }
+        return;
+    }
+
+    const char *mcd_state;
+    const char *stop_str;
+    const char *info_str;
+    uint32_t trig_id = 0;
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
+                trig_id = MCD_TRIG_TYPE_READ;
+                stop_str = STATE_STR_BREAK_READ(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_WRITE:
+                trig_id = MCD_TRIG_TYPE_WRITE;
+                stop_str = STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hitaddr);
+                break;
+            case BP_MEM_ACCESS:
+                trig_id = MCD_TRIG_TYPE_RW;
+                stop_str = STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitaddr);
+                break;
+            default:
+                break;
+                stop_str = STATE_STR_BREAK_UNKNOWN;
+            }
+            cpu->watchpoint_hit = NULL;
+        } else {
+            // "hardware" breakpoint hit!
+            trig_id = MCD_TRIG_TYPE_IP;
+            stop_str = STATE_STR_BREAK_HW;
+            tb_flush(cpu);
+        }
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
+        printf("runstate watchdog hit\n");
+        break;
+    default:
+        info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
+        mcd_state = CORE_STATE_UNKNOWN;
+        stop_str = "";
+        // we don't care;
+        break;
+    }
+
+    mcdserver_state.cpu_state.state = mcd_state;
+    mcdserver_state.cpu_state.trig_id = trig_id;
+    mcdserver_state.cpu_state.stop_str = stop_str;
+    mcdserver_state.cpu_state.info_str = info_str;
+
+    /* disable single step if it was enabled */
+    cpu_single_step(cpu, 0);
 }
 
 int mcd_put_packet(const char *buf)
 {
-	//tracing
-    //trace_gdbstub_io_reply(buf);
-
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
 
@@ -1267,6 +1379,7 @@ void handle_open_core(GArray *params, void *user_ctx) {
     // get the cpu whith the given id
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcdserver_state.c_cpu = cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
     int return_value = 0;
@@ -1318,6 +1431,7 @@ void handle_open_core(GArray *params, void *user_ctx) {
         // we don't support other architectures
         assert(0);
     }
+
     g_free(arch);
 }
 
@@ -1367,10 +1481,13 @@ void handle_close_core(GArray *params, void *user_ctx) {
     // free memory for correct core
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    mcdserver_state.all_memspaces = g_list_remove(mcdserver_state.all_memspaces, memspaces);
     g_array_free(memspaces, TRUE);
     GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    mcdserver_state.all_reggroups = g_list_remove(mcdserver_state.all_reggroups, reggroups);
     g_array_free(reggroups, TRUE);
     GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    mcdserver_state.all_registers = g_list_remove(mcdserver_state.all_registers, registers);
     g_array_free(registers, TRUE);
 }
 
@@ -1395,7 +1512,7 @@ void handle_close_server(GArray *params, void *user_ctx) {
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
-        mcd_continue();
+        mcd_vm_start();
     }
 }
 
@@ -1407,13 +1524,19 @@ void handle_query_trigger(GArray *params, void *user_ctx) {
     mcd_put_strbuf();
 }
 
-void mcd_continue(void)
-{
-    if (!runstate_needs_reset()) {
+void mcd_vm_start(void) {
+    if (!runstate_needs_reset() && !runstate_is_running()) {
         vm_start();
     }
 }
 
+void mcd_vm_stop(void) {
+    if (runstate_is_running()) {
+        //might want to have DEBUG state here but idk
+        vm_stop(RUN_STATE_PAUSED);
+    }
+}
+
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
     // 1. get correct memspaces and set the query_cpu
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
@@ -1563,9 +1686,33 @@ void handle_query_regs_c(GArray *params, void *user_ctx) {
 
 void handle_reset(GArray *params, void *user_ctx) {
     int reset_id = get_param(params, 0)->data_int;
-    int bool_halt_after_reset = get_param(params, 1)->data_int;
-    if (reset_id>=0 && bool_halt_after_reset) {
+    //int bool_halt_after_reset = get_param(params, 1)->data_int;
+    if (reset_id>=0) {
         //fun for the compiler
     }
-    
+}
+
+void handle_query_state(GArray *params, void *user_ctx) {
+    // send state from correct core
+    //uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    // get state info
+    mcd_cpu_state_st state_info = mcdserver_state.cpu_state;
+    mcd_core_event_et event = MCD_CORE_EVENT_NONE;
+    if (state_info.memory_changed) {
+        event = event | MCD_CORE_EVENT_MEMORY_CHANGE;
+        state_info.memory_changed = false;
+    }
+    if (state_info.registers_changed) {
+        event = event | MCD_CORE_EVENT_REGISTER_CHANGE;
+        state_info.registers_changed = false;
+    }
+    if (state_info.target_was_stopped) {
+        event = event | MCD_CORE_EVENT_STOPPED;
+        state_info.target_was_stopped = false;
+    }
+    // send data
+    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%s.%s=%s.", TCP_ARGUMENT_STATE, state_info.state,
+        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0, TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_STOP_STRING, state_info.stop_str, TCP_ARGUMENT_INFO_STRING, state_info.info_str);
+    mcd_put_strbuf();
 }
-- 
2.34.1


