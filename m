Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAC79F28A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgW2y-0002Es-Rj; Wed, 13 Sep 2023 16:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgW2w-0002DQ-6D
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgW2n-0005Ou-GG
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694635260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pG2WPZLRqDLjPAdddF1KKTi0oO1n+tSekW4IHh1/dp4=;
 b=YLXY6PsvF5OOTyMUQqqcZZkBYyOd898SY1YrhgjVk/86LuGd/3b6uGR971bgWpdnQf2rd7
 UYTYDFhmHoLTbnzLlwO9cDM6xn5J+H/cIx+1u/SVSv+h3HlGlFZS5d4LAOIf/o06S9rAss
 JELhs7k+Ai2LTAqQAaWGNt19bjxf40E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-PwMA5HczPguv2YeuDT1NhA-1; Wed, 13 Sep 2023 16:00:56 -0400
X-MC-Unique: PwMA5HczPguv2YeuDT1NhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BF8B857A9D;
 Wed, 13 Sep 2023 20:00:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10CD640C6EBF;
 Wed, 13 Sep 2023 20:00:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 1/4] block: rename blk_io_plug_call() API to defer_call()
Date: Wed, 13 Sep 2023 16:00:42 -0400
Message-ID: <20230913200045.1024233-2-stefanha@redhat.com>
In-Reply-To: <20230913200045.1024233-1-stefanha@redhat.com>
References: <20230913200045.1024233-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prepare to move the blk_io_plug_call() API out of the block layer so
that other subsystems call use this deferred call mechanism. Rename it
to defer_call() but leave the code in block/plug.c.

The next commit will move the code out of the block layer.

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/block-backend-io.h |   6 +-
 block/blkio.c                     |   8 +--
 block/io_uring.c                  |   4 +-
 block/linux-aio.c                 |   4 +-
 block/nvme.c                      |   4 +-
 block/plug.c                      | 109 +++++++++++++++---------------
 hw/block/dataplane/xen-block.c    |  10 +--
 hw/block/virtio-blk.c             |   4 +-
 hw/scsi/virtio-scsi.c             |   6 +-
 9 files changed, 76 insertions(+), 79 deletions(-)

diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index be4dcef59d..cfcfd85c1d 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -100,9 +100,9 @@ void blk_iostatus_set_err(BlockBackend *blk, int error);
 int blk_get_max_iov(BlockBackend *blk);
 int blk_get_max_hw_iov(BlockBackend *blk);
 
-void blk_io_plug(void);
-void blk_io_unplug(void);
-void blk_io_plug_call(void (*fn)(void *), void *opaque);
+void defer_call_begin(void);
+void defer_call_end(void);
+void defer_call(void (*fn)(void *), void *opaque);
 
 AioContext *blk_get_aio_context(BlockBackend *blk);
 BlockAcctStats *blk_get_stats(BlockBackend *blk);
diff --git a/block/blkio.c b/block/blkio.c
index 1dd495617c..7cf6d61f47 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -312,10 +312,10 @@ static void blkio_detach_aio_context(BlockDriverState *bs)
 }
 
 /*
- * Called by blk_io_unplug() or immediately if not plugged. Called without
- * blkio_lock.
+ * Called by defer_call_end() or immediately if not in a deferred section.
+ * Called without blkio_lock.
  */
-static void blkio_unplug_fn(void *opaque)
+static void blkio_deferred_fn(void *opaque)
 {
     BDRVBlkioState *s = opaque;
 
@@ -332,7 +332,7 @@ static void blkio_submit_io(BlockDriverState *bs)
 {
     BDRVBlkioState *s = bs->opaque;
 
-    blk_io_plug_call(blkio_unplug_fn, s);
+    defer_call(blkio_deferred_fn, s);
 }
 
 static int coroutine_fn
diff --git a/block/io_uring.c b/block/io_uring.c
index 69d9820928..8429f341be 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -306,7 +306,7 @@ static void ioq_init(LuringQueue *io_q)
     io_q->blocked = false;
 }
 
