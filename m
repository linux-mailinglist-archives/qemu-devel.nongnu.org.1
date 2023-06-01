Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C7771F047
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kwH-00007J-UV; Thu, 01 Jun 2023 12:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kwG-00006k-7N
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kwE-0003vC-5P
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryCbGEttsUUm9yVEWeKO0JsvqZ6dygGasud7gPPH4yw=;
 b=g18OgZTlJTe/sg1dOwiCmVapaIhEzMuOnxu07Wc8buzOQ4XgFrmxXLt44lkachOYvH9pvY
 KwUezUZoWb1FxfnuhjurSkVvEmZVw3Fa1EpuSxiixd7ws0ZKhrPaKaxwSNxU3rnusEu1KB
 l1hVCZM/k7i0rjXyl2gREe+q6szaZO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-rif-f0TUPxyw10QFhE5trw-1; Thu, 01 Jun 2023 12:14:08 -0400
X-MC-Unique: rif-f0TUPxyw10QFhE5trw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06A71101A59E
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:14:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCB5D14171BB;
 Thu,  1 Jun 2023 16:14:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 10/10] tests/qtest: massively speed up migration-test
Date: Thu,  1 Jun 2023 17:13:47 +0100
Message-Id: <20230601161347.1803440-11-berrange@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
---
 tests/qtest/migration-test.c | 143 ++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0b9d045152..298291f01c 100644
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
 
     /* Optional: whether the guest CPUs should be running during migration */
@@ -1158,12 +1260,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
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
@@ -1398,14 +1502,8 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1440,13 +1538,16 @@ static void test_precopy_common(MigrateCommon *args)
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
 
@@ -1573,6 +1674,9 @@ static void test_ignore_shared(void)
         return;
     }
 
+    migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
+
     migrate_set_capability(from, "x-ignore-shared", true);
     migrate_set_capability(to, "x-ignore-shared", true);
 
@@ -1581,7 +1685,7 @@ static void test_ignore_shared(void)
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
 
     if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -2273,6 +2377,7 @@ static void test_multifd_tcp_cancel(void)
     }
 
     migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
 
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
@@ -2291,7 +2396,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_qmp(from, uri, "{}");
 
-    wait_for_migration_pass(from);
+    migrate_wait_for_dirty_mem(from, to);
 
     migrate_cancel(from);
 
@@ -2320,11 +2425,13 @@ static void test_multifd_tcp_cancel(void)
 
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
2.40.1


