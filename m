Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE197940C6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumx-0007E0-MX; Wed, 06 Sep 2023 11:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumu-0007BI-AZ; Wed, 06 Sep 2023 11:49:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdump-0002xu-9G; Wed, 06 Sep 2023 11:49:52 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdujh-007L3X-26;
 Wed, 06 Sep 2023 17:49:32 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 02/18] parallels: Fix comments formatting inside parallels
 driver
Date: Wed,  6 Sep 2023 17:49:35 +0200
Message-Id: <20230906154942.656537-3-den@openvz.org>
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

This patch is technically necessary as git patch rendering could result
in moving some code from one place to the another and that hits
checkpatch.pl warning. This problem specifically happens within next
series.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 18e34aef28..c7b2ed5a54 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -188,7 +188,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     idx = sector_num / s->tracks;
     to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
 
-    /* This function is called only by parallels_co_writev(), which will never
+    /*
+     * This function is called only by parallels_co_writev(), which will never
      * pass a sector_num at or beyond the end of the image (because the block
      * layer never passes such a sector_num to that function). Therefore, idx
      * is always below s->bat_size.
@@ -196,7 +197,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
      * exceed the image end. Therefore, idx + to_allocate cannot exceed
      * s->bat_size.
      * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t. */
+     * will always fit into a uint32_t.
+     */
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
     space = to_allocate * s->tracks;
@@ -230,13 +232,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    /* Try to read from backing to fill empty clusters
+    /*
+     * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
      *        2. most of data we read from backing will be rewritten by
      *           parallels_co_writev. On aligned-to-cluster write we do not need
      *           this read at all.
      *        3. it would be good to combine write of data from backing and new
-     *           data into one write call */
+     *           data into one write call.
+     */
     if (bs->backing) {
         int64_t nb_cow_sectors = to_allocate * s->tracks;
         int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
@@ -864,8 +868,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
     }
     if (s->data_end < s->header_size) {
-        /* there is not enough unused space to fit to block align between BAT
-           and actual data. We can't avoid read-modify-write... */
+        /*
+         * There is not enough unused space to fit to block align between BAT
+         * and actual data. We can't avoid read-modify-write...
+         */
         s->header_size = size;
     }
 
-- 
2.34.1


