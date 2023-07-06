Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE474A237
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRtV-0008Rs-T5; Thu, 06 Jul 2023 12:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRso-0008Pz-IC; Thu, 06 Jul 2023 12:31:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRsg-0007Pt-1F; Thu, 06 Jul 2023 12:30:59 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qHRrH-00D6CC-0g;
 Thu, 06 Jul 2023 18:30:47 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Date: Thu,  6 Jul 2023 19:30:45 +0300
Message-Id: <20230706163047.128999-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index c51388e99d..77885fe27c 100644
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
index e15395f2cb..f7a4e7d4db 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -282,6 +282,8 @@ typedef enum {
  *                       layer rather than any backing, set by block layer
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
  *                 layer, set by block layer
+ * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only valid for
+ *                        the formats supporting compression: qcow, qcow2
  *
  * Internal flags:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
@@ -317,6 +319,7 @@ typedef enum {
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
+#define BDRV_BLOCK_COMPRESSED   0x80
 
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
-- 
2.39.3