-static void luring_unplug_fn(void *opaque)
+static void luring_deferred_fn(void *opaque)
 {
     LuringState *s = opaque;
     trace_luring_unplug_fn(s, s->io_q.blocked, s->io_q.in_queue,
@@ -367,7 +367,7 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
             return ret;
         }
 
-        blk_io_plug_call(luring_unplug_fn, s);
+        defer_call(luring_deferred_fn, s);
     }
     return 0;
 }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 1a51503271..49a37174c2 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -353,7 +353,7 @@ static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
     return max_batch;
 }
 
-static void laio_unplug_fn(void *opaque)
+static void laio_deferred_fn(void *opaque)
 {
     LinuxAioState *s = opaque;
 
@@ -393,7 +393,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
         if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
             ioq_submit(s);
         } else {
-            blk_io_plug_call(laio_unplug_fn, s);
+            defer_call(laio_deferred_fn, s);
         }
     }
 
diff --git a/block/nvme.c b/block/nvme.c
index b6e95f0b7e..dfbd1085fd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -476,7 +476,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
-static void nvme_unplug_fn(void *opaque)
+static void nvme_deferred_fn(void *opaque)
 {
     NVMeQueuePair *q = opaque;
 
@@ -503,7 +503,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
     q->need_kick++;
     qemu_mutex_unlock(&q->lock);
 
-    blk_io_plug_call(nvme_unplug_fn, q);
+    defer_call(nvme_deferred_fn, q);
 }
 
 static void nvme_admin_cmd_sync_cb(void *opaque, int ret)
diff --git a/block/plug.c b/block/plug.c
index 98a155d2f4..f26173559c 100644
--- a/block/plug.c
+++ b/block/plug.c
@@ -1,24 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Block I/O plugging
+ * Deferred calls
  *
  * Copyright Red Hat.
  *
- * This API defers a function call within a blk_io_plug()/blk_io_unplug()
+ * This API defers a function call within a defer_call_begin()/defer_call_end()
  * section, allowing multiple calls to batch up. This is a performance
  * optimization that is used in the block layer to submit several I/O requests
  * at once instead of individually:
  *
- *   blk_io_plug(); <-- start of plugged region
+ *   defer_call_begin(); <-- start of section
  *   ...
- *   blk_io_plug_call(my_func, my_obj); <-- deferred my_func(my_obj) call
- *   blk_io_plug_call(my_func, my_obj); <-- another
- *   blk_io_plug_call(my_func, my_obj); <-- another
+ *   defer_call(my_func, my_obj); <-- deferred my_func(my_obj) call
+ *   defer_call(my_func, my_obj); <-- another
+ *   defer_call(my_func, my_obj); <-- another
  *   ...
- *   blk_io_unplug(); <-- end of plugged region, my_func(my_obj) is called once
- *
- * This code is actually generic and not tied to the block layer. If another
- * subsystem needs this functionality, it could be renamed.
+ *   defer_call_end(); <-- end of section, my_func(my_obj) is called once
  */
 
 #include "qemu/osdep.h"
@@ -27,66 +24,66 @@
 #include "qemu/thread.h"
 #include "sysemu/block-backend.h"
 
-/* A function call that has been deferred until unplug() */
+/* A function call that has been deferred until defer_call_end() */
 typedef struct {
     void (*fn)(void *);
     void *opaque;
-} UnplugFn;
+} DeferredCall;
 
 /* Per-thread state */
 typedef struct {
-    unsigned count;       /* how many times has plug() been called? */
-    GArray *unplug_fns;   /* functions to call at unplug time */
-} Plug;
+    unsigned nesting_level;
+    GArray *deferred_call_array;
+} DeferCallThreadState;
 
-/* Use get_ptr_plug() to fetch this thread-local value */
-QEMU_DEFINE_STATIC_CO_TLS(Plug, plug);
+/* Use get_ptr_defer_call_thread_state() to fetch this thread-local value */
+QEMU_DEFINE_STATIC_CO_TLS(DeferCallThreadState, defer_call_thread_state);
 
 /* Called at thread cleanup time */
