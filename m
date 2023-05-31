Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC35718185
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:25:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LoS-0006Lg-2q; Wed, 31 May 2023 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoK-0005zB-Pv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoH-0004NM-1d
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685539456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax9zatSniEce5EheZNR52ukeRPOm+//cDon8LhsxKLE=;
 b=Kv/+VRikGa0dLbXYXPiFeBqcm8q+8LsSLvStNz4YHhAPh44mRhZe69viYZ6wZjBkusZNzl
 ECCfrVeBOzlCKKptPrrAmNnP57Oqvzd1UZ95o0STbaZA05/PNi8G/Q4/74E7BI3KGgMKTB
 Q6n8lrQ272Ua2JtCq9bMoZKrciOuaP0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-H4RYsWEBNumMGTQFXo5PDw-1; Wed, 31 May 2023 09:24:14 -0400
X-MC-Unique: H4RYsWEBNumMGTQFXo5PDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E25828EA6E1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FF98420AA;
 Wed, 31 May 2023 13:24:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 6/9] tests/qtest: replace wait_command() with
 qtest_qmp_assert_success
Date: Wed, 31 May 2023 14:23:57 +0100
Message-Id: <20230531132400.1129576-7-berrange@redhat.com>
In-Reply-To: <20230531132400.1129576-1-berrange@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Most usage of wait_command() is followed by qobject_unref(), which
is just a verbose re-implementation of qtest_qmp_assert_success().

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-helpers.c |  53 +---------
 tests/qtest/migration-helpers.h |   8 --
 tests/qtest/migration-test.c    | 170 +++++++++++++-------------------
 3 files changed, 74 insertions(+), 157 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 936a27a944..884d8a2e07 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -35,54 +35,6 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
     return false;
 }
 
-#ifndef _WIN32
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
-{
-    va_list ap;
-    QDict *resp, *ret;
-
-    va_start(ap, command);
-    qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
-    va_end(ap);
-
-    resp = qtest_qmp_receive(who);
-
-    g_assert(!qdict_haskey(resp, "error"));
-    g_assert(qdict_haskey(resp, "return"));
-
-    ret = qdict_get_qdict(resp, "return");
-    qobject_ref(ret);
-    qobject_unref(resp);
-
-    return ret;
-}
-#endif
-
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-QDict *wait_command(QTestState *who, const char *command, ...)
-{
-    va_list ap;
-    QDict *resp, *ret;
-
-    va_start(ap, command);
-    resp = qtest_vqmp(who, command, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(resp, "error"));
-    g_assert(qdict_haskey(resp, "return"));
-
-    ret = qdict_get_qdict(resp, "return");
-    qobject_ref(ret);
-    qobject_unref(resp);
-
-    return ret;
-}
-
 /*
  * Send QMP command "migrate".
  * Arguments are built from @fmt... (formatted like
@@ -110,7 +62,7 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
  */
 QDict *migrate_query(QTestState *who)
 {
-    return wait_command(who, "{ 'execute': 'query-migrate' }");
+    return qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-migrate' }");
 }
 
 QDict *migrate_query_not_failed(QTestState *who)
@@ -208,7 +160,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     } while (!failed);
 
     /* Is the machine currently running? */
-    rsp_return = wait_command(from, "{ 'execute': 'query-status' }");
+    rsp_return = qtest_qmp_assert_success_ref(from,
+                                              "{ 'execute': 'query-status' }");
     g_assert(qdict_haskey(rsp_return, "running"));
     g_assert(qdict_get_bool(rsp_return, "running"));
     qobject_unref(rsp_return);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index fa69d1780a..aab0745cfe 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -18,14 +18,6 @@
 bool migrate_watch_for_stop(QTestState *who, const char *name,
                             QDict *event, void *opaque);
 
