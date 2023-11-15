Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38687E2722
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:38:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jT-0005I7-Am; Mon, 06 Nov 2023 09:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jS-0005HJ-03
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:38 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jP-0000vw-Jz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTT5LbYz4xkB;
 Tue,  7 Nov 2023 01:37:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTR5q22z4xk7;
 Tue,  7 Nov 2023 01:37:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/22] test: Add some tests for range and resv-mem helpers
Date: Mon,  6 Nov 2023 15:36:43 +0100
Message-ID: <20231106143653.302391-13-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Add unit tests for both resv_region_list_insert() and
range_inverse_array().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
[ clg: Removal of unused variable in compare_ranges() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/unit/test-resv-mem.c | 316 +++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build     |   1 +
 2 files changed, 317 insertions(+)
 create mode 100644 tests/unit/test-resv-mem.c

diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
new file mode 100644
index 0000000000000000000000000000000000000000..5963274e2c49729e2c959e18d7c92a94979641ec
--- /dev/null
+++ b/tests/unit/test-resv-mem.c
@@ -0,0 +1,316 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * reserved-region/range.c unit-tests.
+ *
+ * Copyright (C) 2023, Red Hat, Inc.
+ *
+ * Author: Eric Auger <eric.auger@redhat.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "exec/memory.h"
+#include "qemu/reserved-region.h"
+
+#define DEBUG 0
+
+#if DEBUG
+static void print_ranges(const char *prefix, GList *ranges)
+{
+    GList *l;
+    int i = 0;
+
+    if (!g_list_length(ranges)) {
+        printf("%s is void\n", prefix);
+        return;
+    }
+    for (l = ranges; l; l = l->next) {
+        Range *r = (Range *)l->data;
+
+        printf("%s rev[%i] = [0x%"PRIx64",0x%"PRIx64"]\n",
+               prefix, i, range_lob(r), range_upb(r));
+        i++;
+    }
+}
+#endif
+
+static void compare_ranges(const char *prefix, GList *ranges,
+                           GList *expected)
+{
+    GList *l, *e;
+
+#if DEBUG
+    print_ranges("out", ranges);
+    print_ranges("expected", expected);
+#endif
+    g_assert_cmpint(g_list_length(ranges), ==, g_list_length(expected));
+    for (l = ranges, e = expected; l ; l = l->next, e = e->next) {
+        Range *r = (Range *)l->data;
+        Range *er = (Range *)e->data;
+
+        g_assert_true(range_lob(r) == range_lob(er) &&
+                      range_upb(r) == range_upb(er));
+    }
+}
+
+static GList *insert_sorted_range(GList *list, uint64_t lob, uint64_t upb)
+{
+    Range *new = g_new0(Range, 1);
+
+    range_set_bounds(new, lob, upb);
+    return range_list_insert(list, new);
+}
+
+static void reset(GList **in, GList **out, GList **expected)
+{
+    g_list_free_full(*in, g_free);
+    g_list_free_full(*out, g_free);
+    g_list_free_full(*expected, g_free);
+    *in = NULL;
+    *out = NULL;
+    *expected = NULL;
+}
+
+static void
+run_range_inverse_array(const char *prefix, GList **in, GList **expected,
+                        uint64_t low, uint64_t high)
+{
+    GList *out = NULL;
+    range_inverse_array(*in, &out, low, high);
+    compare_ranges(prefix, out, *expected);
+    reset(in, &out, expected);
+}
+
+static void check_range_reverse_array(void)
+{
+    GList *in = NULL, *expected = NULL;
+
+    /* test 1 */
+
+    in = insert_sorted_range(in, 0x10000, UINT64_MAX);
+    expected = insert_sorted_range(expected, 0x0, 0xFFFF);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+
+    /* test 2 */
+
+    in = insert_sorted_range(in, 0x10000, 0xFFFFFFFFFFFF);
+    expected = insert_sorted_range(expected, 0x0, 0xFFFF);
+    expected = insert_sorted_range(expected, 0x1000000000000, UINT64_MAX);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+
+    /* test 3 */
+
+    in = insert_sorted_range(in, 0x0, 0xFFFF);
+    in = insert_sorted_range(in, 0x10000, 0x2FFFF);
+    expected = insert_sorted_range(expected, 0x30000, UINT64_MAX);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+
+    /* test 4 */
+
+    in = insert_sorted_range(in, 0x50000, 0x5FFFF);
+    in = insert_sorted_range(in, 0x60000, 0xFFFFFFFFFFFF);
+    expected = insert_sorted_range(expected, 0x0, 0x4FFFF);
+    expected = insert_sorted_range(expected, 0x1000000000000, UINT64_MAX);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+
+    /* test 5 */
+
+    in = insert_sorted_range(in, 0x0, UINT64_MAX);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+
+    /* test 6 */
+    in = insert_sorted_range(in,  0x10000, 0x1FFFF);
+    in = insert_sorted_range(in,  0x30000, 0x6FFFF);
+    in = insert_sorted_range(in,  0x90000, UINT64_MAX);
+    expected = insert_sorted_range(expected, 0x0, 0xFFFF);
+    expected = insert_sorted_range(expected, 0x20000, 0x2FFFF);
+    expected = insert_sorted_range(expected, 0x70000, 0x8FFFF);
+    run_range_inverse_array("test1", &in, &expected, 0x0, UINT64_MAX);
+}
+
+static void check_range_reverse_array_low_end(void)
+{
+    GList *in = NULL, *expected = NULL;
+
+    /* test 1 */
+    in = insert_sorted_range(in,  0x0, UINT64_MAX);
+    run_range_inverse_array("test1", &in, &expected, 0x10000, 0xFFFFFF);
+
+    /* test 2 */
+
+    in = insert_sorted_range(in,  0x0, 0xFFFF);
+    in = insert_sorted_range(in,  0x20000, 0x2FFFF);
+    expected = insert_sorted_range(expected, 0x40000, 0xFFFFFFFFFFFF);
+    run_range_inverse_array("test2", &in, &expected, 0x40000, 0xFFFFFFFFFFFF);
+
+    /* test 3 */
+    in = insert_sorted_range(in,  0x0, 0xFFFF);
+    in = insert_sorted_range(in,  0x20000, 0x2FFFF);
+    in = insert_sorted_range(in,  0x1000000000000, UINT64_MAX);
+    expected = insert_sorted_range(expected, 0x40000, 0xFFFFFFFFFFFF);
+    run_range_inverse_array("test3", &in, &expected, 0x40000, 0xFFFFFFFFFFFF);
+
+    /* test 4 */
+
+    in = insert_sorted_range(in,  0x0, 0xFFFF);
+    in = insert_sorted_range(in,  0x20000, 0x2FFFF);
+    in = insert_sorted_range(in,  0x1000000000000, UINT64_MAX);
+    expected = insert_sorted_range(expected, 0x30000, 0xFFFFFFFFFFFF);
+    run_range_inverse_array("test4", &in, &expected, 0x20000, 0xFFFFFFFFFFFF);
+
+    /* test 5 */
+
+    in = insert_sorted_range(in,  0x2000, 0xFFFF);
+    in = insert_sorted_range(in,  0x20000, 0x2FFFF);
+    in = insert_sorted_range(in,  0x100000000, 0x1FFFFFFFF);
+    expected = insert_sorted_range(expected, 0x1000, 0x1FFF);
+    expected = insert_sorted_range(expected, 0x10000, 0x1FFFF);
+    expected = insert_sorted_range(expected, 0x30000, 0xFFFFFFFF);
+    expected = insert_sorted_range(expected, 0x200000000, 0xFFFFFFFFFFFF);
+    run_range_inverse_array("test5", &in, &expected, 0x1000, 0xFFFFFFFFFFFF);
+
+    /* test 6 */
+
+    in = insert_sorted_range(in,  0x10000000 , 0x1FFFFFFF);
+    in = insert_sorted_range(in,  0x100000000, 0x1FFFFFFFF);
+    expected = insert_sorted_range(expected, 0x0, 0xFFFF);
+    run_range_inverse_array("test6", &in, &expected, 0x0, 0xFFFF);
+}
+
+static ReservedRegion *alloc_resv_mem(unsigned type, uint64_t lob, uint64_t upb)
+{
+    ReservedRegion *r;
+
+    r = g_new0(ReservedRegion, 1);
+    r->type = type;
+    range_set_bounds(&r->range, lob, upb);
+    return r;
+}
+
+static void print_resv_region_list(const char *prefix, GList *list,
+                                   uint32_t expected_length)
+{
+    int i = g_list_length(list);
+
+    g_assert_cmpint(i, ==, expected_length);
+#if DEBUG
+    i = 0;
+    for (GList *l = list; l; l = l->next) {
+        ReservedRegion *r = (ReservedRegion *)l->data;
+        Range *range = &r->range;
+
+        printf("%s item[%d]=[0x%x, 0x%"PRIx64", 0x%"PRIx64"]\n",
+               prefix, i++, r->type, range_lob(range), range_upb(range));
+    }
+#endif
+}
+
+static void free_resv_region(gpointer data)
+{
+    ReservedRegion *reg = (ReservedRegion *)data;
+
+    g_free(reg);
+}
+
+static void check_resv_region_list_insert(void)
+{
+    ReservedRegion *r[10];
+    GList *l = NULL;
+
+    r[0] = alloc_resv_mem(0xA, 0, 0xFFFF);
+    r[1] = alloc_resv_mem(0xA, 0x20000, 0x2FFFF);
+    l = resv_region_list_insert(l, r[0]);
+    l = resv_region_list_insert(l, r[1]);
+    print_resv_region_list("test1", l, 2);
+
+    /* adjacent on left */
+    r[2] = alloc_resv_mem(0xB, 0x0, 0xFFF);
+    l = resv_region_list_insert(l, r[2]);
+    /* adjacent on right */
+    r[3] = alloc_resv_mem(0xC, 0x21000, 0x2FFFF);
+    l = resv_region_list_insert(l, r[3]);
+    print_resv_region_list("test2", l, 4);
+
+    /* exact overlap of D into C*/
+    r[4] = alloc_resv_mem(0xD, 0x21000, 0x2FFFF);
+    l = resv_region_list_insert(l, r[4]);
+    print_resv_region_list("test3", l, 4);
+
+    /* in the middle */
+    r[5] = alloc_resv_mem(0xE, 0x22000, 0x23FFF);
+    l = resv_region_list_insert(l, r[5]);
+    print_resv_region_list("test4", l, 6);
+
+    /* overwrites several existing ones */
+    r[6] = alloc_resv_mem(0xF, 0x10000, 0x2FFFF);
+    l = resv_region_list_insert(l, r[6]);
+    print_resv_region_list("test5", l, 3);
+
+    /* contiguous at the end */
+    r[7] = alloc_resv_mem(0x0, 0x30000, 0x40000);
+    l = resv_region_list_insert(l, r[7]);
+    print_resv_region_list("test6", l, 4);
+
+    g_list_free_full(l, free_resv_region);
+    l = NULL;
+
+    r[0] = alloc_resv_mem(0x0, 0x10000, 0x1FFFF);
+    l = resv_region_list_insert(l, r[0]);
+    /* insertion before the 1st item */
+    r[1] = alloc_resv_mem(0x1, 0x0, 0xFF);
+    l = resv_region_list_insert(l, r[1]);
+    print_resv_region_list("test8", l, 2);
+
+    /* collision on the left side */
+    r[2] = alloc_resv_mem(0xA, 0x1200, 0x11FFF);
+    l = resv_region_list_insert(l, r[2]);
+    print_resv_region_list("test9", l, 3);
+
+    /* collision on the right side */
+    r[3] = alloc_resv_mem(0xA, 0x1F000, 0x2FFFF);
+    l = resv_region_list_insert(l, r[3]);
+    print_resv_region_list("test10", l, 4);
+
+    /* override everything */
+    r[4] = alloc_resv_mem(0xF, 0x0, UINT64_MAX);
+    l = resv_region_list_insert(l, r[4]);
+    print_resv_region_list("test11", l, 1);
+
+    g_list_free_full(l, free_resv_region);
+    l = NULL;
+
+    r[0] = alloc_resv_mem(0xF, 0x1000000000000, UINT64_MAX);
+    l = resv_region_list_insert(l, r[0]);
+    print_resv_region_list("test12", l, 1);
+
+    r[1] = alloc_resv_mem(0xA, 0x0, 0xFFFFFFF);
+    l = resv_region_list_insert(l, r[1]);
+    print_resv_region_list("test12", l, 2);
+
+    r[2] = alloc_resv_mem(0xB, 0x100000000, 0x1FFFFFFFF);
+    l = resv_region_list_insert(l, r[2]);
+    print_resv_region_list("test12", l, 3);
+
+    r[3] = alloc_resv_mem(0x0, 0x010000000, 0x2FFFFFFFF);
+    l = resv_region_list_insert(l, r[3]);
+    print_resv_region_list("test12", l, 3);
+
+    g_list_free_full(l, free_resv_region);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/resv-mem/range_reverse_array",
+                    check_range_reverse_array);
+    g_test_add_func("/resv-mem/range_reverse_array_low_end",
+                    check_range_reverse_array_low_end);
+    g_test_add_func("/resv-mem/resv_region_list_insert",
+                    check_resv_region_list_insert);
+
+    g_test_run();
+
+    return 0;
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index f33ae64b8dc6fdb8202f7a16dfc499009e79188b..e6c51e7a867b6541454715b1d2c6b103f51b065a 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -21,6 +21,7 @@ tests = {
   'test-opts-visitor': [testqapi],
   'test-visitor-serialization': [testqapi],
   'test-bitmap': [],
+  'test-resv-mem': [],
   # all code tested by test-x86-cpuid is inside topology.h
   'test-x86-cpuid': [],
   'test-cutils': [],
-- 
2.41.0


