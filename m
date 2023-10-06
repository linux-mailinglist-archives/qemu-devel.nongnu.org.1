Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E27BB3F7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn8-00087A-HF; Fri, 06 Oct 2023 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogn1-00083j-H1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:32 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmw-0000wB-Jj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:31 -0400
Received: (qmail 19535 invoked by uid 484); 6 Oct 2023 09:06:23 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.07364 secs); 06 Oct 2023 09:06:23 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:22 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 09/29] memory and register query data now stored per core
Date: Fri,  6 Oct 2023 11:05:50 +0200
Message-Id: <20231006090610.26171-10-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          |  63 +++-
 mcdstub/mcd_shared_defines.h |  43 ++-
 mcdstub/mcdstub.c            | 693 ++++++++++++++++++++++-------------
 3 files changed, 533 insertions(+), 266 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 4c79ff7674..a4d49a4a84 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -8,6 +8,7 @@
 
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
+#include "hw/core/cpu.h"
 // just used for the register xml files
 #include "exec/gdbstub.h"       /* xml_builtin */
 
@@ -22,9 +23,22 @@
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
 // schema defines
-#define ARG_SCHEMA_QRYHANDLE "q"
-#define ARG_SCHEMA_STRING "s"
-#define ARG_SCHEMA_CORENUM "c" 
+#define ARG_SCHEMA_QRYHANDLE 'q'
+#define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_CORENUM 'c'
+
+// resets
+#define RESET_SYSTEM "full_system_reset"
+#define RESET_GPR "gpr_reset"
+#define RESET_MEMORY "memory_reset"
+
+// more
+#define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the end
+#define CMD_SCHEMA_LENGTH 2
+#define MCD_MAX_CORES 128
+#define MCD_SYSTEM_NAME "qemu-system"
+// tcp query packet values templates
+#define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
 
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
@@ -52,8 +66,7 @@ typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
 typedef struct MCDCmdParseEntry {
     MCDCmdHandler handler;
     const char *cmd;
-    bool cmd_startswith;
-    const char *schema;
+    char schema[CMD_SCHEMA_LENGTH];
 } MCDCmdParseEntry;
 
 typedef enum MCDThreadIdKind {
@@ -92,6 +105,13 @@ enum RSState {
     RS_DATAEND,
 };
 
+typedef struct mcd_trigger_st {
+    uint32_t type;
+    uint32_t option;
+    uint32_t action;
+    uint32_t nr_trigger;
+} mcd_trigger_st;
+
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
     CPUState *c_cpu; /* current CPU for everything */
@@ -113,9 +133,13 @@ typedef struct MCDState {
     int supported_sstep_flags;
 
     // my stuff
-    GArray *memspaces;
-    GArray *reggroups;
-    GArray *registers;
+    uint32_t query_cpu_id;
+    GList *all_memspaces;
+    GList *all_reggroups;
+    GList *all_registers;
+    GArray *resets;
+    mcd_trigger_st trigger;
+    MCDCmdParseEntry mcd_query_cmds_table[QUERY_TOTAL_NUMBER];
 } MCDState;
 
 /* lives in main mcdstub.c */
@@ -164,6 +188,11 @@ typedef struct mcd_reg_st {
     uint8_t opc2;
 } mcd_reg_st;
 
+typedef struct mcd_reset_st {
+    const char *name;
+    uint8_t id;
+} mcd_reset_st;
+
 // Inline utility function, convert from int to hex and back
 
 
@@ -194,6 +223,9 @@ void mcd_sigterm_handler(int signal);
 #endif
 
 void mcd_init_mcdserver_state(void);
+void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table);
+int init_resets(GArray* resets);
+int init_trigger(mcd_trigger_st* trigger);
 void reset_mcdserver_state(void);
 void create_processes(MCDState *s);
 void mcd_create_default_process(MCDState *s);
@@ -231,8 +263,10 @@ void handle_query_system(GArray *params, void *user_ctx);
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 CPUState *find_cpu(uint32_t thread_id);
 void handle_open_core(GArray *params, void *user_ctx);
-void handle_query_reset(GArray *params, void *user_ctx);
-void handle_detach(GArray *params, void *user_ctx);
+void handle_query_reset_f(GArray *params, void *user_ctx);
+void handle_query_reset_c(GArray *params, void *user_ctx);
+void handle_close_server(GArray *params, void *user_ctx);
+void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
@@ -241,11 +275,14 @@ void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
-void handle_init(GArray *params, void *user_ctx);
-void parse_reg_xml(const char *xml, int size);
+void handle_open_server(GArray *params, void *user_ctx);
+void parse_reg_xml(const char *xml, int size, GArray* registers);
 
 // arm specific functions
-void mcd_arm_store_mem_spaces(int nr_address_spaces);
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* registers, int* current_group_id);
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArray* registers, int* current_group_id);
+int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers);
 
 /* sycall handling */
 void mcd_syscall_reset(void);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 6a2abfb1bc..e0b27ce5e6 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -3,12 +3,13 @@
 #ifndef MCD_SHARED_DEFINES
 #define MCD_SHARED_DEFINES
 
