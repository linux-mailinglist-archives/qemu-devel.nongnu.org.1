Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02358728B65
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTM-0005Tq-VJ; Thu, 08 Jun 2023 18:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTJ-0005Hj-2d
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTG-0005MT-1Y
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDGtoV7qXWzFl+UYDyXYjN+Gedv5Mn0oMfKvI+Lso98=;
 b=GaAfheuk4q+VIak3HCuB01/U+IBiZJOW6rNU4/ARlj/h1rvOHT06Hy+tWFZpnQlxi/Lo0+
 5o9OoC0LpZCf7Bdni/VxykJ1AdzkCTQF1x326DutqbBQD3eVDkXrHrl/OI6aOr/+iMq6wn
 eU6nt8x9DaTlip/cnTQGQYppF+s875w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-ROmBqgvRM0ygEWzLyiadTg-1; Thu, 08 Jun 2023 18:51:07 -0400
X-MC-Unique: ROmBqgvRM0ygEWzLyiadTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02D9D811E7C;
 Thu,  8 Jun 2023 22:51:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5403A492B00;
 Thu,  8 Jun 2023 22:51:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 35/42] migration-test: Set uri for tcp tests with
 guest_set_uri()
Date: Fri,  9 Jun 2023 00:49:36 +0200
Message-Id: <20230608224943.3877-36-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 76a5f8d353..8d497d0940 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1423,7 +1423,8 @@ static void test_baddest(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
-    test_migrate_start(from, to, "tcp:127.0.0.1:0", &args);
+    guest_set_uri(to, "tcp:127.0.0.1:0");
+    test_migrate_start(from, to, NULL, &args);
     /*
      * Don't change to do_migrate(). We are using a wrong uri on purpose.
      */
@@ -1722,10 +1723,9 @@ static void test_precopy_tcp_plain(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-    };
+    MigrateCommon args = { };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1735,11 +1735,11 @@ static void test_precopy_tcp_tls_psk_match(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1748,7 +1748,6 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_psk_start_mismatch,
         .finish_hook = test_migrate_tls_psk_finish,
         .result = MIG_TEST_FAIL,
@@ -1756,6 +1755,7 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1765,11 +1765,11 @@ static void test_precopy_tcp_tls_x509_default_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_default_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1778,11 +1778,11 @@ static void test_precopy_tcp_tls_x509_override_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_override_host,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1791,7 +1791,6 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_mismatch_host,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
@@ -1799,6 +1798,7 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1807,11 +1807,11 @@ static void test_precopy_tcp_tls_x509_friendly_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_friendly_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1820,7 +1820,6 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_hostile_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
@@ -1828,6 +1827,7 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1836,11 +1836,11 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_allow_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
     };
 
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 
@@ -1849,7 +1849,6 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
         .start_hook = test_migrate_tls_x509_start_reject_anon_client,
         .finish_hook = test_migrate_tls_x509_finish,
         .result = MIG_TEST_FAIL,
@@ -1857,6 +1856,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 
     guest_hide_stderr(from);
     guest_hide_stderr(to);
+    guest_set_uri(to, "tcp:127.0.0.1:0");
     test_precopy_common(from, to, &args);
 }
 #endif /* CONFIG_TASN1 */
-- 
2.40.1


