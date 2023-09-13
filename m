Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E879E180
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKs1-00019Q-N2; Wed, 13 Sep 2023 04:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrz-00018a-IC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrv-0004q4-16
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCybop2n1+y5gn/su2wbF3O17fb882BIyOUTQA5kyA0=;
 b=CFpt2Y//kT9SKDJQnUw7EZcuNt7u1EJN6DuvGuAjaRIFzAbO+x+1WZxZ/Itc/6GZBqGv/O
 pIENuqJQXnWcp8zDAhMOshHf/mDrWza+NsZ9VqNu/NREYYaVOorLKiurp3IpMynx5IyZHP
 mcjRgXX0+4E740A8fFkVqsMEneTCzZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-SKFihXE9Nm6MzCkLTf83bQ-1; Wed, 13 Sep 2023 04:04:59 -0400
X-MC-Unique: SKFihXE9Nm6MzCkLTf83bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38509101FAB3;
 Wed, 13 Sep 2023 08:04:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51062026D4B;
 Wed, 13 Sep 2023 08:04:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 11/12] test: Add some tests for range and resv-mem helpers
Date: Wed, 13 Sep 2023 10:01:46 +0200
Message-ID: <20230913080423.523953-12-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add unit tests for both resv_region_list_insert() and
range_inverse_array().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/unit/test-resv-mem.c | 251 +++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build     |   1 +
 2 files changed, 252 insertions(+)
 create mode 100644 tests/unit/test-resv-mem.c

diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
new file mode 100644
index 0000000000..8fc7dbf1dd
--- /dev/null
+++ b/tests/unit/test-resv-mem.c
@@ -0,0 +1,251 @@
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
+static void print_rev_array(const char *prefix, uint32_t nr_rev,
+                            Range *rev, uint32_t expected_nr_rev)
+{
+    g_assert_cmpint(nr_rev, ==, expected_nr_rev);
+#if DEBUG
+    printf("%s nr_rev=%d\n", prefix, nr_rev);
+    for (int i = 0; i < nr_rev; i++) {
+        printf("%s rev[%i] = [0x%"PRIx64",0x%"PRIx64"]\n",
+               prefix, i, range_lob(&rev[i]), range_upb(&rev[i]));
+    }
+#endif
+}
+
+static void check_range_reverse_array(void)
+{
+    Range r[10];
+    Range *rev;
+    uint32_t nr_rev;
+
+    range_set_bounds(&r[0], 0x10000, UINT64_MAX);
+    range_inverse_array(1, r, &nr_rev, &rev, 0, UINT64_MAX);
+    print_rev_array("test1", nr_rev, rev, 1);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x10000, 0xFFFFFFFFFFFF);
+    range_inverse_array(1, r, &nr_rev, &rev, 0, UINT64_MAX);
+    print_rev_array("test2", nr_rev, rev, 2);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x0, 0xFFFF);
+    range_set_bounds(&r[1], 0x10000, 0x2FFFF);
+    range_inverse_array(2, r, &nr_rev, &rev, 0, UINT64_MAX);
+    print_rev_array("test3", nr_rev, rev, 1);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x50000, 0x5FFFF);
+    range_set_bounds(&r[1], 0x60000, 0xFFFFFFFFFFFF);
+    range_inverse_array(2, r, &nr_rev, &rev, 0, UINT64_MAX);
+    print_rev_array("test4", nr_rev, rev, 2);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x0, UINT64_MAX);
+    range_inverse_array(1, r, &nr_rev, &rev, 0, UINT64_MAX);
+    print_rev_array("test5", nr_rev, rev, 0);
+    g_free(rev);
+}
+
+static void check_range_reverse_array_low_end(void)
+{
+    Range r[10];
+    Range *rev;
+    uint32_t nr_rev;
+
+    printf("%s\n", __func__);
+    range_set_bounds(&r[0], 0x0, UINT64_MAX);
+    range_inverse_array(1, r, &nr_rev, &rev, 0x10000, 0xFFFFFF);
+    print_rev_array("test1", nr_rev, rev, 0);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x0, 0xFFFF);
+    range_set_bounds(&r[1], 0x20000, 0x2FFFF);
+    range_inverse_array(2, r, &nr_rev, &rev, 0x40000, 0xFFFFFFFFFFFF);
+    print_rev_array("test2", nr_rev, rev, 1);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x0, 0xFFFF);
+    range_set_bounds(&r[1], 0x20000, 0x2FFFF);
+    range_set_bounds(&r[2], 0x1000000000000, UINT64_MAX);
+    range_inverse_array(3, r, &nr_rev, &rev, 0x40000, 0xFFFFFFFFFFFF);
+    print_rev_array("test3", nr_rev, rev, 1);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x0, 0xFFFF);
+    range_set_bounds(&r[1], 0x10000, 0x2FFFF);
+    range_set_bounds(&r[2], 0x100000000, 0x100000000FFFF);
+    range_inverse_array(3, r, &nr_rev, &rev, 0x20000, 0xFFFFFFFFFFFF);
+    print_rev_array("test4", nr_rev, rev, 1);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x2000, 0xFFFF);
+    range_set_bounds(&r[1], 0x20000, 0x2FFFF);
+    range_set_bounds(&r[2], 0x100000000, 0x1FFFFFFFF);
+    range_inverse_array(3, r, &nr_rev, &rev, 0x1000, 0xFFFFFFFFFFFF);
+    /*
+     * expects [0x1000, 0x2000] [0x10000, 0x1FFFF] [0x30000, 0xFFFFFFFF]
+     *         [0x200000000, 0xFFFFFFFFFFFF]
+     */
+    print_rev_array("test4", nr_rev, rev, 4);
+    g_free(rev);
+
+    range_set_bounds(&r[0], 0x10000000 , 0x1FFFFFFF);
+    range_set_bounds(&r[1], 0x100000000, 0x1FFFFFFFF);
+    range_inverse_array(2, r, &nr_rev, &rev, 0x0, 0xFFFF);
+    /* expects [0x0, 0xFFFF] */
+    print_rev_array("test5", nr_rev, rev, 1);
+    g_free(rev);
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
index 0299ef6906..3e196eda7b 100644
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


