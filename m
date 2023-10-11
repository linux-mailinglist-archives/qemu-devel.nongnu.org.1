Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C27C4F35
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQD-0007Ap-VB; Wed, 11 Oct 2023 05:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQC-0007A7-3V
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQ9-0004rN-SA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnrq8LoFp56BDEAWbW/k2CW+DRswhfjulEEnTPZLRJM=;
 b=irVZ1gahJvVuQNPTBHbbBDzp2xcb2vW3svmoJdRCTYXQLgXbvce7oQaqQrrQuGME8l42e/
 dkr6e5nUnyTibyD9Irf5BaucEgb6jitPnPIjBXEvEAFpR0DA9/zfso/qibrDR2Bl4a8iV4
 9g7cbnxLD50s2YF5xuIO5FAfWqwoCR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-nPmCmY0zMRqY-ygoVBWl9w-1; Wed, 11 Oct 2023 05:22:19 -0400
X-MC-Unique: nPmCmY0zMRqY-ygoVBWl9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6792887E46;
 Wed, 11 Oct 2023 09:22:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06FAB1C060AE;
 Wed, 11 Oct 2023 09:22:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/65] tests/qtest: migration: Add support for negative testing
 of qmp_migrate
Date: Wed, 11 Oct 2023 11:21:04 +0200
Message-ID: <20231011092203.1266-7-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

There is currently no way to write a test for errors that happened in
qmp_migrate before the migration has started.

Add a version of qmp_migrate that ensures an error happens. To make
use of it a test needs to set MigrateCommon.result as
MIG_TEST_QMP_ERROR.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230712190742.22294-6-farosas@suse.de>
---
 tests/qtest/libqtest.h          | 28 ++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  3 +++
 tests/qtest/libqtest.c          | 33 +++++++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.c | 20 ++++++++++++++++++++
 tests/qtest/migration-test.c    | 16 ++++++++++++----
 5 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index e53e350e3a..5fe3d13466 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -810,6 +810,34 @@ void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
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
 
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 3f94a4f477..dc7a55634c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1259,6 +1259,28 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
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
@@ -1321,6 +1343,17 @@ void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
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
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 84660b3e3d..8eb2053dbb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -697,6 +697,8 @@ typedef struct {
         MIG_TEST_FAIL,
         /* This test should fail, dest qemu should fail with abnormal status */
         MIG_TEST_FAIL_DEST_QUIT_ERR,
+        /* The QMP command for this migration should fail with an error */
+        MIG_TEST_QMP_ERROR,
     } result;
 
     /*
@@ -1503,6 +1505,7 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    g_autofree char *connect_uri = NULL;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1537,13 +1540,17 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1595,6 +1602,7 @@ static void test_precopy_common(MigrateCommon *args)
         wait_for_serial("dest_serial");
     }
 
+finish:
     if (args->finish_hook) {
         args->finish_hook(from, to, data_hook);
     }
-- 
2.41.0


