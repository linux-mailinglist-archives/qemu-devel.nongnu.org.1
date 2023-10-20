Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476807D1879
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxUF-0003xp-EM; Fri, 20 Oct 2023 17:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTy-0003s4-E5; Fri, 20 Oct 2023 17:56:39 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008Fy-M4; Fri, 20 Oct 2023 17:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=AOdVB5L+10G1WQ+8o75fKXSttdivBvesl0iH9zSiDRA=; b=RWsp3xhUFTQ3
 kVAhfThRyMtF2JWs4amcOI/U/r68AliLrhp+eNS2WWZ+WGI7xIzAUyFy96Tn4SwyDSa0XcnZjD3we
 97oaB/FcUDRkBaxM8eFJOPrUFB5yWH1rUsdJ/BlrqmXQytOWeES2uQFyqemCUw+sALC/sYl0BY4p8
 LDVMXnQyGh1fnkCNx6RZ50sM+tWkQNrZsyXBxkbCC3G8yjG+prPy5ox9V+Aei2H8vlgw3mjrDkuBa
 QSQWXiLwQSjut9d5lUkKPlb3078rKKK2hSloGhc8d9yg2xvA4fP+ZKEDt0DBeae1QMCvj2EaQ+8Dp
 OR3qf2KJ9skjJ/npaXAetQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-2H;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 4/7] qcow2: make subclusters discardable
Date: Sat, 21 Oct 2023 00:56:19 +0300
Message-Id: <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit makes the discard operation work on the subcluster level
rather than cluster level.  It introduces discard_l2_subclusters()
function and makes use of it in qcow2 discard implementation, much like
it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
operation and free host disk space.

This feature will let us gain additional disk space on guest
TRIM/discard requests, especially when using large enough clusters
(1M, 2M) with subclusters enabled.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 100 ++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.c         |   8 ++--
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 7c6fa5524c..cf40f2dc12 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2042,6 +2042,74 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
     return nb_clusters;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
+                       uint64_t nb_subclusters,
+                       enum qcow2_discard_type type,
+                       bool full_discard,
+                       SubClusterRangeInfo *pscri)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t new_l2_bitmap, l2_bitmap_mask;
+    int ret, sc = offset_to_sc_index(s, offset);
+    SubClusterRangeInfo scri = { 0 };
+
+    if (!pscri) {
+        ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
+        if (ret < 0) {
+            goto out;
+        }
+    } else {
+        scri = *pscri;
+    }
+
+    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap = scri.l2_bitmap;
+    new_l2_bitmap &= ~l2_bitmap_mask;
+
+    /*
+     * If there're no allocated subclusters left, we might as well discard
+     * the entire cluster.  That way we'd also update the refcount table.
+     */
+    if (!(new_l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC)) {
+        return discard_in_l2_slice(bs,
+                                   QEMU_ALIGN_DOWN(offset, s->cluster_size),
+                                   1, type, full_discard);
+    }
+
+    /*
+     * Full discard means we fall through to the backing file, thus we only
+     * need to mark the subclusters as deallocated.
+     *
+     * Non-full discard means subclusters should be explicitly marked as
+     * zeroes.  In this case QCOW2 specification requires the corresponding
+     * allocation status bits to be unset as well.  If the subclusters are
+     * deallocated in the first place and there's no backing, the operation
+     * can be skipped.
+     */
+    if (!full_discard &&
+        (bs->backing || scri.l2_bitmap & l2_bitmap_mask)) {
+        new_l2_bitmap |= QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+    }
+
+    if (scri.l2_bitmap != new_l2_bitmap) {
+        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
+    }
+
+    if (s->discard_passthrough[type]) {
+        qcow2_queue_discard(bs, (scri.l2_entry & L2E_OFFSET_MASK) +
+                            offset_into_cluster(s, offset),
+                            nb_subclusters * s->subcluster_size);
+    }
+
+    ret = 0;
+out:
+    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
+
+    return ret;
+}
+
 int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, enum qcow2_discard_type type,
                           bool full_discard)
@@ -2049,19 +2117,36 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
     BDRVQcow2State *s = bs->opaque;
     uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
+    unsigned head, tail;
     int64_t cleared;
     int ret;
 
     /* Caller must pass aligned values, except at image end */
-    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+    assert(QEMU_IS_ALIGNED(offset, s->subcluster_size));
+    assert(QEMU_IS_ALIGNED(end_offset, s->subcluster_size) ||
            end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
 
-    nb_clusters = size_to_clusters(s, bytes);
+    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
+    offset += head;
+
+    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
+           end_offset - MAX(offset, start_of_cluster(s, end_offset));
+    end_offset -= tail;
 
     s->cache_discards = true;
 
+    if (head) {
+        ret = discard_l2_subclusters(bs, offset - head,
+                                     size_to_subclusters(s, head), type,
+                                     full_discard, NULL);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     /* Each L2 slice is handled by its own loop iteration */
+    nb_clusters = size_to_clusters(s, end_offset - offset);
+
     while (nb_clusters > 0) {
         cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
                                       full_discard);
@@ -2074,6 +2159,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
         offset += (cleared * s->cluster_size);
     }
 
+    if (tail) {
+        ret = discard_l2_subclusters(bs, end_offset,
+                                     size_to_subclusters(s, tail), type,
+                                     full_discard, NULL);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     ret = 0;
 fail:
     s->cache_discards = false;
diff --git a/block/qcow2.c b/block/qcow2.c
index aa01d9e7b5..66961fa59e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1966,7 +1966,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
-    bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.pdiscard_alignment = s->subcluster_size;
 }
 
 static int GRAPH_UNLOCKED
@@ -4102,11 +4102,11 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
         return -ENOTSUP;
     }
 
-    if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
-        assert(bytes < s->cluster_size);
+    if (!QEMU_IS_ALIGNED(offset | bytes, bs->bl.pdiscard_alignment)) {
+        assert(bytes < bs->bl.pdiscard_alignment);
         /* Ignore partial clusters, except for the special case of the
          * complete partial cluster at the end of an unaligned file */
-        if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
+        if (!QEMU_IS_ALIGNED(offset, bs->bl.pdiscard_alignment) ||
             offset + bytes != bs->total_sectors * BDRV_SECTOR_SIZE) {
             return -ENOTSUP;
         }
-- 
2.39.3