-static void blk_io_plug_atexit(Notifier *n, void *value)
+static void defer_call_atexit(Notifier *n, void *value)
 {
-    Plug *plug = get_ptr_plug();
-    g_array_free(plug->unplug_fns, TRUE);
+    DeferCallThreadState *thread_state = get_ptr_defer_call_thread_state();
+    g_array_free(thread_state->deferred_call_array, TRUE);
 }
 
 /* This won't involve coroutines, so use __thread */
-static __thread Notifier blk_io_plug_atexit_notifier;
+static __thread Notifier defer_call_atexit_notifier;
 
 /**
- * blk_io_plug_call:
+ * defer_call:
  * @fn: a function pointer to be invoked
  * @opaque: a user-defined argument to @fn()
  *
- * Call @fn(@opaque) immediately if not within a blk_io_plug()/blk_io_unplug()
- * section.
+ * Call @fn(@opaque) immediately if not within a
+ * defer_call_begin()/defer_call_end() section.
  *
  * Otherwise defer the call until the end of the outermost
- * blk_io_plug()/blk_io_unplug() section in this thread. If the same
+ * defer_call_begin()/defer_call_end() section in this thread. If the same
  * @fn/@opaque pair has already been deferred, it will only be called once upon
- * blk_io_unplug() so that accumulated calls are batched into a single call.
+ * defer_call_end() so that accumulated calls are batched into a single call.
  *
  * The caller must ensure that @opaque is not freed before @fn() is invoked.
  */
