Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0367728B57
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSX-0003Z6-KR; Thu, 08 Jun 2023 18:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSV-0003Y7-O4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSS-00053M-TM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1AvEczG1dOhxyRZouPKZ9jIzFLrdPQJMtBooWfY/Lo=;
 b=Ir05AsurIcEfk6gA+gjQmAriXmp2c7rBPTKT6D5c4IMplltKGe3CJupmmrhaPJ5BGIwtF8
 kdkyzzTbFtJbXVFAM+sysMoFnID78Qm/m0E2BvJ68uoutVAxFOyrRi+XtqdfIdDsM/YtYJ
 QQmZ+eE4kuvKqiKEFoVnKZQXoHMNp4Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-G51T5_RjNPqYZdMuKq8ccQ-1; Thu, 08 Jun 2023 18:50:19 -0400
X-MC-Unique: G51T5_RjNPqYZdMuKq8ccQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96C7F385556B;
 Thu,  8 Jun 2023 22:50:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2290515541;
 Thu,  8 Jun 2023 22:50:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 17/42] migration-test: Introduce GuestState
Date: Fri,  9 Jun 2023 00:49:18 +0200
Message-Id: <20230608224943.3877-18-quintela@redhat.com>
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

It will contain all the information that we need for a guest.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 330 +++++++++++++++++++----------------
 1 file changed, 180 insertions(+), 150 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 96b495f255..5cfc7a6ebc 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -152,6 +152,26 @@ static void bootfile_delete(void)
     bootpath = NULL;
 }
 
+typedef struct {
+    QTestState *qs;
+    const gchar *name;
+} GuestState;
+
+static GuestState *guest_create(const char *name)
+{
+    GuestState *vm = g_new0(GuestState, 1);
+
+    vm->name = name;
+
+    return vm;
+}
+
+static void guest_destroy(GuestState *vm)
+{
+    qtest_quit(vm->qs);
+    g_free(vm);
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -272,7 +292,7 @@ static void wait_for_migration_pass(QTestState *who)
     } while (pass == initial_pass && !got_src_stop);
 }
 
-static void check_guests_ram(QTestState *who)
+static void check_guests_ram(GuestState *who)
 {
     /* Our ASM test will have been incrementing one byte from each page from
      * start_address to < end_address in order. This gives us a constraint
@@ -287,14 +307,14 @@ static void check_guests_ram(QTestState *who)
     bool hit_edge = false;
     int bad = 0;
 
-    qtest_memread(who, start_address, &first_byte, 1);
+    qtest_memread(who->qs, start_address, &first_byte, 1);
     last_byte = first_byte;
 
     for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
          address += TEST_MEM_PAGE_SIZE)
     {
         uint8_t b;
-        qtest_memread(who, address, &b, 1);
+        qtest_memread(who->qs, address, &b, 1);
         if (b != last_byte) {
             if (((b + 1) % 256) == last_byte && !hit_edge) {
                 /* This is OK, the guest stopped at the point of
@@ -528,14 +548,14 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     qtest_qmp_eventwait(to, "RESUME");
 }
 
-static void do_migrate(QTestState *from, QTestState *to, const gchar *uri)
+static void do_migrate(GuestState *from, GuestState *to, const gchar *uri)
 {
     if (!uri) {
         g_autofree char *tcp_uri =
-            migrate_get_socket_address(to, "socket-address");
-        migrate_qmp(from, tcp_uri, "{}");
+            migrate_get_socket_address(to->qs, "socket-address");
+        migrate_qmp(from->qs, tcp_uri, "{}");
     } else {
-        migrate_qmp(from, uri, "{}");
+        migrate_qmp(from->qs, uri, "{}");
     }
 }
 
@@ -640,7 +660,7 @@ typedef struct {
     bool postcopy_preempt;
 } MigrateCommon;
 
-static void test_migrate_start(QTestState **from, QTestState **to,
+static void test_migrate_start(GuestState *from, GuestState *to,
                                const char *uri, MigrateStart *args)
 {
     g_autofree gchar *arch_source = NULL;
@@ -712,11 +732,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-name source,debug-threads=on "
+                                 "-name %s,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 from->name,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -725,27 +746,28 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr ? ignore_stderr : "");
 
     if (!args->only_target) {
-        *from = qtest_init(cmd_source);
-        qtest_qmp_set_event_callback(*from,
+        from->qs = qtest_init(cmd_source);
+        qtest_qmp_set_event_callback(from->qs,
                                      migrate_watch_for_stop,
                                      &got_src_stop);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-name target,debug-threads=on "
+                                 "-name %s,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 to->name,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr ? ignore_stderr : "");
-    *to = qtest_init(cmd_target);
-    qtest_qmp_set_event_callback(*to,
+    to->qs = qtest_init(cmd_target);
+    qtest_qmp_set_event_callback(to->qs,
                                  migrate_watch_for_resume,
                                  &got_dst_resume);
 
@@ -758,33 +780,33 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     }
 }
 
-static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
+static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
-    qtest_quit(from);
+    guest_destroy(from);
 
     if (test_dest) {
-        qtest_memread(to, start_address, &dest_byte_a, 1);
+        qtest_memread(to->qs, start_address, &dest_byte_a, 1);
 
         /* Destination still running, wait for a byte to change */
         do {
-            qtest_memread(to, start_address, &dest_byte_b, 1);
+            qtest_memread(to->qs, start_address, &dest_byte_b, 1);
             usleep(1000 * 10);
         } while (dest_byte_a == dest_byte_b);
 
-        qtest_qmp_assert_success(to, "{ 'execute' : 'stop'}");
+        qtest_qmp_assert_success(to->qs, "{ 'execute' : 'stop'}");
 
         /* With it stopped, check nothing changes */
-        qtest_memread(to, start_address, &dest_byte_c, 1);
+        qtest_memread(to->qs, start_address, &dest_byte_c, 1);
         usleep(1000 * 200);
-        qtest_memread(to, start_address, &dest_byte_d, 1);
+        qtest_memread(to->qs, start_address, &dest_byte_d, 1);
         g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
 
         check_guests_ram(to);
     }
 
