Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A377D728B5F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSq-0004Iq-Ho; Thu, 08 Jun 2023 18:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSj-00044Z-FD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSh-0005Ab-De
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjhpxl6wU6+QIbMXQEEmeHvaTr4KpukWzCOVNU/C9RU=;
 b=dHL+g0pwugGK8y25GESUEYjPT/Sqafw6qrmBgIm5+2wZW0lZ3h2sBWnp6TMDTAoloZ3Y/N
 fVsVA9GEFKZbSMiR6L+i6v8NrmdJ01zIl1k1JDwGldjo30T1RCAhBdTwjOmL+FaDL2BOjO
 VQd7SdrmZAfLVio4U+yoKCxj996v6Xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-BcO4TGF_O9W43GdBwfw3PQ-1; Thu, 08 Jun 2023 18:50:31 -0400
X-MC-Unique: BcO4TGF_O9W43GdBwfw3PQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0122C85A5AA;
 Thu,  8 Jun 2023 22:50:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51DC2492B00;
 Thu,  8 Jun 2023 22:50:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 23/42] migration-test: Move serial to GuestState
Date: Fri,  9 Jun 2023 00:49:24 +0200
Message-Id: <20230608224943.3877-24-quintela@redhat.com>
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 65 ++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 69a3728e4b..01ab51a391 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -158,7 +158,12 @@ typedef struct {
     gchar *arch_target;
     gchar *kvm_opts;
     const gchar *memory_size;
+    /*
+     * name must *not* contain "target" if it is the target of a
+     * migration.
+     */
     const gchar *name;
+    gchar *serial_path;
     unsigned start_address;
     unsigned end_address;
 } GuestState;
@@ -199,7 +204,7 @@ static GuestState *guest_create(const char *name)
     }
 
     vm->name = name;
-
+    vm->serial_path = g_strdup_printf("%s/%s", tmpfs, vm->name);
     return vm;
 }
 
@@ -210,6 +215,8 @@ static void guest_destroy(GuestState *vm)
     g_free(vm->arch_source);
     g_free(vm->arch_target);
     g_free(vm->kvm_opts);
+    unlink(vm->serial_path);
+    g_free(vm->serial_path);
     g_free(vm);
 }
 
@@ -224,12 +231,12 @@ static void guest_use_dirty_ring(GuestState *vm)
  * we get an 'A' followed by an endless string of 'B's
  * but on the destination we won't have the A.
  */
