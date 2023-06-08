Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F71728B69
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTu-0006S4-Ve; Thu, 08 Jun 2023 18:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTW-0006PS-8n
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTT-0005RM-98
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Onx7hzdOZamKcksqH2V8dm73ESIZxV7rvSGJ9zpS7p4=;
 b=dDeyaryKODFAmqNT2CX/yj25un6ucKj2Jhn6Vyos53/TbqaDF7A/qTWeHxdNFjVQ5m4qki
 TOvihBCVqe7wDc1eA90coOGBYx9k+YjpH3H/H4z4AqYfDwO6z0wIiUjwhMhQwL2lhjsME8
 TCm8XwHyc4I0h0b1VMTZ5ciShL6P7Vs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-Kc1SHNGwNB2VoRpyvP-Zqg-1; Thu, 08 Jun 2023 18:51:19 -0400
X-MC-Unique: Kc1SHNGwNB2VoRpyvP-Zqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E77DD802355;
 Thu,  8 Jun 2023 22:51:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2258E492B00;
 Thu,  8 Jun 2023 22:51:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 41/42] migration-test: Move functions to migration-helpers.c
Date: Fri,  9 Jun 2023 00:49:42 +0200
Message-Id: <20230608224943.3877-42-quintela@redhat.com>
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

This will help on next patch to split vcpu-dirty-limit-test.c

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-helpers.h |  39 +++++
 tests/qtest/migration-helpers.c | 242 +++++++++++++++++++++++++++++
 tests/qtest/migration-test.c    | 260 --------------------------------
 3 files changed, 281 insertions(+), 260 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 009e250e90..6096ffd82a 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -15,6 +15,8 @@
 
 #include "libqtest.h"
 
