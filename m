Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44C7D187A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxTw-0003pR-BL; Fri, 20 Oct 2023 17:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTs-0003nm-RZ; Fri, 20 Oct 2023 17:56:32 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G0-Iw; Fri, 20 Oct 2023 17:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=AAm3BCi7oLK+rMtTaRnf4YstYpBZyRvRpC4m7z5RCrM=; b=Spc48BusaTgy
 M2MveG7EpevasYorRVBbYmuwedD8zP1/iGbmEnZwwZcXVtgSJp/o70vPjv4fZ/mtojLoy1xWvdZiw
 fpTBjmscgIIu9mW+inf9EbmSc0GUNXHycQl31xCMQuTIWGowuzsY1g+IKPooWrxPRpr/mHsXne2xo
 h5pUJOLhfey1IOW0zFErn4feXRZbEZRre63H9sG7c+q1kUL4J7/x6hX5VVZCipmi3ulbraD8g5gFp
 PHi6KGc/pA6DgsYFCTxWq7TLpgQ2kXtBZrJoYea4V594TePJUTlCl0blRd/hRd+c28wa8jlIVrJiR
 W/J280PSxSPN4dwO7HCopw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-26;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 3/7] qcow2: zeroize the entire cluster when there're no
 non-zero subclusters
Date: Sat, 21 Oct 2023 00:56:18 +0300
Message-Id: <20231020215622.789260-4-andrey.drobyshev@virtuozzo.com>
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

When zeroizing the last non-zero subclusters within single cluster, it
makes sense to go zeroize the entire cluster and go down zero_in_l2_slice()
path right away.  That way we'd also update the corresponding refcount
table.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8801856b93..7c6fa5524c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2145,7 +2145,7 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
 static int coroutine_fn GRAPH_RDLOCK
 zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
-                    unsigned nb_subclusters)
+                    unsigned nb_subclusters, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t new_l2_bitmap;
@@ -2161,6 +2161,17 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
     new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
     new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
 
+    /*
+     * If there're no non-zero subclusters left, we might as well zeroize
+     * the entire cluster.  That way we'd also update the refcount table.
+     */
+    if ((new_l2_bitmap & QCOW_L2_BITMAP_ALL_ZEROES) ==
+        QCOW_L2_BITMAP_ALL_ZEROES) {
+        qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
+        return zero_in_l2_slice(bs, QEMU_ALIGN_DOWN(offset, s->cluster_size),
+                                1, flags);
+    }
+
     if (new_l2_bitmap != scri.l2_bitmap) {
         set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
@@ -2221,7 +2232,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
 
     if (head) {
         ret = zero_l2_subclusters(bs, offset - head,
-                                  size_to_subclusters(s, head));
+                                  size_to_subclusters(s, head), flags);
         if (ret < 0) {
             goto fail;
         }
@@ -2242,7 +2253,8 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
     }
 
     if (tail) {
-        ret = zero_l2_subclusters(bs, end_offset, size_to_subclusters(s, tail));
+        ret = zero_l2_subclusters(bs, end_offset,
+                                  size_to_subclusters(s, tail), flags);
         if (ret < 0) {
             goto fail;
         }
-- 
2.39.3


