Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26FA34CF5
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Feb 2025 19:06:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidZs-0002kp-4F; Thu, 13 Feb 2025 13:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWT-0007qY-RD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWP-0006Rd-Aj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739469664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGsDc5YWAkqP97Hnuuj4Lc3d+C4/1IUximqabFn8a5s=;
 b=dif7u1EJzTHPHca3EU6dCw1n68HZG5kt1vvwx+vfLChv4B/BcJY0/BTQunCSor9iPxIZWZ
 F3BSA3gj+mAwTyJKUj3PeT90+qXgz1vmI9eHXUT2/BSvCI0BYVcJvBbiqPpuwz56v+ZYn+
 eqtmpbnNAP+KY210rKgEiAuFSrAbYfk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-0tPyDVrKMT2i_hJGpwbXhA-1; Thu,
 13 Feb 2025 13:01:00 -0500
X-MC-Unique: 0tPyDVrKMT2i_hJGpwbXhA-1
X-Mimecast-MFC-AGG-ID: 0tPyDVrKMT2i_hJGpwbXhA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF8818EB2CB; Thu, 13 Feb 2025 18:00:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DF9A1955F0F; Thu, 13 Feb 2025 18:00:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 04/12] scsi: introduce requests_lock
Date: Thu, 13 Feb 2025 13:00:35 -0500
Message-ID: <20250213180043.713434-5-stefanha@redhat.com>
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SCSIDevice keeps track of in-flight requests for device reset and Task
Management Functions (TMFs). The request list requires protection so
that multi-threaded SCSI emulation can be implemented in commits that
follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |   7 ++-
 hw/scsi/scsi-bus.c     | 120 +++++++++++++++++++++++++++++------------
 2 files changed, 88 insertions(+), 39 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index ffc48203f9..90ee192b4d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -49,6 +49,8 @@ struct SCSIRequest {
     bool              dma_started;
     BlockAIOCB        *aiocb;
     QEMUSGList        *sg;
+
+    /* Protected by SCSIDevice->requests_lock */
     QTAILQ_ENTRY(SCSIRequest) next;
 };
 
@@ -77,10 +79,7 @@ struct SCSIDevice
     uint8_t sense[SCSI_SENSE_BUF_SIZE];
     uint32_t sense_len;
 
-    /*
-     * The requests list is only accessed from the AioContext that executes
-     * requests or from the main loop when IOThread processing is stopped.
-     */
+    QemuMutex requests_lock; /* protects the requests list */
     QTAILQ_HEAD(, SCSIRequest) requests;
 
     uint32_t channel;
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 846bbbf0ec..ece1107ee8 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -100,8 +100,15 @@ static void scsi_device_for_each_req_sync(SCSIDevice *s,
     assert(!runstate_is_running());
     assert(qemu_in_main_thread());
 
-    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
-        fn(req, opaque);
+    /*
+     * Locking is not necessary because the guest is stopped and no other
+     * threads can be accessing the requests list, but take the lock for
+     * consistency.
+     */
+    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
+        QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
+            fn(req, opaque);
+        }
     }
 }
 
@@ -115,21 +122,29 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
 {
     g_autofree SCSIDeviceForEachReqAsyncData *data = opaque;
     SCSIDevice *s = data->s;
-    AioContext *ctx;
-    SCSIRequest *req;
-    SCSIRequest *next;
+    g_autoptr(GList) reqs = NULL;
 
     /*
-     * The BB cannot have changed contexts between this BH being scheduled and
-     * now: BBs' AioContexts, when they have a node attached, can only be
-     * changed via bdrv_try_change_aio_context(), in a drained section.  While
-     * we have the in-flight counter incremented, that drain must block.
+     * Build a list of requests in this AioContext so fn() can be invoked later
+     * outside requests_lock.
      */
-    ctx = blk_get_aio_context(s->conf.blk);
-    assert(ctx == qemu_get_current_aio_context());
+    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
+        AioContext *ctx = qemu_get_current_aio_context();
+        SCSIRequest *req;
+        SCSIRequest *next;
 
-    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
-        data->fn(req, data->fn_opaque);
+        QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
+            if (req->ctx == ctx) {
+                scsi_req_ref(req); /* dropped after calling fn() */
+                reqs = g_list_prepend(reqs, req);
+            }
+        }
+    }
+
+    /* Call fn() on each request */
+    for (GList *elem = g_list_first(reqs); elem; elem = g_list_next(elem)) {
+        data->fn(elem->data, data->fn_opaque);
+        scsi_req_unref(elem->data);
     }
 
     /* Drop the reference taken by scsi_device_for_each_req_async() */
