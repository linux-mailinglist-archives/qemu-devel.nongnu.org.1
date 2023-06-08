Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F2728B63
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSg-0003lG-Ho; Thu, 08 Jun 2023 18:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSe-0003dd-5v
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSc-00057k-9w
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/EOC/BzsmoJBdHcGAPixhJ+VEqlkAvngm2nxmR52Kg=;
 b=jROHfmmSNCxImNUs9+aSPBal2bmGmKo5IadyCrQ0iu1+wTrYNHbKDg2tRwV86AA66reRb6
 QlfKEcyY25wSGHTq7C0lK0e67oQOPNESQWOn2ePcs37GyZBK5PkdHATyvQ+WILzBevRqps
 9QBoxpu8F/53kpqkVXWn60DAfoozC04=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-a6f1a3EoPH2OyWtB0RW4yA-1; Thu, 08 Jun 2023 18:50:27 -0400
X-MC-Unique: a6f1a3EoPH2OyWtB0RW4yA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E602A59548;
 Thu,  8 Jun 2023 22:50:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88370515544;
 Thu,  8 Jun 2023 22:50:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 21/42] migration-test: Move common guest code to guest_create()
Date: Fri,  9 Jun 2023 00:49:22 +0200
Message-Id: <20230608224943.3877-22-quintela@redhat.com>
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
 tests/qtest/migration-test.c | 104 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a18b3ce1e2..9671c4c6e5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -40,8 +40,6 @@
 #include "linux/kvm.h"
 #endif
 
-unsigned start_address;
-unsigned end_address;
 static bool uffd_feature_thread_id;
 static bool got_src_stop;
 static bool got_dst_resume;
@@ -154,12 +152,50 @@ static void bootfile_delete(void)
 
 typedef struct {
     QTestState *qs;
+    /* options for source and target */
+    gchar *arch_opts;
+    gchar *arch_source;
+    gchar *arch_target;
+    const gchar *memory_size;
     const gchar *name;
+    unsigned start_address;
+    unsigned end_address;
 } GuestState;
 
 static GuestState *guest_create(const char *name)
 {
     GuestState *vm = g_new0(GuestState, 1);
+    const char *arch = qtest_get_arch();
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        vm->memory_size = "150M";
+        vm->arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
+        vm->start_address = X86_TEST_MEM_START;
+        vm->end_address = X86_TEST_MEM_END;
+    } else if (g_str_equal(arch, "s390x")) {
+        vm->memory_size = "128M";
+        vm->arch_opts = g_strdup_printf("-bios %s", bootpath);
+        vm->start_address = S390_TEST_MEM_START;
+        vm->end_address = S390_TEST_MEM_END;
+    } else if (strcmp(arch, "ppc64") == 0) {
+        vm->memory_size = "256M";
+        vm->start_address = PPC_TEST_MEM_START;
+        vm->end_address = PPC_TEST_MEM_END;
+        vm->arch_source = g_strdup_printf(
+            "-prom-env 'use-nvramrc?=true' -prom-env "
+            "'nvramrc=hex .\" _\" begin %x %x "
+            "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
+            "until'", vm->end_address, vm->start_address);
+        vm->arch_opts = g_strdup("-nodefaults -machine vsmt=8");
+    } else if (strcmp(arch, "aarch64") == 0) {
+        vm->memory_size = "150M";
+        vm->arch_opts = g_strdup_printf(
+            "-machine virt,gic-version=max -cpu max -kernel %s", bootpath);
+        vm->start_address = ARM_TEST_MEM_START;
+        vm->end_address = ARM_TEST_MEM_END;
+    } else {
+        g_assert_not_reached();
+    }
 
     vm->name = name;
 
@@ -169,6 +205,9 @@ static GuestState *guest_create(const char *name)
 static void guest_destroy(GuestState *vm)
 {
     qtest_quit(vm->qs);
+    g_free(vm->arch_opts);
+    g_free(vm->arch_source);
+    g_free(vm->arch_target);
     g_free(vm);
 }
 
@@ -307,10 +346,11 @@ static void check_guests_ram(GuestState *who)
     bool hit_edge = false;
     int bad = 0;
 
-    qtest_memread(who->qs, start_address, &first_byte, 1);
+    qtest_memread(who->qs, who->start_address, &first_byte, 1);
     last_byte = first_byte;
 
