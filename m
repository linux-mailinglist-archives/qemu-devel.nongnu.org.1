Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C27BB3FA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn5-00082y-Tu; Fri, 06 Oct 2023 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmr-0007zc-9T
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:21 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmo-0000sr-4O
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:21 -0400
Received: (qmail 19403 invoked by uid 484); 6 Oct 2023 09:06:15 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 4e-06 secs); 06 Oct 2023 09:06:15 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:14 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 03/29] TCP packet handling added
Date: Fri,  6 Oct 2023 11:05:44 +0200
Message-Id: <20231006090610.26171-4-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h    |  64 ++++-
 mcdstub/mcd_syscalls.c |  11 +
 mcdstub/mcdstub.c      | 541 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 596 insertions(+), 20 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 7b0f4b0b36..5af705a12a 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -25,12 +25,42 @@ enum {
  */
 
 typedef struct MCDProcess {
+    //this is probably what we would call a system (in qemu its a cluster)
     uint32_t pid;
     bool attached;
 
     char target_xml[1024];
 } MCDProcess;
 
+typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
+typedef struct MCDCmdParseEntry {
+    MCDCmdHandler handler;
+    const char *cmd;
+    bool cmd_startswith;
+    const char *schema;
+} MCDCmdParseEntry;
+
+typedef enum MCDThreadIdKind {
+    GDB_ONE_THREAD = 0,
+    GDB_ALL_THREADS,     /* One process, all threads */
+    GDB_ALL_PROCESSES,
+    GDB_READ_THREAD_ERR
+} MCDThreadIdKind;
+
+typedef union MCDCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        MCDThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} MCDCmdVariant;
+
+#define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
+
 
 /*
  * not sure for what this is used exactly
@@ -41,10 +71,11 @@ enum RSState {
     RS_INACTIVE,
     RS_IDLE,
     RS_GETLINE,
-    RS_GETLINE_ESC,
-    RS_GETLINE_RLE,
-    RS_CHKSUM1,
-    RS_CHKSUM2,
+    RS_DATAEND,
+    //RS_GETLINE_ESC,
+    //RS_GETLINE_RLE,
+    //RS_CHKSUM1,
+    //RS_CHKSUM2,
 };
 
 typedef struct MCDState {
@@ -59,11 +90,13 @@ typedef struct MCDState {
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
     int signal;
-    bool multiprocess;
+    //the next one is about stub compatibility and we should be able to assume this is true anyway
+    //bool multiprocess;
     MCDProcess *processes;
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
+    // maybe we don't need those flags
     int sstep_flags;
     int supported_sstep_flags;
 } MCDState;
@@ -128,8 +161,29 @@ uint32_t mcd_get_cpu_pid(CPUState *cpu);
 MCDProcess *mcd_get_process(uint32_t pid);
 CPUState *mcd_first_attached_cpu(void);
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
+void mcd_read_byte(uint8_t ch);
+int mcd_handle_packet(const char *line_buf);
+void mcd_put_strbuf(void);
+void mcd_exit(int code);
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds);
+int cmd_parse_params(const char *data, const char *schema, GArray *params);
+void handle_continue(GArray *params, void *user_ctx);
+void handle_gen_query(GArray *params, void *user_ctx);
+void mcd_append_thread_id(CPUState *cpu, GString *buf);
+int mcd_get_cpu_index(CPUState *cpu);
+CPUState* mcd_get_cpu(uint32_t i_cpu_index);
+void handle_query_cores(GArray *params, void *user_ctx);
+void handle_query_system(GArray *params, void *user_ctx);
+CPUState *get_first_cpu_in_process(MCDProcess *process);
+CPUState *find_cpu(uint32_t thread_id);
+void handle_core_open(GArray *params, void *user_ctx);
+void handle_query_reset(GArray *params, void *user_ctx);
+void handle_detach(GArray *params, void *user_ctx);
+void mcd_continue(void);
 
 /* sycall handling */
 void mcd_syscall_reset(void);
+void mcd_disable_syscalls(void);
 
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index 663ffde1b6..dec0af51b7 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -12,9 +12,20 @@ typedef struct {
     int current_syscall_cb;
 } MCDSyscallState;
 
+static enum {
+    MCD_SYS_UNKNOWN,
+    MCD_SYS_ENABLED,
+    MCD_SYS_DISABLED,
+} mcd_syscall_mode;
+
 static MCDSyscallState mcdserver_syscall_state;
 
 void mcd_syscall_reset(void)
 {
     mcdserver_syscall_state.current_syscall_cb = 0;
+}
+
+void mcd_disable_syscalls(void)
+{
+    mcd_syscall_mode = MCD_SYS_DISABLED;
 }
