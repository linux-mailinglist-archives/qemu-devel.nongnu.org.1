Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C9728B4F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTS-0006CT-Eu; Thu, 08 Jun 2023 18:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTP-0005ur-Fx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTN-0005PK-8e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjCaYmA+5Dzqw8dhZRmkI4HmuIl1PjkQQdmd4vUZDhE=;
 b=VxeWeEkQSlVzjM04CZYLiXVJY239PshX9huc/lmDq8gY9SWDzQSqfy/qWkupthcQ+CyZEz
 qO6zT/1LiS9bNj1PWNQCj27p3FQtx65LD+mbRNU2FqMK/UUpH5Se5zY3Ejyw8C3zQmACXw
 5G0vnqQuHVVe1dfJbzLSzrB+LPpwW8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-R-qqbPaKNpq1sfu9sq4d_g-1; Thu, 08 Jun 2023 18:51:13 -0400
X-MC-Unique: R-qqbPaKNpq1sfu9sq4d_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDF7D85A5B5;
 Thu,  8 Jun 2023 22:51:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B67448205E;
 Thu,  8 Jun 2023 22:51:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 38/42] migration-test: Create guest_realize()
Date: Fri,  9 Jun 2023 00:49:39 +0200
Message-Id: <20230608224943.3877-39-quintela@redhat.com>
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

So we can get rid of the duplication in test_migrate_start().
- unfold test_migrate_start() because it is just two calls to
  guest_realize().
- make dirty_limit test use guest_realize()
- get rid of MigrateStart as now it is empty.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 147 +++++++++++++----------------------
 1 file changed, 54 insertions(+), 93 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a96eb3eec7..29147b2be3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -233,6 +233,39 @@ static void guest_destroy(GuestState *vm)
     g_free(vm);
 }
 
+static void guest_realize(GuestState *who)
+{
+    bool target = false;
+    if (strncmp(who->name, "target", strlen("target")) == 0) {
+        target = true;
+    }
+    gchar *
+    cmd = g_strdup_printf("-accel kvm%s -accel tcg "
+                          "-name %s,debug-threads=on "
+                          "-m %s "
+                          "-serial file:%s "
+                          "%s %s "
+                          "%s %s %s %s %s",
+                          who->kvm_opts ? who->kvm_opts : "",
+                          who->name,
+                          who->memory_size,
+                          who->serial_path,
+                          target ? "-incoming" : "",
+                          target ? who->uri ? who->uri : "defer"
+                                 : "",
+                          who->arch_opts ? who->arch_opts : "",
+                          target ? who->arch_target ? who->arch_target : ""
+                                 : who->arch_source ? who->arch_source : "",
+                          who->shmem_opts ? who->shmem_opts : "",
+                          who->extra_opts ? who->extra_opts : "",
+                          who->hide_stderr ? who->hide_stderr : "");
+    who->qs = qtest_init(cmd);
+    qtest_qmp_set_event_callback(who->qs,
+                                 target ? migrate_watch_for_resume
+                                        : migrate_watch_for_stop,
+                                 &who->got_event);
+}
+
 static void guest_use_dirty_ring(GuestState *vm)
 {
     g_assert(vm->kvm_opts == NULL);
@@ -674,11 +707,6 @@ static void do_migrate(GuestState *from, GuestState *to)
     }
 }
 
-typedef struct {
-    /* only launch the target process */
-    bool only_target;
-} MigrateStart;
-
 /*
  * A hook that runs after the src and dst QEMUs have been
  * created, but before the migration is started. This can
@@ -702,9 +730,6 @@ typedef void (*TestMigrateFinishHook)(GuestState *from, GuestState *to,
                                       void *opaque);
 
 typedef struct {
-    /* Optional: fine tune start parameters */
-    MigrateStart start;
-
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -752,56 +777,6 @@ typedef struct {
     bool postcopy_preempt;
 } MigrateCommon;
 
-static void test_migrate_start(GuestState *from, GuestState *to,
-                               MigrateStart *args)
-{
-    g_autofree gchar *cmd_source = NULL;
-    g_autofree gchar *cmd_target = NULL;
-
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-name %s,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s "
-                                 "%s %s %s %s %s",
-                                 from->kvm_opts ? from->kvm_opts : "",
-                                 from->name,
-                                 from->memory_size,
-                                 from->serial_path,
-                                 from->arch_opts ? from->arch_opts : "",
-                                 from->arch_source ? from->arch_source : "",
-                                 from->shmem_opts ? from->shmem_opts : "",
-                                 from->extra_opts ? from->extra_opts : "",
-                                 from->hide_stderr ? from->hide_stderr : "");
-
-    if (!args->only_target) {
-        from->qs = qtest_init(cmd_source);
-        qtest_qmp_set_event_callback(from->qs,
-                                     migrate_watch_for_stop,
-                                     &from->got_event);
-    }
-
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-name %s,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s "
-                                 "-incoming %s "
-                                 "%s %s %s %s %s",
-                                 to->kvm_opts ? to->kvm_opts : "",
-                                 to->name,
-                                 to->memory_size,
-                                 to->serial_path,
-                                 to->uri ? to->uri : "defer",
-                                 to->arch_opts ? to->arch_opts : "",
-                                 to->arch_target ? to->arch_target : "",
-                                 to->shmem_opts ? to->shmem_opts : "",
-                                 to->extra_opts ? to->extra_opts : "",
-                                 to->hide_stderr ? to->hide_stderr : "");
-    to->qs = qtest_init(cmd_target);
-    qtest_qmp_set_event_callback(to->qs,
-                                 migrate_watch_for_resume,
-                                 &to->got_event);
-}
-
 static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
