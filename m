Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4335E728B5C
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSg-0003mi-PJ; Thu, 08 Jun 2023 18:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSe-0003h3-Tp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSd-00058Y-AA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rhPYNYE42HQeY1eRKeAgK6BPwEJ/BcC1H/q4dfGUy8=;
 b=Qkm9u8/SbLjedr09aAVwjeqXRufF9IcktwzYsUN7B4U1JY5835MY8TMua5QS/WPAHCKOpW
 HF+GK1kDvPmZgzB6L/hhW5jSsY7VoyW0HdC7GFxBYPp5rMIn/Sq3SFGGqSoi69LZqGz7Ba
 2s+pLv12DxTbojX4y45eW7AAeCx+Yfo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-4pzmH_VXMpCMzeJWbGKKvQ-1; Thu, 08 Jun 2023 18:50:29 -0400
X-MC-Unique: 4pzmH_VXMpCMzeJWbGKKvQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09A07385556A;
 Thu,  8 Jun 2023 22:50:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC23492B00;
 Thu,  8 Jun 2023 22:50:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 22/42] migration-test: Create guest_use_dirty_log()
Date: Fri,  9 Jun 2023 00:49:23 +0200
Message-Id: <20230608224943.3877-23-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9671c4c6e5..69a3728e4b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -156,6 +156,7 @@ typedef struct {
     gchar *arch_opts;
     gchar *arch_source;
     gchar *arch_target;
+    gchar *kvm_opts;
     const gchar *memory_size;
     const gchar *name;
     unsigned start_address;
@@ -208,9 +209,16 @@ static void guest_destroy(GuestState *vm)
     g_free(vm->arch_opts);
     g_free(vm->arch_source);
     g_free(vm->arch_target);
+    g_free(vm->kvm_opts);
     g_free(vm);
 }
 
+static void guest_use_dirty_ring(GuestState *vm)
+{
+    g_assert(vm->kvm_opts == NULL);
+    vm->kvm_opts = g_strdup(",dirty-ring-size=4096");
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -608,8 +616,6 @@ typedef struct {
     bool use_shmem;
     /* only launch the target process */
     bool only_target;
-    /* Use dirty ring if true; dirty logging otherwise */
-    bool use_dirty_ring;
     const char *opts_source;
     const char *opts_target;
 } MigrateStart;
@@ -708,7 +714,6 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     const gchar *ignore_stderr = NULL;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
-    const char *kvm_opts = NULL;
 
     got_src_stop = false;
     got_dst_resume = false;
@@ -733,16 +738,12 @@ static void test_migrate_start(GuestState *from, GuestState *to,
             from->memory_size, shmem_path);
     }
 
-    if (args->use_dirty_ring) {
-        kvm_opts = ",dirty-ring-size=4096";
-    }
-
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
+                                 from->kvm_opts ? from->kvm_opts : "",
                                  from->name,
                                  from->memory_size, tmpfs,
                                  from->arch_opts ? from->arch_opts : "",
@@ -764,7 +765,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
+                                 to->kvm_opts ? to->kvm_opts : "",
                                  to->name,
                                  to->memory_size, tmpfs, uri,
                                  to->arch_opts ? to->arch_opts : "",
@@ -1555,9 +1556,6 @@ static void test_precopy_unix_dirty_ring(void)
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
     MigrateCommon args = {
-        .start = {
-            .use_dirty_ring = true,
-        },
         .listen_uri = uri,
         .connect_uri = uri,
         /*
@@ -1567,6 +1565,8 @@ static void test_precopy_unix_dirty_ring(void)
         .live = true,
     };
 
+    guest_use_dirty_ring(from);
+    guest_use_dirty_ring(to);
     test_precopy_common(from, to, &args);
 }
 
@@ -2588,6 +2588,9 @@ static int64_t get_limit_rate(QTestState *who)
 static GuestState *dirtylimit_start_vm(void)
 {
     GuestState *vm = guest_create("dirtylimit-test");
+
+    guest_use_dirty_ring(vm);
+
     g_autofree gchar *
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
-- 
2.40.1


