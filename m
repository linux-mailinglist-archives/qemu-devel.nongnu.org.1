Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE937BB3ED
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognw-0000y7-LN; Fri, 06 Oct 2023 05:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognV-0008FJ-6t
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:02 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognR-00011h-98
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:59 -0400
Received: (qmail 19843 invoked by uid 484); 6 Oct 2023 09:06:45 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.245072 secs); 06 Oct 2023 09:06:45 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:42 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 19/29] adding trigger ID handling for TRACE32
Date: Fri,  6 Oct 2023 11:06:00 +0200
Message-Id: <20231006090610.26171-20-nicolas.eder@lauterbach.com>
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
 mcdstub/mcd_shared_defines.h |   2 +-
 mcdstub/mcdstub.c            | 101 +++++++++++++++++++++--------------
 mcdstub/mcdstub.h            |  29 ++++++----
 3 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 2e0831594a..88d556cab1 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -63,7 +63,7 @@
 #define TCP_ARGUMENT_MEMSPACEID "memspaceid"
 #define TCP_ARGUMENT_SIZE "size"
 #define TCP_ARGUMENT_THREAD "thread"
-#define TCP_ARGUMENT_TRIGGER_ID "trig_id"
+#define TCP_ARGUMENT_ADDRESS "address"
 #define TCP_ARGUMENT_STOP_STRING "stop_str"
 #define TCP_ARGUMENT_INFO_STRING "info_str"
 #define TCP_ARGUMENT_STATE "state"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 8fc95d96a4..bd532b0f4c 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -573,8 +573,8 @@ int mcd_handle_packet(const char *line_buf)
             handle_breakpoint_insert_cmd_desc.cmd =
                 (char[2]) { TCP_CHAR_BREAKPOINT_INSERT, '\0' };
             strcpy(handle_breakpoint_insert_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
-                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser = &handle_breakpoint_insert_cmd_desc;
         }
         break;
@@ -586,8 +586,8 @@ int mcd_handle_packet(const char *line_buf)
             handle_breakpoint_remove_cmd_desc.cmd =
                 (char[2]) { TCP_CHAR_BREAKPOINT_REMOVE, '\0' };
             strcpy(handle_breakpoint_remove_cmd_desc.schema,
-                (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
-                ARG_SCHEMA_UINT64_T, ARG_SCHEMA_UINT64_T, '\0' });
+                (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT,
+                ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser = &handle_breakpoint_remove_cmd_desc;
         }
         break;
@@ -671,6 +671,18 @@ uint64_t atouint64_t(const char *in)
     return res;
 }
 
+uint32_t atouint32_t(const char *in)
+{
+    uint32_t res = 0;
+    for (int i = 0; i < strlen(in); ++i) {
+        const char c = in[i];
+        res *= 10;
+        res += c - '0';
+    }
+
+    return res;
+}
+
 int cmd_parse_params(const char *data, const char *schema, GArray *params)
 {
 
@@ -705,7 +717,7 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params)
             g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
             break;
         case ARG_SCHEMA_INT:
-            this_param.data_int = atoi(data_buffer);
+            this_param.data_uint32_t = atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_UINT64_T:
@@ -713,11 +725,11 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params)
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_QRYHANDLE:
-            this_param.query_handle = atoi(data_buffer);
+            this_param.query_handle = atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_CORENUM:
-            this_param.cpu_id = atoi(data_buffer);
+            this_param.cpu_id = atouint32_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         default:
@@ -828,7 +840,7 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
             const char *info_str;
             info_str = STATE_STR_INIT_RUNNING;
             mcdserver_state.cpu_state.state = mcd_state;
-            mcdserver_state.cpu_state.state = info_str;
+            mcdserver_state.cpu_state.info_str = info_str;
         }
         return;
     }
@@ -836,7 +848,8 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
     const char *mcd_state;
     const char *stop_str;
     const char *info_str;
