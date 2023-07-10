Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6574D53B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpon-00010D-Kl; Mon, 10 Jul 2023 08:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoY-0000uv-3u
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoQ-0003Xy-8q
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJHpeGgwpCvk2OsK7eOUdTxRweOWTimf04XqLVoev0Q=;
 b=dPiOSD94FNEhGa6Fgngg+Qsrbo7oUEa0Aw+q0U8JGfOYN9xZPMgKhdY3bYXyMwNGEvzpye
 iW8Z+amzWF0/gd50TAYnZDvat2Khik8NhdE8m2CiJqfB35YzUN6P3JXH8WnzizBOW0jlfM
 Z9sBqW14lA52eNdvOHFuFoTLgoboWq0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-geNQJ0urOTWBcPQZA7IfyQ-1; Mon, 10 Jul 2023 08:16:14 -0400
X-MC-Unique: geNQJ0urOTWBcPQZA7IfyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 123983C0ED4D;
 Mon, 10 Jul 2023 12:16:14 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05659F66BB;
 Mon, 10 Jul 2023 12:16:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 20/21] tests/qtest: massively speed up migration-test
Date: Mon, 10 Jul 2023 14:15:42 +0200
Message-Id: <20230710121543.197250-21-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The migration test cases that actually exercise live migration want to
ensure there is a minimum of two iterations of pre-copy, in order to
exercise the dirty tracking code.

Historically we've queried the migration status, looking for the
'dirty-sync-count' value to increment to track iterations. This was
not entirely reliable because often all the data would get transferred
quickly enough that the migration would finish before we wanted it
to. So we massively dropped the bandwidth and max downtime to
guarantee non-convergance. This had the unfortunate side effect
that every migration took at least 30 seconds to run (100 MB of
dirty pages / 3 MB/sec).

This optimization takes a different approach to ensuring that a
mimimum of two iterations. Rather than waiting for dirty-sync-count
to increment, directly look for an indication that the source VM
has dirtied RAM that has already been transferred.

On the source VM a magic marker is written just after the 3 MB
offset. The destination VM is now montiored to detect when the
magic marker is transferred. This gives a guarantee that the
first 3 MB of memory have been transferred. Now the source VM
memory is monitored at exactly the 3MB offset until we observe
a flip in its value. This gives us a guaranteed that the guest
workload has dirtied a byte that has already been transferred.

Since we're looking at a place that is only 3 MB from the start
of memory, with the 3 MB/sec bandwidth, this test should complete
in 1 second, instead of 30 seconds.

Once we've proved there is some dirty memory, migration can be
set back to full speed for the remainder of the 1st iteration,
and the entire of the second iteration at which point migration
should be complete.

On a test machine this further reduces the migration test time
from 8 minutes to 1 minute 40.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230601161347.1803440-11-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 143 ++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b9cc194100..efa8c729db 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -46,6 +46,20 @@ static bool uffd_feature_thread_id;
 static bool got_src_stop;
 static bool got_dst_resume;
 
