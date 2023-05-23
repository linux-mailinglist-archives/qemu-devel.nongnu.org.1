Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1270DA2C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P5e-0001f0-Eh; Tue, 23 May 2023 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P5A-0001NJ-8Y; Tue, 23 May 2023 06:17:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P58-00029c-7N; Tue, 23 May 2023 06:17:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35DD67D08;
 Tue, 23 May 2023 13:15:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 763CB7298;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: (nullmailer pid 85557 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 58/59] graph-lock: Disable locking for now
Date: Tue, 23 May 2023 13:15:18 +0300
Message-Id: <20230523101536.85424-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

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
Message-Id: <20230517152834.277483-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 80fc5d260002432628710f8b0c7cfc7d9b97bb9d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/graph-lock.c b/block/graph-lock.c
index 259a7a0bde..2490926c90 100644
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
 
@@ -223,10 +238,12 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
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
 
@@ -249,6 +266,7 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     if (qatomic_read(&has_writer)) {
         aio_wait_kick();
     }
+#endif
 }
 
 void bdrv_graph_rdlock_main_loop(void)
@@ -266,13 +284,19 @@ void bdrv_graph_rdunlock_main_loop(void)
 void assert_bdrv_graph_readable(void)
 {
     /* reader_count() is slow due to aio_context_list_lock lock contention */
+    /* TODO Reenable when wrlock is reenabled */
+#if 0
 #ifdef CONFIG_DEBUG_GRAPH_LOCK
     assert(qemu_in_main_thread() || reader_count());
 #endif
+#endif
 }
 
 void assert_bdrv_graph_writable(void)
 {
     assert(qemu_in_main_thread());
+    /* TODO Reenable when wrlock is reenabled */
+#if 0
     assert(qatomic_read(&has_writer));
+#endif
 }
-- 
2.39.2


