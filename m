Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1F7A2655
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDlB-0004bK-LF; Fri, 15 Sep 2023 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl6-0004Ss-6T; Fri, 15 Sep 2023 14:41:40 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl4-00037y-Cj; Fri, 15 Sep 2023 14:41:39 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qhDhf-00Fs9Q-1B;
 Fri, 15 Sep 2023 20:41:31 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 07/21] parallels: create mark_used() helper which sets bit in
 used bitmap
Date: Fri, 15 Sep 2023 20:41:15 +0200
Message-Id: <20230915184130.403366-9-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915184130.403366-1-den@openvz.org>
References: <20230915184130.403366-1-den@openvz.org>
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

This functionality is used twice already and next patch will add more
code with it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index aa29df9f77..60ad41b49b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -178,6 +178,21 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
+static int mark_used(BlockDriverState *bs,
+                     unsigned long *bitmap, uint32_t bitmap_size, int64_t off)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_index = host_cluster_index(s, off);
+    if (cluster_index >= bitmap_size) {
+        return -E2BIG;
+    }
+    if (test_bit(cluster_index, bitmap)) {
+        return -EBUSY;
+    }
+    bitmap_set(bitmap, cluster_index, 1);
+    return 0;
+}
+
 static int64_t coroutine_fn GRAPH_RDLOCK
 allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                   int nb_sectors, int *pnum)
@@ -621,7 +636,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     BDRVParallelsState *s = bs->opaque;
     int64_t host_off, host_sector, guest_sector;
     unsigned long *bitmap;
-    uint32_t i, bitmap_size, cluster_index, bat_entry;
+    uint32_t i, bitmap_size, bat_entry;
     int n, ret = 0;
     uint64_t *buf = NULL;
     bool fixed = false;
@@ -655,10 +670,9 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        cluster_index = host_cluster_index(s, host_off);
-        assert(cluster_index < bitmap_size);
-        if (!test_bit(cluster_index, bitmap)) {
-            bitmap_set(bitmap, cluster_index, 1);
+        ret = mark_used(bs, bitmap, bitmap_size, host_off);
+        assert(ret != -E2BIG);
+        if (ret == 0) {
             continue;
         }
 
@@ -713,11 +727,13 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * consistent for the new allocated clusters too.
          *
          * Note, clusters allocated outside the current image are not
-         * considered, and the bitmap size doesn't change.
+         * considered, and the bitmap size doesn't change. This specifically
+         * means that -E2BIG is OK.
          */
-        cluster_index = host_cluster_index(s, host_off);
-        if (cluster_index < bitmap_size) {
-            bitmap_set(bitmap, cluster_index, 1);
+        ret = mark_used(bs, bitmap, bitmap_size, host_off);
+        if (ret == -EBUSY) {
+            res->check_errors++;
+            goto out_repair_bat;
         }
 
         fixed = true;
-- 
2.34.1


