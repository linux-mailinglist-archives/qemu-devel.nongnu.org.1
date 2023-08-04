Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825D7708E5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0It-0000bq-Iy; Fri, 04 Aug 2023 15:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Iq-0000aN-7z; Fri, 04 Aug 2023 15:17:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Io-00070X-F3; Fri, 04 Aug 2023 15:17:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6E8D1845F;
 Fri,  4 Aug 2023 22:17:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0CE1F1B8A2;
 Fri,  4 Aug 2023 22:16:52 +0300 (MSK)
Received: (nullmailer pid 1875726 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 45/63] thread-pool: signal "request_cond" while locked
Date: Fri,  4 Aug 2023 22:16:28 +0300
Message-Id: <20230804191647.1875608-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anthony PERARD <anthony.perard@citrix.com>

thread_pool_free() might have been called on the `pool`, which would
be a reason for worker_thread() to quit. In this case,
`pool->request_cond` is been destroyed.

If worker_thread() didn't managed to signal `request_cond` before it
been destroyed by thread_pool_free(), we got:
    util/qemu-thread-posix.c:198: qemu_cond_signal: Assertion `cond->initialized' failed.

One backtrace:
    __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "util/qemu-thread-posix.c", line=198,
	function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
    qemu_cond_signal (cond=0x7fffb800db30) at util/qemu-thread-posix.c:198
    worker_thread (opaque=0x7fffb800dab0) at util/thread-pool.c:129
    qemu_thread_start (args=0x7fffb8000b20) at util/qemu-thread-posix.c:505
    start_thread (arg=<optimized out>) at pthread_create.c:486

Reported here:
    https://lore.kernel.org/all/ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local/T/#u

To avoid issue, keep lock while sending a signal to `request_cond`.

Fixes: 900fa208f506 ("thread-pool: replace semaphore with condition variable")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230714152720.5077-1-anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
(cherry picked from commit f4f71363fcdb1092ff64d2bba6f9af39570c2f2b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 31113b5860..39accc9ebe 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -120,13 +120,13 @@ static void *worker_thread(void *opaque)
 
     pool->cur_threads--;
     qemu_cond_signal(&pool->worker_stopped);
-    qemu_mutex_unlock(&pool->lock);
 
     /*
      * Wake up another thread, in case we got a wakeup but decided
      * to exit due to pool->cur_threads > pool->max_threads.
      */
     qemu_cond_signal(&pool->request_cond);
+    qemu_mutex_unlock(&pool->lock);
     return NULL;
 }
 
-- 
2.39.2


