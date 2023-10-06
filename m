Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A17BB3E5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognw-0000xX-Kz; Fri, 06 Oct 2023 05:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognc-0008Kg-5n
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:08 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogna-000142-G8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:07 -0400
Received: (qmail 19968 invoked by uid 484); 6 Oct 2023 09:06:54 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.074474 secs); 06 Oct 2023 09:06:54 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:53 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 24/29] step and go handlers now propperly perform global
 operations
Date: Fri,  6 Oct 2023 11:06:05 +0200
Message-Id: <20231006090610.26171-25-nicolas.eder@lauterbach.com>
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
 mcdstub/mcd_shared_defines.h |  2 ++
 mcdstub/mcdstub.c            | 35 +++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
index 5cfda4121d..5fbd732252 100644
--- a/mcdstub/mcd_shared_defines.h
+++ b/mcdstub/mcd_shared_defines.h
@@ -78,6 +78,8 @@
 
 /* for packets sent to qemu */
 #define ARGUMENT_SEPARATOR ';'
+#define NEGATIVE_FLAG 0
+#define POSITIVE_FLAG 1
 
 /* core states */
 #define CORE_STATE_RUNNING "running"
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index b19ca471ea..7613ed2c4a 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -435,7 +435,7 @@ int mcd_handle_packet(const char *line_buf)
             };
             go_cmd_desc.cmd = (char[2]) { TCP_CHAR_GO, '\0' };
             strcpy(go_cmd_desc.schema,
-                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &go_cmd_desc;
         }
         break;
@@ -446,7 +446,7 @@ int mcd_handle_packet(const char *line_buf)
             };
             step_cmd_desc.cmd = (char[2]) { TCP_CHAR_STEP, '\0' };
             strcpy(step_cmd_desc.schema,
-                (char[2]) { ARG_SCHEMA_CORENUM, '\0' });
+                (char[3]) { ARG_SCHEMA_INT, ARG_SCHEMA_CORENUM, '\0' });
             cmd_parser = &step_cmd_desc;
         }
         break;
@@ -608,28 +608,35 @@ int mcd_handle_packet(const char *line_buf)
 
 void handle_vm_start(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial restart with arguments and so on */
-    uint32_t cpu_id = get_param(params, 0)->cpu_id;
-    CPUState *cpu = mcd_get_cpu(cpu_id);
-    mcd_cpu_start(cpu);
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        mcd_vm_start();
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        mcd_cpu_start(cpu);
+    }
 }
 
 void handle_vm_step(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial restart with arguments and so on */
-    uint32_t cpu_id = get_param(params, 0)->cpu_id;
-
-    CPUState *cpu = mcd_get_cpu(cpu_id);
-    int return_value = mcd_cpu_sstep(cpu);
-    if (return_value != 0) {
-        g_assert_not_reached();
+    uint32_t global = get_param(params, 0)->data_uint32_t;
+    if (global == 1) {
+        /* TODO: add multicore support */
+    } else{
+        uint32_t cpu_id = get_param(params, 1)->cpu_id;
+        CPUState *cpu = mcd_get_cpu(cpu_id);
+        int return_value = mcd_cpu_sstep(cpu);
+        if (return_value != 0) {
+            g_assert_not_reached();
+        }
     }
 }
 
 
 void handle_vm_stop(GArray *params, void *user_ctx)
 {
-    /* TODO: add partial stop with arguments and so on */
+    /* TODO: add core dependant break option */
     mcd_vm_stop();
 }
 
-- 
2.34.1


