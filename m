Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F347169EB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Iq-00023n-CQ; Tue, 30 May 2023 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hh-0006wv-2u
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42He-0008TY-NM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=123E95yY9EoHHxjf4VYk1zc9vgfUknZ60ThDYikdDPw=;
 b=JL2b5facbK3g+qe7HgeAcsR0/cAD+yLYuywVu+0Fz5wdmzaVctb/V6rZSf7AAcG35GgDfA
 aMI9III8vDGpAzopLio2NbARd1uZwkqRCWytTuQI9UqKq38gib0t8JrIxDFigrDWYWzw/p
 FeGLj4yVdIb9Z2tBIAmBqcx/3xGcHsc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-2ioook0AOWCwImXyr8BJ4g-1; Tue, 30 May 2023 12:33:14 -0400
X-MC-Unique: 2ioook0AOWCwImXyr8BJ4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 919FC3C17C62;
 Tue, 30 May 2023 16:33:14 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D84CEC154D2;
 Tue, 30 May 2023 16:33:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Date: Tue, 30 May 2023 18:32:36 +0200
Message-Id: <20230530163239.576632-30-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Detach ioeventfds during drained sections to stop I/O submission from
the guest. virtio-blk is no longer reliant on aio_disable_external()
after this patch. This will allow us to remove the
aio_disable_external() API once all other code that relies on it is
converted.

Take extra care to avoid attaching/detaching ioeventfds if the data
plane is started/stopped during a drained section. This should be rare,
but maybe the mirror block job can trigger it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230516190238.8401-18-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 16 ++++++++------
 hw/block/virtio-blk.c           | 38 ++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 4f5c7cd55f..b90456c08c 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -246,13 +246,15 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     }
 
     /* Get this show started by hooking up our callbacks */
-    aio_context_acquire(s->ctx);
-    for (i = 0; i < nvqs; i++) {
-        VirtQueue *vq = virtio_get_queue(s->vdev, i);
+    if (!blk_in_drain(s->conf->conf.blk)) {
+        aio_context_acquire(s->ctx);
+        for (i = 0; i < nvqs; i++) {
+            VirtQueue *vq = virtio_get_queue(s->vdev, i);
 
-        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+        }
+        aio_context_release(s->ctx);
     }
-    aio_context_release(s->ctx);
     return 0;
 
   fail_aio_context:
@@ -322,7 +324,9 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     s->stopping = true;
     trace_virtio_blk_data_plane_stop(s);
 
-    aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
+    if (!blk_in_drain(s->conf->conf.blk)) {
+        aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
+    }
 
     aio_context_acquire(s->ctx);
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8f65ea4659..4ca66b5860 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1506,8 +1506,44 @@ static void virtio_blk_resize(void *opaque)
     aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
 }
 
+/* Suspend virtqueue ioeventfd processing during drain */
+static void virtio_blk_drained_begin(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    AioContext *ctx = blk_get_aio_context(s->conf.conf.blk);
+
+    if (!s->dataplane || !s->dataplane_started) {
+        return;
+    }
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_detach_host_notifier(vq, ctx);
+    }
+}
+
+/* Resume virtqueue ioeventfd processing after drain */
+static void virtio_blk_drained_end(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    AioContext *ctx = blk_get_aio_context(s->conf.conf.blk);
+
+    if (!s->dataplane || !s->dataplane_started) {
+        return;
+    }
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_attach_host_notifier(vq, ctx);
+    }
+}
+
 static const BlockDevOps virtio_block_ops = {
-    .resize_cb = virtio_blk_resize,
+    .resize_cb     = virtio_blk_resize,
+    .drained_begin = virtio_blk_drained_begin,
+    .drained_end   = virtio_blk_drained_end,
 };
 
 static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
-- 
2.40.1


