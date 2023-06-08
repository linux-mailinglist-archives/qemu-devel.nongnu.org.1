Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E6728B66
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTP-0005qT-KT; Thu, 08 Jun 2023 18:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTM-0005Xg-Th
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTL-0005NJ-35
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyurFvDURCZbEwa8AO4WSQ20OAwsMG3UWiZ1c2Nvryo=;
 b=SKDjlUSzcI0z5nUszaWW5f6yhj0oTmA1J5yllxioxFvQUTnwgW8l7JTU/qiTbwPpsFYR05
 SILvNi1DiZZSd72CXGVL5goL+NoL+0S923/3IVRhCMDaiFhH+Utyaeeeu8ihYaBX/Theto
 CTdPwOpLhMCiYUluDbnMWqzlpbVGfTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-ZFHyJ0eEMlS_eSadg47ohA-1; Thu, 08 Jun 2023 18:51:11 -0400
X-MC-Unique: ZFHyJ0eEMlS_eSadg47ohA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7BA7385556A;
 Thu,  8 Jun 2023 22:51:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45655492B00;
 Thu,  8 Jun 2023 22:51:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 37/42] migration-test: Create get_event GuestState variable
Date: Fri,  9 Jun 2023 00:49:38 +0200
Message-Id: <20230608224943.3877-38-quintela@redhat.com>
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

So we don't use a global variable for events.  We use one by guest.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 48 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 95b7c9ed73..a96eb3eec7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -41,8 +41,6 @@
 #endif
 
 static bool uffd_feature_thread_id;
-static bool got_src_stop;
-static bool got_dst_resume;
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -172,6 +170,7 @@ typedef struct {
     gchar *uri;
     unsigned start_address;
     unsigned end_address;
+    bool got_event;
 } GuestState;
 
 static GuestState *guest_create(const char *name)
@@ -396,21 +395,21 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
-static void wait_for_migration_pass(QTestState *who)
+static void wait_for_migration_pass(GuestState *who)
 {
-    uint64_t initial_pass = get_migration_pass(who);
+    uint64_t initial_pass = get_migration_pass(who->qs);
     uint64_t pass;
 
     /* Wait for the 1st sync */
-    while (!got_src_stop && !initial_pass) {
+    while (!who->got_event && !initial_pass) {
         usleep(1000);
-        initial_pass = get_migration_pass(who);
+        initial_pass = get_migration_pass(who->qs);
     }
 
     do {
         usleep(1000);
-        pass = get_migration_pass(who);
-    } while (pass == initial_pass && !got_src_stop);
+        pass = get_migration_pass(who->qs);
+    } while (pass == initial_pass && !who->got_event);
 }
 
 static void check_guests_ram(GuestState *who)
@@ -657,7 +656,7 @@ static void migrate_postcopy_start(GuestState *from, GuestState *to)
     qtest_qmp_assert_success(from->qs,
                              "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_src_stop) {
+    if (!from->got_event) {
         qtest_qmp_eventwait(from->qs, "STOP");
     }
 
@@ -759,9 +758,6 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
 
-    got_src_stop = false;
-    got_dst_resume = false;
-
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
@@ -781,7 +777,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
         from->qs = qtest_init(cmd_source);
         qtest_qmp_set_event_callback(from->qs,
                                      migrate_watch_for_stop,
-                                     &got_src_stop);
+                                     &from->got_event);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
@@ -803,7 +799,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     to->qs = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(to->qs,
                                  migrate_watch_for_resume,
-                                 &got_dst_resume);
+                                 &to->got_event);
 }
 
 static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
@@ -1211,7 +1207,7 @@ static void migrate_postcopy_prepare(GuestState *from,
 
     do_migrate(from, to);
 
-    wait_for_migration_pass(from->qs);
+    wait_for_migration_pass(from);
 }
 
 static void migrate_postcopy_complete(GuestState *from, GuestState *to,
@@ -1464,7 +1460,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
          */
         if (args->result == MIG_TEST_SUCCEED) {
             qtest_qmp_assert_success(from->qs, "{ 'execute' : 'stop'}");
-            if (!got_src_stop) {
+            if (!from->got_event) {
                 qtest_qmp_eventwait(from->qs, "STOP");
             }
             migrate_ensure_converge(from->qs);
@@ -1484,10 +1480,10 @@ static void test_precopy_common(GuestState *from, GuestState *to,
         if (args->live) {
             if (args->iterations) {
                 while (args->iterations--) {
-                    wait_for_migration_pass(from->qs);
+                    wait_for_migration_pass(from);
                 }
             } else {
-                wait_for_migration_pass(from->qs);
+                wait_for_migration_pass(from);
             }
 
             migrate_ensure_converge(from->qs);
@@ -1498,7 +1494,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
              */
             wait_for_migration_complete(from->qs);
 
-            if (!got_src_stop) {
+            if (!from->got_event) {
                 qtest_qmp_eventwait(from->qs, "STOP");
             }
         } else {
@@ -1513,7 +1509,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
             qtest_qmp_assert_success(to->qs, "{ 'execute' : 'cont'}");
         }
 
-        if (!got_dst_resume) {
+        if (!to->got_event) {
             qtest_qmp_eventwait(to->qs, "RESUME");
         }
 
@@ -1627,9 +1623,9 @@ static void test_ignore_shared(void)
 
     do_migrate(from, to);
 
-    wait_for_migration_pass(from->qs);
+    wait_for_migration_pass(from);
 
-    if (!got_src_stop) {
+    if (!from->got_event) {
         qtest_qmp_eventwait(from->qs, "STOP");
     }
 
@@ -2062,7 +2058,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_src_stop);
+        g_assert_false(from->got_event);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2368,7 +2364,7 @@ static void test_multifd_tcp_cancel(void)
 
     do_migrate(from, to);
 
-    wait_for_migration_pass(from->qs);
+    wait_for_migration_pass(from);
 
     migrate_cancel(from->qs);
 
@@ -2399,9 +2395,9 @@ static void test_multifd_tcp_cancel(void)
 
     do_migrate(from, to2);
 
-    wait_for_migration_pass(from->qs);
+    wait_for_migration_pass(from);
 
-    if (!got_src_stop) {
+    if (!from->got_event) {
         qtest_qmp_eventwait(from->qs, "STOP");
     }
     qtest_qmp_eventwait(to2->qs, "RESUME");
-- 
2.40.1


