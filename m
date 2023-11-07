Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA57E3FC5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Llr-0000uC-Jm; Tue, 07 Nov 2023 08:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-0008GO-M2
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:24 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkO-0005z4-I7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:16 -0500
Received: (qmail 31250 invoked by uid 484); 7 Nov 2023 13:03:58 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071896 secs); 07 Nov 2023 13:03:58 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:56 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 11/20] mcdstub: reset and trigger queries added
Date: Tue,  7 Nov 2023 14:03:14 +0100
Message-Id: <20231107130323.4126-12-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h | 25 ++++++++++++++
 mcdstub/mcdstub.c         | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index eb46917d00..62394e7c12 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -507,6 +507,23 @@ CPUState *find_cpu(uint32_t thread_id);
  */
 void handle_open_core(GArray *params, void *user_ctx);
 
+/**
+ * handle_query_reset_f() - Handler for the first reset query.
+ *
+ * This function sends the first reset name and ID.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_reset_f(GArray *params, void *user_ctx);
+
+/**
+ * handle_query_reset_c() - Handler for all consecutive reset queries.
+ *
+ * This functions sends all consecutive reset names and IDs. It uses the
+ * query_index parameter to determine which reset is queried next.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_reset_c(GArray *params, void *user_ctx);
+
 /**
  * handle_close_server() - Handler for closing the MCD server.
  *
@@ -525,6 +542,14 @@ void handle_close_server(GArray *params, void *user_ctx);
  */
 void handle_close_core(GArray *params, void *user_ctx);
 
+/**
+ * handle_query_trigger() - Handler for trigger query.
+ *
+ * Sends data on the different types of trigger and their options and actions.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_query_trigger(GArray *params, void *user_ctx);
+
 /**
  * handle_open_server() - Handler for opening the MCD server.
  *
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 657f80d2a2..d71dff633a 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -95,6 +95,27 @@ void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
     mcd_query_cmds_table[cmd_number] = query_cores;
     cmd_number++;
 
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
+    strcpy(query_reset_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_reset_c;
+    cmd_number++;
+
+    MCDCmdParseEntry query_trigger = {
+        .handler = handle_query_trigger,
+        .cmd = QUERY_ARG_TRIGGER,
+    };
+    mcd_query_cmds_table[cmd_number] = query_trigger;
+    cmd_number++;
 
     MCDCmdParseEntry query_state = {
         .handler = handle_query_state,
@@ -1001,6 +1022,44 @@ void handle_open_core(GArray *params, void *user_ctx)
     }
 }
 
+void handle_query_reset_f(GArray *params, void *user_ctx)
+{
+    /* 1. check length */
+    int nb_resets = mcdserver_state.resets->len;
+    if (nb_resets == 1) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
+    }
+    /* 2. send data */
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets, mcd_reset_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+}
+
+void handle_query_reset_c(GArray *params, void *user_ctx)
+{
+    /* reset options are the same for every cpu! */
+    uint32_t query_index = get_param(params, 0)->query_handle;
+
+    /* 1. check weather this was the last mem space */
+    int nb_groups = mcdserver_state.resets->len;
+    if (query_index + 1 == nb_groups) {
+        /* indicates this is the last packet */
+        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
+    } else {
+        g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
+    }
+
+    /* 2. send data */
+    mcd_reset_st reset = g_array_index(mcdserver_state.resets,
+        mcd_reset_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "%s=%s.%s=%u.",
+        TCP_ARGUMENT_NAME, reset.name, TCP_ARGUMENT_ID, reset.id);
+    mcd_put_strbuf();
+}
 
 void handle_close_core(GArray *params, void *user_ctx)
 {
@@ -1047,3 +1106,13 @@ void handle_close_server(GArray *params, void *user_ctx)
     }
 }
 
+void handle_query_trigger(GArray *params, void *user_ctx)
+{
+    mcd_trigger_into_st trigger = mcdserver_state.trigger;
+    g_string_printf(mcdserver_state.str_buf, "%s=%u.%s=%s.%s=%s.%s=%s.",
+        TCP_ARGUMENT_AMOUNT_TRIGGER, trigger.nr_trigger,
+        TCP_ARGUMENT_TYPE, trigger.type,
+        TCP_ARGUMENT_OPTION, trigger.option,
+        TCP_ARGUMENT_ACTION, trigger.action);
+    mcd_put_strbuf();
+}
-- 
2.34.1


