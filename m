Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CF741389
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVy4-0008Qp-DK; Wed, 28 Jun 2023 10:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxu-0008JI-LT
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxp-0005Ht-PO
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGTMR5e46d9SRCIppxoyZInwm3yrmAzCqXuOi4M/ucU=;
 b=TmTVW+9BpC2vYOvxQ9n8eFOzmm6EFdLDE1dB3nxp+3WRIOn5aHpWe/TdG0jFHPFz5xfo2J
 1JMpdJwP8v/WqQVeH5nWz6dkVd3KfLUnP8qUCP3HcBUo4cdwYhJRrqLRZ2wQJsVB8XSkA0
 HgESKKYL4uOCnmi6ssXBeja5NKH5eFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Ke9Cs54aPpaSeuXIhfXdmw-1; Wed, 28 Jun 2023 10:15:56 -0400
X-MC-Unique: Ke9Cs54aPpaSeuXIhfXdmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7145F88D543;
 Wed, 28 Jun 2023 14:15:51 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD1E40C2063;
 Wed, 28 Jun 2023 14:15:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/23] Revert "graph-lock: Disable locking for now"
Date: Wed, 28 Jun 2023 16:15:14 +0200
Message-ID: <20230628141526.293104-12-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that bdrv_graph_wrlock() temporarily drops the AioContext lock that
its caller holds, it can poll without causing deadlocks. We can now
re-enable graph locking.

This reverts commit ad128dff0bf4b6f971d05eb4335a627883a19c1d.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230605085711.21261-12-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/graph-lock.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index 3bf2591dc4..5e66f01ae8 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -30,10 +30,8 @@ BdrvGraphLock graph_lock;
 /* Protects the list of aiocontext and orphaned_reader_count */
 static QemuMutex aio_context_list_lock;
 
-#if 0
 /* Written and read with atomic operations. */
 static int has_writer;
-#endif
 
 /*
  * A reader coroutine could move from an AioContext to another.
@@ -90,7 +88,6 @@ void unregister_aiocontext(AioContext *ctx)
     g_free(ctx->bdrv_graph);
 }
 
-#if 0
 static uint32_t reader_count(void)
 {
     BdrvGraphRWlock *brdv_graph;
@@ -108,21 +105,13 @@ static uint32_t reader_count(void)
     assert((int32_t)rd >= 0);
     return rd;
 }
-#endif
 
 void bdrv_graph_wrlock(BlockDriverState *bs)
 {
     AioContext *ctx = NULL;
 
     GLOBAL_STATE_CODE();
-    /*
-     * TODO Some callers hold an AioContext lock when this is called, which
-     * causes deadlocks. Reenable once the AioContext locking is cleaned up (or
-     * AioContext locks are gone).
-     */
-#if 0
     assert(!qatomic_read(&has_writer));
-#endif
 
     /*
      * Release only non-mainloop AioContext. The mainloop often relies on the
@@ -137,7 +126,6 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
         }
     }
 
-#if 0
     /* Make sure that constantly arriving new I/O doesn't cause starvation */
     bdrv_drain_all_begin_nopoll();
 
@@ -166,7 +154,6 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
     } while (reader_count() >= 1);
 
     bdrv_drain_all_end();
-#endif
 
     if (ctx) {
         aio_context_acquire(bdrv_get_aio_context(bs));
@@ -176,7 +163,6 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
 void bdrv_graph_wrunlock(void)
 {
     GLOBAL_STATE_CODE();
-#if 0
     QEMU_LOCK_GUARD(&aio_context_list_lock);
     assert(qatomic_read(&has_writer));
 
@@ -188,13 +174,10 @@ void bdrv_graph_wrunlock(void)
 
     /* Wake up all coroutine that are waiting to read the graph */
     qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
-#endif
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
 {
-    /* TODO Reenable when wrlock is reenabled */
-#if 0
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
@@ -254,12 +237,10 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
             qemu_co_queue_wait(&reader_queue, &aio_context_list_lock);
         }
     }
-#endif
 }
 
 void coroutine_fn bdrv_graph_co_rdunlock(void)
 {
-#if 0
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
@@ -277,7 +258,6 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     if (qatomic_read(&has_writer)) {
         aio_wait_kick();
     }
-#endif
 }
 
 void bdrv_graph_rdlock_main_loop(void)
@@ -295,19 +275,13 @@ void bdrv_graph_rdunlock_main_loop(void)
 void assert_bdrv_graph_readable(void)
 {
     /* reader_count() is slow due to aio_context_list_lock lock contention */
-    /* TODO Reenable when wrlock is reenabled */
-#if 0
 #ifdef CONFIG_DEBUG_GRAPH_LOCK
     assert(qemu_in_main_thread() || reader_count());
 #endif
-#endif
 }
 
 void assert_bdrv_graph_writable(void)
 {
     assert(qemu_in_main_thread());
-    /* TODO Reenable when wrlock is reenabled */
-#if 0
     assert(qatomic_read(&has_writer));
-#endif
 }
-- 
2.41.0


