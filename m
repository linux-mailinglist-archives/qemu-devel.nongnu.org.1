Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 190BA7E3FB3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:08:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lms-0002fS-LG; Tue, 07 Nov 2023 08:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Ll2-00009J-3u
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:42 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkr-00062I-Qr
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:33 -0500
Received: (qmail 31443 invoked by uid 484); 7 Nov 2023 13:04:12 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.093115 secs); 07 Nov 2023 13:04:12 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:10 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 16/20] mcdstub: function construct for resets added
Date: Tue,  7 Nov 2023 14:03:19 +0100
Message-Id: <20231107130323.4126-17-nicolas.eder@lauterbach.com>
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
 include/mcdstub/mcdstub.h |  8 ++++++++
 mcdstub/mcdstub.c         | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
index 0375cf7311..000d832a39 100644
--- a/include/mcdstub/mcdstub.h
+++ b/include/mcdstub/mcdstub.h
@@ -672,6 +672,14 @@ void handle_query_regs_c(GArray *params, void *user_ctx);
  */
 void handle_open_server(GArray *params, void *user_ctx);
 
+/**
+ * handle_reset() - Handler for performing resets.
+ *
+ * This function is currently not in use.
+ * @params: GArray with all TCP packet parameters.
+ */
+void handle_reset(GArray *params, void *user_ctx);
+
 /**
  * handle_query_state() - Handler for the state query.
  *
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 6313459bac..1a10bc6c98 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -511,6 +511,16 @@ int mcd_handle_packet(const char *line_buf)
             cmd_parser = &close_core_cmd_desc;
         }
         break;
+    case TCP_CHAR_RESET:
+        {
+            static MCDCmdParseEntry reset_cmd_desc = {
+                .handler = handle_reset,
+            };
+            reset_cmd_desc.cmd = (char[2]) { TCP_CHAR_RESET, '\0' };
+            strcpy(reset_cmd_desc.schema, (char[2]) { ARG_SCHEMA_INT, '\0' });
+            cmd_parser = &reset_cmd_desc;
+        }
+        break;
     default:
         /* command not supported */
         mcd_put_packet("");
@@ -1568,6 +1578,14 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
     mcd_put_strbuf();
 }
 
+void handle_reset(GArray *params, void *user_ctx)
+{
+    /*
+     * int reset_id = get_param(params, 0)->data_int;
+     * TODO: implement resets
+     */
+}
+
 void handle_query_state(GArray *params, void *user_ctx)
 {
     /*
-- 
2.34.1


