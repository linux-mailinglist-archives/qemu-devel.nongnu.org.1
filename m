Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F1728B55
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSZ-0003Zt-0C; Thu, 08 Jun 2023 18:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSW-0003Yd-La
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSV-00054e-3k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1pI/BP2IizABLIeg9YZBR3oLfPlDsau/eE+8LuSHew=;
 b=YKV72j46ED7UZ+LqNXHdPiazdyiEmxU8GjV8cmiy7SkIL3UqNZJuwulHvjG12iB2yrYHBe
 LxGn5BaM8u0unxsHCERucIIH/MQXhPLksUyfjQaTrcNASVFjfPrM/Q6EEPNAg2gDHxo0Vu
 J7cy9euByy4VbJSEHI8t/UNs10SpKOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-IeoyYnGnNIa8lZV88COeDQ-1; Thu, 08 Jun 2023 18:50:20 -0400
X-MC-Unique: IeoyYnGnNIa8lZV88COeDQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B9F4185A78F;
 Thu,  8 Jun 2023 22:50:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF12F515541;
 Thu,  8 Jun 2023 22:50:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 18/42] migration-test: Create guest before calling
 do_test_validate_uuid()
Date: Fri,  9 Jun 2023 00:49:19 +0200
Message-Id: <20230608224943.3877-19-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5cfc7a6ebc..14f4fd579b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1905,11 +1905,10 @@ static void test_migrate_fd_proto(void)
 }
 #endif /* _WIN32 */
 
-static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
+static void do_test_validate_uuid(GuestState *from, GuestState *to,
+                                  MigrateStart *args, bool should_fail)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    GuestState *from = guest_create("source");
-    GuestState *to = guest_create("target");
 
     test_migrate_start(from, to, uri, args);
 
@@ -1938,43 +1937,51 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 
 static void test_validate_uuid(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateStart args = {
         .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
         .opts_target = "-uuid 11111111-1111-1111-1111-111111111111",
     };
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(from, to, &args, false);
 }
 
 static void test_validate_uuid_error(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateStart args = {
         .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
         .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
         .hide_stderr = true,
     };
 
-    do_test_validate_uuid(&args, true);
+    do_test_validate_uuid(from, to, &args, true);
 }
 
 static void test_validate_uuid_src_not_set(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateStart args = {
         .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
         .hide_stderr = true,
     };
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(from, to, &args, false);
 }
 
 static void test_validate_uuid_dst_not_set(void)
 {
+    GuestState *from = guest_create("source");
+    GuestState *to = guest_create("target");
     MigrateStart args = {
         .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
         .hide_stderr = true,
     };
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(from, to, &args, false);
 }
 
 /*
-- 
2.40.1


