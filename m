Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E2728B74
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OTv-0006tb-Pr; Thu, 08 Jun 2023 18:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTe-0006Xh-R5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OTa-0005Sr-Cp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I49yc+YxU5BPDO2hrTM16dVAH3Ex2ds9hLfWn4wzWSU=;
 b=iD8ooKdPZODd9Gn3NHQawU7Uv7VPJWce/QjYM8EHkAHu9CNWpBge4uZGWg6jRhe+WqgMjw
 oHMnDwCWKMmPNpha4khnidSpnE/uPHc9tqcKvmma9YAhPz92cWcZf5qsLdpNfKUi1fNhJc
 4IfqQ0v70LvBPbxSn1TFknjqxky8GIA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-v6sCr4EGPpuZglW8_Q90_g-1; Thu, 08 Jun 2023 18:51:28 -0400
X-MC-Unique: v6sCr4EGPpuZglW8_Q90_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8ECB1C05122;
 Thu,  8 Jun 2023 22:51:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 395E848205E;
 Thu,  8 Jun 2023 22:51:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 42/42] migration-test: Split vcpu-dirty-limit-test
Date: Fri,  9 Jun 2023 00:49:43 +0200
Message-Id: <20230608224943.3877-43-quintela@redhat.com>
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

It is not really a migration test, it just happens that migration
infrastructure is useful to it.

Once there, put migration-helpers.* as maintained.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 MAINTAINERS                         |   3 +-
 tests/qtest/migration-test.c        | 246 ----------------------
 tests/qtest/vcpu-dirty-limit-test.c | 310 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   5 +-
 4 files changed, 316 insertions(+), 248 deletions(-)
 create mode 100644 tests/qtest/vcpu-dirty-limit-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 436b3f0afe..20de5ae8b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3176,7 +3176,8 @@ F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
-F: tests/qtest/migration-test.c
+F: tests/qtest/migration-*
+F: tests/qtest/vcpu-dirty-limit-test.c
 F: docs/devel/migration.rst
 F: qapi/migration.json
 F: tests/migration/
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4d3321b7b3..58bb829dcf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -14,17 +14,11 @@
 
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qemu/module.h"
 #include "qemu/option.h"
-#include "qemu/range.h"
 #include "qemu/sockets.h"
-#include "chardev/char.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-output-visitor.h"
 #include "crypto/tlscredspsk.h"
-#include "qapi/qmp/qlist.h"
 
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
@@ -37,12 +31,6 @@
 
 static bool uffd_feature_thread_id;
 
-/*
- * Dirtylimit stop working if dirty page rate error
- * value less than DIRTYLIMIT_TOLERANCE_RANGE
- */
-#define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
-
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -2146,238 +2134,6 @@ static void test_multifd_tcp_cancel(void)
     guest_destroy(to2);
 }
 
