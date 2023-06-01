Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8A71F14B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4mb7-00018i-2i; Thu, 01 Jun 2023 14:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4mb2-00018Q-Cn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4mal-0005gD-KK
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685642404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9Uf66GQAYGNyoseaTra9ZW3uH/oqSMyIrU7px0i/OY=;
 b=NC1pCdz2AUjwc/qLdqsYQjwHg9kdDgCmc+WXJ0KwcgMIX0rcqIRuUidBocZ1uwebWKxrMx
 gH0kRU5mO7kJArfsc1VFIf9+Ro/xryxSTc5LsxXQ07pBeAhRguvzgo00q0XzEDroUc66Np
 9M+9otLwkoNgvsSlP7LBbLuhX1WA2Mo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664--6-7SIt7Pl2VQ7vzDKlsJg-1; Thu, 01 Jun 2023 12:14:20 -0400
X-MC-Unique: -6-7SIt7Pl2VQ7vzDKlsJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4661D8027F5
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:13:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E29F314171BB;
 Thu,  1 Jun 2023 16:13:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 01/10] tests/qtest: add various qtest_qmp_assert_success()
 variants
Date: Thu,  1 Jun 2023 17:13:38 +0100
Message-Id: <20230601161347.1803440-2-berrange@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c |  97 +++++++++++++++++++++++++++++++---
 tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c3a0ef5bb4..7ae28fb6ac 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1229,24 +1229,107 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s);
 }
 
-void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
+QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
+                                     const char *fmt, va_list args)
 {
-    va_list ap;
     QDict *response;
+    QDict *ret;
 
-    va_start(ap, fmt);
-    response = qtest_vqmp(qts, fmt, ap);
-    va_end(ap);
+    response = qtest_vqmp(qts, fmt, args);
+
+    g_assert(response);
+    if (!qdict_haskey(response, "return")) {
+        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(response), true);
+        g_test_message("%s", s->str);
+    }
+    g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_qdict(response, "return");
+    qobject_ref(ret);
+    qobject_unref(response);
+
+    return ret;
+}
+
+void qtest_vqmp_assert_success(QTestState *qts,
+                               const char *fmt, va_list args)
+{
+    QDict *response;
+
+    response = qtest_vqmp_assert_success_ref(qts, fmt, args);
+
+    qobject_unref(response);
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
 
     g_assert(response);
     if (!qdict_haskey(response, "return")) {
-        GString *s = qobject_to_json_pretty(QOBJECT(response), true);
+        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(response), true);
         g_test_message("%s", s->str);
-        g_string_free(s, true);
     }
     g_assert(qdict_haskey(response, "return"));
+    ret = qdict_get_qdict(response, "return");
+    qobject_ref(ret);
     qobject_unref(response);
+
+    return ret;
+}
+
+void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                   const char *fmt, va_list args)
+{
+    QDict *response;
+    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, args);
+    qobject_unref(response);
+}
+#endif /* !_WIN32 */
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
+void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
+{
+    va_list ap;
+    va_start(ap, fmt);
+    qtest_vqmp_assert_success(qts, fmt, ap);
+    va_end(ap);
+}
+
+#ifndef _WIN32
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
+
+void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
+                                  const char *fmt, ...)
+{
+    va_list ap;
+    va_start(ap, fmt);
+    qtest_vqmp_fds_assert_success(qts, fds, nfds, fmt, ap);
+    va_end(ap);
 }
+#endif /* !_WIN32 */
 
 bool qtest_big_endian(QTestState *s)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 8d7d450963..d310eba7fb 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -693,6 +693,86 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
  */
 void qtest_remove_abrt_handler(void *data);
 
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
+#ifndef _WIN32
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
+
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
+#endif /* !_WIN32 */
+
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
 /**
  * qtest_qmp_assert_success:
  * @qts: QTestState instance to operate on
@@ -706,6 +786,41 @@ void qtest_remove_abrt_handler(void *data);
 void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+#ifndef _WIN32
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
+
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
+#endif /* !_WIN32 */
+
 /**
  * qtest_cb_for_every_machine:
  * @cb: Pointer to the callback function
-- 
2.40.1


