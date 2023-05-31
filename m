Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32871818B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LoT-0006bj-RV; Wed, 31 May 2023 09:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoN-00063y-Gp
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4LoK-0004PF-NV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685539460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyQ52qc2eK0gkF/Q5szsBf2rvbOHttLLtQ+7QPHTW7A=;
 b=cWo3k6YKjJfCi/zii0lyq488KApn7XpFcn1lpYQC2Kb0G83BGujlS7tIiNFCkM2A4vMDcl
 /Emm9LT9wi1m0qQ8IuiwLRfH1h8jkJ8D9m1TQIarDHeLiWkYucc0gi9vMT65BNZSiM2Gyp
 9ZxU4/5FKKluenTkzRiJ5Mf/zava/50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-0QiEVM9DNkiRvkFYwoXVZA-1; Wed, 31 May 2023 09:24:18 -0400
X-MC-Unique: 0QiEVM9DNkiRvkFYwoXVZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B418101A531
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:18 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60EB6170ED;
 Wed, 31 May 2023 13:24:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 8/9] tests/qtest: make more migration pre-copy scenarios
 run non-live
Date: Wed, 31 May 2023 14:23:59 +0100
Message-Id: <20230531132400.1129576-9-berrange@redhat.com>
In-Reply-To: <20230531132400.1129576-1-berrange@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

There are 27 pre-copy live migration scenarios being tested. In all of
these we force non-convergance and run for one iteration, then let it
converge and wait for completion during the second (or following)
iterations. At 3 mbps bandwidth limit the first iteration takes a very
long time (~30 seconds).

While it is important to test the migration passes and convergance
logic, it is overkill to do this for all 27 pre-copy scenarios. The
TLS migration scenarios in particular are merely exercising different
code paths during connection establishment.

To optimize time taken, switch most of the test scenarios to run
non-live (ie guest CPUs paused) with no bandwidth limits. This gives
a massive speed up for most of the test scenarios.

For test coverage the following scenarios are unchanged

 * Precopy with UNIX sockets
 * Precopy with UNIX sockets and dirty ring tracking
 * Precopy with XBZRLE
 * Precopy with UNIX compress
 * Precopy with UNIX compress (nowait)
 * Precopy with multifd

On a test machine this reduces execution time from 13 minutes to
8 minutes.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-test.c | 81 +++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index aee25e1c4f..e033d9f0c1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -577,9 +577,12 @@ typedef struct {
         MIG_TEST_FAIL_DEST_QUIT_ERR,
     } result;
 
-    /* Optional: set number of migration passes to wait for */
+    /* Optional: set number of migration passes to wait for, if live==true */
     unsigned int iterations;
 
+    /* Optional: whether the guest CPUs should be running during migration */
+    bool live;
+
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
@@ -1385,8 +1388,6 @@ static void test_precopy_common(MigrateCommon *args)
         return;
     }
 
-    migrate_ensure_non_converge(from);
-
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
     }
@@ -1396,6 +1397,31 @@ static void test_precopy_common(MigrateCommon *args)
         wait_for_serial("src_serial");
     }
 
+    if (args->live) {
+        /*
+         * Testing live migration, we want to ensure that some
+         * memory is re-dirtied after being transferred, so that
+         * we exercise logic for dirty page handling. We achieve
+         * this with a ridiculosly low bandwidth that guarantees
+         * non-convergance.
+         */
+        migrate_ensure_non_converge(from);
+    } else {
+        /*
+         * Testing non-live migration, we allow it to run at
+         * full speed to ensure short test case duration.
+         * For tests expected to fail, we don't need to
+         * change anything.
+         */
+        if (args->result == MIG_TEST_SUCCEED) {
+            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+            if (!got_stop) {
+                qtest_qmp_eventwait(from, "STOP");
+            }
+            migrate_ensure_converge(from);
+        }
+    }
+
     if (!args->connect_uri) {
         g_autofree char *local_connect_uri =
             migrate_get_socket_address(to, "socket-address");
@@ -1413,25 +1439,41 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_set_expected_status(to, EXIT_FAILURE);
         }
     } else {
-        if (args->iterations) {
-            while (args->iterations--) {
+        if (args->live) {
+            if (args->iterations) {
+                while (args->iterations--) {
+                    wait_for_migration_pass(from);
+                }
+            } else {
                 wait_for_migration_pass(from);
             }
-        } else {
-            wait_for_migration_pass(from);
-        }
 
-        migrate_ensure_converge(from);
+            migrate_ensure_converge(from);
 
-        /* We do this first, as it has a timeout to stop us
-         * hanging forever if migration didn't converge */
-        wait_for_migration_complete(from);
+            /*
+             * We do this first, as it has a timeout to stop us
+             * hanging forever if migration didn't converge
+             */
+            wait_for_migration_complete(from);
 
-        if (!got_stop) {
-            qtest_qmp_eventwait(from, "STOP");
+            if (!got_stop) {
+                qtest_qmp_eventwait(from, "STOP");
+            }
+        } else {
+            wait_for_migration_complete(from);
+            /*
+             * Must wait for dst to finish reading all incoming
+             * data on the socket before issuing 'cont' otherwise
+             * it'll be ignored
+             */
+            wait_for_migration_complete(to);
+
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
-        qtest_qmp_eventwait(to, "RESUME");
+        if (!got_resume) {
+            qtest_qmp_eventwait(to, "RESUME");
+        }
 
         wait_for_serial("dest_serial");
     }
@@ -1449,6 +1491,8 @@ static void test_precopy_unix_plain(void)
     MigrateCommon args = {
         .listen_uri = uri,
         .connect_uri = uri,
+
+        .live = true,
     };
 
     test_precopy_common(&args);
@@ -1464,6 +1508,8 @@ static void test_precopy_unix_dirty_ring(void)
         },
         .listen_uri = uri,
         .connect_uri = uri,
+
+        .live = true,
     };
 
     test_precopy_common(&args);
@@ -1575,6 +1621,7 @@ static void test_precopy_unix_xbzrle(void)
         .start_hook = test_migrate_xbzrle_start,
 
         .iterations = 2,
+        .live = true,
     };
 
     test_precopy_common(&args);
@@ -1592,6 +1639,7 @@ static void test_precopy_unix_compress(void)
          * the previous iteration.
          */
         .iterations = 2,
+        .live = true,
     };
 
     test_precopy_common(&args);
@@ -1609,6 +1657,7 @@ static void test_precopy_unix_compress_nowait(void)
          * the previous iteration.
          */
         .iterations = 2,
+        .live = true,
     };
 
     test_precopy_common(&args);
@@ -2017,6 +2066,8 @@ static void test_multifd_tcp_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
+
+        .live = true,
     };
     test_precopy_common(&args);
 }
-- 
2.40.1


