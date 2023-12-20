Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A481A510
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzPG-0000VZ-E0; Wed, 20 Dec 2023 11:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPC-0000UE-7U
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:46 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzPA-0004nY-CW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:45 -0500
Received: (qmail 15563 invoked by uid 484); 20 Dec 2023 16:26:32 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.073401 secs); 20 Dec 2023 16:26:32 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:29 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 15/18] mcdstub: skeleton for reset handling added
Date: Wed, 20 Dec 2023 17:25:52 +0100
Message-Id: <20231220162555.19545-16-nicolas.eder@lauterbach.com>
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
 debug/mcdstub/mcdstub.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
index fb13958108..df97eca65b 100644
--- a/debug/mcdstub/mcdstub.c
+++ b/debug/mcdstub/mcdstub.c
@@ -826,6 +826,37 @@ static void handle_vm_stop(GArray *params, void *user_ctx)
     mcd_vm_stop();
 }
 
+/**
+ * mcd_exit() - Terminates QEMU.
+ *
+ * If the mcdserver_state has not been initialized the function exits before
+ * terminating QEMU. Terminting is done with the qemu_chr_fe_deinit function.
+ * @code: An exitcode, which can be used in the future.
+ */
+static void mcd_exit(int code)
+{
+    /* terminate qemu */
+    if (!mcdserver_state.init) {
+        return;
+    }
+
+    qemu_chr_fe_deinit(&mcdserver_system_state.chr, true);
+}
+
+/**
+ * handle_reset() - Handler for performing resets.
+ *
+ * This function is currently not in use.
+ * @params: GArray with all TCP packet parameters.
+ */
+static void handle_reset(GArray *params, void *user_ctx)
+{
+    /*
+     * int reset_id = get_param(params, 0)->data_int;
+     * TODO: implement resets
+     */
+}
+
 /**
  * mcd_handle_packet() - Evaluates the type of received packet and chooses the
  * correct handler.
@@ -921,6 +952,21 @@ static int mcd_handle_packet(const char *line_buf)
             cmd_parser = &break_cmd_desc;
         }
         break;
+    case TCP_CHAR_KILLQEMU:
+        /* kill qemu completely */
+        error_report("QEMU: Terminated via MCDstub");
+        mcd_exit(0);
+        exit(0);
+    case TCP_CHAR_RESET:
+        {
+            static MCDCmdParseEntry reset_cmd_desc = {
+                .handler = handle_reset,
+                .cmd = {TCP_CHAR_RESET, '\0'},
+                .schema = {ARG_SCHEMA_INT, '\0'},
+            };
+            cmd_parser = &reset_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
-- 
2.34.1


