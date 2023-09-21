Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435977A9267
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEYC-0001IN-Di; Thu, 21 Sep 2023 03:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEY9-00014K-Ey; Thu, 21 Sep 2023 03:56:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEY7-0002HL-Lf; Thu, 21 Sep 2023 03:56:37 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWS-00BsUn-23;
 Thu, 21 Sep 2023 09:55:05 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 12/22] parallels: collect bitmap of used clusters at open
Date: Thu, 21 Sep 2023 09:54:50 +0200
Message-Id: <20230921075500.694585-13-den@openvz.org>
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

If the operation is failed, we need to check image consistency if the
problem is not about memory allocation.

Bitmap adjustments in allocate_cluster are not performed yet.
They worth to be separate. This was proven useful during debug of this
series. Kept as is for future bissecting.

It should be specifically noted that used bitmap must be recalculated
if data_off has been fixed during image consistency check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 block/parallels.h |  3 ++
 2 files changed, 76 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 2b5f2b54a0..a997880c34 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -193,6 +193,58 @@ static int mark_used(BlockDriverState *bs,
     return 0;
 }
 
+/*
+ * Collect used bitmap. The image can contain errors, we should fill the
+ * bitmap anyway, as much as we can. This information will be used for
+ * error resolution.
+ */
+static int parallels_fill_used_bitmap(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t payload_bytes;
+    uint32_t i;
+    int err = 0;
+
+    payload_bytes = bdrv_getlength(bs->file->bs);
+    if (payload_bytes < 0) {
+        return payload_bytes;
+    }
+    payload_bytes -= s->data_start * BDRV_SECTOR_SIZE;
+    if (payload_bytes < 0) {
+        return -EINVAL;
+    }
+
+    s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
+    if (s->used_bmap_size == 0) {
+        return 0;
+    }
+    s->used_bmap = bitmap_try_new(s->used_bmap_size);
+    if (s->used_bmap == NULL) {
+        return -ENOMEM;
+    }
+
+    for (i = 0; i < s->bat_size; i++) {
+        int err2;
+        int64_t host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
+        if (host_off == 0) {
+            continue;
+        }
+
+        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off);
+        if (err2 < 0 && err == 0) {
+            err = err2;
+        }
+    }
+    return err;
+}
+
+static void parallels_free_used_bitmap(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    s->used_bmap_size = 0;
+    g_free(s->used_bmap);
+}
+
 static int64_t coroutine_fn GRAPH_RDLOCK
 allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                   int nb_sectors, int *pnum)
@@ -530,8 +582,17 @@ parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
 
     res->corruptions++;
     if (fix & BDRV_FIX_ERRORS) {
+        int err;
         s->header->data_off = cpu_to_le32(data_off);
         s->data_start = data_off;
+
+        parallels_free_used_bitmap(bs);
+        err = parallels_fill_used_bitmap(bs);
+        if (err == -ENOMEM) {
+            res->check_errors++;
+            return err;
+        }
+
         res->corruptions_fixed++;
     }
 
@@ -1222,6 +1283,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || s->data_end > file_nb_sectors;
 
+    if (!need_check) {
+        ret = parallels_fill_used_bitmap(bs);
+        if (ret == -ENOMEM) {
+            goto fail;
+        }
+        need_check = need_check || ret < 0; /* These are correctable errors */
+    }
+
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
      * want to change inactive images and can't change readonly images.
@@ -1251,6 +1320,8 @@ fail:
      * "s" object was allocated by g_malloc0 so we can safely
      * try to free its fields even they were not allocated.
      */
+    parallels_free_used_bitmap(bs);
+
     error_free(s->migration_blocker);
     g_free(s->bat_dirty_bmap);
     qemu_vfree(s->header);
@@ -1271,6 +1342,8 @@ static void parallels_close(BlockDriverState *bs)
                       PREALLOC_MODE_OFF, 0, NULL);
     }
 
+    parallels_free_used_bitmap(bs);
+
     g_free(s->bat_dirty_bmap);
     qemu_vfree(s->header);
 
diff --git a/block/parallels.h b/block/parallels.h
index 4e53e9572d..6b199443cf 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -72,6 +72,9 @@ typedef struct BDRVParallelsState {
     unsigned long *bat_dirty_bmap;
     unsigned int  bat_dirty_block;
 
+    unsigned long *used_bmap;
+    unsigned long used_bmap_size;
+
     uint32_t *bat_bitmap;
     unsigned int bat_size;
 
-- 
2.34.1


