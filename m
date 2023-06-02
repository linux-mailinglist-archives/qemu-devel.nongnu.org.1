Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CC71F7A2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 03:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4tPG-0004Y1-PE; Thu, 01 Jun 2023 21:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tPD-0004Wq-Mj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4tPB-0004Zv-Jp
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 21:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685668597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGwf8kc/dcE7Ruk14sBtlzgegWZUPzDePbWfpRUuLvE=;
 b=VkRNrWFt33tHIbmSMxaP2q9xgq355P/biMJLKeBOcfjv/5J5TYS5uz3whp5dxjwdHUJXPw
 rA4OBcSGI58yoF12biMyKB9Rpuc75dyQOVsLS6ZtNSrTGpibxHeKVEyMHpWjLhCSYiw9mt
 E+Km+RY8LYSZ4MdaN6XVN6sKZ348uq0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-QGIZVYzvOfqKGS7b5i2Z7A-1; Thu, 01 Jun 2023 21:16:36 -0400
X-MC-Unique: QGIZVYzvOfqKGS7b5i2Z7A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62849c5e9f0so901646d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 18:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685668595; x=1688260595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGwf8kc/dcE7Ruk14sBtlzgegWZUPzDePbWfpRUuLvE=;
 b=RjVdawtGgx62KLNiQu8Yy5BBWE/3vnAem99X2WfRSbbdGgkSMjIE7D+dd6wEq78G3Z
 4nsvyIU7abZ3FRnTomTU/8JL0euFBor5Dul15WholsAdeaL77xbvpXbpAe/zlvwtDXNB
 K15FndEOqTiUFgCDie7WJD/A6uclQm/D7bDx5I1VlCRnth9/VUAYWpq6zsJspPvdNN3c
 w6aY399cLFhnEba5hkjNqcHL8NMx9cjglzdOI/dj2h/WRLb5S7ugm4/S70Ymc4b79KfS
 M7xZmISh8cZ6ijXgvjs3HdCXWrlSfkB9kxXCCAV64Ki0dqogOp9r8esdYoZdsruHHk2G
 AiLg==
X-Gm-Message-State: AC+VfDxdGCyt8oBACNjzSrD4msO4GvPnOBlHYcyJY/mdm+IxZ9sKHCm1
 59aKxooKQS3tG4LHl7JQmx2VJVq3m6SOd9HQ+Bfk+/wNwjAuBTs64UQ25LqQSURQlFyq5Zg484H
 I+NoP/MH3TjwooGLPa/3VeuBFDGJXbkhaZIxXOs+/4pmHwm7f8Q5ZOXt7HM6fJI3MIWQpZ9dU
X-Received: by 2002:a05:6214:2aa1:b0:628:7923:b3e1 with SMTP id
 js1-20020a0562142aa100b006287923b3e1mr1408403qvb.2.1685668594660; 
 Thu, 01 Jun 2023 18:16:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x/lPSn19Dd+YS5KESBgKjtP+jYNEwTxrJUbhzZ6YM3vWWVuGLT+Z7Emq1MvepQwsulkcdrw==
X-Received: by 2002:a05:6214:2aa1:b0:628:7923:b3e1 with SMTP id
 js1-20020a0562142aa100b006287923b3e1mr1408371qvb.2.1685668594238; 
 Thu, 01 Jun 2023 18:16:34 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l20-20020ad44454000000b006261e6a88c7sm170462qvt.36.2023.06.01.18.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 18:16:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH RFC 2/3] Revert "tests/qtest: massively speed up
 migration-test"
Date: Thu,  1 Jun 2023 21:16:25 -0400
Message-Id: <20230602011626.226640-3-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602011626.226640-1-peterx@redhat.com>
References: <20230602011626.226640-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This reverts commit e76a92b869f17d7a3f554890fb89b7da595dd652.
---
 tests/qtest/migration-test.c | 143 +++++------------------------------
 1 file changed, 18 insertions(+), 125 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d2cd71e6cf..b0c355bbd9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -46,20 +46,6 @@ static bool uffd_feature_thread_id;
 static bool got_src_stop;
 static bool got_dst_resume;
 
