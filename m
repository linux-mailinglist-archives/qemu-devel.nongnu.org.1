Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6A81A501
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:28:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPJ-0000Wm-EH; Wed, 20 Dec 2023 11:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPC-0000UI-F5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:46 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPA-0004ml-AH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:46 -0500
Received: (qmail 15531 invoked by uid 484); 20 Dec 2023 16:26:29 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.089016 secs); 20 Dec 2023 16:26:29 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:26 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 14/18] mcdstub: state query added
Date: Wed, 20 Dec 2023 17:25:51 +0100
Message-Id: <20231220162555.19545-15-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index ee52830a2c..fb13958108 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -1406,6 +1406,43 @@ static void handle_query_regs_c(GArray *params, void *user_ctx)
     mcd_put_strbuf();
 }
 
+/**
+ * handle_query_state() - Handler for the state query.
+ *
+ * This function collects all data stored in the
+ * cpu_state member of the mcdserver_state and formats and sends it to the
+ * library.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_query_state(GArray *params, void *user_ctx)
+{
+    /*
+     * TODO: multicore support
+     * get state info
+     */
+    mcd_cpu_state_st state_info = mcdserver_state.cpu_state;
+    /* TODO: add event information */
+    uint32_t event = 0;
+    /* send data */
+    g_string_printf(mcdserver_state.str_buf,
+        "%s=%s.%s=%u.%s=%u.%s=%u.%s=%lu.%s=%s.%s=%s.",
+        TCP_ARGUMENT_STATE, state_info.state,
+        TCP_ARGUMENT_EVENT, event, TCP_ARGUMENT_THREAD, 0,
+        TCP_ARGUMENT_TYPE, state_info.bp_type,
+        TCP_ARGUMENT_ADDRESS, state_info.bp_address,
+        TCP_ARGUMENT_STOP_STRING, state_info.stop_str,
+        TCP_ARGUMENT_INFO_STRING, state_info.info_str);
+    mcd_put_strbuf();
+
+    /* reset debug info after first query */
+    if (strcmp(state_info.state, CORE_STATE_DEBUG) == 0) {
+        mcdserver_state.cpu_state.stop_str = "";
+        mcdserver_state.cpu_state.info_str = "";
+        mcdserver_state.cpu_state.bp_type = 0;
+        mcdserver_state.cpu_state.bp_address = 0;
+    }
+}
+
 /**
  * init_query_cmds_table() - Initializes all query functions.
  *
@@ -1501,6 +1538,13 @@ static void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
     strcpy(query_regs_c.schema, (char[2]) { ARG_SCHEMA_QRYHANDLE, '\0' });
     mcd_query_cmds_table[cmd_number] = query_regs_c;
     cmd_number++;
+
+    MCDCmdParseEntry query_state = {
+        .handler = handle_query_state,
+        .cmd = QUERY_ARG_STATE,
+    };
+    strcpy(query_state.schema, (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+    mcd_query_cmds_table[cmd_number] = query_state;
 }
 
 /**
-- 
2.34.1


