Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DE7DD67D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyX-0004OC-6W; Tue, 31 Oct 2023 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxty8-0004CX-Rr
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxh-000684-Mt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csEwfXNoo9FaZsxDRm4Xw2984Qo8bNTHeVvdleYTDNU=;
 b=F9JpQ1Dyt/lyGjPopTFfzdn/5lh/OVtqM7USUgsn5yWeudHL1hDe0PTwptg/yg5IMeCELe
 Ra9PCD8jmoBFmGk2lYgDVfK/vXllo6lUkZHNSzEa/r4QV8v+fejxm8goXiLANW4MzNJZy2
 130TjE2Pk/DYctr7gng1+uc4C3Bbg4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-1DncB-NlM7GVdevAUDlTHw-1; Tue, 31 Oct 2023 14:59:34 -0400
X-MC-Unique: 1DncB-NlM7GVdevAUDlTHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7903F8678A3;
 Tue, 31 Oct 2023 18:59:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDD1E25C0;
 Tue, 31 Oct 2023 18:59:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/27] virtio-blk: remove batch notification BH
Date: Tue, 31 Oct 2023 19:59:08 +0100
Message-ID: <20231031185918.346940-18-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There is a batching mechanism for virtio-blk Used Buffer Notifications
that is no longer needed because the previous commit added batching to
virtio_notify_irqfd().

Note that this mechanism was rarely used in practice because it is only
enabled when EVENT_IDX is not negotiated by the driver. Modern drivers
enable EVENT_IDX.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230913200045.1024233-5-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 48 +--------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index da36fcfd0b..f83bb0f116 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -31,9 +31,6 @@ struct VirtIOBlockDataPlane {
 
     VirtIOBlkConf *conf;
     VirtIODevice *vdev;
-    QEMUBH *bh;                     /* bh for guest notification */
-    unsigned long *batch_notify_vqs;
-    bool batch_notifications;
 
     /* Note that these EventNotifiers are assigned by value.  This is
      * fine as long as you do not call event_notifier_cleanup on them
@@ -47,36 +44,7 @@ struct VirtIOBlockDataPlane {
 /* Raise an interrupt to signal guest, if necessary */
 void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
 {
-    if (s->batch_notifications) {
-        set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
-        qemu_bh_schedule(s->bh);
-    } else {
-        virtio_notify_irqfd(s->vdev, vq);
-    }
-}
-
-static void notify_guest_bh(void *opaque)
-{
-    VirtIOBlockDataPlane *s = opaque;
-    unsigned nvqs = s->conf->num_queues;
-    unsigned long bitmap[BITS_TO_LONGS(nvqs)];
-    unsigned j;
-
-    memcpy(bitmap, s->batch_notify_vqs, sizeof(bitmap));
-    memset(s->batch_notify_vqs, 0, sizeof(bitmap));
-
-    for (j = 0; j < nvqs; j += BITS_PER_LONG) {
-        unsigned long bits = bitmap[j / BITS_PER_LONG];
-
-        while (bits != 0) {
-            unsigned i = j + ctzl(bits);
-            VirtQueue *vq = virtio_get_queue(s->vdev, i);
-
-            virtio_notify_irqfd(s->vdev, vq);
-
-            bits &= bits - 1; /* clear right-most bit */
-        }
-    }
+    virtio_notify_irqfd(s->vdev, vq);
 }
 
 /* Context: QEMU global mutex held */
@@ -126,9 +94,6 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     } else {
         s->ctx = qemu_get_aio_context();
     }
-    s->bh = aio_bh_new_guarded(s->ctx, notify_guest_bh, s,
-                               &DEVICE(vdev)->mem_reentrancy_guard);
-    s->batch_notify_vqs = bitmap_new(conf->num_queues);
 
     *dataplane = s;
 
@@ -146,8 +111,6 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
 
     vblk = VIRTIO_BLK(s->vdev);
     assert(!vblk->dataplane_started);
-    g_free(s->batch_notify_vqs);
-    qemu_bh_delete(s->bh);
     if (s->iothread) {
         object_unref(OBJECT(s->iothread));
     }
@@ -173,12 +136,6 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     s->starting = true;
 
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        s->batch_notifications = true;
-    } else {
-        s->batch_notifications = false;
-    }
-
     /* Set up guest notifier (irq) */
     r = k->set_guest_notifiers(qbus->parent, nvqs, true);
     if (r != 0) {
@@ -370,9 +327,6 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
 
     aio_context_release(s->ctx);
 
-    qemu_bh_cancel(s->bh);
-    notify_guest_bh(s); /* final chance to notify guest */
-
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
 
-- 
2.41.0


