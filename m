Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BAE710C58
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AO2-0008LL-Cw; Thu, 25 May 2023 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANt-00087f-3n
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANU-00020X-7J
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKRy99Whp5k3dwJu4J4iC5wTaUNX+jBQIxXZEQ8DDA8=;
 b=QdvkofdbbVcrIz90LNCa2/N2BO8/RkollfDpy65qUX/Z3DBvpXQlXpiV+SH3SAsBMIIR/w
 WzNryQcKUzzzpo7/mF0dqFdC7FqAwbzqc25q0mHrOCzL9LtNpwrnKhD1Ah9R7NCzyxi5UW
 bkEJGeozRZTE8qJxmB7PtSl8s+u8fcM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-Dczj6oFVNU65SuZzvYfPQA-1; Thu, 25 May 2023 08:47:33 -0400
X-MC-Unique: Dczj6oFVNU65SuZzvYfPQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 117732A59541;
 Thu, 25 May 2023 12:47:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A7C07AF5;
 Thu, 25 May 2023 12:47:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 08/12] copy-before-write: Fix open with child in iothread
Date: Thu, 25 May 2023 14:47:09 +0200
Message-Id: <20230525124713.401149-9-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The AioContext lock must not be held for bdrv_open_child(), but it is
necessary for the followig operations, in particular those using nested
event loops in coroutine wrappers.

Temporarily dropping the main AioContext lock is not necessary because
we know we run in the main thread.

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


