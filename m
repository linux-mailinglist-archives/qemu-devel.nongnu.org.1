Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F369F7BB3D6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognT-0008Db-Nz; Fri, 06 Oct 2023 05:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognK-00089p-DB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:50 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognF-0000yK-U2
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:50 -0400
Received: (qmail 19699 invoked by uid 484); 6 Oct 2023 09:06:33 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.162807 secs); 06 Oct 2023 09:06:33 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:31 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 14/29] handler for single step added
Date: Fri,  6 Oct 2023 11:05:55 +0200
Message-Id: <20231006090610.26171-15-nicolas.eder@lauterbach.com>
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
 include/exec/mcdstub.h       |   6 +-
 include/mcdstub/syscalls.h   |   4 +-
 mcdstub/internals.h          |  77 +++----
 mcdstub/mcd_shared_defines.h |   3 +-
 mcdstub/mcdstub.c            | 428 ++++++++++++++---------------------
 softmmu/cpus.c               |   2 +-
 target/arm/mcdstub.c         |  66 +++++-
 target/arm/mcdstub.h         |   1 +
 8 files changed, 269 insertions(+), 318 deletions(-)

diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
index abf7beb634..132f32417c 100644
--- a/include/exec/mcdstub.h
+++ b/include/exec/mcdstub.h
@@ -3,10 +3,8 @@
 
 #define DEFAULT_MCDSTUB_PORT "1235"
 #define TYPE_CHARDEV_MCD "chardev-mcd"
-#define MX_INPUT_LENGTH 9
-#define MCD_TCP_DATALEN 80
 
-/* MCD breakpoint/watchpoint types */
+// breakpoint defines
 #define MCD_BREAKPOINT_SW        0
 #define MCD_BREAKPOINT_HW        1
 #define MCD_WATCHPOINT_WRITE     2
@@ -16,8 +14,6 @@
 /**
  * mcd_tcp_server_start: start the tcp server to connect via mcd
  * @device: connection spec for mcd
- *
- * This is a TCP port
  */
 int mcdserver_start(const char *device);
 
diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
index 1f86634140..92ae7f4e77 100644
--- a/include/mcdstub/syscalls.h
+++ b/include/mcdstub/syscalls.h
@@ -1,5 +1,5 @@
-#ifndef _SYSCALLS_H_
-#define _SYSCALLS_H_
+#ifndef _MCD_SYSCALLS_H_
+#define _MCD_SYSCALLS_H_
 
 typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int err);
 
diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 871a58f8ea..0afab434ce 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -1,8 +1,3 @@
-/*
- * this header includes a lookup table for the transmitted messages over the tcp connection to trace32,
- * as well as function declarations for all functios used inside the mcdstub
- */
-
 #ifndef MCDSTUB_INTERNALS_H
 #define MCDSTUB_INTERNALS_H
 
@@ -10,19 +5,33 @@
 #include "chardev/char.h"
 #include "hw/core/cpu.h"
 // just used for the register xml files
-#include "exec/gdbstub.h"       /* xml_builtin */
+#include "exec/gdbstub.h"
 
 #define MAX_PACKET_LENGTH 1024
 
 // trigger defines
-#define MCD_TRIG_TYPE_IP 0x00000001
-#define MCD_TRIG_TYPE_READ 0x00000002
-#define MCD_TRIG_TYPE_WRITE 0x00000004
-#define MCD_TRIG_TYPE_RW 0x00000008
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
+typedef uint32_t mcd_trig_type_et;
+// TODO: replace mcd defines with custom layer
+enum {
+	MCD_TRIG_TYPE_UNDEFINED = 0x00000000, /**< Undefined trigger type.                                                   */
+	MCD_TRIG_TYPE_IP        = 0x00000001, /**< Trigger on a changing instruction pointer.                                */
+	MCD_TRIG_TYPE_READ      = 0x00000002, /**< Trigger on a read data access to a specific address or address range.     */
+	MCD_TRIG_TYPE_WRITE     = 0x00000004, /**< Trigger on a write data access to a specific address or address range.    */
+	MCD_TRIG_TYPE_RW        = 0x00000008, /**< Trigger on a read or a write data access to a specific address or
+		   address range.                                                            */
+	MCD_TRIG_TYPE_NOCYCLE   = 0x00000010, /**< Trigger on core information other than an IP or data compare trigger.     */
+	MCD_TRIG_TYPE_TRIG_BUS  = 0x00000020, /**< Trigger on a trigger bus combination.                                     */
+	MCD_TRIG_TYPE_COUNTER   = 0x00000040, /**< Trigger on an elapsed trigger counter.                                    */
+	MCD_TRIG_TYPE_CUSTOM    = 0x00000080, /**< Custom trigger using standard format as defined by \ref mcd_trig_custom_st. */
+	MCD_TRIG_TYPE_CUSTOM_LO = 0x00010000, /**< Begin Range: User defined trigger types.                                  */
+	MCD_TRIG_TYPE_CUSTOM_HI = 0x40000000, /**< End   Range: User defined trigger types.                                  */
+};
+
 typedef uint32_t mcd_core_event_et;
