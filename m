Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A77BB404
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn8-00087D-Bg; Fri, 06 Oct 2023 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmv-00082K-Ed
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:26 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmr-0000tR-3H
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:24 -0400
Received: (qmail 19447 invoked by uid 484); 6 Oct 2023 09:06:18 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.073842 secs); 06 Oct 2023 09:06:18 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:17 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 05/29] queries for memory spaces and register groups added
Date: Fri,  6 Oct 2023 11:05:46 +0200
Message-Id: <20231006090610.26171-6-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h |  29 +++---
 mcdstub/mcdstub.c   | 240 ++++++++++++++++++++++++--------------------
 2 files changed, 147 insertions(+), 122 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index ce3bffe7e6..8df535e92a 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -19,21 +19,13 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
-/*
- * lookuptable for transmitted signals
- */
-
-enum {
-    MCD_SIGNAL_HANDSHAKE = 0
-};
-
 
 /*
  * struct for an MCD Process, each process can establish one connection
  */
 
 typedef struct MCDProcess {
-    //this is probably what we would call a system (in qemu its a cluster)
+    //this is a relict from the gdb process, we might be able to delete this
     uint32_t pid;
     bool attached;
 
@@ -65,6 +57,9 @@ typedef union MCDCmdVariant {
         uint32_t pid;
         uint32_t tid;
     } thread_id;
+
+    // used to synchronize stub and dll for functions with multiple packets
+    int index_handle;
 } MCDCmdVariant;
 
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -88,9 +83,7 @@ enum RSState {
 
 typedef struct MCDState {
     bool init;       /* have we been initialised? */
-    CPUState *c_cpu; /* current CPU for step/continue ops */
-    CPUState *g_cpu; /* current CPU for other ops */
-    CPUState *query_cpu; /* for q{f|s}ThreadInfo */
+    CPUState *c_cpu; /* current CPU for everything */
     enum RSState state; /* parsing state */
     char line_buf[MAX_PACKET_LENGTH];
     int line_buf_index;
@@ -107,11 +100,19 @@ typedef struct MCDState {
     // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
+
+    // my stuff
+    GArray *reggroups;
 } MCDState;
 
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
 
+typedef struct mcd_reg_group_st {
+    const char *name;
+    const char *id;
+} mcd_reg_group_st;
+
 
 // Inline utility function, convert from int to hex and back
 
@@ -190,6 +191,10 @@ void handle_query_reset(GArray *params, void *user_ctx);
 void handle_detach(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
+void handle_query_mem_spaces(GArray *params, void *user_ctx);
+void handle_query_reg_groups_f(GArray *params, void *user_ctx);
+void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_init(GArray *params, void *user_ctx);
 
 /* sycall handling */
 void mcd_syscall_reset(void);
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 1d066c8169..9817f0893c 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -33,6 +33,7 @@
 
 // just used for the xml_builtin stuff
 //#include "exec/gdbstub.h"       /* xml_builtin */
+#include "hw/core/sysemu-cpu-ops.h"
 
 typedef struct {
     CharBackend chr;
@@ -61,6 +62,19 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
         .handler = handle_query_trigger,
         .cmd = "trigger",
     },
+    {
+        .handler = handle_query_mem_spaces,
+        .cmd = "memory",
+    },
+    {
+        .handler = handle_query_reg_groups_f,
+        .cmd = "reggroupf",
+    },
+    {
+        .handler = handle_query_reg_groups_c,
+        .cmd = "reggroupc",
+        .schema = "i",
+    },
 };
 
 void mcd_init_mcdserver_state(void)
@@ -314,6 +328,8 @@ void mcd_read_byte(uint8_t ch)
         case RS_GETLINE:
             if (ch == '#') {
                 /* end of command, start of checksum*/
+                mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
+                //mcdserver_state.line_sum += ch;
                 mcdserver_state.state = RS_DATAEND;
             }
             else if (mcdserver_state.line_buf_index >= sizeof(mcdserver_state.line_buf) - 1) {
@@ -363,25 +379,26 @@ void mcd_read_byte(uint8_t ch)
 
 int mcd_handle_packet(const char *line_buf)
 {
-    //decides what function (handler) to call depending on what the first character in the line_buf is!
+    // decides what function (handler) to call depending on what the first character in the line_buf is!
     const MCDCmdParseEntry *cmd_parser = NULL;
 
-    //trace_gdbstub_io_command(line_buf);
-
     switch (line_buf[0]) {
     case 'i':
-        //handshake
-        mcd_put_packet("shaking your hand");
-        //gdb_put_packet("OK");
+        // handshake and lookup initialization
+        {
+            static const MCDCmdParseEntry continue_cmd_desc = {
+                .handler = handle_init,
+                .cmd = "i",
+            };
+            cmd_parser = &continue_cmd_desc;
+        }
         break;
     case 'c':
-        //go command
+        // go command
         {
             static const MCDCmdParseEntry continue_cmd_desc = {
                 .handler = handle_continue,
                 .cmd = "c",
-                //.cmd_startswith = 1,
-                //.schema = "L0"
             };
             cmd_parser = &continue_cmd_desc;
         }
@@ -397,8 +414,7 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_query_cmd_desc = {
                 .handler = handle_gen_query,
                 .cmd = "q",
-                //.cmd_startswith = 1,
-                .schema = "ss"
+                .schema = "s"
             };
             cmd_parser = &gen_query_cmd_desc;
         }
@@ -409,8 +425,7 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_core_open = {
                 .handler = handle_core_open,
                 .cmd = "H",
-                //.cmd_startswith = 1,
-                .schema = "ss"
+                .schema = "s"
             };
             cmd_parser = &gen_core_open;
         }
@@ -420,20 +435,18 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry detach_cmd_desc = {
                 .handler = handle_detach,
                 .cmd = "D",
-                //.cmd_startswith = 1,
-                //.schema = "?.l0"
             };
             cmd_parser = &detach_cmd_desc;
         }
         break;
     default:
-        //could not perform the command (because its unknown)
+        // could not perform the command (because its unknown)
         mcd_put_packet("");
         break;
     }
 
     if (cmd_parser) {
-        //now parse commands and run the selected function (handler)
+        // now parse commands and run the selected function (handler)
         run_cmd_parser(line_buf, cmd_parser);
     }
 
@@ -484,63 +497,16 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
 int cmd_parse_params(const char *data, const char *schema, GArray *params)
 {
     MCDCmdVariant this_param;
-    this_param.data = data;
-    g_array_append_val(params, this_param);
-    /*
-    const char *curr_schema, *curr_data;
 
-    g_assert(schema);
-    g_assert(params->len == 0);
-
-    curr_schema = schema;
-    curr_data = data;
-    while (curr_schema[0] && curr_schema[1] && *curr_data) {
-        GdbCmdVariant this_param;
-
-        switch (curr_schema[0]) {
-        case 'l':
-            if (qemu_strtoul(curr_data, &curr_data, 16,
-                             &this_param.val_ul)) {
-                return -EINVAL;
-            }
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 'L':
-            if (qemu_strtou64(curr_data, &curr_data, 16,
-                              (uint64_t *)&this_param.val_ull)) {
-                return -EINVAL;
-            }
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 's':
-            this_param.data = curr_data;
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 'o':
-            this_param.opcode = *(uint8_t *)curr_data;
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case 't':
-            this_param.thread_id.kind =
-                read_thread_id(curr_data, &curr_data,
-                               &this_param.thread_id.pid,
-                               &this_param.thread_id.tid);
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            g_array_append_val(params, this_param);
-            break;
-        case '?':
-            curr_data = cmd_next_param(curr_data, curr_schema[1]);
-            break;
-        default:
-            return -EINVAL;
-        }
-        curr_schema += 2;
+    if (schema[0] == 's') {
+        this_param.data = data;
+        g_array_append_val(params, this_param);
     }
-    */
+    else if (schema[0] == 'i') {
+        this_param.index_handle = atoi(data);
+    g_array_append_val(params, this_param);
+    }
+
     return 0;
     
 }
@@ -566,7 +532,7 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
 
         // if a schema is provided we need to extract parameters from the data string
         if (cmd->schema) {
-            //currently doing nothing
+            // this only gets the data from data beginning after the command name
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params)) {
                 return -1;
             }
