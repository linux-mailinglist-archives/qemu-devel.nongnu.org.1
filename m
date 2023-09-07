Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E7797DB3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeM99-0004Ox-Sz; Thu, 07 Sep 2023 17:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeM97-0004OU-PF; Thu, 07 Sep 2023 17:02:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeM94-00032W-EV; Thu, 07 Sep 2023 17:02:37 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qeM5r-00EPgQ-06;
 Thu, 07 Sep 2023 23:02:26 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 1/2] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Date: Fri,  8 Sep 2023 00:02:25 +0300
Message-Id: <20230907210226.953821-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
References: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Functions qcow2_get_host_offset(), get_cluster_offset(),
vmdk_co_block_status() explicitly report compressed cluster types when data
is compressed.  However, this information is never passed further.  Let's
make use of it by adding new BDRV_BLOCK_COMPRESSED flag for
bdrv_block_status(), so that caller may know that the data range is
compressed.  In particular, we're going to use this flag to tweak
"qemu-img map" output.

This new flag is only being utilized by qcow, qcow2 and vmdk formats, as only
those support compression.

Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow.c                 | 5 ++++-
 block/qcow2.c                | 3 +++
 block/vmdk.c                 | 2 ++
 include/block/block-common.h | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/qcow.c b/block/qcow.c
index 577bd70324..d56d24ab6d 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -549,7 +549,10 @@ qcow_co_block_status(BlockDriverState *bs, bool want_zero,
     if (!cluster_offset) {
         return 0;
     }
-    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
+    if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_COMPRESSED;
+    }
+    if (s->crypto) {
         return BDRV_BLOCK_DATA;
     }
     *map = cluster_offset | index_in_cluster;
diff --git a/block/qcow2.c b/block/qcow2.c
index b48cd9ce63..b81dc5066b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2162,6 +2162,9 @@ qcow2_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
     {
         status |= BDRV_BLOCK_RECURSE;
     }
+    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
+        status |= BDRV_BLOCK_COMPRESSED;
+    }
     return status;
 }
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 70066c2b01..56b3d5151d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1770,6 +1770,8 @@ vmdk_co_block_status(BlockDriverState *bs, bool want_zero,
             if (extent->flat) {
                 ret |= BDRV_BLOCK_RECURSE;
             }
+        } else {
+            ret |= BDRV_BLOCK_COMPRESSED;
         }
         *file = extent->file->bs;
         break;
diff --git a/include/block/block-common.h b/include/block/block-common.h
index df5ffc8d09..5b5ae07c93 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -287,6 +287,8 @@ typedef enum {
  *                       layer rather than any backing, set by block layer
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
  *                 layer, set by block layer
+ * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only valid for
+ *                        the formats supporting compression: qcow, qcow2
  *
  * Internal flags:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
@@ -322,6 +324,7 @@ typedef enum {
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
+#define BDRV_BLOCK_COMPRESSED   0x80
 
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
-- 
2.39.3


