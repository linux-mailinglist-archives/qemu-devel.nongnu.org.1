Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5397E3F9E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:07:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmm-0002NH-Fz; Tue, 07 Nov 2023 08:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Ll2-00009L-5K
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:42 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkr-00061B-V0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:33 -0500
Received: (qmail 31355 invoked by uid 484); 7 Nov 2023 13:04:06 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.16659 secs); 07 Nov 2023 13:04:06 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:04:04 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 14/20] mcdstub: missing handle_query_state function added
Date: Tue,  7 Nov 2023 14:03:17 +0100
Message-Id: <20231107130323.4126-15-nicolas.eder@lauterbach.com>
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
 mcdstub/mcdstub.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 56854c4c76..cd2f5db8e4 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -1466,3 +1466,32 @@ void handle_query_regs_c(GArray *params, void *user_ctx)
         TCP_ARGUMENT_OPCODE, my_register.opcode);
     mcd_put_strbuf();
 }
+
+void handle_query_state(GArray *params, void *user_ctx)
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
-- 
2.34.1


