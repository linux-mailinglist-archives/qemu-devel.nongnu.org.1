Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7857E489B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:47:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R69-0004EQ-1g; Tue, 07 Nov 2023 13:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5f-0003vK-Il
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5b-0001Tg-VA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gysl0ZBHgyXFksr4RgfuRtuFuCtAWWPUOnQr7I7eCo=;
 b=PP4iat+RbKIAGlnF364DrftNhDOoveqSeh/KC7hsfiWtR8UxczhODn+OkXbQSh5NWG9Zcb
 mkt8U1aIqirlXMwSAjgvRJ4Z+eSyclppXykAIL+9jG+7tkjC7gM1CHqcfCwNOp46vtymBP
 V2y8xpjKEc9aBLgJHt1AHnQQqVpZ6O0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-EY1Qia7IPNa3A6rbKcPDRA-1; Tue, 07 Nov 2023 13:46:13 -0500
X-MC-Unique: EY1Qia7IPNa3A6rbKcPDRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2B50832D69
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9E4C1596F;
 Tue,  7 Nov 2023 18:46:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 07/25] block: Mark bdrv_skip_implicit_filters() and callers
 GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:47 +0100
Message-ID: <20231107184605.236540-8-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bdrv_skip_implicit_filters() need to hold a reader lock for the graph
because it calls bdrv_filter_child(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-8-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-global-state.h |  3 ++-
 block.c                                | 28 +++++++++++++++++---------
 block/monitor/block-hmp-cmds.c         |  3 +++
 blockdev.c                             | 14 +++++++------
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index afce6c4416..ef31c58bb3 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -277,7 +277,8 @@ BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
                                            Error **errp);
 
 
-BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
+BlockDriverState * GRAPH_RDLOCK
+bdrv_skip_implicit_filters(BlockDriverState *bs);
 
 /**
  * bdrv_add_aio_context_notifier:
diff --git a/block.c b/block.c
index a6060eddbc..7e8b39711b 100644
--- a/block.c
+++ b/block.c
@@ -4778,6 +4778,8 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         return 0;
     }
 
+    bdrv_graph_rdlock_main_loop();
+
     switch (qobject_type(value)) {
     case QTYPE_QNULL:
         assert(is_backing); /* The 'file' option does not allow a null value */
@@ -4787,17 +4789,16 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         str = qstring_get_str(qobject_to(QString, value));
         new_child_bs = bdrv_lookup_bs(NULL, str, errp);
         if (new_child_bs == NULL) {
-            return -EINVAL;
+            ret = -EINVAL;
+            goto out_rdlock;
         }
 
-        bdrv_graph_rdlock_main_loop();
         has_child = bdrv_recurse_has_child(new_child_bs, bs);
-        bdrv_graph_rdunlock_main_loop();
-
         if (has_child) {
             error_setg(errp, "Making '%s' a %s child of '%s' would create a "
                        "cycle", str, child_name, bs->node_name);
-            return -EINVAL;
+            ret = -EINVAL;
+            goto out_rdlock;
         }
         break;
     default:
@@ -4809,18 +4810,21 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     }
 
     if (old_child_bs == new_child_bs) {
-        return 0;
+        ret = 0;
+        goto out_rdlock;
     }
 
     if (old_child_bs) {
         if (bdrv_skip_implicit_filters(old_child_bs) == new_child_bs) {
-            return 0;
+            ret = 0;
+            goto out_rdlock;
         }
 
         if (old_child_bs->implicit) {
             error_setg(errp, "Cannot replace implicit %s child of %s",
                        child_name, bs->node_name);
-            return -EPERM;
+            ret = -EPERM;
+            goto out_rdlock;
         }
     }
 
@@ -4831,7 +4835,8 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
          */
         error_setg(errp, "'%s' is a %s filter node that does not support a "
                    "%s child", bs->node_name, bs->drv->format_name, child_name);
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out_rdlock;
     }
 
     if (is_backing) {
@@ -4852,6 +4857,7 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         aio_context_acquire(ctx);
     }
 
+    bdrv_graph_rdunlock_main_loop();
     bdrv_graph_wrlock(new_child_bs);
 
     ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
@@ -4870,6 +4876,10 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     }
 
     return ret;
+
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
+    return ret;
 }
 
 /*
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 5b2c597e7a..c729cbf1eb 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -206,6 +206,9 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
     BlockBackend *blk;
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!strcmp(device, "all")) {
         ret = blk_commit_all();
     } else {
diff --git a/blockdev.c b/blockdev.c
index 4cb8e1d91a..6cdf48beb1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1746,10 +1746,10 @@ static void drive_backup_action(DriveBackup *backup,
         assert(format);
         if (source) {
             /* Implicit filters should not appear in the filename */
-            BlockDriverState *explicit_backing =
-                bdrv_skip_implicit_filters(source);
+            BlockDriverState *explicit_backing;
 
             bdrv_graph_rdlock_main_loop();
+            explicit_backing = bdrv_skip_implicit_filters(source);
             bdrv_refresh_filename(explicit_backing);
             bdrv_graph_rdunlock_main_loop();
 
@@ -3108,16 +3108,18 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         bdrv_img_create(arg->target, format,
                         NULL, NULL, NULL, size, flags, false, &local_err);
     } else {
-        /* Implicit filters should not appear in the filename */
-        BlockDriverState *explicit_backing =
-            bdrv_skip_implicit_filters(target_backing_bs);
+        BlockDriverState *explicit_backing;
 
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
             break;
         case NEW_IMAGE_MODE_ABSOLUTE_PATHS:
-            /* create new image with backing file */
+            /*
+             * Create new image with backing file.
+             * Implicit filters should not appear in the filename.
+             */
             bdrv_graph_rdlock_main_loop();
+            explicit_backing = bdrv_skip_implicit_filters(target_backing_bs);
             bdrv_refresh_filename(explicit_backing);
             bdrv_graph_rdunlock_main_loop();
 
-- 
2.41.0


