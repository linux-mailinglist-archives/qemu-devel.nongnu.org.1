Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CB7C729B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySs-0003bn-Dj; Thu, 12 Oct 2023 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySf-0003W7-6Z
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000aX-Ix
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlN6iMJXkvZ5CxaOBhxGfG4aTt2NXDSLahJ4Qvh91PM=;
 b=aOUFy7tgU2/uMLG7mG1N863NFy32ipQQFMPDnZloJQLxB7uu5jpEPPmxZFyPX98NqxIfHR
 LhnT7ns9KK5/s72MB2yd5vkMNaLCvBRL4XErxOJ/W0QVVvyB0DVM0ZkjEbj23ng8t/CBCE
 CLpuBBxH+ILQfM/Fs1QxSM/rzcX/ibQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-wU8iDFY7NdKt2Ia21aYq-A-1; Thu, 12 Oct 2023 12:22:45 -0400
X-MC-Unique: wU8iDFY7NdKt2Ia21aYq-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D6668039C1;
 Thu, 12 Oct 2023 16:22:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1BA920296DB;
 Thu, 12 Oct 2023 16:22:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/26] block: Mark bdrv_snapshot_fallback() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:09 +0200
Message-ID: <20231012162224.240535-12-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_snapshot_fallback() need to hold a reader lock for the graph
because it accesses the children list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-8-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 18 ++++++++--------
 include/block/snapshot.h         | 24 +++++++++++++---------
 block/snapshot.c                 | 35 ++++++++++++++++++++++++++------
 blockdev.c                       |  9 ++++++++
 qemu-img.c                       |  5 +++++
 5 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 8ef68176a5..29c5b8a3c5 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -313,14 +313,16 @@ struct BlockDriver {
 
     int GRAPH_RDLOCK_PTR (*bdrv_inactivate)(BlockDriverState *bs);
 
-    int (*bdrv_snapshot_create)(BlockDriverState *bs,
-                                QEMUSnapshotInfo *sn_info);
-    int (*bdrv_snapshot_goto)(BlockDriverState *bs,
-                              const char *snapshot_id);
-    int (*bdrv_snapshot_delete)(BlockDriverState *bs,
-                                const char *snapshot_id,
-                                const char *name,
-                                Error **errp);
+    int GRAPH_RDLOCK_PTR (*bdrv_snapshot_create)(
+        BlockDriverState *bs, QEMUSnapshotInfo *sn_info);
+
+    int GRAPH_UNLOCKED_PTR (*bdrv_snapshot_goto)(
+        BlockDriverState *bs, const char *snapshot_id);
+
+    int GRAPH_RDLOCK_PTR (*bdrv_snapshot_delete)(
+        BlockDriverState *bs, const char *snapshot_id, const char *name,
+        Error **errp);
+
     int (*bdrv_snapshot_list)(BlockDriverState *bs,
                               QEMUSnapshotInfo **psn_info);
     int (*bdrv_snapshot_load_tmp)(BlockDriverState *bs,
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 50ff924710..d49c5599d9 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -25,6 +25,7 @@
 #ifndef SNAPSHOT_H
 #define SNAPSHOT_H
 
+#include "block/graph-lock.h"
 #include "qapi/qapi-builtin-types.h"
 
 #define SNAPSHOT_OPT_BASE       "snapshot."
@@ -59,16 +60,19 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
                                        const char *name,
                                        QEMUSnapshotInfo *sn_info,
                                        Error **errp);
-int bdrv_can_snapshot(BlockDriverState *bs);
-int bdrv_snapshot_create(BlockDriverState *bs,
-                         QEMUSnapshotInfo *sn_info);
-int bdrv_snapshot_goto(BlockDriverState *bs,
-                       const char *snapshot_id,
-                       Error **errp);
-int bdrv_snapshot_delete(BlockDriverState *bs,
-                         const char *snapshot_id,
-                         const char *name,
-                         Error **errp);
+
+int GRAPH_RDLOCK bdrv_can_snapshot(BlockDriverState *bs);
+
+int GRAPH_RDLOCK
+bdrv_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info);
+
+int GRAPH_UNLOCKED
+bdrv_snapshot_goto(BlockDriverState *bs, const char *snapshot_id, Error **errp);
+
+int GRAPH_RDLOCK
+bdrv_snapshot_delete(BlockDriverState *bs, const char *snapshot_id,
+                     const char *name, Error **errp);
+
 int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info);
 int bdrv_snapshot_load_tmp(BlockDriverState *bs,
diff --git a/block/snapshot.c b/block/snapshot.c
index 633391e8a9..554065578b 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -155,11 +155,15 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
  * back if the given BDS does not support snapshots.
  * Return NULL if there is no BDS to (safely) fall back to.
  */
-static BdrvChild *bdrv_snapshot_fallback_child(BlockDriverState *bs)
+static BdrvChild * GRAPH_RDLOCK
+bdrv_snapshot_fallback_child(BlockDriverState *bs)
 {
     BdrvChild *fallback = bdrv_primary_child(bs);
     BdrvChild *child;
 
+    GLOBAL_STATE_CODE();
+    assert_bdrv_graph_readable();
+
     /* We allow fallback only to primary child */
     if (!fallback) {
         return NULL;
@@ -182,8 +186,10 @@ static BdrvChild *bdrv_snapshot_fallback_child(BlockDriverState *bs)
     return fallback;
 }
 
-static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)
+static BlockDriverState * GRAPH_RDLOCK
+bdrv_snapshot_fallback(BlockDriverState *bs)
 {
+    GLOBAL_STATE_CODE();
     return child_bs(bdrv_snapshot_fallback_child(bs));
 }
 
@@ -254,7 +260,10 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
 
+    bdrv_graph_rdlock_main_loop();
     fallback = bdrv_snapshot_fallback_child(bs);
+    bdrv_graph_rdunlock_main_loop();
+
     if (fallback) {
         QDict *options;
         QDict *file_options;
@@ -374,10 +383,12 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
 int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     BlockDriver *drv = bs->drv;
     BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
 
-    GLOBAL_STATE_CODE();
     if (!drv) {
         return -ENOMEDIUM;
     }
@@ -498,6 +509,9 @@ bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
 
 static bool GRAPH_RDLOCK bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
 {
+    GLOBAL_STATE_CODE();
+    assert_bdrv_graph_readable();
+
     if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
         return false;
     }
@@ -595,11 +609,15 @@ int bdrv_all_goto_snapshot(const char *name,
 {
     g_autoptr(GList) bdrvs = NULL;
     GList *iterbdrvs;
+    int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+    bdrv_graph_rdlock_main_loop();
+    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
+    bdrv_graph_rdunlock_main_loop();
+
+    if (ret < 0) {
         return -1;
     }
 
@@ -608,9 +626,14 @@ int bdrv_all_goto_snapshot(const char *name,
         BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
         int ret = 0;
+        bool all_snapshots_includes_bs;
 
         aio_context_acquire(ctx);
-        if (devices || bdrv_all_snapshots_includes_bs(bs)) {
+        bdrv_graph_rdlock_main_loop();
+        all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
+        bdrv_graph_rdunlock_main_loop();
+
+        if (devices || all_snapshots_includes_bs) {
             ret = bdrv_snapshot_goto(bs, name, errp);
         }
         aio_context_release(ctx);
diff --git a/blockdev.c b/blockdev.c
index b6b7c44288..43e0c4ddf2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1138,6 +1138,9 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     SnapshotInfo *info = NULL;
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
         return NULL;
@@ -1223,6 +1226,9 @@ static void internal_snapshot_action(BlockdevSnapshotInternal *internal,
     AioContext *aio_context;
     int ret1;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     tran_add(tran, &internal_snapshot_drv, state);
 
     device = internal->device;
@@ -1311,6 +1317,9 @@ static void internal_snapshot_abort(void *opaque)
     AioContext *aio_context;
     Error *local_error = NULL;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!state->created) {
         return;
     }
diff --git a/qemu-img.c b/qemu-img.c
index 6068ab0d27..5a74e9b10e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3470,7 +3470,10 @@ static int img_snapshot(int argc, char **argv)
         sn.date_sec = rt / G_USEC_PER_SEC;
         sn.date_nsec = (rt % G_USEC_PER_SEC) * 1000;
 
+        bdrv_graph_rdlock_main_loop();
         ret = bdrv_snapshot_create(bs, &sn);
+        bdrv_graph_rdunlock_main_loop();
+
         if (ret) {
             error_report("Could not create snapshot '%s': %s",
                 snapshot_name, strerror(-ret));
@@ -3486,6 +3489,7 @@ static int img_snapshot(int argc, char **argv)
         break;
 
     case SNAPSHOT_DELETE:
+        bdrv_graph_rdlock_main_loop();
         ret = bdrv_snapshot_find(bs, &sn, snapshot_name);
         if (ret < 0) {
             error_report("Could not delete snapshot '%s': snapshot not "
@@ -3499,6 +3503,7 @@ static int img_snapshot(int argc, char **argv)
                 ret = 1;
             }
         }
+        bdrv_graph_rdunlock_main_loop();
         break;
     }
 
-- 
2.41.0


