Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E2D81A51E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:30:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP8-0000TC-Lh; Wed, 20 Dec 2023 11:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP5-0000Qz-4u
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:39 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP3-0004j1-8v
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:38 -0500
Received: (qmail 15252 invoked by uid 484); 20 Dec 2023 16:26:15 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.180907 secs); 20 Dec 2023 16:26:15 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:12 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 08/18] cutils: qemu_strtou32 function added
Date: Wed, 20 Dec 2023 17:25:45 +0100
Message-Id: <20231220162555.19545-9-nicolas.eder@lauterbach.com>
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
 include/qemu/cutils.h |  2 ++
 util/cutils.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 5ab1a4ffb0..14f492ba61 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -158,6 +158,8 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result);
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                   int64_t *result);
+int qemu_strtou32(const char *nptr, const char **endptr, int base,
+                  uint32_t *result);
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result);
 int qemu_strtod(const char *nptr, const char **endptr, double *result);
diff --git a/util/cutils.c b/util/cutils.c
index 42364039a5..5e00a4ec14 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -665,6 +665,36 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
     return check_strtox_error(nptr, ep, endptr, *result == 0, errno);
 }
 
+/**
+ * Convert string @nptr to an uint32_t.
+ *
+ * Works like qemu_strtoul(), except it stores UINT32_MAX on overflow.
+ * (If you want to prohibit negative numbers that wrap around to
+ * positive, use parse_uint()).
+ */
+int qemu_strtou32(const char *nptr, const char **endptr, int base,
+                  uint32_t *result)
+{
+    char *ep;
+
+    assert((unsigned) base <= 36 && base != 1);
+    if (!nptr) {
+        *result = 0;
+        if (endptr) {
+            *endptr = nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno = 0;
+    *result = strtoul(nptr, &ep, base);
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = -1;
+    }
+    return check_strtox_error(nptr, ep, endptr, *result == 0, errno);
+}
+
 /**
  * Convert string @nptr to an uint64_t.
  *
-- 
2.34.1


