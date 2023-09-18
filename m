Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA257A5188
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIZY-0007cX-98; Mon, 18 Sep 2023 14:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qiIYp-0006og-Je; Mon, 18 Sep 2023 14:01:29 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qiIYo-0003Br-2O; Mon, 18 Sep 2023 14:01:27 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qiIV5-008crV-2y;
 Mon, 18 Sep 2023 20:01:00 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 17/22] parallels: naive implementation of allocate_clusters
 with used bitmap
Date: Mon, 18 Sep 2023 20:00:55 +0200
Message-Id: <20230918180100.524843-19-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918180100.524843-1-den@openvz.org>
References: <20230918180100.524843-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The access to the bitmap is not optimized completely.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 51 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 3beb18e44f..6a5bff4fcb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -253,7 +253,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 {
     int ret = 0;
     BDRVParallelsState *s = bs->opaque;
-    int64_t pos, space, idx, to_allocate, i, len;
+    int64_t i, pos, idx, to_allocate, first_free, host_off;
 
     pos = block_status(s, sector_num, nb_sectors, pnum);
     if (pos > 0) {
@@ -276,15 +276,13 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
      */
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
-    space = to_allocate * s->tracks;
-    len = bdrv_co_getlength(bs->file->bs);
-    if (len < 0) {
-        return len;
-    }
-    if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
+    first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
+    if (first_free == s->used_bmap_size) {
         uint32_t new_usedsize;
+        int64_t space = to_allocate * s->tracks + s->prealloc_size;
+
+        host_off = s->data_end * BDRV_SECTOR_SIZE;
 
-        space += s->prealloc_size;
         /*
          * We require the expanded size to read back as zero. If the
          * user permitted truncation, we try that; but if it fails, we
@@ -313,6 +311,32 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
+    } else {
+        int64_t next_used;
+        next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
+
+        /* Not enough continuous clusters in the middle, adjust the size */
+        if (next_used - first_free < to_allocate) {
+            to_allocate = next_used - first_free;
+            *pnum = (idx + to_allocate) * s->tracks - sector_num;
+        }
+
+        host_off = s->data_start * BDRV_SECTOR_SIZE;
+        host_off += first_free * s->cluster_size;
+
+        /*
+         * No need to preallocate if we are using tail area from the above
+         * branch. In the other case we are likely re-using hole. Preallocate
+         * the space if required by the prealloc_mode.
+         */
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
+                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
+                                        s->cluster_size * to_allocate, 0);
+            if (ret < 0) {
+                return ret;
+            }
+        }
     }
 
     /*
@@ -344,15 +368,18 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size,
-                    s->data_end << BDRV_SECTOR_BITS, to_allocate);
+    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
     }
     for (i = 0; i < to_allocate; i++) {
-        parallels_set_bat_entry(s, idx + i, s->data_end / s->off_multiplier);
-        s->data_end += s->tracks;
+        parallels_set_bat_entry(s, idx + i,
+                host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
+        host_off += s->cluster_size;
+    }
+    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
+        s->data_end = host_off / BDRV_SECTOR_SIZE;
     }
 
     return bat2sect(s, idx) + sector_num % s->tracks;
-- 
2.34.1