@@ -610,7 +576,6 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
         }
 
         s->c_cpu = mcd_first_attached_cpu();
-        s->g_cpu = s->c_cpu;
 
         vm_stop(RUN_STATE_PAUSED);
 		//TODO: this might not be necessary
@@ -812,7 +777,6 @@ void mcd_set_stop_cpu(CPUState *cpu)
     }
     //FIXME: we probably can delete this because in the opern_core function we set these two anyway
     mcdserver_state.c_cpu = cpu;
-    mcdserver_state.g_cpu = cpu;
 }
 
 MCDProcess *mcd_get_cpu_process(CPUState *cpu)
@@ -888,35 +852,6 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
 
     return cpu;
 }
-/*
-void handle_query_first_threads(GArray *params, void *user_ctx)
-{
-    // chache the first cpu
-    mcdserver_state.query_cpu = mcd_first_attached_cpu();
-    // new answer over tcp
-    handle_query_threads(params, user_ctx);
-}
-
-void handle_query_threads(GArray *params, void *user_ctx)
-{
-    if (!mcdserver_state.query_cpu) {
-        // send packet back that that there is no more threads
-        //gdb_put_packet("l");
-        return;
-    }
-
-    g_string_assign(mcdserver_state.str_buf, "m");
-    mcd_append_thread_id(mcdserver_state.query_cpu, mcdserver_state.str_buf);
-    mcd_put_strbuf();
-    mcdserver_state.query_cpu = mcd_next_attached_cpu(mcdserver_state.query_cpu);
-}
-
-
-void mcd_append_thread_id(CPUState *cpu, GString *buf)
-{
-    g_string_append_printf(buf, "p%02x.%02x", mcd_get_cpu_pid(cpu), mcd_get_cpu_index(cpu));
-}
-*/
 
 int mcd_get_cpu_index(CPUState *cpu)
 {
@@ -950,6 +885,34 @@ CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
 
+void handle_init(GArray *params, void *user_ctx) {
+    CPUState *cpu = mcdserver_state.c_cpu;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    gchar *arch = cc->gdb_arch_name(cpu);
+
+    // store reg groups
+    if (strcmp(arch, "arm")==0) {
+        // at the moment we just assume there are 3 spaces (gpr, per and debug)
+        // TODO: this might cause a memory leak when called a second time -> maybe free the Garray first
+        mcdserver_state.reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+
+        mcd_reg_group_st group1 = { .name = "GPR Registers", .id = "1" };
+        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group1, 1);
+
+        mcd_reg_group_st group2 = { .name = "CP15 Registers", .id = "2" };
+        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group2, 1);
+    }
+    else {
+        // we don't support other architectures
+        assert(1);
+    }
+    g_free(arch);
+
+    // the mcdserver is set up and we return the handshake
+    mcd_put_packet("shaking your hand");
+}
+
 void handle_query_system(GArray *params, void *user_ctx) {
     mcd_put_packet("qemu-system");
 }
