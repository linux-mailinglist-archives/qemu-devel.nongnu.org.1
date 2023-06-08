Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FE728B6C
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTN-0005aa-T8; Thu, 08 Jun 2023 18:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTH-0005Hg-D9
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTD-0005MA-KD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSGWendDyCd+WV+hmYwME6vB7l+YVlp30HEoATLBdUs=;
 b=GsWeEpFuLtlYbm27eSv5YR8Prcpy36upA3nWJgsump8GBUj1lRt3hr0NJzvlNCWDIFBD1R
 s7rWOd/zmAwJU7TtRf99jean63bva/eOKxJ9gz/CyCq+WUwuPk5Y64QGrzIJUBUXoeaDt6
 Yz9ohguUg2EZehcCtM538+6wmEYMr20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-Ey653PUbPGCRMRKmjIE8xg-1; Thu, 08 Jun 2023 18:51:05 -0400
X-MC-Unique: Ey653PUbPGCRMRKmjIE8xg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DAE1811E7F;
 Thu,  8 Jun 2023 22:51:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37F54492B00;
 Thu,  8 Jun 2023 22:50:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 34/42] migration-test: Use new schema for all tests that use
 unix sockets
Date: Fri,  9 Jun 2023 00:49:35 +0200
Message-Id: <20230608224943.3877-35-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Once there we can remove the now unused cleanup() function.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 39 ++++++++++--------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3b1b76fe6f..76a5f8d353 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -462,13 +462,6 @@ static void check_guests_ram(GuestState *who)
     g_assert(bad == 0);
 }
 
-static void cleanup(const char *filename)
-{
-    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, filename);
-
-    unlink(path);
-}
-
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -843,8 +836,6 @@ static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
     }
 
     guest_destroy(to);
-
-    cleanup("migsocket");
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1540,11 +1531,9 @@ static void test_precopy_common(GuestState *from, GuestState *to,
 
 static void test_precopy_unix_plain(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         /*
          * The simplest use case of precopy, covering smoke tests of
          * get-dirty-log dirty tracking.
@@ -1552,17 +1541,16 @@ static void test_precopy_unix_plain(void)
         .live = true,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 
 static void test_precopy_unix_dirty_ring(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         /*
          * Besides the precopy/unix basic test, cover dirty ring interface
          * rather than get-dirty-log.
@@ -1572,32 +1560,30 @@ static void test_precopy_unix_dirty_ring(void)
 
     guest_use_dirty_ring(from);
     guest_use_dirty_ring(to);
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_GNUTLS
 static void test_precopy_unix_tls_psk(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_TASN1
 static void test_precopy_unix_tls_x509_default_host(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
@@ -1605,20 +1591,20 @@ static void test_precopy_unix_tls_x509_default_host(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_tls_x509_override_host(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
@@ -1626,14 +1612,14 @@ static void test_precopy_unix_tls_x509_override_host(void)
 
 static void test_ignore_shared(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateStart args = { };
 
     guest_use_shmem(from);
     guest_use_shmem(to);
-    test_migrate_start(from, to, uri, &args);
+    guest_listen_unix_socket(to);
+    test_migrate_start(from, to, NULL, &args);
 
     migrate_set_capability(from->qs, "x-ignore-shared", true);
     migrate_set_capability(to->qs, "x-ignore-shared", true);
@@ -1674,11 +1660,9 @@ test_migrate_xbzrle_start(GuestState *from, GuestState *to)
 
 static void test_precopy_unix_xbzrle(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_xbzrle_start,
         .iterations = 2,
         /*
@@ -1688,16 +1672,15 @@ static void test_precopy_unix_xbzrle(void)
         .live = true,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_compress(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_compress_start,
         /*
          * Test that no invalid thread state is left over from
@@ -1712,16 +1695,15 @@ static void test_precopy_unix_compress(void)
         .live = true,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_compress_nowait(void)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = uri,
         .start_hook = test_migrate_compress_nowait_start,
         /*
          * Test that no invalid thread state is left over from
@@ -1732,6 +1714,7 @@ static void test_precopy_unix_compress_nowait(void)
         .live = true,
     };
 
+    guest_listen_unix_socket(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -2053,7 +2036,7 @@ static void test_migrate_auto_converge(void)
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
     guest_listen_unix_socket(to);
-    test_migrate_start(from, to, to->uri, &args);
+    test_migrate_start(from, to, NULL, &args);
 
     migrate_set_capability(from->qs, "auto-converge", true);
     migrate_set_parameter_int(from->qs, "cpu-throttle-initial", init_pct);
-- 
2.40.1