@@ -139,9 +154,35 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
     blk_dec_in_flight(s->conf.blk);
 }
 
+static void scsi_device_for_each_req_async_do_ctx(gpointer key, gpointer value,
+                                                  gpointer user_data)
+{
+    AioContext *ctx = key;
+    SCSIDeviceForEachReqAsyncData *params = user_data;
+    SCSIDeviceForEachReqAsyncData *data;
+
+    data = g_new(SCSIDeviceForEachReqAsyncData, 1);
+    data->s = params->s;
+    data->fn = params->fn;
+    data->fn_opaque = params->fn_opaque;
+
+    /*
+     * Hold a reference to the SCSIDevice until
+     * scsi_device_for_each_req_async_bh() finishes.
+     */
+    object_ref(OBJECT(data->s));
+
+    /* Paired with scsi_device_for_each_req_async_bh() */
+    blk_inc_in_flight(data->s->conf.blk);
+
+    aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh, data);
+}
+
 /*
  * Schedule @fn() to be invoked for each enqueued request in device @s. @fn()
- * runs in the AioContext that is executing the request.
+ * must be thread-safe because it runs concurrently in each AioContext that is
+ * executing a request.
+ *
  * Keeps the BlockBackend's in-flight counter incremented until everything is
  * done, so draining it will settle all scheduled @fn() calls.
  */
@@ -151,24 +192,26 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
 {
     assert(qemu_in_main_thread());
 
-    SCSIDeviceForEachReqAsyncData *data =
-        g_new(SCSIDeviceForEachReqAsyncData, 1);
+    /* The set of AioContexts where the requests are being processed */
+    g_autoptr(GHashTable) aio_contexts = g_hash_table_new(NULL, NULL);
+    WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
+        SCSIRequest *req;
+        QTAILQ_FOREACH(req, &s->requests, next) {
+            g_hash_table_add(aio_contexts, req->ctx);
+        }
+    }
 
-    data->s = s;
-    data->fn = fn;
-    data->fn_opaque = opaque;
-
-    /*
-     * Hold a reference to the SCSIDevice until
-     * scsi_device_for_each_req_async_bh() finishes.
-     */
-    object_ref(OBJECT(s));
-
-    /* Paired with blk_dec_in_flight() in scsi_device_for_each_req_async_bh() */
-    blk_inc_in_flight(s->conf.blk);
-    aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
-                            scsi_device_for_each_req_async_bh,
-                            data);
+    /* Schedule a BH for each AioContext */
+    SCSIDeviceForEachReqAsyncData params = {
+        .s = s,
+        .fn = fn,
+        .fn_opaque = opaque,
+    };
+    g_hash_table_foreach(
+            aio_contexts,
+            scsi_device_for_each_req_async_do_ctx,
+            &params
+    );
 }
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
@@ -349,6 +392,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         dev->lun = lun;
     }
 
+    qemu_mutex_init(&dev->requests_lock);
     QTAILQ_INIT(&dev->requests);
     scsi_device_realize(dev, &local_err);
     if (local_err) {
@@ -369,6 +413,8 @@ static void scsi_qdev_unrealize(DeviceState *qdev)
 
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
 
+    qemu_mutex_destroy(&dev->requests_lock);
+
     scsi_device_unrealize(dev);
 
     blockdev_mark_auto_del(dev->conf.blk);
@@ -965,7 +1011,10 @@ static void scsi_req_enqueue_internal(SCSIRequest *req)
         req->sg = NULL;
     }
     req->enqueued = true;
-    QTAILQ_INSERT_TAIL(&req->dev->requests, req, next);
+
+    WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
+        QTAILQ_INSERT_TAIL(&req->dev->requests, req, next);
+    }
 }
 
 int32_t scsi_req_enqueue(SCSIRequest *req)
@@ -985,7 +1034,9 @@ static void scsi_req_dequeue(SCSIRequest *req)
     trace_scsi_req_dequeue(req->dev->id, req->lun, req->tag);
     req->retry = false;
     if (req->enqueued) {
-        QTAILQ_REMOVE(&req->dev->requests, req, next);
+        WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
+            QTAILQ_REMOVE(&req->dev->requests, req, next);
+        }
         req->enqueued = false;
         scsi_req_unref(req);
     }
@@ -1962,8 +2013,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
 
 static void scsi_dev_instance_init(Object *obj)
 {
-    DeviceState *dev = DEVICE(obj);
-    SCSIDevice *s = SCSI_DEVICE(dev);
+    SCSIDevice *s = SCSI_DEVICE(obj);
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", NULL,
-- 
2.48.1


