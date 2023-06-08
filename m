Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D3728B6D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTP-0005nn-5G; Thu, 08 Jun 2023 18:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTL-0005LH-DA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTJ-0005N3-6d
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQlbzlzJdsTEByR8DWR4rIJeodH/2vrPkeinuu5si9M=;
 b=ZCJhMKjKYHp6QXc3PAYc9851U/TwoDCycOhwjHxlKIpcR0fSJNibOYCtnm4doX4tn8yMtr
 cW8766AG/VjNYFo2CLqRyvIGb0zHjR9YR7iUpNpqeukXCDwZPDAV2SV8XbjwLSuL4QVXMK
 gGk6uOEXWYBugZ5Dhwe2RQV3jvaAGmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-vqcsAxxeP6Ce4sBAksVTYw-1; Thu, 08 Jun 2023 18:51:09 -0400
X-MC-Unique: vqcsAxxeP6Ce4sBAksVTYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F184D80013A;
 Thu,  8 Jun 2023 22:51:08 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D201492B00;
 Thu,  8 Jun 2023 22:51:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 36/42] migration-test: Remove unused listen_uri
Date: Fri,  9 Jun 2023 00:49:37 +0200
Message-Id: <20230608224943.3877-37-quintela@redhat.com>
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

Only remaining use was to transfer "defer".  But we make "defer" the
default if no uri is given.  Once there Remove the uri parameter to
test_migrate_start().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8d497d0940..95b7c9ed73 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -706,9 +706,6 @@ typedef struct {
     /* Optional: fine tune start parameters */
     MigrateStart start;
 
-    /* Required: the URI for the dst QEMU to listen on */
-    const char *listen_uri;
-
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -757,7 +754,7 @@ typedef struct {
 } MigrateCommon;
 
 static void test_migrate_start(GuestState *from, GuestState *to,
-                               const char *uri, MigrateStart *args)
+                               MigrateStart *args)
 {
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
@@ -797,7 +794,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  to->name,
                                  to->memory_size,
                                  to->serial_path,
-                                 to->uri ? to->uri : uri,
+                                 to->uri ? to->uri : "defer",
                                  to->arch_opts ? to->arch_opts : "",
                                  to->arch_target ? to->arch_target : "",
                                  to->shmem_opts ? to->shmem_opts : "",
@@ -1192,7 +1189,7 @@ static void migrate_postcopy_prepare(GuestState *from,
                                      MigrateCommon *args)
 {
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, NULL, &args->start);
+    test_migrate_start(from, to, &args->start);
 
     if (args->start_hook) {
         args->postcopy_data = args->start_hook(from, to);
@@ -1424,7 +1421,7 @@ static void test_baddest(void)
     guest_hide_stderr(from);
     guest_hide_stderr(to);
     guest_set_uri(to, "tcp:127.0.0.1:0");
-    test_migrate_start(from, to, NULL, &args);
+    test_migrate_start(from, to, &args);
     /*
      * Don't change to do_migrate(). We are using a wrong uri on purpose.
      */
@@ -1438,7 +1435,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
 {
     void *data_hook = NULL;
 
-    test_migrate_start(from, to, args->listen_uri, &args->start);
+    test_migrate_start(from, to, &args->start);
 
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
@@ -1620,7 +1617,7 @@ static void test_ignore_shared(void)
     guest_use_shmem(from);
     guest_use_shmem(to);
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, NULL, &args);
+    test_migrate_start(from, to, &args);
 
     migrate_set_capability(from->qs, "x-ignore-shared", true);
     migrate_set_capability(to->qs, "x-ignore-shared", true);
@@ -1921,7 +1918,6 @@ static void test_migrate_fd_proto(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_fd_start_hook,
         .finish_hook = test_migrate_fd_finish_hook
     };
@@ -1933,7 +1929,7 @@ static void do_test_validate_uuid(GuestState *from, GuestState *to,
                                   MigrateStart *args, bool should_fail)
 {
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, NULL, args);
+    test_migrate_start(from, to, args);
 
     /*
      * UUID validation is at the begin of migration. So, the main process of
@@ -2036,7 +2032,7 @@ static void test_migrate_auto_converge(void)
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, NULL, &args);
+    test_migrate_start(from, to, &args);
 
     migrate_set_capability(from->qs, "auto-converge", true);
     migrate_set_parameter_int(from->qs, "cpu-throttle-initial", init_pct);
@@ -2138,7 +2134,6 @@ static void test_multifd_tcp_none(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
         /*
          * Multifd is more complicated than most of the features, it
@@ -2155,7 +2150,6 @@ static void test_multifd_tcp_zlib(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_zlib_start,
     };
     test_precopy_common(from, to, &args);
@@ -2167,7 +2161,6 @@ static void test_multifd_tcp_zstd(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_zstd_start,
     };
     test_precopy_common(from, to, &args);
@@ -2237,7 +2230,6 @@ static void test_multifd_tcp_tls_psk_match(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tcp_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
@@ -2249,7 +2241,6 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tcp_tls_psk_start_mismatch,
         .finish_hook = test_migrate_tls_psk_finish,
         .result = MIG_TEST_FAIL,
@@ -2265,7 +2256,6 @@ static void test_multifd_tcp_tls_x509_default_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
@@ -2277,7 +2267,6 @@ static void test_multifd_tcp_tls_x509_override_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
@@ -2302,7 +2291,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_mismatch_host,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
@@ -2317,7 +2305,6 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_allow_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
@@ -2329,7 +2316,6 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_reject_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
@@ -2362,7 +2348,7 @@ static void test_multifd_tcp_cancel(void)
     guest_hide_stderr(from);
     guest_hide_stderr(to);
 
-    test_migrate_start(from, to, "defer", &args);
+    test_migrate_start(from, to, &args);
 
     migrate_ensure_non_converge(from->qs);
 
@@ -2396,7 +2382,7 @@ static void test_multifd_tcp_cancel(void)
         .only_target = true,
     };
 
-    test_migrate_start(from, to2, "defer", &args);
+    test_migrate_start(from, to2, &args);
 
     migrate_set_parameter_int(to2->qs, "multifd-channels", 16);
 
-- 
2.40.1


