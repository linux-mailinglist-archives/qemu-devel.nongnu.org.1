Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641957E3FC2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lly-0001CA-NI; Tue, 07 Nov 2023 08:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkl-0008JL-Ep
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:26 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0005rk-DL
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:23 -0500
Received: (qmail 31068 invoked by uid 484); 7 Nov 2023 13:03:47 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 9e-06 secs); 07 Nov 2023 13:03:47 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:46 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 05/20] mcdstub: tcp packet processing added
Date: Tue,  7 Nov 2023 14:03:08 +0100
Message-Id: <20231107130323.4126-6-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h | 144 ++++++++++++++++++++
 mcdstub/mcdstub.c         | 277 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 36058157ae..1461d0e1cb 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -25,6 +25,21 @@ typedef struct MCDProcess {
     char target_xml[1024];
 } MCDProcess;
 
+typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
+typedef struct MCDCmdParseEntry {
+    MCDCmdHandler handler;
+    const char *cmd;
+    char schema[CMD_SCHEMA_LENGTH];
+} MCDCmdParseEntry;
+
+typedef union MCDCmdVariant {
+    const char *data;
+    uint32_t data_uint32_t;
+    uint64_t data_uint64_t;
+    uint32_t query_handle;
+    uint32_t cpu_id;
+} MCDCmdVariant;
+
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
 
 enum RSState {
@@ -176,6 +191,35 @@ bool mcd_supports_guest_debug(void);
  * @state: The new (and active) VM run state.
  */
 void mcd_vm_state_change(void *opaque, bool running, RunState state);
+
+/**
+ * mcd_put_packet() - Calls :c:func:`mcd_put_packet_binary` with buf and length
+ * of buf.
+ *
+ * @buf: TCP packet data.
+ */
+int mcd_put_packet(const char *buf);
+
+/**
+ * mcd_put_packet_binary() - Adds footer and header to the TCP packet data in
+ * buf.
+ *
+ * Besides adding header and footer, this function also stores the complete TCP
+ * packet in the last_packet member of the mcdserver_state. Then the packet
+ * gets send with the :c:func:`mcd_put_buffer` function.
+ * @buf: TCP packet data.
+ * @len: TCP packet length.
+ */
+int mcd_put_packet_binary(const char *buf, int len);
+
+/**
+ * mcd_put_buffer() - Sends the buf as TCP packet with qemu_chr_fe_write_all.
+ *
+ * @buf: TCP packet data.
+ * @len: TCP packet length.
+ */
+void mcd_put_buffer(const uint8_t *buf, int len);
+
 /**
  * mcd_get_cpu_process() - Returns the process of the provided CPU.
  *
@@ -218,6 +262,82 @@ CPUState *mcd_first_attached_cpu(void);
  */
 CPUState *mcd_next_attached_cpu(CPUState *cpu);
 
+/**
+ * mcd_read_byte() - Resends the last packet if not acknowledged and extracts
+ * the data from a received TCP packet.
+ *
+ * In case the last sent packet was not acknowledged from the mcdstub,
+ * this function resends it.
+ * If it was acknowledged this function parses the incoming packet
+ * byte by byte.
+ * It extracts the data in the packet and sends an
+ * acknowledging response when finished. Then :c:func:`mcd_handle_packet` gets
+ * called.
+ * @ch: Character of the received TCP packet, which should be parsed.
+ */
+void mcd_read_byte(uint8_t ch);
+
+/**
+ * mcd_handle_packet() - Evaluates the type of received packet and chooses the
+ * correct handler.
+ *
+ * This function takes the first character of the line_buf to determine the
+ * type of packet. Then it selects the correct handler function and parameter
+ * schema. With this info it calls :c:func:`run_cmd_parser`.
+ * @line_buf: TCP packet data.
+ */
+int mcd_handle_packet(const char *line_buf);
+
+/**
+ * mcd_put_strbuf() - Calls :c:func:`mcd_put_packet` with the str_buf of the
+ * mcdserver_state.
+ */
+void mcd_put_strbuf(void);
+
+/**
+ * run_cmd_parser() - Prepares the mcdserver_state before executing TCP packet
+ * functions.
+ *
+ * This function empties the str_buf and mem_buf of the mcdserver_state and
+ * then calls :c:func:`process_string_cmd`. In case this function fails, an
+ * empty TCP packet is sent back the MCD Shared Library.
+ * @data: TCP packet data.
+ * @cmd: Handler function (can be an array of functions).
+ */
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
+
+/**
+ * process_string_cmd() - Collects all parameters from the data and calls the
+ * correct handler.
+ *
+ * The parameters are extracted with the :c:func:`cmd_parse_params function.
+ * This function selects the command in the cmds array, which fits the start of
+ * the data string. This way the correct commands is selected.
+ * @data: TCP packet data.
+ * @cmds: Array of possible commands.
+ * @num_cmds: Number of commands in the cmds array.
+ */
+int process_string_cmd(void *user_ctx, const char *data,
+    const MCDCmdParseEntry *cmds, int num_cmds);
+
+/**
+ * cmd_parse_params() - Extracts all parameters from a TCP packet.
+ *
+ * This function uses the schema parameter to determine which type of parameter
+ * to expect. It then extracts that parameter from the data and stores it in
+ * the params GArray.
+ * @data: TCP packet data.
+ * @schema: List of expected parameters for the packet.
+ * @params: GArray with all extracted parameters.
+ */
+int cmd_parse_params(const char *data, const char *schema, GArray *params);
+/**
+ * mcd_get_cpu_index() - Returns the internal CPU index plus one.
+ *
+ * @cpu: CPU of interest.
+ */
+int mcd_get_cpu_index(CPUState *cpu);
+
 /**
  * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
  *
@@ -237,3 +357,27 @@ CPUState *get_first_cpu_in_process(MCDProcess *process);
  * @thread_id: ID of the desired CPU.
  */
 CPUState *find_cpu(uint32_t thread_id);
+/* helpers */
+
+/**
+ * int_cmp() - Compares a and b and returns zero if they are equal.
+ *
+ * @a: Pointer to integer a.
+ * @b: Pointer to integer b.
+ */
+int int_cmp(gconstpointer a, gconstpointer b);
+/**
+ * atouint64_t() - Converts a string into a unsigned 64 bit integer.
+ *
+ * @in: Pointer to input string.
+ */
+uint64_t atouint64_t(const char *in);
+
+/**
+ * atouint32_t() - Converts a string into a unsigned 32 bit integer.
+ *
+ * @in: Pointer to input string.
+ */
+uint32_t atouint32_t(const char *in);
+
+#endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 4cdf2e42ed..6900dcd0ea 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -80,7 +80,14 @@ void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
 {
     /* initalizes a list of all query commands */
     int cmd_number = 0;
+
+void reset_mcdserver_state(void)
+{
+    g_free(mcdserver_state.processes);
+    mcdserver_state.processes = NULL;
+    mcdserver_state.process_num = 0;
 }
+
 void create_processes(MCDState *s)
 {
     object_child_foreach(object_get_root(), find_cpu_clusters, s);
@@ -243,6 +250,228 @@ void mcd_chr_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
+void mcd_read_byte(uint8_t ch)
+{
+    uint8_t reply;
+
+    if (mcdserver_state.last_packet->len) {
+        if (ch == TCP_NOT_ACKNOWLEDGED) {
+            /* the previous packet was not akcnowledged */
+            mcd_put_buffer(mcdserver_state.last_packet->data,
+                mcdserver_state.last_packet->len);
+        } else if (ch == TCP_ACKNOWLEDGED) {
+            /* the previous packet was acknowledged */
+        }
+
+        if (ch == TCP_ACKNOWLEDGED || ch == TCP_COMMAND_START) {
+            /*
+             * either acknowledged or a new communication starts
+             * -> discard previous packet
+             */
+            g_byte_array_set_size(mcdserver_state.last_packet, 0);
+        }
+        if (ch != TCP_COMMAND_START) {
+            /* skip to the next char */
+            return;
+        }
+    }
+
+    switch (mcdserver_state.state) {
+    case RS_IDLE:
+        if (ch == TCP_COMMAND_START) {
+            /* start of command packet */
+            mcdserver_state.line_buf_index = 0;
+            mcdserver_state.line_sum = 0;
+            mcdserver_state.state = RS_GETLINE;
+        }
+        break;
+    case RS_GETLINE:
+        if (ch == TCP_COMMAND_END) {
+            /* end of command */
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
+            mcdserver_state.state = RS_DATAEND;
+        } else if (mcdserver_state.line_buf_index >=
+            sizeof(mcdserver_state.line_buf) - 1) {
+            /* the input string is too long for the linebuffer! */
+            mcdserver_state.state = RS_IDLE;
+        } else {
+            /* copy the content to the line_buf */
+            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = ch;
+            mcdserver_state.line_sum += ch;
+        }
+        break;
+    case RS_DATAEND:
+        if (ch == TCP_WAS_NOT_LAST) {
+            reply = TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
+        } else if (ch == TCP_WAS_LAST) {
+            reply = TCP_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
+        } else {
+            /* not acknowledged! */
+            reply = TCP_NOT_ACKNOWLEDGED;
+            mcd_put_buffer(&reply, 1);
+            /* waiting for package to get resent */
+            mcdserver_state.state = RS_IDLE;
+        }
+        break;
+    default:
+        abort();
+    }
+}
+
+int mcd_handle_packet(const char *line_buf)
+{
+    /*
+     * decides what function (handler) to call depending on
+     * the first character in the line_buf
+     */
+    const MCDCmdParseEntry *cmd_parser = NULL;
+
+    switch (line_buf[0]) {
+    default:
+        /* command not supported */
+        mcd_put_packet("");
+        break;
+    }
+
+    if (cmd_parser) {
+        /* parse commands and run the selected handler function */
+        run_cmd_parser(line_buf, cmd_parser);
+    }
+
+    return RS_IDLE;
+}
+void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
+{
+    if (!data) {
+        return;
+    }
+
+    g_string_set_size(mcdserver_state.str_buf, 0);
+    g_byte_array_set_size(mcdserver_state.mem_buf, 0);
+
+    if (process_string_cmd(NULL, data, cmd, 1)) {
+        mcd_put_packet("");
+    }
+}
+
+uint64_t atouint64_t(const char *in)
+{
+    uint64_t res = 0;
+    for (int i = 0; i < strlen(in); ++i) {
+        const char c = in[i];
+        res *= 10;
+        res += c - '0';
+    }
+
+    return res;
+}
+
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
+int cmd_parse_params(const char *data, const char *schema, GArray *params)
+{
+
+    char data_buffer[64] = {0};
+    const char *remaining_data = data;
+
+    for (int i = 0; i < strlen(schema); i++) {
+        /* get correct part of data */
+        char *separator = strchr(remaining_data, ARGUMENT_SEPARATOR);
+
+        if (separator) {
+            /* multiple arguments */
+            int seperator_index = (int)(separator - remaining_data);
+            strncpy(data_buffer, remaining_data, seperator_index);
+            data_buffer[seperator_index] = 0;
+            /* update remaining data for the next run */
+            remaining_data = &(remaining_data[seperator_index + 1]);
+        } else {
+            strncpy(data_buffer, remaining_data, strlen(remaining_data));
+            data_buffer[strlen(remaining_data)] = 0;
+        }
+
+        /* store right data */
+        MCDCmdVariant this_param;
+        switch (schema[i]) {
+        case ARG_SCHEMA_STRING:
+            /* this has to be the last argument */
+            this_param.data = remaining_data;
+            g_array_append_val(params, this_param);
+            break;
+        case ARG_SCHEMA_HEXDATA:
+            g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
+            break;
+        case ARG_SCHEMA_INT:
+            this_param.data_uint32_t = atouint32_t(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
+        case ARG_SCHEMA_UINT64_T:
+            this_param.data_uint64_t = atouint64_t(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
+        case ARG_SCHEMA_QRYHANDLE:
+            this_param.query_handle = atouint32_t(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
+        case ARG_SCHEMA_CORENUM:
+            this_param.cpu_id = atouint32_t(data_buffer);
+            g_array_append_val(params, this_param);
+            break;
+        default:
+            return -1;
+        }
+    }
+    return 0;
+}
+
+int process_string_cmd(void *user_ctx, const char *data,
+    const MCDCmdParseEntry *cmds, int num_cmds)
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
+        g_assert(cmd->handler && cmd->cmd);
+
+        /* continue if data and command are different */
+        if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
+            continue;
+        }
+
+        if (strlen(cmd->schema)) {
+            /* extract data for parameters */
+            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, params))
+            {
+                return -1;
+            }
+        }
+
+        /* call handler */
+        cmd->handler(params, user_ctx);
+        return 0;
+    }
+
+    return -1;
+}
 
 void mcd_chr_event(void *opaque, QEMUChrEvent event)
 {
@@ -281,6 +510,43 @@ void mcd_sigterm_handler(int signal)
 }
 #endif
 
+int mcd_put_packet(const char *buf)
+{
+    return mcd_put_packet_binary(buf, strlen(buf));
+}
+
+void mcd_put_strbuf(void)
+{
+    mcd_put_packet(mcdserver_state.str_buf->str);
+}
+
+int mcd_put_packet_binary(const char *buf, int len)
+{
+    g_byte_array_set_size(mcdserver_state.last_packet, 0);
+    g_byte_array_append(mcdserver_state.last_packet,
+        (const uint8_t *) (char[2]) { TCP_COMMAND_START, '\0' }, 1);
+    g_byte_array_append(mcdserver_state.last_packet,
+        (const uint8_t *) buf, len);
+    g_byte_array_append(mcdserver_state.last_packet,
+        (const uint8_t *) (char[2]) { TCP_COMMAND_END, '\0' }, 1);
+    g_byte_array_append(mcdserver_state.last_packet,
+        (const uint8_t *) (char[2]) { TCP_WAS_LAST, '\0' }, 1);
+
+    mcd_put_buffer(mcdserver_state.last_packet->data,
+        mcdserver_state.last_packet->len);
+    return 0;
+}
+
+void mcd_put_buffer(const uint8_t *buf, int len)
+{
+    qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
+}
+
+MCDProcess *mcd_get_cpu_process(CPUState *cpu)
+{
+    return mcd_get_process(mcd_get_cpu_pid(cpu));
+}
+
 uint32_t mcd_get_cpu_pid(CPUState *cpu)
 {
     if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
@@ -381,3 +647,14 @@ CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
 
+
+int int_cmp(gconstpointer a, gconstpointer b)
+{
+    int int_a = *(int *)a;
+    int int_b = *(int *)b;
+    if (int_a == int_b) {
+        return 0;
+    } else {
+        return 1;
+    }
+}
-- 
2.34.1