-    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
+    for (address = who->start_address + TEST_MEM_PAGE_SIZE;
+         address < who->end_address;
          address += TEST_MEM_PAGE_SIZE)
     {
         uint8_t b;
@@ -663,49 +703,15 @@ typedef struct {
 static void test_migrate_start(GuestState *from, GuestState *to,
                                const char *uri, MigrateStart *args)
 {
-    g_autofree gchar *arch_source = NULL;
-    g_autofree gchar *arch_target = NULL;
-    /* options for source and target */
-    g_autofree gchar *arch_opts = NULL;
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr = NULL;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
     const char *kvm_opts = NULL;
-    const char *arch = qtest_get_arch();
-    const char *memory_size;
 
     got_src_stop = false;
     got_dst_resume = false;
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        memory_size = "150M";
-        arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        start_address = X86_TEST_MEM_START;
-        end_address = X86_TEST_MEM_END;
-    } else if (g_str_equal(arch, "s390x")) {
-        memory_size = "128M";
-        arch_opts = g_strdup_printf("-bios %s", bootpath);
-        start_address = S390_TEST_MEM_START;
-        end_address = S390_TEST_MEM_END;
-    } else if (strcmp(arch, "ppc64") == 0) {
-        memory_size = "256M";
-        start_address = PPC_TEST_MEM_START;
-        end_address = PPC_TEST_MEM_END;
-        arch_source = g_strdup_printf("-prom-env 'use-nvramrc?=true' -prom-env "
-                                      "'nvramrc=hex .\" _\" begin %x %x "
-                                      "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                      "until'", end_address, start_address);
-        arch_opts = g_strdup("-nodefaults -machine vsmt=8");
-    } else if (strcmp(arch, "aarch64") == 0) {
-        memory_size = "150M";
-        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
-                                    "-kernel %s", bootpath);
-        start_address = ARM_TEST_MEM_START;
-        end_address = ARM_TEST_MEM_END;
-    } else {
-        g_assert_not_reached();
-    }
 
     if (!getenv("QTEST_LOG") && args->hide_stderr) {
 #ifndef _WIN32
@@ -724,7 +730,7 @@ static void test_migrate_start(GuestState *from, GuestState *to,
         shmem_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
             ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
+            from->memory_size, shmem_path);
     }
 
     if (args->use_dirty_ring) {
@@ -738,9 +744,9 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  from->name,
-                                 memory_size, tmpfs,
-                                 arch_opts ? arch_opts : "",
-                                 arch_source ? arch_source : "",
+                                 from->memory_size, tmpfs,
+                                 from->arch_opts ? from->arch_opts : "",
+                                 from->arch_source ? from->arch_source : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr ? ignore_stderr : "");
@@ -760,9 +766,9 @@ static void test_migrate_start(GuestState *from, GuestState *to,
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  to->name,
-                                 memory_size, tmpfs, uri,
-                                 arch_opts ? arch_opts : "",
-                                 arch_target ? arch_target : "",
+                                 to->memory_size, tmpfs, uri,
+                                 to->arch_opts ? to->arch_opts : "",
+                                 to->arch_target ? to->arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr ? ignore_stderr : "");
@@ -787,20 +793,20 @@ static void test_migrate_end(GuestState *from, GuestState *to, bool test_dest)
     guest_destroy(from);
 
     if (test_dest) {
-        qtest_memread(to->qs, start_address, &dest_byte_a, 1);
+        qtest_memread(to->qs, to->start_address, &dest_byte_a, 1);
 
         /* Destination still running, wait for a byte to change */
         do {
-            qtest_memread(to->qs, start_address, &dest_byte_b, 1);
+            qtest_memread(to->qs, to->start_address, &dest_byte_b, 1);
             usleep(1000 * 10);
         } while (dest_byte_a == dest_byte_b);
 
         qtest_qmp_assert_success(to->qs, "{ 'execute' : 'stop'}");
 
         /* With it stopped, check nothing changes */
-        qtest_memread(to->qs, start_address, &dest_byte_c, 1);
+        qtest_memread(to->qs, to->start_address, &dest_byte_c, 1);
         usleep(1000 * 200);
-        qtest_memread(to->qs, start_address, &dest_byte_d, 1);
+        qtest_memread(to->qs, to->start_address, &dest_byte_d, 1);
         g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
 
         check_guests_ram(to);
-- 
2.40.1


