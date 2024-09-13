Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0259785FB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 18:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Lh-00012d-9i; Fri, 13 Sep 2024 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9LS-0000CX-H6; Fri, 13 Sep 2024 12:40:32 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9LP-00016L-PC; Fri, 13 Sep 2024 12:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=RFuHDVCB6WEL6sCRSt1TXrSgPQ8bKk8dhDHri4p6yHE=; b=oedgI/9oOTUD
 yLH5xXpMTIc1tKyQu8pw5bVIXMAE3l5oLuSJ0tLPWmQyxODsGITHP00Dd6/oQvl14tZE0QidGW9Fe
 xyu5emlUY5bMjGv3txk5vzEw9Qff09T9T99sJEfomUVMdR3HW6YZ22kJcKkCfNh1TpvToEFdUkCUp
 s4x3+v0FfLg2QAdwpiJHVM4LUlUoo4YY+XzJHMbxImo+zAaG32FiW4i0WnG9S/gaQbSuogLQV2HqD
 avYFgYgij3t1mHOSzBa4lAp347bK3/anYneGaTribUKTvePtxZmHQ1Ugg2q2PrHhtgeGye45ECLeK
 KTW6YzH7Vc51onMqW/NcsA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hz-002OPf-0K;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 10/12] qcow2: zero_l2_subclusters: fall through to discard
 operation when requested
Date: Fri, 13 Sep 2024 19:39:40 +0300
Message-Id: <20240913163942.423050-11-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

When zeroizing subclusters within single cluster, detect usage of the
BDRV_REQ_MAY_UNMAP flag and fall through to the subcluster-based discard
operation, much like it's done with the cluster-based discards.  That
way subcluster-aligned operations "qemu-io -c 'write -z -u ...'" will
lead to actual unmap.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/qcow2-cluster.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3c134a7e80..53e04eff93 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2107,15 +2107,16 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
 
 static int coroutine_fn GRAPH_RDLOCK
 discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
-                       uint64_t nb_subclusters,
-                       enum qcow2_discard_type type,
-                       bool full_discard)
+                       uint64_t nb_subclusters, enum qcow2_discard_type type,
+                       bool full_discard, bool uncond_zeroize)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t new_l2_bitmap, bitmap_alloc_mask, bitmap_zero_mask;
     int ret, sc = offset_to_sc_index(s, offset);
     g_auto(SubClusterRangeInfo) scri = { 0 };
 
+    assert(!(full_discard && uncond_zeroize));
+
     ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
     if (ret < 0) {
         return ret;
@@ -2140,7 +2141,8 @@ discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
      */
     if (full_discard) {
         new_l2_bitmap &= ~bitmap_zero_mask;
-    } else if (bs->backing || scri.l2_bitmap & bitmap_alloc_mask) {
+    } else if (uncond_zeroize || bs->backing ||
+               scri.l2_bitmap & bitmap_alloc_mask) {
         new_l2_bitmap |= bitmap_zero_mask;
     }
 
@@ -2197,7 +2199,7 @@ int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
     if (head) {
         ret = discard_l2_subclusters(bs, offset - head,
                                      size_to_subclusters(s, head), type,
-                                     full_discard);
+                                     full_discard, false);
         if (ret < 0) {
             goto fail;
         }
@@ -2221,7 +2223,7 @@ int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
     if (tail) {
         ret = discard_l2_subclusters(bs, end_offset,
                                      size_to_subclusters(s, tail), type,
-                                     full_discard);
+                                     full_discard, false);
         if (ret < 0) {
             goto fail;
         }
@@ -2318,6 +2320,18 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
     int ret, sc = offset_to_sc_index(s, offset);
     g_auto(SubClusterRangeInfo) scri = { 0 };
 
+    /*
+     * If the request allows discarding subclusters we go down the discard
+     * path regardless of their allocation status.  After the discard
+     * operation with full_discard=false subclusters are going to be read as
+     * zeroes anyway.  But we make sure that subclusters are explicitly
+     * zeroed anyway with uncond_zeroize=true.
+     */
+    if (flags & BDRV_REQ_MAY_UNMAP) {
+        return discard_l2_subclusters(bs, offset, nb_subclusters,
+                                      QCOW2_DISCARD_REQUEST, false, true);
+    }
+
     ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
     if (ret < 0) {
         return ret;
-- 
2.39.3