-// tcp characters
-#define TCP_CHAR_INIT 'i'
+// tcp data characters
+#define TCP_CHAR_OPEN_SERVER 'I'
+#define TCP_CHAR_OPEN_CORE 'i'
 #define TCP_CHAR_GO 'c'
 #define TCP_CHAR_QUERY 'q'
-#define TCP_CHAR_OPEN_CORE 'H'
-#define TCP_CHAR_DETACH 'D'
+#define TCP_CHAR_CLOSE_SERVER 'D'
+#define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
 
 // tcp protocol chars
@@ -18,7 +19,39 @@
 #define TCP_COMMAND_END '#'
 #define TCP_WAS_LAST '|'
 #define TCP_WAS_NOT_LAST '~'
+#define TCP_HANDSHAKE_SUCCESS "shaking your hand"
 
+// tcp query arguments
+#define QUERY_FIRST "f"
+#define QUERY_CONSEQUTIVE "c"
 
+#define QUERY_ARG_SYSTEM "system"
+#define QUERY_ARG_CORES "cores"
+#define QUERY_ARG_RESET "reset"
+#define QUERY_ARG_TRIGGER "trigger"
+#define QUERY_ARG_MEMORY "memory"
+#define QUERY_ARG_REGGROUP "reggroup"
+#define QUERY_ARG_REG "reg"
 
-#endif
\ No newline at end of file
+// tcp query packet argument list
+#define TCP_ARGUMENT_NAME "name"
+#define TCP_ARGUMENT_ID "id"
+#define TCP_ARGUMENT_TYPE "type"
+#define TCP_ARGUMENT_BITS_PER_MAU "bpm"
+#define TCP_ARGUMENT_INVARIANCE "i"
+#define TCP_ARGUMENT_ENDIAN "e"
+#define TCP_ARGUMENT_MIN "min"
+#define TCP_ARGUMENT_MAX "max"
+#define TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS "sao"
+#define TCP_ARGUMENT_REGGROUPID "reggroupid"
+#define TCP_ARGUMENT_MEMSPACEID "memspaceid"
+#define TCP_ARGUMENT_SIZE "size"
+#define TCP_ARGUMENT_THREAD "thread"
+#define TCP_ARGUMENT_DEVICE "device"
+#define TCP_ARGUMENT_CORE "core"
+#define TCP_ARGUMENT_AMOUNT_CORE "nr_cores"
+#define TCP_ARGUMENT_AMOUNT_TRIGGER "nr_trigger"
+#define TCP_ARGUMENT_OPTION "option"
+#define TCP_ARGUMENT_ACTION "action"
+
+#endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a4841cf7d3..a0c4c2794f 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -27,7 +27,6 @@
 #include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
 #include "sysemu/replay.h"
-#include "hw/core/cpu.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
@@ -47,53 +46,6 @@ MCDSystemState mcdserver_system_state;
 
 MCDState mcdserver_state;
 