+// TODO: replace mcd defines with custom layer
 enum {
 	MCD_CORE_EVENT_NONE            = 0x00000000,   /**< No since the last poll.                                 */
 	MCD_CORE_EVENT_MEMORY_CHANGE   = 0x00000001,   /**< Memory content has changed.                             */
@@ -50,10 +59,11 @@ enum {
 #define RESET_GPR "gpr_reset"
 #define RESET_MEMORY "memory_reset"
 
-// more
-#define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the end
+// misc
+#define QUERY_TOTAL_NUMBER 12 
 #define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
+
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
 
@@ -65,13 +75,14 @@ enum {
 #define STATE_STR_INIT_HALTED "vm halted since boot"
 #define STATE_STR_INIT_RUNNING "vm running since boot"
 #define STATE_STR_BREAK_HW "stopped beacuse of HW breakpoint"
+#define STATE_STEP_PERFORMED "stopped beacuse of single step"
 #define STATE_STR_BREAK_READ(d) "stopped beacuse of read access at " #d
 #define STATE_STR_BREAK_WRITE(d) "stopped beacuse of write access at " #d
 #define STATE_STR_BREAK_RW(d) "stopped beacuse of read or write access at " #d
 #define STATE_STR_BREAK_UNKNOWN "stopped for unknown reason"
 
-// GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
+    // needed for the used gdb functions
     int base_reg;
     int num_regs;
     gdb_get_reg_cb get_reg;
@@ -80,12 +91,7 @@ typedef struct GDBRegisterState {
     struct GDBRegisterState *next;
 } GDBRegisterState;
 
-/*
- * struct for an MCD Process, each process can establish one connection
- */
-
 typedef struct MCDProcess {
-    //this is a relict from the gdb process, we might be able to delete this
     uint32_t pid;
     bool attached;
 
@@ -99,35 +105,16 @@ typedef struct MCDCmdParseEntry {
     char schema[CMD_SCHEMA_LENGTH];
 } MCDCmdParseEntry;
 
-typedef enum MCDThreadIdKind {
-    GDB_ONE_THREAD = 0,
-    GDB_ALL_THREADS,     /* One process, all threads */
-    GDB_ALL_PROCESSES,
-    GDB_READ_THREAD_ERR
-} MCDThreadIdKind;
-
 typedef union MCDCmdVariant {
     const char *data;
     int data_int;
     uint64_t data_uint64_t;
     int query_handle;
     int cpu_id;
-    struct {
-        MCDThreadIdKind kind;
-        uint32_t pid;
-        uint32_t tid;
-    } thread_id;
-
 } MCDCmdVariant;
 
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
 
-
-/*
- * not sure for what this is used exactly
- */
-
-
 enum RSState {
     RS_INACTIVE,
     RS_IDLE,
@@ -162,19 +149,14 @@ typedef struct MCDState {
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
     int signal;
-    //the next one is about stub compatibility and we should be able to assume this is true anyway
-    //bool multiprocess;
+
     MCDProcess *processes;
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
-    // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
 
-    // my stuff
-    RunState vm_current_state;
-    RunState vm_previous_state;
     uint32_t query_cpu_id;
     GList *all_memspaces;
     GList *all_reggroups;
@@ -236,9 +218,6 @@ typedef struct mcd_reset_st {
     uint8_t id;
 } mcd_reset_st;
 
-// Inline utility function, convert from int to hex and back
-
-
 static inline int fromhex(int v)
 {
     if (v >= '0' && v <= '9') {
@@ -283,7 +262,6 @@ int mcd_put_packet(const char *buf);
 int mcd_put_packet_binary(const char *buf, int len, bool dump);
 bool mcd_got_immediate_ack(void);
 void mcd_put_buffer(const uint8_t *buf, int len);
-void mcd_set_stop_cpu(CPUState *cpu);
 MCDProcess *mcd_get_cpu_process(CPUState *cpu);
 uint32_t mcd_get_cpu_pid(CPUState *cpu);
 MCDProcess *mcd_get_process(uint32_t pid);
@@ -297,6 +275,7 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds);
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
 void handle_vm_start(GArray *params, void *user_ctx);
+void handle_vm_step(GArray *params, void *user_ctx);
 void handle_vm_stop(GArray *params, void *user_ctx);
 void handle_gen_query(GArray *params, void *user_ctx);
 int mcd_get_cpu_index(CPUState *cpu);
@@ -312,6 +291,7 @@ void handle_close_server(GArray *params, void *user_ctx);
 void handle_close_core(GArray *params, void *user_ctx);
 void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_vm_start(void);
+int mcd_vm_sstep(CPUState *cpu);
 void mcd_vm_stop(void);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
@@ -328,6 +308,7 @@ void handle_write_register(GArray *params, void *user_ctx);
 void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 
@@ -337,7 +318,7 @@ int mcd_arm_parse_core_xml_file(CPUClass *cc, GArray* reggroups, GArray* registe
 int mcd_arm_parse_general_xml_files(CPUState *cpu, GArray* reggroups, GArray* registers, int* current_group_id);
 int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers);
 
-/* sycall handling */
+// sycall handling
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
 
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index f2f4d31335..311d24e12f 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -6,7 +6,8 @@
 // tcp data characters
 #define TCP_CHAR_OPEN_SERVER 'I'
 #define TCP_CHAR_OPEN_CORE 'i'
-#define TCP_CHAR_GO 'c'
+#define TCP_CHAR_GO 'C'
+#define TCP_CHAR_STEP 'c'
 #define TCP_CHAR_BREAK 'b'
 #define TCP_CHAR_QUERY 'q'
 #define TCP_CHAR_CLOSE_SERVER 'D'
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 88f321a068..d65b0a54d2 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1,10 +1,9 @@
 /*
- * This is the main mcdstub. It needs to be complemented by other mcd stubs for each target.
+ * This is the main mcdstub.
  */
 
 #include "mcd_shared_defines.h"
 
-//from original gdbstub.c
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -14,15 +13,12 @@
 #include "mcdstub/syscalls.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
-
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "exec/replay-core.h"
 #include "exec/hwaddr.h"
-
 #include "internals.h"
 
-//from original softmmu.c (minus what was already here)
 #include "qapi/error.h"
 #include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
@@ -31,7 +27,7 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 
-//architecture specific stuff
+// architecture specific stubs
 #include "target/arm/mcdstub.h"
 
 // FIXME: delete the following line and check if it worked
@@ -39,7 +35,6 @@
 
 typedef struct {
     CharBackend chr;
-    //Chardev *mon_chr;
 } MCDSystemState;
 
 MCDSystemState mcdserver_system_state;
@@ -60,8 +55,6 @@ void mcd_init_mcdserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-	// TODO:
-	// this is weird and we might not actually need it after all
     mcdserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
     mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
@@ -106,7 +99,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_reset_c,
         .cmd = QUERY_ARG_RESET QUERY_CONSEQUTIVE,
     };
-    strcpy(query_reset_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    strcpy(query_reset_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_reset_c;
     cmd_number++;
 
@@ -121,7 +114,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_mem_spaces_f,
         .cmd = QUERY_ARG_MEMORY QUERY_FIRST,
     };
-    strcpy(query_mem_spaces_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    strcpy(query_mem_spaces_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] = query_mem_spaces_f;
     cmd_number++;
 
@@ -129,7 +122,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_mem_spaces_c,
         .cmd = QUERY_ARG_MEMORY QUERY_CONSEQUTIVE,
     };
-    strcpy(query_mem_spaces_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    strcpy(query_mem_spaces_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_mem_spaces_c;
     cmd_number++;
 
@@ -137,7 +130,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_reg_groups_f,
         .cmd = QUERY_ARG_REGGROUP QUERY_FIRST,
     };
-    strcpy(query_reg_groups_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    strcpy(query_reg_groups_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] = query_reg_groups_f;
     cmd_number++;
 
@@ -145,7 +138,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_reg_groups_c,
         .cmd = QUERY_ARG_REGGROUP QUERY_CONSEQUTIVE,
     };
-    strcpy(query_reg_groups_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    strcpy(query_reg_groups_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_reg_groups_c;
     cmd_number++;
 
@@ -153,7 +146,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_regs_f,
         .cmd = QUERY_ARG_REG QUERY_FIRST,
     };
-    strcpy(query_regs_f.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    strcpy(query_regs_f.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] = query_regs_f;
     cmd_number++;
 
@@ -161,7 +154,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_regs_c,
         .cmd = QUERY_ARG_REG QUERY_CONSEQUTIVE,
     };
-    strcpy(query_regs_c.schema, (char[2]) { (char) ARG_SCHEMA_QRYHANDLE, '\0' });
+    strcpy(query_regs_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_regs_c;
     cmd_number++;
 
@@ -169,7 +162,7 @@ void init_query_cmds_table(MCDCmdParseEntry* mcd_query_cmds_table) {
         .handler = handle_query_state,
         .cmd = QUERY_ARG_STATE,
     };
-    strcpy(query_state.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+    strcpy(query_state.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
     mcd_query_cmds_table[cmd_number] = query_state;
 }
 
@@ -258,12 +251,8 @@ int pid_order(const void *a, const void *b)
 
 int mcdserver_start(const char *device)
 {
-    //might wann add tracing later (no idea for what this is used)
-    //trace_gdbstub_op_start(device);
-
     char mcdstub_device_name[128];
     Chardev *chr = NULL;
-    //Chardev *mon_chr;
 
     if (!first_cpu) {
         error_report("mcdstub: meaningless to attach to a "
@@ -271,7 +260,6 @@ int mcdserver_start(const char *device)
         return -1;
     }
 
-    //
     if (!mcd_supports_guest_debug()) {
         error_report("mcdstub: current accelerator doesn't "
                      "support guest debugging");
@@ -282,7 +270,7 @@ int mcdserver_start(const char *device)
         return -1;
     }
 
-    //if device == default -> set device = tcp::1235
+    // if device == default -> set device = tcp::1235
     if (strcmp(device, "default") == 0) {
         device = "tcp::1235";
     }
@@ -303,7 +291,6 @@ int mcdserver_start(const char *device)
             sigaction(SIGINT, &act, NULL);
         }
 #endif
-        
         chr = qemu_chr_new_noreplay("mcd", device, true, NULL);
         if (!chr) {
             return -1;
@@ -314,13 +301,8 @@ int mcdserver_start(const char *device)
         mcd_init_mcdserver_state();
 
         qemu_add_vm_change_state_handler(mcd_vm_state_change, NULL);
-
-        /* Initialize a monitor terminal for mcd */
-        //mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_MCD, NULL, NULL, &error_abort);
-        //monitor_init_hmp(mon_chr, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
-        //mon_chr = mcdserver_system_state.mon_chr;
         reset_mcdserver_state();
     }
 
@@ -334,7 +316,6 @@ int mcdserver_start(const char *device)
                                  NULL, &mcdserver_state, NULL, true);
     }
     mcdserver_state.state = chr ? RS_IDLE : RS_INACTIVE;
-    //mcdserver_system_state.mon_chr = mon_chr;
     mcd_syscall_reset();
 
     return 0;
@@ -360,107 +341,80 @@ void mcd_read_byte(uint8_t ch)
     uint8_t reply;
 
     if (mcdserver_state.last_packet->len) {
-        /* Waiting for a response to the last packet.  If we see the start
-           of a new command then abandon the previous response.  */
         if (ch == TCP_NOT_ACKNOWLEDGED) {
-            //the previous packet was not akcnowledged
-            //trace_gdbstub_err_got_nack();
-            //we are resending the last packet
+            // the previous packet was not akcnowledged
             mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
         }
         else if (ch == TCP_ACKNOWLEDGED) {
-            //the previous packet was acknowledged
-            //trace_gdbstub_io_got_ack();
+            // the previous packet was acknowledged
         }
 
         if (ch == TCP_ACKNOWLEDGED || ch == TCP_COMMAND_START) {
-            //either acknowledged or a new communication starts -> we discard previous communication
+            // either acknowledged or a new communication starts -> discard previous packet
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
         if (ch != TCP_COMMAND_START) {
-            // we only continue if we are processing a new commant. otherwise we skip to ne next character in the packet which sould be a $
+            // skip to the next char
             return;
         }
     }
-    //if (runstate_is_running()) {
-        /* when the CPU is running, we cannot do anything except stop
-           it when receiving a char */
-        //vm_stop(RUN_STATE_PAUSED);
-    //}
-    //else {
-        switch(mcdserver_state.state) {
-        case RS_IDLE:
-            if (ch == TCP_COMMAND_START) {
-                /* start of command packet */
-                mcdserver_state.line_buf_index = 0;
-                mcdserver_state.line_sum = 0;
-                mcdserver_state.state = RS_GETLINE;
-            }
-            else {
-                //new communication has to start with a $
-                //trace_gdbstub_err_garbage(ch);
-            }
-            break;
-        case RS_GETLINE:
-            if (ch == TCP_COMMAND_END) {
-                /* end of command, start of checksum*/
-                mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
-                //mcdserver_state.line_sum += ch;
-                mcdserver_state.state = RS_DATAEND;
-            }
-            else if (mcdserver_state.line_buf_index >= sizeof(mcdserver_state.line_buf) - 1) {
-                //the input string is too long for the linebuffer!
-                //trace_gdbstub_err_overrun();
-                mcdserver_state.state = RS_IDLE;
-            }
-            else {
-                /* unescaped command character */
-                //this means the character is part of the real content fo the packet and we copy it to the line_buf
-                mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = ch;
-                mcdserver_state.line_sum += ch;
-            }
-            break;
-        case RS_DATAEND:
-            // we are now done with copying the data and in the suffix of the packet
-            // TODO: maybe wanna implement a checksum or sth like the gdb protocol has
-
-            if (ch == TCP_WAS_NOT_LAST) {
-                // ~ indicates that there is an additional package coming
-                //acknowledged -> send +
-                reply = TCP_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
-            }
-            else if (ch == TCP_WAS_LAST) {
-                //acknowledged -> send +
-                // | indicates that there is no additional package coming
-                reply = TCP_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
-            }
-            else {
-                //trace_gdbstub_err_checksum_incorrect(mcdserver_state.line_sum, mcdserver_state.line_csum);
-                //not acknowledged -> send -
-                reply = TCP_NOT_ACKNOWLEDGED;
-                mcd_put_buffer(&reply, 1);
-                //waiting for package to get resent
-                mcdserver_state.state = RS_IDLE;
-            }
-            break;
-        default:
-            abort();
+
+    switch(mcdserver_state.state) {
+    case RS_IDLE:
+        if (ch == TCP_COMMAND_START) {
+            // start of command packet
+            mcdserver_state.line_buf_index = 0;
+            mcdserver_state.line_sum = 0;
+            mcdserver_state.state = RS_GETLINE;
+        }
+        break;
+    case RS_GETLINE:
+        if (ch == TCP_COMMAND_END) {
+            // end of command
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
+            mcdserver_state.state = RS_DATAEND;
+        }
+        else if (mcdserver_state.line_buf_index >= sizeof(mcdserver_state.line_buf) - 1) {
+            // the input string is too long for the linebuffer!
+            mcdserver_state.state = RS_IDLE;
+        }
+        else {
+            // copy the content to the line_buf
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = ch;
+            mcdserver_state.line_sum += ch;
+        }
+        break;
+    case RS_DATAEND:
+        if (ch == TCP_WAS_NOT_LAST) {
+            reply = TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
+        }
+        else if (ch == TCP_WAS_LAST) {
+            reply = TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
         }
-    //}
+        else {
+            // not acknowledged!
+            reply = TCP_NOT_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            // waiting for package to get resent
+            mcdserver_state.state = RS_IDLE;
+        }
+        break;
+    default:
+        abort();
+    }
 }
 
 int mcd_handle_packet(const char *line_buf)
 {
-    // decides what function (handler) to call depending on what the first character in the line_buf is!
+    // decides what function (handler) to call depending on the first character in the line_buf
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
     case TCP_CHAR_OPEN_SERVER:
-        // handshake and lookup initialization
         {
             static MCDCmdParseEntry open_server_cmd_desc = {
                 .handler = handle_open_server,
@@ -470,7 +424,6 @@ int mcd_handle_packet(const char *line_buf)
         }
         break;
     case TCP_CHAR_GO:
-        // go command
         {
             static MCDCmdParseEntry go_cmd_desc = {
                 .handler = handle_vm_start,
@@ -479,8 +432,17 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &go_cmd_desc;
         }
         break;
+    case TCP_CHAR_STEP:
+        {
+            static MCDCmdParseEntry step_cmd_desc = {
+                .handler = handle_vm_step,
+            };
+            step_cmd_desc.cmd = (char[2]) { TCP_CHAR_STEP, '\0' };
+            strcpy(step_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+            cmd_parser = &step_cmd_desc;
+        }
+        break;
     case TCP_CHAR_BREAK:
-        // go command
         {
             static MCDCmdParseEntry break_cmd_desc = {
                 .handler = handle_vm_stop,
@@ -495,7 +457,6 @@ int mcd_handle_packet(const char *line_buf)
         mcd_exit(0);
         exit(0);
     case TCP_CHAR_QUERY:
-        //query inquiry
         {
             static MCDCmdParseEntry query_cmd_desc = {
                 .handler = handle_gen_query,
@@ -550,7 +511,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_read_register,
             };
             read_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_REGISTER, '\0' };
-            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, '\0' });
             cmd_parser = &read_reg_cmd_desc;
         }
         break;
@@ -560,7 +521,7 @@ int mcd_handle_packet(const char *line_buf)
                 .handler = handle_write_register,
             };
             write_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
-            strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            strcpy(write_reg_cmd_desc.schema, (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser = &write_reg_cmd_desc;
         }
         break;
@@ -585,13 +546,13 @@ int mcd_handle_packet(const char *line_buf)
         }
         break;
     default:
-        // could not perform the command (because its unknown)
+        // command not supported
         mcd_put_packet("");
         break;
     }
 
     if (cmd_parser) {
-        // now parse commands and run the selected function (handler)
+        // parse commands and run the selected handler function
         run_cmd_parser(line_buf, cmd_parser);
     }
 
@@ -599,21 +560,29 @@ int mcd_handle_packet(const char *line_buf)
 }
 
 void handle_vm_start(GArray *params, void *user_ctx) {
-    // todo add partial restart with arguments and so on
+    // TODO: add partial restart with arguments and so on
     mcd_vm_start();
 }
 
+void handle_vm_step(GArray *params, void *user_ctx) {
+    // TODO: add partial restart with arguments and so on
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcd_vm_sstep(cpu);
+}
+
+
 void handle_vm_stop(GArray *params, void *user_ctx) {
-    // todo add partial stop with arguments and so on
+    // TODO: add partial stop with arguments and so on
     mcd_vm_stop();
 }
 
-void handle_gen_query(GArray *params, void *user_ctx)
-{
+void handle_gen_query(GArray *params, void *user_ctx) {
     if (!params->len) {
         return;
     }
-    //now iterate over all possible query functions and execute the right one
+    // iterate over all possible query functions and execute the right one
     if (process_string_cmd(NULL, get_param(params, 0)->data,
                            mcdserver_state.mcd_query_cmds_table,
                            ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table))) {
@@ -621,8 +590,7 @@ void handle_gen_query(GArray *params, void *user_ctx)
     }
 }
 
-void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
-{
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd) {
     if (!data) {
         return;
     }
@@ -630,8 +598,6 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
     g_string_set_size(mcdserver_state.str_buf, 0);
     g_byte_array_set_size(mcdserver_state.mem_buf, 0);
 
-    /* In case there was an error during the command parsing we must
-    * send a NULL packet to indicate the command is not supported */
     if (process_string_cmd(NULL, data, cmd, 1)) {
         mcd_put_packet("");
     }
@@ -655,11 +621,11 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     const char *remaining_data = data;
     
     for (int i = 0; i<strlen(schema); i++) {
-        // get correct part of string
+        // get correct part of data
         char *separator = strchr(remaining_data, ARGUMENT_SEPARATOR);
 
         if (separator) {
-            // we multiple arguments left
+            // multiple arguments
             int seperator_index = (int)(separator - remaining_data);
             strncpy(data_buffer, remaining_data, seperator_index);
             data_buffer[seperator_index] = 0;
@@ -675,12 +641,11 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
         MCDCmdVariant this_param; 
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            // a string has to be the last argument
+            // this has to be the last argument
             this_param.data = remaining_data;
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_HEXDATA:
-            // a string has to be the last argument
             g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
             break;
         case ARG_SCHEMA_INT:
@@ -706,8 +671,7 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     return 0;
 }
 
-int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds)
-{
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds) {
     int i;
     g_autoptr(GArray) params = g_array_new(false, true, sizeof(MCDCmdVariant));
 
@@ -717,23 +681,21 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
 
     for (i = 0; i < num_cmds; i++) {
         const MCDCmdParseEntry *cmd = &cmds[i];
-        //terminate if we don't have handler and cmd
         g_assert(cmd->handler && cmd->cmd);
 
-        // if data and command are different continue
+        // continue if data and command are different
         if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
             continue;
         }
 
-        // if a schema is provided we need to extract parameters from the data string
         if (strlen(cmd->schema)) {
-            // this only gets the data from data beginning after the command name
+            // extract data for parameters
             if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params)) {
                 return -1;
             }
         }
 
-        // the correct handler function is called
+        // call handler
         cmd->handler(params, user_ctx);
         return 0;
     }
@@ -741,25 +703,16 @@ int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry
     return -1;
 }
 
-void mcd_exit(int code)
-{
-    char buf[4];
-
+void mcd_exit(int code) {
+    // terminate qemu
     if (!mcdserver_state.init) {
         return;
     }
 
-    //trace_gdbstub_op_exiting((uint8_t)code);
-
-    //need to check what is sent here and dapt it to my needs
-    snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
-    mcd_put_packet(buf);
-
     qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
 }
 
-void mcd_chr_event(void *opaque, QEMUChrEvent event)
-{
+void mcd_chr_event(void *opaque, QEMUChrEvent event) {
     int i;
     MCDState *s = (MCDState *) opaque;
 
@@ -771,19 +724,13 @@ void mcd_chr_event(void *opaque, QEMUChrEvent event)
         }
 
         s->c_cpu = mcd_first_attached_cpu();
-
-        //vm_stop(RUN_STATE_PAUSED);
-		//TODO: this might not be necessary
-        //replay_gdb_attached();
-        //gdb_has_xml = false;
         break;
     default:
         break;
     }
 }
 
-bool mcd_supports_guest_debug(void)
-{
+bool mcd_supports_guest_debug(void) {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->supports_guest_debug) {
         return ops->supports_guest_debug();
@@ -792,29 +739,23 @@ bool mcd_supports_guest_debug(void)
 }
 
 #ifndef _WIN32
-void mcd_sigterm_handler(int signal)
-{
+void mcd_sigterm_handler(int signal) {
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_PAUSED);
     }
 }
 #endif
 
-void mcd_vm_state_change(void *opaque, bool running, RunState state)
-{
+void mcd_vm_state_change(void *opaque, bool running, RunState state) {
 	CPUState *cpu = mcdserver_state.c_cpu;
 
-    // update cpu state
-    mcdserver_state.vm_previous_state = mcdserver_state.vm_current_state;
-    mcdserver_state.vm_current_state = state;
-
     if (mcdserver_state.state == RS_INACTIVE) {
         return;
     }
 
     if (cpu == NULL) {
         if (running) {
-            // this is the case if qemu starts the vm before any mcd is connected
+            // this is the case if qemu starts the vm before a mcd client is connected
             const char *mcd_state;
             mcd_state = CORE_STATE_RUNNING;
             const char *info_str;
@@ -857,8 +798,13 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
                 stop_str = STATE_STR_BREAK_UNKNOWN;
             }
             cpu->watchpoint_hit = NULL;
-        } else {
-            // "hardware" breakpoint hit!
+        }
+        else if (cpu->singlestep_enabled){
+            // we land here when a single step is performed
+            cpu_single_step(cpu, 0);
+            stop_str = STATE_STEP_PERFORMED;
+        }
+        else {
             trig_id = MCD_TRIG_TYPE_IP;
             stop_str = STATE_STR_BREAK_HW;
             tb_flush(cpu);
@@ -870,47 +816,40 @@ void mcd_vm_state_change(void *opaque, bool running, RunState state)
         stop_str = "";
         break;
     case RUN_STATE_WATCHDOG:
+        printf("runstate watchdog hit\n");
         info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state = CORE_STATE_UNKNOWN;
         stop_str = "";
-        printf("runstate watchdog hit\n");
         break;
     default:
         info_str = STATE_STR_UNKNOWN(cpu->cpu_index);
         mcd_state = CORE_STATE_UNKNOWN;
         stop_str = "";
-        // we don't care;
         break;
     }
 
+    // set state for c_cpu
     mcdserver_state.cpu_state.state = mcd_state;
     mcdserver_state.cpu_state.trig_id = trig_id;
     mcdserver_state.cpu_state.stop_str = stop_str;
     mcdserver_state.cpu_state.info_str = info_str;
-
-    /* disable single step if it was enabled */
-    cpu_single_step(cpu, 0);
 }
 
-int mcd_put_packet(const char *buf)
-{
+int mcd_put_packet(const char *buf) {
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
 
-void mcd_put_strbuf(void)
-{
+void mcd_put_strbuf(void) {
     mcd_put_packet(mcdserver_state.str_buf->str);
 }
 
-int mcd_put_packet_binary(const char *buf, int len, bool dump)
-{
+int mcd_put_packet_binary(const char *buf, int len, bool dump) {
     for(;;) {
-        //super interesting if we want a chekcsum or something like that here!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_COMMAND_START, '\0' }, 1);
         g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) buf, len);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "#", 1);
-        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "|", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_COMMAND_END, '\0' }, 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) (char[2]) { TCP_WAS_LAST, '\0' }, 1);
 
         mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
 
@@ -921,53 +860,28 @@ int mcd_put_packet_binary(const char *buf, int len, bool dump)
     return 0;
 }
 
-bool mcd_got_immediate_ack(void)
-{
+bool mcd_got_immediate_ack(void) {
     return true;
 }
 
-void mcd_put_buffer(const uint8_t *buf, int len)
-{
-    /*
-     * XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks
-     */
+void mcd_put_buffer(const uint8_t *buf, int len) {
     qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
 }
 
-void mcd_set_stop_cpu(CPUState *cpu)
-{
-    MCDProcess *p = mcd_get_cpu_process(cpu);
-
-    if (!p->attached) {
-        /*
-         * Having a stop CPU corresponding to a process that is not attached
-         * confuses GDB. So we ignore the request.
-         */
-        return;
-    }
-    //FIXME: we probably can delete this because in the opern_core function we set these two anyway
-    mcdserver_state.c_cpu = cpu;
-}
-
-MCDProcess *mcd_get_cpu_process(CPUState *cpu)
-{
+MCDProcess *mcd_get_cpu_process(CPUState *cpu) {
     return mcd_get_process(mcd_get_cpu_pid(cpu));
 }
 
-uint32_t mcd_get_cpu_pid(CPUState *cpu)
-{
+uint32_t mcd_get_cpu_pid(CPUState *cpu) {
     if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
-        /* Return the default process' PID */
+        // Return the default process' PID
         int index = mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
-    // TODO: maybe +1 because we start numbering at 1
     return cpu->cluster_index + 1;
 }
 
-MCDProcess *mcd_get_process(uint32_t pid)
-{
+MCDProcess *mcd_get_process(uint32_t pid) {
     int i;
 
     if (!pid) {
@@ -997,8 +911,7 @@ CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
     return cpu;
 }
 
-CPUState *mcd_first_attached_cpu(void)
-{
+CPUState *mcd_first_attached_cpu(void) {
     CPUState *cpu = first_cpu;
     MCDProcess *process = mcd_get_cpu_process(cpu);
 
@@ -1009,8 +922,7 @@ CPUState *mcd_first_attached_cpu(void)
     return cpu;
 }
 
-CPUState *mcd_next_attached_cpu(CPUState *cpu)
-{
+CPUState *mcd_next_attached_cpu(CPUState *cpu) {
     cpu = CPU_NEXT(cpu);
 
     while (cpu) {
@@ -1024,14 +936,11 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
     return cpu;
 }
 
-int mcd_get_cpu_index(CPUState *cpu)
-{
-    // TODO: maybe plus 1 because we start numbering at 1
+int mcd_get_cpu_index(CPUState *cpu) {
     return cpu->cpu_index + 1;
 }
 
-CPUState *get_first_cpu_in_process(MCDProcess *process)
-{
+CPUState *get_first_cpu_in_process(MCDProcess *process) {
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -1043,8 +952,7 @@ CPUState *get_first_cpu_in_process(MCDProcess *process)
     return NULL;
 }
 
-CPUState *find_cpu(uint32_t thread_id)
-{
+CPUState *find_cpu(uint32_t thread_id) {
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -1080,7 +988,7 @@ void parse_reg_xml(const char *xml, int size, GArray* registers) {
         c_ptr = &c;
 
         if (still_to_skip>0) {
-            // skip chars unwanted chars
+            // skip unwanted chars
             still_to_skip --;
             continue;
         }
@@ -1172,9 +1080,7 @@ void parse_reg_xml(const char *xml, int size, GArray* registers) {
 }
 
 int int_cmp(gconstpointer a, gconstpointer b) {
-    int a_int = *(int*)a;
-    int b_int = *(int*)b;
-    if (a_int == b_int) {
+    if (*(int*)a == *(int*)b) {
         return 0;
     }
     else {
@@ -1285,7 +1191,7 @@ int init_trigger(mcd_trigger_st* trigger) {
 }
 
 void handle_open_server(GArray *params, void *user_ctx) {
-    // initialize some core-independent data
+    // initialize core-independent data
     int return_value = 0;
     mcdserver_state.resets = g_array_new(false, true, sizeof(mcd_reset_st));
     return_value = init_resets(mcdserver_state.resets);
@@ -1301,8 +1207,6 @@ void handle_query_system(GArray *params, void *user_ctx) {
 }
 
 void handle_query_cores(GArray *params, void *user_ctx) {
-    //TODO: add cluster support: in gdb each inferior (process) handles one cluster we might want to have sth similar here
-
     // get first cpu
     CPUState *cpu = mcd_first_attached_cpu();
     if (!cpu) {
@@ -1316,10 +1220,9 @@ void handle_query_cores(GArray *params, void *user_ctx) {
     gchar *arch = cc->gdb_arch_name(cpu);
     
     int nr_cores = cpu->nr_cores;
-
     char device_name[] = DEVICE_NAME_TEMPLATE(arch);
     g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%d.",
-    TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model, TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
     mcd_put_strbuf();
     g_free(arch);
 }
@@ -1441,7 +1344,6 @@ int mcd_arm_get_additional_register_info(GArray* reggroups, GArray* registers) {
 }
 
 void handle_open_core(GArray *params, void *user_ctx) {
-    // get the cpu whith the given id
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     CPUState *cpu = mcd_get_cpu(cpu_id);
     mcdserver_state.c_cpu = cpu;
@@ -1501,9 +1403,7 @@ void handle_open_core(GArray *params, void *user_ctx) {
 }
 
 void handle_query_reset_f(GArray *params, void *user_ctx) {
-    // resetting has to be done over a monitor (look ar Rcmd) so we tell MCD that we can reset but this still need to be implemented
-    // we only support one reset over this monitor and that would be a full "system_restart"
-    // reset options are the same for every cpu!
+    // TODO: vull reset over the qemu monitor
     
     // 1. check length
     int nb_resets = mcdserver_state.resets->len;
@@ -1518,7 +1418,6 @@ void handle_query_reset_f(GArray *params, void *user_ctx) {
     mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
     g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
-    // TODO: we still need to implement the gpr and memory reset here!
 }
 
 void handle_query_reset_c(GArray *params, void *user_ctx) {
@@ -1539,7 +1438,6 @@ void handle_query_reset_c(GArray *params, void *user_ctx) {
     mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, query_index);
     g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%d.", TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
     mcd_put_strbuf();
-    // TODO: we still need to implement the gpr and memory reset here!
 }
 
 void handle_close_core(GArray *params, void *user_ctx) {
@@ -1575,7 +1473,7 @@ void handle_close_server(GArray *params, void *user_ctx) {
         mcdserver_state.c_cpu = mcd_first_attached_cpu();
     }
     if (!mcdserver_state.c_cpu) {
-        /* No more process attached */
+        // no more processes attached
         mcd_disable_syscalls();
         mcd_vm_start();
     }
@@ -1595,10 +1493,15 @@ void mcd_vm_start(void) {
     }
 }
 
+int mcd_vm_sstep(CPUState *cpu) {
+    cpu_single_step(mcdserver_state.c_cpu, mcdserver_state.sstep_flags);
+    mcd_vm_start();
+    return 0;
+}
+
 void mcd_vm_stop(void) {
     if (runstate_is_running()) {
-        //might want to have DEBUG state here but idk
-        vm_stop(RUN_STATE_PAUSED);
+        vm_stop(RUN_STATE_DEBUG);
     }
 }
 
@@ -1724,7 +1627,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx) {
 }
 
 void handle_query_regs_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups except for the first
+    // this funcitons send all regs except for the first
     // 1. get parameter and registers
     int query_index = get_param(params, 0)->query_handle;
     uint32_t cpu_id = mcdserver_state.query_cpu_id;
@@ -1750,16 +1653,12 @@ void handle_query_regs_c(GArray *params, void *user_ctx) {
 }
 
 void handle_reset(GArray *params, void *user_ctx) {
-    int reset_id = get_param(params, 0)->data_int;
-    //int bool_halt_after_reset = get_param(params, 1)->data_int;
-    if (reset_id>=0) {
-        //fun for the compiler
-    }
+    //int reset_id = get_param(params, 0)->data_int;
+    // TODO: implement resets
 }
 
 void handle_query_state(GArray *params, void *user_ctx) {
-    // send state from correct core
-    //uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    // TODO: multicore support
     // get state info
     mcd_cpu_state_st state_info = mcdserver_state.cpu_state;
     mcd_core_event_et event = MCD_CORE_EVENT_NONE;
@@ -1795,6 +1694,19 @@ int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg) {
     }
 }
 
+int mcd_write_register(CPUState *cpu, GByteArray *buf, int reg) {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    gchar *arch = cc->gdb_arch_name(cpu);
+    if (strcmp(arch, "arm")==0) {
+        g_free(arch);
+        return arm_mcd_write_register(cpu, buf, reg);
+    }
+    else {
+        g_free(arch);
+        return 0;
+    }
+}
+
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
     int i, c;
     for(i = 0; i < len; i++) {
@@ -1817,18 +1729,28 @@ void mcd_hextomem(GByteArray *mem, const char *buf, int len) {
 
 void handle_read_register(GArray *params, void *user_ctx) {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    int reg_num = get_param(params, 1)->data_int;
+    uint64_t reg_num = get_param(params, 1)->data_int;
     int reg_size;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-
     reg_size = mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
-    mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, reg_size);
+    mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, reg_size);
     mcd_put_strbuf();
 }
 
 void handle_write_register(GArray *params, void *user_ctx) {
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint64_t reg_num = get_param(params, 1)->data_int;
+    uint32_t reg_size = get_param(params, 2)->data_int;
 
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, reg_size);
+    if (mcd_write_register(cpu, mcdserver_state.mem_buf, reg_num)==0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
 }
 
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
@@ -1836,7 +1758,6 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
-        // TODO: check out the difference between those two calls
         return cc->memory_rw_debug(cpu, addr, buf, len, false);
     }
 
@@ -1848,7 +1769,6 @@ int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc = CPU_GET_CLASS(cpu);
     if (cc->memory_rw_debug) {
-        // TODO: check out the difference between those two calls
         return cc->memory_rw_debug(cpu, addr, buf, len, true);
     }
 
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 0848e0dbdb..6a1c969f3b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -306,7 +306,7 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        gdb_set_stop_cpu(cpu);
+        //gdb_set_stop_cpu(cpu);
         qemu_system_debug_request();
         cpu->stopped = true;
     }
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index dc36a79a70..27e1a13b69 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -8,7 +8,7 @@
 
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
-    //FIXME: move this to a separate file
+    //TODO: move this to a separate file
     // convert endianess if necessary
     uint32_t to_long = tswap32(val);
     g_byte_array_append(buf, (uint8_t *) &to_long, 4);
@@ -17,7 +17,7 @@ static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 
 static inline int mcd_get_zeroes(GByteArray *array, size_t len)
 {
-    //FIXME: move this to a separate file
+    //TODO: move this to a separate file
     guint oldlen = array->len;
     g_byte_array_set_size(array, oldlen + len);
     memset(array->data + oldlen, 0, len);
@@ -44,9 +44,6 @@ const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname)
 }
 
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
-    //CPUClass *cc = CPU_GET_CLASS(cpu);
-    //CPUArchState *env = cpu->env_ptr;
-
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
@@ -70,6 +67,61 @@ int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n) {
             return mcd_get_reg32(mem_buf, cpsr_read(env));
         }
     }
-    //TODO: add funcitons for regs with higher numbers (including cp_regs)
+    //TODO: add funcitons for the remaining regs (including cp_regs)
+    return 0;
+}
+
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n) {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint32_t tmp;
+
+    tmp = ldl_p(mem_buf);
+    tmp = *((uint32_t*)mem_buf->data);
+
+    /*
+     * Mask out low bits of PC to workaround gdb bugs.
+     * This avoids an assert in thumb_tr_translate_insn, because it is
+     * architecturally impossible to misalign the pc.
+     * This will probably cause problems if we ever implement the
+     * Jazelle DBX extensions.
+     */
+    if (n == 15) {
+        tmp &= ~1;
+    }
+
+    if (n < 16) {
+        /* Core integer register.  */
+        if (n == 13 && arm_feature(env, ARM_FEATURE_M)) {
+            /* M profile SP low bits are always 0 */
+            tmp &= ~3;
+        }
+        env->regs[n] = tmp;
+        return 4;
+    }
+    if (n < 24) { /* 16-23 */
+        /* FPA registers (ignored).  */
+        return 4;
+    }
+    switch (n) {
+    case 24:
+        /* FPA status register (ignored).  */
+        return 4;
+    case 25:
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            /*
+             * Don't allow writing to XPSR.Exception as it can cause
+             * a transition into or out of handler mode (it's not
+             * writable via the MSR insn so this is a reasonable
+             * restriction). Other fields are safe to update.
+             */
+            xpsr_write(env, tmp, ~XPSR_EXCP);
+        } else {
+            cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
+        }
+        return 4;
+    }
+    //TODO: add funcitons for the remaining regs (including cp_regs)
     return 0;
-}
\ No newline at end of file
+}
diff --git a/target/arm/mcdstub.h b/target/arm/mcdstub.h
index d61028c7f4..28c7f2baec 100644
--- a/target/arm/mcdstub.h
+++ b/target/arm/mcdstub.h
@@ -3,5 +3,6 @@
 
 const char *arm_mcd_get_dynamic_xml(CPUState *cs, const char *xmlname);
 int arm_mcd_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+int arm_mcd_write_register(CPUState *cs, GByteArray *mem_buf, int n);
 
 #endif /* ARM_MCDSTUB_H */
-- 
2.34.1


