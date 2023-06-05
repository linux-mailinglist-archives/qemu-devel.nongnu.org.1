Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC60722195
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q661y-0005dY-JU; Mon, 05 Jun 2023 04:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661s-0005br-37
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661o-0004sQ-4A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXzk+wTY/wPTx+vScZUjOzTefhoJYcLpzD/2LCLqaO0=;
 b=Atf5efkJrpdj84gAegSc0HBtfCJ1F5m+8XYDExuiz2b8MNQMY5P7Wrk3wX2SjuVgVljK5J
 eU3Fk8mCecT3c6YJG/BGqTdEbgkX7ZYdYL37LXc7Bm4EtV3WGIAOC2NJ85bmEZByIg7HZC
 ZpkBToKl+GZ2p91EkSiGkebsiraMoxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-59H5fcNUNU6i6KKEsUfiTQ-1; Mon, 05 Jun 2023 04:57:23 -0400
X-MC-Unique: 59H5fcNUNU6i6KKEsUfiTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1DE8037AB;
 Mon,  5 Jun 2023 08:57:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C97840C6EC4;
 Mon,  5 Jun 2023 08:57:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] block: Fix AioContext locking in
 bdrv_reopen_parse_file_or_backing()
Date: Mon,  5 Jun 2023 10:57:06 +0200
Message-Id: <20230605085711.21261-7-kwolf@redhat.com>
In-Reply-To: <20230605085711.21261-1-kwolf@redhat.com>
References: <20230605085711.21261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

bdrv_set_file_or_backing_noperm() requires the caller to hold the
AioContext lock for the child node, but we hold the one for the parent
node in bdrv_reopen_parse_file_or_backing(). Take the other one
temporarily.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 508e0e396b..a0793b6435 100644
--- a/block.c
+++ b/block.c
@@ -3366,6 +3366,10 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * callers which don't need their own reference any more must call bdrv_unref().
  *
  * Function doesn't update permissions, caller is responsible for this.
+ *
+ * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
+ * @child_bs can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
  */
 static int bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
                                            BlockDriverState *child_bs,
@@ -3454,6 +3458,11 @@ out:
     return 0;
 }
 
+/*
+ * The caller must hold the AioContext lock for @backing_hd. Both @bs and
+ * @backing_hd can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
+ */
 static int bdrv_set_backing_noperm(BlockDriverState *bs,
                                    BlockDriverState *backing_hd,
                                    Transaction *tran, Error **errp)
@@ -4606,6 +4615,11 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
  * backing BlockDriverState (or NULL).
  *
  * Return 0 on success, otherwise return < 0 and set @errp.
+ *
+ * The caller must hold the AioContext lock of @reopen_state->bs.
+ * @reopen_state->bs can move to a different AioContext in this function.
+ * Callers must make sure that their AioContext locking is still correct after
+ * this.
  */
 static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
                                              bool is_backing, Transaction *tran,
@@ -4618,6 +4632,8 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     const char *child_name = is_backing ? "backing" : "file";
     QObject *value;
     const char *str;
+    AioContext *ctx, *old_ctx;
+    int ret;
 
     GLOBAL_STATE_CODE();
 
@@ -4682,8 +4698,22 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         reopen_state->old_file_bs = old_child_bs;
     }
 
-    return bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
-                                           tran, errp);
+    old_ctx = bdrv_get_aio_context(bs);
+    ctx = bdrv_get_aio_context(new_child_bs);
+    if (old_ctx != ctx) {
+        aio_context_release(old_ctx);
+        aio_context_acquire(ctx);
+    }
+
+    ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
+                                          tran, errp);
+
+    if (old_ctx != ctx) {
+        aio_context_release(ctx);
+        aio_context_acquire(old_ctx);
+    }
+
+    return ret;
 }
 
 /*
@@ -4702,6 +4732,7 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
  * It is the responsibility of the caller to then call the abort() or
  * commit() for any other BDS that have been left in a prepare() state
  *
+ * The caller must hold the AioContext lock of @reopen_state->bs.
  */
 static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue,
-- 
2.40.1