-static const MCDCmdParseEntry mcd_gen_query_table[] = {
-    // this is a list of all query commands. it gets iterated over only the handler of the matching command will get executed
-    {
-        .handler = handle_query_system,
-        .cmd = "system",
-    },
-    {
-        .handler = handle_query_cores,
-        .cmd = "cores",
-    },
-    {
-        .handler = handle_query_reset,
-        .cmd = "reset",
-    },
-    {
-        .handler = handle_query_trigger,
-        .cmd = "trigger",
-    },
-    {
-        .handler = handle_query_mem_spaces_f,
-        .cmd = "memoryf",
-    },
-    {
-        .handler = handle_query_mem_spaces_c,
-        .cmd = "memoryc",
-        .schema = ARG_SCHEMA_QRYHANDLE,
-    },
-    {
-        .handler = handle_query_reg_groups_f,
-        .cmd = "reggroupf",
-    },
-    {
-        .handler = handle_query_reg_groups_c,
-        .cmd = "reggroupc",
-        .schema = ARG_SCHEMA_QRYHANDLE,
-    },
-    {
-        .handler = handle_query_regs_f,
-        .cmd = "regf",
-    },
-    {
-        .handler = handle_query_regs_c,
-        .cmd = "regc",
-        .schema = ARG_SCHEMA_QRYHANDLE,
-    },
-};
-
 void mcd_init_mcdserver_state(void)
 {
 	g_assert(!mcdserver_state.init);
@@ -113,6 +65,97 @@ void mcd_init_mcdserver_state(void)
     mcdserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
     mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
+
+    // init query table
+    init_query_cmds_table(mcdserver_state.mcd_query_cmds_table);
+}
+
+void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
+    // initalizes a list of all query commands
+    int cmd_number = 0;
+
+    MCDCmdParseEntry query_system = {
+        .handler = handle_query_system,
+        .cmd = QUERY_ARG_SYSTEM,
+    };
+    mcd_query_cmds_table[cmd_number] = query_system;
+    cmd_number++;
+
+    MCDCmdParseEntry query_cores = {
+        .handler = handle_query_cores,
+        .cmd = QUERY_ARG_CORES,
+    };
+    mcd_query_cmds_table[cmd_number] = query_cores;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reset_f = {
+        .handler = handle_query_reset_f,
+        .cmd = QUERY_ARG_RESET QUERY_FIRST,
+    };
+    mcd_query_cmds_table[cmd_number] = query_reset_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reset_c = {
+        .handler = handle_query_reset_c,
+        .cmd = QUERY_ARG_RESET QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reset_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reset_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_trigger = {
+        .handler = handle_query_trigger,
+        .cmd = QUERY_ARG_TRIGGER,
+    };
+    mcd_query_cmds_table[cmd_number] = query_trigger;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_f = {
+        .handler = handle_query_mem_spaces_f,
+        .cmd = QUERY_ARG_MEMORY QUERY_FIRST,
+    };
+    strcpy(query_mem_spaces_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_mem_spaces_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_mem_spaces_c = {
+        .handler = handle_query_mem_spaces_c,
+        .cmd = QUERY_ARG_MEMORY QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_mem_spaces_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_mem_spaces_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_f = {
+        .handler = handle_query_reg_groups_f,
+        .cmd = QUERY_ARG_REGGROUP QUERY_FIRST,
+    };
+    strcpy(query_reg_groups_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reg_groups_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_reg_groups_c = {
+        .handler = handle_query_reg_groups_c,
+        .cmd = QUERY_ARG_REGGROUP QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_reg_groups_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reg_groups_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_f = {
+        .handler = handle_query_regs_f,
+        .cmd = QUERY_ARG_REG QUERY_FIRST,
+    };
+    strcpy(query_regs_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_regs_f;
+    cmd_number++;
+
+    MCDCmdParseEntry query_regs_c = {
+        .handler = handle_query_regs_c,
+        .cmd = QUERY_ARG_REG QUERY_CONSEQUTIVE,
+    };
+    strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_regs_c;
 }
 
 void reset_mcdserver_state(void)
@@ -400,14 +443,14 @@ int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
-    case TCP_CHAR_INIT:
+    case TCP_CHAR_OPEN_SERVER:
         // handshake and lookup initialization
         {
-            static MCDCmdParseEntry init_cmd_desc = {
-                .handler = handle_init,
+            static MCDCmdParseEntry open_server_cmd_desc = {
+                .handler = handle_open_server,
             };
-            init_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_INIT, '\0' };
-            cmd_parser = &init_cmd_desc;
+            open_server_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_OPEN_SERVER, '\0' };
+            cmd_parser = &open_server_cmd_desc;
         }
         break;
     case TCP_CHAR_GO:
@@ -430,29 +473,39 @@ int mcd_handle_packet(const char *line_buf)
         {
             static MCDCmdParseEntry query_cmd_desc = {
                 .handler = handle_gen_query,
-                .schema = ARG_SCHEMA_STRING
             };
             query_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_QUERY, '\0' };
+            strcpy(query_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_STRING, '\0' });
             cmd_parser = &query_cmd_desc;
         }
         break;
     case TCP_CHAR_OPEN_CORE:
         {
-            static MCDCmdParseEntry gen_open_core = {
+            static MCDCmdParseEntry open_core_cmd_desc = {
                 .handler = handle_open_core,
-                .schema = ARG_SCHEMA_CORENUM
             };
-            gen_open_core.cmd = (char[2]) { (char) TCP_CHAR_OPEN_CORE, '\0' };
-            cmd_parser = &gen_open_core;
+            open_core_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_OPEN_CORE, '\0' };
+            strcpy(open_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &open_core_cmd_desc;
         }
         break;
-    case TCP_CHAR_DETACH:
+    case TCP_CHAR_CLOSE_SERVER:
         {
-            static MCDCmdParseEntry detach_cmd_desc = {
-                .handler = handle_detach,
+            static MCDCmdParseEntry close_server_cmd_desc = {
+                .handler = handle_close_server,
             };
-            detach_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_DETACH, '\0' };
-            cmd_parser = &detach_cmd_desc;
+            close_server_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_CLOSE_SERVER, '\0' };
+            cmd_parser = &close_server_cmd_desc;
+        }
+        break;
+    case TCP_CHAR_CLOSE_CORE:
+        {
+            static MCDCmdParseEntry close_core_cmd_desc = {
+                .handler = handle_close_core,
+            };
+            close_core_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_CLOSE_CORE, '\0' };
+            strcpy(close_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &close_core_cmd_desc;
         }
         break;
     default:
@@ -488,8 +541,8 @@ void handle_gen_query(GArray *params, void *user_ctx)
     }
     //now iterate over all possible query functions and execute the right one
     if (process_string_cmd(NULL, get_param(params, 0)->data,
-                           mcd_gen_query_table,
-                           ARRAY_SIZE(mcd_gen_query_table))) {
+                           mcdserver_state.mcd_query_cmds_table,
+                           ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table))) {
         mcd_put_packet("");
     }
 }
@@ -514,16 +567,16 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     MCDCmdVariant this_param;
 
     char data_buffer[64] = {0};
