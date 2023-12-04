Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A262F803AA4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAC2l-0005fk-Pj; Mon, 04 Dec 2023 11:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2k-0005fZ-9n
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2e-0003eP-Ud
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701708212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gS+ert4RnNDTMYWvrH77lBFagDngb6vqP+jFNgcaJM=;
 b=R2P29t/vejxO++rrp8u3iykbcyHXaNqnoIc+0XNpF3kyn4pusko8aXSpzbi+KuzIIgwH+s
 8KOKYtfwjvmO1/D7ALwtLqihUhV2/X+u4H+ZFZ1zw/4ldbR5kGLYuZ9xDD+288uZH9t3e9
 YZ48KAybhGzIP3B7DzhUwBmUilD3Cjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-JOQ-3Ip-NKyKMZ8EcNjfwA-1; Mon, 04 Dec 2023 11:43:30 -0500
X-MC-Unique: JOQ-3Ip-NKyKMZ8EcNjfwA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A50D85A5B5;
 Mon,  4 Dec 2023 16:43:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BF56492BFC;
 Mon,  4 Dec 2023 16:43:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 1/4] scsi: only access SCSIDevice->requests from one thread
Date: Mon,  4 Dec 2023 11:42:56 -0500
Message-ID: <20231204164259.1515217-2-stefanha@redhat.com>
In-Reply-To: <20231204164259.1515217-1-stefanha@redhat.com>
References: <20231204164259.1515217-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Stop depending on the AioContext lock and instead access
SCSIDevice->requests from only one thread at a time:
- When the VM is running only the BlockBackend's AioContext may access
  the requests list.
- When the VM is stopped only the main loop may access the requests
  list.

These constraints protect the requests list without the need for locking
in the I/O code path.

Note that multiple IOThreads are not supported yet because the code
assumes all SCSIRequests are executed from a single AioContext. Leave
that as future work.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/hw/scsi/scsi.h |   7 +-
 hw/scsi/scsi-bus.c     | 180 ++++++++++++++++++++++++++++-------------
 2 files changed, 130 insertions(+), 57 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 3692ca82f3..10c4e8288d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -69,14 +69,19 @@ struct SCSIDevice
 {
     DeviceState qdev;
     VMChangeStateEntry *vmsentry;
-    QEMUBH *bh;
     uint32_t id;
     BlockConf conf;
     SCSISense unit_attention;
     bool sense_is_ua;
     uint8_t sense[SCSI_SENSE_BUF_SIZE];
     uint32_t sense_len;
+
+    /*
+     * The requests list is only accessed from the AioContext that executes
+     * requests or from the main loop when IOThread processing is stopped.
+     */
     QTAILQ_HEAD(, SCSIRequest) requests;
+
     uint32_t channel;
     uint32_t lun;
     int blocksize;
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index fc4b77fdb0..f3ec11f892 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -85,6 +85,88 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
     return d;
 }
 
+/*
+ * Invoke @fn() for each enqueued request in device @s. Must be called from the
+ * main loop thread while the guest is stopped. This is only suitable for
+ * vmstate ->put(), use scsi_device_for_each_req_async() for other cases.
+ */
+static void scsi_device_for_each_req_sync(SCSIDevice *s,
+                                          void (*fn)(SCSIRequest *, void *),
+                                          void *opaque)
+{
+    SCSIRequest *req;
+    SCSIRequest *next_req;
+
+    assert(!runstate_is_running());
+    assert(qemu_in_main_thread());
+
+    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
+        fn(req, opaque);
+    }
+}
+
+typedef struct {
+    SCSIDevice *s;
+    void (*fn)(SCSIRequest *, void *);
+    void *fn_opaque;
+} SCSIDeviceForEachReqAsyncData;
+
+static void scsi_device_for_each_req_async_bh(void *opaque)
+{
+    g_autofree SCSIDeviceForEachReqAsyncData *data = opaque;
+    SCSIDevice *s = data->s;
+    AioContext *ctx;
+    SCSIRequest *req;
+    SCSIRequest *next;
+
+    /*
+     * If the AioContext changed before this BH was called then reschedule into
+     * the new AioContext before accessing ->requests. This can happen when
+     * scsi_device_for_each_req_async() is called and then the AioContext is
+     * changed before BHs are run.
+     */
+    ctx = blk_get_aio_context(s->conf.blk);
+    if (ctx != qemu_get_current_aio_context()) {
+        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh, data);
+        return;
+    }
+
+    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
+        data->fn(req, data->fn_opaque);
+    }
+
+    /* Drop the reference taken by scsi_device_for_each_req_async() */
+    object_unref(OBJECT(s));
+}
+
+/*
+ * Schedule @fn() to be invoked for each enqueued request in device @s. @fn()
+ * runs in the AioContext that is executing the request.
+ */
+static void scsi_device_for_each_req_async(SCSIDevice *s,
+                                           void (*fn)(SCSIRequest *, void *),
+                                           void *opaque)
+{
+    assert(qemu_in_main_thread());
+
+    SCSIDeviceForEachReqAsyncData *data =
+        g_new(SCSIDeviceForEachReqAsyncData, 1);
+
+    data->s = s;
+    data->fn = fn;
+    data->fn_opaque = opaque;
+
+    /*
+     * Hold a reference to the SCSIDevice until
+     * scsi_device_for_each_req_async_bh() finishes.
+     */
+    object_ref(OBJECT(s));
+
+    aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
+                            scsi_device_for_each_req_async_bh,
+                            data);
+}
+
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
@@ -144,20 +226,18 @@ void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
     qbus_set_bus_hotplug_handler(BUS(bus));
 }
 