+extern char *tmpfs;
+
 bool migrate_watch_for_stop(QTestState *who, const char *name,
                             QDict *event, void *opaque);
 bool migrate_watch_for_resume(QTestState *who, const char *name,
@@ -33,4 +35,41 @@ void wait_for_migration_complete(QTestState *who);
 
 void wait_for_migration_fail(QTestState *from, bool allow_active);
 
+typedef struct {
+    QTestState *qs;
+    /* options for source and target */
+    gchar *arch_opts;
+    gchar *arch_source;
+    gchar *arch_target;
+    const gchar *extra_opts;
+    const gchar *hide_stderr;
+    gchar *kvm_opts;
+    const gchar *memory_size;
+    /*
+     * name must *not* contain "target" if it is the target of a
+     * migration.
+     */
+    const gchar *name;
+    gchar *serial_path;
+    gchar *shmem_opts;
+    gchar *shmem_path;
+    gchar *unix_socket;
+    gchar *uri;
+    unsigned start_address;
+    unsigned end_address;
+    bool got_event;
+} GuestState;
+
+GuestState *guest_create(const char *name);
+void guest_destroy(GuestState *vm);
+void guest_realize(GuestState *who);
+void guest_use_dirty_ring(GuestState *vm);
+
+void wait_for_serial(GuestState *vm);
+
+void bootfile_create(char *dir);
+void bootfile_delete(void);
+
+bool kvm_dirty_ring_supported(void);
+
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index be00c52d00..ffdc689a88 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,8 +13,23 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/qjson.h"
 
+#include "tests/migration/migration-test.h"
 #include "migration-helpers.h"
 
+#if defined(__linux__)
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <sys/vfs.h>
+#endif
+
+/* For dirty ring test; so far only x86_64 is supported */
+#if defined(__linux__) && defined(HOST_X86_64)
+#include "linux/kvm.h"
+#endif
+
+char *tmpfs;
+static char *bootpath;
+
 /*
  * Number of seconds we wait when looking for migration
  * status changes, to avoid test suite hanging forever
@@ -180,3 +195,230 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     g_assert(qdict_get_bool(rsp_return, "running"));
     qobject_unref(rsp_return);
 }
+
+/* The boot file modifies memory area in [start_address, end_address)
+ * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
+ */
+#include "tests/migration/i386/a-b-bootblock.h"
+#include "tests/migration/aarch64/a-b-kernel.h"
+#include "tests/migration/s390x/a-b-bios.h"
+
+void bootfile_create(char *dir)
+{
+    const char *arch = qtest_get_arch();
+    unsigned char *content;
+    size_t len;
+
+    bootpath = g_strdup_printf("%s/bootsect", dir);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        /* the assembled x86 boot sector should be exactly one sector large */
+        g_assert(sizeof(x86_bootsect) == 512);
+        content = x86_bootsect;
+        len = sizeof(x86_bootsect);
+    } else if (g_str_equal(arch, "s390x")) {
+        content = s390x_elf;
+        len = sizeof(s390x_elf);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        /*
+         * sane architectures can be programmed at the boot prompt
+         */
+        return;
+    } else if (strcmp(arch, "aarch64") == 0) {
+        content = aarch64_kernel;
+        len = sizeof(aarch64_kernel);
+        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else {
+        g_assert_not_reached();
+    }
+
+    FILE *bootfile = fopen(bootpath, "wb");
+
+    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
+    fclose(bootfile);
+}
+
+void bootfile_delete(void)
+{
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
+GuestState *guest_create(const char *name)
+{
+    GuestState *vm = g_new0(GuestState, 1);
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
+
+    vm->name = name;
+    vm->serial_path = g_strdup_printf("%s/%s", tmpfs, vm->name);
+    return vm;
+}
+
+void guest_destroy(GuestState *vm)
+{
+    qtest_quit(vm->qs);
+    g_free(vm->arch_opts);
+    g_free(vm->arch_source);
+    g_free(vm->arch_target);
+    g_free(vm->kvm_opts);
+    unlink(vm->serial_path);
+    g_free(vm->serial_path);
+    g_free(vm->shmem_opts);
+    unlink(vm->shmem_path);
+    g_free(vm->shmem_path);
+    if (vm->unix_socket) {
+        unlink(vm->unix_socket);
+        g_free(vm->unix_socket);
+    }
+    g_free(vm->uri);
+    g_free(vm);
+}
+
+void guest_realize(GuestState *who)
+{
+    bool target = false;
+    if (strncmp(who->name, "target", strlen("target")) == 0) {
+        target = true;
+    }
+    gchar *
+    cmd = g_strdup_printf("-accel kvm%s -accel tcg "
+                          "-name %s,debug-threads=on "
+                          "-m %s "
+                          "-serial file:%s "
+                          "%s %s "
+                          "%s %s %s %s %s",
+                          who->kvm_opts ? who->kvm_opts : "",
+                          who->name,
+                          who->memory_size,
+                          who->serial_path,
+                          target ? "-incoming" : "",
+                          target ? who->uri ? who->uri : "defer"
+                                 : "",
+                          who->arch_opts ? who->arch_opts : "",
+                          target ? who->arch_target ? who->arch_target : ""
+                                 : who->arch_source ? who->arch_source : "",
+                          who->shmem_opts ? who->shmem_opts : "",
+                          who->extra_opts ? who->extra_opts : "",
+                          who->hide_stderr ? who->hide_stderr : "");
+    who->qs = qtest_init(cmd);
+    qtest_qmp_set_event_callback(who->qs,
+                                 target ? migrate_watch_for_resume
+                                        : migrate_watch_for_stop,
+                                 &who->got_event);
+}
+
+void guest_use_dirty_ring(GuestState *vm)
+{
+    g_assert(vm->kvm_opts == NULL);
+    vm->kvm_opts = g_strdup(",dirty-ring-size=4096");
+}
+
+/*
+ * Wait for some output in the serial output file,
+ * we get an 'A' followed by an endless string of 'B's
+ * but on the destination we won't have the A.
+ */
+void wait_for_serial(GuestState *vm)
+{
+    FILE *serialfile = fopen(vm->serial_path, "r");
+    const char *arch = qtest_get_arch();
+    /* see serial_path comment on GuestState definition */
+    int started = (strstr(vm->serial_path, "target") == NULL &&
+                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
+
+    do {
+        int readvalue = fgetc(serialfile);
+
+        if (!started) {
+            /* SLOF prints its banner before starting test,
+             * to ignore it, mark the start of the test with '_',
+             * ignore all characters until this marker
+             */
+            switch (readvalue) {
+            case '_':
+                started = 1;
+                break;
+            case EOF:
+                fseek(serialfile, 0, SEEK_SET);
+                usleep(1000);
+                break;
+            }
+            continue;
+        }
+        switch (readvalue) {
+        case 'A':
+            /* Fine */
+            break;
+
+        case 'B':
+            /* It's alive! */
+            fclose(serialfile);
+            return;
+
+        case EOF:
+            started = (strstr(vm->serial_path, "target") == NULL &&
+                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
+            fseek(serialfile, 0, SEEK_SET);
+            usleep(1000);
+            break;
+
+        default:
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue,
+                    vm->serial_path);
+            g_assert_not_reached();
+        }
+    } while (true);
+}
+
+bool kvm_dirty_ring_supported(void)
+{
+#if defined(__linux__) && defined(HOST_X86_64)
+    int ret, kvm_fd = open("/dev/kvm", O_RDONLY);
+
+    if (kvm_fd < 0) {
+        return false;
+    }
+
+    ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_DIRTY_LOG_RING);
+    close(kvm_fd);
+
+    /* We test with 4096 slots */
+    if (ret < 4096) {
+        return false;
+    }
+
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d8479abb4a..4d3321b7b3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -35,11 +35,6 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-/* For dirty ring test; so far only x86_64 is supported */
-#if defined(__linux__) && defined(HOST_X86_64)
-#include "linux/kvm.h"
-#endif
-
 static bool uffd_feature_thread_id;
 
 /*
@@ -97,181 +92,6 @@ static bool ufd_version_check(void)
 
 #endif
 
-static char *tmpfs;
-static char *bootpath;
-
-/* The boot file modifies memory area in [start_address, end_address)
- * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
- */
-#include "tests/migration/i386/a-b-bootblock.h"
-#include "tests/migration/aarch64/a-b-kernel.h"
-#include "tests/migration/s390x/a-b-bios.h"
-
-static void bootfile_create(char *dir)
-{
-    const char *arch = qtest_get_arch();
-    unsigned char *content;
-    size_t len;
-
-    bootpath = g_strdup_printf("%s/bootsect", dir);
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        /* the assembled x86 boot sector should be exactly one sector large */
-        g_assert(sizeof(x86_bootsect) == 512);
-        content = x86_bootsect;
-        len = sizeof(x86_bootsect);
-    } else if (g_str_equal(arch, "s390x")) {
-        content = s390x_elf;
-        len = sizeof(s390x_elf);
-    } else if (strcmp(arch, "ppc64") == 0) {
-        /*
-         * sane architectures can be programmed at the boot prompt
-         */
-        return;
-    } else if (strcmp(arch, "aarch64") == 0) {
-        content = aarch64_kernel;
-        len = sizeof(aarch64_kernel);
-        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
-    } else {
-        g_assert_not_reached();
-    }
-
-    FILE *bootfile = fopen(bootpath, "wb");
-
-    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
-    fclose(bootfile);
-}
-
-static void bootfile_delete(void)
-{
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
-typedef struct {
-    QTestState *qs;
-    /* options for source and target */
-    gchar *arch_opts;
-    gchar *arch_source;
-    gchar *arch_target;
-    const gchar *extra_opts;
-    const gchar *hide_stderr;
-    gchar *kvm_opts;
-    const gchar *memory_size;
-    /*
-     * name must *not* contain "target" if it is the target of a
-     * migration.
-     */
-    const gchar *name;
-    gchar *serial_path;
-    gchar *shmem_opts;
-    gchar *shmem_path;
-    gchar *unix_socket;
-    gchar *uri;
-    unsigned start_address;
-    unsigned end_address;
-    bool got_event;
-} GuestState;
-
-static GuestState *guest_create(const char *name)
-{
-    GuestState *vm = g_new0(GuestState, 1);
-    const char *arch = qtest_get_arch();
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        vm->memory_size = "150M";
-        vm->arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        vm->start_address = X86_TEST_MEM_START;
-        vm->end_address = X86_TEST_MEM_END;
-    } else if (g_str_equal(arch, "s390x")) {
-        vm->memory_size = "128M";
-        vm->arch_opts = g_strdup_printf("-bios %s", bootpath);
-        vm->start_address = S390_TEST_MEM_START;
-        vm->end_address = S390_TEST_MEM_END;
-    } else if (strcmp(arch, "ppc64") == 0) {
-        vm->memory_size = "256M";
-        vm->start_address = PPC_TEST_MEM_START;
-        vm->end_address = PPC_TEST_MEM_END;
-        vm->arch_source = g_strdup_printf(
-            "-prom-env 'use-nvramrc?=true' -prom-env "
-            "'nvramrc=hex .\" _\" begin %x %x "
-            "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-            "until'", vm->end_address, vm->start_address);
-        vm->arch_opts = g_strdup("-nodefaults -machine vsmt=8");
-    } else if (strcmp(arch, "aarch64") == 0) {
-        vm->memory_size = "150M";
-        vm->arch_opts = g_strdup_printf(
-            "-machine virt,gic-version=max -cpu max -kernel %s", bootpath);
-        vm->start_address = ARM_TEST_MEM_START;
-        vm->end_address = ARM_TEST_MEM_END;
-    } else {
-        g_assert_not_reached();
-    }
-
-    vm->name = name;
-    vm->serial_path = g_strdup_printf("%s/%s", tmpfs, vm->name);
-    return vm;
-}
-
-static void guest_destroy(GuestState *vm)
-{
-    qtest_quit(vm->qs);
-    g_free(vm->arch_opts);
-    g_free(vm->arch_source);
-    g_free(vm->arch_target);
-    g_free(vm->kvm_opts);
-    unlink(vm->serial_path);
-    g_free(vm->serial_path);
-    g_free(vm->shmem_opts);
-    unlink(vm->shmem_path);
-    g_free(vm->shmem_path);
-    if (vm->unix_socket) {
-        unlink(vm->unix_socket);
-        g_free(vm->unix_socket);
-    }
-    g_free(vm->uri);
-    g_free(vm);
-}
-
-static void guest_realize(GuestState *who)
-{
-    bool target = false;
-    if (strncmp(who->name, "target", strlen("target")) == 0) {
-        target = true;
-    }
-    gchar *
-    cmd = g_strdup_printf("-accel kvm%s -accel tcg "
-                          "-name %s,debug-threads=on "
-                          "-m %s "
-                          "-serial file:%s "
-                          "%s %s "
-                          "%s %s %s %s %s",
-                          who->kvm_opts ? who->kvm_opts : "",
-                          who->name,
-                          who->memory_size,
-                          who->serial_path,
-                          target ? "-incoming" : "",
-                          target ? who->uri ? who->uri : "defer"
-                                 : "",
-                          who->arch_opts ? who->arch_opts : "",
-                          target ? who->arch_target ? who->arch_target : ""
-                                 : who->arch_source ? who->arch_source : "",
-                          who->shmem_opts ? who->shmem_opts : "",
-                          who->extra_opts ? who->extra_opts : "",
-                          who->hide_stderr ? who->hide_stderr : "");
-    who->qs = qtest_init(cmd);
-    qtest_qmp_set_event_callback(who->qs,
-                                 target ? migrate_watch_for_resume
-                                        : migrate_watch_for_stop,
-                                 &who->got_event);
-}
-
-static void guest_use_dirty_ring(GuestState *vm)
-{
-    g_assert(vm->kvm_opts == NULL);
-    vm->kvm_opts = g_strdup(",dirty-ring-size=4096");
-}
-
 static void guest_use_shmem(GuestState *vm)
 {
     g_assert(vm->shmem_opts == NULL);
@@ -324,63 +144,6 @@ static void guest_set_uri(GuestState *vm, const gchar *uri)
     vm->uri = g_strdup(uri);
 }
 
-/*
- * Wait for some output in the serial output file,
- * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A.
- */
-static void wait_for_serial(GuestState *vm)
-{
-    FILE *serialfile = fopen(vm->serial_path, "r");
-    const char *arch = qtest_get_arch();
-    /* see serial_path comment on GuestState definition */
-    int started = (strstr(vm->serial_path, "target") == NULL &&
-                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
-
-    do {
-        int readvalue = fgetc(serialfile);
-
-        if (!started) {
-            /* SLOF prints its banner before starting test,
-             * to ignore it, mark the start of the test with '_',
-             * ignore all characters until this marker
-             */
-            switch (readvalue) {
-            case '_':
-                started = 1;
-                break;
-            case EOF:
-                fseek(serialfile, 0, SEEK_SET);
-                usleep(1000);
-                break;
-            }
-            continue;
-        }
-        switch (readvalue) {
-        case 'A':
-            /* Fine */
-            break;
-
-        case 'B':
-            /* It's alive! */
-            fclose(serialfile);
-            return;
-
-        case EOF:
-            started = (strstr(vm->serial_path, "target") == NULL &&
-                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
-            fseek(serialfile, 0, SEEK_SET);
-            usleep(1000);
-            break;
-
-        default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue,
-                    vm->serial_path);
-            g_assert_not_reached();
-        }
-    } while (true);
-}
-
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -2615,29 +2378,6 @@ static void test_vcpu_dirty_limit(void)
     dirtylimit_stop_vm(vm);
 }
 
-static bool kvm_dirty_ring_supported(void)
-{
-#if defined(__linux__) && defined(HOST_X86_64)
-    int ret, kvm_fd = open("/dev/kvm", O_RDONLY);
-
-    if (kvm_fd < 0) {
-        return false;
-    }
-
-    ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, KVM_CAP_DIRTY_LOG_RING);
-    close(kvm_fd);
-
-    /* We test with 4096 slots */
-    if (ret < 4096) {
-        return false;
-    }
-
-    return true;
-#else
-    return false;
-#endif
-}
-
 static bool shm_supported(void)
 {
     if (g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-- 
2.40.1


