Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FA728B5E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTU-0006L9-9u; Thu, 08 Jun 2023 18:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTR-0006BV-97
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTO-0005Q5-Tp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avOz0bY4F3dSc+e/kGAWCAFrVyjMLSrlTsZ50TMKA3k=;
 b=MDeafryHMFtIzaqOeMKhxTlDLFmOeK1OBrAV0vowZeT9f6i3h+EoyQPIRl6dwJN/rRX4ZW
 g8RXa7Cm0LAveXATyBva7AxH6D+IZzrpsgbsDVgEoZq9gm5/aLdVVF6LACP9BG3z071M4k
 JACQzmlpfUND7YG8m6dmYPZlg6MD/Ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-W3MlQwrxOsWOa594OD6irQ-1; Thu, 08 Jun 2023 18:51:15 -0400
X-MC-Unique: W3MlQwrxOsWOa594OD6irQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5BB78007D9;
 Thu,  8 Jun 2023 22:51:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31E69492B00;
 Thu,  8 Jun 2023 22:51:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 39/42] migration-test: Unfold test_migrate_end() into three
 functions
Date: Fri,  9 Jun 2023 00:49:40 +0200
Message-Id: <20230608224943.3877-40-quintela@redhat.com>
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

guest_destroy(from)
test_migrate_check(from, to): depending of test value
guest_destroy(to);

This mimics previous change that split test_migrate_start()

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 63 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 29147b2be3..1a03077166 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -777,33 +777,26 @@ typedef struct {
     bool postcopy_preempt;
 } MigrateCommon;
 
-static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
+static void test_migrate_check(GuestState *from, GuestState *to)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
-    guest_destroy(from);
+    qtest_memread(to->qs, to->start_address, &dest_byte_a, 1);
 
-    if (test_dest) {
-        qtest_memread(to->qs, to->start_address, &dest_byte_a, 1);
+    /* Destination still running, wait for a byte to change */
+    do {
+        qtest_memread(to->qs, to->start_address, &dest_byte_b, 1);
+        usleep(1000 * 10);
+    } while (dest_byte_a == dest_byte_b);
 
-        /* Destination still running, wait for a byte to change */
-        do {
-            qtest_memread(to->qs, to->start_address, &dest_byte_b, 1);
-            usleep(1000 * 10);
-        } while (dest_byte_a == dest_byte_b);
+    qtest_qmp_assert_success(to->qs, "{ 'execute' : 'stop'}");
 
-        qtest_qmp_assert_success(to->qs, "{ 'execute' : 'stop'}");
-
-        /* With it stopped, check nothing changes */
-        qtest_memread(to->qs, to->start_address, &dest_byte_c, 1);
-        usleep(1000 * 200);
-        qtest_memread(to->qs, to->start_address, &dest_byte_d, 1);
-        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
-
-        check_guests_ram(to);
-    }
-
-    guest_destroy(to);
+    /* With it stopped, check nothing changes */
+    qtest_memread(to->qs, to->start_address, &dest_byte_c, 1);
+    usleep(1000 * 200);
+    qtest_memread(to->qs, to->start_address, &dest_byte_d, 1);
+    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+    check_guests_ram(to);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1203,7 +1196,9 @@ static void migrate_postcopy_complete(GuestState *from, GuestState *to,
         args->postcopy_data = NULL;
     }
 
-    test_migrate_end(from, to, true);
+    guest_destroy(from);
+    test_migrate_check(from, to);
+    guest_destroy(to);
 }
 
 static void test_postcopy_common(GuestState *from, GuestState *to,
@@ -1399,7 +1394,8 @@ static void test_baddest(void)
      */
     migrate_qmp(from->qs, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from->qs, false);
-    test_migrate_end(from, to, false);
+    guest_destroy(from);
+    guest_destroy(to);
 }
 
 static void test_precopy_common(GuestState *from, GuestState *to,
@@ -1497,7 +1493,11 @@ static void test_precopy_common(GuestState *from, GuestState *to,
         args->finish_hook(from, to, data_hook);
     }
 
-    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+    guest_destroy(from);
+    if (args->result == MIG_TEST_SUCCEED) {
+        test_migrate_check(from, to);
+    }
+    guest_destroy(to);
 }
 
 static void test_precopy_unix_plain(void)
@@ -1615,7 +1615,9 @@ static void test_ignore_shared(void)
     g_assert_cmpint(
         read_ram_property_int(from->qs, "transferred"), <, 1024 * 1024);
 
-    test_migrate_end(from, to, true);
+    guest_destroy(from);
+    test_migrate_check(from, to);
+    guest_destroy(to);
 }
 
 static void *
@@ -1925,7 +1927,8 @@ static void do_test_validate_uuid(GuestState *from, GuestState *to,
         wait_for_migration_complete(from->qs);
     }
 
-    test_migrate_end(from, to, false);
+    guest_destroy(from);
+    guest_destroy(to);
 }
 
 static void test_validate_uuid(void)
@@ -2055,7 +2058,9 @@ static void test_migrate_auto_converge(void)
     wait_for_serial(to);
     wait_for_migration_complete(from->qs);
 
-    test_migrate_end(from, to, true);
+    guest_destroy(from);
+    test_migrate_check(from, to);
+    guest_destroy(to);
 }
 
 static void *
@@ -2374,7 +2379,9 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_serial(to2);
     wait_for_migration_complete(from->qs);
-    test_migrate_end(from, to2, true);
+    guest_destroy(from);
+    test_migrate_check(from, to2);
+    guest_destroy(to2);
 }
 
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
-- 
2.40.1