-    if (schema[0] == atoi(ARG_SCHEMA_STRING)) {
+    if (schema[0] == ARG_SCHEMA_STRING) {
         this_param.data = data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] == atoi(ARG_SCHEMA_QRYHANDLE)) {
+    else if (schema[0] == ARG_SCHEMA_QRYHANDLE) {
         strncat(data_buffer, data, strlen(data));
         this_param.query_handle = atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] == atoi(ARG_SCHEMA_CORENUM)) {
+    else if (schema[0] == ARG_SCHEMA_CORENUM) {
         strncat(data_buffer, data, strlen(data));
         this_param.cpu_id = atoi(data_buffer);
         g_array_append_val(params, this_param);
@@ -799,7 +852,7 @@ CPUState *find_cpu(uint32_t thread_id)
 }
 
 
-void parse_reg_xml(const char *xml, int size) {
+void parse_reg_xml(const char *xml, int size, GArray* registers) {
     // iterates over the complete xml file
     int i, j;
     int still_to_skip = 0;
@@ -866,7 +919,7 @@ void parse_reg_xml(const char *xml, int size) {
                     }
                 }
                 // store register
-                g_array_append_vals(mcdserver_state.registers, (gconstpointer)&my_register, 1);
+                g_array_append_vals(registers, (gconstpointer)&my_register, 1);
                 // free memory
                 g_array_free(reg_data, false);
             }
@@ -924,7 +977,9 @@ int int_cmp(gconstpointer a, gconstpointer b) {
     }
 }
 
-void mcd_arm_store_mem_spaces(int nr_address_spaces) {
+int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces) {
+    int nr_address_spaces = cpu->num_ases;
+
     mcd_mem_space_st space1 = {
         .name = "Non Secure",
         .id = 1,
@@ -936,7 +991,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space1, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space1, 1);
 
     mcd_mem_space_st space2 = {
         .name = "Physical (Non Secure)",
@@ -949,7 +1004,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space2, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space2, 1);
 
     if (nr_address_spaces==2) {
         mcd_mem_space_st space3 = {
@@ -963,7 +1018,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space3, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space3, 1);
     mcd_mem_space_st space4 = {
         .name = "Physical (Secure)",
         .id = 4,
@@ -975,7 +1030,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space4, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space4, 1);
     }
     // TODO: get dynamically how the per (CP15) space is called
     mcd_mem_space_st space5 = {
@@ -989,7 +1044,7 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space5, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space5, 1);
     mcd_mem_space_st space6 = {
         .name = "CP15 Registers",
         .id = 6,
@@ -1001,16 +1056,43 @@ void mcd_arm_store_mem_spaces(int nr_address_spaces) {
         .max_addr = -1,
         .supported_access_options = 0,
     };
-    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space6, 1);
+    g_array_append_vals(memspaces, (gconstpointer)&space6, 1);
+
+    return 0;
+}
+
+int init_resets(GArray* resets) {
+    mcd_reset_st system_reset = { .id = 0, .name = RESET_SYSTEM};
+    mcd_reset_st gpr_reset = { .id = 1, .name = RESET_GPR};
+    mcd_reset_st memory_reset = { .id = 2, .name = RESET_MEMORY};
+    g_array_append_vals(resets, (gconstpointer)&system_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&gpr_reset, 1);
+    g_array_append_vals(resets, (gconstpointer)&memory_reset, 1);
+    return 0;
 }
 