-#ifndef _WIN32
-G_GNUC_PRINTF(3, 4)
-QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...);
-#endif
-
-G_GNUC_PRINTF(2, 3)
-QDict *wait_command(QTestState *who, const char *command, ...);
-
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0af72c37c2..d8b4282abc 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -342,7 +342,8 @@ static long long migrate_get_parameter_int(QTestState *who,
     QDict *rsp;
     long long result;
 
-    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
+    rsp = qtest_qmp_assert_success_ref(
+        who, "{ 'execute': 'query-migrate-parameters' }");
     result = qdict_get_int(rsp, parameter);
     qobject_unref(rsp);
     return result;
@@ -373,7 +374,8 @@ static char *migrate_get_parameter_str(QTestState *who,
     QDict *rsp;
     char *result;
 
-    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
+    rsp = qtest_qmp_assert_success_ref(
+        who, "{ 'execute': 'query-migrate-parameters' }");
     result = g_strdup(qdict_get_str(rsp, parameter));
     qobject_unref(rsp);
     return result;
@@ -402,7 +404,8 @@ static long long migrate_get_parameter_bool(QTestState *who,
     QDict *rsp;
     int result;
 
-    rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
+    rsp = qtest_qmp_assert_success_ref(
+        who, "{ 'execute': 'query-migrate-parameters' }");
     result = qdict_get_bool(rsp, parameter);
     qobject_unref(rsp);
     return !!result;
@@ -443,41 +446,29 @@ static void migrate_ensure_converge(QTestState *who)
 
 static void migrate_pause(QTestState *who)
 {
-    QDict *rsp;
-
-    rsp = wait_command(who, "{ 'execute': 'migrate-pause' }");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
 }
 
 static void migrate_continue(QTestState *who, const char *state)
 {
-    QDict *rsp;
-
-    rsp = wait_command(who,
-                       "{ 'execute': 'migrate-continue',"
-                       "  'arguments': { 'state': %s } }",
-                       state);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-continue',"
+                             "  'arguments': { 'state': %s } }",
+                             state);
 }
 
 static void migrate_recover(QTestState *who, const char *uri)
 {
-    QDict *rsp;
-
-    rsp = wait_command(who,
-                       "{ 'execute': 'migrate-recover', "
-                       "  'id': 'recover-cmd', "
-                       "  'arguments': { 'uri': %s } }",
-                       uri);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-recover', "
+                             "  'id': 'recover-cmd', "
+                             "  'arguments': { 'uri': %s } }",
+                             uri);
 }
 
 static void migrate_cancel(QTestState *who)
 {
-    QDict *rsp;
-
-    rsp = wait_command(who, "{ 'execute': 'migrate_cancel' }");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who, "{ 'execute': 'migrate_cancel' }");
 }
 
 static void migrate_set_capability(QTestState *who, const char *capability,
@@ -493,10 +484,7 @@ static void migrate_set_capability(QTestState *who, const char *capability,
 
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
-    QDict *rsp;
-
-    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -785,7 +773,6 @@ test_migrate_tls_psk_start_common(QTestState *from,
 {
     struct TestMigrateTLSPSKData *data =
         g_new0(struct TestMigrateTLSPSKData, 1);
-    QDict *rsp;
 
     data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
     data->pskfile = g_strdup_printf("%s/%s", data->workdir,
@@ -801,24 +788,22 @@ test_migrate_tls_psk_start_common(QTestState *from,
         test_tls_psk_init_alt(data->pskfilealt);
     }
 
-    rsp = wait_command(from,
-                       "{ 'execute': 'object-add',"
-                       "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                       "                 'id': 'tlscredspsk0',"
-                       "                 'endpoint': 'client',"
-                       "                 'dir': %s,"
-                       "                 'username': 'qemu'} }",
-                       data->workdir);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'username': 'qemu'} }",
+                             data->workdir);
 
-    rsp = wait_command(to,
-                       "{ 'execute': 'object-add',"
-                       "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                       "                 'id': 'tlscredspsk0',"
-                       "                 'endpoint': 'server',"
-                       "                 'dir': %s } }",
-                       mismatch ? data->workdiralt : data->workdir);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'server',"
+                             "                 'dir': %s } }",
+                             mismatch ? data->workdiralt : data->workdir);
 
     migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
     migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
@@ -889,7 +874,6 @@ test_migrate_tls_x509_start_common(QTestState *from,
                                    TestMigrateTLSX509 *args)
 {
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
-    QDict *rsp;
 
     data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
     data->keyfile = g_strdup_printf("%s/key.pem", data->workdir);
@@ -932,40 +916,38 @@ test_migrate_tls_x509_start_common(QTestState *from,
                                args->certhostname,
                                args->certipaddr);
 
-    rsp = wait_command(from,
-                       "{ 'execute': 'object-add',"
-                       "  'arguments': { 'qom-type': 'tls-creds-x509',"
-                       "                 'id': 'tlscredsx509client0',"
-                       "                 'endpoint': 'client',"
-                       "                 'dir': %s,"
-                       "                 'sanity-check': true,"
-                       "                 'verify-peer': true} }",
-                       data->workdir);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
+                             "                 'id': 'tlscredsx509client0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'sanity-check': true,"
+                             "                 'verify-peer': true} }",
+                             data->workdir);
     migrate_set_parameter_str(from, "tls-creds", "tlscredsx509client0");
     if (args->certhostname) {
         migrate_set_parameter_str(from, "tls-hostname", args->certhostname);
     }
 
-    rsp = wait_command(to,
-                       "{ 'execute': 'object-add',"
-                       "  'arguments': { 'qom-type': 'tls-creds-x509',"
-                       "                 'id': 'tlscredsx509server0',"
-                       "                 'endpoint': 'server',"
-                       "                 'dir': %s,"
-                       "                 'sanity-check': true,"
-                       "                 'verify-peer': %i} }",
-                       data->workdir, args->verifyclient);
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
+                             "                 'id': 'tlscredsx509server0',"
+                             "                 'endpoint': 'server',"
+                             "                 'dir': %s,"
+                             "                 'sanity-check': true,"
+                             "                 'verify-peer': %i} }",
+                             data->workdir, args->verifyclient);
     migrate_set_parameter_str(to, "tls-creds", "tlscredsx509server0");
 
     if (args->authzclient) {
-        rsp = wait_command(to,
-                           "{ 'execute': 'object-add',"
-                           "  'arguments': { 'qom-type': 'authz-simple',"
-                           "                 'id': 'tlsauthz0',"
-                           "                 'identity': %s} }",
-                           "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
+        qtest_qmp_assert_success(to,
+                                 "{ 'execute': 'object-add',"
+                                 "  'arguments': { 'qom-type': 'authz-simple',"
+                                 "                 'id': 'tlsauthz0',"
+                                 "                 'identity': %s} }",
+                                 "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
         migrate_set_parameter_str(to, "tls-authz", "tlsauthz0");
     }
 
@@ -1759,7 +1741,6 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 static void *test_migrate_fd_start_hook(QTestState *from,
                                         QTestState *to)
 {
-    QDict *rsp;
     int ret;
     int pair[2];
 
@@ -1768,22 +1749,19 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     g_assert_cmpint(ret, ==, 0);
 
     /* Send the 1st socket to the target */
-    rsp = wait_command_fd(to, pair[0],
-                          "{ 'execute': 'getfd',"
-                          "  'arguments': { 'fdname': 'fd-mig' }}");
-    qobject_unref(rsp);
+    qtest_qmp_fds_assert_success(to, &(pair[0]), 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
-                           "  'arguments': { 'uri': 'fd:fd-mig' }}");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': 'fd:fd-mig' }}");
 
     /* Send the 2nd socket to the target */
-    rsp = wait_command_fd(from, pair[1],
-                          "{ 'execute': 'getfd',"
-                          "  'arguments': { 'fdname': 'fd-mig' }}");
-    qobject_unref(rsp);
+    qtest_qmp_fds_assert_success(from, &(pair[1]), 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[1]);
 
     return NULL;
@@ -1990,8 +1968,6 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
                                               QTestState *to,
                                               const char *method)
 {
-    QDict *rsp;
-
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
 
@@ -2002,9 +1978,8 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
-                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     return NULL;
 }
@@ -2235,7 +2210,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    QDict *rsp;
     g_autofree char *uri = NULL;
 
     if (test_migrate_start(&from, &to, "defer", &args)) {
@@ -2251,9 +2225,8 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
-                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -2283,9 +2256,8 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    rsp = wait_command(to2, "{ 'execute': 'migrate-incoming',"
-                            "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(to2, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     g_free(uri);
     uri = migrate_get_socket_address(to2, "socket-address");
-- 
2.40.1


