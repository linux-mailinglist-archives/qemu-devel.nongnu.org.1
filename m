Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600F7912FF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4bd-00018S-Db; Mon, 04 Sep 2023 04:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bV-00013S-La
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bR-0006Js-Bt
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693814781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Um6REkjCwNMOmEMDVW18psduw0V2ZAPmFC4IdpStheA=;
 b=Iox/4fZAPpBsJLMT2tvO4yrbqqDJXGY1io0sUDSUEP/4Xn0qdN+faN4idcKNml9DWW1Bzc
 zKcHW66f7uE7M56dh87Jkvc18RW7IASB7GpZx1MaVaYLuhOj72xswcIBAjegoJHpBYs1E5
 BBeaaaLHjommgPV3bIDLaHtYJgKVsPo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-RgijNkkRMfySp58HyT5o3Q-1; Mon, 04 Sep 2023 04:05:15 -0400
X-MC-Unique: RgijNkkRMfySp58HyT5o3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA5291E441D4;
 Mon,  4 Sep 2023 08:05:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEF1940ED412;
 Mon,  4 Sep 2023 08:05:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 06/13] range: Introduce range_inverse_array()
Date: Mon,  4 Sep 2023 10:03:49 +0200
Message-ID: <20230904080451.424731-7-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This helper reverses an array of regions, turning original
regions into holes and original holes into actual regions,
covering the whole UINT64_MAX span.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/qemu/range.h |  3 +++
 util/range.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 7e2b1cc447..fc1d3dabe6 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -219,4 +219,7 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
 
 GList *range_list_insert(GList *list, Range *data);
 
+void range_inverse_array(uint32_t nr_ranges, Range *ranges,
+                         uint32_t *nr_inv_ranges, Range **inv_ranges);
+
 #endif
diff --git a/util/range.c b/util/range.c
index 098d9d2dc0..11c4ff0b78 100644
--- a/util/range.c
+++ b/util/range.c
@@ -70,3 +70,38 @@ GList *range_list_insert(GList *list, Range *data)
 
     return list;
 }
+
+/*
+ * Inverse an array of sorted ranges over the UINT64_MAX span, ie.
+ * original ranges becomes holes in the newly allocated inv_ranges
+ */
+void range_inverse_array(uint32_t nr_ranges, Range *ranges,
+                         uint32_t *nr_inv_ranges, Range **inv_ranges)
+{
+    Range *resv;
+    int i = 0, j = 0;
+
+    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
+
+    /* first range lob is greater than 0, insert a first range */
+    if (range_lob(&ranges[0]) > 0) {
+        range_set_bounds(&resv[i++], 0,
+                         range_lob(&ranges[0]) - 1);
+    }
+
+    /* insert a range inbetween each original range */
+    for (; j < nr_ranges - 1; j++) {
+        if (range_compare(&ranges[j], &ranges[j + 1])) {
+            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
+                             range_lob(&ranges[j + 1]) - 1);
+        }
+    }
+    /* last range upb is less than UINT64_MAX, insert a last range */
+    if (range_upb(&ranges[nr_ranges - 1]) <  UINT64_MAX) {
+        range_set_bounds(&resv[i++],
+                          range_upb(&ranges[nr_ranges - 1]) + 1, UINT64_MAX);
+    }
+    *nr_inv_ranges = i;
+    resv = g_realloc(resv, i * sizeof(Range));
+    *inv_ranges = resv;
+}
-- 
2.41.0


