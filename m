Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC57728B58
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSV-0003Y5-Vt; Thu, 08 Jun 2023 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSR-0003X2-W2
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSQ-000523-EP
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooZDVu2u6stJR54x4HIx0421sLGbHoWHpwjasvtyWl4=;
 b=Q+ZVZSzTK8SmCY2b7T97ykpXNBvzK7s8HtQoF64I1MJ/T1LEa08mU6NxcBdX5VygPhmmcX
 3l8erKV00fpc8oCGMdQ+YJQTQ9ebtV2Xkv7FoeMU/rqq+uuZdz743QdpyJCkr3tZVsyfnX
 ySoozyRjhW68UFYT3eEGm5CbrTLI7qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-uGC5y3flMq-GYodPuuYhMQ-1; Thu, 08 Jun 2023 18:50:13 -0400
X-MC-Unique: uGC5y3flMq-GYodPuuYhMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3E8C811E85;
 Thu,  8 Jun 2023 22:50:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 739A0515541;
 Thu,  8 Jun 2023 22:50:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 14/42] migration-test: test_migrate_start() always return 0
Date: Fri,  9 Jun 2023 00:49:15 +0200
Message-Id: <20230608224943.3877-15-quintela@redhat.com>
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

So make it return void instead and adjust all callers.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 38 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5837060138..b57811da75 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -629,8 +629,8 @@ typedef struct {
     bool postcopy_preempt;
 } MigrateCommon;
 
-static int test_migrate_start(QTestState **from, QTestState **to,
-                              const char *uri, MigrateStart *args)
+static void test_migrate_start(QTestState **from, QTestState **to,
+                               const char *uri, MigrateStart *args)
 {
     g_autofree gchar *arch_source = NULL;
     g_autofree gchar *arch_target = NULL;
@@ -745,8 +745,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     if (args->use_shmem) {
         unlink(shmem_path);
     }
-
-    return 0;
 }
 
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
@@ -1155,9 +1153,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, &args->start)) {
-        return -1;
-    }
+    test_migrate_start(&from, &to, uri, &args->start);
 
     if (args->start_hook) {
         args->postcopy_data = args->start_hook(from, to);
@@ -1387,9 +1383,7 @@ static void test_baddest(void)
     };
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
-        return;
-    }
+    test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args);
     migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
@@ -1400,9 +1394,7 @@ static void test_precopy_common(MigrateCommon *args)
     QTestState *from, *to;
     void *data_hook = NULL;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
-    }
+    test_migrate_start(&from, &to, args->listen_uri, &args->start);
 
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
@@ -1592,9 +1584,7 @@ static void test_ignore_shared(void)
         .use_shmem = true
     };
 
-    if (test_migrate_start(&from, &to, uri, &args)) {
-        return;
-    }
+    test_migrate_start(&from, &to, uri, &args);
 
     migrate_set_capability(from, "x-ignore-shared", true);
     migrate_set_capability(to, "x-ignore-shared", true);
@@ -1893,9 +1883,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, args)) {
-        return;
-    }
+    test_migrate_start(&from, &to, uri, args);
 
     /*
      * UUID validation is at the begin of migration. So, the main process of
@@ -1990,9 +1978,7 @@ static void test_migrate_auto_converge(void)
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
-    if (test_migrate_start(&from, &to, uri, &args)) {
-        return;
-    }
+    test_migrate_start(&from, &to, uri, &args);
 
     migrate_set_capability(from, "auto-converge", true);
     migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
@@ -2302,9 +2288,7 @@ static void test_multifd_tcp_cancel(void)
     QTestState *from, *to, *to2;
     g_autofree char *uri = NULL;
 
-    if (test_migrate_start(&from, &to, "defer", &args)) {
-        return;
-    }
+    test_migrate_start(&from, &to, "defer", &args);
 
     migrate_ensure_non_converge(from);
 
@@ -2337,9 +2321,7 @@ static void test_multifd_tcp_cancel(void)
         .only_target = true,
     };
 
-    if (test_migrate_start(&from, &to2, "defer", &args)) {
-        return;
-    }
+    test_migrate_start(&from, &to2, "defer", &args);
 
     migrate_set_parameter_int(to2, "multifd-channels", 16);
 
-- 
2.40.1