-    qtest_quit(to);
+    guest_destroy(to);
 
     cleanup("migsocket");
     cleanup("src_serial");
@@ -1157,55 +1179,51 @@ test_migrate_compress_nowait_start(QTestState *from,
     return NULL;
 }
 
-static void migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr,
+static void migrate_postcopy_prepare(GuestState *from,
+                                     GuestState *to,
                                      MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
 
-    test_migrate_start(&from, &to, uri, &args->start);
+    test_migrate_start(from, to, uri, &args->start);
 
     if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from, to);
+        args->postcopy_data = args->start_hook(from->qs, to->qs);
     }
 
-    migrate_set_capability(from, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-blocktime", true);
+    migrate_set_capability(from->qs, "postcopy-ram", true);
+    migrate_set_capability(to->qs, "postcopy-ram", true);
+    migrate_set_capability(to->qs, "postcopy-blocktime", true);
 
     if (args->postcopy_preempt) {
-        migrate_set_capability(from, "postcopy-preempt", true);
-        migrate_set_capability(to, "postcopy-preempt", true);
+        migrate_set_capability(from->qs, "postcopy-preempt", true);
+        migrate_set_capability(to->qs, "postcopy-preempt", true);
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from->qs);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     do_migrate(from, to, uri);
 
-    wait_for_migration_pass(from);
-
-    *from_ptr = from;
-    *to_ptr = to;
+    wait_for_migration_pass(from->qs);
 }
 