-static void scsi_dma_restart_bh(void *opaque)
+void scsi_req_retry(SCSIRequest *req)
 {
-    SCSIDevice *s = opaque;
-    SCSIRequest *req, *next;
+    req->retry = true;
+}
 
-    qemu_bh_delete(s->bh);
-    s->bh = NULL;
-
-    aio_context_acquire(blk_get_aio_context(s->conf.blk));
-    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
-        scsi_req_ref(req);
-        if (req->retry) {
-            req->retry = false;
-            switch (req->cmd.mode) {
+/* Called in the AioContext that is executing the request */
+static void scsi_dma_restart_req(SCSIRequest *req, void *opaque)
+{
+    scsi_req_ref(req);
+    if (req->retry) {
+        req->retry = false;
+        switch (req->cmd.mode) {
             case SCSI_XFER_FROM_DEV:
             case SCSI_XFER_TO_DEV:
                 scsi_req_continue(req);
@@ -166,37 +246,22 @@ static void scsi_dma_restart_bh(void *opaque)
                 scsi_req_dequeue(req);
                 scsi_req_enqueue(req);
                 break;
-            }
         }
-        scsi_req_unref(req);
     }
-    aio_context_release(blk_get_aio_context(s->conf.blk));
-    /* Drop the reference that was acquired in scsi_dma_restart_cb */
-    object_unref(OBJECT(s));
-}
-
-void scsi_req_retry(SCSIRequest *req)
-{
-    /* No need to save a reference, because scsi_dma_restart_bh just
-     * looks at the request list.  */
-    req->retry = true;
+    scsi_req_unref(req);
 }
 
 static void scsi_dma_restart_cb(void *opaque, bool running, RunState state)
 {
     SCSIDevice *s = opaque;
 
+    assert(qemu_in_main_thread());
+
     if (!running) {
         return;
     }
-    if (!s->bh) {
-        AioContext *ctx = blk_get_aio_context(s->conf.blk);
-        /* The reference is dropped in scsi_dma_restart_bh.*/
-        object_ref(OBJECT(s));
-        s->bh = aio_bh_new_guarded(ctx, scsi_dma_restart_bh, s,
-                                   &DEVICE(s)->mem_reentrancy_guard);
-        qemu_bh_schedule(s->bh);
-    }
+
+    scsi_device_for_each_req_async(s, scsi_dma_restart_req, NULL);
 }
 
 static bool scsi_bus_is_address_free(SCSIBus *bus,
@@ -1657,15 +1722,16 @@ void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
     }
 }
 
+static void scsi_device_purge_one_req(SCSIRequest *req, void *opaque)
+{
+    scsi_req_cancel_async(req, NULL);
+}
+
 void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
 {
-    SCSIRequest *req;
+    scsi_device_for_each_req_async(sdev, scsi_device_purge_one_req, NULL);
 
     aio_context_acquire(blk_get_aio_context(sdev->conf.blk));
-    while (!QTAILQ_EMPTY(&sdev->requests)) {
-        req = QTAILQ_FIRST(&sdev->requests);
-        scsi_req_cancel_async(req, NULL);
-    }
     blk_drain(sdev->conf.blk);
     aio_context_release(blk_get_aio_context(sdev->conf.blk));
     scsi_device_set_ua(sdev, sense);
@@ -1737,31 +1803,33 @@ static char *scsibus_get_fw_dev_path(DeviceState *dev)
 
 /* SCSI request list.  For simplicity, pv points to the whole device */
 
+static void put_scsi_req(SCSIRequest *req, void *opaque)
+{
+    QEMUFile *f = opaque;
+
+    assert(!req->io_canceled);
+    assert(req->status == -1 && req->host_status == -1);
+    assert(req->enqueued);
+
+    qemu_put_sbyte(f, req->retry ? 1 : 2);
+    qemu_put_buffer(f, req->cmd.buf, sizeof(req->cmd.buf));
+    qemu_put_be32s(f, &req->tag);
+    qemu_put_be32s(f, &req->lun);
+    if (req->bus->info->save_request) {
+        req->bus->info->save_request(f, req);
+    }
+    if (req->ops->save_request) {
+        req->ops->save_request(f, req);
+    }
+}
+
 static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
                              const VMStateField *field, JSONWriter *vmdesc)
 {
     SCSIDevice *s = pv;
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
-    SCSIRequest *req;
 
-    QTAILQ_FOREACH(req, &s->requests, next) {
-        assert(!req->io_canceled);
-        assert(req->status == -1 && req->host_status == -1);
-        assert(req->enqueued);
-
-        qemu_put_sbyte(f, req->retry ? 1 : 2);
-        qemu_put_buffer(f, req->cmd.buf, sizeof(req->cmd.buf));
-        qemu_put_be32s(f, &req->tag);
-        qemu_put_be32s(f, &req->lun);
-        if (bus->info->save_request) {
-            bus->info->save_request(f, req);
-        }
-        if (req->ops->save_request) {
-            req->ops->save_request(f, req);
-        }
-    }
+    scsi_device_for_each_req_sync(s, put_scsi_req, f);
     qemu_put_sbyte(f, 0);
-
     return 0;
 }
 
-- 
2.43.0


