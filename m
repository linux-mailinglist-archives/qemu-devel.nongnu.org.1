Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670071FFBD
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52M7-0007sr-LP; Fri, 02 Jun 2023 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52M2-0007nL-Ih
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52M0-0002OF-Pm
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvHMPsKWlgLpwvpcSXGtDPhOKfHRtBdpv1KNqO6R6Kw=;
 b=WcO8elXAe8Dr3oDknmoPwqyKk3BmRRZ0jRbDKWLvUGZffT4r036hzFePb2haMsGT5ms5yz
 U4NKLzGEczSuHgib0DFZ/e/XvZzV7VqMa3TunvJ9HMJ09StnHHImvz3qHb5prYgtjR+oAZ
 M8X8xADWe++VRlEVLT5Y39+wQtR5nSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-f6x7j2hVPLGvD6IHs3931g-1; Fri, 02 Jun 2023 06:49:29 -0400
X-MC-Unique: f6x7j2hVPLGvD6IHs3931g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DB31800888
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:17 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 328A040CFD00;
 Fri,  2 Jun 2023 10:49:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/10] tests/qtest: get rid of 'qmp_command' helper in
 migration test
Date: Fri,  2 Jun 2023 12:49:03 +0200
Message-Id: <20230602104910.35157-4-quintela@redhat.com>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

This function duplicates logic of qtest_qmp_assert_success_ref.
The qtest_qmp_assert_success_ref method has better diagnostics
on failure because it prints the entire QMP response, instead
of just asserting on existance of the 'error' key.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230601161347.1803440-4-berrange@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-helpers.h |  3 ---
 tests/qtest/migration-helpers.c | 22 ----------------------
 tests/qtest/migration-test.c    | 29 +++++++++++++++--------------
 3 files changed, 15 insertions(+), 39 deletions(-)

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