-static void migrate_postcopy_complete(QTestState *from, QTestState *to,
+static void migrate_postcopy_complete(GuestState *from, GuestState *to,
                                       MigrateCommon *args)
 {
-    wait_for_migration_complete(from);
+    wait_for_migration_complete(from->qs);
 
     /* Make sure we get at least one "B" on destination */
     wait_for_serial("dest_serial");
 
     if (uffd_feature_thread_id) {
-        read_blocktime(to);
+        read_blocktime(to->qs);
     }
 
     if (args->finish_hook) {
-        args->finish_hook(from, to, args->postcopy_data);
+        args->finish_hook(from->qs, to->qs, args->postcopy_data);
         args->postcopy_data = NULL;
     }
 
@@ -1214,10 +1232,11 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 
 static void test_postcopy_common(MigrateCommon *args)
 {
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
 
-    migrate_postcopy_prepare(&from, &to, args);
-    migrate_postcopy_start(from, to);
+    migrate_postcopy_prepare(from, to, args);
+    migrate_postcopy_start(from->qs, to->qs);
     migrate_postcopy_complete(from, to, args);
 }
 
@@ -1271,38 +1290,40 @@ static void test_postcopy_preempt_tls_psk(void)
 
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
+
     g_autofree char *uri = NULL;
 
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
-    migrate_postcopy_prepare(&from, &to, args);
+    migrate_postcopy_prepare(from, to, args);
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
+    migrate_set_parameter_int(from->qs, "max-postcopy-bandwidth", 4096);
 
     /* Now we start the postcopy */
-    migrate_postcopy_start(from, to);
+    migrate_postcopy_start(from->qs, to->qs);
 
     /*
      * Wait until postcopy is really started; we can only run the
      * migrate-pause command during a postcopy
      */
-    wait_for_migration_status(from, "postcopy-active", NULL);
+    wait_for_migration_status(from->qs, "postcopy-active", NULL);
 
     /*
      * Manually stop the postcopy migration. This emulates a network
      * failure with the migration socket
      */
-    migrate_pause(from);
+    migrate_pause(from->qs);
 
     /*
      * Wait for destination side to reach postcopy-paused state.  The
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused",
+    wait_for_migration_status(to->qs, "postcopy-paused",
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
 
@@ -1312,19 +1333,19 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * listen to the new port
      */
     uri = g_strdup_printf("unix:%s/migsocket-recover", tmpfs);
-    migrate_recover(to, uri);
+    migrate_recover(to->qs, uri);
 
     /*
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused",
+    wait_for_migration_status(from->qs, "postcopy-paused",
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from->qs, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
-    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
+    migrate_set_parameter_int(from->qs, "max-postcopy-bandwidth", 0);
 
     migrate_postcopy_complete(from, to, args);
 }
@@ -1386,26 +1407,29 @@ static void test_baddest(void)
     MigrateStart args = {
         .hide_stderr = true
     };
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
 
-    test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args);
+    test_migrate_start(from, to, "tcp:127.0.0.1:0", &args);
     /*
      * Don't change to do_migrate(). We are using a wrong uri on purpose.
      */
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
-    wait_for_migration_fail(from, false);
+    migrate_qmp(from->qs, "tcp:127.0.0.1:0", "{}");
+    wait_for_migration_fail(from->qs, false);
     test_migrate_end(from, to, false);
 }
 
 static void test_precopy_common(MigrateCommon *args)
 {
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
+
     void *data_hook = NULL;
 
-    test_migrate_start(&from, &to, args->listen_uri, &args->start);
+    test_migrate_start(from, to, args->listen_uri, &args->start);
 
     if (args->start_hook) {
-        data_hook = args->start_hook(from, to);
+        data_hook = args->start_hook(from->qs, to->qs);
     }
 
     /* Wait for the first serial output from the source */
@@ -1421,7 +1445,7 @@ static void test_precopy_common(MigrateCommon *args)
          * this with a ridiculosly low bandwidth that guarantees
          * non-convergance.
          */
-        migrate_ensure_non_converge(from);
+        migrate_ensure_non_converge(from->qs);
     } else {
         /*
          * Testing non-live migration, we allow it to run at
@@ -1430,11 +1454,11 @@ static void test_precopy_common(MigrateCommon *args)
          * change anything.
          */
         if (args->result == MIG_TEST_SUCCEED) {
-            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+            qtest_qmp_assert_success(from->qs, "{ 'execute' : 'stop'}");
             if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
+                qtest_qmp_eventwait(from->qs, "STOP");
             }
-            migrate_ensure_converge(from);
+            migrate_ensure_converge(from->qs);
         }
     }
 
@@ -1442,53 +1466,53 @@ static void test_precopy_common(MigrateCommon *args)
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
-        wait_for_migration_fail(from, allow_active);
+        wait_for_migration_fail(from->qs, allow_active);
 
         if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