-    uint32_t trig_id = 0;
+    uint32_t bp_type = 0;
+    uint64_t bp_address = 0;
     switch (state) {
     case RUN_STATE_RUNNING:
         mcd_state = CORE_STATE_RUNNING;
@@ -849,27 +862,28 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
         if (cpu->watchpoint_hit) {
             switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
             case BP_MEM_READ:
-                trig_id = MCD_TRIG_TYPE_READ;
+                bp_type = MCD_BREAKPOINT_READ;
                 stop_str = STATE_STR_BREAK_READ(cpu->watchpoint_hit->hitaddr);
                 break;
             case BP_MEM_WRITE:
-                trig_id = MCD_TRIG_TYPE_WRITE;
+                bp_type = MCD_BREAKPOINT_WRITE;
                 stop_str = STATE_STR_BREAK_WRITE(cpu->watchpoint_hit->hitaddr);
                 break;
             case BP_MEM_ACCESS:
-                trig_id = MCD_TRIG_TYPE_RW;
+                bp_type = MCD_BREAKPOINT_RW;
                 stop_str = STATE_STR_BREAK_RW(cpu->watchpoint_hit->hitaddr);
                 break;
             default:
-                break;
                 stop_str = STATE_STR_BREAK_UNKNOWN;
+                break;
             }
+            bp_address = cpu->watchpoint_hit->hitaddr;
             cpu->watchpoint_hit = NULL;
         } else if (cpu->singlestep_enabled) {
             /* we land here when a single step is performed */
             stop_str = STATE_STEP_PERFORMED;
         } else {
-            trig_id = MCD_TRIG_TYPE_IP;
+            bp_type = MCD_BREAKPOINT_HW;
             stop_str = STATE_STR_BREAK_HW;
             tb_flush(cpu);
         }
@@ -895,7 +909,8 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
 
     /* set state for c_cpu */
     mcdserver_state.cpu_state.state = mcd_state;
-    mcdserver_state.cpu_state.trig_id = trig_id;
+    mcdserver_state.cpu_state.bp_type = bp_type;
+    mcdserver_state.cpu_state.bp_address = bp_address;
     mcdserver_state.cpu_state.stop_str = stop_str;
     mcdserver_state.cpu_state.info_str = info_str;
 }
@@ -1263,13 +1278,14 @@ int init_resets(GArray *resets)
     return 0;
 }
 
-int init_trigger(mcd_trigger_st *trigger)
+int init_trigger(mcd_trigger_into_st *trigger)
 {
     trigger->type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ |
         MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
     trigger->option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
     trigger->action = (MCD_TRIG_ACTION_DBG_DEBUG);
-    trigger->nr_trigger = 4;
+    /* there is no specific upper limit for trigger */
+    trigger->nr_trigger = 0;
     return 0;
 }
 
