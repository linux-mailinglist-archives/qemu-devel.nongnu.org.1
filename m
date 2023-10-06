Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB67BB3FF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognQ-0008AT-PI; Fri, 06 Oct 2023 05:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognH-00089c-Em
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:48 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognE-0000xq-2Y
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:47 -0400
Received: (qmail 19664 invoked by uid 484); 6 Oct 2023 09:06:31 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.244089 secs); 06 Oct 2023 09:06:31 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:28 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 13/29] handler for reading memory added
Date: Fri,  6 Oct 2023 11:05:54 +0200
Message-Id: <20231006090610.26171-14-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          |   9 ++-
 mcdstub/mcd_shared_defines.h |   2 +-
 mcdstub/mcdstub.c            | 124 +++++++++++++++++++++++------------
 3 files changed, 89 insertions(+), 46 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index a85173d0d1..871a58f8ea 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -41,8 +41,9 @@ enum {
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
 #define ARG_SCHEMA_INT 'd'
-#define ARG_SCHEMA_UINT32_T 'l'
+#define ARG_SCHEMA_UINT64_T 'l'
 #define ARG_SCHEMA_CORENUM 'c'
+#define ARG_SCHEMA_HEXDATA 'h'
 
 // resets
 #define RESET_SYSTEM "full_system_reset"
@@ -51,7 +52,7 @@ enum {
 
 // more
 #define QUERY_TOTAL_NUMBER 12 //FIXME: set this to a usefull value in the end
-#define CMD_SCHEMA_LENGTH 3
+#define CMD_SCHEMA_LENGTH 5
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -106,7 +107,6 @@ typedef enum MCDThreadIdKind {
 } MCDThreadIdKind;
 
 typedef union MCDCmdVariant {
-    
     const char *data;
     int data_int;
     uint64_t data_uint64_t;
@@ -329,6 +329,7 @@ void handle_read_memory(GArray *params, void *user_ctx);
 void handle_write_memory(GArray *params, void *user_ctx);
 int mcd_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len);
 
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
@@ -343,5 +344,7 @@ void mcd_disable_syscalls(void);
 // helpers
 int int_cmp(gconstpointer a, gconstpointer b);
 void mcd_memtohex(GString *buf, const uint8_t *mem, int len);
+void mcd_hextomem(GByteArray *mem, const char *buf, int len);
+uint64_t atouint64_t(const char* in);
 
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 47d5d46af3..f2f4d31335 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -27,7 +27,7 @@
 #define TCP_WAS_NOT_LAST '~'
 #define TCP_HANDSHAKE_SUCCESS "shaking your hand"
 #define TCP_EXECUTION_SUCCESS "success"
-#define TCP_EXECUTION_ERROR ""
+#define TCP_EXECUTION_ERROR "error"
 
 // tcp query arguments
 #define QUERY_FIRST "f"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 21e9159876..88f321a068 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -465,7 +465,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry open_server_cmd_desc = {
                 .handler = handle_open_server,
             };
-            open_server_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_OPEN_SERVER, '\0' };
+            open_server_cmd_desc.cmd = (char[2]) { TCP_CHAR_OPEN_SERVER, '\0' };
             cmd_parser = &open_server_cmd_desc;
         }
         break;
@@ -475,7 +475,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry go_cmd_desc = {
                 .handler = handle_vm_start,
             };
-            go_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_GO, '\0' };
+            go_cmd_desc.cmd = (char[2]) { TCP_CHAR_GO, '\0' };
             cmd_parser = &go_cmd_desc;
         }
         break;
@@ -485,7 +485,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry break_cmd_desc = {
                 .handler = handle_vm_stop,
             };
-            break_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_BREAK, '\0' };
+            break_cmd_desc.cmd = (char[2]) { TCP_CHAR_BREAK, '\0' };
             cmd_parser = &break_cmd_desc;
         }
         break;
@@ -500,8 +500,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry query_cmd_desc = {
                 .handler = handle_gen_query,
             };
-            query_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_QUERY, '\0' };
-            strcpy(query_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_STRING, '\0' });
+            query_cmd_desc.cmd = (char[2]) { TCP_CHAR_QUERY, '\0' };
+            strcpy(query_cmd_desc.schema, (char[2]) { ARG_SCHEMA_STRING, '\0' });
             cmd_parser = &query_cmd_desc;
         }
         break;
@@ -510,8 +510,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry open_core_cmd_desc = {
                 .handler = handle_open_core,
             };
-            open_core_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_OPEN_CORE, '\0' };
-            strcpy(open_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+            open_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_OPEN_CORE, '\0' };
+            strcpy(open_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &open_core_cmd_desc;
         }
         break;