-            qtest_set_expected_status(to, EXIT_FAILURE);
+            qtest_set_expected_status(to->qs, EXIT_FAILURE);
         }
     } else {
         if (args->live) {
             if (args->iterations) {
                 while (args->iterations--) {
-                    wait_for_migration_pass(from);
+                    wait_for_migration_pass(from->qs);
                 }
             } else {
-                wait_for_migration_pass(from);
+                wait_for_migration_pass(from->qs);
             }
 
-            migrate_ensure_converge(from);
+            migrate_ensure_converge(from->qs);
 
             /*
              * We do this first, as it has a timeout to stop us
              * hanging forever if migration didn't converge
              */
-            wait_for_migration_complete(from);
+            wait_for_migration_complete(from->qs);
 
             if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
+                qtest_qmp_eventwait(from->qs, "STOP");
             }
         } else {
-            wait_for_migration_complete(from);
+            wait_for_migration_complete(from->qs);
             /*
              * Must wait for dst to finish reading all incoming
              * data on the socket before issuing 'cont' otherwise
              * it'll be ignored
              */
-            wait_for_migration_complete(to);
+            wait_for_migration_complete(to->qs);
 
-            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            qtest_qmp_assert_success(to->qs, "{ 'execute' : 'cont'}");
         }
 
         if (!got_dst_resume) {
-            qtest_qmp_eventwait(to, "RESUME");
+            qtest_qmp_eventwait(to->qs, "RESUME");
         }
 
         wait_for_serial("dest_serial");
     }
 
     if (args->finish_hook) {
-        args->finish_hook(from, to, data_hook);
+        args->finish_hook(from->qs, to->qs, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1580,34 +1604,36 @@ static void test_precopy_unix_tls_x509_override_host(void)
 static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateStart args = {
         .use_shmem = true
     };
 
-    test_migrate_start(&from, &to, uri, &args);
+    test_migrate_start(from, to, uri, &args);
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
+    migrate_set_capability(from->qs, "x-ignore-shared", true);
+    migrate_set_capability(to->qs, "x-ignore-shared", true);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     do_migrate(from, to, uri);
 
-    wait_for_migration_pass(from);
+    wait_for_migration_pass(from->qs);
 
     if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
+        qtest_qmp_eventwait(from->qs, "STOP");
     }
 
-    qtest_qmp_eventwait(to, "RESUME");
+    qtest_qmp_eventwait(to->qs, "RESUME");
 
     wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
+    wait_for_migration_complete(from->qs);
 
     /* Check whether shared RAM has been really skipped */
-    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
+    g_assert_cmpint(
+        read_ram_property_int(from->qs, "transferred"), <, 1024 * 1024);
 
     test_migrate_end(from, to, true);
 }
@@ -1882,17 +1908,18 @@ static void test_migrate_fd_proto(void)
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
 
-    test_migrate_start(&from, &to, uri, args);
+    test_migrate_start(from, to, uri, args);
 
     /*
      * UUID validation is at the begin of migration. So, the main process of
      * migration is not interesting for us here. Thus, set huge downtime for
      * very fast migration.
      */
