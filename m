Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF397DD66E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:00:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxty0-00042H-R2; Tue, 31 Oct 2023 14:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxy-00041b-Vj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxi-000688-Dt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUAxM+YGqvmxpwf+HeQdOZGQVVePhtWYD/qRWsLdc14=;
 b=gBEH7Vr2feB9YtUuComi0gE8xlCLVxbHOnbzmGS52R4AvgstucW8C8bKWBQFgOk5dUJKHC
 z+ihDb7LqDOAj9qlQIRkGh5aiYcKVHbvRkKBfMPRel5gieZMGdAGoe7E5qxpbjHdUF78VC
 1ee4sQBTPo2/tu1D5k86KBdoX86Uvdw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-g4anmyHRMIyy1CCVVvklTA-1; Tue,
 31 Oct 2023 14:59:33 -0400
X-MC-Unique: g4anmyHRMIyy1CCVVvklTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7B473813F2B;
 Tue, 31 Oct 2023 18:59:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17674143;
 Tue, 31 Oct 2023 18:59:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/27] virtio: use defer_call() in virtio_irqfd_notify()
Date: Tue, 31 Oct 2023 19:59:07 +0100
Message-ID: <20231031185918.346940-17-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230913200045.1024233-4-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io_uring.c       |  6 ++++++
 block/linux-aio.c      |  4 ++++
 hw/virtio/virtio.c     | 13 ++++++++++++-
 util/thread-pool.c     |  5 +++++
 hw/virtio/trace-events |  1 +
 5 files changed, 28 insertions(+), 1 deletion(-)

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
index a2670b3e46..ec05d946f3 100644
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
      * own `for` loop.  If we are the last all counters dropped to zero. */
     s->event_max = 0;
     s->event_idx = 0;
+
+    defer_call_end();
 }
 
 static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb24bc927b..e5105571cf 100644
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
@@ -2445,6 +2446,16 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+/* Batch irqs while inside a defer_call_begin()/defer_call_end() section */
+static void virtio_notify_irqfd_deferred_fn(void *opaque)
+{
+    EventNotifier *notifier = opaque;
+    VirtQueue *vq = container_of(notifier, VirtQueue, guest_notifier);
+
+    trace_virtio_notify_irqfd_deferred_fn(vq->vdev, vq);
+    event_notifier_set(notifier);
+}
+
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     WITH_RCU_READ_LOCK_GUARD() {
@@ -2471,7 +2482,7 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    event_notifier_set(&vq->guest_notifier);
+    defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
 }
 
 static void virtio_irq(VirtQueue *vq)
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 22f9ba3286..27eb777e85 100644
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
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1cb9027d1e..0af7a2886c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -73,6 +73,7 @@ virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "
 virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
 virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int out_num) "vq %p elem %p in_num %u out_num %u"
 virtio_queue_notify(void *vdev, int n, void *vq) "vdev %p n %d vq %p"
+virtio_notify_irqfd_deferred_fn(void *vdev, void *vq) "vdev %p vq %p"
 virtio_notify_irqfd(void *vdev, void *vq) "vdev %p vq %p"
 virtio_notify(void *vdev, void *vq) "vdev %p vq %p"
 virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
-- 
2.41.0


