Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C9728B45
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTD-0004wt-6f; Thu, 08 Jun 2023 18:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSy-0004ub-9e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSw-0005JR-6o
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVN1nXo6DujMCsHuqnOTEQUt2FzvOxE8/dS8ka8qYWg=;
 b=C9RqNUR7EtfoG5dQXqqga8zrXfdRuadbe1DxZvTOA1gBhdePYjZ9INdFMa+KQ9UTm7kv41
 gZG2kG9aidSjhn8wN0GmbUwArDU1b3iCBS33otoALa9Lznaj9eiqKcO3RxqmMb95by2ybz
 hzmEkkFcmlmU+qUCdWagV0CrcUuEaKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-rf-it9liOu6KyKHe2o7ePA-1; Thu, 08 Jun 2023 18:50:48 -0400
X-MC-Unique: rf-it9liOu6KyKHe2o7ePA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC8BB80013A;
 Thu,  8 Jun 2023 22:50:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFEB492B00;
 Thu,  8 Jun 2023 22:50:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 32/42] migration-test: Create guest_set_uri()
Date: Fri,  9 Jun 2023 00:49:33 +0200
Message-Id: <20230608224943.3877-33-quintela@redhat.com>
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

We need this for migration-incoming cases.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0afe871cfb..f029258f67 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -286,6 +286,12 @@ static void guest_listen_unix_socket(GuestState *vm)
     vm->uri = g_strdup_printf("unix:%s", vm->unix_socket);
 }
 
+static void guest_set_uri(GuestState *vm, const gchar *uri)
+{
+    g_free(vm->uri);
+    vm->uri = g_strdup(uri);
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -1918,6 +1924,7 @@ static void *test_migrate_fd_start_hook(GuestState *from, GuestState *to)
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'fd:fd-mig' }}");
+    guest_set_uri(to, "fd:fd-mig");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from->qs, &pair[1], 1,
@@ -1958,7 +1965,6 @@ static void test_migrate_fd_proto(void)
     GuestState *to = guest_create("target");
     MigrateCommon args = {
         .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
         .start_hook = test_migrate_fd_start_hook,
         .finish_hook = test_migrate_fd_finish_hook
     };
@@ -2145,6 +2151,7 @@ test_migrate_precopy_tcp_multifd_start_common(GuestState *from, GuestState *to,
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    guest_set_uri(to, "tcp:127.0.0.1:0");
 
     return NULL;
 }
@@ -2411,6 +2418,7 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    guest_set_uri(to, "tcp:127.0.0.1:0");
 
     /* Wait for the first serial output from the source */
     wait_for_serial(from);
@@ -2440,6 +2448,7 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to2->qs, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    guest_set_uri(to2, "tcp:127.0.0.1:0");
 
     wait_for_migration_status(from->qs, "cancelled", NULL);
 
-- 
2.40.1


