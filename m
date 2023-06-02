Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C671FFBC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52Lh-0007B6-Qx; Fri, 02 Jun 2023 06:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52Lb-0007AB-Jw
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52LZ-0002Km-VO
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmuKYPEKPpW1kd0CglqT4w2zLSlxX3ssyau191e1TaA=;
 b=BQAiWdYpY6/+hz2y3gZp3/cl/k1WGKB2fId/0KBxhnOzM+b46NdchVmssPji/4rSlTyMJ4
 2/4uKsisQWcz9rFCltRUjrFqDSRKlkRbWNnxzTh96oh654oFj+AbTqOQXNWr8833hBZ6gi
 xmdG6PEEvy7VATtSUIyBUXMnIel0RUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-vnNxKHEkMlGSXXHI4HhSVw-1; Fri, 02 Jun 2023 06:49:26 -0400
X-MC-Unique: vnNxKHEkMlGSXXHI4HhSVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E6503828887
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:26 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B21540CFD00;
 Fri,  2 Jun 2023 10:49:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/10] tests/qtest: distinguish src/dst migration VM
 stop/resume events
Date: Fri,  2 Jun 2023 12:49:08 +0200
Message-Id: <20230602104910.35157-9-quintela@redhat.com>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

The 'got_stop' and 'got_resume' global variables apply to the src and
dst migration VM respectively. Change their names to make this explicit
to developers.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230601161347.1803440-9-berrange@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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