\ No newline at end of file
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index c68cab9391..75b38d910a 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -31,6 +31,9 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 
+// just used for the xml_builtin stuff
+//#include "exec/gdbstub.h"       /* xml_builtin */
+
 typedef struct {
     CharBackend chr;
     //Chardev *mon_chr;
@@ -40,6 +43,22 @@ MCDSystemState mcdserver_system_state;
 
 MCDState mcdserver_state;
 
+static const MCDCmdParseEntry mcd_gen_query_table[] = {
+    // this is a list of all query commands. it gets iterated over only the handler of the matching command will get executed
+    {
+        .handler = handle_query_system,
+        .cmd = "system",
+    },
+    {
+        .handler = handle_query_cores,
+        .cmd = "cores",
+    },
+    {
+        .handler = handle_query_reset,
+        .cmd = "reset",
+    },
+};
+
 void mcd_init_mcdserver_state(void)
 {
 	g_assert(!mcdserver_state.init);
@@ -55,7 +74,7 @@ void mcd_init_mcdserver_state(void)
      * stepping so as to make single stepping like a typical ICE HW step.
      */
 	// TODO:
-	// this is weird and might be able to sit just like it is here with the same value as for gdb
+	// this is weird and we might not actually need it after all
     mcdserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
     mcdserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     mcdserver_state.sstep_flags &= mcdserver_state.supported_sstep_flags;
@@ -235,14 +254,343 @@ int mcd_chr_can_receive(void *opaque)
 
 void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
 {
-    printf("incoming buffer: %s\n", buf);
-    char send_buffer[] = "shaking your hand";
-    mcd_put_packet(send_buffer);
-    //int i;
-	/*
+    int i;
+	
     for (i = 0; i < size; i++) {
-        //TODO: some byte reading or idk gdb_read_byte(buf[i]);
-    }*/
+        mcd_read_byte(buf[i]);
+    }
+}
+
+void mcd_read_byte(uint8_t ch)
+{
+    uint8_t reply;
+
+    if (mcdserver_state.last_packet->len) {
+        /* Waiting for a response to the last packet.  If we see the start
+           of a new command then abandon the previous response.  */
+        if (ch == '-') {
+            //the previous packet was not akcnowledged
+            //trace_gdbstub_err_got_nack();
+            //we are resending the last packet
+            mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
+        }
+        else if (ch == '+') {
+            //the previous packet was acknowledged
+            //trace_gdbstub_io_got_ack();
+        }
+
+        if (ch == '+' || ch == '$') {
+            //either acknowledged or a new communication starts -> we discard previous communication
+            g_byte_array_set_size(mcdserver_state.last_packet, 0);
+        }
+        if (ch != '$') {
+            // we only continue if we are processing a new commant. otherwise we skip to ne next character in the packet which sould be a $
+            return;
+        }
+    }
+    if (runstate_is_running()) {
+        /* when the CPU is running, we cannot do anything except stop
+           it when receiving a char */
+        vm_stop(RUN_STATE_PAUSED);
+    }
+    else {
+        switch(mcdserver_state.state) {
+        case RS_IDLE:
+            if (ch == '$') {
+                /* start of command packet */
+                mcdserver_state.line_buf_index = 0;
+                mcdserver_state.line_sum = 0;
+                mcdserver_state.state = RS_GETLINE;
+            }
+            else {
+                //new communication has to start with a $
+                //trace_gdbstub_err_garbage(ch);
+            }
+            break;
+        case RS_GETLINE:
+            if (ch == '#') {
+                /* end of command, start of checksum*/
+                mcdserver_state.state = RS_DATAEND;
+            }
+            else if (mcdserver_state.line_buf_index >= sizeof(mcdserver_state.line_buf) - 1) {
+                //the input string is too long for the linebuffer!
+                //trace_gdbstub_err_overrun();
+                mcdserver_state.state = RS_IDLE;
+            }
+            else {
+                /* unescaped command character */
+                //this means the character is part of the real content fo the packet and we copy it to the line_buf
+                mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = ch;
+                mcdserver_state.line_sum += ch;
+            }
+            break;
+        case RS_DATAEND:
+            // we are now done with copying the data and in the suffix of the packet
+            // TODO: maybe wanna implement a checksum or sth like the gdb protocol has
+
+            if (ch == '~') {
+                // ~ indicates that there is an additional package coming
+                //acknowledged -> send +
+                reply = '+';
+                mcd_put_buffer(&reply, 1);
+                mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
+            }
+            else if (ch == '|') {
+                //acknowledged -> send +
+                // | indicates that there is no additional package coming
+                reply = '+';
+                mcd_put_buffer(&reply, 1);
+                mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
+            }
+            else {
+                //trace_gdbstub_err_checksum_incorrect(mcdserver_state.line_sum, mcdserver_state.line_csum);
+                //not acknowledged -> send -
+                reply = '-';
+                mcd_put_buffer(&reply, 1);
+                //waiting for package to get resent
+                mcdserver_state.state = RS_IDLE;
+            }
+            break;
+        default:
+            abort();
+        }
+    }
+}
+
+int mcd_handle_packet(const char *line_buf)
+{
+    //decides what function (handler) to call depending on what the first character in the line_buf is!
+    const MCDCmdParseEntry *cmd_parser = NULL;
+
+    //trace_gdbstub_io_command(line_buf);
+
+    switch (line_buf[0]) {
+    case 'i':
+        //handshake
+        mcd_put_packet("shaking your hand");
+        //gdb_put_packet("OK");
+        break;
+    case 'c':
+        //go command
+        {
+            static const MCDCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                //.cmd_startswith = 1,
+                //.schema = "L0"
+            };
+            cmd_parser = &continue_cmd_desc;
+        }
+        break;
+    case 'k':
+        // kill qemu completely
+        error_report("QEMU: Terminated via MCDstub");
+        mcd_exit(0);
+        exit(0);
+    case 'q':
+        //query inquiry
+        {
+            static const MCDCmdParseEntry gen_query_cmd_desc = {
+                .handler = handle_gen_query,
+                .cmd = "q",
+                //.cmd_startswith = 1,
+                .schema = "ss"
+            };
+            cmd_parser = &gen_query_cmd_desc;
+        }
+        break;
+    case 'H':
+        //current alias for open core, later this will probably be a part of the 'i' requests
+        {
+            static const MCDCmdParseEntry gen_core_open = {
+                .handler = handle_core_open,
+                .cmd = "H",
+                //.cmd_startswith = 1,
+                .schema = "ss"
+            };
+            cmd_parser = &gen_core_open;
+        }
+        break;
+    case 'D':
+        {
+            static const MCDCmdParseEntry detach_cmd_desc = {
+                .handler = handle_detach,
+                .cmd = "D",
+                //.cmd_startswith = 1,
+                //.schema = "?.l0"
+            };
+            cmd_parser = &detach_cmd_desc;
+        }
+        break;
+    default:
+        //could not perform the command (because its unknown)
+        mcd_put_packet("");
+        break;
+    }
+
+    if (cmd_parser) {
+        //now parse commands and run the selected function (handler)
+        run_cmd_parser(line_buf, cmd_parser);
+    }
+
+    return RS_IDLE;
+}
+
+void handle_continue(GArray *params, void *user_ctx)
+{
+    /*
+    if (params->len) {
+        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
+    }
+
+    mcdserver_state.signal = 0;
+    gdb_continue();
+    */
+}
+
+void handle_gen_query(GArray *params, void *user_ctx)
+{
+    if (!params->len) {
+        return;
+    }
+    //now iterate over all possible query functions and execute the right one
+    if (process_string_cmd(NULL, get_param(params, 0)->data,
+                           mcd_gen_query_table,
+                           ARRAY_SIZE(mcd_gen_query_table))) {
+        mcd_put_packet("");
+    }
+}
+
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
+{
+    if (!data) {
+        return;
+    }
+
+    g_string_set_size(mcdserver_state.str_buf, 0);
+    g_byte_array_set_size(mcdserver_state.mem_buf, 0);
+
+    /* In case there was an error during the command parsing we must
+    * send a NULL packet to indicate the command is not supported */
+    if (process_string_cmd(NULL, data, cmd, 1)) {
+        mcd_put_packet("");
+    }
+}
+
+int cmd_parse_params(const char *data, const char *schema, GArray *params)
+{
+    MCDCmdVariant this_param;
+    this_param.data = data;
+    g_array_append_val(params, this_param);
+    /*
+    const char *curr_schema, *curr_data;
+
+    g_assert(schema);
+    g_assert(params->len == 0);
+
+    curr_schema = schema;
+    curr_data = data;
+    while (curr_schema[0] && curr_schema[1] && *curr_data) {
+        GdbCmdVariant this_param;
+
+        switch (curr_schema[0]) {
+        case 'l':
+            if (qemu_strtoul(curr_data, &curr_data, 16,
+                             &this_param.val_ul)) {
+                return -EINVAL;
+            }
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 'L':
+            if (qemu_strtou64(curr_data, &curr_data, 16,
+                              (uint64_t *)&this_param.val_ull)) {
+                return -EINVAL;
+            }
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 's':
+            this_param.data = curr_data;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 'o':
+            this_param.opcode = *(uint8_t *)curr_data;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case 't':
+            this_param.thread_id.kind =
+                read_thread_id(curr_data, &curr_data,
+                               &this_param.thread_id.pid,
+                               &this_param.thread_id.tid);
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            g_array_append_val(params, this_param);
+            break;
+        case '?':
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        default:
+            return -EINVAL;
+        }
+        curr_schema += 2;
+    }
+    */
+    return 0;
+    
+}
+
+int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds)
+{
+    int i;
+    g_autoptr(GArray) params = g_array_new(false, true, sizeof(MCDCmdVariant));
+
+    if (!cmds) {
+        return -1;
+    }
+
+    for (i = 0; i < num_cmds; i++) {
+        const MCDCmdParseEntry *cmd = &cmds[i];
+        //terminate if we don't have handler and cmd
+        g_assert(cmd->handler && cmd->cmd);
+
+        // if data and command are different continue
+        if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
+            continue;
+        }
+
+        // if a schema is provided we need to extract parameters from the data string
+        if (cmd->schema) {
+            //currently doing nothing
+            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params)) {
+                return -1;
+            }
+        }
+
+        // the correct handler function is called
+        cmd->handler(params, user_ctx);
+        return 0;
+    }
+
+    return -1;
+}
+
+void mcd_exit(int code)
+{
+    char buf[4];
+
+    if (!mcdserver_state.init) {
+        return;
+    }
+
+    //trace_gdbstub_op_exiting((uint8_t)code);
+
+    //need to check what is sent here and dapt it to my needs
+    snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
+    mcd_put_packet(buf);
+
+    qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
 }
 
 void mcd_chr_event(void *opaque, QEMUChrEvent event)
