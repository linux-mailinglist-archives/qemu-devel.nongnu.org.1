Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62B7169BA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:35:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IB-0007cJ-Tt; Tue, 30 May 2023 12:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HO-0006Wq-FQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HL-0008Gz-TF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nfp1QYTgcYnCvbyCQgd9+AsYb38Acvt02na2ryMYY0=;
 b=f4knlCEElu99lkngIL1eMXUnokgwKYLH2/5FFKWGBglstN/hCQAIpuzTaGgUlH+u4ld3mo
 UUPxNPX5Oy5/HcdD2692H2LIB4i55h/2UHTZBSOgdsg1dcvygJFxF0tznMNGYjab9xrPGj
 iPyKCWEfWA/Vhn0cLhdt2e/mOigD0xs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-sk32MJsRPDWPgYEfMq75Ng-1; Tue, 30 May 2023 12:32:55 -0400
X-MC-Unique: sk32MJsRPDWPgYEfMq75Ng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABC972A5957F;
 Tue, 30 May 2023 16:32:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8FB8C0448F;
 Tue, 30 May 2023 16:32:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/32] copy-before-write: Fix open with child in iothread
Date: Tue, 30 May 2023 18:32:15 +0200
Message-Id: <20230530163239.576632-9-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

The AioContext lock must not be held for bdrv_open_child(), but it is
necessary for the following operations, in particular those using nested
event loops in coroutine wrappers.

Temporarily dropping the main AioContext lock is not necessary because
we know we run in the main thread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-9-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/copy-before-write.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 646d8227a4..b866e42271 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -412,6 +412,7 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
     int64_t cluster_size;
     g_autoptr(BlockdevOptions) full_opts = NULL;
     BlockdevOptionsCbw *opts;
+    AioContext *ctx;
     int ret;
 
     full_opts = cbw_parse_options(options, errp);
@@ -432,11 +433,15 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+
     if (opts->bitmap) {
         bitmap = block_dirty_bitmap_lookup(opts->bitmap->node,
                                            opts->bitmap->name, NULL, errp);
         if (!bitmap) {
-            return -EINVAL;
+            ret = -EINVAL;
+            goto out;
         }
     }
     s->on_cbw_error = opts->has_on_cbw_error ? opts->on_cbw_error :
@@ -454,21 +459,24 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
     s->bcs = block_copy_state_new(bs->file, s->target, bitmap, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     cluster_size = block_copy_cluster_size(s->bcs);
 
     s->done_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
     if (!s->done_bitmap) {
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
     bdrv_disable_dirty_bitmap(s->done_bitmap);
 
     /* s->access_bitmap starts equal to bcs bitmap */
     s->access_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
     if (!s->access_bitmap) {
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
     bdrv_disable_dirty_bitmap(s->access_bitmap);
     bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
@@ -478,7 +486,10 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_co_mutex_init(&s->lock);
     QLIST_INIT(&s->frozen_read_reqs);
 
-    return 0;
+    ret = 0;
+out:
+    aio_context_release(ctx);
+    return ret;
 }
 
 static void cbw_close(BlockDriverState *bs)
-- 
2.40.1