@@ -1541,7 +1557,7 @@ void handle_query_reset_f(GArray *params, void *user_ctx)
 void handle_query_reset_c(GArray *params, void *user_ctx)
 {
     /* reset options are the same for every cpu! */
-    int query_index = get_param(params, 0)->query_handle;
+    uint32_t query_index = get_param(params, 0)->query_handle;
 
     /* 1. check weather this was the last mem space */
     int nb_groups = mcdserver_state.resets->len;
@@ -1608,7 +1624,7 @@ void handle_close_server(GArray *params, void *user_ctx)
 
 void handle_query_trigger(GArray *params, void *user_ctx)
 {
-    mcd_trigger_st trigger = mcdserver_state.trigger;
+    mcd_trigger_into_st trigger = mcdserver_state.trigger;
     g_string_printf(mcdserver_state.str_buf, "%s=%d.%s=%d.%s=%d.%s=%d.",
         TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
         TCP_ARGUMENT_TYPE, trigger.type, TCP_ARGUMENT_OPTION, trigger.option,
@@ -1687,7 +1703,7 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx)
      * this funcitons send all mem spaces except for the first
      * 1. get parameter and memspace
      */
-    int query_index = get_param(params, 0)->query_handle;
+    uint32_t query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
     GArray *memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
 
@@ -1742,7 +1758,7 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx)
      * this funcitons send all reg groups except for the first
      * 1. get parameter and memspace
      */
-    int query_index = get_param(params, 0)->query_handle;
+    uint32_t query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
     GArray *reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
 
@@ -1797,7 +1813,7 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
      * this funcitons send all regs except for the first
      * 1. get parameter and registers
      */
-    int query_index = get_param(params, 0)->query_handle;
+    uint32_t query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
     GArray *registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
 
@@ -1853,13 +1869,22 @@ void handle_query_state(GArray *params, void *user_ctx)
     }
     /* send data */
     g_string_printf(mcdserver_state.str_buf,
-        "%s=%s.%s=%d.%s=%d.%s=%d.%s=%s.%s=%s.",
+        "%s=%s.%s=%u.%s=%u.%s=%u.%s=%lu.%s=%s.%s=%s.",
         TCP_ARGUMENT_STATE, state_info.state,
         TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0,
-        TCP_ARGUMENT_TRIGGER_ID, state_info.trig_id,
+        TCP_ARGUMENT_TYPE, state_info.bp_type,
+        TCP_ARGUMENT_ADDRESS, state_info.bp_address,
         TCP_ARGUMENT_STOP_STRING, state_info.stop_str,
         TCP_ARGUMENT_INFO_STRING, state_info.info_str);
     mcd_put_strbuf();
+
+    /* reset debug info after first query */
+    if (strcmp(state_info.state, CORE_STATE_DEBUG) == 0) {
+        mcdserver_state.cpu_state.stop_str = "";
+        mcdserver_state.cpu_state.info_str = "";
+        mcdserver_state.cpu_state.bp_type = 0;
+        mcdserver_state.cpu_state.bp_address = 0;
+    }
 }
 
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg)
@@ -1913,7 +1938,7 @@ void mcd_hextomem(GByteArray *mem, const char *buf, int len)
 void handle_read_register(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint64_t reg_num = get_param(params, 1)->data_int;
+    uint64_t reg_num = get_param(params, 1)->data_uint64_t;
     int reg_size;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
@@ -1926,8 +1951,8 @@ void handle_read_register(GArray *params, void *user_ctx)
 void handle_write_register(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint64_t reg_num = get_param(params, 1)->data_int;
-    uint32_t reg_size = get_param(params, 2)->data_int;
+    uint64_t reg_num = get_param(params, 1)->data_uint64_t;
+    uint32_t reg_size = get_param(params, 2)->data_uint32_t;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf,
@@ -1967,7 +1992,7 @@ void handle_read_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t mem_address = get_param(params, 1)->data_uint64_t;
-    int len = get_param(params, 2)->data_int;
+    uint32_t len = get_param(params, 2)->data_uint32_t;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     g_byte_array_set_size(mcdserver_state.mem_buf, len);
@@ -1985,7 +2010,7 @@ void handle_write_memory(GArray *params, void *user_ctx)
 {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t mem_address = get_param(params, 1)->data_uint64_t;
-    int len = get_param(params, 2)->data_int;
+    uint32_t len = get_param(params, 2)->data_uint32_t;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
     mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
@@ -1997,7 +2022,7 @@ void handle_write_memory(GArray *params, void *user_ctx)
     }
 }
 
-int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len)
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr)
 {
     /* translate the type to known gdb types and function call*/
     int bp_type = 0;
@@ -2027,7 +2052,7 @@ int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len)
     }
 }
 