+/*
+ * An initial 3 MB offset is used as that corresponds
+ * to ~1 sec of data transfer with our bandwidth setting.
+ */
+#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
+/*
+ * A further 1k is added to ensure we're not a multiple
+ * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
+ * from the migration guest workload.
+ */
+#define MAGIC_OFFSET_SHUFFLE 1024
+#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
+#define MAGIC_MARKER 0xFEED12345678CAFEULL
+
 /*
  * Dirtylimit stop working if dirty page rate error
  * value less than DIRTYLIMIT_TOLERANCE_RANGE
@@ -445,6 +459,91 @@ static void migrate_ensure_converge(QTestState *who)
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
+/*
+ * Our goal is to ensure that we run a single full migration
+ * iteration, and also dirty memory, ensuring that at least
+ * one further iteration is required.
+ *
+ * We can't directly synchronize with the start of a migration
+ * so we have to apply some tricks monitoring memory that is
+ * transferred.
+ *
+ * Initially we set the migration bandwidth to an insanely
+ * low value, with tiny max downtime too. This basically
+ * guarantees migration will never complete.
+ *
+ * This will result in a test that is unacceptably slow though,
+ * so we can't let the entire migration pass run at this speed.
+ * Our intent is to let it run just long enough that we can
+ * prove data prior to the marker has been transferred *AND*
+ * also prove this transferred data is dirty again.
+ *
+ * Before migration starts, we write a 64-bit magic marker
+ * into a fixed location in the src VM RAM.
+ *
+ * Then watch dst memory until the marker appears. This is
+ * proof that start_address -> MAGIC_OFFSET_BASE has been
+ * transferred.
+ *
+ * Finally we go back to the source and read a byte just
+ * before the marker untill we see it flip in value. This
+ * is proof that start_address -> MAGIC_OFFSET_BASE
+ * is now dirty again.
+ *
+ * IOW, we're guaranteed at least a 2nd migration pass
+ * at this point.
+ *
+ * We can now let migration run at full speed to finish
+ * the test
+ */
+static void migrate_prepare_for_dirty_mem(QTestState *from)
+{
+    /*
+     * The guest workflow iterates from start_address to
+     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
+     * bytes.
+     *
+     * IOW, if we write to mem at a point which is NOT
+     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
+     * conflict with the migration workflow.
+     *
+     * We put in a marker here, that we'll use to determine
+     * when the data has been transferred to the dst.
+     */
+    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
+}
+
+static void migrate_wait_for_dirty_mem(QTestState *from,
+                                       QTestState *to)
+{
+    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
+    uint64_t marker_address = start_address + MAGIC_OFFSET;
+    uint8_t watch_byte;
+
+    /*
+     * Wait for the MAGIC_MARKER to get transferred, as an
+     * indicator that a migration pass has made some known
+     * amount of progress.
+     */
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
+
+    /*
+     * Now ensure that already transferred bytes are
+     * dirty again from the guest workload. Note the
+     * guest byte value will wrap around and by chance
+     * match the original watch_byte. This is harmless
+     * as we'll eventually see a different value if we
+     * keep watching
+     */
+    watch_byte = qtest_readb(from, watch_address);
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readb(from, watch_address) == watch_byte);
+}
+
+
 static void migrate_pause(QTestState *who)
 {
     qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
@@ -577,7 +676,10 @@ typedef struct {
         MIG_TEST_FAIL_DEST_QUIT_ERR,
     } result;
 
-    /* Optional: set number of migration passes to wait for, if live==true */
+    /*
+     * Optional: set number of migration passes to wait for, if live==true.
+     * If zero, then merely wait for a few MB of dirty data
+     */
     unsigned int iterations;
 
     /*
@@ -1165,12 +1267,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_ensure_non_converge(from);
 
+    migrate_prepare_for_dirty_mem(from);
+
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
 
     *from_ptr = from;
     *to_ptr = to;
@@ -1405,14 +1509,8 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->live) {
-        /*
-         * Testing live migration, we want to ensure that some
-         * memory is re-dirtied after being transferred, so that
-         * we exercise logic for dirty page handling. We achieve
-         * this with a ridiculosly low bandwidth that guarantees
-         * non-convergance.
-         */
         migrate_ensure_non_converge(from);
+        migrate_prepare_for_dirty_mem(from);
     } else {
         /*
          * Testing non-live migration, we allow it to run at
@@ -1447,13 +1545,16 @@ static void test_precopy_common(MigrateCommon *args)
         }
     } else {
         if (args->live) {
-            if (args->iterations) {
-                while (args->iterations--) {
-                    wait_for_migration_pass(from);
-                }
-            } else {
+            /*
+             * For initial iteration(s) we must do a full pass,
+             * but for the final iteration, we need only wait
+             * for some dirty mem before switching to converge
+             */
+            while (args->iterations > 1) {
                 wait_for_migration_pass(from);
+                args->iterations--;
             }
+            migrate_wait_for_dirty_mem(from, to);
 
             migrate_ensure_converge(from);
 
@@ -1586,6 +1687,9 @@ static void test_ignore_shared(void)
         return;
     }
 
+    migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
+
     migrate_set_capability(from, "x-ignore-shared", true);
     migrate_set_capability(to, "x-ignore-shared", true);
 
@@ -1594,7 +1698,7 @@ static void test_ignore_shared(void)
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
 
     if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -2325,6 +2429,7 @@ static void test_multifd_tcp_cancel(void)
     }
 
     migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
 
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
@@ -2343,7 +2448,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
 
     migrate_cancel(from);
 
@@ -2372,11 +2477,13 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_migration_status(from, "cancelled", NULL);
 
-    migrate_ensure_converge(from);
+    migrate_ensure_non_converge(from);
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
+
+    migrate_ensure_converge(from);
 
     if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.39.3


