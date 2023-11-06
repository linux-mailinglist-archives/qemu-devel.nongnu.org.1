Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A937E2ABD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:12:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r037d-0002Y4-Qc; Mon, 06 Nov 2023 12:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037Z-0002XG-94
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037X-00070E-8J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699290638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggOWmtxey/harr42Oal2rCuuFLnxtORqeHMKe0yyHzk=;
 b=jNYWr7GgtXNSRrDpLb+USW76N6PsvaP90Nd2buHFk7l7zZF+sQokAPZbyO8x+i+/wNcBqr
 rMe30GQ0OnF920yWYZJgu58yraKGHpKsRg1FVnkd56QZtaqBu73psCTF2V9wdiBq/4DBYv
 hkDina4dEuNSyA8fm02TCad4KLxpSP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-SnHhuHstPae0P9TSL-ZOPA-1; Mon, 06 Nov 2023 12:10:35 -0500
X-MC-Unique: SnHhuHstPae0P9TSL-ZOPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 468EA1019C99;
 Mon,  6 Nov 2023 17:10:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 066A7492A;
 Mon,  6 Nov 2023 17:10:34 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 1/3] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Date: Mon,  6 Nov 2023 18:10:29 +0100
Message-ID: <20231106171031.1084277-2-hreitz@redhat.com>
In-Reply-To: <20231106171031.1084277-1-hreitz@redhat.com>
References: <20231106171031.1084277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jean-Louis Dupond <jean-louis@dupond.be>

When the discard-no-unref flag is enabled, we keep the reference for
normal discard requests.
But when a discard is executed on a snapshot/qcow2 image with backing,
the discards are saved as zero clusters in the snapshot image.

When committing the snapshot to the backing file, not
discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
any logic to keep the reference when discard-no-unref is enabled.

Therefor we add logic in the zero_in_l2_slice call to keep the reference
on commit.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
Message-Id: <20231003125236.216473-2-jean-louis@dupond.be>
[hreitz: Made the documentation change more verbose, as discussed
         on-list]
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-core.json  | 24 ++++++++++++++----------
 block/qcow2-cluster.c | 22 ++++++++++++++++++----
 qemu-options.hx       | 10 +++++++---
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 99961256f2..ca390c5700 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3528,16 +3528,20 @@
 # @pass-discard-other: whether discard requests for the data source
 #     should be issued on other occasions where a cluster gets freed
 #
-# @discard-no-unref: when enabled, discards from the guest will not
-#     cause cluster allocations to be relinquished.  This prevents
-#     qcow2 fragmentation that would be caused by such discards.
-#     Besides potential performance degradation, such fragmentation
-#     can lead to increased allocation of clusters past the end of the
-#     image file, resulting in image files whose file length can grow
-#     much larger than their guest disk size would suggest.  If image
-#     file length is of concern (e.g. when storing qcow2 images
-#     directly on block devices), you should consider enabling this
-#     option.  (since 8.1)
+# @discard-no-unref: when enabled, data clusters will remain
+#     preallocated when they are no longer used, e.g. because they are
+#     discarded or converted to zero clusters.  As usual, whether the
+#     old data is discarded or kept on the protocol level (i.e. in the
+#     image file) depends on the setting of the pass-discard-request
+#     option.  Keeping the clusters preallocated prevents qcow2
+#     fragmentation that would otherwise be caused by freeing and
+#     re-allocating them later.  Besides potential performance
+#     degradation, such fragmentation can lead to increased allocation
+#     of clusters past the end of the image file, resulting in image
+#     files whose file length can grow much larger than their guest disk
+#     size would suggest.  If image file length is of concern (e.g. when
+#     storing qcow2 images directly on block devices), you should
+#     consider enabling this option.  (since 8.1)
 #
 # @overlap-check: which overlap checks to perform for writes to the
 #     image, defaults to 'cached' (since 2.2)
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 904f00d1b3..5af439bd11 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1983,7 +1983,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
             /* If we keep the reference, pass on the discard still */
             bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
                           s->cluster_size);
-       }
+        }
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
@@ -2061,9 +2061,15 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
         bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
-        uint64_t new_l2_entry = unmap ? 0 : old_l2_entry;
+        bool keep_reference =
+            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
+        uint64_t new_l2_entry = old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
+        if (unmap && !keep_reference) {
+            new_l2_entry = 0;
+        }
+
         if (has_subclusters(s)) {
             new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
         } else {
@@ -2081,9 +2087,17 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
 
-        /* Then decrease the refcount */
         if (unmap) {
-            qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
+            if (!keep_reference) {
+                /* Then decrease the refcount */
+                qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
+            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
+                       (type == QCOW2_CLUSTER_NORMAL ||
+                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+                /* If we keep the reference, pass on the discard still */
+                bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
+                            s->cluster_size);
+            }
         }
     }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index e26230bac5..7809036d8c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1457,9 +1457,13 @@ SRST
             (on/off; default: off)
 
         ``discard-no-unref``
-            When enabled, discards from the guest will not cause cluster
-            allocations to be relinquished. This prevents qcow2 fragmentation
-            that would be caused by such discards. Besides potential
+            When enabled, data clusters will remain preallocated when they are
+            no longer used, e.g. because they are discarded or converted to
+            zero clusters. As usual, whether the old data is discarded or kept
+            on the protocol level (i.e. in the image file) depends on the
+            setting of the pass-discard-request option. Keeping the clusters
+            preallocated prevents qcow2 fragmentation that would otherwise be
+            caused by freeing and re-allocating them later. Besides potential
             performance degradation, such fragmentation can lead to increased
             allocation of clusters past the end of the image file,
             resulting in image files whose file length can grow much larger
-- 
2.41.0


