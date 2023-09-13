Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2879E17E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrn-0000uC-55; Wed, 13 Sep 2023 04:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrk-0000tB-U1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKri-0004lU-Gb
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2lVeIef1hbTmeC1q70QMPD0uEK6J6II9o/yF0r+lHE=;
 b=VOUC5ZE74DkDx9JlO9mDJ4+8OUFjpp8THJdnP7s9pVdsfSf13deSRHHBagPDzZV/tsFi/Q
 Y1/P1NlkJbLjlivTvkG3uTgkW8ctCvAAfiFELoT16UsSDjlhtXBIDAVTOWK1x53mTR2fRF
 DAOaIKNvinejSoh5R2NWSW2+NAS9JO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-x8gOLFrtO-aAoSIRhyZSwA-1; Wed, 13 Sep 2023 04:04:46 -0400
X-MC-Unique: x8gOLFrtO-aAoSIRhyZSwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03036185A79C;
 Wed, 13 Sep 2023 08:04:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 994C82026D68;
 Wed, 13 Sep 2023 08:04:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 06/12] range: Introduce range_inverse_array()
Date: Wed, 13 Sep 2023 10:01:41 +0200
Message-ID: <20230913080423.523953-7-eric.auger@redhat.com>
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

v1 -> v2:
- Move range_inverse_array description comment in the header
- Take low/high params
---
 include/qemu/range.h |  8 ++++++++
 util/range.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 7e2b1cc447..2b59e3bf0c 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -219,4 +219,12 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
 
 GList *range_list_insert(GList *list, Range *data);
 
+/*
+ * Inverse an array of sorted ranges over the [low, high] span, ie.
+ * original ranges becomes holes in the newly allocated inv_ranges
+ */
+void range_inverse_array(uint32_t nr_ranges, Range *ranges,
+                         uint32_t *nr_inv_ranges, Range **inv_ranges,
+                         uint64_t low, uint64_t high);
+
 #endif
diff --git a/util/range.c b/util/range.c
index 098d9d2dc0..4baeb588cc 100644
--- a/util/range.c
+++ b/util/range.c
@@ -70,3 +70,48 @@ GList *range_list_insert(GList *list, Range *data)
 
     return list;
 }
+
+void range_inverse_array(uint32_t nr_ranges, Range *ranges,
+                         uint32_t *nr_inv_ranges, Range **inv_ranges,
+                         uint64_t low, uint64_t high)
+{
+    Range *resv;
+    int i = 0, j = 0;
+
+    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
+
+    for (; j < nr_ranges  && (range_upb(&ranges[j]) < low); j++) {
+        continue; /* skip all ranges below mon */
+    }
+
+    if (j == nr_ranges) {
+        range_set_bounds(&resv[i++], low, high);
+        goto realloc;
+    }
+
+    /* first range lob is greater than min, insert a first range */
+    if (range_lob(&ranges[j]) > low) {
+        range_set_bounds(&resv[i++], low,
+                         MIN(range_lob(&ranges[j]) - 1, high));
+    }
+
+    /* insert a range inbetween each original range until we reach max */
+    for (; j < nr_ranges - 1; j++) {
+        if (range_lob(&ranges[j]) >= high) {
+            goto realloc;
+        }
+        if (range_compare(&ranges[j], &ranges[j + 1])) {
+            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
+                             MIN(range_lob(&ranges[j + 1]) - 1, high));
+        }
+    }
+    /* last range upb is less than max, insert a last range */
+    if (range_upb(&ranges[j]) <  high) {
+        range_set_bounds(&resv[i++],
+                          range_upb(&ranges[j]) + 1, high);
+    }
+realloc:
+    *nr_inv_ranges = i;
+    resv = g_realloc(resv, i * sizeof(Range));
+    *inv_ranges = resv;
+}
-- 
2.41.0


