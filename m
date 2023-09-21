Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9987A9261
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEY0-00089j-4F; Thu, 21 Sep 2023 03:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEXh-0007aU-AZ; Thu, 21 Sep 2023 03:56:15 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEXe-0002De-T4; Thu, 21 Sep 2023 03:56:08 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWV-00BsUn-0D;
 Thu, 21 Sep 2023 09:55:07 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 19/22] parallels: naive implementation of
 parallels_co_pdiscard
Date: Thu, 21 Sep 2023 09:54:57 +0200
Message-Id: <20230921075500.694585-20-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075500.694585-1-den@openvz.org>
References: <20230921075500.694585-1-den@openvz.org>
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

* Discarding with backing stores is not supported by the format.
* There is no buffering/queueing of the discard operation.
* Only operations aligned to the cluster are supported.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index a97fb8b506..1808029f14 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -537,6 +537,51 @@ parallels_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     return ret;
 }
 
+
+static int coroutine_fn GRAPH_RDLOCK
+parallels_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    int ret = 0;
+    uint32_t cluster, count;
+    BDRVParallelsState *s = bs->opaque;
+
+    /*
+     * The image does not support ZERO mark inside the BAT, which means that
+     * stale data could be exposed from the backing file.
+     */
+    if (bs->backing) {
+        return -ENOTSUP;
+    }
+
+    if (!QEMU_IS_ALIGNED(offset, s->cluster_size)) {
+        return -ENOTSUP;
+    } else if (!QEMU_IS_ALIGNED(bytes, s->cluster_size)) {
+        return -ENOTSUP;
+    }
+
+    cluster = offset / s->cluster_size;
+    count = bytes / s->cluster_size;
+
+    qemu_co_mutex_lock(&s->lock);
+    for (; count > 0; cluster++, count--) {
+        int64_t host_off = bat2sect(s, cluster) << BDRV_SECTOR_BITS;
+        if (host_off == 0) {
+            continue;
+        }
+
+        ret = bdrv_co_pdiscard(bs->file, host_off, s->cluster_size);
+        if (ret < 0) {
+            goto done;
+        }
+
+        parallels_set_bat_entry(s, cluster, 0);
+        bitmap_clear(s->used_bmap, host_cluster_index(s, host_off), 1);
+    }
+done:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
+}
+
 static void parallels_check_unclean(BlockDriverState *bs,
                                     BdrvCheckResult *res,
                                     BdrvCheckMode fix)
@@ -1417,6 +1462,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_create             = parallels_co_create,
     .bdrv_co_create_opts        = parallels_co_create_opts,
     .bdrv_co_check              = parallels_co_check,
+    .bdrv_co_pdiscard           = parallels_co_pdiscard,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