@@ -392,6 +740,11 @@ int mcd_put_packet(const char *buf)
     return mcd_put_packet_binary(buf, strlen(buf), false);
 }
 
+void mcd_put_strbuf(void)
+{
+    mcd_put_packet(mcdserver_state.str_buf->str);
+}
+
 int mcd_put_packet_binary(const char *buf, int len, bool dump)
 {
     //int csum, i;
@@ -405,9 +758,10 @@ int mcd_put_packet_binary(const char *buf, int len, bool dump)
     for(;;) {
         //super interesting if we want a chekcsum or something like that here!!
         g_byte_array_set_size(mcdserver_state.last_packet, 0);
-        //g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "$", 1);
-        g_byte_array_append(mcdserver_state.last_packet,
-                            (const uint8_t *) buf, len);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "$", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) buf, len);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "#", 1);
+        g_byte_array_append(mcdserver_state.last_packet, (const uint8_t *) "|", 1);
         /*
         csum = 0;
         for(i = 0; i < len; i++) {
@@ -418,8 +772,7 @@ int mcd_put_packet_binary(const char *buf, int len, bool dump)
         footer[2] = tohex((csum) & 0xf);
         g_byte_array_append(mcdserver_state.last_packet, footer, 3);
         */
-        mcd_put_buffer(mcdserver_state.last_packet->data,
-                   mcdserver_state.last_packet->len);
+        mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
 
         if (mcd_got_immediate_ack()) {
             break;
@@ -453,7 +806,7 @@ void mcd_set_stop_cpu(CPUState *cpu)
          */
         return;
     }
