Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95087940C3
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumz-0007Fe-Ke; Wed, 06 Sep 2023 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumw-0007Co-CC; Wed, 06 Sep 2023 11:49:54 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumq-0002yJ-EE; Wed, 06 Sep 2023 11:49:54 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdujj-007L3X-2D;
 Wed, 06 Sep 2023 17:49:34 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 07/18] parallels: Add checking and repairing duplicate offsets
 in BAT
Date: Wed,  6 Sep 2023 17:49:40 +0200
Message-Id: <20230906154942.656537-8-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906154942.656537-1-den@openvz.org>
References: <20230906154942.656537-1-den@openvz.org>
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Cluster offsets must be unique among all the BAT entries. Find duplicate
offsets in the BAT and fix it by copying the content of the relevant
cluster to a newly allocated cluster and set the new cluster offset to the
duplicated entry.

Add host_cluster_index() helper to deduplicate the code.

When new clusters are allocated, the file size increases by 128 Mb. Call
parallels_check_leak() to fix this leak.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index f7b44cb433..a78238eadd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
     return MIN(nb_sectors, ret);
 }
 
+static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
+{
+    off -= s->data_start << BDRV_SECTOR_BITS;
+    return off / s->cluster_size;
+}
+
 static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
                             int nb_sectors, int *pnum)
 {
@@ -533,6 +539,139 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
+                          BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t host_off, host_sector, guest_sector;
+    unsigned long *bitmap;
+    uint32_t i, bitmap_size, cluster_index, bat_entry;
+    int n, ret = 0;
+    uint64_t *buf = NULL;
+    bool fixed = false;
+
+    /*
+     * Create a bitmap of used clusters.
+     * If a bit is set, there is a BAT entry pointing to this cluster.
+     * Loop through the BAT entries, check bits relevant to an entry offset.
+     * If bit is set, this entry is duplicated. Otherwise set the bit.
+     *
+     * We shouldn't worry about newly allocated clusters outside the image
+     * because they are created higher then any existing cluster pointed by
+     * a BAT entry.
+     */
+    bitmap_size = host_cluster_index(s, res->image_end_offset);
+    if (bitmap_size == 0) {
+        return 0;
+    }
+    if (res->image_end_offset % s->cluster_size) {
+        /* A not aligned image end leads to a bitmap shorter by 1 */
+        bitmap_size++;
+    }
+
+    bitmap = bitmap_new(bitmap_size);
+
+    buf = qemu_blockalign(bs, s->cluster_size);
+
+    for (i = 0; i < s->bat_size; i++) {
+        host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
+        if (host_off == 0) {
+            continue;
+        }
+
+        cluster_index = host_cluster_index(s, host_off);
+        assert(cluster_index < bitmap_size);
+        if (!test_bit(cluster_index, bitmap)) {
+            bitmap_set(bitmap, cluster_index, 1);
+            continue;
+        }
+
+        /* this cluster duplicates another one */
+        fprintf(stderr, "%s duplicate offset in BAT entry %u\n",
+                fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+
+        res->corruptions++;
+
+        if (!(fix & BDRV_FIX_ERRORS)) {
+            continue;
+        }
+
+        /*
+         * Reset the entry and allocate a new cluster
+         * for the relevant guest offset. In this way we let
+         * the lower layer to place the new cluster properly.
+         * Copy the original cluster to the allocated one.
+         * But before save the old offset value for repairing
+         * if we have an error.
+         */
+        bat_entry = s->bat_bitmap[i];
+        parallels_set_bat_entry(s, i, 0);
+
+        ret = bdrv_co_pread(bs->file, host_off, s->cluster_size, buf, 0);
+        if (ret < 0) {
+            res->check_errors++;
+            goto out_repair_bat;
+        }
+
+        guest_sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;
+        host_sector = allocate_clusters(bs, guest_sector, s->tracks, &n);
+        if (host_sector < 0) {
+            res->check_errors++;
+            goto out_repair_bat;
+        }
+        host_off = host_sector << BDRV_SECTOR_BITS;
+
+        ret = bdrv_co_pwrite(bs->file, host_off, s->cluster_size, buf, 0);
+        if (ret < 0) {
+            res->check_errors++;
+            goto out_repair_bat;
+        }
+
+        if (host_off + s->cluster_size > res->image_end_offset) {
+            res->image_end_offset = host_off + s->cluster_size;
+        }
+
+        /*
+         * In the future allocate_cluster() will reuse holed offsets
+         * inside the image. Keep the used clusters bitmap content
+         * consistent for the new allocated clusters too.
+         *
+         * Note, clusters allocated outside the current image are not
+         * considered, and the bitmap size doesn't change.
+         */
+        cluster_index = host_cluster_index(s, host_off);
+        if (cluster_index < bitmap_size) {
+            bitmap_set(bitmap, cluster_index, 1);
+        }
+
+        fixed = true;
+        res->corruptions_fixed++;
+
+    }
+
+    if (fixed) {
+        /*
+         * When new clusters are allocated, the file size increases by
+         * 128 Mb. We need to truncate the file to the right size. Let
+         * the leak fix code make its job without res changing.
+         */
+        ret = parallels_check_leak(bs, res, fix, false);
+    }
+
+out_free:
+    g_free(buf);
+    g_free(bitmap);
+    return ret;
+/*
+ * We can get here only from places where index and old_offset have
+ * meaningful values.
+ */
+out_repair_bat:
+    s->bat_bitmap[i] = bat_entry;
+    goto out_free;
+}
+
 static void parallels_collect_statistics(BlockDriverState *bs,
                                          BdrvCheckResult *res,
                                          BdrvCheckMode fix)
@@ -584,6 +723,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
+        ret = parallels_check_duplicate(bs, res, fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         parallels_collect_statistics(bs, res, fix);
     }
 
-- 
2.34.1


