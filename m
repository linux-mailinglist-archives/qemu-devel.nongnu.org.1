Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B0706CDA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ5B-0002NZ-MA; Wed, 17 May 2023 11:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ59-0002Lo-1w
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ57-0000tX-D3
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=307NFVhzkj0Ci6yzvP3eVZ7VIH69hx+a7JKtXTKt04s=;
 b=EP+3nV/eR6MqgUhFhHMAJ2fANcv7uiYbXmO63JAWmAplGYZMSw4bZEdiEuS62BV/kQO577
 iyR0qrlzZec2xAdDdQC9LKLWcU8nDfyn+b9zF5pglCSZNGsh+U3E3Kz9FXQv90bOVchSp7
 jZL0h8fWro0OTR3AyboUsdjRQNl2tXI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-gPtw047NO421oFKpKj5ZrA-1; Wed, 17 May 2023 11:28:45 -0400
X-MC-Unique: gPtw047NO421oFKpKj5ZrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1FF21C313B5;
 Wed, 17 May 2023 15:28:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33FC51121314;
 Wed, 17 May 2023 15:28:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mjt@tls.msk.ru,
 eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] graph-lock: Disable locking for now
Date: Wed, 17 May 2023 17:28:32 +0200
Message-Id: <20230517152834.277483-2-kwolf@redhat.com>
In-Reply-To: <20230517152834.277483-1-kwolf@redhat.com>
References: <20230517152834.277483-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

In QEMU 8.0, we've been seeing deadlocks in bdrv_graph_wrlock(). They
come from callers that hold an AioContext lock, which is not allowed
during polling. In theory, we could temporarily release the lock, but
callers are inconsistent about whether they hold a lock, and if they do,
some are also confused about which one they hold. While all of this is
fixable, it's not trivial, and the best course of action for 8.0.1 is
probably just disabling the graph locking code temporarily.

We don't currently rely on graph locking yet. It is supposed to replace
the AioContext lock eventually to enable multiqueue support, but as long
as we still have the AioContext lock, it is sufficient without the graph
lock. Once the AioContext lock goes away, the deadlock doesn't exist any
more either and this commit can be reverted. (Of course, it can also be
reverted while the AioContext lock still exists if the callers have been
fixed.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/graph-lock.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index 9c42bd9799..9806fd4ecb 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -30,8 +30,10 @@ BdrvGraphLock graph_lock;
 /* Protects the list of aiocontext and orphaned_reader_count */
 static QemuMutex aio_context_list_lock;
 
+#if 0
 /* Written and read with atomic operations. */
 static int has_writer;
+#endif
 
 /*
  * A reader coroutine could move from an AioContext to another.
@@ -88,6 +90,7 @@ void unregister_aiocontext(AioContext *ctx)
     g_free(ctx->bdrv_graph);
 }
 
+#if 0
 static uint32_t reader_count(void)
 {
     BdrvGraphRWlock *brdv_graph;
@@ -105,10 +108,17 @@ static uint32_t reader_count(void)
     assert((int32_t)rd >= 0);
     return rd;
 }
+#endif
 
 void bdrv_graph_wrlock(void)
 {
     GLOBAL_STATE_CODE();
+    /*
+     * TODO Some callers hold an AioContext lock when this is called, which
+     * causes deadlocks. Reenable once the AioContext locking is cleaned up (or
+     * AioContext locks are gone).
+     */
+#if 0
     assert(!qatomic_read(&has_writer));
 
     /* Make sure that constantly arriving new I/O doesn't cause starvation */
@@ -139,11 +149,13 @@ void bdrv_graph_wrlock(void)
     } while (reader_count() >= 1);
 
     bdrv_drain_all_end();
+#endif
 }
 
 void bdrv_graph_wrunlock(void)
 {
     GLOBAL_STATE_CODE();
+#if 0
     QEMU_LOCK_GUARD(&aio_context_list_lock);
     assert(qatomic_read(&has_writer));
 
@@ -155,10 +167,13 @@ void bdrv_graph_wrunlock(void)
 
     /* Wake up all coroutine that are waiting to read the graph */
     qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
+#endif
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
 {
+    /* TODO Reenable when wrlock is reenabled */
+#if 0
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
@@ -218,10 +233,12 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
             qemu_co_queue_wait(&reader_queue, &aio_context_list_lock);
         }
     }
+#endif
 }
 
 void coroutine_fn bdrv_graph_co_rdunlock(void)
 {
+#if 0
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
@@ -239,6 +256,7 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     if (qatomic_read(&has_writer)) {
         aio_wait_kick();
     }
+#endif
 }
 
 void bdrv_graph_rdlock_main_loop(void)
@@ -264,5 +282,8 @@ void assert_bdrv_graph_readable(void)
 void assert_bdrv_graph_writable(void)
 {
     assert(qemu_in_main_thread());
+    /* TODO Reenable when wrlock is reenabled */
+#if 0
     assert(qatomic_read(&has_writer));
+#endif
 }
-- 
2.40.1