-
+    //FIXME: we probably can delete this because in the opern_core function we set these two anyway
     mcdserver_state.c_cpu = cpu;
     mcdserver_state.g_cpu = cpu;
 }
@@ -470,6 +823,7 @@ uint32_t mcd_get_cpu_pid(CPUState *cpu)
         int index = mcdserver_state.process_num - 1;
         return mcdserver_state.processes[index].pid;
     }
+    // TODO: maybe +1 because we start numbering at 1
     return cpu->cluster_index + 1;
 }
 
@@ -491,6 +845,19 @@ MCDProcess *mcd_get_process(uint32_t pid)
     return NULL;
 }
 
+CPUState* mcd_get_cpu(uint32_t i_cpu_index) {
+    CPUState *cpu = first_cpu;
+
+    while (cpu) {
+        if (cpu->cpu_index == i_cpu_index) {
+            return cpu;
+        }
+        cpu = mcd_next_attached_cpu(cpu);
+    }
+
+    return cpu;
+}
+
 CPUState *mcd_first_attached_cpu(void)
 {
     CPUState *cpu = first_cpu;
@@ -516,4 +883,148 @@ CPUState *mcd_next_attached_cpu(CPUState *cpu)
     }
 
     return cpu;
-}
\ No newline at end of file
+}
+/*
+void handle_query_first_threads(GArray *params, void *user_ctx)
+{
+    // chache the first cpu
+    mcdserver_state.query_cpu = mcd_first_attached_cpu();
+    // new answer over tcp
+    handle_query_threads(params, user_ctx);
+}
+
+void handle_query_threads(GArray *params, void *user_ctx)
+{
+    if (!mcdserver_state.query_cpu) {
+        // send packet back that that there is no more threads
+        //gdb_put_packet("l");
+        return;
+    }
+
+    g_string_assign(mcdserver_state.str_buf, "m");
+    mcd_append_thread_id(mcdserver_state.query_cpu, mcdserver_state.str_buf);
+    mcd_put_strbuf();
+    mcdserver_state.query_cpu = mcd_next_attached_cpu(mcdserver_state.query_cpu);
+}
+
+
+void mcd_append_thread_id(CPUState *cpu, GString *buf)
+{
+    g_string_append_printf(buf, "p%02x.%02x", mcd_get_cpu_pid(cpu), mcd_get_cpu_index(cpu));
+}
+*/
+
+int mcd_get_cpu_index(CPUState *cpu)
+{
+    // TODO: maybe plus 1 because we start numbering at 1
+    return cpu->cpu_index + 1;
+}
+
+CPUState *get_first_cpu_in_process(MCDProcess *process)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (mcd_get_cpu_pid(cpu) == process->pid) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+CPUState *find_cpu(uint32_t thread_id)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (mcd_get_cpu_index(cpu) == thread_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
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
+    //const char *cpu_name = object_get_canonical_path_component(OBJECT(cpu));
+    //int process_id = mcd_get_cpu_pid(cpu);
+    //int cpu_index = cpu->cpu_index;
+    //int cpu_cluster = cpu->cluster_index;
+    int nr_cores = cpu->nr_cores;
+
+    g_string_append_printf(mcdserver_state.str_buf, "device=\"qemu-%s-device\",core=\"%s\",nr_cores=\"%d\"", arch, cpu_model, nr_cores);
+    mcd_put_strbuf();
+    g_free(arch);
+}
+
+void handle_core_open(GArray *params, void *user_ctx) {
+    // get the cpu whith the given id
+    uint32_t cpu_id = atoi(get_param(params, 0)->data);
+
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+
+    // select the the cpu as the current cpu for all request from the mcd interface
+    mcdserver_state.c_cpu = cpu;
+    mcdserver_state.g_cpu = cpu;
+
+}
+
+void handle_query_reset(GArray *params, void *user_ctx) {
+    // resetting has to be done over a monitor (look ar Rcmd) so we tell MCD that we can reset but this still need to be implemented
+    // we only support one reset over this monitor and that would be a fully "system_restart"
+    mcd_put_packet("info_rst=\"results in a full system restart\"");
+}
+
+void handle_detach(GArray *params, void *user_ctx) {
+    uint32_t pid = 1;
+    MCDProcess *process = mcd_get_process(pid);
+
+    // 1. cleanup
+    // gdb_process_breakpoint_remove_all(process);
+
+    // 2. detach
+    process->attached = false;
+
+    // reset current cpus
+    // TODO: if we don't use c_cpu we can delete this
+    // this also checks to only reset THIS process we also probably don't need this since we only got one process!
+    if (pid == mcd_get_cpu_pid(mcdserver_state.c_cpu)) {
+        mcdserver_state.c_cpu = mcd_first_attached_cpu();
+    }
+
+    if (pid == mcd_get_cpu_pid(mcdserver_state.g_cpu)) {
+        mcdserver_state.g_cpu = mcd_first_attached_cpu();
+    }
+
+    if (!mcdserver_state.c_cpu) {
+        /* No more process attached */
+        mcd_disable_syscalls();
+        mcd_continue();
+    }
+}
+
+void mcd_continue(void)
+{
+    if (!runstate_needs_reset()) {
+        vm_start();
+    }
+}
-- 
2.34.1


