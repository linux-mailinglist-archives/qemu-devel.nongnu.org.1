Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B271EFB7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kwF-0008Ps-2h; Thu, 01 Jun 2023 12:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kwB-0008PB-Np
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kwA-0003uu-5z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOkw5tS/V0vb3gyOWJKM6iTwjgyZVasEj+VXHeAVfcg=;
 b=i7jv5XO+sgNTbMpYrrY2dbNQ5d+tZY/OylHv8kP1h8avpueGdNHQX2CtT7xLCzgO+gvOIe
 2p5e4g/9/EQQVfo5dxG5FFScZaBMH9ZkXnWO1RPpKHGqURVeVkTVyGrP3EavxDIhoc96cB
 HJ2iNak+32lyWn6Q910iNETzwiQbXVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-32vBP4jZMtSEpKUb-9s2Bw-1; Thu, 01 Jun 2023 12:14:04 -0400
X-MC-Unique: 32vBP4jZMtSEpKUb-9s2Bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 250EC811E78
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:14:04 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A64714171BB;
 Thu,  1 Jun 2023 16:14:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 08/10] tests/qtest: distinguish src/dst migration VM
 stop/resume events
Date: Thu,  1 Jun 2023 17:13:45 +0100
Message-Id: <20230601161347.1803440-9-berrange@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The 'got_stop' and 'got_resume' global variables apply to the src and
dst migration VM respectively. Change their names to make this explicit
to developers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-test.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0948d13e14..23fb61506c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,8 +43,8 @@
 unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
-static bool got_stop;
-static bool got_resume;
+static bool got_src_stop;
+static bool got_dst_resume;
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -227,7 +227,7 @@ static void wait_for_migration_pass(QTestState *who)
     uint64_t pass;
 
     /* Wait for the 1st sync */
-    while (!got_stop && !initial_pass) {
+    while (!got_src_stop && !initial_pass) {
         usleep(1000);
         initial_pass = get_migration_pass(who);
     }
@@ -235,7 +235,7 @@ static void wait_for_migration_pass(QTestState *who)
     do {
         usleep(1000);
         pass = get_migration_pass(who);
-    } while (pass == initial_pass && !got_stop);
+    } while (pass == initial_pass && !got_src_stop);
 }
 
 static void check_guests_ram(QTestState *who)
@@ -487,7 +487,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_stop) {
+    if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
     }
 
@@ -607,8 +607,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    got_stop = false;
-    got_resume = false;
+    got_src_stop = false;
+    got_dst_resume = false;
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -696,7 +696,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         *from = qtest_init(cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_stop,
-                                     &got_stop);
+                                     &got_src_stop);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
@@ -716,7 +716,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     *to = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_resume,
-                                 &got_resume);
+                                 &got_dst_resume);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -1427,7 +1427,7 @@ static void test_precopy_common(MigrateCommon *args)
          * hanging forever if migration didn't converge */
         wait_for_migration_complete(from);
 
-        if (!got_stop) {
+        if (!got_src_stop) {
             qtest_qmp_eventwait(from, "STOP");
         }
 
@@ -1537,7 +1537,7 @@ static void test_ignore_shared(void)
 
     wait_for_migration_pass(from);
 
-    if (!got_stop) {
+    if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
     }
 
@@ -1942,7 +1942,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_stop);
+        g_assert_false(got_src_stop);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2275,7 +2275,7 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_migration_pass(from);
 
-    if (!got_stop) {
+    if (!got_src_stop) {
         qtest_qmp_eventwait(from, "STOP");
     }
     qtest_qmp_eventwait(to2, "RESUME");
-- 
2.40.1


