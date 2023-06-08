Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10B728B4E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTM-0005Ki-0m; Thu, 08 Jun 2023 18:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OT0-0004wy-NA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSy-0005K7-IP
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmVBbNYr8UlJROOV2zWzgfWTW/NpftgV/qHnpIjmsZ4=;
 b=TsipUVwGKan0bL72opxUetH6yHKMoRBUqlX5aE9Kl2PfL6ZgdbRgmVfsJUaEldAst7TRdj
 izMeYLZ0vI9Ol0CV9zlYJXbKtgZ3m+adasTcASOsQXCySQl17pVQrbOJFurk2MlpFjYHin
 +tPQ/4X+VtNKKvSJIlo7NpLDsRPJWIQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-FnChPJ_BOn6C7Yj2K11G4A-1; Thu, 08 Jun 2023 18:50:50 -0400
X-MC-Unique: FnChPJ_BOn6C7Yj2K11G4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E38E02A59548;
 Thu,  8 Jun 2023 22:50:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 409FF492B00;
 Thu,  8 Jun 2023 22:50:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 33/42] migration-test: Remove connect_uri
Date: Fri,  9 Jun 2023 00:49:34 +0200
Message-Id: <20230608224943.3877-34-quintela@redhat.com>
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

We are using to->uri in everywhere know.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 52 +++++++++---------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f029258f67..3b1b76fe6f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -671,24 +671,14 @@ static void migrate_postcopy_start(GuestState *from, GuestState *to)
     qtest_qmp_eventwait(to->qs, "RESUME");
 }
 
-static void do_migrate(GuestState *from, GuestState *to, const gchar *uri)
+static void do_migrate(GuestState *from, GuestState *to)
 {
-    if (to->uri) {
-        if (strncmp(to->uri, "tcp:", strlen("tcp:")) == 0) {
-            g_autofree char *tcp_uri =
-                migrate_get_socket_address(to->qs, "socket-address");
-            migrate_qmp(from->qs, tcp_uri, "{}");
-        } else {
-            migrate_qmp(from->qs, to->uri, "{}");
-        }
+    if (!to->uri || strncmp(to->uri, "tcp:", strlen("tcp:")) == 0) {
+        g_autofree char *tcp_uri =
+            migrate_get_socket_address(to->qs, "socket-address");
+        migrate_qmp(from->qs, tcp_uri, "{}");
     } else {
-        if (!uri) {
-            g_autofree char *tcp_uri =
-                migrate_get_socket_address(to->qs, "socket-address");
-            migrate_qmp(from->qs, tcp_uri, "{}");
-        } else {
-            migrate_qmp(from->qs, uri, "{}");
-        }
+        migrate_qmp(from->qs, to->uri, "{}");
     }
 }
 
@@ -726,14 +716,6 @@ typedef struct {
     /* Required: the URI for the dst QEMU to listen on */
     const char *listen_uri;
 
-    /*
-     * Optional: the URI for the src QEMU to connect to
-     * If NULL, then it will query the dst QEMU for its actual
-     * listening address and use that as the connect address.
-     * This allows for dynamically picking a free TCP port.
-     */
-    const char *connect_uri;
-
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -1239,7 +1221,7 @@ static void migrate_postcopy_prepare(GuestState *from,
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, to->uri);
+    do_migrate(from, to);
 
     wait_for_migration_pass(from->qs);
 }
@@ -1500,7 +1482,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
         }
     }
 
-    do_migrate(from, to, args->connect_uri);
+    do_migrate(from, to);
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1563,7 +1545,6 @@ static void test_precopy_unix_plain(void)
     GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = uri,
-        .connect_uri = uri,
         /*
          * The simplest use case of precopy, covering smoke tests of
          * get-dirty-log dirty tracking.
@@ -1582,7 +1563,6 @@ static void test_precopy_unix_dirty_ring(void)
     GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = uri,
-        .connect_uri = uri,
         /*
          * Besides the precopy/unix basic test, cover dirty ring interface
          * rather than get-dirty-log.
@@ -1602,7 +1582,6 @@ static void test_precopy_unix_tls_psk(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
@@ -1618,7 +1597,6 @@ static void test_precopy_unix_tls_x509_default_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
@@ -1636,7 +1614,6 @@ static void test_precopy_unix_tls_x509_override_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
@@ -1664,7 +1641,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, to->uri);
+    do_migrate(from, to);
 
     wait_for_migration_pass(from->qs);
 
@@ -1701,7 +1678,6 @@ static void test_precopy_unix_xbzrle(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_xbzrle_start,
         .iterations = 2,
@@ -1721,7 +1697,6 @@ static void test_precopy_unix_compress(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_compress_start,
         /*
@@ -1746,7 +1721,6 @@ static void test_precopy_unix_compress_nowait(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_compress_nowait_start,
         /*
@@ -1989,7 +1963,7 @@ static void do_test_validate_uuid(GuestState *from, GuestState *to,
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, to->uri);
+    do_migrate(from, to);
 
     if (should_fail) {
         qtest_set_expected_status(to->qs, EXIT_FAILURE);
@@ -2098,7 +2072,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, to->uri);
+    do_migrate(from, to);
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2423,7 +2397,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, "127.0.0.1:0");
+    do_migrate(from, to);
 
     wait_for_migration_pass(from->qs);
 
@@ -2454,7 +2428,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_converge(from->qs);
 
-    do_migrate(from, to2, "127.0.0.1:0");
+    do_migrate(from, to2);
 
     wait_for_migration_pass(from->qs);
 
-- 
2.40.1