-    migrate_set_parameter_int(from, "downtime-limit", 1000000);
-    migrate_set_capability(from, "validate-uuid", true);
+    migrate_set_parameter_int(from->qs, "downtime-limit", 1000000);
+    migrate_set_capability(from->qs, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -1900,10 +1927,10 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     do_migrate(from, to, uri);
 
     if (should_fail) {
-        qtest_set_expected_status(to, EXIT_FAILURE);
-        wait_for_migration_fail(from, true);
+        qtest_set_expected_status(to->qs, EXIT_FAILURE);
+        wait_for_migration_fail(from->qs, true);
     } else {
-        wait_for_migration_complete(from);
+        wait_for_migration_complete(from->qs);
     }
 
     test_migrate_end(from, to, false);
@@ -1969,7 +1996,8 @@ static void test_migrate_auto_converge(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateStart args = {};
-    QTestState *from, *to;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     int64_t percentage;
 
     /*
@@ -1979,21 +2007,21 @@ static void test_migrate_auto_converge(void)
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
-    test_migrate_start(&from, &to, uri, &args);
+    test_migrate_start(from, to, uri, &args);
 
-    migrate_set_capability(from, "auto-converge", true);
-    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
-    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
-    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+    migrate_set_capability(from->qs, "auto-converge", true);
+    migrate_set_parameter_int(from->qs, "cpu-throttle-initial", init_pct);
+    migrate_set_parameter_int(from->qs, "cpu-throttle-increment", inc_pct);
+    migrate_set_parameter_int(from->qs, "max-cpu-throttle", max_pct);
 
     /*
      * Set the initial parameters so that the migration could not converge
      * without throttling.
      */
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from->qs);
 
     /* To check remaining size after precopy */
-    migrate_set_capability(from, "pause-before-switchover", true);
+    migrate_set_capability(from->qs, "pause-before-switchover", true);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -2003,7 +2031,8 @@ static void test_migrate_auto_converge(void)
     /* Wait for throttling begins */
     percentage = 0;
     do {
-        percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+        percentage = read_migrate_property_int(from->qs,
+                                               "cpu-throttle-percentage");
         if (percentage != 0) {
             break;
         }
@@ -2013,23 +2042,23 @@ static void test_migrate_auto_converge(void)
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
     /* Now, when we tested that throttling works, let it converge */
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from->qs);
 
     /*
      * Wait for pre-switchover status to check last throttle percentage
      * and remaining. These values will be zeroed later
      */
-    wait_for_migration_status(from, "pre-switchover", NULL);
+    wait_for_migration_status(from->qs, "pre-switchover", NULL);
 
     /* The final percentage of throttling shouldn't be greater than max_pct */
-    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+    percentage = read_migrate_property_int(from->qs, "cpu-throttle-percentage");
     g_assert_cmpint(percentage, <=, max_pct);
-    migrate_continue(from, "pre-switchover");
+    migrate_continue(from->qs, "pre-switchover");
 
-    qtest_qmp_eventwait(to, "RESUME");
+    qtest_qmp_eventwait(to->qs, "RESUME");
 
     wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
+    wait_for_migration_complete(from->qs);
 
     test_migrate_end(from, to, true);
 }
@@ -2286,20 +2315,22 @@ static void test_multifd_tcp_cancel(void)
     MigrateStart args = {
         .hide_stderr = true,
     };
-    QTestState *from, *to, *to2;
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
+    GuestState *to2 = guest_create("target2");
 
-    test_migrate_start(&from, &to, "defer", &args);
+    test_migrate_start(from, to, "defer", &args);
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from->qs);
 
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
+    migrate_set_parameter_int(from->qs, "multifd-channels", 16);
+    migrate_set_parameter_int(to->qs, "multifd-channels", 16);
 
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
+    migrate_set_capability(from->qs, "multifd", true);
+    migrate_set_capability(to->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     /* Wait for the first serial output from the source */
@@ -2307,43 +2338,43 @@ static void test_multifd_tcp_cancel(void)
 
     do_migrate(from, to, "127.0.0.1:0");
 
-    wait_for_migration_pass(from);
+    wait_for_migration_pass(from->qs);
 
-    migrate_cancel(from);
+    migrate_cancel(from->qs);
 
     /* Make sure QEMU process "to" exited */
-    qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
+    qtest_set_expected_status(to->qs, EXIT_FAILURE);
+    qtest_wait_qemu(to->qs);
 
     args = (MigrateStart){
         .only_target = true,
     };
 
-    test_migrate_start(&from, &to2, "defer", &args);
+    test_migrate_start(from, to2, "defer", &args);
 
-    migrate_set_parameter_int(to2, "multifd-channels", 16);
+    migrate_set_parameter_int(to2->qs, "multifd-channels", 16);
 
-    migrate_set_capability(to2, "multifd", true);
+    migrate_set_capability(to2->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to2, "{ 'execute': 'migrate-incoming',"
+    qtest_qmp_assert_success(to2->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
-    wait_for_migration_status(from, "cancelled", NULL);
+    wait_for_migration_status(from->qs, "cancelled", NULL);
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from->qs);
 
     do_migrate(from, to2, "127.0.0.1:0");
 
-    wait_for_migration_pass(from);
+    wait_for_migration_pass(from->qs);
 
     if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
+        qtest_qmp_eventwait(from->qs, "STOP");
     }
-    qtest_qmp_eventwait(to2, "RESUME");
+    qtest_qmp_eventwait(to2->qs, "RESUME");
 
     wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
+    wait_for_migration_complete(from->qs);
     test_migrate_end(from, to2, true);
 }
 
