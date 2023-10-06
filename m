Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A77BB3F3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn8-00087I-TH; Fri, 06 Oct 2023 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogn6-00086X-3r
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:36 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmy-0000wT-EQ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:35 -0400
Received: (qmail 19558 invoked by uid 484); 6 Oct 2023 09:06:25 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 4e-06 secs); 06 Oct 2023 09:06:25 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:23 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 10/29] handler for resets added
Date: Fri,  6 Oct 2023 11:05:51 +0200
Message-Id: <20231006090610.26171-11-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h          | 14 ++++----
 mcdstub/mcd_shared_defines.h |  4 +++
 mcdstub/mcdstub.c            | 65 ++++++++++++++++++++++++++++--------
 3 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index a4d49a4a84..0de8d8fd07 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -25,6 +25,7 @@
 // schema defines
 #define ARG_SCHEMA_QRYHANDLE 'q'
 #define ARG_SCHEMA_STRING 's'
+#define ARG_SCHEMA_INT 'd'
 #define ARG_SCHEMA_CORENUM 'c'
 
 // resets
@@ -34,8 +35,8 @@
 
 // more
 #define QUERY_TOTAL_NUMBER 11 //FIXME: set this to a usefull value in the end
-#define CMD_SCHEMA_LENGTH 2
-#define MCD_MAX_CORES 128
+#define CMD_SCHEMA_LENGTH 3
+#define MAX_SCHEMA_ARGS CMD_SCHEMA_LENGTH-1
 #define MCD_SYSTEM_NAME "qemu-system"
 // tcp query packet values templates
 #define DEVICE_NAME_TEMPLATE(s) "qemu-" #s "-device"
@@ -77,17 +78,17 @@ typedef enum MCDThreadIdKind {
 } MCDThreadIdKind;
 
 typedef union MCDCmdVariant {
-    const char *data;
     
+    const char *data;
+    int data_int;
+    int query_handle;
+    int cpu_id;
     struct {
         MCDThreadIdKind kind;
         uint32_t pid;
         uint32_t tid;
     } thread_id;
 
-    int query_handle;
-    int cpu_id;
-
 } MCDCmdVariant;
 
 #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
@@ -277,6 +278,7 @@ void handle_query_regs_f(GArray *params, void *user_ctx);
 void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_open_server(GArray *params, void *user_ctx);
 void parse_reg_xml(const char *xml, int size, GArray* registers);
+void handle_reset(GArray *params, void *user_ctx);
 
 // arm specific functions
 int mcd_arm_store_mem_spaces(CPUState *cpu, GArray* memspaces);
diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index e0b27ce5e6..7e96129cdf 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -11,6 +11,7 @@
 #define TCP_CHAR_CLOSE_SERVER 'D'
 #define TCP_CHAR_CLOSE_CORE 'd'
 #define TCP_CHAR_KILLQEMU 'k'
+#define TCP_CHAR_RESET 'r'
 
 // tcp protocol chars
 #define TCP_ACKNOWLEDGED '+'
@@ -54,4 +55,7 @@
 #define TCP_ARGUMENT_OPTION "option"
 #define TCP_ARGUMENT_ACTION "action"
 
+// for packets sent to qemu
+#define ARGUMENT_SEPARATOR ';'
+
 #endif
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a0c4c2794f..85e0c3a219 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -508,6 +508,16 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &close_core_cmd_desc;
         }
         break;
+    case TCP_CHAR_RESET:
+        {
+            static MCDCmdParseEntry reset_cmd_desc = {
+                .handler = handle_reset,
+            };
+            reset_cmd_desc.cmd = (char[2]) { (char) TCP_CHAR_RESET, '\0' };
+            strcpy(reset_cmd_desc.schema, (char[3]) { (char) ARG_SCHEMA_INT, ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &reset_cmd_desc;
+        }
+        break;
     default:
         // could not perform the command (because its unknown)
         mcd_put_packet("");
@@ -564,24 +574,42 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
 }
 
 int cmd_parse_params(const char *data, const char *schema, GArray *params) {
-    MCDCmdVariant this_param;
-
+    
     char data_buffer[64] = {0};
-    if (schema[0] == ARG_SCHEMA_STRING) {
-        this_param.data = data;
-        g_array_append_val(params, this_param);
-    }
-    else if (schema[0] == ARG_SCHEMA_QRYHANDLE) {
-        strncat(data_buffer, data, strlen(data));
-        this_param.query_handle = atoi(data_buffer);
-        g_array_append_val(params, this_param);
+    char *separator = strchr(data_buffer, ARGUMENT_SEPARATOR);
+    int seperator_index = (int)(separator - data);
+
+    if (separator) {
+        // we got two arguments
+        strncpy(data_buffer, data, seperator_index);
     }
-    else if (schema[0] == ARG_SCHEMA_CORENUM) {
-        strncat(data_buffer, data, strlen(data));
-        this_param.cpu_id = atoi(data_buffer);
-        g_array_append_val(params, this_param);
+    else {
+        strncpy(data_buffer, data, strlen(data));
     }
+    for (int i = 0; i<MAX_SCHEMA_ARGS; i++) {
+        MCDCmdVariant this_param;
+        if (schema[i] == ARG_SCHEMA_STRING) {
+            this_param.data = data_buffer;
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] == ARG_SCHEMA_INT) {
+            this_param.data_int = atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] == ARG_SCHEMA_QRYHANDLE) {
+            this_param.query_handle = atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
+        else if (schema[i] == ARG_SCHEMA_CORENUM) {
+            this_param.cpu_id = atoi(data_buffer);
+            g_array_append_val(params, this_param);
+        }
 
+        if (separator) {
+            // we got two arguments
+            strncpy(data_buffer, &data[seperator_index+1], strlen(&data[seperator_index+1]));
+        }
+    }
     return 0;
 }
 
@@ -1532,3 +1560,12 @@ void handle_query_regs_c(GArray *params, void *user_ctx) {
         TCP_ARGUMENT_TYPE, my_register.mcd_reg_type, TCP_ARGUMENT_THREAD, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
+
+void handle_reset(GArray *params, void *user_ctx) {
+    int reset_id = get_param(params, 0)->data_int;
+    int bool_halt_after_reset = get_param(params, 1)->data_int;
+    if (reset_id>=0 && bool_halt_after_reset) {
+        //fun for the compiler
+    }
+    
+}
-- 
2.34.1