-void blk_io_plug_call(void (*fn)(void *), void *opaque)
+void defer_call(void (*fn)(void *), void *opaque)
 {
-    Plug *plug = get_ptr_plug();
+    DeferCallThreadState *thread_state = get_ptr_defer_call_thread_state();
 
-    /* Call immediately if we're not plugged */
-    if (plug->count == 0) {
+    /* Call immediately if we're not deferring calls */
+    if (thread_state->nesting_level == 0) {
         fn(opaque);
         return;
     }
 
-    GArray *array = plug->unplug_fns;
+    GArray *array = thread_state->deferred_call_array;
     if (!array) {
-        array = g_array_new(FALSE, FALSE, sizeof(UnplugFn));
-        plug->unplug_fns = array;
-        blk_io_plug_atexit_notifier.notify = blk_io_plug_atexit;
-        qemu_thread_atexit_add(&blk_io_plug_atexit_notifier);
+        array = g_array_new(FALSE, FALSE, sizeof(DeferredCall));
+        thread_state->deferred_call_array = array;
+        defer_call_atexit_notifier.notify = defer_call_atexit;
+        qemu_thread_atexit_add(&defer_call_atexit_notifier);
     }
 
-    UnplugFn *fns = (UnplugFn *)array->data;
-    UnplugFn new_fn = {
+    DeferredCall *fns = (DeferredCall *)array->data;
+    DeferredCall new_fn = {
         .fn = fn,
         .opaque = opaque,
     };
@@ -106,46 +103,46 @@ void blk_io_plug_call(void (*fn)(void *), void *opaque)
 }
 
 /**
- * blk_io_plug: Defer blk_io_plug_call() functions until blk_io_unplug()
+ * defer_call_begin: Defer defer_call() functions until defer_call_end()
  *
- * blk_io_plug/unplug are thread-local operations. This means that multiple
- * threads can simultaneously call plug/unplug, but the caller must ensure that
- * each unplug() is called in the same thread of the matching plug().
+ * defer_call_begin() and defer_call_end() are thread-local operations. The
+ * caller must ensure that each defer_call_begin() has a matching
+ * defer_call_end() in the same thread.
  *
- * Nesting is supported. blk_io_plug_call() functions are only called at the
- * outermost blk_io_unplug().
+ * Nesting is supported. defer_call() functions are only called at the
+ * outermost defer_call_end().
  */
-void blk_io_plug(void)
+void defer_call_begin(void)
 {
-    Plug *plug = get_ptr_plug();
+    DeferCallThreadState *thread_state = get_ptr_defer_call_thread_state();
 
-    assert(plug->count < UINT32_MAX);
+    assert(thread_state->nesting_level < UINT32_MAX);
 
-    plug->count++;
+    thread_state->nesting_level++;
 }
 
 /**
- * blk_io_unplug: Run any pending blk_io_plug_call() functions
+ * defer_call_end: Run any pending defer_call() functions
  *
- * There must have been a matching blk_io_plug() call in the same thread prior
- * to this blk_io_unplug() call.
+ * There must have been a matching defer_call_begin() call in the same thread
+ * prior to this defer_call_end() call.
  */
-void blk_io_unplug(void)
+void defer_call_end(void)
 {
-    Plug *plug = get_ptr_plug();
+    DeferCallThreadState *thread_state = get_ptr_defer_call_thread_state();
 
-    assert(plug->count > 0);
+    assert(thread_state->nesting_level > 0);
 
-    if (--plug->count > 0) {
+    if (--thread_state->nesting_level > 0) {
         return;
     }
 
-    GArray *array = plug->unplug_fns;
+    GArray *array = thread_state->deferred_call_array;
     if (!array) {
         return;
     }
 
-    UnplugFn *fns = (UnplugFn *)array->data;
+    DeferredCall *fns = (DeferredCall *)array->data;
 
     for (guint i = 0; i < array->len; i++) {
         fns[i].fn(fns[i].opaque);
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 3b6f2b0aa2..e9dd8f8a99 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -509,7 +509,7 @@ static int xen_block_get_request(XenBlockDataPlane *dataplane,
 
 /*
  * Threshold of in-flight requests above which we will start using
- * blk_io_plug()/blk_io_unplug() to batch requests.
+ * defer_call_begin()/defer_call_end() to batch requests.
  */
 #define IO_PLUG_THRESHOLD 1
 
@@ -537,7 +537,7 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
      * is below us.
      */
     if (inflight_atstart > IO_PLUG_THRESHOLD) {
-        blk_io_plug();
+        defer_call_begin();
     }
     while (rc != rp) {
         /* pull request from ring */
@@ -577,12 +577,12 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
 
         if (inflight_atstart > IO_PLUG_THRESHOLD &&
             batched >= inflight_atstart) {
-            blk_io_unplug();
+            defer_call_end();
         }
         xen_block_do_aio(request);
         if (inflight_atstart > IO_PLUG_THRESHOLD) {
             if (batched >= inflight_atstart) {
-                blk_io_plug();
+                defer_call_begin();
                 batched = 0;
             } else {
                 batched++;
@@ -590,7 +590,7 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
         }
     }
     if (inflight_atstart > IO_PLUG_THRESHOLD) {
-        blk_io_unplug();
+        defer_call_end();
     }
 
     return done_something;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 39e7f23fab..6a45033d15 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1134,7 +1134,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
     bool suppress_notifications = virtio_queue_get_notification(vq);
 
     aio_context_acquire(blk_get_aio_context(s->blk));
-    blk_io_plug();
+    defer_call_begin();
 
     do {
         if (suppress_notifications) {
@@ -1158,7 +1158,7 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
         virtio_blk_submit_multireq(s, &mrb);
     }
 
-    blk_io_unplug();
+    defer_call_end();
     aio_context_release(blk_get_aio_context(s->blk));
 }
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..c2465e3e88 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -799,7 +799,7 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
         return -ENOBUFS;
     }
     scsi_req_ref(req->sreq);
-    blk_io_plug();
+    defer_call_begin();
     object_unref(OBJECT(d));
     return 0;
 }
@@ -810,7 +810,7 @@ static void virtio_scsi_handle_cmd_req_submit(VirtIOSCSI *s, VirtIOSCSIReq *req)
     if (scsi_req_enqueue(sreq)) {
         scsi_req_continue(sreq);
     }
-    blk_io_unplug();
+    defer_call_end();
     scsi_req_unref(sreq);
 }
 
@@ -836,7 +836,7 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
                 while (!QTAILQ_EMPTY(&reqs)) {
                     req = QTAILQ_FIRST(&reqs);
                     QTAILQ_REMOVE(&reqs, req, next);
-                    blk_io_unplug();
+                    defer_call_end();
                     scsi_req_unref(req->sreq);
                     virtqueue_detach_element(req->vq, &req->elem, 0);
                     virtio_scsi_free_req(req);
-- 
2.41.0