-static void wait_for_serial(const char *side)
+static void wait_for_serial(GuestState *vm)
 {
-    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
-    FILE *serialfile = fopen(serialpath, "r");
+    FILE *serialfile = fopen(vm->serial_path, "r");
     const char *arch = qtest_get_arch();
-    int started = (strcmp(side, "src_serial") == 0 &&
+    /* see serial_path comment on GuestState definition */
+    int started = (strstr(vm->serial_path, "target") == NULL &&
                    strcmp(arch, "ppc64") == 0) ? 0 : 1;
 
     do {
@@ -262,14 +269,15 @@ static void wait_for_serial(const char *side)
             return;
 
         case EOF:
-            started = (strcmp(side, "src_serial") == 0 &&
+            started = (strstr(vm->serial_path, "target") == NULL &&
                        strcmp(arch, "ppc64") == 0) ? 0 : 1;
             fseek(serialfile, 0, SEEK_SET);
             usleep(1000);
             break;
 
         default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue,
+                    vm->serial_path);
             g_assert_not_reached();
         }
     } while (true);
@@ -741,11 +749,12 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
-                                 "-serial file:%s/src_serial "
+                                 "-serial file:%s "
                                  "%s %s %s %s %s",
                                  from->kvm_opts ? from->kvm_opts : "",
                                  from->name,
-                                 from->memory_size, tmpfs,
+                                 from->memory_size,
+                                 from->serial_path,
                                  from->arch_opts ? from->arch_opts : "",
                                  from->arch_source ? from->arch_source : "",
                                  shmem_opts ? shmem_opts : "",
@@ -762,12 +771,14 @@ static void test_migrate_start(GuestState *from, GuestState *to,
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-name %s,debug-threads=on "
                                  "-m %s "
-                                 "-serial file:%s/dest_serial "
+                                 "-serial file:%s "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  to->kvm_opts ? to->kvm_opts : "",
                                  to->name,
-                                 to->memory_size, tmpfs, uri,
+                                 to->memory_size,
+                                 to->serial_path,
+                                 uri,
                                  to->arch_opts ? to->arch_opts : "",
                                  to->arch_target ? to->arch_target : "",
                                  shmem_opts ? shmem_opts : "",
@@ -816,8 +827,6 @@ static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
     guest_destroy(to);
 
     cleanup("migsocket");
-    cleanup("src_serial");
-    cleanup("dest_serial");
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1210,7 +1219,7 @@ static void migrate_postcopy_prepare(GuestState *from,
     migrate_ensure_non_converge(from->qs);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(from);
 
     do_migrate(from, to, uri);
 
@@ -1223,7 +1232,7 @@ static void migrate_postcopy_complete(GuestState *from, GuestState *to,
     wait_for_migration_complete(from->qs);
 
     /* Make sure we get at least one "B" on destination */
-    wait_for_serial("dest_serial");
+    wait_for_serial(to);
 
     if (uffd_feature_thread_id) {
         read_blocktime(to->qs);
@@ -1447,7 +1456,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
 
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial("src_serial");
+        wait_for_serial(from);
     }
 
     if (args->live) {
@@ -1521,7 +1530,7 @@ static void test_precopy_common(GuestState *from, GuestState *to,
             qtest_qmp_eventwait(to->qs, "RESUME");
         }
 
-        wait_for_serial("dest_serial");
+        wait_for_serial(to);
     }
 
     if (args->finish_hook) {
@@ -1638,7 +1647,7 @@ static void test_ignore_shared(void)
     migrate_set_capability(to->qs, "x-ignore-shared", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(from);
 
     do_migrate(from, to, uri);
 
@@ -1650,7 +1659,7 @@ static void test_ignore_shared(void)
 
     qtest_qmp_eventwait(to->qs, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(to);
     wait_for_migration_complete(from->qs);
 
     /* Check whether shared RAM has been really skipped */
@@ -1971,7 +1980,7 @@ static void do_test_validate_uuid(GuestState *from, GuestState *to,
     migrate_set_capability(from->qs, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(from);
 
     do_migrate(from, to, uri);
 
@@ -2081,7 +2090,7 @@ static void test_migrate_auto_converge(void)
     migrate_set_capability(from->qs, "pause-before-switchover", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(from);
 
     do_migrate(from, to, uri);
 
@@ -2114,7 +2123,7 @@ static void test_migrate_auto_converge(void)
 
     qtest_qmp_eventwait(to->qs, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(to);
     wait_for_migration_complete(from->qs);
 
     test_migrate_end(from, to, true);
@@ -2411,7 +2420,7 @@ static void test_multifd_tcp_cancel(void)
                              "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(from);
 
     do_migrate(from, to, "127.0.0.1:0");
 
@@ -2450,7 +2459,7 @@ static void test_multifd_tcp_cancel(void)
     }
     qtest_qmp_eventwait(to2->qs, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(to2);
     wait_for_migration_complete(from->qs);
     test_migrate_end(from, to2, true);
 }
@@ -2595,9 +2604,10 @@ static GuestState *dirtylimit_start_vm(void)
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
-                          "-serial file:%s/vm_serial "
+                          "-serial file:%s "
                           "-drive file=%s,format=raw ",
-                          tmpfs, bootpath);
+                          vm->serial_path,
+                          bootpath);
 
     vm->qs = qtest_init(cmd);
     return vm;
@@ -2606,7 +2616,6 @@ static GuestState *dirtylimit_start_vm(void)
 static void dirtylimit_stop_vm(GuestState *vm)
 {
     guest_destroy(vm);
-    cleanup("vm_serial");
 }
 
 static void test_vcpu_dirty_limit(void)
@@ -2621,7 +2630,7 @@ static void test_vcpu_dirty_limit(void)
     GuestState *vm = dirtylimit_start_vm();
 
     /* Wait for the first serial output from the vm*/
-    wait_for_serial("vm_serial");
+    wait_for_serial(vm);
 
     /* Do dirtyrate measurement with calc time equals 1s */
     calc_dirty_rate(vm->qs, 1);
-- 
2.40.1


