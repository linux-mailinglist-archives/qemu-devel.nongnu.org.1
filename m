Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A57BB402
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn8-00087C-8W; Fri, 06 Oct 2023 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmy-00082u-Ja
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:29 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmu-0000ux-FB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:27 -0400
Received: (qmail 19491 invoked by uid 484); 6 Oct 2023 09:06:20 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.083181 secs); 06 Oct 2023 09:06:20 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:19 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 07/29] query data preparation improved
Date: Fri,  6 Oct 2023 11:05:48 +0200
Message-Id: <20231006090610.26171-8-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h |  35 +++-
 mcdstub/mcdstub.c   | 382 ++++++++++++++++++++++----------------------
 2 files changed, 215 insertions(+), 202 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 45ba1ca8cb..2f9a768038 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -21,6 +21,11 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
+// schema defines
+#define ARG_SCHEMA_QRY_HANDLE "q"
+#define ARG_SCHEMA_STRING "s"
+#define ARG_SCHEMA_CORE_NUM "c" 
+
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
     int base_reg;
@@ -60,17 +65,16 @@ typedef enum MCDThreadIdKind {
 
 typedef union MCDCmdVariant {
     const char *data;
-    uint8_t opcode;
-    unsigned long val_ul;
-    unsigned long long val_ull;
+    
     struct {
         MCDThreadIdKind kind;
         uint32_t pid;
         uint32_t tid;
     } thread_id;
 
-    // used to synchronize stub and dll for functions with multiple packets
-    int index_handle;
+    int query_handle;
+    int cpu_id;
+
 } MCDCmdVariant;
 
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -109,6 +113,7 @@ typedef struct MCDState {
     int supported_sstep_flags;
 
     // my stuff
+    GArray *memspaces;
     GArray *reggroups;
     GArray *registers;
 } MCDState;
@@ -116,6 +121,18 @@ typedef struct MCDState {
 /* lives in main mcdstub.c */
 extern MCDState mcdserver_state;
 
+typedef struct mcd_mem_space_st {
+    const char *name;
+    uint32_t id;
+    uint32_t type;
+    uint32_t bits_per_mau;
+    uint8_t invariance;
+    uint32_t endian;
+    uint64_t min_addr;
+    uint64_t max_addr;
+    uint32_t supported_access_options;
+} mcd_mem_space_st;
+
 typedef struct mcd_reg_group_st {
     const char *name;
     uint32_t id;
@@ -213,19 +230,23 @@ void handle_query_cores(GArray *params, void *user_ctx);
 void handle_query_system(GArray *params, void *user_ctx);
 CPUState *get_first_cpu_in_process(MCDProcess *process);
 CPUState *find_cpu(uint32_t thread_id);
-void handle_core_open(GArray *params, void *user_ctx);
+void handle_open_core(GArray *params, void *user_ctx);
 void handle_query_reset(GArray *params, void *user_ctx);
 void handle_detach(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
-void handle_query_mem_spaces(GArray *params, void *user_ctx);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx);
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx);
 void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_init(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size);
 
+// arm specific functions
+void mcd_arm_store_mem_spaces(int nr_address_spaces);
+
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 81026a42a1..b3ec3af543 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -2,6 +2,8 @@
  * This is the main mcdstub. It needs to be complemented by other mcd stubs for each target.
  */
 
+#include "mcd_shared_defines.h"
+
 //from original gdbstub.c
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
@@ -64,8 +66,13 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
         .cmd = "trigger",
     },
     {
-        .handler = handle_query_mem_spaces,
-        .cmd = "memory",
+        .handler = handle_query_mem_spaces_f,
+        .cmd = "memoryf",
+    },
+    {
+        .handler = handle_query_mem_spaces_c,
+        .cmd = "memoryc",
+        .schema = ARG_SCHEMA_QRY_HANDLE,
     },
     {
         .handler = handle_query_reg_groups_f,
@@ -74,7 +81,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
     {
         .handler = handle_query_reg_groups_c,
         .cmd = "reggroupc",
-        .schema = "i",
+        .schema = ARG_SCHEMA_QRY_HANDLE,
     },
     {
         .handler = handle_query_regs_f,
@@ -83,7 +90,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
     {
         .handler = handle_query_regs_c,
         .cmd = "regc",
-        .schema = "i",
+        .schema = ARG_SCHEMA_QRY_HANDLE,
     },
 };
 
@@ -424,20 +431,19 @@ int mcd_handle_packet(const char *line_buf)
             static const MCDCmdParseEntry gen_query_cmd_desc = {
                 .handler = handle_gen_query,
                 .cmd = "q",
-                .schema = "s"
+                .schema = ARG_SCHEMA_STRING
             };
             cmd_parser = &gen_query_cmd_desc;
         }
         break;
     case 'H':
-        //current alias for open core, later this will probably be a part of the 'i' requests
         {
-            static const MCDCmdParseEntry gen_core_open = {
-                .handler = handle_core_open,
+            static const MCDCmdParseEntry gen_open_core = {
+                .handler = handle_open_core,
                 .cmd = "H",
-                .schema = "s"
+                .schema = ARG_SCHEMA_CORE_NUM
             };
-            cmd_parser = &gen_core_open;
+            cmd_parser = &gen_open_core;
         }
         break;
     case 'D':
@@ -508,13 +514,18 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     MCDCmdVariant this_param;
 
     char data_buffer[64] = {0};
-    if (schema[0] == 's') {
+    if (schema[0] == atoi(ARG_SCHEMA_STRING)) {
         this_param.data = data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] == 'i') {
+    else if (schema[0] == atoi(ARG_SCHEMA_QRY_HANDLE)) {
         strncat(data_buffer, data, strlen(data));
-        this_param.index_handle = atoi(data_buffer);
+        this_param.query_handle = atoi(data_buffer);
+        g_array_append_val(params, this_param);
+    }
+    else if (schema[0] == atoi(ARG_SCHEMA_CORE_NUM)) {
+        strncat(data_buffer, data, strlen(data));
+        this_param.cpu_id = atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
 
@@ -618,97 +629,6 @@ void mcd_sigterm_handler(int signal)
 void mcd_vm_state_change(void *opaque, bool running, RunState state)
 {
 	printf("this calls state_change\n");
-	/*
-    CPUState *cpu = mcdserver_state.c_cpu;
-    g_autoptr(GString) buf = g_string_new(NULL);
-    g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
-    int ret;
-
-    if (running || mcdserver_state.state == RS_INACTIVE) {
-        return;
-    }
-
-    //Is there a GDB syscall waiting to be sent?
-    if (gdb_handled_syscall()) {
-        return;
-    }
-
-    if (cpu == NULL) {
-        //No process attached
-        return;
-    }
-
-    gdb_append_thread_id(cpu, tid);
-
-    switch (state) {
-    case RUN_STATE_DEBUG:
-        if (cpu->watchpoint_hit) {
-            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
-            case BP_MEM_READ:
-                type = "r";
-                break;
-            case BP_MEM_ACCESS:
-                type = "a";
-                break;
-            default:
-                type = "";
-                break;
-            }
-            trace_gdbstub_hit_watchpoint(type,
-                                         gdb_get_cpu_index(cpu),
-                                         cpu->watchpoint_hit->vaddr);
-            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
-                            GDB_SIGNAL_TRAP, tid->str, type,
-                            cpu->watchpoint_hit->vaddr);
-            cpu->watchpoint_hit = NULL;
-            goto send_packet;
-        } else {
-            trace_gdbstub_hit_break();
-        }
-        tb_flush(cpu);
-        ret = GDB_SIGNAL_TRAP;
-        break;
-    case RUN_STATE_PAUSED:
-        trace_gdbstub_hit_paused();
-        ret = GDB_SIGNAL_INT;
-        break;
-    case RUN_STATE_SHUTDOWN:
-        trace_gdbstub_hit_shutdown();
-        ret = GDB_SIGNAL_QUIT;
-        break;
-    case RUN_STATE_IO_ERROR:
-        trace_gdbstub_hit_io_error();
-        ret = GDB_SIGNAL_IO;
-        break;
-    case RUN_STATE_WATCHDOG:
-        trace_gdbstub_hit_watchdog();
-        ret = GDB_SIGNAL_ALRM;
-        break;
-    case RUN_STATE_INTERNAL_ERROR:
-        trace_gdbstub_hit_internal_error();
-        ret = GDB_SIGNAL_ABRT;
-        break;
-    case RUN_STATE_SAVE_VM:
-    case RUN_STATE_RESTORE_VM:
-        return;
-    case RUN_STATE_FINISH_MIGRATE:
-        ret = GDB_SIGNAL_XCPU;
-        break;
-    default:
-        trace_gdbstub_hit_unknown(state);
-        ret = GDB_SIGNAL_UNKNOWN;
-        break;
-    }
-    mcd_set_stop_cpu(cpu);
-    g_string_printf(buf, "T%02xthread:%s;", ret, tid->str);
-
-send_packet:
-    mcd_put_packet(buf->str);
-
-    // disable single step if it was enabled
-    cpu_single_step(cpu, 0);
-*/
 }
 
 int mcd_put_packet(const char *buf)
@@ -726,14 +646,6 @@ void mcd_put_strbuf(void)
 
 int mcd_put_packet_binary(const char *buf, int len, bool dump)
 {
-    //int csum, i;
-    //uint8_t footer[3];
-
-	//trace stuff
-    //if (dump && trace_event_get_state_backends(TRACE_GDBSTUB_IO_BINARYREPLY)) {
-    //    hexdump(buf, len, trace_gdbstub_io_binaryreply);
-    //}
-
     for(;;) {
         //super interesting if we want a chekcsum or something like that here!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
@@ -741,16 +653,7 @@ int mcd_put_packet_binary(const char *buf, int len, bool dump)
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) buf, len);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "#", 1);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "|", 1);
-        /*
-        csum = 0;
-        for(i = 0; i < len; i++) {
-            csum += buf[i];
-        }
-        footer[0] = '#';
-        footer[1] = tohex((csum >> 4) & 0xf);
-        footer[2] = tohex((csum) & 0xf);
-        g_byte_array_append(mcdserver_state.last_packet, footer, 3);
-        */
+
         mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
 
         if (mcd_got_immediate_ack()) {
@@ -1021,23 +924,145 @@ int int_cmp(gconstpointer a, gconstpointer b) {
     }
 }
 
+void mcd_arm_store_mem_spaces(int nr_address_spaces) {
+    mcd_mem_space_st space1 = {
+        .name = "Non Secure",
+        .id = 1,
+        .type = 34,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space1, 1);
+
+    mcd_mem_space_st space2 = {
+        .name = "Physical (Non Secure)",
+        .id = 2,
+        .type = 18,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space2, 1);
+
+    if (nr_address_spaces==2) {
+        mcd_mem_space_st space3 = {
+        .name = "Secure",
+        .id = 3,
+        .type = 34,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space3, 1);
+    mcd_mem_space_st space4 = {
+        .name = "Physical (Secure)",
+        .id = 4,
+        .type = 18,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space4, 1);
+    }
+    // TODO: get dynamically how the per (CP15) space is called
+    mcd_mem_space_st space5 = {
+        .name = "GPR Registers",
+        .id = 5,
+        .type = 1,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space5, 1);
+    mcd_mem_space_st space6 = {
+        .name = "CP15 Registers",
+        .id = 6,
+        .type = 1,
+        .bits_per_mau = 8,
+        .invariance = 1,
+        .endian = 1,
+        .min_addr = 0,
+        .max_addr = -1,
+        .supported_access_options = 0,
+    };
+    g_array_append_vals(mcdserver_state.memspaces, (gconstpointer)&space6, 1);
+}
+
 void handle_init(GArray *params, void *user_ctx) {
-    CPUState *cpu = mcdserver_state.c_cpu;
+    // the mcdserver is set up and we return the handshake
+    mcd_put_packet("shaking your hand"); 
+}
+
+void handle_query_system(GArray *params, void *user_ctx) {
+    mcd_put_packet("qemu-system");
+}
+
+void handle_query_cores(GArray *params, void *user_ctx) {
+    //TODO: add cluster support: in gdb each inferior (process) handles one cluster we might want to have sth similar here
+
+    // get first cpu
+    CPUState *cpu = mcd_first_attached_cpu();
+    if (!cpu) {
+        return;
+    }
+
+    ObjectClass *oc = object_get_class(OBJECT(cpu));
+    const char *cpu_model = object_class_get_name(oc);
+
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    gchar *arch = cc->gdb_arch_name(cpu);
+    
+    int nr_cores = cpu->nr_cores;
+
+    g_string_append_printf(mcdserver_state.str_buf, "device=\"qemu-%s-device\",core=\"%s\",nr_cores=\"%d\"", arch, cpu_model, nr_cores);
+    mcd_put_strbuf();
+    g_free(arch);
+}
+
+void handle_open_core(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     gchar *arch = cc->gdb_arch_name(cpu);
 
+    // TODO: this might cause a memory leak when called a second time -> maybe free the Garray first
+    mcdserver_state.memspaces = g_array_new(false, true, sizeof(mcd_mem_space_st));
+    mcdserver_state.reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+    mcdserver_state.registers = g_array_new(false, true, sizeof(mcd_reg_st));
+
     
     if (strcmp(arch, "arm")==0) {
         // store reg groups
         uint32_t current_group_id = 0;
 
         // at the moment we just assume there are 3 spaces (gpr, per and debug)
-        // TODO: this might cause a memory leak when called a second time -> maybe free the Garray first
-        mcdserver_state.reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
+        
+        // store mem spaces
+        int nr_address_spaces = cpu->num_ases;
+        mcd_arm_store_mem_spaces(nr_address_spaces);
+        // mem spaces done
+
 
-        // store the registers themselves
-        mcdserver_state.registers = g_array_new(false, true, sizeof(mcd_reg_st));
         GList *register_numbers = NULL;
 
         const char *xml_filename = NULL;
@@ -1140,49 +1165,9 @@ void handle_init(GArray *params, void *user_ctx) {
     }
     else {
         // we don't support other architectures
-        assert(1);
+        assert(0);
     }
     g_free(arch);
-
-    // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand"); 
-}
-
-void handle_query_system(GArray *params, void *user_ctx) {
-    mcd_put_packet("qemu-system");
-}
-
-void handle_query_cores(GArray *params, void *user_ctx) {
-    //TODO: add cluster support: in gdb each inferior (process) handles one cluster we might want to have sth similar here
-
-    // get first cpu
-    CPUState *cpu = mcd_first_attached_cpu();
-    if (!cpu) {
-        return;
-    }
-
-    ObjectClass *oc = object_get_class(OBJECT(cpu));
-    const char *cpu_model = object_class_get_name(oc);
-
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    gchar *arch = cc->gdb_arch_name(cpu);
-    
-    int nr_cores = cpu->nr_cores;
-
-    g_string_append_printf(mcdserver_state.str_buf, "device=\"qemu-%s-device\",core=\"%s\",nr_cores=\"%d\"", arch, cpu_model, nr_cores);
-    mcd_put_strbuf();
-    g_free(arch);
-}
-
-void handle_core_open(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
-    uint32_t cpu_id = atoi(get_param(params, 0)->data);
-
-    CPUState *cpu = mcd_get_cpu(cpu_id);
-
-    // select the the cpu as the current cpu for all request from the mcd interface
-    mcdserver_state.c_cpu = cpu;
-
 }
 
 void handle_query_reset(GArray *params, void *user_ctx) {
@@ -1235,36 +1220,43 @@ void mcd_continue(void)
     }
 }
 
-void handle_query_mem_spaces(GArray *params, void *user_ctx) {
-    // this returns the address spaces
-    // first we check if this is an arm architecture
-    // if it is arm we assume that if there are 2 address spaces, these are secure and non-secure (EL3 and EL0 for 64 bit)
-    CPUState *cpu = mcdserver_state.c_cpu;
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    int nr_address_spaces = cpu->num_ases;
-    gchar *arch = cc->gdb_arch_name(cpu);
+void handle_query_mem_spaces_f(GArray *params, void *user_ctx) {
+    // send the first mem space
+    int nb_groups = mcdserver_state.memspaces->len;
+    if (nb_groups == 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    mcd_mem_space_st space = g_array_index(mcdserver_state.memspaces, mcd_mem_space_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "name=%s.id=%d.type=%d.bpm=%d.i=%d.e=%d.min=%ld.max=%ld.sao=%d.",
+        space.name, space.id, space.type, space.bits_per_mau, space.invariance, space.endian,
+        space.min_addr, space.max_addr, space.supported_access_options);
+    mcd_put_strbuf();
+}
 
-    if (strcmp(arch, "arm")==0) {
-        // we got secure and non-secure
-        g_string_printf(mcdserver_state.str_buf, "Non Secure=id:1;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        g_string_append_printf(mcdserver_state.str_buf, "Physical (Non Secure)=id:2;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        if (nr_address_spaces==2) {
-            g_string_append_printf(mcdserver_state.str_buf, "Secure=id:3;type:34;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-            g_string_append_printf(mcdserver_state.str_buf, "Physical (Secure)=id:4;type:18;bpm:8;i:1;e:1;min:0;max:-1;sao:0;.");
-        }
+void handle_query_mem_spaces_c(GArray *params, void *user_ctx) {
+    // this funcitons send all mem spaces except for the first
+    // 1. get parameter
+    int query_index = get_param(params, 0)->query_handle;
 
-        // provide register spaces
-        // TODO: get dynamically how the per (CP15) space is called
-        g_string_append_printf(mcdserver_state.str_buf, "GPR Registers=id:5;type:1;bpm:64;i:1;e:1;min:0;max:-1;sao:0;.");
-        g_string_append_printf(mcdserver_state.str_buf, "CP15 Registers=id:6;type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); //<-- per registers
-        //g_string_append_printf(mcdserver_state.str_buf, "CP14 Registers=type:1;bpm:32;i:1;e:1;min:0;max:-1;sao:0;."); // <-- debug registers
+    // 2. check weather this was the last mem space
+    int nb_groups = mcdserver_state.memspaces->len;
+    if (query_index+1 == nb_groups) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
     }
     else {
-        // we don't support other architectures
-        assert(1);
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
     }
-    g_free(arch);
+
+    // 3. send the correct memspace
+    mcd_mem_space_st space = g_array_index(mcdserver_state.memspaces, mcd_mem_space_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "name=%s.id=%d.type=%d.bpm=%d.i=%d.e=%d.min=%ld.max=%ld.sao=%d.",
+        space.name, space.id, space.type, space.bits_per_mau, space.invariance, space.endian,
+        space.min_addr, space.max_addr, space.supported_access_options);
     mcd_put_strbuf();
 }
 
@@ -1286,7 +1278,7 @@ void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
     // this funcitons send all reg groups except for the first
     // 1. get parameter
-    int query_index = get_param(params, 0)->index_handle;
+    int query_index = get_param(params, 0)->query_handle;
 
     // 2. check weather this was the last reg group
     int nb_groups = mcdserver_state.reggroups->len;
@@ -1324,7 +1316,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx) {
 void handle_query_regs_c(GArray *params, void *user_ctx) {
     // this funcitons send all registers except for the first
     // 1. get parameter
-    int query_index = get_param(params, 0)->index_handle;
+    int query_index = get_param(params, 0)->query_handle;
 
     // 2. check weather this was the last register
     int nb_regs = mcdserver_state.registers->len;
-- 
2.34.1


