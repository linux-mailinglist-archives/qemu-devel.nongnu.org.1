Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A66728B60
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTV-0006LS-SB; Thu, 08 Jun 2023 18:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTS-0006Ht-N3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTR-0005Qk-3M
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gS+7Kp6/30cV/JTgNGb4o3ipG6V7VBAHBd4BKS+QWTQ=;
 b=aFunP3BjZfVSr78Yix6o0KCdT9hka6MfGvSr9lQyOxWPKRmUdBMY9PMHprxO0sYiMyHeMF
 lcLOseMjSYKINaqqhSSy7CycRPQPmYmLztvuM327oEDULXeASdgh4nw2efyIAhrJolDZZB
 e8Cf5aCZY5/U50x/NwjiW4ulLLahiqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-e-UmFcl3OkSfD9uzsnQazQ-1; Thu, 08 Jun 2023 18:51:17 -0400
X-MC-Unique: e-UmFcl3OkSfD9uzsnQazQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD1E82A59548;
 Thu,  8 Jun 2023 22:51:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A071492B00;
 Thu,  8 Jun 2023 22:51:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 40/42] migration-test: Create migrate_incoming() function
Date: Fri,  9 Jun 2023 00:49:41 +0200
Message-Id: <20230608224943.3877-41-quintela@redhat.com>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1a03077166..d8479abb4a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -684,6 +684,13 @@ static void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
+static void migrate_incoming(GuestState *who, const char *uri)
+{
+    qtest_qmp_assert_success(who->qs, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { 'uri': %s }}", uri);
+    guest_set_uri(who, uri);
+}
+
 static void migrate_postcopy_start(GuestState *from, GuestState *to)
 {
     qtest_qmp_assert_success(from->qs,
@@ -1851,9 +1858,7 @@ static void *test_migrate_fd_start_hook(GuestState *from, GuestState *to)
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'fd:fd-mig' }}");
-    guest_set_uri(to, "fd:fd-mig");
+    migrate_incoming(to, "fd:fd-mig");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from->qs, &pair[1], 1,
@@ -2077,9 +2082,7 @@ test_migrate_precopy_tcp_multifd_start_common(GuestState *from, GuestState *to,
     migrate_set_capability(to->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    guest_set_uri(to, "tcp:127.0.0.1:0");
+    migrate_incoming(to, "tcp:127.0.0.1:0");
 
     return NULL;
 }
@@ -2334,9 +2337,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    guest_set_uri(to, "tcp:127.0.0.1:0");
+    migrate_incoming(to, "tcp:127.0.0.1:0");
 
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
@@ -2360,9 +2361,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2->qs, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to2->qs, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
-    guest_set_uri(to2, "tcp:127.0.0.1:0");
+    migrate_incoming(to2, "tcp:127.0.0.1:0");
 
     wait_for_migration_status(from->qs, "cancelled", NULL);
 
-- 
2.40.1


