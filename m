Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16574A4C5
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVS9-0002Ri-Af; Thu, 06 Jul 2023 16:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHVS7-0002Ra-UB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:19:47 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHVS6-0002cX-1K
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:19:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F116C227A7;
 Thu,  6 Jul 2023 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688674784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C87qpSFqQu6OmQF28e015335rv9b9jGvSEYE+GArQBs=;
 b=DwK3yOv0/MaHhAYJk4F5XIJ/wShRjmGEj07Rzp/7odMlqR49s6E2scgc3uIXTZFedbsouk
 Pc8NkgjImk/Ibi6Lk5l+a9ztGq1lPoF7d5qM/sawn7jIOX1re8XqyIz1yQF9DVAVCG4NVR
 p7gqd3204D8A0U0G/mVkULKhDKBZBlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688674784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C87qpSFqQu6OmQF28e015335rv9b9jGvSEYE+GArQBs=;
 b=Vd7EDv9ZBewaLRrl+Am/ZK9G30skeqduqEyNLgeET4S1RVES6Ta78HnrGG78ViNLCxcQaQ
 D8PufxTczPrkQtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B54B138EE;
 Thu,  6 Jul 2023 20:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AEEJFd4hp2S8GAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 06 Jul 2023 20:19:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v4 5/6] tests/qtest: migration: Add support for negative
 testing of qmp_migrate
Date: Thu,  6 Jul 2023 17:19:26 -0300
Message-Id: <20230706201927.15442-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706201927.15442-1-farosas@suse.de>
References: <20230706201927.15442-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

There is currently no way to write a test for errors that happened in
qmp_migrate before the migration has started.

Add a version of qmp_migrate that ensures an error happens. To make
use of it a test needs to set MigrateCommon.result as
MIG_TEST_QMP_ERROR.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c          | 33 +++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h          | 28 ++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.c | 20 ++++++++++++++++++++
 tests/qtest/migration-helpers.h |  3 +++
 tests/qtest/migration-test.c    | 16 ++++++++++++----
 5 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 79152f0ec3..011ed255fa 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1248,6 +1248,28 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s);
 }
 
+QDict *qtest_vqmp_assert_failure_ref(QTestState *qts,
+                                     const char *fmt, va_list args)
+{
+    QDict *response;
+    QDict *ret;
+
+    response = qtest_vqmp(qts, fmt, args);
+
+    g_assert(response);
+    if (!qdict_haskey(response, "error")) {
+        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(response), true);
+        g_test_message("%s", s->str);
+    }
+    g_assert(qdict_haskey(response, "error"));
+    g_assert(!qdict_haskey(response, "return"));
+    ret = qdict_get_qdict(response, "error");
+    qobject_ref(ret);
+    qobject_unref(response);
+
+    return ret;
+}
+
 QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
                                      const char *fmt, va_list args)
 {
@@ -1310,6 +1332,17 @@ void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
 }
 #endif /* !_WIN32 */
 
+QDict *qtest_qmp_assert_failure_ref(QTestState *qts, const char *fmt, ...)
+{
+    QDict *response;
+    va_list ap;
+
+    va_start(ap, fmt);
+    response = qtest_vqmp_assert_failure_ref(qts, fmt, ap);
+    va_end(ap);
+    return response;
+}
+
 QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ...)
 {
     QDict *response;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 913acc3d5c..7ef19ce3ff 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -799,6 +799,34 @@ void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
     G_GNUC_PRINTF(4, 0);
 #endif /* !_WIN32 */
 
+/**
+ * qtest_qmp_assert_failure_ref:
+ * @qts: QTestState instance to operate on
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message to QEMU, asserts that an 'error' key is present in
+ * the response, and returns the response.
+ */
+QDict *qtest_qmp_assert_failure_ref(QTestState *qts, const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
+/**
+ * qtest_vqmp_assert_failure_ref:
+ * @qts: QTestState instance to operate on
+ * @fmt: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
+ * supported after '%'.
+ * @args: variable arguments for @fmt
+ *
+ * Sends a QMP message to QEMU, asserts that an 'error' key is present in
+ * the response, and returns the response.
+ */
+QDict *qtest_vqmp_assert_failure_ref(QTestState *qts,
+                                     const char *fmt, va_list args)
+    G_GNUC_PRINTF(2, 0);
+
 /**
  * qtest_qmp_assert_success_ref:
  * @qts: QTestState instance to operate on
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 08f5ee1179..0c185db450 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -49,6 +49,26 @@ bool migrate_watch_for_resume(QTestState *who, const char *name,
     return false;
 }
 
+void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+{
+    va_list ap;
+    QDict *args, *err;
+
+    va_start(ap, fmt);
+    args = qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
+
+    g_assert(!qdict_haskey(args, "uri"));
+    qdict_put_str(args, "uri", uri);
+
+    err = qtest_qmp_assert_failure_ref(
+        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
+
+    g_assert(qdict_haskey(err, "desc"));
+
+    qobject_unref(err);
+}
+
 /*
  * Send QMP command "migrate".
  * Arguments are built from @fmt... (formatted like
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 57d295a4fe..4f51d0f8bc 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -27,6 +27,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
+G_GNUC_PRINTF(3, 4)
+void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c4140ac3f1..2fdf6a115e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -564,6 +564,8 @@ typedef struct {
         MIG_TEST_FAIL,
         /* This test should fail, dest qemu should fail with abnormal status */
         MIG_TEST_FAIL_DEST_QUIT_ERR,
+        /* The QMP command for this migration should fail with an error */
+        MIG_TEST_QMP_ERROR,
     } result;
 
     /* Optional: set number of migration passes to wait for, if live==true */
@@ -1379,6 +1381,7 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1419,13 +1422,17 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (!args->connect_uri) {
-        g_autofree char *local_connect_uri =
-            migrate_get_socket_address(to, "socket-address");
-        migrate_qmp(from, local_connect_uri, "{}");
+        connect_uri = migrate_get_socket_address(to, "socket-address");
     } else {
-        migrate_qmp(from, args->connect_uri, "{}");
+        connect_uri = g_strdup(args->connect_uri);
     }
 
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, connect_uri, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from, connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1474,6 +1481,7 @@ static void test_precopy_common(MigrateCommon *args)
         wait_for_serial("dest_serial");
     }
 
+finish:
     if (args->finish_hook) {
         args->finish_hook(from, to, data_hook);
     }
-- 
2.35.3


