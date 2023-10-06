Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA917BB3DD
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn1-00082N-7J; Fri, 06 Oct 2023 05:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmr-0007zb-9E
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:21 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmp-0000tA-7s
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:21 -0400
Received: (qmail 19425 invoked by uid 484); 6 Oct 2023 09:06:16 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071552 secs); 06 Oct 2023 09:06:16 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:15 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 04/29] queries for resets and triggers added
Date: Fri,  6 Oct 2023 11:05:45 +0200
Message-Id: <20231006090610.26171-5-nicolas.eder@lauterbach.com>
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
 mcdstub/internals.h |  9 +++++++++
 mcdstub/mcdstub.c   | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 5af705a12a..ce3bffe7e6 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -11,6 +11,14 @@
 
 #define MAX_PACKET_LENGTH 1024
 
+// trigger defines
+#define MCD_TRIG_TYPE_IP 0x00000001
+#define MCD_TRIG_TYPE_READ 0x00000002
+#define MCD_TRIG_TYPE_WRITE 0x00000004
+#define MCD_TRIG_TYPE_RW 0x00000008
+#define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
+#define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
+
 /*
  * lookuptable for transmitted signals
  */
@@ -180,6 +188,7 @@ CPUState *find_cpu(uint32_t thread_id);
 void handle_core_open(GArray *params, void *user_ctx);
 void handle_query_reset(GArray *params, void *user_ctx);
 void handle_detach(GArray *params, void *user_ctx);
+void handle_query_trigger(GArray *params, void *user_ctx);
 void mcd_continue(void);
 
 /* sycall handling */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 75b38d910a..1d066c8169 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -57,6 +57,10 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
         .handler = handle_query_reset,
         .cmd = "reset",
     },
+    {
+        .handler = handle_query_trigger,
+        .cmd = "trigger",
+    },
 };
 
 void mcd_init_mcdserver_state(void)
@@ -991,7 +995,8 @@ void handle_core_open(GArray *params, void *user_ctx) {
 void handle_query_reset(GArray *params, void *user_ctx) {
     // resetting has to be done over a monitor (look ar Rcmd) so we tell MCD that we can reset but this still need to be implemented
     // we only support one reset over this monitor and that would be a fully "system_restart"
-    mcd_put_packet("info_rst=\"results in a full system restart\"");
+    mcd_put_packet("nr=\"3\",info=\"0,full_system_reset;1,gpr_reset;2,memory_reset;\"");
+    // TODO: we still need to implement the gpr and memory reset here!
 }
 
 void handle_detach(GArray *params, void *user_ctx) {
@@ -1022,6 +1027,18 @@ void handle_detach(GArray *params, void *user_ctx) {
     }
 }
 
+void handle_query_trigger(GArray *params, void *user_ctx) {
+    // set the type, option and action bitmask and send it
+
+    uint32_t type = (MCD_TRIG_TYPE_IP | MCD_TRIG_TYPE_READ | MCD_TRIG_TYPE_WRITE | MCD_TRIG_TYPE_RW);
+    uint32_t option = (MCD_TRIG_OPT_DATA_IS_CONDITION);
+    uint32_t action = (MCD_TRIG_ACTION_DBG_DEBUG);
+    uint32_t nr_trigger = 4;
+
+    g_string_append_printf(mcdserver_state.str_buf, "nr=\"%d\",info=\"%d;%d;%d;\"", nr_trigger, type, option, action);
+    mcd_put_strbuf();
+}
+
 void mcd_continue(void)
 {
     if (!runstate_needs_reset()) {
-- 
2.34.1


