Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12536728B73
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSc-0003cS-LY; Thu, 08 Jun 2023 18:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSa-0003bA-LD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSY-00056Q-Ez
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWqjeoEZdLsjerSt0GiQQXRXO+jnwFsGlvl9xehGb8I=;
 b=QMmMXL/TOTmDOj9bRCdvVuB+Q4LBGiVBxp88OfporPn4hb0cSU3fdHFyZwz5kqma53CfTw
 S81jDY38EcxGyvlI3E9r9mYGK4xje6RUZ7BYoT24GKElnRVNLJ4EpuPIsE///A44G+oNar
 dvP5n1uXYwHsDqvWnh1hITozTy7Yg5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-VnbJwEJ-MeWXpX4TYbiylA-1; Thu, 08 Jun 2023 18:50:22 -0400
X-MC-Unique: VnbJwEJ-MeWXpX4TYbiylA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66DF9811E85;
 Thu,  8 Jun 2023 22:50:22 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5145515541;
 Thu,  8 Jun 2023 22:50:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 19/42] migration-test: Create guest before calling
 test_precopy_common()
Date: Fri,  9 Jun 2023 00:49:20 +0200
Message-Id: <20230608224943.3877-20-quintela@redhat.com>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 122 +++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 33 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 14f4fd579b..528dc571ef 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1419,11 +1419,9 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
-static void test_precopy_common(MigrateCommon *args)
+static void test_precopy_common(GuestState *from, GuestState *to,
+                                MigrateCommon *args)
 {
-    GuestState *from = guest_create("source");
-    GuestState *to = guest_create("target");
-
     void *data_hook = NULL;
 
     test_migrate_start(from, to, args->listen_uri, &args->start);
@@ -1521,6 +1519,8 @@ static void test_precopy_common(MigrateCommon *args)
 static void test_precopy_unix_plain(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = uri,
         .connect_uri = uri,
@@ -1531,13 +1531,15 @@ static void test_precopy_unix_plain(void)
         .live = true,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 
 static void test_precopy_unix_dirty_ring(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .use_dirty_ring = true,
@@ -1551,13 +1553,15 @@ static void test_precopy_unix_dirty_ring(void)
         .live = true,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_GNUTLS
 static void test_precopy_unix_tls_psk(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
@@ -1565,13 +1569,15 @@ static void test_precopy_unix_tls_psk(void)
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_TASN1
 static void test_precopy_unix_tls_x509_default_host(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -1583,12 +1589,14 @@ static void test_precopy_unix_tls_x509_default_host(void)
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_tls_x509_override_host(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
@@ -1596,7 +1604,7 @@ static void test_precopy_unix_tls_x509_override_host(void)
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
@@ -1653,6 +1661,8 @@ test_migrate_xbzrle_start(QTestState *from,
 static void test_precopy_unix_xbzrle(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
@@ -1665,12 +1675,14 @@ static void test_precopy_unix_xbzrle(void)
         .live = true,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_compress(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
@@ -1688,12 +1700,14 @@ static void test_precopy_unix_compress(void)
         .live = true,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_unix_compress_nowait(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
@@ -1707,32 +1721,38 @@ static void test_precopy_unix_compress_nowait(void)
         .live = true,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_plain(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_GNUTLS
 static void test_precopy_tcp_tls_psk_match(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_psk_mismatch(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -1743,34 +1763,40 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
         .result = MIG_TEST_FAIL,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_TASN1
 static void test_precopy_tcp_tls_x509_default_host(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_override_host(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_mismatch_host(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -1781,22 +1807,26 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_friendly_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_friendly_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_hostile_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -1807,22 +1837,26 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
         .result = MIG_TEST_FAIL,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_allow_anon_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_allow_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -1833,7 +1867,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
         .result = MIG_TEST_FAIL,
     };
 
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
@@ -1895,13 +1929,15 @@ static void test_migrate_fd_finish_hook(QTestState *from,
 
 static void test_migrate_fd_proto(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
         .start_hook = test_migrate_fd_start_hook,
         .finish_hook = test_migrate_fd_finish_hook
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 #endif /* _WIN32 */
 
@@ -2116,6 +2152,8 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 
 static void test_multifd_tcp_none(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
@@ -2126,26 +2164,30 @@ static void test_multifd_tcp_none(void)
          */
         .live = true,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_zlib(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_zlib_start,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_ZSTD
 static void test_multifd_tcp_zstd(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_zstd_start,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 #endif
 
@@ -2210,16 +2252,20 @@ test_migrate_multifd_tls_x509_start_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tcp_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_tls_psk_mismatch(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -2229,28 +2275,32 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
         .finish_hook = test_migrate_tls_psk_finish,
         .result = MIG_TEST_FAIL,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_TASN1
 static void test_multifd_tcp_tls_x509_default_host(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_tls_x509_override_host(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_tls_x509_mismatch_host(void)
@@ -2268,6 +2318,8 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -2277,21 +2329,25 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_tls_x509_allow_anon_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_multifd_tls_x509_start_allow_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 
 static void test_multifd_tcp_tls_x509_reject_anon_client(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
@@ -2301,7 +2357,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
     };
-    test_precopy_common(&args);
+    test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
-- 
2.40.1


