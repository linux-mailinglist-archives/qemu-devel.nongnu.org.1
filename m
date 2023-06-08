Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 375BF728B43
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSW-0003Y8-7k; Thu, 08 Jun 2023 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSU-0003Xq-GI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSS-00053J-Uc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViNfUOJYaf06RUnHLCjBsa8zlI/W/H9KzPj32wnV7a4=;
 b=ixLx/5WHgE51byBVB8iilfq1Pz5VVGQVuJq6UNx+wsDttPDGHd3tq8U4wwVUmbeii2f9AY
 jwQRoC/zCj6OdYclNNr5mp9ffayFYmJKbnjS4Q05qPF0zr0mpy29YXuaiRA2fCdDOM+RXH
 8oVoNsVjYDq34lDADkaUhLO/uOG/b2U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-XIxtUB1ANDiaSO4DLEGi_A-1; Thu, 08 Jun 2023 18:50:17 -0400
X-MC-Unique: XIxtUB1ANDiaSO4DLEGi_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B14A280BC58;
 Thu,  8 Jun 2023 22:50:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17842515541;
 Thu,  8 Jun 2023 22:50:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 16/42] migration-test: Create do_migrate()
Date: Fri,  9 Jun 2023 00:49:17 +0200
Message-Id: <20230608224943.3877-17-quintela@redhat.com>
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

We called migrate_qmp() in lot of places.  And there are tricks like
changing tcp address with the right port.

Only two callers remaining:
- postcopy resume: It needs to play with the qmp.
- baddest: We want to do a unvalid URI. For that we need to do it by
  hand.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e623c43957..96b495f255 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -528,6 +528,17 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
     qtest_qmp_eventwait(to, "RESUME");
 }
 
+static void do_migrate(QTestState *from, QTestState *to, const gchar *uri)
+{
+    if (!uri) {
+        g_autofree char *tcp_uri =
+            migrate_get_socket_address(to, "socket-address");
+        migrate_qmp(from, tcp_uri, "{}");
+    } else {
+        migrate_qmp(from, uri, "{}");
+    }
+}
+
 typedef struct {
     /*
      * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
@@ -1173,7 +1184,7 @@ static void migrate_postcopy_prepare(QTestState **from_ptr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to, uri);
 
     wait_for_migration_pass(from);
 
@@ -1378,6 +1389,9 @@ static void test_baddest(void)
     QTestState *from, *to;
 
     test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args);
+    /*
+     * Don't change to do_migrate(). We are using a wrong uri on purpose.
+     */
     migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
@@ -1424,14 +1438,7 @@ static void test_precopy_common(MigrateCommon *args)
         }
     }
 
-    if (!args->connect_uri) {
-        g_autofree char *local_connect_uri =
-            migrate_get_socket_address(to, "socket-address");
-        migrate_qmp(from, local_connect_uri, "{}");
-    } else {
-        migrate_qmp(from, args->connect_uri, "{}");
-    }
-
+    do_migrate(from, to, args->connect_uri);
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1586,7 +1593,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to, uri);
 
     wait_for_migration_pass(from);
 
@@ -1890,7 +1897,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to, uri);
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -1991,7 +1998,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to, uri);
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2280,7 +2287,6 @@ static void test_multifd_tcp_cancel(void)
         .hide_stderr = true,
     };
     QTestState *from, *to, *to2;
-    g_autofree char *uri = NULL;
 
     test_migrate_start(&from, &to, "defer", &args);
 
@@ -2299,9 +2305,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    uri = migrate_get_socket_address(to, "socket-address");
-
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to, "127.0.0.1:0");
 
     wait_for_migration_pass(from);
 
@@ -2325,14 +2329,11 @@ static void test_multifd_tcp_cancel(void)
     qtest_qmp_assert_success(to2, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
-    g_free(uri);
-    uri = migrate_get_socket_address(to2, "socket-address");
-
     wait_for_migration_status(from, "cancelled", NULL);
 
     migrate_ensure_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    do_migrate(from, to2, "127.0.0.1:0");
 
     wait_for_migration_pass(from);
 
-- 
2.40.1


