Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43500728B6B
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSv-0004bo-8M; Thu, 08 Jun 2023 18:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSq-0004RH-Hb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSm-0005EQ-UA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbFyLack4wDnUym7oF0k7wqkTIuMqatFAHhadVBxf8g=;
 b=NoFtPhN12FuGcVGdYT8bS8+7wvaKsjoqYPjs+U/l22bcc81wsd4mjbdcOPNrSBubaOZPPK
 LH80oWzzjHB84eJ7jhuvwTT5ZZg9RynV9W0ZkWhDAkDQDC73s1q9R8nbX23xT0WPEKRyp5
 m0miXdfFb5nKOL6HdpKSjh4EHErjkLM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-khLabbbFNBq2PCstQX6PYg-1; Thu, 08 Jun 2023 18:50:38 -0400
X-MC-Unique: khLabbbFNBq2PCstQX6PYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6873C1C0513A;
 Thu,  8 Jun 2023 22:50:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA9CE48205E;
 Thu,  8 Jun 2023 22:50:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 27/42] migration-test: Create guest_extra_opts()
Date: Fri,  9 Jun 2023 00:49:28 +0200
Message-Id: <20230608224943.3877-28-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

If a guest has extra command line options, add it with this.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0130a00707..b9b11ebb0f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -156,6 +156,7 @@ typedef struct {
     gchar *arch_opts;
     gchar *arch_source;
     gchar *arch_target;
+    const gchar *extra_opts;
     gchar *kvm_opts;
     const gchar *memory_size;
     /*
@@ -243,6 +244,12 @@ static void guest_use_shmem(GuestState *vm)
         vm->memory_size, vm->shmem_path);
 }
 
+static void guest_extra_opts(GuestState *vm, const gchar *opts)
+{
+    g_assert(vm->extra_opts == NULL);
+    vm->extra_opts = opts;
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -640,8 +647,6 @@ typedef struct {
     bool hide_stderr;
     /* only launch the target process */
     bool only_target;
-    const char *opts_source;
-    const char *opts_target;
 } MigrateStart;
 
 /*
@@ -764,7 +769,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  from->arch_opts ? from->arch_opts : "",
                                  from->arch_source ? from->arch_source : "",
                                  from->shmem_opts ? from->shmem_opts : "",
-                                 args->opts_source ? args->opts_source : "",
+                                 from->extra_opts ? from->extra_opts : "",
                                  ignore_stderr ? ignore_stderr : "");
 
     if (!args->only_target) {
@@ -788,7 +793,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  to->arch_opts ? to->arch_opts : "",
                                  to->arch_target ? to->arch_target : "",
                                  to->shmem_opts ? to->shmem_opts : "",
-                                 args->opts_target ? args->opts_target : "",
+                                 to->extra_opts ? to->extra_opts : "",
                                  ignore_stderr ? ignore_stderr : "");
     to->qs = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(to->qs,
@@ -1996,11 +2001,10 @@ static void test_validate_uuid(void)
 {
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 11111111-1111-1111-1111-111111111111",
-    };
+    MigrateStart args = { };
 
+    guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
+    guest_extra_opts(to, "-uuid 11111111-1111-1111-1111-111111111111");
     do_test_validate_uuid(from, to, &args, false);
 }
 
@@ -2009,11 +2013,11 @@ static void test_validate_uuid_error(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
         .hide_stderr = true,
     };
 
+    guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
+    guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
     do_test_validate_uuid(from, to, &args, true);
 }
 
@@ -2022,10 +2026,10 @@ static void test_validate_uuid_src_not_set(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateStart args = {
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
         .hide_stderr = true,
     };
 
+    guest_extra_opts(to, "-uuid 22222222-2222-2222-2222-222222222222");
     do_test_validate_uuid(from, to, &args, false);
 }
 
@@ -2034,10 +2038,10 @@ static void test_validate_uuid_dst_not_set(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
         .hide_stderr = true,
     };
 
+    guest_extra_opts(from, "-uuid 11111111-1111-1111-1111-111111111111");
     do_test_validate_uuid(from, to, &args, false);
 }
 
-- 
2.40.1


