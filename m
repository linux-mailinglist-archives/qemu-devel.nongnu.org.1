Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A4718182
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LoI-0005kI-Ks; Wed, 31 May 2023 09:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoE-0005cK-3k
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Lo9-0004Lw-Pu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685539448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og53zO2oDpZYfwC+DsBUoXwKDCBdok0FLhJi5Kg+Tbo=;
 b=CGFKYoeT1aiiSxWUur8+qRIrtB0iBJ5gd1VCYaJqjrJwhPzKai679NsysCy+xwshFWBgmK
 /vdvkGNZfFc9tDzTzVr4xrtBJQB5gS4o9+JKaWHUm4CSxQ8HSzN+Py7qucS2ULEdp2oPqP
 gZ5ujPnZu1YwL3LUWpUqR3D+Dsx14ss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-PjSL0xrOPN-m5UzlTpdPTQ-1; Wed, 31 May 2023 09:24:05 -0400
X-MC-Unique: PjSL0xrOPN-m5UzlTpdPTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9556C802E58
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0727E420AA;
 Wed, 31 May 2023 13:24:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/9] tests/qtest: add various qtest_qmp_assert_success()
 variants
Date: Wed, 31 May 2023 14:23:52 +0100
Message-Id: <20230531132400.1129576-2-berrange@redhat.com>
In-Reply-To: <20230531132400.1129576-1-berrange@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add several counterparts of qtest_qmp_assert_success() that can

 * Use va_list instead of ...
 * Accept a list of FDs to send
 * Return the response data

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
 tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c3a0ef5bb4..603c26d955 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1229,14 +1229,23 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s);
 }
 
-void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
+void qtest_vqmp_assert_success(QTestState *qts,
+                               const char *fmt, va_list args)
 {
-    va_list ap;
     QDict *response;
 
-    va_start(ap, fmt);
-    response = qtest_vqmp(qts, fmt, ap);
-    va_end(ap);
+    response = qtest_vqmp_assert_success_ref(qts, fmt, args);
+
+    qobject_unref(response);
+}
+
+QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
+                                     const char *fmt, va_list args)
+{
+    QDict *response;
+    QDict *ret;
+
+    response = qtest_vqmp(qts, fmt, args);
 
     g_assert(response);
     if (!qdict_haskey(response, "return")) {
@@ -1245,8 +1254,88 @@ void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
         g_string_free(s, true);
     }
     g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_qdict(response, "return");
+    qobject_ref(ret);
+    qobject_unref(response);
+
+    return ret;
+}
+
+#ifndef _WIN32
+QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
+                                         const char *fmt, va_list args)
+{
+    QDict *response;
+    QDict *ret;
+
+    response = qtest_vqmp_fds(qts, fds, nfds, fmt, args);
+
+    g_assert(response);
+    if (!qdict_haskey(response, "return")) {
+        GString *s = qobject_to_json_pretty(QOBJECT(response), true);
+        g_test_message("%s", s->str);
+        g_string_free(s, true);
+    }
+    g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_qdict(response, "return");
+    qobject_ref(ret);
+    qobject_unref(response);
+
+    return ret;
+}
+
+void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                   const char *fmt, va_list args)
+{
+    QDict *response;
+    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, args);
     qobject_unref(response);
 }
+#endif /* !_WIN32 */
+
+void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
+{
+    QDict *response;
+    va_list ap;
+    va_start(ap, fmt);
+    response = qtest_vqmp_assert_success_ref(qts, fmt, ap);
+    va_end(ap);
+    qobject_unref(response);
+}
+
+QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ...)
+{
+    QDict *response;
+    va_list ap;
+    va_start(ap, fmt);
+    response = qtest_vqmp_assert_success_ref(qts, fmt, ap);
+    va_end(ap);
+    return response;
+}
+
+#ifndef _WIN32
+void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                  const char *fmt, ...)
+{
+    QDict *response;
+    va_list ap;
+    va_start(ap, fmt);
+    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, ap);
+    va_end(ap);
+    qobject_unref(response);
+}
+
+QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
+                                        const char *fmt, ...)
+{
+    QDict *response;
+    va_list ap;
+    va_start(ap, fmt);
+    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, ap);
+    va_end(ap);
+    return response;
+}
+#endif /* !_WIN32 */
 
 bool qtest_big_endian(QTestState *s)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 8d7d450963..41bc6633bd 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -693,6 +693,73 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
  */
 void qtest_remove_abrt_handler(void *data);
 
+/**
+ * qtest_vqmp_assert_success:
+ * @qts: QTestState instance to operate on
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ * @args: variable arguments for @fmt
+ *
+ * Sends a QMP message to QEMU and asserts that a 'return' key is present in
+ * the response.
+ */
+void qtest_vqmp_assert_success(QTestState *qts,
+                               const char *fmt, va_list args)
+    G_GNUC_PRINTF(2, 0);
+
+/**
+ * qtest_vqmp_assert_success_ref:
+ * @qts: QTestState instance to operate on
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ * @args: variable arguments for @fmt
+ *
+ * Sends a QMP message to QEMU, asserts that a 'return' key is present in
+ * the response, and returns the response.
+ */
+QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
+                                     const char *fmt, va_list args)
+    G_GNUC_PRINTF(2, 0);
+
+#ifndef _WIN32
+/**
+ * qtest_vqmp_fds_assert_success:
+ * @qts: QTestState instance to operate on
+ * @fds: the file descriptors to send
+ * @nfds: number of @fds to send
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ * @args: variable arguments for @fmt
+ *
+ * Sends a QMP message with file descriptors to QEMU and
+ * asserts that a 'return' key is present in the response.
+ */
+void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                   const char *fmt, va_list args)
+    G_GNUC_PRINTF(4, 0);
+
+/**
+ * qtest_vqmp_fds_assert_success_ref:
+ * @qts: QTestState instance to operate on
+ * @fds: the file descriptors to send
+ * @nfds: number of @fds to send
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ * @args: variable arguments for @fmt
+ *
+ * Sends a QMP message with file descriptors to QEMU,
+ * asserts that a 'return' key is present in the response,
+ * and returns the response.
+ */
+QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
+                                         const char *fmt, va_list args)
+    G_GNUC_PRINTF(4, 0);
+#endif /* !_WIN32 */
+
 /**
  * qtest_qmp_assert_success:
  * @qts: QTestState instance to operate on
@@ -706,6 +773,54 @@ void qtest_remove_abrt_handler(void *data);
 void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/**
+ * qtest_qmp_assert_success_ref:
+ * @qts: QTestState instance to operate on
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message to QEMU, asserts that a 'return' key is present in
+ * the response, and returns the response.
+ */
+QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
+#ifndef _WIN32
+/**
+ * qtest_qmp_fd_assert_success:
+ * @qts: QTestState instance to operate on
+ * @fds: the file descriptors to send
+ * @nfds: number of @fds to send
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message with file descriptors to QEMU and
+ * asserts that a 'return' key is present in the response.
+ */
+void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                  const char *fmt, ...)
+    G_GNUC_PRINTF(4, 5);
+
+/**
+ * qtest_qmp_fd_assert_success_ref:
+ * @qts: QTestState instance to operate on
+ * @fds: the file descriptors to send
+ * @nfds: number of @fds to send
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message with file descriptors to QEMU,
+ * asserts that a 'return' key is present in the response,
+ * and returns the response.
+ */
+QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
+                                        const char *fmt, ...)
+    G_GNUC_PRINTF(4, 5);
+#endif /* !_WIN32 */
+
 /**
  * qtest_cb_for_every_machine:
  * @cb: Pointer to the callback function
-- 
2.40.1