-/*
- * An initial 3 MB offset is used as that corresponds
- * to ~1 sec of data transfer with our bandwidth setting.
- */
-#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
-/*
- * A further 1k is added to ensure we're not a multiple
- * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
- * from the migration guest workload.
- */
-#define MAGIC_OFFSET_SHUFFLE 1024
-#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
-#define MAGIC_MARKER 0xFEED12345678CAFEULL
-
 /*
  * Dirtylimit stop working if dirty page rate error
  * value less than DIRTYLIMIT_TOLERANCE_RANGE
@@ -459,91 +445,6 @@ static void migrate_ensure_converge(QTestState *who)
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
-/*
- * Our goal is to ensure that we run a single full migration
- * iteration, and also dirty memory, ensuring that at least
- * one further iteration is required.
- *
- * We can't directly synchronize with the start of a migration
- * so we have to apply some tricks monitoring memory that is
- * transferred.
- *
- * Initially we set the migration bandwidth to an insanely
- * low value, with tiny max downtime too. This basically
- * guarantees migration will never complete.
- *
- * This will result in a test that is unacceptably slow though,
- * so we can't let the entire migration pass run at this speed.
- * Our intent is to let it run just long enough that we can
- * prove data prior to the marker has been transferred *AND*
- * also prove this transferred data is dirty again.
- *
- * Before migration starts, we write a 64-bit magic marker
- * into a fixed location in the src VM RAM.
- *
- * Then watch dst memory until the marker appears. This is
- * proof that start_address -> MAGIC_OFFSET_BASE has been
- * transferred.
- *
- * Finally we go back to the source and read a byte just
- * before the marker untill we see it flip in value. This
- * is proof that start_address -> MAGIC_OFFSET_BASE
- * is now dirty again.
- *
- * IOW, we're guaranteed at least a 2nd migration pass
- * at this point.
- *
- * We can now let migration run at full speed to finish
- * the test
- */
-static void migrate_prepare_for_dirty_mem(QTestState *from)
-{
-    /*
-     * The guest workflow iterates from start_address to
-     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
-     * bytes.
-     *
-     * IOW, if we write to mem at a point which is NOT
-     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
-     * conflict with the migration workflow.
-     *
-     * We put in a marker here, that we'll use to determine
-     * when the data has been transferred to the dst.
-     */
-    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
-}
-
-static void migrate_wait_for_dirty_mem(QTestState *from,
-                                       QTestState *to)
-{
-    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
-    uint64_t marker_address = start_address + MAGIC_OFFSET;
-    uint8_t watch_byte;
-
-    /*
-     * Wait for the MAGIC_MARKER to get transferred, as an
-     * indicator that a migration pass has made some known
-     * amount of progress.
-     */
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
-
-    /*
-     * Now ensure that already transferred bytes are
-     * dirty again from the guest workload. Note the
-     * guest byte value will wrap around and by chance
-     * match the original watch_byte. This is harmless
-     * as we'll eventually see a different value if we
-     * keep watching
-     */
-    watch_byte = qtest_readb(from, watch_address);
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte);
-}
-
-
 static void migrate_pause(QTestState *who)
 {
     qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
@@ -676,10 +577,7 @@ typedef struct {
         MIG_TEST_FAIL_DEST_QUIT_ERR,
     } result;
 
-    /*
-     * Optional: set number of migration passes to wait for, if live==true.
-     * If zero, then merely wait for a few MB of dirty data
-     */
+    /* Optional: set number of migration passes to wait for, if live==true */
     unsigned int iterations;
 
     /*
@@ -1267,14 +1165,12 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_ensure_non_converge(from);
 
-    migrate_prepare_for_dirty_mem(from);
-
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     migrate_qmp(from, uri, "{}");
 
-    migrate_wait_for_dirty_mem(from, to);
+    wait_for_migration_pass(from);
 
     *from_ptr = from;
     *to_ptr = to;
@@ -1509,8 +1405,14 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->live) {
+        /*
+         * Testing live migration, we want to ensure that some
+         * memory is re-dirtied after being transferred, so that
+         * we exercise logic for dirty page handling. We achieve
+         * this with a ridiculosly low bandwidth that guarantees
+         * non-convergance.
+         */
         migrate_ensure_non_converge(from);
-        migrate_prepare_for_dirty_mem(from);
     } else {
         /*
          * Testing non-live migration, we allow it to run at
@@ -1545,16 +1447,13 @@ static void test_precopy_common(MigrateCommon *args)
         }
     } else {
         if (args->live) {
-            /*
-             * For initial iteration(s) we must do a full pass,
-             * but for the final iteration, we need only wait
-             * for some dirty mem before switching to converge
-             */
-            while (args->iterations > 1) {
+            if (args->iterations) {
+                while (args->iterations--) {
+                    wait_for_migration_pass(from);
+                }
+            } else {
                 wait_for_migration_pass(from);
-                args->iterations--;
             }
-            migrate_wait_for_dirty_mem(from, to);
 
             migrate_ensure_converge(from);
 
@@ -1687,9 +1586,6 @@ static void test_ignore_shared(void)
         return;
     }
 
-    migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
-
     migrate_set_capability(from, "x-ignore-shared", true);
     migrate_set_capability(to, "x-ignore-shared", true);
 
@@ -1698,7 +1594,7 @@ static void test_ignore_shared(void)
 
     migrate_qmp(from, uri, "{}");
 
-    migrate_wait_for_dirty_mem(from, to);
+    wait_for_migration_pass(from);
 
     if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -2402,7 +2298,6 @@ static void test_multifd_tcp_cancel(void)
     }
 
     migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
 
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
@@ -2421,7 +2316,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_qmp(from, uri, "{}");
 
-    migrate_wait_for_dirty_mem(from, to);
+    wait_for_migration_pass(from);
 
     migrate_cancel(from);
 
@@ -2450,13 +2345,11 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_migration_status(from, "cancelled", NULL);
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_converge(from);
 
     migrate_qmp(from, uri, "{}");
 
-    migrate_wait_for_dirty_mem(from, to);
-
-    migrate_ensure_converge(from);
+    wait_for_migration_pass(from);
 
     if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.40.1


