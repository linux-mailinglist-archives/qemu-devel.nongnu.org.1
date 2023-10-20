Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C034A7D187B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxU1-0003sc-33; Fri, 20 Oct 2023 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTu-0003pM-A6; Fri, 20 Oct 2023 17:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008Fz-NS; Fri, 20 Oct 2023 17:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=5EW9dBv700hG96A7F9K7bifxv268XKy4vOdbQChMeHA=; b=dHxm6Tcexdsh
 KUVCDk/2TURH/Z+724Ngp6cA7fP6RjGELjEYv5jb9Nn8jFK0xsuXQ8JkiZOVOHmKFIw26BrQrcE1E
 sr+e+C58RAIi6/hq1vb3nSgedHstWXE6gTLFPc4TBwOy2xHxkq4NHf/Tmh+IFMksoRu/XZ9n53X1W
 juMWNLq3DZWzHtWJOs9cG5R2s+xJXlQR728nvqbJht8Opb3pCVsqXFQQ28LE7bKFYhh3Nze/Zc09r
 qTdNagMd/K28u/Z4XO1+BHQY/wEoczX8HHs96K+LIskKJRlfP7+ANxReOJSgUUhyEKJtwLbeYxVHT
 Yb3aTYCJTqAd/DAaSHa9sw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-1v;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 2/7] qcow2: add get_sc_range_info() helper for working with
 subcluster ranges
Date: Sat, 21 Oct 2023 00:56:17 +0300
Message-Id: <20231020215622.789260-3-andrey.drobyshev@virtuozzo.com>
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

This helper simply obtains the l2 table parameters of the cluster which
contains the given subclusters range.  Right now this info is being
obtained and used by zero_l2_subclusters().  As we're about to introduce
the subclusters discard operation, this helper would let us avoid code
duplication.

Also introduce struct SubClusterRangeInfo, which would contain all the
needed params.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 90 +++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 904f00d1b3..8801856b93 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -32,6 +32,13 @@
 #include "qemu/memalign.h"
 #include "trace.h"
 
+typedef struct SubClusterRangeInfo {
+    uint64_t *l2_slice;
+    int l2_index;
+    uint64_t l2_entry;
+    uint64_t l2_bitmap;
+} SubClusterRangeInfo;
+
 int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
                                        uint64_t exact_size)
 {
@@ -1892,6 +1899,50 @@ again:
     return 0;
 }
 
+static int get_sc_range_info(BlockDriverState *bs, uint64_t offset,
+                             unsigned nb_subclusters,
+                             SubClusterRangeInfo *scri)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret, sc_cleared = 0, sc_index = offset_to_sc_index(s, offset);
+    QCow2SubclusterType sctype;
+
+    /* Here we only work with the subclusters within single cluster. */
+    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
+    assert(sc_index + nb_subclusters <= s->subclusters_per_cluster);
+    assert(offset_into_subcluster(s, offset) == 0);
+
+    ret = get_cluster_table(bs, offset, &scri->l2_slice, &scri->l2_index);
+    if (ret < 0) {
+        return ret;
+    }
+
+    scri->l2_entry = get_l2_entry(s, scri->l2_slice, scri->l2_index);
+    scri->l2_bitmap = get_l2_bitmap(s, scri->l2_slice, scri->l2_index);
+
+    do {
+        qcow2_get_subcluster_range_type(bs, scri->l2_entry, scri->l2_bitmap,
+                                        sc_index, &sctype);
+        if (ret < 0) {
+            return ret;
+        }
+
+        switch (sctype) {
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            /* We cannot partially zeroize/discard compressed clusters. */
+            return -ENOTSUP;
+        case QCOW2_SUBCLUSTER_INVALID:
+            return -EINVAL;
+        default:
+            break;
+        }
+
+        sc_cleared += ret;
+    } while (sc_cleared < nb_subclusters);
+
+    return 0;
+}
+
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
  * all clusters in the same L2 slice) and returns the number of discarded
@@ -2097,44 +2148,27 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
                     unsigned nb_subclusters)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_slice;
-    uint64_t old_l2_bitmap, l2_bitmap;
-    int l2_index, ret, sc = offset_to_sc_index(s, offset);
+    uint64_t new_l2_bitmap;
+    int ret, sc = offset_to_sc_index(s, offset);
+    SubClusterRangeInfo scri = { 0 };
 
-    /* For full clusters use zero_in_l2_slice() instead */
-    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
-    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
-    assert(offset_into_subcluster(s, offset) == 0);
-
-    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
+    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
     if (ret < 0) {
-        return ret;
-    }
-
-    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice, l2_index))) {
-    case QCOW2_CLUSTER_COMPRESSED:
-        ret = -ENOTSUP; /* We cannot partially zeroize compressed clusters */
         goto out;
-    case QCOW2_CLUSTER_NORMAL:
-    case QCOW2_CLUSTER_UNALLOCATED:
-        break;
-    default:
-        g_assert_not_reached();
     }
 
-    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
-
-    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
-    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap = scri.l2_bitmap;
+    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
 
-    if (old_l2_bitmap != l2_bitmap) {
-        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
-        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+    if (new_l2_bitmap != scri.l2_bitmap) {
+        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
     }
 
     ret = 0;
 out:
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
+    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
 
     return ret;
 }
-- 
2.39.3


