Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207F71EF3F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kw6-0008JE-OV; Thu, 01 Jun 2023 12:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kw4-0008Ig-BG
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kw2-0003sD-Mq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7063dUYn5osLxKoESf+YXjel4PhHO5uaC5ANzm8gn8=;
 b=bhNRmaMgi0AR52bThZ9v/PSuYgP9Z9CeJbzTKuQTYnNDdW+7z8ZiZoiWXpt1RQ5fL/tMV9
 rk9/YdQGwSIn/VbhG1uc1cpv882N6tODCP1nX8oU7oVN9HZr4mGAt09/kOZXm4CwaQhy6n
 RrPD996Jor7J7wuiYBxPClb2hf1mERM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-nGK7hUzpPumZd01bMgrZuA-1; Thu, 01 Jun 2023 12:13:56 -0400
X-MC-Unique: nGK7hUzpPumZd01bMgrZuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F82D185A794
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:13:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA3E214171BB;
 Thu,  1 Jun 2023 16:13:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 03/10] tests/qtest: get rid of 'qmp_command' helper in
 migration test
Date: Thu,  1 Jun 2023 17:13:40 +0100
Message-Id: <20230601161347.1803440-4-berrange@redhat.com>
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

This function duplicates logic of qtest_qmp_assert_success_ref.
The qtest_qmp_assert_success_ref method has better diagnostics
on failure because it prints the entire QMP response, instead
of just asserting on existance of the 'error' key.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-helpers.c | 22 ----------------------
 tests/qtest/migration-helpers.h |  3 ---
 tests/qtest/migration-test.c    | 29 +++++++++++++++--------------
 3 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index f6f3c6680f..bddf3f8d4d 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -85,28 +85,6 @@ QDict *wait_command(QTestState *who, const char *command, ...)
     return ret;
 }
 
-/*
- * Execute the qmp command only
- */
-QDict *qmp_command(QTestState *who, const char *command, ...)
-{
-    va_list ap;
-    QDict *resp, *ret;
-
-    va_start(ap, command);
-    resp = qtest_vqmp(who, command, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(resp, "error"));
-    g_assert(qdict_haskey(resp, "return"));
-
-    ret = qdict_get_qdict(resp, "return");
-    qobject_ref(ret);
-    qobject_unref(resp);
-
-    return ret;
-}
-
 /*
  * Send QMP command "migrate".
  * Arguments are built from @fmt... (formatted like
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index a188b62787..2e51a6e195 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,9 +25,6 @@ QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...);
 G_GNUC_PRINTF(2, 3)
 QDict *wait_command(QTestState *who, const char *command, ...);
 
-G_GNUC_PRINTF(2, 3)
-QDict *qmp_command(QTestState *who, const char *command, ...);
-
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b99b49a314..9ce27f89ec 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2322,32 +2322,33 @@ static void test_multifd_tcp_cancel(void)
 
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
-    qobject_unref(qmp_command(who,
-                  "{ 'execute': 'calc-dirty-rate',"
-                  "'arguments': { "
-                  "'calc-time': %" PRIu64 ","
-                  "'mode': 'dirty-ring' }}",
-                  calc_time));
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'calc-dirty-rate',"
+                             "'arguments': { "
+                             "'calc-time': %" PRIu64 ","
+                             "'mode': 'dirty-ring' }}",
+                             calc_time);
 }
 
 static QDict *query_dirty_rate(QTestState *who)
 {
-    return qmp_command(who, "{ 'execute': 'query-dirty-rate' }");
+    return qtest_qmp_assert_success_ref(who,
+                                        "{ 'execute': 'query-dirty-rate' }");
 }
 
 static void dirtylimit_set_all(QTestState *who, uint64_t dirtyrate)
 {
-    qobject_unref(qmp_command(who,
-                  "{ 'execute': 'set-vcpu-dirty-limit',"
-                  "'arguments': { "
-                  "'dirty-rate': %" PRIu64 " } }",
-                  dirtyrate));
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'set-vcpu-dirty-limit',"
+                             "'arguments': { "
+                             "'dirty-rate': %" PRIu64 " } }",
+                             dirtyrate);
 }
 
 static void cancel_vcpu_dirty_limit(QTestState *who)
 {
-    qobject_unref(qmp_command(who,
-                  "{ 'execute': 'cancel-vcpu-dirty-limit' }"));
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'cancel-vcpu-dirty-limit' }");
 }
 
 static QDict *query_vcpu_dirty_limit(QTestState *who)
-- 
2.40.1


