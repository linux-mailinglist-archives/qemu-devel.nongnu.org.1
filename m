Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE6728B64
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSw-0004k0-8X; Thu, 08 Jun 2023 18:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSs-0004Y6-Af
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSq-0005Hq-Fv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9B5T8CASrZdmFWPRYfWRj9lntP6nFGjSGp/jvVEMfcA=;
 b=QOCFRWdQkOpGOMHE+V2XvchrZXq6CXfRIOhHNRpiRoDNG6ZHUHQ9nmwu1S73Fiy0/hixCk
 Uv1zPc/VwCRpJHu+6Wy2ich4/J86HkCinhg2KEeB8fOmzdruy5wHeFFroSiY3kb9rNctnd
 SN9W/6+1ib2Rckp+yMuQTHNA9CQmUhQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-q-Ro9yRBP-aWltfBqdiFqA-1; Thu, 08 Jun 2023 18:50:42 -0400
X-MC-Unique: q-Ro9yRBP-aWltfBqdiFqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5350C801182;
 Thu,  8 Jun 2023 22:50:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A77CA492B00;
 Thu,  8 Jun 2023 22:50:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 29/42] migration-test: Create the migration unix socket by
 guest
Date: Fri,  9 Jun 2023 00:49:30 +0200
Message-Id: <20230608224943.3877-30-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 50 +++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c70b08e7db..a0ed8eb05a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -168,6 +168,8 @@ typedef struct {
     gchar *serial_path;
     gchar *shmem_opts;
     gchar *shmem_path;
+    gchar *unix_socket;
+    gchar *uri;
     unsigned start_address;
     unsigned end_address;
 } GuestState;
@@ -224,6 +226,11 @@ static void guest_destroy(GuestState *vm)
     g_free(vm->shmem_opts);
     unlink(vm->shmem_path);
     g_free(vm->shmem_path);
+    if (vm->unix_socket) {
+        unlink(vm->unix_socket);
+        g_free(vm->unix_socket);
+    }
+    g_free(vm->uri);
     g_free(vm);
 }
 
@@ -268,6 +275,17 @@ static void guest_extra_opts(GuestState *vm, const gchar *opts)
     vm->extra_opts = opts;
 }
 
+static void guest_listen_unix_socket(GuestState *vm)
+{
+    if (vm->unix_socket) {
+        unlink(vm->unix_socket);
+        g_free(vm->unix_socket);
+    }
+    g_free(vm->uri);
+    vm->unix_socket = g_strdup_printf("%s/migsocket", tmpfs);
+    vm->uri = g_strdup_printf("unix:%s", vm->unix_socket);
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -789,7 +807,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  to->name,
                                  to->memory_size,
                                  to->serial_path,
-                                 uri,
+                                 to->uri ? to->uri : uri,
                                  to->arch_opts ? to->arch_opts : "",
                                  to->arch_target ? to->arch_target : "",
                                  to->shmem_opts ? to->shmem_opts : "",
@@ -1202,9 +1220,8 @@ static void migrate_postcopy_prepare(GuestState *from,
                                      GuestState *to,
                                      MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    test_migrate_start(from, to, uri, &args->start);
+    guest_listen_unix_socket(to);
+    test_migrate_start(from, to, NULL, &args->start);
 
     if (args->start_hook) {
         args->postcopy_data = args->start_hook(from->qs, to->qs);
@@ -1224,7 +1241,7 @@ static void migrate_postcopy_prepare(GuestState *from,
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, uri);
+    do_migrate(from, to, to->uri);
 
     wait_for_migration_pass(from->qs);
 }
@@ -1320,8 +1337,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
 
-    g_autofree char *uri = NULL;
-
     /* Always hide errors for postcopy recover tests since they're expected */
     guest_hide_stderr(from);
     guest_hide_stderr(to);
@@ -1359,8 +1374,8 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * from the broken migration channel; tell the destination to
      * listen to the new port
      */
-    uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
-    migrate_recover(to->qs, uri);
+    guest_listen_unix_socket(to);
+    migrate_recover(to->qs, to->uri);
 
     /*
      * Try to rebuild the migration channel using the resume flag and
@@ -1369,7 +1384,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_migration_status(from->qs, "postcopy-paused",
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
-    migrate_qmp(from->qs, uri, "{'resume': true}");
+    migrate_qmp(from->qs, to->uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from->qs, "max-postcopy-bandwidth", 0);
@@ -1651,7 +1666,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, uri);
+    do_migrate(from, to, to->uri);
 
     wait_for_migration_pass(from->qs);
 
@@ -1965,9 +1980,8 @@ static void test_migrate_fd_proto(void)
 static void do_test_validate_uuid(GuestState *from, GuestState *to,
                                   MigrateStart *args, bool should_fail)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    test_migrate_start(from, to, uri, args);
+    guest_listen_unix_socket(to);
+    test_migrate_start(from, to, NULL, args);
 
     /*
      * UUID validation is at the begin of migration. So, the main process of
@@ -1980,7 +1994,7 @@ static void do_test_validate_uuid(GuestState *from, GuestState *to,
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, uri);
+    do_migrate(from, to, to->uri);
 
     if (should_fail) {
         qtest_set_expected_status(to->qs, EXIT_FAILURE);
@@ -2057,7 +2071,6 @@ static void test_validate_uuid_dst_not_set(void)
  */
 static void test_migrate_auto_converge(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateStart args = {};
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
@@ -2070,7 +2083,8 @@ static void test_migrate_auto_converge(void)
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
-    test_migrate_start(from, to, uri, &args);
+    guest_listen_unix_socket(to);
+    test_migrate_start(from, to, to->uri, &args);
 
     migrate_set_capability(from->qs, "auto-converge", true);
     migrate_set_parameter_int(from->qs, "cpu-throttle-initial", init_pct);
@@ -2089,7 +2103,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
 
-    do_migrate(from, to, uri);
+    do_migrate(from, to, to->uri);
 
     /* Wait for throttling begins */
     percentage = 0;
-- 
2.40.1


