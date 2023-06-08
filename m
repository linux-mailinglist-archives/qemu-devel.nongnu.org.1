Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1323728B61
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSw-0004jw-8L; Thu, 08 Jun 2023 18:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSs-0004Zp-Ra
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSq-0005Hs-ME
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqlkLQmG60AE7FrdA+ymuLG4WbW2mGDFDGR5H0KViKE=;
 b=ZvKdsKpGbjp6xC6K75JD4Pzf4kJ9DtSY9tDP7sN2eTRPSRGb9Y1jnJVkCv8WRhUror2pe6
 7lkjtFH7odicSqfVT5/JoOFj+p/N1nYAkBm9O4lxgvVZvoI7c3I6heQM0IchHsXxf2/M7w
 mkMFV+WnkO+wMDZPZIWVPt4annlo+nM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-hzM9HUqdNNC6sHjwexdOSQ-1; Thu, 08 Jun 2023 18:50:40 -0400
X-MC-Unique: hzM9HUqdNNC6sHjwexdOSQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F54C3855571;
 Thu,  8 Jun 2023 22:50:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B10FE492B00;
 Thu,  8 Jun 2023 22:50:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 28/42] migration-test: Create guest_hide_stderr()
Date: Fri,  9 Jun 2023 00:49:29 +0200
Message-Id: <20230608224943.3877-29-quintela@redhat.com>
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

So we can handle in a single place all the error output handling.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 115 ++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b9b11ebb0f..c70b08e7db 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -157,6 +157,7 @@ typedef struct {
     gchar *arch_source;
     gchar *arch_target;
     const gchar *extra_opts;
+    const gchar *hide_stderr;
     gchar *kvm_opts;
     const gchar *memory_size;
     /*
@@ -244,6 +245,23 @@ static void guest_use_shmem(GuestState *vm)
         vm->memory_size, vm->shmem_path);
 }
 
+static void guest_hide_stderr(GuestState *vm)
+{
+    g_assert(vm->hide_stderr == NULL);
+
+     if (!getenv("QTEST_LOG")) {
+#ifndef _WIN32
+        vm->hide_stderr = "2>/dev/null";
+#else
+        /*
+         * On Windows the QEMU executable is created via CreateProcess() and
+         * IO redirection does not work, so don't bother adding IO redirection
+         * to the command line.
+         */
+#endif
+    }
+}
+
 static void guest_extra_opts(GuestState *vm, const gchar *opts)
 {
     g_assert(vm->extra_opts == NULL);
@@ -640,11 +658,6 @@ static void do_migrate(GuestState *from, GuestState *to, const gchar *uri)
 }
 
 typedef struct {
-    /*
-     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
-     * unconditionally, because it means the user would like to be verbose.
-     */
-    bool hide_stderr;
     /* only launch the target process */
     bool only_target;
 } MigrateStart;
@@ -740,23 +753,10 @@ static void test_migrate_start(GuestState *from, GuestState *to,
 {
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
-    const gchar *ignore_stderr = NULL;
 
     got_src_stop = false;
     got_dst_resume = false;
 
-    if (!getenv("QTEST_LOG") && args->hide_stderr) {
-#ifndef _WIN32
-        ignore_stderr = "2>/dev/null";
-#else
-        /*
-         * On Windows the QEMU executable is created via CreateProcess() and
-         * IO redirection does not work, so don't bother adding IO redirection
-         * to the command line.
-         */
-#endif
-    }
-
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
@@ -770,7 +770,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  from->arch_source ? from->arch_source : "",
                                  from->shmem_opts ? from->shmem_opts : "",
                                  from->extra_opts ? from->extra_opts : "",
-                                 ignore_stderr ? ignore_stderr : "");
+                                 from->hide_stderr ? from->hide_stderr : "");
 
     if (!args->only_target) {
         from->qs = qtest_init(cmd_source);
@@ -794,7 +794,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  to->arch_target ? to->arch_target : "",
                                  to->shmem_opts ? to->shmem_opts : "",
                                  to->extra_opts ? to->extra_opts : "",
-                                 ignore_stderr ? ignore_stderr : "");
+                                 to->hide_stderr ? to->hide_stderr : "");
     to->qs = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(to->qs,
                                  migrate_watch_for_resume,
@@ -1323,8 +1323,8 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     g_autofree char *uri = NULL;
 
     /* Always hide errors for postcopy recover tests since they're expected */
-    args->start.hide_stderr = true;
-
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     migrate_postcopy_prepare(from, to, args);
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
@@ -1431,12 +1431,12 @@ static void test_postcopy_preempt_all(void)
 
 static void test_baddest(void)
 {
-    MigrateStart args = {
-        .hide_stderr = true
-    };
+    MigrateStart args = { };
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_migrate_start(from, to, "tcp:127.0.0.1:0", &args);
     /*
      * Don't change to do_migrate(). We are using a wrong uri on purpose.
@@ -1605,9 +1605,6 @@ static void test_precopy_unix_tls_x509_default_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .connect_uri = uri,
         .listen_uri = uri,
         .start_hook = test_migrate_tls_x509_start_default_host,
@@ -1615,6 +1612,8 @@ static void test_precopy_unix_tls_x509_default_host(void)
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -1780,15 +1779,14 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_psk_start_mismatch,
         .finish_hook = test_migrate_tls_psk_finish,
         .result = MIG_TEST_FAIL,
     };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -1824,15 +1822,14 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_mismatch_host,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -1854,15 +1851,14 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_hostile_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -1884,15 +1880,14 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_reject_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
@@ -2012,10 +2007,10 @@ static void test_validate_uuid_error(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
+    MigrateStart args = { };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
     guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
     do_test_validate_uuid(from, to, &args, true);
@@ -2025,10 +2020,10 @@ static void test_validate_uuid_src_not_set(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
+    MigrateStart args = { };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
     do_test_validate_uuid(from, to, &args, false);
 }
@@ -2037,10 +2032,10 @@ static void test_validate_uuid_dst_not_set(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
+    MigrateStart args = { };
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
     do_test_validate_uuid(from, to, &args, false);
 }
@@ -2292,14 +2287,13 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tcp_tls_psk_start_mismatch,
         .finish_hook = test_migrate_tls_psk_finish,
         .result = MIG_TEST_FAIL,
     };
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -2346,14 +2340,13 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_mismatch_host,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -2374,14 +2367,13 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_reject_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
     test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
@@ -2400,13 +2392,14 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  */
 static void test_multifd_tcp_cancel(void)
 {
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
+    MigrateStart args = { };
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     GuestState *to2 = guest_create("target2");
 
+    guest_hide_stderr(from);
+    guest_hide_stderr(to);
+
     test_migrate_start(from, to, "defer", &args);
 
     migrate_ensure_non_converge(from->qs);
-- 
2.40.1


