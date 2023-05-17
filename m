Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A462F706CDE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ5D-0002OU-CU; Wed, 17 May 2023 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ59-0002Md-Sy
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ57-0000tn-Rb
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71BCgfGW3jfYqjQHSMUd2R17uTz6MCoIV8/vS9j2Si0=;
 b=KUWKR9AwdqXOE+EV+YmxjN5N38uQDjrHXuJyonRByNfgsAdJPtUINY8JSS68/MMLPm1v3m
 m4lzZ4ouwG19VVqRQD/ILfbwe/9AYsSg3/b8/Hc28XEklHp14G2xEI36DgDOK/SoTXL4+K
 K2hnPFrP0uVrniSvZ8841hUNeapWcKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-j0MOZfpPNIaX0vjPHNxrcA-1; Wed, 17 May 2023 11:28:47 -0400
X-MC-Unique: j0MOZfpPNIaX0vjPHNxrcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43B458EFF1F;
 Wed, 17 May 2023 15:28:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E92631121315;
 Wed, 17 May 2023 15:28:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mjt@tls.msk.ru,
 eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] nbd/server: Fix drained_poll to wake coroutine in right
 AioContext
Date: Wed, 17 May 2023 17:28:33 +0200
Message-Id: <20230517152834.277483-3-kwolf@redhat.com>
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
---
 include/io/channel.h | 10 ++++++++++
 io/channel.c         | 33 +++++++++++++++++++++++++++------
 nbd/server.c         |  3 +--
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 446a566e5e..229bf36910 100644
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
index 375a130a39..72f0066af5 100644
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
index e239c2890f..2664d43bff 100644
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
2.40.1


