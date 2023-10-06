Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989F7BB3E8
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn6-00085Z-FO; Fri, 06 Oct 2023 05:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmz-00082v-8D
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:29 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmv-0000vv-9Q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:29 -0400
Received: (qmail 19513 invoked by uid 484); 6 Oct 2023 09:06:22 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071708 secs); 06 Oct 2023 09:06:22 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:21 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 08/29] shared header file added, used for TCP packet data
Date: Fri,  6 Oct 2023 11:05:49 +0200
Message-Id: <20231006090610.26171-9-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          |  4 +-
 mcdstub/mcd_shared_defines.h | 24 ++++++++++++
 mcdstub/mcdstub.c            | 72 ++++++++++++++++++------------------
 3 files changed, 62 insertions(+), 38 deletions(-)
 create mode 100644 mcdstub/mcd_shared_defines.h

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 2f9a768038..4c79ff7674 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -22,9 +22,9 @@
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
 // schema defines
-#define ARG_SCHEMA_QRY_HANDLE "q"
+#define ARG_SCHEMA_QRYHANDLE "q"
 #define ARG_SCHEMA_STRING "s"
-#define ARG_SCHEMA_CORE_NUM "c" 
+#define ARG_SCHEMA_CORENUM "c" 
 
 // GDB stuff thats needed for GDB function, which we use
 typedef struct GDBRegisterState {
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
new file mode 100644
index 0000000000..6a2abfb1bc
--- /dev/null
+++ b/mcdstub/mcd_shared_defines.h
@@ -0,0 +1,24 @@
+// this file is shared between the mcd dll and the mcd stub. it has to be kept exectly the same!
+
+#ifndef MCD_SHARED_DEFINES
+#define MCD_SHARED_DEFINES
+
+// tcp characters
+#define TCP_CHAR_INIT 'i'
+#define TCP_CHAR_GO 'c'
+#define TCP_CHAR_QUERY 'q'
+#define TCP_CHAR_OPEN_CORE 'H'
+#define TCP_CHAR_DETACH 'D'
+#define TCP_CHAR_KILLQEMU 'k'
+
+// tcp protocol chars
+#define TCP_ACKNOWLEDGED '+'
+#define TCP_NOT_ACKNOWLEDGED '-'
+#define TCP_COMMAND_START '$'
+#define TCP_COMMAND_END '#'
+#define TCP_WAS_LAST '|'
+#define TCP_WAS_NOT_LAST '~'
+
+
+
+#endif
\ No newline at end of file
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index b3ec3af543..a4841cf7d3 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -72,7 +72,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
     {
         .handler = handle_query_mem_spaces_c,
         .cmd = "memoryc",
-        .schema = ARG_SCHEMA_QRY_HANDLE,
+        .schema = ARG_SCHEMA_QRYHANDLE,
     },
     {
         .handler = handle_query_reg_groups_f,
@@ -81,7 +81,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
     {
         .handler = handle_query_reg_groups_c,
         .cmd = "reggroupc",
-        .schema = ARG_SCHEMA_QRY_HANDLE,
+        .schema = ARG_SCHEMA_QRYHANDLE,
     },
     {
         .handler = handle_query_regs_f,
@@ -90,7 +90,7 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
     {
         .handler = handle_query_regs_c,
         .cmd = "regc",
-        .schema = ARG_SCHEMA_QRY_HANDLE,
+        .schema = ARG_SCHEMA_QRYHANDLE,
     },
 };
 
@@ -303,22 +303,22 @@ void mcd_read_byte(uint8_t ch)
     if (mcdserver_state.last_packet->len) {
         /* Waiting for a response to the last packet.  If we see the start
            of a new command then abandon the previous response.  */
-        if (ch == '-') {
+        if (ch == TCP_NOT_ACKNOWLEDGED) {
             //the previous packet was not akcnowledged
             //trace_gdbstub_err_got_nack();
             //we are resending the last packet
             mcd_put_buffer(mcdserver_state.last_packet->data, mcdserver_state.last_packet->len);
         }
-        else if (ch == '+') {
+        else if (ch == TCP_ACKNOWLEDGED) {
             //the previous packet was acknowledged
             //trace_gdbstub_io_got_ack();
         }
 
-        if (ch == '+' || ch == '$') {
+        if (ch == TCP_ACKNOWLEDGED || ch == TCP_COMMAND_START) {
             //either acknowledged or a new communication starts -> we discard previous communication
             g_byte_array_set_size(mcdserver_state.last_packet, 0);
         }
-        if (ch != '$') {
+        if (ch != TCP_COMMAND_START) {
             // we only continue if we are processing a new commant. otherwise we skip to ne next character in the packet which sould be a $
             return;
         }
@@ -331,7 +331,7 @@ void mcd_read_byte(uint8_t ch)
     else {
         switch(mcdserver_state.state) {
         case RS_IDLE:
-            if (ch == '$') {
+            if (ch == TCP_COMMAND_START) {
                 /* start of command packet */
                 mcdserver_state.line_buf_index = 0;
                 mcdserver_state.line_sum = 0;
@@ -343,7 +343,7 @@ void mcd_read_byte(uint8_t ch)
             }
             break;
         case RS_GETLINE:
-            if (ch == '#') {
+            if (ch == TCP_COMMAND_END) {
                 /* end of command, start of checksum*/
                 mcdserver_state.line_buf[mcdserver_state.line_buf_index++] = 0;
                 //mcdserver_state.line_sum += ch;
@@ -365,24 +365,24 @@ void mcd_read_byte(uint8_t ch)
             // we are now done with copying the data and in the suffix of the packet
             // TODO: maybe wanna implement a checksum or sth like the gdb protocol has
 
-            if (ch == '~') {
+            if (ch == TCP_WAS_NOT_LAST) {
                 // ~ indicates that there is an additional package coming
                 //acknowledged -> send +
-                reply = '+';
+                reply = TCP_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
             }
-            else if (ch == '|') {
+            else if (ch == TCP_WAS_LAST) {
                 //acknowledged -> send +
                 // | indicates that there is no additional package coming
-                reply = '+';
+                reply = TCP_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 mcdserver_state.state = mcd_handle_packet(mcdserver_state.line_buf);
             }
             else {
                 //trace_gdbstub_err_checksum_incorrect(mcdserver_state.line_sum, mcdserver_state.line_csum);
                 //not acknowledged -> send -
-                reply = '-';
+                reply = TCP_NOT_ACKNOWLEDGED;
                 mcd_put_buffer(&reply, 1);
                 //waiting for package to get resent
                 mcdserver_state.state = RS_IDLE;
@@ -400,58 +400,58 @@ int mcd_handle_packet(const char *line_buf)
     const MCDCmdParseEntry *cmd_parser = NULL;
 
     switch (line_buf[0]) {
-    case 'i':
+    case TCP_CHAR_INIT:
         // handshake and lookup initialization
         {
-            static const MCDCmdParseEntry continue_cmd_desc = {
+            static MCDCmdParseEntry init_cmd_desc = {
                 .handler = handle_init,
-                .cmd = "i",
             };
-            cmd_parser = &continue_cmd_desc;
+            init_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_INIT, '\0' };
+            cmd_parser = &init_cmd_desc;
         }
         break;
-    case 'c':
+    case TCP_CHAR_GO:
         // go command
         {
-            static const MCDCmdParseEntry continue_cmd_desc = {
+            static MCDCmdParseEntry go_cmd_desc = {
                 .handler = handle_continue,
-                .cmd = "c",
             };
-            cmd_parser = &continue_cmd_desc;
+            go_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_GO, '\0' };
+            cmd_parser = &go_cmd_desc;
         }
         break;
-    case 'k':
+    case TCP_CHAR_KILLQEMU:
         // kill qemu completely
         error_report("QEMU: Terminated via MCDstub");
         mcd_exit(0);
         exit(0);
-    case 'q':
+    case TCP_CHAR_QUERY:
         //query inquiry
         {
-            static const MCDCmdParseEntry gen_query_cmd_desc = {
+            static MCDCmdParseEntry query_cmd_desc = {
                 .handler = handle_gen_query,
-                .cmd = "q",
                 .schema = ARG_SCHEMA_STRING
             };
-            cmd_parser = &gen_query_cmd_desc;
+            query_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_QUERY, '\0' };
+            cmd_parser = &query_cmd_desc;
         }
         break;
-    case 'H':
+    case TCP_CHAR_OPEN_CORE:
         {
-            static const MCDCmdParseEntry gen_open_core = {
+            static MCDCmdParseEntry gen_open_core = {
                 .handler = handle_open_core,
-                .cmd = "H",
-                .schema = ARG_SCHEMA_CORE_NUM
+                .schema = ARG_SCHEMA_CORENUM
             };
+            gen_open_core.cmd = (char[2]) { (char) TCP_CHAR_OPEN_CORE, '\0' };
             cmd_parser = &gen_open_core;
         }
         break;
-    case 'D':
+    case TCP_CHAR_DETACH:
         {
-            static const MCDCmdParseEntry detach_cmd_desc = {
+            static MCDCmdParseEntry detach_cmd_desc = {
                 .handler = handle_detach,
-                .cmd = "D",
             };
+            detach_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_DETACH, '\0' };
             cmd_parser = &detach_cmd_desc;
         }
         break;
@@ -518,12 +518,12 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
         this_param.data = data;
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] == atoi(ARG_SCHEMA_QRY_HANDLE)) {
+    else if (schema[0] == atoi(ARG_SCHEMA_QRYHANDLE)) {
         strncat(data_buffer, data, strlen(data));
         this_param.query_handle = atoi(data_buffer);
         g_array_append_val(params, this_param);
     }
-    else if (schema[0] == atoi(ARG_SCHEMA_CORE_NUM)) {
+    else if (schema[0] == atoi(ARG_SCHEMA_CORENUM)) {
         strncat(data_buffer, data, strlen(data));
         this_param.cpu_id = atoi(data_buffer);
         g_array_append_val(params, this_param);
-- 
2.34.1