@@ -1185,7 +1160,8 @@ static void migrate_postcopy_prepare(GuestState *from,
                                      MigrateCommon *args)
 {
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, &args->start);
+    guest_realize(from);
+    guest_realize(to);
 
     if (args->start_hook) {
         args->postcopy_data = args->start_hook(from, to);
@@ -1410,14 +1386,14 @@ static void test_postcopy_preempt_all(void)
 
 static void test_baddest(void)
 {
-    MigrateStart args = { };
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
     guest_set_uri(to, "tcp:127.0.0.1:0");
-    test_migrate_start(from, to, &args);
+    guest_realize(from);
+    guest_realize(to);
     /*
      * Don't change to do_migrate(). We are using a wrong uri on purpose.
      */
@@ -1431,7 +1407,8 @@ static void test_precopy_common(GuestState *from, GuestState *to,
 {
     void *data_hook = NULL;
 
-    test_migrate_start(from, to, &args->start);
+    guest_realize(from);
+    guest_realize(to);
 
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
@@ -1608,12 +1585,12 @@ static void test_ignore_shared(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = { };
 
     guest_use_shmem(from);
     guest_use_shmem(to);
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, &args);
+    guest_realize(from);
+    guest_realize(to);
 
     migrate_set_capability(from->qs, "x-ignore-shared", true);
     migrate_set_capability(to->qs, "x-ignore-shared", true);
@@ -1922,10 +1899,11 @@ static void test_migrate_fd_proto(void)
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(GuestState *from, GuestState *to,
-                                  MigrateStart *args, bool should_fail)
+                                  bool should_fail)
 {
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, args);
+    guest_realize(from);
+    guest_realize(to);
 
     /*
      * UUID validation is at the begin of migration. So, the main process of
@@ -1954,48 +1932,44 @@ static void test_validate_uuid(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = { };
 
     guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
     guest_extra_opts(to, "-uuid 11111111-1111-1111-1111-111111111111");
-    do_test_validate_uuid(from, to, &args, false);
+    do_test_validate_uuid(from, to, false);
 }
 
 static void test_validate_uuid_error(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = { };
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
     guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
     guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
-    do_test_validate_uuid(from, to, &args, true);
+    do_test_validate_uuid(from, to, true);
 }
 
 static void test_validate_uuid_src_not_set(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = { };
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
     guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
-    do_test_validate_uuid(from, to, &args, false);
+    do_test_validate_uuid(from, to, false);
 }
 
 static void test_validate_uuid_dst_not_set(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = { };
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
     guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
-    do_test_validate_uuid(from, to, &args, false);
+    do_test_validate_uuid(from, to, false);
 }
 
 /*
@@ -2015,7 +1989,6 @@ static void test_validate_uuid_dst_not_set(void)
  */
 static void test_migrate_auto_converge(void)
 {
-    MigrateStart args = {};
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     int64_t percentage;
@@ -2028,7 +2001,8 @@ static void test_migrate_auto_converge(void)
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, &args);
+    guest_realize(from);
+    guest_realize(to);
 
     migrate_set_capability(from->qs, "auto-converge", true);
     migrate_set_parameter_int(from->qs, "cpu-throttle-initial", init_pct);
@@ -2336,7 +2310,6 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  */
 static void test_multifd_tcp_cancel(void)
 {
-    MigrateStart args = { };
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     GuestState *to2 = guest_create("target2");
@@ -2344,7 +2317,8 @@ static void test_multifd_tcp_cancel(void)
     guest_hide_stderr(from);
     guest_hide_stderr(to);
 
-    test_migrate_start(from, to, &args);
+    guest_realize(from);
+    guest_realize(to);
 
     migrate_ensure_non_converge(from->qs);
 
@@ -2374,11 +2348,7 @@ static void test_multifd_tcp_cancel(void)
 
     guest_destroy(to);
 
-    args = (MigrateStart){
-        .only_target = true,
-    };
-
-    test_migrate_start(from, to2, &args);
+    guest_realize(to2);
 
     migrate_set_parameter_int(to2->qs, "multifd-channels", 16);
 
@@ -2542,17 +2512,8 @@ static GuestState *dirtylimit_start_vm(void)
     GuestState *vm = guest_create("dirtylimit-test");
 
     guest_use_dirty_ring(vm);
+    guest_realize(vm);
 
-    g_autofree gchar *
-    cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
-                          "-name dirtylimit-test,debug-threads=on "
-                          "-m 150M -smp 1 "
-                          "-serial file:%s "
-                          "-drive file=%s,format=raw ",
-                          vm->serial_path,
-                          bootpath);
-
-    vm->qs = qtest_init(cmd);
     return vm;
 }
 
-- 
2.40.1


