Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F767717D9F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcL-0007Zm-Dj; Wed, 31 May 2023 07:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0007QH-QC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbr-0001fz-4W
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwbOjCEJs8O+/peU3WfjZvUeay7SQbRYnqv6qoXOGhk=;
 b=c/Z5SHtC+UgMqsE9t50z8deIhhQ4bx+HpVBfI1jhxpYNXydlCpFufO4ScjojuIg3aBJQxb
 W28xmmS+3QaKg4jQmhXyoxGVbH/5Iksd8UptAVgbxL7iB9QYM2bbu+mKZ+x6/NG8DRIkYw
 Do6FQU0/M7Onf+faDYTLZsZ9kJZDfxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-RwQr5-XWNXuxwr9Ql4sH-g-1; Wed, 31 May 2023 07:02:49 -0400
X-MC-Unique: RwQr5-XWNXuxwr9Ql4sH-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73C4485A5BB;
 Wed, 31 May 2023 11:02:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBCD2029F6D;
 Wed, 31 May 2023 11:02:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 07/11] block: Fix AioContext locking in bdrv_open_inherit()
Date: Wed, 31 May 2023 13:02:27 +0200
Message-Id: <20230531110231.262251-8-kwolf@redhat.com>
In-Reply-To: <20230531110231.262251-1-kwolf@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index a0793b6435..954b9923d9 100644
--- a/block.c
+++ b/block.c
@@ -3794,6 +3794,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot = NULL;
+    AioContext *ctx = bdrv_get_aio_context(bs);
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -3802,7 +3803,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
        instead of opening 'filename' directly */
 
     /* Get the required size from the image */
+    aio_context_acquire(ctx);
     total_size = bdrv_getlength(bs);
+    aio_context_release(ctx);
+
     if (total_size < 0) {
         error_setg_errno(errp, -total_size, "Could not get image size");
         goto out;
@@ -3836,7 +3840,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
         goto out;
     }
 
+    aio_context_acquire(ctx);
     ret = bdrv_append(bs_snapshot, bs, errp);
+    aio_context_release(ctx);
+
     if (ret < 0) {
         bs_snapshot = NULL;
         goto out;
@@ -3880,6 +3887,7 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     Error *local_err = NULL;
     QDict *snapshot_options = NULL;
     int snapshot_flags = 0;
+    AioContext *ctx = qemu_get_aio_context();
 
     assert(!child_class || !flags);
     assert(!child_class == !parent);
@@ -4017,9 +4025,13 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
             /* Not requesting BLK_PERM_CONSISTENT_READ because we're only
              * looking at the header to guess the image format. This works even
              * in cases where a guest would not see a consistent state. */
-            file = blk_new(bdrv_get_aio_context(file_bs), 0, BLK_PERM_ALL);
+            ctx = bdrv_get_aio_context(file_bs);
+            aio_context_acquire(ctx);
+            file = blk_new(ctx, 0, BLK_PERM_ALL);
             blk_insert_bs(file, file_bs, &local_err);
             bdrv_unref(file_bs);
+            aio_context_release(ctx);
+
             if (local_err) {
                 goto fail;
             }
@@ -4065,8 +4077,13 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
         goto fail;
     }
 
+    /* The AioContext could have changed during bdrv_open_common() */
+    ctx = bdrv_get_aio_context(bs);
+
     if (file) {
+        aio_context_acquire(ctx);
         blk_unref(file);
+        aio_context_release(ctx);
         file = NULL;
     }
 
@@ -4124,13 +4141,16 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
          * (snapshot_bs); thus, we have to drop the strong reference to bs
          * (which we obtained by calling bdrv_new()). bs will not be deleted,
          * though, because the overlay still has a reference to it. */
+        aio_context_acquire(ctx);
         bdrv_unref(bs);
+        aio_context_release(ctx);
         bs = snapshot_bs;
     }
 
     return bs;
 
 fail:
+    aio_context_acquire(ctx);
     blk_unref(file);
     qobject_unref(snapshot_options);
     qobject_unref(bs->explicit_options);
@@ -4139,11 +4159,14 @@ fail:
     bs->options = NULL;
     bs->explicit_options = NULL;
     bdrv_unref(bs);
+    aio_context_release(ctx);
     error_propagate(errp, local_err);
     return NULL;
 
 close_and_fail:
+    aio_context_acquire(ctx);
     bdrv_unref(bs);
+    aio_context_release(ctx);
     qobject_unref(snapshot_options);
     qobject_unref(options);
     error_propagate(errp, local_err);
-- 
2.40.1


