Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B417E3F8B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:05:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlR-0000WR-Hv; Tue, 07 Nov 2023 08:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0008GN-I1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:24 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkK-0005vg-MG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:07 -0500
Received: (qmail 31185 invoked by uid 484); 7 Nov 2023 13:03:54 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 1.9e-05 secs); 07 Nov 2023 13:03:54 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:52 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 08/20] mcdstub: query packet processing added and
 core/system querie added
Date: Tue,  7 Nov 2023 14:03:11 +0100
Message-Id: <20231107130323.4126-9-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h | 30 +++++++++++++++++
 mcdstub/mcdstub.c         | 70 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index c3e9c7e9dc..c4370bb177 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -402,6 +402,18 @@ int process_string_cmd(void *user_ctx, const char *data,
  * @params: GArray with all extracted parameters.
  */
 int cmd_parse_params(const char *data, const char *schema, GArray *params);
+
+/**
+ * handle_gen_query() - Handler for all TCP query packets.
+ *
+ * Calls :c:func:`process_string_cmd` with all query functions in the
+ * mcd_query_cmds_table. :c:func:`process_string_cmd` then selects the correct
+ * one. This function just passes on the TCP packet data string from the
+ * parameters.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_gen_query(GArray *params, void *user_ctx);
+
 /**
  * mcd_get_cpu_index() - Returns the internal CPU index plus one.
  *
@@ -415,6 +427,24 @@ int mcd_get_cpu_index(CPUState *cpu);
  * @cpu_index: Index of the desired CPU.
  */
 CPUState *mcd_get_cpu(uint32_t cpu_index);
+
+/**
+ * handle_query_cores() - Handler for the core query.
+ *
+ * This function sends the type of core and number of cores currently
+ * simulated by QEMU. It also sends a device name for the MCD data structure.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_cores(GArray *params, void *user_ctx);
+
+/**
+ * handle_query_system() - Handler for the system query.
+ *
+ * Sends the system name, which is "qemu-system".
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_system(GArray *params, void *user_ctx);
+
 /**
  * get_first_cpu_in_process() - Returns the first CPU in the provided process.
  *
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 858e79632b..a090268e70 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -81,6 +81,20 @@ void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
     /* initalizes a list of all query commands */
     int cmd_number = 0;
 
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
 void reset_mcdserver_state(void)
 {
     g_free(mcdserver_state.processes);
@@ -345,6 +359,17 @@ int mcd_handle_packet(const char *line_buf)
         error_report("QEMU: Terminated via MCDstub");
         mcd_exit(0);
         exit(0);
+    case TCP_CHAR_QUERY:
+        {
+            static MCDCmdParseEntry query_cmd_desc = {
+                .handler = handle_gen_query,
+            };
+            query_cmd_desc.cmd = (char[2]) { TCP_CHAR_QUERY, '\0' };
+            strcpy(query_cmd_desc.schema,
+                (char[2]) { ARG_SCHEMA_STRING, '\0' });
+            cmd_parser = &query_cmd_desc;
+        }
+        break;
     case TCP_CHAR_CLOSE_SERVER:
         {
             static MCDCmdParseEntry close_server_cmd_desc = {
@@ -368,6 +393,20 @@ int mcd_handle_packet(const char *line_buf)
 
     return RS_IDLE;
 }
+
+void handle_gen_query(GArray *params, void *user_ctx)
+{
+    if (!params->len) {
+        return;
+    }
+    /* iterate over all possible query functions and execute the right one */
+    if (process_string_cmd(NULL, get_param(params, 0)->data,
+                           mcdserver_state.mcd_query_cmds_table,
+                           ARRAY_SIZE(mcdserver_state.mcd_query_cmds_table))) {
+        mcd_put_packet("");
+    }
+}
+
 void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
 {
     if (!data) {
@@ -735,6 +774,37 @@ void handle_open_server(GArray *params, void *user_ctx)
     mcd_put_packet(TCP_HANDSHAKE_SUCCESS);
 }
 
+void handle_query_system(GArray *params, void *user_ctx)
+{
+    mcd_put_packet(MCD_SYSTEM_NAME);
+}
+
+void handle_query_cores(GArray *params, void *user_ctx)
+{
+    /* get first cpu */
+    CPUState *cpu = mcd_first_attached_cpu();
+    if (!cpu) {
+        return;
+    }
+
+    ObjectClass *oc = object_get_class(OBJECT(cpu));
+    const char *cpu_model = object_class_get_name(oc);
+
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    const gchar *arch = cc->gdb_arch_name(cpu);
+
+    uint32_t nr_cores = cpu->nr_cores;
+    char device_name[ARGUMENT_STRING_LENGTH] = {0};
+    if (arch) {
+        snprintf(device_name, sizeof(device_name), "%s",
+            DEVICE_NAME_TEMPLATE(arch));
+    }
+    g_string_printf(mcdserver_state.str_buf, "%s=%s.%s=%s.%s=%u.",
+        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
+        TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
+    mcd_put_strbuf();
+}
+
 
 void handle_close_server(GArray *params, void *user_ctx)
 {
-- 
2.34.1