@@ -520,7 +520,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_server_cmd_desc = {
                 .handler = handle_close_server,
             };
-            close_server_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_CLOSE_SERVER, '\0' };
+            close_server_cmd_desc.cmd = (char[2]) { TCP_CHAR_CLOSE_SERVER, '\0' };
             cmd_parser = &close_server_cmd_desc;
         }
         break;
@@ -529,8 +529,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry close_core_cmd_desc = {
                 .handler = handle_close_core,
             };
-            close_core_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_CLOSE_CORE, '\0' };
-            strcpy(close_core_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_CORENUM, '\0' });
+            close_core_cmd_desc.cmd = (char[2]) { TCP_CHAR_CLOSE_CORE, '\0' };
+            strcpy(close_core_cmd_desc.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &close_core_cmd_desc;
         }
         break;
@@ -539,8 +539,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry reset_cmd_desc = {
                 .handler = handle_reset,
             };
-            reset_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_RESET, '\0' };
-            strcpy(reset_cmd_desc.schema, (char[2]) { (char) ARG_SCHEMA_INT, '\0' });
+            reset_cmd_desc.cmd = (char[2]) { TCP_CHAR_RESET, '\0' };
+            strcpy(reset_cmd_desc.schema, (char[2]) { ARG_SCHEMA_INT, '\0' });
             cmd_parser = &reset_cmd_desc;
         }
         break;
@@ -549,7 +549,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry read_reg_cmd_desc = {
                 .handler = handle_read_register,
             };
-            read_reg_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_READ_REGISTER, '\0' };
+            read_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_REGISTER, '\0' };
             strcpy(read_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
             cmd_parser = &read_reg_cmd_desc;
         }
@@ -559,7 +559,7 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_reg_cmd_desc = {
                 .handler = handle_write_register,
             };
-            write_reg_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_WRITE_REGISTER, '\0' };
+            write_reg_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_REGISTER, '\0' };
             strcpy(write_reg_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
             cmd_parser = &write_reg_cmd_desc;
         }
@@ -569,8 +569,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry read_mem_cmd_desc = {
                 .handler = handle_read_memory,
             };
-            read_mem_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_READ_MEMORY, '\0' };
-            strcpy(read_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            read_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_READ_MEMORY, '\0' };
+            strcpy(read_mem_cmd_desc.schema, (char[4]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, '\0' });
             cmd_parser = &read_mem_cmd_desc;
         }
         break;
@@ -579,8 +579,8 @@ int mcd_handle_packet(const char *line_buf)
             static MCDCmdParseEntry write_mem_cmd_desc = {
                 .handler = handle_write_memory,
             };
-            write_mem_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_WRITE_MEMORY, '\0' };
-            strcpy(write_mem_cmd_desc.schema, (char[3]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_INT, '\0' });
+            write_mem_cmd_desc.cmd = (char[2]) { TCP_CHAR_WRITE_MEMORY, '\0' };
+            strcpy(write_mem_cmd_desc.schema, (char[5]) { ARG_SCHEMA_CORENUM, ARG_SCHEMA_UINT64_T, ARG_SCHEMA_INT, ARG_SCHEMA_HEXDATA, '\0' });
             cmd_parser = &write_mem_cmd_desc;
         }
         break;