-void handle_init(GArray *params, void *user_ctx) {
-    // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand"); 
+int init_trigger(mcd_trigger_st* trigger) {
+    trigger->type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
+    trigger->option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
+    trigger->action = (MCD_TRIG_ACTION_DBG_DEBUG);
+    trigger->nr_trigger = 4;
+    return 0;
+}
+
+void handle_open_server(GArray *params, void *user_ctx) {
+    // initialize some core-independent data
+    int return_value = 0;
+    mcdserver_state.resets = g_array_new(false, true, sizeof(mcd_reset_st));
+    return_value = init_resets(mcdserver_state.resets);
+    if (return_value!=0) assert(0);
+    return_value = init_trigger(&mcdserver_state.trigger);
+    if (return_value!=0) assert(0);
+
+    mcd_put_packet(TCP_HANDSHAKE_SUCCESS); 
 }
 
 void handle_query_system(GArray *params, void *user_ctx) {
-    mcd_put_packet("qemu-system");
+    mcd_put_packet(MCD_SYSTEM_NAME);
 }
 
 void handle_query_cores(GArray *params, void *user_ctx) {
@@ -1030,138 +1112,179 @@ void handle_query_cores(GArray *params, void *user_ctx) {
     
     int nr_cores = cpu->nr_cores;
 
-    g_string_append_printf(mcdserver_state.str_buf, "device=\"qemu-%s-device\",core=\"%s\",nr_cores=\"%d\"", arch, cpu_model, nr_cores);
+    char device_name[] = DEVICE_NAME_TEMPLATE(arch);
+    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%d.",
+    TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
 
-void handle_open_core(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
-    uint32_t cpu_id = get_param(params, 0)->cpu_id;
-
-    CPUState *cpu = mcd_get_cpu(cpu_id);
-
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    gchar *arch = cc->gdb_arch_name(cpu);
-
-    // TODO: this might cause a memory leak when called a second time -> maybe free the Garray first
-    mcdserver_state.memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
-    mcdserver_state.reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
-    mcdserver_state.registers = g_array_new(false, true, sizeof(mcd_reg_st));
-
-    
-    if (strcmp(arch, "arm")==0) {
-        // store reg groups
-        uint32_t current_group_id = 0;
-
-        // at the moment we just assume there are 3 spaces (gpr, per and debug)
-        
-        // store mem spaces
-        int nr_address_spaces = cpu->num_ases;
-        mcd_arm_store_mem_spaces(nr_address_spaces);
-        // mem spaces done
-
-
-        GList *register_numbers = NULL;
+int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* registers, int* current_group_id) {
+    const char *xml_filename = NULL;
+    const char *current_xml_filename = NULL;
+    const char *xml_content = NULL;
+    int i = 0;
+
+    // 1. get correct file
+    xml_filename = cc->gdb_core_xml_file;
+    for (i = 0; ; i++) {
+        current_xml_filename = xml_builtin[i][0];
+        if (!current_xml_filename || (strncmp(current_xml_filename, xml_filename, strlen(xml_filename)) == 0
+            && strlen(current_xml_filename) == strlen(xml_filename)))
+        break;
+    }
+    // without gpr registers we can do nothing
+    if (!current_xml_filename) {
+        return -1;
+    }
 
-        const char *xml_filename = NULL;
-        const char *xml_content = NULL;
-        const char *name = NULL;
-        int i;
+    // 2. add group for gpr registers
+    mcd_reg_group_st gprregs = { .name = "GPR Registers", .id = *current_group_id };
+    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
+    *current_group_id = *current_group_id + 1;
 
-        // 1. check out the core xml file
-        xml_filename = cc->gdb_core_xml_file;
+    // 3. parse xml
+    xml_content = xml_builtin[i][1];
+    parse_reg_xml(xml_content, strlen(xml_content), registers);
+    return 0;
+}
 
-        for (i = 0; ; i++) {
-                name = xml_builtin[i][0];
-                if (!name || (strncmp(name, xml_filename, strlen(xml_filename)) == 0 && strlen(name) == strlen(xml_filename)))
+int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArray* registers, int* current_group_id) {
+    const char *xml_filename = NULL;
+    const char *current_xml_filename = NULL;
+    const char *xml_content = NULL;
+    int i = 0;
+
+    // iterate over all gdb xml files 
+    GDBRegisterState *r;
+    for (r = cpu->gdb_regs; r; r = r->next) {
+        xml_filename = r->xml;
+        xml_content = NULL;
+
+        // 1. get xml content
+        xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
+        if (xml_content) {
+            if (strcmp(xml_filename, "system-registers.xml")==0) {
+                // these are the coprocessor register
+                mcd_reg_group_st corprocessorregs = { .name = "CP15 Registers", .id = *current_group_id };
+                g_array_append_vals(reggroups, (gconstpointer)&corprocessorregs, 1);
+                *current_group_id = *current_group_id + 1;
+            }  
+        }
+        else {
+            // its not a coprocessor xml -> it is a static xml file
+            for (i = 0; ; i++) {
+                current_xml_filename = xml_builtin[i][0];
+                if (!current_xml_filename || (strncmp(current_xml_filename, xml_filename, strlen(xml_filename)) == 0
+                    && strlen(current_xml_filename) == strlen(xml_filename)))
                 break;
             }
-        // without gpr registers we can do nothing
-        assert(name);
-        // add group for gpr registers
-        current_group_id = 1;
-        mcd_reg_group_st group1 = { .name = "GPR Registers", .id = current_group_id };
-        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group1, 1);
-
-        // parse xml
-        xml_content = xml_builtin[i][1];
-        parse_reg_xml(xml_content, strlen(xml_content));
-
-        // 2. iterate over all other xml files
-        GDBRegisterState *r;
-        for (r = cpu->gdb_regs; r; r = r->next) {
-            xml_filename = r->xml;
-            xml_content = NULL;
-
-            // first, check if this is a coprocessor xml
-
-            // funciton call
-            xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
-            if (xml_content) {
-                if (strcmp(xml_filename, "system-registers.xml")==0) {
-                    //these are the coprocessor register
-                    current_group_id = 2;
-                    mcd_reg_group_st group2 = { .name = "CP15 Registers", .id = current_group_id };
-                    g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group2, 1);
-                }
-                
+            if (current_xml_filename) {
+                xml_content = xml_builtin[i][1];
             }
             else {
-                // its not a coprocessor xml -> it is a static xml file
-                for (i = 0; ; i++) {
-                    name = xml_builtin[i][0];
-                    if (!name || (strncmp(name, xml_filename, strlen(xml_filename)) == 0 && strlen(name) == strlen(xml_filename)))
-                    break;
-                }
-                if (name) {
-                    xml_content = xml_builtin[i][1];
-                }
-                else {
-                    printf("no data found for %s\n", xml_filename);
-                    continue;
-                }
+                printf("no data found for %s\n", xml_filename);
+                continue;
             }
+        }
+        // 2. parse xml
+        parse_reg_xml(xml_content, strlen(xml_content), registers);
+    }
+    return 0;
+}
 
-            // parse xml
-            parse_reg_xml(xml_content, strlen(xml_content));
+int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers) {
+    GList *register_numbers = NULL;
+    mcd_reg_st *current_register;
+    int i = 0;
+    int id_neg_offset = 0;
+    int effective_id = 0;
+
+    // iterate over all registers
+    for (i = 0; i < registers->len; i++) {
+        current_register = &(g_array_index(registers, mcd_reg_st, i));
+        // 1. ad the id
+        if (current_register->id) {
+            // id is already in place
+            // NOTE: qemu doesn't emulate the FPA regs (so we are missing the indices 16 to 24)
+            int used_id = current_register->id;
+            register_numbers = g_list_append(register_numbers, &used_id);
+            id_neg_offset ++;
         }
-        // go over the register array and collect all additional data
-        mcd_reg_st *current_register;
-        int id_neg_offset = 0;
-        int effective_id;
-        for (i = 0; i < mcdserver_state.registers->len; i++) {
-            current_register = &(g_array_index(mcdserver_state.registers, mcd_reg_st, i));
-            // ad an id handle
-            if (current_register->id) {
-                // id is already in place
-                //FIXME: we are missing 10 registers (likely the FPA regs or sth)
-                int used_id = current_register->id;
-                register_numbers = g_list_append(register_numbers, &used_id);
-                id_neg_offset ++;
-            }
-            else {
-                effective_id = i - id_neg_offset;
-                if (g_list_find_custom(register_numbers, &effective_id, (GCompareFunc)int_cmp)!=NULL) {
-                    id_neg_offset --;
-                }
-                current_register->id = i - id_neg_offset;
-            }
-            // sort into correct reg_group and according mem_space
-            if (strcmp(current_register->group, "cp_regs")==0) {
-                current_register->mcd_reg_group_id = 2;
-                current_register->mcd_mem_space_id = 6;
-                // get info for opcode
-            }
-            else {
-                // gpr register
-                current_register->mcd_reg_group_id = 1;
-                current_register->mcd_mem_space_id = 5;
+        else {
+            effective_id = i - id_neg_offset;
+            if (g_list_find_custom(register_numbers, &effective_id, (GCompareFunc)int_cmp)!=NULL) {
+                id_neg_offset --;
             }
+            current_register->id = i - id_neg_offset;
+        }
+        // 2. add mcd_reg_group_id and mcd_mem_space_id
+        if (strcmp(current_register->group, "cp_regs")==0) {
+            // coprocessor registers
+            current_register->mcd_reg_group_id = 2;
+            current_register->mcd_mem_space_id = 6;
+            // TODO: get info for opcode
+        }
+        else {
+            // gpr register
+            current_register->mcd_reg_group_id = 1;
+            current_register->mcd_mem_space_id = 5;
+        }
+    }
+    g_list_free(register_numbers);
+    return 0;
+}
+
+void handle_open_core(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    gchar *arch = cc->gdb_arch_name(cpu);
+    int return_value = 0;
+
+    // prepare data strucutures
+    GArray* memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
+    GArray* reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+    GArray* registers = g_array_new(false, true, sizeof(mcd_reg_st));
+    
+    if (strcmp(arch, "arm")==0) {
+        // TODO: make group and memspace ids dynamic
+        int current_group_id = 1;
+        // 1. store mem spaces
+        return_value = mcd_arm_store_mem_spaces(cpu, memspaces);
+        if (return_value!=0) assert(0);
+        // 2. parse core xml
+        return_value = mcd_arm_parse_core_xml_file(cc, reggroups, registers, &current_group_id);
+        if (return_value!=0) assert(0);
+        // 3. parse other xmls
+        return_value = mcd_arm_parse_general_xml_files(cpu, reggroups, registers, &current_group_id);
+        if (return_value!=0) assert(0);
+        // 4. add additional data the the regs from the xmls
+        return_value = mcd_arm_get_additional_register_info(reggroups, registers);
+        if (return_value!=0) assert(0);
+        // 5. store all found data
+        if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
+            GList* memspaces_ptr = g_list_nth(mcdserver_state.all_memspaces, cpu_id);
+            memspaces_ptr->data = memspaces;
+        }
+        else {
+            mcdserver_state.all_memspaces = g_list_insert(mcdserver_state.all_memspaces, memspaces, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
+            GList* reggroups_ptr = g_list_nth(mcdserver_state.all_reggroups, cpu_id);
+            reggroups_ptr->data = reggroups;
+        }
+        else {
+            mcdserver_state.all_reggroups = g_list_insert(mcdserver_state.all_reggroups, reggroups, cpu_id);
+        }
+        if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
+            GList* registers_ptr = g_list_nth(mcdserver_state.all_registers, cpu_id);
+            registers_ptr->data = registers;
+        }
+        else {
+            mcdserver_state.all_registers = g_list_insert(mcdserver_state.all_registers, registers, cpu_id);
         }
-        // free memory
-        g_list_free(register_numbers);
     }
     else {
         // we don't support other architectures
@@ -1170,30 +1293,77 @@ void handle_open_core(GArray *params, void *user_ctx) {
     g_free(arch);
 }
 
-void handle_query_reset(GArray *params, void *user_ctx) {
+void handle_query_reset_f(GArray *params, void *user_ctx) {
     // resetting has to be done over a monitor (look ar Rcmd) so we tell MCD that we can reset but this still need to be implemented
-    // we only support one reset over this monitor and that would be a fully "system_restart"
-    mcd_put_packet("nr=\"3\",info=\"0,full_system_reset;1,gpr_reset;2,memory_reset;\"");
+    // we only support one reset over this monitor and that would be a full "system_restart"
+    // reset options are the same for every cpu!
+    
+    // 1. check length
+    int nb_resets = mcdserver_state.resets->len;
+    if (nb_resets == 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    // 2. send data
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+    // TODO: we still need to implement the gpr and memory reset here!
+}
+
+void handle_query_reset_c(GArray *params, void *user_ctx) {
+    // reset options are the same for every cpu!
+    int query_index = get_param(params, 0)->query_handle;
+    
+    // 1. check weather this was the last mem space
+    int nb_groups = mcdserver_state.resets->len;
+    if (query_index+1 == nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 2. send data
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
     // TODO: we still need to implement the gpr and memory reset here!
 }
 
-void handle_detach(GArray *params, void *user_ctx) {
+void handle_close_core(GArray *params, void *user_ctx) {
+    // free memory for correct core
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+    g_array_free(memspaces, TRUE);
+    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+    g_array_free(reggroups, TRUE);
+    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+    g_array_free(registers, TRUE);
+}
+
+void handle_close_server(GArray *params, void *user_ctx) {
     uint32_t pid = 1;
     MCDProcess *process = mcd_get_process(pid);
 
-    // 1. cleanup
-    // gdb_process_breakpoint_remove_all(process);
+    // 1. free memory
+    // TODO: do this only if there are no processes attached anymore!
+    g_list_free(mcdserver_state.all_memspaces);
+    g_list_free(mcdserver_state.all_reggroups);
+    g_list_free(mcdserver_state.all_registers);
+    g_array_free(mcdserver_state.resets, TRUE);
 
     // 2. detach
     process->attached = false;
 
-    // reset current cpus
-    // TODO: if we don't use c_cpu we can delete this
-    // this also checks to only reset THIS process we also probably don't need this since we only got one process!
+    // 3. reset process
     if (pid == mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
         mcdserver_state.c_cpu = mcd_first_attached_cpu();
     }
-
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
@@ -1202,14 +1372,10 @@ void handle_detach(GArray *params, void *user_ctx) {
 }
 
 void handle_query_trigger(GArray *params, void *user_ctx) {
-    // set the type, option and action bitmask and send it
-
-    uint32_t type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
-    uint32_t option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
-    uint32_t action = (MCD_TRIG_ACTION_DBG_DEBUG);
-    uint32_t nr_trigger = 4;
-
-    g_string_printf(mcdserver_state.str_buf, "nr=\"%d\",info=\"%d;%d;%d;\"", nr_trigger, type, option, action);
+    mcd_trigger_st trigger = mcdserver_state.trigger;
+    g_string_printf(mcdserver_state.str_buf, "%s=%d.%s=%d.%s=%d.%s=%d.",
+        TCP_ARGUMENT_AMOUNT_TRIGGER,  trigger.nr_trigger, TCP_ARGUMENT_TYPE, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option, TCP_ARGUMENT_ACTION, trigger.action);
     mcd_put_strbuf();
 }
 
@@ -1221,8 +1387,13 @@ void mcd_continue(void)
 }
 
 void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
-    // send the first mem space
-    int nb_groups = mcdserver_state.memspaces->len;
+    // 1. get correct memspaces and set the query_cpu
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
+
+    // 2. check length
+    int nb_groups = memspaces->len;
     if (nb_groups == 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1230,20 +1401,26 @@ void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_mem_space_st space = g_array_index(mcdserver_state.memspaces, mcd_mem_space_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "name=%s.id=%d.type=%d.bpm=%d.i=%d.e=%d.min=%ld.max=%ld.sao=%d.",
-        space.name, space.id, space.type, space.bits_per_mau, space.invariance, space.endian,
-        space.min_addr, space.max_addr, space.supported_access_options);
+
+    // 3. send data
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
     mcd_put_strbuf();
 }
 
 void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
     // this funcitons send all mem spaces except for the first
-    // 1. get parameter
+    // 1. get parameter and memspace
     int query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray* memspaces = g_list_nth_data(mcdserver_state.all_memspaces, cpu_id);
 
     // 2. check weather this was the last mem space
-    int nb_groups = mcdserver_state.memspaces->len;
+    int nb_groups = memspaces->len;
     if (query_index+1 == nb_groups) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1253,16 +1430,23 @@ void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
     }
 
     // 3. send the correct memspace
-    mcd_mem_space_st space = g_array_index(mcdserver_state.memspaces, mcd_mem_space_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "name=%s.id=%d.type=%d.bpm=%d.i=%d.e=%d.min=%ld.max=%ld.sao=%d.",
-        space.name, space.id, space.type, space.bits_per_mau, space.invariance, space.endian,
-        space.min_addr, space.max_addr, space.supported_access_options);
+    mcd_mem_space_st space = g_array_index(memspaces, mcd_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.%s=%ld.%s=%ld.%s=%d.",
+        TCP_ARGUMENT_NAME, space.name, TCP_ARGUMENT_ID, space.id, TCP_ARGUMENT_TYPE, space.type,
+        TCP_ARGUMENT_BITS_PER_MAU, space.bits_per_mau, TCP_ARGUMENT_INVARIANCE, space.invariance, TCP_ARGUMENT_ENDIAN, space.endian,
+        TCP_ARGUMENT_MIN, space.min_addr, TCP_ARGUMENT_MAX, space.max_addr,
+        TCP_ARGUMENT_SUPPORTED_ACCESS_OPTIONS, space.supported_access_options);
     mcd_put_strbuf();
 }
 
 void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
-    // send the first reg group
-    int nb_groups = mcdserver_state.reggroups->len;
+    // 1. get correct reggroups and set the query_cpu
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
+
+    // 2. check length
+    int nb_groups = reggroups->len;
     if (nb_groups == 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1270,18 +1454,21 @@ void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.", group.id, group.name);
+    // 3. send data
+    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.", TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
 
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
     // this funcitons send all reg groups except for the first
-    // 1. get parameter
+    // 1. get parameter and memspace
     int query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray* reggroups = g_list_nth_data(mcdserver_state.all_reggroups, cpu_id);
 
     // 2. check weather this was the last reg group
-    int nb_groups = mcdserver_state.reggroups->len;
+    int nb_groups = reggroups->len;
     if (query_index+1 == nb_groups) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1291,14 +1478,19 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
     }
 
     // 3. send the correct reggroup
-    mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.", group.id, group.name);
+    mcd_reg_group_st group = g_array_index(reggroups, mcd_reg_group_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.", TCP_ARGUMENT_ID, group.id, TCP_ARGUMENT_NAME, group.name);
     mcd_put_strbuf();
 }
 
 void handle_query_regs_f(GArray *params, void *user_ctx) {
-    // send the first register
-    int nb_regs = mcdserver_state.registers->len;
+    // 1. get correct registers and set the query_cpu
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    mcdserver_state.query_cpu_id = cpu_id;
+    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
+
+    // 2. check length
+    int nb_regs = registers->len;
     if (nb_regs == 1) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1306,20 +1498,24 @@ void handle_query_regs_f(GArray *params, void *user_ctx) {
     else {
         g_string_printf(mcdserver_state.str_buf, "1!");
     }
-    mcd_reg_st my_register = g_array_index(mcdserver_state.registers, mcd_reg_st, 0);
-    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.size=%d.reggroupid=%d.memspaceid=%d.type=%d.thread=%d.",
-        my_register.id, my_register.name, my_register.bitsize, my_register.mcd_reg_group_id,
-        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_register.mcd_hw_thread_id);
+    // 3. send data
+    mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
 
 void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all registers except for the first
-    // 1. get parameter
+    // this funcitons send all reg groups except for the first
+    // 1. get parameter and registers
     int query_index = get_param(params, 0)->query_handle;
+    uint32_t cpu_id = mcdserver_state.query_cpu_id;
+    GArray* registers = g_list_nth_data(mcdserver_state.all_registers, cpu_id);
 
     // 2. check weather this was the last register
-    int nb_regs = mcdserver_state.registers->len;
+    int nb_regs = registers->len;
     if (query_index+1 == nb_regs) {
         // indicates this is the last packet
         g_string_printf(mcdserver_state.str_buf, "0!");
@@ -1329,9 +1525,10 @@ void handle_query_regs_c(GArray *params, void *user_ctx) {
     }
 
     // 3. send the correct register
-    mcd_reg_st my_register = g_array_index(mcdserver_state.registers, mcd_reg_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.size=%d.reggroupid=%d.memspaceid=%d.type=%d.thread=%d.",
-        my_register.id, my_register.name, my_register.bitsize, my_register.mcd_reg_group_id,
-        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_register.mcd_hw_thread_id);
+    mcd_reg_st my_register = g_array_index(registers, mcd_reg_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%d.%s=%s.%s=%d.%s=%d.%s=%d.%s=%d.%s=%d.",
+        TCP_ARGUMENT_ID, my_register.id, TCP_ARGUMENT_NAME,  my_register.name, TCP_ARGUMENT_SIZE, my_register.bitsize,
+        TCP_ARGUMENT_REGGROUPID, my_register.mcd_reg_group_id, TCP_ARGUMENT_MEMSPACEID, my_register.mcd_mem_space_id,
+        TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
-- 
2.34.1


