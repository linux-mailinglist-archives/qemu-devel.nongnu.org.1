Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA079728B5B
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTD-0004ws-6i; Thu, 08 Jun 2023 18:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSw-0004oB-3g
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSt-0005Io-IX
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PwsaOYTlnXmqOenIJcSOycZ+5tMERiC1FuCEF58WIg=;
 b=OXjm0l5HW96bM6PDhTjX5o878OS1knFpyTuMmUUQqanGabgW33FM9b01bvF0qwAD7JnKeF
 WGyvvJY3xPO7gCOdWcXf/GuN4ISXZrxtzI2x13law6XTa7PEkVnBl95xXTZ5h3iTm4vCmE
 JgaybHX35NeUyKUn0r17tuq6yOJk7xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-bk17veaLPo2wGRMTT8LGxA-1; Thu, 08 Jun 2023 18:50:44 -0400
X-MC-Unique: bk17veaLPo2wGRMTT8LGxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AFEB85A5A8;
 Thu,  8 Jun 2023 22:50:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D077492B00;
 Thu,  8 Jun 2023 22:50:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 30/42] migration-test: Hooks also need GuestState
Date: Fri,  9 Jun 2023 00:49:31 +0200
Message-Id: <20230608224943.3877-31-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 198 +++++++++++++++--------------------
 1 file changed, 86 insertions(+), 112 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a0ed8eb05a..6438379dcf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -653,15 +653,16 @@ static void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-static void migrate_postcopy_start(QTestState *from, QTestState *to)
+static void migrate_postcopy_start(GuestState *from, GuestState *to)
 {
-    qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
+    qtest_qmp_assert_success(from->qs,
+                             "{ 'execute': 'migrate-start-postcopy' }");
 
     if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
+        qtest_qmp_eventwait(from->qs, "STOP");
     }
 
-    qtest_qmp_eventwait(to, "RESUME");
+    qtest_qmp_eventwait(to->qs, "RESUME");
 }
 
 static void do_migrate(GuestState *from, GuestState *to, const gchar *uri)