@@ -652,29 +652,43 @@ uint64_t atouint64_t(const char* in) {
 int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     
     char data_buffer[64] = {0};
-    char *separator = strchr(data, ARGUMENT_SEPARATOR);
-    int seperator_index = (int)(separator - data);
-
-    if (separator) {
-        // we got two arguments
-        strncpy(data_buffer, data, seperator_index);
-    }
-    else {
-        strncpy(data_buffer, data, strlen(data));
-    }
+    const char *remaining_data = data;
+    
     for (int i = 0; i<strlen(schema); i++) {
+        // get correct part of string
+        char *separator = strchr(remaining_data, ARGUMENT_SEPARATOR);
+
+        if (separator) {
+            // we multiple arguments left
+            int seperator_index = (int)(separator - remaining_data);
+            strncpy(data_buffer, remaining_data, seperator_index);
+            data_buffer[seperator_index] = 0;
+            // update remaining data for the next run
+            remaining_data = &(remaining_data[seperator_index+1]);
+        }
+        else {
+            strncpy(data_buffer, remaining_data, strlen(remaining_data));
+            data_buffer[strlen(remaining_data)] = 0;
+        }
+        
+        // store right data
         MCDCmdVariant this_param; 
         switch (schema[i]) {
         case ARG_SCHEMA_STRING:
-            this_param.data = data;
+            // a string has to be the last argument
+            this_param.data = remaining_data;
             g_array_append_val(params, this_param);
             break;
+        case ARG_SCHEMA_HEXDATA:
+            // a string has to be the last argument
+            g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
+            break;
         case ARG_SCHEMA_INT:
             this_param.data_int = atoi(data_buffer);
             g_array_append_val(params, this_param);
             break;
-        case ARG_SCHEMA_UINT32_T:
-            this_param.data_int = atoi(data_buffer);
+        case ARG_SCHEMA_UINT64_T:
+            this_param.data_uint64_t = atouint64_t(data_buffer);
             g_array_append_val(params, this_param);
             break;
         case ARG_SCHEMA_QRYHANDLE:
@@ -688,11 +702,6 @@ int cmd_parse_params(const char *data, const char *schema, GArray *params) {
         default:
             return -1;
         }
-        
-        if (separator) {
-            // we got two arguments
-            strncpy(data_buffer, &data[seperator_index+1], strlen(&data[seperator_index+1]));
-        }
     }
     return 0;
 }
@@ -1796,6 +1805,16 @@ void mcd_memtohex(GString *buf, const uint8_t *mem, int len) {
     g_string_append_c(buf, '\0');
 }
 
+void mcd_hextomem(GByteArray *mem, const char *buf, int len) {
+    int i;
+
+    for(i = 0; i < len; i++) {
+        guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        g_byte_array_append(mem, &byte, 1);
+        buf += 2;
+    }
+}
+
 void handle_read_register(GArray *params, void *user_ctx) {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     int reg_num = get_param(params, 1)->data_int;
@@ -1805,8 +1824,6 @@ void handle_read_register(GArray *params, void *user_ctx) {
 
     reg_size = mcd_read_register(cpu, mcdserver_state.mem_buf, reg_num);
     mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, reg_size);
-    //g_string_printf(mcdserver_state.str_buf, "%s=%d;%d.%s=%d.",
-    //    TCP_ARGUMENT_DATA, *mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->data[1], TCP_ARGUMENT_SIZE, reg_size);
     mcd_put_strbuf();
 }
 
@@ -1814,8 +1831,7 @@ void handle_write_register(GArray *params, void *user_ctx) {
 
 }
 
-int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
-{
+int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
     CPUClass *cc;
     //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
     cc = CPU_GET_CLASS(cpu);
@@ -1827,21 +1843,45 @@ int mcd_read_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len)
     return cpu_memory_rw_debug(cpu, addr, buf, len, false);
 }
 
+int mcd_write_memory(CPUState *cpu, hwaddr addr, uint8_t *buf, int len) {
+    CPUClass *cc;
+    //TODO: add physical mem cpu_physical_memory_read(addr, buf, len);
+    cc = CPU_GET_CLASS(cpu);
+    if (cc->memory_rw_debug) {
+        // TODO: check out the difference between those two calls
+        return cc->memory_rw_debug(cpu, addr, buf, len, true);
+    }
+
+    return cpu_memory_rw_debug(cpu, addr, buf, len, true);
+}
+
 void handle_read_memory(GArray *params, void *user_ctx) {
     uint32_t cpu_id = get_param(params, 0)->cpu_id;
     uint64_t mem_address = get_param(params, 1)->data_uint64_t;
     int len = get_param(params, 2)->data_int;
 
     CPUState *cpu = mcd_get_cpu(cpu_id);
-    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf, len)!=0) {
+    g_byte_array_set_size(mcdserver_state.mem_buf, len);
+    if (mcd_read_memory(cpu, mem_address, mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len)!=0) {
         mcd_put_packet(TCP_EXECUTION_ERROR);
     }
     else {
-        mcd_memtohex(mcdserver_state.str_buf,  mcdserver_state.mem_buf->data, len);
+        mcd_memtohex(mcdserver_state.str_buf, mcdserver_state.mem_buf->data, mcdserver_state.mem_buf->len);
         mcd_put_strbuf();
     }
 }
 
 void handle_write_memory(GArray *params, void *user_ctx) {
+    uint32_t cpu_id = get_param(params, 0)->cpu_id;
+    uint64_t mem_address = get_param(params, 1)->data_uint64_t;
+    int len = get_param(params, 2)->data_int;
 
+    CPUState *cpu = mcd_get_cpu(cpu_id);
+    mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, len);
+    if (mcd_write_memory(cpu, mem_address, mcdserver_state.mem_buf->data, len)!=0) {
+        mcd_put_packet(TCP_EXECUTION_ERROR);
+    }
+    else {
+        mcd_put_packet(TCP_EXECUTION_SUCCESS);
+    }
 }
-- 
2.34.1


