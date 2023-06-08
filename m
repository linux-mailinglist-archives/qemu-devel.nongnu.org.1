Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD99728B40
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSd-0003d1-9X; Thu, 08 Jun 2023 18:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSb-0003cH-Vq
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSa-00057C-DY
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtnabW/FzzwqFPUIYX3N3p9+Q6zIYLzIkpHYsX40f6o=;
 b=MNtoyLOHTjE0xj8MC/lRRwZTOOawrZ77nATAzdmc8ZBJ8IVVwaZEXXnWGc0DLUjiWNIgxw
 bdQyT9IctPafGfBJe8XLmO46hIuJgDx+g9SsAbS6mkBJS6zxyQeAJEDj2iHvc3YKccJa8+
 iNwPtkv0JXN3/7XuoU3E8m1I+cdRqaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-dYQf7ezsO_-h_2NhU8sCcw-1; Thu, 08 Jun 2023 18:50:25 -0400
X-MC-Unique: dYQf7ezsO_-h_2NhU8sCcw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FF8F801182;
 Thu,  8 Jun 2023 22:50:25 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB68B515541;
 Thu,  8 Jun 2023 22:50:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 20/42] migration-test: Create guest before calling
 test_postcopy_common()
Date: Fri,  9 Jun 2023 00:49:21 +0200
Message-Id: <20230608224943.3877-21-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 528dc571ef..a18b3ce1e2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1230,11 +1230,9 @@ static void migrate_postcopy_complete(GuestState *from, GuestState *to,
     test_migrate_end(from, to, true);
 }
 
-static void test_postcopy_common(MigrateCommon *args)
+static void test_postcopy_common(GuestState *from, GuestState *to,
+                                 MigrateCommon *args)
 {
-    GuestState *from = guest_create("source");
-    GuestState *to = guest_create("target");
-
     migrate_postcopy_prepare(from, to, args);
     migrate_postcopy_start(from->qs, to->qs);
     migrate_postcopy_complete(from, to, args);
@@ -1242,49 +1240,59 @@ static void test_postcopy_common(MigrateCommon *args)
 
 static void test_postcopy(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = { };
 
-    test_postcopy_common(&args);
+    test_postcopy_common(from, to, &args);
 }
 
 static void test_postcopy_compress(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start_hook = test_migrate_compress_start
     };
 
-    test_postcopy_common(&args);
+    test_postcopy_common(from, to, &args);
 }
 
 static void test_postcopy_preempt(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .postcopy_preempt = true,
     };
 
-    test_postcopy_common(&args);
+    test_postcopy_common(from, to, &args);
 }
 
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_tls_psk(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
-    test_postcopy_common(&args);
+    test_postcopy_common(from, to, &args);
 }
 
 static void test_postcopy_preempt_tls_psk(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateCommon args = {
         .postcopy_preempt = true,
         .start_hook = test_migrate_tls_psk_start_match,
         .finish_hook = test_migrate_tls_psk_finish,
     };
 
-    test_postcopy_common(&args);
+    test_postcopy_common(from, to, &args);
 }
 #endif
 
-- 
2.40.1


