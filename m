Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A917169D9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42ID-0007k8-97; Tue, 30 May 2023 12:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HH-0006Nx-1h
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HF-0008EG-Al
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFmwsZj7mEJbuyFquMgG1tFmHr+v8B1z2+1WMORARnM=;
 b=MsHmyt6PoIoK3i+z13x24S2c1xR2fTe74DyvudYnh5uPr2IlxYLIfv1zR8+bSdcW+nEoOv
 jcxQRPj43q4I2fRGbS8yTXjfDBiuXCtgdkGHl8J4Ck1Cz2U41CD1Ujc/2zwosFCay9n2IG
 auJALeGjToBHpRLYvbzRicqR9JIeN64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-uU_9FGYmM8qmmJBrz1Jazg-1; Tue, 30 May 2023 12:32:51 -0400
X-MC-Unique: uU_9FGYmM8qmmJBrz1Jazg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2246185A78F;
 Tue, 30 May 2023 16:32:50 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22482C154D2;
 Tue, 30 May 2023 16:32:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/32] block-backend: Fix blk_new_open() for iothreads
Date: Tue, 30 May 2023 18:32:11 +0200
Message-Id: <20230530163239.576632-5-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This fixes blk_new_open() to not assume that bs is in the main context.

In particular, the BlockBackend must be created with the right
AioContext because it will refuse to move to a different context
afterwards. (blk->allow_aio_context_change is false.)

Use this opportunity to use blk_insert_bs() instead of duplicating the
bdrv_root_attach_child() call. This is consistent with what
blk_new_with_bs() does. Add comments to document the locking rules.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-5-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 1d89fabd35..dde60e0f71 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -389,6 +389,8 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
  * Both sets of permissions can be changed later using blk_set_perm().
  *
  * Return the new BlockBackend on success, null on failure.
+ *
+ * Callers must hold the AioContext lock of @bs.
  */
 BlockBackend *blk_new_with_bs(BlockDriverState *bs, uint64_t perm,
                               uint64_t shared_perm, Error **errp)
@@ -406,11 +408,15 @@ BlockBackend *blk_new_with_bs(BlockDriverState *bs, uint64_t perm,
 
 /*
  * Creates a new BlockBackend, opens a new BlockDriverState, and connects both.
- * The new BlockBackend is in the main AioContext.
+ * By default, the new BlockBackend is in the main AioContext, but if the
+ * parameters connect it with any existing node in a different AioContext, it
+ * may end up there instead.
  *
  * Just as with bdrv_open(), after having called this function the reference to
  * @options belongs to the block layer (even on failure).
  *
+ * Called without holding an AioContext lock.
+ *
  * TODO: Remove @filename and @flags; it should be possible to specify a whole
  * BDS tree just by specifying the @options QDict (or @reference,
  * alternatively). At the time of adding this function, this is not possible,
@@ -422,6 +428,7 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
 {
     BlockBackend *blk;
     BlockDriverState *bs;
+    AioContext *ctx;
     uint64_t perm = 0;
     uint64_t shared = BLK_PERM_ALL;
 
@@ -451,18 +458,24 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
         shared = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
     }
 
-    blk = blk_new(qemu_get_aio_context(), perm, shared);
     aio_context_acquire(qemu_get_aio_context());
     bs = bdrv_open(filename, reference, options, flags, errp);
     aio_context_release(qemu_get_aio_context());
     if (!bs) {
-        blk_unref(blk);
         return NULL;
     }
 
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root,
-                                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                                       perm, shared, blk, errp);
+    /* bdrv_open() could have moved bs to a different AioContext */
+    ctx = bdrv_get_aio_context(bs);
+    blk = blk_new(bdrv_get_aio_context(bs), perm, shared);
+    blk->perm = perm;
+    blk->shared_perm = shared;
+
+    aio_context_acquire(ctx);
+    blk_insert_bs(blk, bs, errp);
+    bdrv_unref(bs);
+    aio_context_release(ctx);
+
     if (!blk->root) {
         blk_unref(blk);
         return NULL;
@@ -903,6 +916,8 @@ void blk_remove_bs(BlockBackend *blk)
 
 /*
  * Associates a new BlockDriverState with @blk.
+ *
+ * Callers must hold the AioContext lock of @bs.
  */
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
-- 
2.40.1


