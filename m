Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC081C008
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:25:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXI-0001At-TX; Thu, 21 Dec 2023 16:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQX9-0000Mb-7o
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQX4-0008BP-0t
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FV1G/fNZrZNWBOtzaRnp3gFfD7nJwtATb300xkY6Pbw=;
 b=QtvamjgnGHvUHQxUXbYU7qkIADEQ8SC3Xba01qi9hYGWls1HH6NuZBpqswR+pUI0jPORhO
 KBwvVHbebhzpRIbvic+NglvdJBb+nrrlHqnKjdE3EXJQhNThluzVetnp8Lg4E3Mn/rPyTJ
 N/GKKomvGvZCxygpqpCFN75GB+37fms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-sKT6e_O9Naq42arxMYqyNA-1; Thu, 21 Dec 2023 16:24:39 -0500
X-MC-Unique: sKT6e_O9Naq42arxMYqyNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00F8985A588;
 Thu, 21 Dec 2023 21:24:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59D49C15968;
 Thu, 21 Dec 2023 21:24:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/33] block: remove bdrv_co_lock()
Date: Thu, 21 Dec 2023 22:23:26 +0100
Message-ID: <20231221212339.164439-22-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The bdrv_co_lock() and bdrv_co_unlock() functions are already no-ops.
Remove them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231205182011.1976568-8-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 14 --------------
 block.c                            | 10 ----------
 blockdev.c                         |  5 -----
 3 files changed, 29 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 0327f1c605..4ec0b217f0 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -267,20 +267,6 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag);
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag);
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 
-/**
- * Locks the AioContext of @bs if it's not the current AioContext. This avoids
- * double locking which could lead to deadlocks: This is a coroutine_fn, so we
- * know we already own the lock of the current AioContext.
- *
- * May only be called in the main thread.
- */
-void coroutine_fn bdrv_co_lock(BlockDriverState *bs);
-
-/**
- * Unlocks the AioContext of @bs if it's not the current AioContext.
- */
-void coroutine_fn bdrv_co_unlock(BlockDriverState *bs);
-
 bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
                                    GHashTable *visited, Transaction *tran,
                                    Error **errp);
diff --git a/block.c b/block.c
index 91ace5d2d5..434b7f4d72 100644
--- a/block.c
+++ b/block.c
@@ -7431,16 +7431,6 @@ void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx)
     bdrv_dec_in_flight(bs);
 }
 
-void coroutine_fn bdrv_co_lock(BlockDriverState *bs)
-{
-    /* TODO removed in next patch */
-}
-
-void coroutine_fn bdrv_co_unlock(BlockDriverState *bs)
-{
-    /* TODO removed in next patch */
-}
-
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     GLOBAL_STATE_CODE();
diff --git a/blockdev.c b/blockdev.c
index 5d8b3a23eb..3a5e7222ec 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2264,18 +2264,13 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
         return;
     }
 
-    bdrv_co_lock(bs);
     bdrv_drained_begin(bs);
-    bdrv_co_unlock(bs);
 
     old_ctx = bdrv_co_enter(bs);
     blk_co_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
     bdrv_co_leave(bs, old_ctx);
 
-    bdrv_co_lock(bs);
     bdrv_drained_end(bs);
-    bdrv_co_unlock(bs);
-
     blk_co_unref(blk);
 }
 
-- 
2.43.0


