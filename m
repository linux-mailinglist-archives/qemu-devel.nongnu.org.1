Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0324728B67
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSu-0004aj-7c; Thu, 08 Jun 2023 18:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSq-0004RD-FZ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSm-0005Dg-A3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpPspcELb1hx/8sTehXX9SuQS6bZnSSsN5qQL51kSA4=;
 b=EENOMXoKvG5q46Kt/FCz0CCDk/qWQjmBaVBwov7L8aoFujWmYve7y/4xQO0qeI8HFgeptn
 xNoIOf5gKSiG+whyOlek05SdaMkM7tbvUB6H4n5sDMMNFp4q/RKoobdieiZslQli5q4Vi8
 /wfLrh6qNPAgy/B/P9iLmVe+0kkvgbU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-smAMUlBUMMOx8vpcP59Sdg-1; Thu, 08 Jun 2023 18:50:37 -0400
X-MC-Unique: smAMUlBUMMOx8vpcP59Sdg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9258B280BC58;
 Thu,  8 Jun 2023 22:50:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3134492B00;
 Thu,  8 Jun 2023 22:50:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 26/42] migration-test: create guest_use_shmem()
Date: Fri,  9 Jun 2023 00:49:27 +0200
Message-Id: <20230608224943.3877-27-quintela@redhat.com>
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

So now this is the same that everything else.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 46 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 933000ad81..0130a00707 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -164,6 +164,8 @@ typedef struct {
      */
     const gchar *name;
     gchar *serial_path;
+    gchar *shmem_opts;
+    gchar *shmem_path;
     unsigned start_address;
     unsigned end_address;
 } GuestState;
@@ -217,6 +219,9 @@ static void guest_destroy(GuestState *vm)
     g_free(vm->kvm_opts);
     unlink(vm->serial_path);
     g_free(vm->serial_path);
+    g_free(vm->shmem_opts);
+    unlink(vm->shmem_path);
+    g_free(vm->shmem_path);
     g_free(vm);
 }
 
@@ -226,6 +231,18 @@ static void guest_use_dirty_ring(GuestState *vm)
     vm->kvm_opts = g_strdup(",dirty-ring-size=4096");
 }
 
+static void guest_use_shmem(GuestState *vm)
+{
+    g_assert(vm->shmem_opts == NULL);
+    g_assert(vm->shmem_path == NULL);
+
+    vm->shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+    vm->shmem_opts = g_strdup_printf(
+        "-object memory-backend-file,id=mem0,size=%s"
+        ",mem-path=%s,share=on -numa node,memdev=mem0",
+        vm->memory_size, vm->shmem_path);
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -621,7 +638,6 @@ typedef struct {
      * unconditionally, because it means the user would like to be verbose.
      */
     bool hide_stderr;
-    bool use_shmem;
     /* only launch the target process */
     bool only_target;
     const char *opts_source;
@@ -720,8 +736,6 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr = NULL;
-    g_autofree char *shmem_opts = NULL;
-    g_autofree char *shmem_path = NULL;
 
     got_src_stop = false;
     got_dst_resume = false;
@@ -738,14 +752,6 @@ static void test_migrate_start(GuestState *from, GuestState *to,
 #endif
     }
 
-    if (args->use_shmem) {
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
-        shmem_opts = g_strdup_printf(
-            "-object memory-backend-file,id=mem0,size=%s"
-            ",mem-path=%s,share=on -numa node,memdev=mem0",
-            from->memory_size, shmem_path);
-    }
-
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
@@ -757,7 +763,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  from->serial_path,
                                  from->arch_opts ? from->arch_opts : "",
                                  from->arch_source ? from->arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 from->shmem_opts ? from->shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr ? ignore_stderr : "");
 
@@ -781,21 +787,13 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  uri,
                                  to->arch_opts ? to->arch_opts : "",
                                  to->arch_target ? to->arch_target : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 to->shmem_opts ? to->shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr ? ignore_stderr : "");
     to->qs = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(to->qs,
                                  migrate_watch_for_resume,
                                  &got_dst_resume);
-
-    /*
-     * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid becase QEMU has already opened this file
-     */
-    if (args->use_shmem) {
-        unlink(shmem_path);
-    }
 }
 
 static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
@@ -1637,10 +1635,10 @@ static void test_ignore_shared(void)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     GuestState *from = guest_create("source");
     GuestState *to = guest_create("target");
-    MigrateStart args = {
-        .use_shmem = true
-    };
+    MigrateStart args = { };
 
+    guest_use_shmem(from);
+    guest_use_shmem(to);
     test_migrate_start(from, to, uri, &args);
 
     migrate_set_capability(from->qs, "x-ignore-shared", true);
-- 
2.40.1