@@ -988,7 +951,6 @@ void handle_core_open(GArray *params, void *user_ctx) {
 
     // select the the cpu as the current cpu for all request from the mcd interface
     mcdserver_state.c_cpu = cpu;
-    mcdserver_state.g_cpu = cpu;
 
 }
 
@@ -1016,10 +978,6 @@ void handle_detach(GArray *params, void *user_ctx) {
         mcdserver_state.c_cpu = mcd_first_attached_cpu();
     }
 
-    if (pid == mcd_get_cpu_pid(mcdserver_state.g_cpu)) {
-        mcdserver_state.g_cpu = mcd_first_attached_cpu();
-    }
-
     if (!mcdserver_state.c_cpu) {
         /* No more process attached */
         mcd_disable_syscalls();
@@ -1035,7 +993,7 @@ void handle_query_trigger(GArray *params, void *user_ctx) {
     uint32_t action = (MCD_TRIG_ACTION_DBG_DEBUG);
     uint32_t nr_trigger = 4;
 
-    g_string_append_printf(mcdserver_state.str_buf, "nr=\"%d\",info=\"%d;%d;%d;\"", nr_trigger, type, option, action);
+    g_string_printf(mcdserver_state.str_buf, "nr=\"%d\",info=\"%d;%d;%d;\"", nr_trigger, type, option, action);
     mcd_put_strbuf();
 }
 
@@ -1045,3 +1003,65 @@ void mcd_continue(void)
         vm_start();
     }
 }
+
+void handle_query_mem_spaces(GArray *params, void *user_ctx) {
+    // this returns the address spaces
+    // first we check if this is an arm architecture
+    // if it is arm we assume that if there are 2 address spaces, these are secure and non-secure (EL3 and EL0 for 64 bit)
+    CPUState *cpu = mcdserver_state.c_cpu;
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    int nr_address_spaces = cpu->num_ases;
+    gchar *arch = cc->gdb_arch_name(cpu);
+
+    if (strcmp(arch, "arm")==0) {
+        // we got secure and non-secure
+        g_string_printf(mcdserver_state.str_buf, "Non Secure=id:1;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        g_string_append_printf(mcdserver_state.str_buf, "Physical (Non Secure)=id:2;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        if (nr_address_spaces==2) {
+            g_string_append_printf(mcdserver_state.str_buf, "Secure=id:3;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+            g_string_append_printf(mcdserver_state.str_buf, "Physical (Secure)=id:4;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
+        }
+
+        // provide register spaces
+        // TODO: get dynamically how the per (CP15) space is called
+        g_string_append_printf(mcdserver_state.str_buf, "GPR Registers=id:5;type:1;bpm:64;i:1;e:1;min:0;max:-1;sao:0;.");
+        g_string_append_printf(mcdserver_state.str_buf, "CP15 Registers=id:6;type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); //<-- per registers
+        //g_string_append_printf(mcdserver_state.str_buf, "CP14 Registers=type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); // <-- debug registers
+    }
+    else {
+        // we don't support other architectures
+        assert(1);
+    }
+    g_free(arch);
+    mcd_put_strbuf();
+}
+
+void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
+    // send the first reg group
+    mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, 0);
+    g_string_printf(mcdserver_state.str_buf, "1!id=%s.name=%s.", group.id, group.name);
+    mcd_put_strbuf();
+}
+
+void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
+    // this funcitons send all reg groups exept for the first
+    // 1. get parameter
+    int query_index = get_param(params, 0)->index_handle;
+
+    // 2. check weather this was the last reg group
+    int nb_groups = mcdserver_state.reggroups->len;
+    if (query_index+1 == nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        // provides
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 3. send the correct reggroup
+    mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "id=%s.name=%s.", group.id, group.name);
+    mcd_put_strbuf();
+}
-- 
2.34.1


