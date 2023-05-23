Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B870DA32
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P66-00027Q-Lc; Tue, 23 May 2023 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P5E-0001ZA-V9; Tue, 23 May 2023 06:17:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P59-0002E0-Q8; Tue, 23 May 2023 06:17:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74B937D09;
 Tue, 23 May 2023 13:15:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AB09A7299;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: (nullmailer pid 85560 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 59/59] nbd/server: Fix drained_poll to wake coroutine
 in right AioContext
Date: Tue, 23 May 2023 13:15:19 +0300
Message-Id: <20230523101536.85424-23-mjt@tls.msk.ru>
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

nbd_drained_poll() generally runs in the main thread, not whatever
iothread the NBD server coroutine is meant to run in, so it can't
directly reenter the coroutines to wake them up.

The code seems to have the right intention, it specifies the correct
AioContext when it calls qemu_aio_coroutine_enter(). However, this
functions doesn't schedule the coroutine to run in that AioContext, but
it assumes it is already called in the home thread of the AioContext.

To fix this, add a new thread-safe qio_channel_wake_read() that can be
called in the main thread to wake up the coroutine in its AioContext,
and use this in nbd_drained_poll().

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230517152834.277483-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7c1f51bf38de8cea4ed5030467646c37b46edeb7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/io/channel.h b/include/io/channel.h
index 153fbd2904..2b905423a9 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -757,6 +757,16 @@ void qio_channel_detach_aio_context(QIOChannel *ioc);
 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
                                     GIOCondition condition);
 
+/**
+ * qio_channel_wake_read:
+ * @ioc: the channel object
+ *
+ * If qio_channel_yield() is currently waiting for the channel to become
+ * readable, interrupt it and reenter immediately. This function is safe to call
+ * from any thread.
+ */
+void qio_channel_wake_read(QIOChannel *ioc);
+
 /**
  * qio_channel_wait:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index a8c7f11649..3c9b7beb65 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/aio-wait.h"
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -514,7 +515,11 @@ int qio_channel_flush(QIOChannel *ioc,
 static void qio_channel_restart_read(void *opaque)
 {
     QIOChannel *ioc = opaque;
-    Coroutine *co = ioc->read_coroutine;
+    Coroutine *co = qatomic_xchg(&ioc->read_coroutine, NULL);
+
+    if (!co) {
+        return;
+    }
 
     /* Assert that aio_co_wake() reenters the coroutine directly */
     assert(qemu_get_current_aio_context() ==
@@ -525,7 +530,11 @@ static void qio_channel_restart_read(void *opaque)
 static void qio_channel_restart_write(void *opaque)
 {
     QIOChannel *ioc = opaque;
-    Coroutine *co = ioc->write_coroutine;
+    Coroutine *co = qatomic_xchg(&ioc->write_coroutine, NULL);
+
+    if (!co) {
+        return;
+    }
 
     /* Assert that aio_co_wake() reenters the coroutine directly */
     assert(qemu_get_current_aio_context() ==
@@ -568,7 +577,11 @@ void qio_channel_detach_aio_context(QIOChannel *ioc)
 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
                                     GIOCondition condition)
 {
+    AioContext *ioc_ctx = ioc->ctx ?: qemu_get_aio_context();
+
     assert(qemu_in_coroutine());
+    assert(in_aio_context_home_thread(ioc_ctx));
+
     if (condition == G_IO_IN) {
         assert(!ioc->read_coroutine);
         ioc->read_coroutine = qemu_coroutine_self();
@@ -580,18 +593,26 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
     }
     qio_channel_set_aio_fd_handlers(ioc);
     qemu_coroutine_yield();
+    assert(in_aio_context_home_thread(ioc_ctx));
 
     /* Allow interrupting the operation by reentering the coroutine other than
      * through the aio_fd_handlers. */
-    if (condition == G_IO_IN && ioc->read_coroutine) {
-        ioc->read_coroutine = NULL;
+    if (condition == G_IO_IN) {
+        assert(ioc->read_coroutine == NULL);
         qio_channel_set_aio_fd_handlers(ioc);
-    } else if (condition == G_IO_OUT && ioc->write_coroutine) {
-        ioc->write_coroutine = NULL;
+    } else if (condition == G_IO_OUT) {
+        assert(ioc->write_coroutine == NULL);
         qio_channel_set_aio_fd_handlers(ioc);
     }
 }
 
+void qio_channel_wake_read(QIOChannel *ioc)
+{
+    Coroutine *co = qatomic_xchg(&ioc->read_coroutine, NULL);
+    if (co) {
+        aio_co_wake(co);
+    }
+}
 
 static gboolean qio_channel_wait_complete(QIOChannel *ioc,
                                           GIOCondition condition,
diff --git a/nbd/server.c b/nbd/server.c
index 3d8d0d81df..ea47522e8f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1599,8 +1599,7 @@ static bool nbd_drained_poll(void *opaque)
              * enter it here so we don't depend on the client to wake it up.
              */
             if (client->recv_coroutine != NULL && client->read_yielding) {
-                qemu_aio_coroutine_enter(exp->common.ctx,
-                                         client->recv_coroutine);
+                qio_channel_wake_read(client->ioc);
             }
 
             return true;
-- 
2.39.2