-int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len)
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr)
 {
     /* translate the type to known gdb types and function call*/
     int bp_type = 0;
@@ -2061,12 +2086,11 @@ void handle_breakpoint_insert(GArray *params, void *user_ctx)
 {
     /* 1. get parameter data */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint32_t type = get_param(params, 1)->data_int;
+    uint32_t type = get_param(params, 1)->data_uint32_t;
     uint64_t address = get_param(params, 2)->data_uint64_t;
-    uint64_t len = get_param(params, 3)->data_uint64_t;
-    /* 2. insert breakpoint and send reply*/
+    /* 2. insert breakpoint and send reply */
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    if (mcd_breakpoint_insert(cpu, type, address, len) != 0) {
+    if (mcd_breakpoint_insert(cpu, type, address) != 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
@@ -2077,12 +2101,11 @@ void handle_breakpoint_remove(GArray *params, void *user_ctx)
 {
     /* 1. get parameter data */
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    uint32_t type = get_param(params, 1)->data_int;
+    uint32_t type = get_param(params, 1)->data_uint32_t;
     uint64_t address = get_param(params, 2)->data_uint64_t;
-    uint64_t len = get_param(params, 3)->data_uint64_t;
-    /* 2. remove breakpoint and send reply*/
+    /* 2. remove breakpoint and send reply */
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    if (mcd_breakpoint_remove(cpu, type, address, len) != 0) {
+    if (mcd_breakpoint_remove(cpu, type, address) != 0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     } else {
         mcd_put_packet(TCP_EXECUTION_SUCCESS);
diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
index ab44252ba0..7a63a01a39 100644
--- a/mcdstub/mcdstub.h
+++ b/mcdstub/mcdstub.h
@@ -104,10 +104,10 @@ typedef struct MCDCmdParseEntry {
 
 typedef union MCDCmdVariant {
     const char *data;
-    int data_int;
+    uint32_t data_uint32_t;
     uint64_t data_uint64_t;
-    int query_handle;
-    int cpu_id;
+    uint32_t query_handle;
+    uint32_t cpu_id;
 } MCDCmdVariant;
 
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -119,19 +119,26 @@ enum RSState {
     RS_DATAEND,
 };
 
-typedef struct mcd_trigger_st {
+typedef struct breakpoint_st {
+    uint32_t type;
+    uint64_t address;
+    uint32_t id;
+} breakpoint_st;
+
+typedef struct mcd_trigger_into_st {
     uint32_t type;
     uint32_t option;
     uint32_t action;
     uint32_t nr_trigger;
-} mcd_trigger_st;
+} mcd_trigger_into_st;
 
 typedef struct mcd_cpu_state_st {
     const char *state;
     bool memory_changed;
     bool registers_changed;
     bool target_was_stopped;
-    uint32_t trig_id;
+    uint32_t bp_type;
+    uint64_t bp_address;
     const char *stop_str;
     const char *info_str;
 } mcd_cpu_state_st;
@@ -158,8 +165,9 @@ typedef struct MCDState {
     GList *all_memspaces;
     GList *all_reggroups;
     GList *all_registers;
+    GList *all_breakpoints;
     GArray *resets;
-    mcd_trigger_st trigger;
+    mcd_trigger_into_st trigger;
     mcd_cpu_state_st cpu_state;
     MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
@@ -244,7 +252,7 @@ void mcd_sigterm_handler(int signal);
 void mcd_init_mcdserver_state(void);
 void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table);
 int init_resets(GArray *resets);
-int init_trigger(mcd_trigger_st *trigger);
+int init_trigger(mcd_trigger_into_st *trigger);
 void reset_mcdserver_state(void);
 void create_processes(MCDState *s);
 void mcd_create_default_process(MCDState *s);
@@ -312,8 +320,8 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 void handle_breakpoint_insert(GArray *params, void *user_ctx);
 void handle_breakpoint_remove(GArray *params, void *user_ctx);
-int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr, vaddr len);
-int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr, vaddr len);
+int mcd_breakpoint_insert(CPUState *cpu, int type, vaddr addr);
+int mcd_breakpoint_remove(CPUState *cpu, int type, vaddr addr);
 
 /* arm specific functions */
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray *memspaces);
@@ -332,5 +340,6 @@ int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
 void mcd_hextomem(GByteArray *mem, const char *buf, int len);
 uint64_t atouint64_t(const char *in);
+uint32_t atouint32_t(const char *in);
 
 #endif /* MCDSTUB_INTERNALS_H */
-- 
2.34.1


