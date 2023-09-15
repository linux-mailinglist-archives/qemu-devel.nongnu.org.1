Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F817A214F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3T-0000OL-2H; Fri, 15 Sep 2023 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3J-0000FX-I7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3I-00054u-23
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAAXGoVYfGtAd8sOviDiPnrPj08h0vb9O4fX5YoMGFs=;
 b=UmNyOrsGx6AQc2DEbSDovvCiMh1AVKqiT4vzfWQPH4jnTNHzqUKPMErW9zz6eyZxX4Idlz
 dY8KAhWNGti9F+lQaImSfpsNrlYCwg89iszWiuquIDr9TpgJ7y44Z66P0Mvw4nzM+7cj3X
 d/W7fADn9uM1q56HcAEdDMZxkJKoi4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-H_GRdKBRMrGKUD3CShIDIg-1; Fri, 15 Sep 2023 10:44:07 -0400
X-MC-Unique: H_GRdKBRMrGKUD3CShIDIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C58CE101B046;
 Fri, 15 Sep 2023 14:44:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32EBF2026D4B;
 Fri, 15 Sep 2023 14:44:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/28] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Date: Fri, 15 Sep 2023 16:43:38 +0200
Message-ID: <20230915144344.238596-23-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrey Drobyshev via <qemu-block@nongnu.org>

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
Message-ID: <20230907210226.953821-2-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h | 3 +++
 block/qcow.c                 | 5 ++++-
 block/qcow2.c                | 3 +++
 block/vmdk.c                 | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 3bbc5d9294..2d2af7230d 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -291,6 +291,8 @@ typedef enum {
  *                       layer rather than any backing, set by block layer
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
  *                 layer, set by block layer
+ * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only valid for
+ *                        the formats supporting compression: qcow, qcow2
  *
  * Internal flags:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
@@ -326,6 +328,7 @@ typedef enum {
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
+#define BDRV_BLOCK_COMPRESSED   0x80
 
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
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
index 071004b302..af43d59d76 100644
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
index 78baa04c0c..e90649c8bf 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1783,6 +1783,8 @@ vmdk_co_block_status(BlockDriverState *bs, bool want_zero,
             if (extent->flat) {
                 ret |= BDRV_BLOCK_RECURSE;
             }
+        } else {
+            ret |= BDRV_BLOCK_COMPRESSED;
         }
         *file = extent->file->bs;
         break;
-- 
2.41.0