-static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'calc-dirty-rate',"
-                             "'arguments': { "
-                             "'calc-time': %" PRIu64 ","
-                             "'mode': 'dirty-ring' }}",
-                             calc_time);
-}
-
-static QDict *query_dirty_rate(QTestState *who)
-{
-    return qtest_qmp_assert_success_ref(who,
-                                        "{ 'execute': 'query-dirty-rate' }");
-}
-
-static void dirtylimit_set_all(QTestState *who, uint64_t dirtyrate)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'set-vcpu-dirty-limit',"
-                             "'arguments': { "
-                             "'dirty-rate': %" PRIu64 " } }",
-                             dirtyrate);
-}
-
-static void cancel_vcpu_dirty_limit(QTestState *who)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'cancel-vcpu-dirty-limit' }");
-}
-
-static QDict *query_vcpu_dirty_limit(QTestState *who)
-{
-    QDict *rsp;
-
-    rsp = qtest_qmp(who, "{ 'execute': 'query-vcpu-dirty-limit' }");
-    g_assert(!qdict_haskey(rsp, "error"));
-    g_assert(qdict_haskey(rsp, "return"));
-
-    return rsp;
-}
-
-static bool calc_dirtyrate_ready(QTestState *who)
-{
-    QDict *rsp_return;
-    gchar *status;
-
-    rsp_return = query_dirty_rate(who);
-    g_assert(rsp_return);
-
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
-    g_assert(status);
-
-    return g_strcmp0(status, "measuring");
-}
-
-static void wait_for_calc_dirtyrate_complete(QTestState *who,
-                                             int64_t time_s)
-{
-    int max_try_count = 10000;
-    usleep(time_s * 1000000);
-
-    while (!calc_dirtyrate_ready(who) && max_try_count--) {
-        usleep(1000);
-    }
-
-    /*
-     * Set the timeout with 10 s(max_try_count * 1000us),
-     * if dirtyrate measurement not complete, fail test.
-     */
-    g_assert_cmpint(max_try_count, !=, 0);
-}
-
-static int64_t get_dirty_rate(QTestState *who)
-{
-    QDict *rsp_return;
-    gchar *status;
-    QList *rates;
-    const QListEntry *entry;
-    QDict *rate;
-    int64_t dirtyrate;
-
-    rsp_return = query_dirty_rate(who);
-    g_assert(rsp_return);
-
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
-    g_assert(status);
-    g_assert_cmpstr(status, ==, "measured");
-
-    rates = qdict_get_qlist(rsp_return, "vcpu-dirty-rate");
-    g_assert(rates && !qlist_empty(rates));
-
-    entry = qlist_first(rates);
-    g_assert(entry);
-
-    rate = qobject_to(QDict, qlist_entry_obj(entry));
-    g_assert(rate);
-
-    dirtyrate = qdict_get_try_int(rate, "dirty-rate", -1);
-
-    qobject_unref(rsp_return);
-    return dirtyrate;
-}
-
-static int64_t get_limit_rate(QTestState *who)
-{
-    QDict *rsp_return;
-    QList *rates;
-    const QListEntry *entry;
-    QDict *rate;
-    int64_t dirtyrate;
-
-    rsp_return = query_vcpu_dirty_limit(who);
-    g_assert(rsp_return);
-
-    rates = qdict_get_qlist(rsp_return, "return");
-    g_assert(rates && !qlist_empty(rates));
-
-    entry = qlist_first(rates);
-    g_assert(entry);
-
-    rate = qobject_to(QDict, qlist_entry_obj(entry));
-    g_assert(rate);
-
-    dirtyrate = qdict_get_try_int(rate, "limit-rate", -1);
-
-    qobject_unref(rsp_return);
-    return dirtyrate;
-}
-
-static GuestState *dirtylimit_start_vm(void)
-{
-    GuestState *vm = guest_create("dirtylimit-test");
-
-    guest_use_dirty_ring(vm);
-    guest_realize(vm);
-
-    return vm;
-}
-
-static void dirtylimit_stop_vm(GuestState *vm)
-{
-    guest_destroy(vm);
-}
-
-static void test_vcpu_dirty_limit(void)
-{
-    int64_t origin_rate;
-    int64_t quota_rate;
-    int64_t rate ;
-    int max_try_count = 20;
-    int hit = 0;
-
-    /* Start vm for vcpu dirtylimit test */
-    GuestState *vm = dirtylimit_start_vm();
-
-    /* Wait for the first serial output from the vm*/
-    wait_for_serial(vm);
-
-    /* Do dirtyrate measurement with calc time equals 1s */
-    calc_dirty_rate(vm->qs, 1);
-
-    /* Sleep calc time and wait for calc dirtyrate complete */
-    wait_for_calc_dirtyrate_complete(vm->qs, 1);
-
-    /* Query original dirty page rate */
-    origin_rate = get_dirty_rate(vm->qs);
-
-    /* VM booted from bootsect should dirty memory steadily */
-    assert(origin_rate != 0);
-
-    /* Setup quota dirty page rate at half of origin */
-    quota_rate = origin_rate / 2;
-
-    /* Set dirtylimit */
-    dirtylimit_set_all(vm->qs, quota_rate);
-
-    /*
-     * Check if set-vcpu-dirty-limit and query-vcpu-dirty-limit
-     * works literally
-     */
-    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm->qs));
-
-    /* Sleep a bit to check if it take effect */
-    usleep(2000000);
-
-    /*
-     * Check if dirtylimit take effect realistically, set the
-     * timeout with 20 s(max_try_count * 1s), if dirtylimit
-     * doesn't take effect, fail test.
-     */
-    while (--max_try_count) {
-        calc_dirty_rate(vm->qs, 1);
-        wait_for_calc_dirtyrate_complete(vm->qs, 1);
-        rate = get_dirty_rate(vm->qs);
-
-        /*
-         * Assume hitting if current rate is less
-         * than quota rate (within accepting error)
-         */
-        if (rate < (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
-            hit = 1;
-            break;
-        }
-    }
-
-    g_assert_cmpint(hit, ==, 1);
-
-    hit = 0;
-    max_try_count = 20;
-
-    /* Check if dirtylimit cancellation take effect */
-    cancel_vcpu_dirty_limit(vm->qs);
-    while (--max_try_count) {
-        calc_dirty_rate(vm->qs, 1);
-        wait_for_calc_dirtyrate_complete(vm->qs, 1);
-        rate = get_dirty_rate(vm->qs);
-
-        /*
-         * Assume dirtylimit be canceled if current rate is
-         * greater than quota rate (within accepting error)
-         */
-        if (rate > (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
-            hit = 1;
-            break;
-        }
-    }
-
-    g_assert_cmpint(hit, ==, 1);
-    dirtylimit_stop_vm(vm);
-}
-
 static bool shm_supported(void)
 {
     if (g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -2566,8 +2322,6 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
         qtest_add_func("/migration/dirty_ring",
                        test_precopy_unix_dirty_ring);
-        qtest_add_func("/migration/vcpu_dirty_limit",
-                       test_vcpu_dirty_limit);
     }
 
     ret = g_test_run();
diff --git a/tests/qtest/vcpu-dirty-limit-test.c b/tests/qtest/vcpu-dirty-limit-test.c
new file mode 100644
index 0000000000..eebcf04509
--- /dev/null
+++ b/tests/qtest/vcpu-dirty-limit-test.c
@@ -0,0 +1,310 @@
+/*
+ * QTest testcase for vcpu-dirty-limit
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/module.h"
+#include "qapi/qmp/qlist.h"
+
+#include "migration-helpers.h"
+
+/* For dirty ring test */
+#if defined(__linux__) && defined(HOST_X86_64)
+#include "linux/kvm.h"
+#include <sys/ioctl.h>
+#endif
+
+/*
+ * Dirtylimit stop working if dirty page rate error
+ * value less than DIRTYLIMIT_TOLERANCE_RANGE
+ */
+#define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
+
+static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'calc-dirty-rate',"
+                             "'arguments': { "
+                             "'calc-time': %" PRIu64 ","
+                             "'mode': 'dirty-ring' }}",
+                             calc_time);
+}
+
+static QDict *query_dirty_rate(QTestState *who)
+{
+    return qtest_qmp_assert_success_ref(who,
+                                        "{ 'execute': 'query-dirty-rate' }");
+}
+
+static void dirtylimit_set_all(QTestState *who, uint64_t dirtyrate)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'set-vcpu-dirty-limit',"
+                             "'arguments': { "
+                             "'dirty-rate': %" PRIu64 " } }",
+                             dirtyrate);
+}
+
+static void cancel_vcpu_dirty_limit(QTestState *who)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'cancel-vcpu-dirty-limit' }");
+}
+
+static QDict *query_vcpu_dirty_limit(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who, "{ 'execute': 'query-vcpu-dirty-limit' }");
+    g_assert(!qdict_haskey(rsp, "error"));
+    g_assert(qdict_haskey(rsp, "return"));
+
+    return rsp;
+}
+
+static bool calc_dirtyrate_ready(QTestState *who)
+{
+    QDict *rsp_return;
+    gchar *status;
+
+    rsp_return = query_dirty_rate(who);
+    g_assert(rsp_return);
+
+    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    g_assert(status);
+
+    return g_strcmp0(status, "measuring");
+}
+
+static void wait_for_calc_dirtyrate_complete(QTestState *who,
+                                             int64_t time_s)
+{
+    int max_try_count = 10000;
+    usleep(time_s * 1000000);
+
+    while (!calc_dirtyrate_ready(who) && max_try_count--) {
+        usleep(1000);
+    }
+
+    /*
+     * Set the timeout with 10 s(max_try_count * 1000us),
+     * if dirtyrate measurement not complete, fail test.
+     */
+    g_assert_cmpint(max_try_count, !=, 0);
+}
+
+static int64_t get_dirty_rate(QTestState *who)
+{
+    QDict *rsp_return;
+    gchar *status;
+    QList *rates;
+    const QListEntry *entry;
+    QDict *rate;
+    int64_t dirtyrate;
+
+    rsp_return = query_dirty_rate(who);
+    g_assert(rsp_return);
+
+    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    g_assert(status);
+    g_assert_cmpstr(status, ==, "measured");
+
+    rates = qdict_get_qlist(rsp_return, "vcpu-dirty-rate");
+    g_assert(rates && !qlist_empty(rates));
+
+    entry = qlist_first(rates);
+    g_assert(entry);
+
+    rate = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(rate);
+
+    dirtyrate = qdict_get_try_int(rate, "dirty-rate", -1);
+
+    qobject_unref(rsp_return);
+    return dirtyrate;
+}
+
+static int64_t get_limit_rate(QTestState *who)
+{
+    QDict *rsp_return;
+    QList *rates;
+    const QListEntry *entry;
+    QDict *rate;
+    int64_t dirtyrate;
+
+    rsp_return = query_vcpu_dirty_limit(who);
+    g_assert(rsp_return);
+
+    rates = qdict_get_qlist(rsp_return, "return");
+    g_assert(rates && !qlist_empty(rates));
+
+    entry = qlist_first(rates);
+    g_assert(entry);
+
+    rate = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(rate);
+
+    dirtyrate = qdict_get_try_int(rate, "limit-rate", -1);
+
+    qobject_unref(rsp_return);
+    return dirtyrate;
+}
+
+static GuestState *dirtylimit_start_vm(void)
+{
+    GuestState *vm = guest_create("dirtylimit-test");
+
+    guest_use_dirty_ring(vm);
+    guest_realize(vm);
+
+    return vm;
+}
+
+static void dirtylimit_stop_vm(GuestState *vm)
+{
+    guest_destroy(vm);
+}
+
+static void test_vcpu_dirty_limit(void)
+{
+    int64_t origin_rate;
+    int64_t quota_rate;
+    int64_t rate ;
+    int max_try_count = 20;
+    int hit = 0;
+
+    /* Start vm for vcpu dirtylimit test */
+    GuestState *vm = dirtylimit_start_vm();
+
+    /* Wait for the first serial output from the vm*/
+    wait_for_serial(vm);
+
+    /* Do dirtyrate measurement with calc time equals 1s */
+    calc_dirty_rate(vm->qs, 1);
+
+    /* Sleep calc time and wait for calc dirtyrate complete */
+    wait_for_calc_dirtyrate_complete(vm->qs, 1);
+
+    /* Query original dirty page rate */
+    origin_rate = get_dirty_rate(vm->qs);
+
+    /* VM booted from bootsect should dirty memory steadily */
+    assert(origin_rate != 0);
+
+    /* Setup quota dirty page rate at half of origin */
+    quota_rate = origin_rate / 2;
+
+    /* Set dirtylimit */
+    dirtylimit_set_all(vm->qs, quota_rate);
+
+    /*
+     * Check if set-vcpu-dirty-limit and query-vcpu-dirty-limit
+     * works literally
+     */
+    g_assert_cmpint(quota_rate, ==, get_limit_rate(vm->qs));
+
+    /* Sleep a bit to check if it take effect */
+    usleep(2000000);
+
+    /*
+     * Check if dirtylimit take effect realistically, set the
+     * timeout with 20 s(max_try_count * 1s), if dirtylimit
+     * doesn't take effect, fail test.
+     */
+    while (--max_try_count) {
+        calc_dirty_rate(vm->qs, 1);
+        wait_for_calc_dirtyrate_complete(vm->qs, 1);
+        rate = get_dirty_rate(vm->qs);
+
+        /*
+         * Assume hitting if current rate is less
+         * than quota rate (within accepting error)
+         */
+        if (rate < (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
+            hit = 1;
+            break;
+        }
+    }
+
+    g_assert_cmpint(hit, ==, 1);
+
+    hit = 0;
+    max_try_count = 20;
+
+    /* Check if dirtylimit cancellation take effect */
+    cancel_vcpu_dirty_limit(vm->qs);
+    while (--max_try_count) {
+        calc_dirty_rate(vm->qs, 1);
+        wait_for_calc_dirtyrate_complete(vm->qs, 1);
+        rate = get_dirty_rate(vm->qs);
+
+        /*
+         * Assume dirtylimit be canceled if current rate is
+         * greater than quota rate (within accepting error)
+         */
+        if (rate > (quota_rate + DIRTYLIMIT_TOLERANCE_RANGE)) {
+            hit = 1;
+            break;
+        }
+    }
+
+    g_assert_cmpint(hit, ==, 1);
+    dirtylimit_stop_vm(vm);
+}
+
+int main(int argc, char **argv)
+{
+    g_autoptr(GError) err = NULL;
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_accel("kvm")) {
+        g_test_skip("No KVM or TCG accelerator available");
+        return 0;
+    }
+
+    if (!g_str_equal(qtest_get_arch(), "x86_64")) {
+        g_test_skip("Only x86_64 support available");
+        return 0;
+    }
+
+    if (!kvm_dirty_ring_supported()) {
+        g_test_skip("KVM dirty ring is not supported");
+        return 0;
+    }
+
+    tmpfs = g_dir_make_tmp("vcpu-dirty-limit-test-XXXXXX", &err);
+    if (!tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+    }
+    g_assert(tmpfs);
+    bootfile_create(tmpfs);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    qtest_add_func("/vcpu_dirty_limit/basic", test_vcpu_dirty_limit);
+
+    int ret = g_test_run();
+
+    g_assert_cmpint(ret, ==, 0);
+
+    bootfile_delete();
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s",
+                       tmpfs, strerror(errno));
+    }
+    g_free(tmpfs);
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5fa6833ad7..ed0d03e3d3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -9,6 +9,7 @@ slow_qtests = {
   'qos-test' : 60,
   'qom-test' : 300,
   'test-hmp' : 120,
+  'vcpu-dirty-limit' : 150,
 }
 
 qtests_generic = [
@@ -101,7 +102,8 @@ qtests_i386 = \
    'vmgenid-test',
    'migration-test',
    'test-x86-cpuid-compat',
-   'numa-test'
+   'numa-test',
+   'vcpu-dirty-limit-test',
   ]
 
 if dbus_display and targetos != 'windows'
@@ -315,6 +317,7 @@ qtests = {
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'vcpu-dirty-limit-test': migration_files,
 }
 
 if vnc.found()
-- 
2.40.1