@@ -688,8 +689,7 @@ typedef struct {
  * Returns: NULL, or a pointer to opaque state to be
  *          later passed to the TestMigrateFinishHook
  */
-typedef void * (*TestMigrateStartHook)(QTestState *from,
-                                       QTestState *to);
+typedef void * (*TestMigrateStartHook)(GuestState *from, GuestState *to);
 
 /*
  * A hook that runs after the migration has finished,
@@ -700,8 +700,7 @@ typedef void * (*TestMigrateStartHook)(QTestState *from,
  * @opaque is a pointer to state previously returned
  * by the TestMigrateStartHook if any, or NULL.
  */
-typedef void (*TestMigrateFinishHook)(QTestState *from,
-                                      QTestState *to,
+typedef void (*TestMigrateFinishHook)(GuestState *from, GuestState *to,
                                       void *opaque);
 
 typedef struct {
@@ -859,8 +858,7 @@ struct TestMigrateTLSPSKData {
 };
 
 static void *
-test_migrate_tls_psk_start_common(QTestState *from,
-                                  QTestState *to,
+test_migrate_tls_psk_start_common(GuestState *from, GuestState *to,
                                   bool mismatch)
 {
     struct TestMigrateTLSPSKData *data =
@@ -880,7 +878,7 @@ test_migrate_tls_psk_start_common(QTestState *from,
         test_tls_psk_init_alt(data->pskfilealt);
     }
 
-    qtest_qmp_assert_success(from,
+    qtest_qmp_assert_success(from->qs,
                              "{ 'execute': 'object-add',"
                              "  'arguments': { 'qom-type': 'tls-creds-psk',"
                              "                 'id': 'tlscredspsk0',"
@@ -889,7 +887,7 @@ test_migrate_tls_psk_start_common(QTestState *from,
                              "                 'username': 'qemu'} }",
                              data->workdir);
 
-    qtest_qmp_assert_success(to,
+    qtest_qmp_assert_success(to->qs,
                              "{ 'execute': 'object-add',"
                              "  'arguments': { 'qom-type': 'tls-creds-psk',"
                              "                 'id': 'tlscredspsk0',"
@@ -897,30 +895,26 @@ test_migrate_tls_psk_start_common(QTestState *from,
                              "                 'dir': %s } }",
                              mismatch ? data->workdiralt : data->workdir);
 
-    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
-    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
+    migrate_set_parameter_str(from->qs, "tls-creds", "tlscredspsk0");
+    migrate_set_parameter_str(to->qs, "tls-creds", "tlscredspsk0");
 
     return data;
 }
 
 static void *
-test_migrate_tls_psk_start_match(QTestState *from,
-                                 QTestState *to)
+test_migrate_tls_psk_start_match(GuestState *from, GuestState *to)
 {
     return test_migrate_tls_psk_start_common(from, to, false);
 }
 
 static void *
-test_migrate_tls_psk_start_mismatch(QTestState *from,
-                                    QTestState *to)
+test_migrate_tls_psk_start_mismatch(GuestState *from, GuestState *to)
 {
     return test_migrate_tls_psk_start_common(from, to, true);
 }
 
 static void
-test_migrate_tls_psk_finish(QTestState *from,
-                            QTestState *to,
-                            void *opaque)
+test_migrate_tls_psk_finish(GuestState *from, GuestState *to, void *opaque)
 {
     struct TestMigrateTLSPSKData *data = opaque;
 
@@ -961,8 +955,7 @@ typedef struct {
 } TestMigrateTLSX509;
 
 static void *
-test_migrate_tls_x509_start_common(QTestState *from,
-                                   QTestState *to,
+test_migrate_tls_x509_start_common(GuestState *from, GuestState *to,
                                    TestMigrateTLSX509 *args)
 {
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
@@ -1008,7 +1001,7 @@ test_migrate_tls_x509_start_common(QTestState *from,
                                args->certhostname,
                                args->certipaddr);
 
-    qtest_qmp_assert_success(from,
+    qtest_qmp_assert_success(from->qs,
                              "{ 'execute': 'object-add',"
                              "  'arguments': { 'qom-type': 'tls-creds-x509',"
                              "                 'id': 'tlscredsx509client0',"
@@ -1017,12 +1010,12 @@ test_migrate_tls_x509_start_common(QTestState *from,
                              "                 'sanity-check': true,"
                              "                 'verify-peer': true} }",
                              data->workdir);
-    migrate_set_parameter_str(from, "tls-creds", "tlscredsx509client0");
+    migrate_set_parameter_str(from->qs, "tls-creds", "tlscredsx509client0");
     if (args->certhostname) {
-        migrate_set_parameter_str(from, "tls-hostname", args->certhostname);
+        migrate_set_parameter_str(from->qs, "tls-hostname", args->certhostname);
     }
 
-    qtest_qmp_assert_success(to,
+    qtest_qmp_assert_success(to->qs,
                              "{ 'execute': 'object-add',"
                              "  'arguments': { 'qom-type': 'tls-creds-x509',"
                              "                 'id': 'tlscredsx509server0',"
@@ -1031,16 +1024,16 @@ test_migrate_tls_x509_start_common(QTestState *from,
                              "                 'sanity-check': true,"
                              "                 'verify-peer': %i} }",
                              data->workdir, args->verifyclient);
-    migrate_set_parameter_str(to, "tls-creds", "tlscredsx509server0");
+    migrate_set_parameter_str(to->qs, "tls-creds", "tlscredsx509server0");
 
     if (args->authzclient) {
-        qtest_qmp_assert_success(to,
+        qtest_qmp_assert_success(to->qs,
                                  "{ 'execute': 'object-add',"
                                  "  'arguments': { 'qom-type': 'authz-simple',"
                                  "                 'id': 'tlsauthz0',"
                                  "                 'identity': %s} }",
                                  "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
-        migrate_set_parameter_str(to, "tls-authz", "tlsauthz0");
+        migrate_set_parameter_str(to->qs, "tls-authz", "tlsauthz0");
     }
 
     return data;
@@ -1051,8 +1044,7 @@ test_migrate_tls_x509_start_common(QTestState *from,
  * whatever host we were telling QEMU to connect to (if any)
  */
 static void *
-test_migrate_tls_x509_start_default_host(QTestState *from,
-                                         QTestState *to)
+test_migrate_tls_x509_start_default_host(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1068,8 +1060,7 @@ test_migrate_tls_x509_start_default_host(QTestState *from,
  * so we must give QEMU an explicit hostname to validate
  */
 static void *
-test_migrate_tls_x509_start_override_host(QTestState *from,
-                                          QTestState *to)
+test_migrate_tls_x509_start_override_host(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1085,8 +1076,7 @@ test_migrate_tls_x509_start_override_host(QTestState *from,
  * expect the client to reject the server
  */
 static void *
-test_migrate_tls_x509_start_mismatch_host(QTestState *from,
-                                          QTestState *to)
+test_migrate_tls_x509_start_mismatch_host(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1097,8 +1087,7 @@ test_migrate_tls_x509_start_mismatch_host(QTestState *from,
 }
 
 static void *
-test_migrate_tls_x509_start_friendly_client(QTestState *from,
-                                            QTestState *to)
+test_migrate_tls_x509_start_friendly_client(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1110,8 +1099,7 @@ test_migrate_tls_x509_start_friendly_client(QTestState *from,
 }
 
 static void *
-test_migrate_tls_x509_start_hostile_client(QTestState *from,
-                                           QTestState *to)
+test_migrate_tls_x509_start_hostile_client(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1128,8 +1116,7 @@ test_migrate_tls_x509_start_hostile_client(QTestState *from,
  * and no server verification
  */
 static void *
-test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
-                                              QTestState *to)
+test_migrate_tls_x509_start_allow_anon_client(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .certipaddr = "127.0.0.1",
@@ -1142,8 +1129,7 @@ test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
  * and server verification rejecting
  */
 static void *
-test_migrate_tls_x509_start_reject_anon_client(QTestState *from,
-                                               QTestState *to)
+test_migrate_tls_x509_start_reject_anon_client(GuestState *from, GuestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1153,9 +1139,7 @@ test_migrate_tls_x509_start_reject_anon_client(QTestState *from,
 }
 
 static void
-test_migrate_tls_x509_finish(QTestState *from,
-                             QTestState *to,
-                             void *opaque)
+test_migrate_tls_x509_finish(GuestState *from, GuestState *to, void *opaque)
 {
     TestMigrateTLSX509Data *data = opaque;
 
@@ -1187,31 +1171,29 @@ test_migrate_tls_x509_finish(QTestState *from,
 #endif /* CONFIG_GNUTLS */
 
 static void *
-test_migrate_compress_start(QTestState *from,
-                            QTestState *to)
+test_migrate_compress_start(GuestState *from, GuestState *to)
 {
-    migrate_set_parameter_int(from, "compress-level", 1);
-    migrate_set_parameter_int(from, "compress-threads", 4);
-    migrate_set_parameter_bool(from, "compress-wait-thread", true);
-    migrate_set_parameter_int(to, "decompress-threads", 4);
+    migrate_set_parameter_int(from->qs, "compress-level", 1);
+    migrate_set_parameter_int(from->qs, "compress-threads", 4);
+    migrate_set_parameter_bool(from->qs, "compress-wait-thread", true);
+    migrate_set_parameter_int(to->qs, "decompress-threads", 4);
 
-    migrate_set_capability(from, "compress", true);
-    migrate_set_capability(to, "compress", true);
+    migrate_set_capability(from->qs, "compress", true);
+    migrate_set_capability(to->qs, "compress", true);
 
     return NULL;
 }
 
 static void *
-test_migrate_compress_nowait_start(QTestState *from,
-                                   QTestState *to)
+test_migrate_compress_nowait_start(GuestState *from, GuestState *to)
 {
-    migrate_set_parameter_int(from, "compress-level", 9);
-    migrate_set_parameter_int(from, "compress-threads", 1);
-    migrate_set_parameter_bool(from, "compress-wait-thread", false);
-    migrate_set_parameter_int(to, "decompress-threads", 1);
+    migrate_set_parameter_int(from->qs, "compress-level", 9);
+    migrate_set_parameter_int(from->qs, "compress-threads", 1);
+    migrate_set_parameter_bool(from->qs, "compress-wait-thread", false);
+    migrate_set_parameter_int(to->qs, "decompress-threads", 1);
 
-    migrate_set_capability(from, "compress", true);
-    migrate_set_capability(to, "compress", true);
+    migrate_set_capability(from->qs, "compress", true);
+    migrate_set_capability(to->qs, "compress", true);
 
     return NULL;
 }
@@ -1224,7 +1206,7 @@ static void migrate_postcopy_prepare(GuestState *from,
     test_migrate_start(from, to, NULL, &args->start);
 
     if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from->qs, to->qs);
+        args->postcopy_data = args->start_hook(from, to);
     }
 
     migrate_set_capability(from->qs, "postcopy-ram", true);
@@ -1259,7 +1241,7 @@ static void migrate_postcopy_complete(GuestState *from, GuestState *to,
     }
 
     if (args->finish_hook) {
-        args->finish_hook(from->qs, to->qs, args->postcopy_data);
+        args->finish_hook(from, to, args->postcopy_data);
         args->postcopy_data = NULL;
     }
 
@@ -1270,7 +1252,7 @@ static void test_postcopy_common(GuestState *from, GuestState *to,
                                  MigrateCommon *args)
 {
     migrate_postcopy_prepare(from, to, args);
-    migrate_postcopy_start(from->qs, to->qs);
+    migrate_postcopy_start(from, to);
     migrate_postcopy_complete(from, to, args);
 }
 
@@ -1346,7 +1328,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     migrate_set_parameter_int(from->qs, "max-postcopy-bandwidth", 4096);
 
     /* Now we start the postcopy */
-    migrate_postcopy_start(from->qs, to->qs);
+    migrate_postcopy_start(from, to);
 
     /*
      * Wait until postcopy is really started; we can only run the
@@ -1469,7 +1451,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
     test_migrate_start(from, to, args->listen_uri, &args->start);
 
     if (args->start_hook) {
-        data_hook = args->start_hook(from->qs, to->qs);
+        data_hook = args->start_hook(from, to);
     }
 
     /* Wait for the first serial output from the source */
@@ -1552,7 +1534,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
     }
 
     if (args->finish_hook) {
-        args->finish_hook(from->qs, to->qs, data_hook);
+        args->finish_hook(from, to, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1687,13 +1669,12 @@ static void test_ignore_shared(void)
 }
 
 static void *
-test_migrate_xbzrle_start(QTestState *from,
-                          QTestState *to)
+test_migrate_xbzrle_start(GuestState *from, GuestState *to)
 {
-    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
+    migrate_set_parameter_int(from->qs, "xbzrle-cache-size", 33554432);
 
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
+    migrate_set_capability(from->qs, "xbzrle", true);
+    migrate_set_capability(to->qs, "xbzrle", true);
 
     return NULL;
 }
@@ -1909,8 +1890,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 #endif /* CONFIG_GNUTLS */
 
 #ifndef _WIN32
-static void *test_migrate_fd_start_hook(QTestState *from,
-                                        QTestState *to)
+static void *test_migrate_fd_start_hook(GuestState *from, GuestState *to)
 {
     int ret;
     int pair[2];
@@ -1920,17 +1900,17 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     g_assert_cmpint(ret, ==, 0);
 
     /* Send the 1st socket to the target */
-    qtest_qmp_fds_assert_success(to, &pair[0], 1,
+    qtest_qmp_fds_assert_success(to->qs, &pair[0], 1,
                                  "{ 'execute': 'getfd',"
                                  "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'fd:fd-mig' }}");
 
     /* Send the 2nd socket to the target */
-    qtest_qmp_fds_assert_success(from, &pair[1], 1,
+    qtest_qmp_fds_assert_success(from->qs, &pair[1], 1,
                                  "{ 'execute': 'getfd',"
                                  "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[1]);
@@ -1938,8 +1918,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     return NULL;
 }
 
-static void test_migrate_fd_finish_hook(QTestState *from,
-                                        QTestState *to,
+static void test_migrate_fd_finish_hook(GuestState *from, GuestState *to,
                                         void *opaque)
 {
     QDict *rsp;
@@ -1948,14 +1927,14 @@ static void test_migrate_fd_finish_hook(QTestState *from,
     /* Test closing fds */
     /* We assume, that QEMU removes named fd from its list,
      * so this should fail */
-    rsp = qtest_qmp(from, "{ 'execute': 'closefd',"
+    rsp = qtest_qmp(from->qs, "{ 'execute': 'closefd',"
                           "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
     g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
     qobject_unref(rsp);
 
-    rsp = qtest_qmp(to, "{ 'execute': 'closefd',"
+    rsp = qtest_qmp(to->qs, "{ 'execute': 'closefd',"
                         "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
@@ -2141,44 +2120,40 @@ static void test_migrate_auto_converge(void)
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
-                                              QTestState *to,
+test_migrate_precopy_tcp_multifd_start_common(GuestState *from, GuestState *to,
                                               const char *method)
 {
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
+    migrate_set_parameter_int(from->qs, "multifd-channels", 16);
+    migrate_set_parameter_int(to->qs, "multifd-channels", 16);
 
-    migrate_set_parameter_str(from, "multifd-compression", method);
-    migrate_set_parameter_str(to, "multifd-compression", method);
+    migrate_set_parameter_str(from->qs, "multifd-compression", method);
+    migrate_set_parameter_str(to->qs, "multifd-compression", method);
 
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
+    migrate_set_capability(from->qs, "multifd", true);
+    migrate_set_capability(to->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     return NULL;
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start(QTestState *from,
-                                       QTestState *to)
+test_migrate_precopy_tcp_multifd_start(GuestState *from, GuestState *to)
 {
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
-                                            QTestState *to)
+test_migrate_precopy_tcp_multifd_zlib_start(GuestState *from, GuestState *to)
 {
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
 }
 
 #ifdef CONFIG_ZSTD
 static void *
-test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
-                                            QTestState *to)
+test_migrate_precopy_tcp_multifd_zstd_start(GuestState *from, GuestState *to)
 {
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
 }
@@ -2227,16 +2202,15 @@ static void test_multifd_tcp_zstd(void)
 
 #ifdef CONFIG_GNUTLS
 static void *
-test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
-                                             QTestState *to)
+test_migrate_multifd_tcp_tls_psk_start_match(GuestState *from, GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_psk_start_match(from, to);
 }
 
 static void *
-test_migrate_multifd_tcp_tls_psk_start_mismatch(QTestState *from,
-                                                QTestState *to)
+test_migrate_multifd_tcp_tls_psk_start_mismatch(GuestState *from,
+                                                GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_psk_start_mismatch(from, to);
@@ -2244,40 +2218,40 @@ test_migrate_multifd_tcp_tls_psk_start_mismatch(QTestState *from,
 
 #ifdef CONFIG_TASN1
 static void *
-test_migrate_multifd_tls_x509_start_default_host(QTestState *from,
-                                                 QTestState *to)
+test_migrate_multifd_tls_x509_start_default_host(GuestState *from,
+                                                 GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_x509_start_default_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_override_host(QTestState *from,
-                                                  QTestState *to)
+test_migrate_multifd_tls_x509_start_override_host(GuestState *from,
+                                                  GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_x509_start_override_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_mismatch_host(QTestState *from,
-                                                  QTestState *to)
+test_migrate_multifd_tls_x509_start_mismatch_host(GuestState *from,
+                                                  GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_x509_start_mismatch_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_allow_anon_client(QTestState *from,
-                                                      QTestState *to)
+test_migrate_multifd_tls_x509_start_allow_anon_client(GuestState *from,
+                                                      GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_x509_start_allow_anon_client(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_reject_anon_client(QTestState *from,
-                                                       QTestState *to)
+test_migrate_multifd_tls_x509_start_reject_anon_client(GuestState *from,
+                                                       GuestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
     return test_migrate_tls_x509_start_reject_anon_client(from, to);
-- 
2.40.1


