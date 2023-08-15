Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421977CC5B
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVsqT-0000LJ-IG; Tue, 15 Aug 2023 08:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVsqS-0000L7-7f
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVsqP-00055u-Tw
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692101297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obCBV9iwAB64Adum28VKvyDjQMxBK5nxC3zXPfKINJY=;
 b=jVTTBKt9EGZorqVUISD7B+nMDeJRZqJua05bTkSlS6nejr220wIah+3nXUBTHLeFBPSmQ3
 JTvC4Sx2cdCbfuiD8ljA+E5F7JJNcyZBSaLufUm167TKyyr3KoghS+rI/boPsxoY6ICI+f
 SfZ5jjp8rdOAxvJdXKBV5NM3tMqLC3I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221--2q4kwXBPWWE9tSRVxPEoA-1; Tue, 15 Aug 2023 08:08:13 -0400
X-MC-Unique: -2q4kwXBPWWE9tSRVxPEoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 561E63C0FC8B;
 Tue, 15 Aug 2023 12:08:13 +0000 (UTC)
Received: from localhost (unknown [10.39.193.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3231C40C207A;
 Tue, 15 Aug 2023 12:08:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] virtio-blk: remove batch notification BH
Date: Tue, 15 Aug 2023 08:08:05 -0400
Message-ID: <20230815120805.3235166-3-stefanha@redhat.com>
In-Reply-To: <20230815120805.3235166-1-stefanha@redhat.com>
References: <20230815120805.3235166-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is a batching mechanism for virtio-blk Used Buffer Notifications
that is no longer needed because the previous commit added batching to
virtio_notify_irqfd().

Note that this mechanism was rarely used in practice because it is only
enabled when EVENT_IDX is not negotiated by the driver. Modern drivers
enable EVENT_IDX.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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


