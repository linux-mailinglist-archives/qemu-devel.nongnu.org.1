Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C888877FB61
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfP9-0007Jd-4f; Thu, 17 Aug 2023 11:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWfP3-0007CB-RB
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWfOy-0003oY-EE
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692287947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqE3ktnyuOAHuFbb42a3OaASqR6lydc27pMXxSDwsLA=;
 b=hvcMPRnkbO7N6LqfGn0ntl82uodnRxuiKOZRCbGhw6fZSi5VZqQmHqoIIgDzGpkhrvmv7V
 NRIQxXDpz2pNS514cYy0UcH1l2AX6uRnUsBwJXhfHC3BJww1+WrPzyRGpxObSrKDnhbIXP
 O2MXv5bv/sSbJSR9FOcbCKP87lwrqRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-i0EGJBEeNVaRNC0FqMm41g-1; Thu, 17 Aug 2023 11:59:04 -0400
X-MC-Unique: i0EGJBEeNVaRNC0FqMm41g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF0778DC661;
 Thu, 17 Aug 2023 15:59:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266692166B2E;
 Thu, 17 Aug 2023 15:58:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 3/4] virtio: use defer_call() in virtio_irqfd_notify()
Date: Thu, 17 Aug 2023 11:58:46 -0400
Message-ID: <20230817155847.3605115-4-stefanha@redhat.com>
In-Reply-To: <20230817155847.3605115-1-stefanha@redhat.com>
References: <20230817155847.3605115-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

virtio-blk and virtio-scsi invoke virtio_irqfd_notify() to send Used
Buffer Notifications from an IOThread. This involves an eventfd
write(2) syscall. Calling this repeatedly when completing multiple I/O
requests in a row is wasteful.

Use the defer_call() API to batch together virtio_irqfd_notify() calls
made during thread pool (aio=threads), Linux AIO (aio=native), and
io_uring (aio=io_uring) completion processing.

Behavior is unchanged for emulated devices that do not use
defer_call_begin()/defer_call_end() since defer_call() immediately
invokes the callback when called outside a
defer_call_begin()/defer_call_end() region.

fio rw=randread bs=4k iodepth=64 numjobs=8 IOPS increases by ~9% with a
single IOThread and 8 vCPUs. iodepth=1 decreases by ~1% but this could
be noise. Detailed performance data and configuration specifics are
available here:
https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd

This duplicates the BH that virtio-blk uses for batching. The next
commit will remove it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c   |  6 ++++++
 block/linux-aio.c  |  4 ++++
 hw/virtio/virtio.c | 11 ++++++++++-
 util/thread-pool.c |  5 +++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 3a1e1f45b3..7cdd00e9f1 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -125,6 +125,9 @@ static void luring_process_completions(LuringState *s)
 {
     struct io_uring_cqe *cqes;
     int total_bytes;
+
+    defer_call_begin();
+
     /*
      * Request completion callbacks can run the nested event loop.
      * Schedule ourselves so the nested event loop will "see" remaining
@@ -217,7 +220,10 @@ end:
             aio_co_wake(luringcb->co);
         }
     }
+
     qemu_bh_cancel(s->completion_bh);
+
+    defer_call_end();
 }
 
 static int ioq_submit(LuringState *s)
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 62380593c8..ab607ade6a 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -205,6 +205,8 @@ static void qemu_laio_process_completions(LinuxAioState *s)
 {
     struct io_event *events;
 
+    defer_call_begin();
+
     /* Reschedule so nested event loops see currently pending completions */
     qemu_bh_schedule(s->completion_bh);
 
@@ -231,6 +233,8 @@ static void qemu_laio_process_completions(LinuxAioState *s)
      * own `for` loop.  If we are the last all counters droped to zero. */
     s->event_max = 0;
     s->event_idx = 0;
+
+    defer_call_end();
 }
 
 static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 309038fd46..5eb1f91b41 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-virtio.h"
 #include "trace.h"
+#include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
@@ -28,6 +29,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
+#include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
 #include "virtio-qmp.h"
@@ -2426,6 +2428,13 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+/* Batch irqs while inside a defer_call_begin()/defer_call_end() section */
+static void virtio_notify_irqfd_deferred_fn(void *opaque)
+{
+    EventNotifier *notifier = opaque;
+    event_notifier_set(notifier);
+}
+
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     WITH_RCU_READ_LOCK_GUARD() {
@@ -2452,7 +2461,7 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    event_notifier_set(&vq->guest_notifier);
+    defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
 }
 
 static void virtio_irq(VirtQueue *vq)
diff --git a/util/thread-pool.c b/util/thread-pool.c
index e3d8292d14..d84961779a 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -15,6 +15,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/defer-call.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
@@ -175,6 +176,8 @@ static void thread_pool_completion_bh(void *opaque)
     ThreadPool *pool = opaque;
     ThreadPoolElement *elem, *next;
 
+    defer_call_begin(); /* cb() may use defer_call() to coalesce work */
+
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
         if (elem->state != THREAD_DONE) {
@@ -208,6 +211,8 @@ restart:
             qemu_aio_unref(elem);
         }
     }
+
+    defer_call_end();
 }
 
 static void thread_pool_cancel(BlockAIOCB *acb)
-- 
2.41.0