@@ -2477,9 +2508,9 @@ static int64_t get_limit_rate(QTestState *who)
     return dirtyrate;
 }
 
-static QTestState *dirtylimit_start_vm(void)
+static GuestState *dirtylimit_start_vm(void)
 {
-    QTestState *vm = NULL;
+    GuestState *vm = guest_create("dirtylimit-test");
     g_autofree gchar *
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
@@ -2488,19 +2519,18 @@ static QTestState *dirtylimit_start_vm(void)
                           "-drive file=%s,format=raw ",
                           tmpfs, bootpath);
 
-    vm = qtest_init(cmd);
+    vm->qs = qtest_init(cmd);
     return vm;
 }
 
-static void dirtylimit_stop_vm(QTestState *vm)
+static void dirtylimit_stop_vm(GuestState *vm)
 {
-    qtest_quit(vm);
+    guest_destroy(vm);
     cleanup("vm_serial");
 }
 
 static void test_vcpu_dirty_limit(void)
 {
-    QTestState *vm;
     int64_t origin_rate;
     int64_t quota_rate;
     int64_t rate ;
@@ -2508,19 +2538,19 @@ static void test_vcpu_dirty_limit(void)
     int hit = 0;
 
     /* Start vm for vcpu dirtylimit test */
-    vm = dirtylimit_start_vm();
+    GuestState *vm = dirtylimit_start_vm();
 
     /* Wait for the first serial output from the vm*/
     wait_for_serial("vm_serial");
 
     /* Do dirtyrate measurement with calc time equals 1s */
-    calc_dirty_rate(vm, 1);
+    calc_dirty_rate(vm->qs, 1);
 
     /* Sleep calc time and wait for calc dirtyrate complete */
-    wait_for_calc_dirtyrate_complete(vm, 1);
+    wait_for_calc_dirtyrate_complete(vm->qs, 1);
 
     /* Query original dirty page rate */
-    origin_rate = get_dirty_rate(vm);
+    origin_rate = get_dirty_rate(vm->qs);
 
     /* VM booted from bootsect should dirty memory steadily */
     assert(origin_rate != 0);
@@ -2529,13 +2559,13 @@ static void test_vcpu_dirty_limit(void)
     quota_rate = origin_rate / 2;
 
     /* Set dirtylimit */
-    dirtylimit_set_all(vm, quota_rate);
+    dirtylimit_set_all(vm->qs, quota_rate);
 
     /*
      * Check if set-vcpu-dirty-limit and query-vcpu-dirty-limit
      * works literally
      */
-    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm));
+    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm->qs));
 
     /* Sleep a bit to check if it take effect */
     usleep(2000000);
@@ -2546,9 +2576,9 @@ static void test_vcpu_dirty_limit(void)
      * doesn't take effect, fail test.
      */
     while (--max_try_count) {
-        calc_dirty_rate(vm, 1);
-        wait_for_calc_dirtyrate_complete(vm, 1);
-        rate = get_dirty_rate(vm);
+        calc_dirty_rate(vm->qs, 1);
+        wait_for_calc_dirtyrate_complete(vm->qs, 1);
+        rate = get_dirty_rate(vm->qs);
 
         /*
          * Assume hitting if current rate is less
@@ -2566,11 +2596,11 @@ static void test_vcpu_dirty_limit(void)
     max_try_count = 20;
 
     /* Check if dirtylimit cancellation take effect */
-    cancel_vcpu_dirty_limit(vm);
+    cancel_vcpu_dirty_limit(vm->qs);
     while (--max_try_count) {
-        calc_dirty_rate(vm, 1);
-        wait_for_calc_dirtyrate_complete(vm, 1);
-        rate = get_dirty_rate(vm);
+        calc_dirty_rate(vm->qs, 1);
+        wait_for_calc_dirtyrate_complete(vm->qs, 1);
+        rate = get_dirty_rate(vm->qs);
 
         /*
          * Assume dirtylimit be canceled if current rate is
-- 
2.40.1


