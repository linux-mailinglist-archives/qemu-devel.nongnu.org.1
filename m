Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A981C003
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:25:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWg-00073r-NH; Thu, 21 Dec 2023 16:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWa-0006tg-4d
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWU-0007zW-BZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJdV4X+lnavj8ZoIfgg+Z3J0O/lFFA5Rp1W5gL/hrq4=;
 b=ZA8zhPTmS8Cg9f2b/uQ0ZTWK9fEVrRvNsr6BUG4i485c9uIbVPG/jyfSFE3fd4YJVdB00F
 Kp9mEBrJgoumZvLNNDNsRPmrjkEbcVk1ypyVOFSpHFH1kD9xpHEvkY1TVxk9RuN7Kdp9ea
 oFBwGsMedPb6JI1Ft9/KIC6qTzI572I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-dTa05JIHNlyxtJU5vJZirg-1; Thu, 21 Dec 2023 16:24:01 -0500
X-MC-Unique: dTa05JIHNlyxtJU5vJZirg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC88101A52A;
 Thu, 21 Dec 2023 21:24:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26B60C15A0C;
 Thu, 21 Dec 2023 21:23:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/33] virtio-blk: add lock to protect s->rq
Date: Thu, 21 Dec 2023 22:23:10 +0100
Message-ID: <20231221212339.164439-6-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

s->rq is accessed from IO_CODE and GLOBAL_STATE_CODE. Introduce a lock
to protect s->rq and eliminate reliance on the AioContext lock.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230914140101.1065008-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  3 +-
 hw/block/virtio-blk.c          | 67 +++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index dafec432ce..9881009c22 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -54,7 +54,8 @@ struct VirtIOBlockReq;
 struct VirtIOBlock {
     VirtIODevice parent_obj;
     BlockBackend *blk;
-    void *rq;
+    QemuMutex rq_lock;
+    void *rq; /* protected by rq_lock */
     VirtIOBlkConf conf;
     unsigned short sector_mask;
     bool original_wce;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1f8e15522..ee38e089bc 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -82,8 +82,11 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
         /* Break the link as the next request is going to be parsed from the
          * ring again. Otherwise we may end up doing a double completion! */
         req->mr_next = NULL;
-        req->next = s->rq;
-        s->rq = req;
+
+        WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+            req->next = s->rq;
+            s->rq = req;
+        }
     } else if (action == BLOCK_ERROR_ACTION_REPORT) {
         virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
         if (acct_failed) {
@@ -1183,10 +1186,13 @@ static void virtio_blk_dma_restart_bh(void *opaque)
 {
     VirtIOBlock *s = opaque;
 
-    VirtIOBlockReq *req = s->rq;
+    VirtIOBlockReq *req;
     MultiReqBuffer mrb = {};
 
-    s->rq = NULL;
+    WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+        req = s->rq;
+        s->rq = NULL;
+    }
 
     aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (req) {
@@ -1238,22 +1244,29 @@ static void virtio_blk_reset(VirtIODevice *vdev)
     AioContext *ctx;
     VirtIOBlockReq *req;
 
+    /* Dataplane has stopped... */
+    assert(!s->dataplane_started);
+
+    /* ...but requests may still be in flight. */
     ctx = blk_get_aio_context(s->blk);
     aio_context_acquire(ctx);
     blk_drain(s->blk);
+    aio_context_release(ctx);
 
     /* We drop queued requests after blk_drain() because blk_drain() itself can
      * produce them. */
-    while (s->rq) {
-        req = s->rq;
-        s->rq = req->next;
-        virtqueue_detach_element(req->vq, &req->elem, 0);
-        virtio_blk_free_request(req);
-    }
+    WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+        while (s->rq) {
+            req = s->rq;
+            s->rq = req->next;
 
-    aio_context_release(ctx);
+            /* No other threads can access req->vq here */
+            virtqueue_detach_element(req->vq, &req->elem, 0);
+
+            virtio_blk_free_request(req);
+        }
+    }
 
-    assert(!s->dataplane_started);
     blk_set_enable_write_cache(s->blk, s->original_wce);
 }
 
@@ -1443,18 +1456,22 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
-    VirtIOBlockReq *req = s->rq;
 
-    while (req) {
-        qemu_put_sbyte(f, 1);
+    WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+        VirtIOBlockReq *req = s->rq;
 
-        if (s->conf.num_queues > 1) {
-            qemu_put_be32(f, virtio_get_queue_index(req->vq));
-        }
+        while (req) {
+            qemu_put_sbyte(f, 1);
 
-        qemu_put_virtqueue_element(vdev, f, &req->elem);
-        req = req->next;
+            if (s->conf.num_queues > 1) {
+                qemu_put_be32(f, virtio_get_queue_index(req->vq));
+            }
+
+            qemu_put_virtqueue_element(vdev, f, &req->elem);
+            req = req->next;
+        }
     }
+
     qemu_put_sbyte(f, 0);
 }
 
@@ -1480,8 +1497,11 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
-        req->next = s->rq;
-        s->rq = req;
+
+        WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
+            req->next = s->rq;
+            s->rq = req;
+        }
     }
 
     return 0;
@@ -1628,6 +1648,8 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
                                             s->host_features);
     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
 
+    qemu_mutex_init(&s->rq_lock);
+
     s->blk = conf->conf.blk;
     s->rq = NULL;
     s->sector_mask = (s->conf.conf.logical_block_size / BDRV_SECTOR_SIZE) - 1;
@@ -1679,6 +1701,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
         virtio_del_queue(vdev, i);
     }
     qemu_coroutine_dec_pool_size(conf->num_queues * conf->queue_size / 2);
+    qemu_mutex_destroy(&s->rq_lock);
     blk_ram_registrar_destroy(&s->blk_ram_registrar);
     qemu_del_vm_change_state_handler(s->change);
     blockdev_mark_auto_del(s->blk);
-- 
2.43.0


