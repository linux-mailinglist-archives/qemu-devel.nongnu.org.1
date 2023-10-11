Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583547C5AB3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqdRf-0001Zo-VT; Wed, 11 Oct 2023 13:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqdRD-0001Ii-VS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqdRC-0006ci-BR
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697046961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/Ia+wknTFtXFM0YlGu3I5yrYzDAJ8TIDR+9DjqkzME=;
 b=bngiaEdHSnTEyxPIcHJuRBDlUv7wGd4vxlCQ9OwAC31KgVFlw753hMLYpuzCFQdtYBeBLc
 6qEGR6XU4axfbeCXowkLtYucSn6Jqc23w9GhJZgCJqA7m6Q01ecVyMmY5roj5g7X+MLqhZ
 eCJur/psI4L1+EXv+s+rFiNDsYGvSBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-FuQgTJuJMUyMd6oZX84n_Q-1; Wed, 11 Oct 2023 13:55:59 -0400
X-MC-Unique: FuQgTJuJMUyMd6oZX84n_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB432858281;
 Wed, 11 Oct 2023 17:55:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 254F7492B00;
 Wed, 11 Oct 2023 17:55:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com
Subject: [PATCH v3 08/13] range: Introduce range_inverse_array()
Date: Wed, 11 Oct 2023 19:52:24 +0200
Message-ID: <20231011175516.541374-9-eric.auger@redhat.com>
In-Reply-To: <20231011175516.541374-1-eric.auger@redhat.com>
References: <20231011175516.541374-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

This helper reverses a list of regions within a [low, high]
span, turning original regions into holes and original
holes into actual regions, covering the whole UINT64_MAX span.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- now operate on GList's. Fix the commit msg by mentionning
  low/high params

v1 -> v2:
- Move range_inverse_array description comment in the header
- Take low/high params
---
 include/qemu/range.h |  8 +++++++
 util/range.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index aa671da143..205e1da76d 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -225,4 +225,12 @@ int range_compare(Range *a, Range *b);
 
 GList *range_list_insert(GList *list, Range *data);
 
+/*
+ * Inverse an array of sorted ranges over the [low, high] span, ie.
+ * original ranges becomes holes in the newly allocated inv_ranges
+ */
+void range_inverse_array(GList *in_ranges,
+                         GList **out_ranges,
+                         uint64_t low, uint64_t high);
+
 #endif
diff --git a/util/range.c b/util/range.c
index 782cb8b21c..9605ccfcbe 100644
--- a/util/range.c
+++ b/util/range.c
@@ -66,3 +66,58 @@ GList *range_list_insert(GList *list, Range *data)
 
     return list;
 }
+
+static inline
+GList *append_new_range(GList *list, uint64_t lob, uint64_t upb)
+{
+    Range *new = g_new0(Range, 1);
+
+    range_set_bounds(new, lob, upb);
+    return g_list_append(list, new);
+}
+
+
+void range_inverse_array(GList *in, GList **rev,
+                         uint64_t low, uint64_t high)
+{
+    Range *r, *rn;
+    GList *l = in, *out = *rev;
+
+    for (l = in; l && range_upb(l->data) < low; l = l->next) {
+        continue;
+    }
+
+    if (!l) {
+        out = append_new_range(out, low, high);
+        goto exit;
+    }
+    r = (Range *)l->data;
+
+    /* first range lob is greater than min, insert a first range */
+    if (range_lob(r) > low) {
+        out = append_new_range(out, low, MIN(range_lob(r) - 1, high));
+    }
+
+    /* insert a range inbetween each original range until we reach high */
+    for (; l->next; l = l->next) {
+        r = (Range *)l->data;
+        rn = (Range *)l->next->data;
+        if (range_lob(r) >= high) {
+            goto exit;
+        }
+        if (range_compare(r, rn)) {
+            out = append_new_range(out, range_upb(r) + 1,
+                                   MIN(range_lob(rn) - 1, high));
+        }
+    }
+
+    /* last range */
+    r = (Range *)l->data;
+
+    /* last range upb is less than max, insert a last range */
+    if (range_upb(r) <  high) {
+        out = append_new_range(out, range_upb(r) + 1, high);
+    }
+exit:
+    *rev = out;
+}
-- 
2.41.0


