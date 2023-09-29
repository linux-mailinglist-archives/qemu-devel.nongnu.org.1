Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF67B2E60
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DY-00056q-T1; Fri, 29 Sep 2023 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DM-0004xy-J4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9D9-0005ac-9d
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4otJMtuOYgwSMwM9aP6q2uWi5OdTkPSIruBqZNSp0k=;
 b=DXLc0Do8GGeARlDRzGYgIqfR93jaKSSRxY8o8VzDLLFLN1bp5fiM2/s1IzDoyDChF1LBqn
 cSEdAvgkhXLVggEoBlrHEk2Zvux46r5XFTDnUk78F78eb9lWl9Hd+cy1/Wc3L3yTHTvHOf
 4hvUh9o/pujJMQ+WBGo1rjT464rBR/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-t_TV9VDtPuq2N2cHoh8Zgw-1; Fri, 29 Sep 2023 04:50:54 -0400
X-MC-Unique: t_TV9VDtPuq2N2cHoh8Zgw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85F0C801779
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63208492B05
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B3E221E690C; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 04/56] block/dirty-bitmap: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:01 +0200
Message-ID: <20230929085053.2789105-5-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Tracked down with -Wshadow=local.
Clean up: rename both the pair of parameters and the pair of local
variables.  While there, move the local variables to function scope.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230921121312.1301864-5-armbru@redhat.com>
---
 block/monitor/bitmap-qmp-cmds.c | 19 ++++++++++---------
 block/qcow2-bitmap.c            |  3 +--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index 55f778f5af..70d01a3776 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -258,37 +258,38 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
-BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
+BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *dst_node,
+                                          const char *dst_bitmap,
                                           BlockDirtyBitmapOrStrList *bms,
                                           HBitmap **backup, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *dst, *src;
     BlockDirtyBitmapOrStrList *lst;
+    const char *src_node, *src_bitmap;
     HBitmap *local_backup = NULL;
 
     GLOBAL_STATE_CODE();
 
-    dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
+    dst = block_dirty_bitmap_lookup(dst_node, dst_bitmap, &bs, errp);
     if (!dst) {
         return NULL;
     }
 
     for (lst = bms; lst; lst = lst->next) {
         switch (lst->value->type) {
-            const char *name, *node;
         case QTYPE_QSTRING:
-            name = lst->value->u.local;
-            src = bdrv_find_dirty_bitmap(bs, name);
+            src_bitmap = lst->value->u.local;
+            src = bdrv_find_dirty_bitmap(bs, src_bitmap);
             if (!src) {
-                error_setg(errp, "Dirty bitmap '%s' not found", name);
+                error_setg(errp, "Dirty bitmap '%s' not found", src_bitmap);
                 goto fail;
             }
             break;
         case QTYPE_QDICT:
-            node = lst->value->u.external.node;
-            name = lst->value->u.external.name;
-            src = block_dirty_bitmap_lookup(node, name, NULL, errp);
+            src_node = lst->value->u.external.node;
+            src_bitmap = lst->value->u.external.name;
+            src = block_dirty_bitmap_lookup(src_node, src_bitmap, NULL, errp);
             if (!src) {
                 goto fail;
             }
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 037fa2d435..ffd5cd3b23 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1555,7 +1555,6 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         const char *name = bdrv_dirty_bitmap_name(bitmap);
         uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
-        Qcow2Bitmap *bm;
 
         if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
             bdrv_dirty_bitmap_inconsistent(bitmap)) {
@@ -1625,7 +1624,7 @@ bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
 
     /* allocate clusters and store bitmaps */
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        BdrvDirtyBitmap *bitmap = bm->dirty_bitmap;
+        bitmap = bm->dirty_bitmap;
 
         if (bitmap == NULL || bdrv_dirty_bitmap_readonly(bitmap)) {
             continue;
-- 
2.41.0


