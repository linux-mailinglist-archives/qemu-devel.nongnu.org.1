Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F37E6B8D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15O8-0002PD-PP; Thu, 09 Nov 2023 08:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NS-0008MN-On; Thu, 09 Nov 2023 08:47:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NQ-0002Aa-BI; Thu, 09 Nov 2023 08:47:22 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94CF131B20;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A3795344C6;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461882 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 40/55] qcow2: keep reference on zeroize with
 discard-no-unref enabled
Date: Thu,  9 Nov 2023 16:42:44 +0300
Message-Id: <20231109134300.1461632-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit b2b109041ecd1095384f5be5bb9badd13c1cf286)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f4f6cd6ad0..fc764aea4d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1984,7 +1984,7 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             /* If we keep the reference, pass on the discard still */
             bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
                           s->cluster_size);
-       }
+        }
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
@@ -2062,9 +2062,15 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
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
@@ -2082,9 +2088,17 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
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
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b1d493d6e..bca1a0c372 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3473,16 +3473,20 @@
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
diff --git a/qemu-options.hx b/qemu-options.hx
index b56f6b2fb2..8073f5edf5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1436,9 +1436,13 @@ SRST
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
2.39.2


