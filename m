Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8067922D2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVoH-0005dG-7v; Tue, 05 Sep 2023 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qdVoC-0005cR-Ha
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:09:33 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qdVo9-0001dN-Mh
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:09:32 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 7B2C01520BEF;
 Tue,  5 Sep 2023 15:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1693919364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=P31G38TdVq75/F7yz8yO59NgcDVH5NtyalfAOIOv6Wk=;
 b=YZEZXPQ4lbseMM/ZeSNd8poqUclikUWYg/+PvdUfnL0H5TBLxSxUv+auZRF8OXC/dO2vXs
 v7e5Qdb89wth/HN1ZLdj23x4w696kjuD9F886DWe8BUB10NMKqMAHxncmDGmahRsACd5Nk
 ocAnZBypSyHd2hR7iPKrK1fjikziXo4cnsG8lN1HCZ1eJuZkroP/UKdIamFPvQ2cdHk1Dg
 Dzko9Y49dZz3izPSCGJbrvMqXKqUvg6YNk0WKhBg3D87LPPnEYuWy5zb9tWCYf9Nq9LP34
 lNy1XcVL8kdNbjmouSOIFp3tIvSc7PEfxKlhGOk/45BLpPFvza2hVmky3v4rSg==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Date: Tue,  5 Sep 2023 15:08:40 +0200
Message-ID: <20230905130839.923041-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 block/qcow2-cluster.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

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
 
-- 
2.42.0


