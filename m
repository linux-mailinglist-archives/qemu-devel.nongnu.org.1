Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198567E3FC9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:10:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmr-0002cM-KT; Tue, 07 Nov 2023 08:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkN-00089N-R4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:01 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkM-0005nQ-15
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:03:59 -0500
Received: (qmail 30874 invoked by uid 484); 7 Nov 2023 13:03:37 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.142005 secs); 07 Nov 2023 13:03:37 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:35 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 03/20] gdbstub: moving code so that it can be easier
 accessed from outside the gdbstub: fromhex and tohex functions moved to a
 cutils header. GDBRegisterState moved to gdbstub.h
Date: Tue,  7 Nov 2023 14:03:06 +0100
Message-Id: <20231107130323.4126-4-nicolas.eder@lauterbach.com>
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
 gdbstub/gdbstub.c      |  9 +--------
 gdbstub/internals.h    | 26 --------------------------
 include/cutils.h       | 30 ++++++++++++++++++++++++++++++
 include/exec/gdbstub.h |  9 ++++++++-
 4 files changed, 39 insertions(+), 35 deletions(-)
 create mode 100644 include/cutils.h

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1e96a71c0c..c43ff89393 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -44,14 +44,7 @@
 #include "exec/hwaddr.h"
 
 #include "internals.h"
-
-typedef struct GDBRegisterState {
-    int base_reg;
-    int num_regs;
-    gdb_get_reg_cb get_reg;
-    gdb_set_reg_cb set_reg;
-    const char *xml;
-} GDBRegisterState;
+#include "cutils.h"
 
 GDBState gdbserver_state;
 
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 465c24b36e..011e6f1858 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -74,32 +74,6 @@ typedef struct GDBState {
 /* lives in main gdbstub.c */
 extern GDBState gdbserver_state;
 
-/*
- * Inline utility function, convert from int to hex and back
- */
-
-static inline int fromhex(int v)
-{
-    if (v >= '0' && v <= '9') {
-        return v - '0';
-    } else if (v >= 'A' && v <= 'F') {
-        return v - 'A' + 10;
-    } else if (v >= 'a' && v <= 'f') {
-        return v - 'a' + 10;
-    } else {
-        return 0;
-    }
-}
-
-static inline int tohex(int v)
-{
-    if (v < 10) {
-        return v + '0';
-    } else {
-        return v - 10 + 'a';
-    }
-}
-
 /*
  * Connection helpers for both system and user backends
  */
diff --git a/include/cutils.h b/include/cutils.h
new file mode 100644
index 0000000000..a6b8dc3690
--- /dev/null
+++ b/include/cutils.h
@@ -0,0 +1,30 @@
+#ifndef CUTILS_H
+#define CUTILS_H
+
+/*
+ * Inline utility function, convert from int to hex and back
+ */
+
+static inline int fromhex(int v)
+{
+    if (v >= '0' && v <= '9') {
+        return v - '0';
+    } else if (v >= 'A' && v <= 'F') {
+        return v - 'A' + 10;
+    } else if (v >= 'a' && v <= 'f') {
+        return v - 'a' + 10;
+    } else {
+        return 0;
+    }
+}
+
+static inline int tohex(int v)
+{
+    if (v < 10) {
+        return v + '0';
+    } else {
+        return v - 10 + 'a';
+    }
+}
+
+#endif /* CUTILS_H */
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index f696e29477..cb70ebd7b4 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -15,11 +15,18 @@ typedef struct GDBFeature {
     const char *xml;
 } GDBFeature;
 
-
 /* Get or set a register.  Returns the size of the register.  */
 typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
 typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
 
+typedef struct GDBRegisterState {
+    int base_reg;
+    int num_regs;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const char *xml;
+} GDBRegisterState;
+
 /**
  * gdb_register_coprocessor() - register a supplemental set of registers
  * @cpu - the CPU associated with registers
-- 
2.34.1


