Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC197912F3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4bf-0001Fw-El; Mon, 04 Sep 2023 04:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bW-00014E-J0
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bR-0006Mh-CV
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693814790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rxn5EDYXEwVoQRGNPIOql5tx6O0sQvV/pW4KSk35sJQ=;
 b=imRcH9jaN+GXUh5sUdRj/feV3OKY3vlo1xNfJTNq3Ope9D+190weONenIV+UE1SUnIOG2U
 9YiBZwLuKHewIzmRZ3UrmPf2+WKMpAeUJBjcN9iINjvLBReUVhBUNtQEQiwhcAsGkT48v0
 5rmQQ45jAAyqLgok3xLDSIrG3ILT1iQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-ebzfLZf2MpGK1cW64yG4oQ-1; Mon, 04 Sep 2023 04:05:24 -0400
X-MC-Unique: ebzfLZf2MpGK1cW64yG4oQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51303C1936C;
 Mon,  4 Sep 2023 08:05:23 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F4B400D277;
 Mon,  4 Sep 2023 08:05:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 09/13] util/reserved-region: Add new ReservedRegion helpers
Date: Mon,  4 Sep 2023 10:03:52 +0200
Message-ID: <20230904080451.424731-10-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce resv_region_list_insert() helper which inserts
a new ReservedRegion into a sorted list of reserved region.
In case of overlap, the new region has higher priority and
hides the existing overlapped segments. If the overlap is
partial, new regions are created for parts which are not
overlapped. The new region has higher priority independently
on the type of the regions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/qemu/reserved-region.h | 32 ++++++++++++
 util/reserved-region.c         | 94 ++++++++++++++++++++++++++++++++++
 util/meson.build               |  1 +
 3 files changed, 127 insertions(+)
 create mode 100644 include/qemu/reserved-region.h
 create mode 100644 util/reserved-region.c

diff --git a/include/qemu/reserved-region.h b/include/qemu/reserved-region.h
new file mode 100644
index 0000000000..8e6f0a97e2
--- /dev/null
+++ b/include/qemu/reserved-region.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU ReservedRegion helpers
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_RESERVED_REGION_H
+#define QEMU_RESERVED_REGION_H
+
+#include "exec/memory.h"
+
+/*
+ * Insert a new region into a sorted list of reserved regions. In case
+ * there is overlap with existing regions, the new added region has
+ * higher priority and replaces the overlapped segment.
+ */
+GList *resv_region_list_insert(GList *list, ReservedRegion *reg);
+
+#endif
diff --git a/util/reserved-region.c b/util/reserved-region.c
new file mode 100644
index 0000000000..bb26a6bed3
--- /dev/null
+++ b/util/reserved-region.c
@@ -0,0 +1,94 @@
+/*
+ * QEMU ReservedRegion helpers
+ *
+ * Copyright (c) 2023 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "qemu/reserved-region.h"
+
+GList *resv_region_list_insert(GList *list, ReservedRegion *reg)
+{
+    ReservedRegion *resv_iter, *new_reg;
+    Range *r = &reg->range;
+    Range *range_iter;
+    GList *l;
+
+    for (l = list; l ; ) {
+        resv_iter = (ReservedRegion *)l->data;
+        range_iter = &resv_iter->range;
+
+        /* Skip all list elements strictly less than range to add */
+        if (range_compare(range_iter, r) < 0) {
+            l = l->next;
+        } else if (range_compare(range_iter, r) > 0) {
+            return g_list_insert_before(list, l, reg);
+        } else { /* there is an operlap */
+            if (range_contains_range(r, range_iter)) {
+                /* new range contains current item, simply remove this latter */
+                GList *prev = l->prev;
+                g_free(l->data);
+                list = g_list_delete_link(list, l);
+                if (prev) {
+                    l = prev;
+                    if (l) {
+                        l = l->next;
+                    }
+                } else {
+                    l = list;
+                }
+            } else if (range_contains_range(range_iter, r)) {
+                /* new region is included in the current region */
+                if (range_lob(range_iter) == range_lob(r)) {
+                    /* adjacent on the left side, derives into 2 regions */
+                    range_set_bounds(range_iter, range_upb(r) + 1,
+                                     range_upb(range_iter));
+                    return g_list_insert_before(list, l, reg);
+                } else if (range_upb(range_iter) == range_upb(r)) {
+                    /* adjacent on the right side, derives into 2 regions */
+                    range_set_bounds(range_iter, range_lob(range_iter),
+                                     range_lob(r) - 1);
+                    l = l->next;
+                } else {
+                    uint64_t lob = range_lob(range_iter);
+                    /*
+                     * the new range is in the middle of an existing one,
+                     * split this latter into 3 regs instead
+                     */
+                    range_set_bounds(range_iter, range_upb(r) + 1,
+                                     range_upb(range_iter));
+                    new_reg = g_new0(ReservedRegion, 1);
+                    new_reg->type = resv_iter->type;
+                    range_set_bounds(&new_reg->range,
+                                     lob, range_lob(r) - 1);
+                    list = g_list_insert_before(list, l, new_reg);
+                    return g_list_insert_before(list, l, reg);
+                }
+            } else if (range_lob(r) < range_lob(range_iter)) {
+                range_set_bounds(range_iter, range_upb(r) + 1,
+                                 range_upb(range_iter));
+                return g_list_insert_before(list, l, reg);
+            } else { /* intersection on the upper range */
+                range_set_bounds(range_iter, range_lob(range_iter),
+                                 range_lob(r) - 1);
+                l = l->next;
+            }
+        } /* overlap */
+    }
+    return g_list_append(list, reg);
+}
+
diff --git a/util/meson.build b/util/meson.build
index a375160286..7e85889606 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -52,6 +52,7 @@ util_ss.add(files('qdist.c'))
 util_ss.add(files('qht.c'))
 util_ss.add(files('qsp.c'))
 util_ss.add(files('range.c'))
+util_ss.add(files('reserved-region.c'))
 util_ss.add(files('stats64.c'))
 util_ss.add(files('systemd.c'))
 util_ss.add(files('transactions.c'))
-- 
2.41.0


