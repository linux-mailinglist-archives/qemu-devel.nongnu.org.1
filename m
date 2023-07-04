Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4532747518
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhkm-0005tD-6D; Tue, 04 Jul 2023 11:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGhkd-0005sE-Oa
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGhkb-0000Gl-VO
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688483733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+4f1BTBrGPeL+aMgNruwrm/piaTYfPvUr4lyKEqSVQ=;
 b=fBeIcQP71BklmEr2i4m8Zq6zFL9hvvukpj5Q5X4uJwE7l/5CfJlyUCF8WpMKiTfMhKGpHE
 ww8tkEYY2381uV+GIY+wbiyp1Hyu0a2qWqlR+wT3qvmuE1krX6BkpwEWDiwmsJp80sRIF7
 QirCcgVbU5E1O4sa5x+ZNBv9TZ/GKjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-XIMsJH2aMampqapQmcN98Q-1; Tue, 04 Jul 2023 11:15:30 -0400
X-MC-Unique: XIMsJH2aMampqapQmcN98Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06361185A78B;
 Tue,  4 Jul 2023 15:15:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92BD140C2063;
 Tue,  4 Jul 2023 15:15:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Subject: [PATCH] virtio-blk: fix host notifier issues during dataplane
 start/stop
Date: Tue,  4 Jul 2023 17:15:27 +0200
Message-Id: <20230704151527.193586-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The main loop thread can consume 100% CPU when using --device
virtio-blk-pci,iothread=<iothread>. ppoll() constantly returns but
reading virtqueue host notifiers fails with EAGAIN. The file descriptors
are stale and remain registered with the AioContext because of bugs in
the virtio-blk dataplane start/stop code.

The problem is that the dataplane start/stop code involves drain
operations, which call virtio_blk_drained_begin() and
virtio_blk_drained_end() at points where the host notifier is not
operational:
- In virtio_blk_data_plane_start(), blk_set_aio_context() drains after
  vblk->dataplane_started has been set to true but the host notifier has
  not been attached yet.
- In virtio_blk_data_plane_stop(), blk_drain() and blk_set_aio_context()
  drain after the host notifier has already been detached but with
  vblk->dataplane_started still set to true.

I would like to simplify ->ioeventfd_start/stop() to avoid interactions
with drain entirely, but couldn't find a way to do that. Instead, this
patch accepts the fragile nature of the code and reorders it so that
vblk->dataplane_started is false during drain operations. This way the
virtio_blk_drained_begin() and virtio_blk_drained_end() calls don't
touch the host notifier. The result is that
virtio_blk_data_plane_start() and virtio_blk_data_plane_stop() have
complete control over the host notifier and stale file descriptors are
no longer left in the AioContext.

This patch fixes the 100% CPU consumption in the main loop thread and
correctly moves host notifier processing to the IOThread.

Fixes: 1665d9326fd2 ("virtio-blk: implement BlockDevOps->drained_begin()")
Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 67 +++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index c227b39408..da36fcfd0b 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -219,13 +219,6 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     memory_region_transaction_commit();
 
-    /*
-     * These fields are visible to the IOThread so we rely on implicit barriers
-     * in aio_context_acquire() on the write side and aio_notify_accept() on
-     * the read side.
-     */
-    s->starting = false;
-    vblk->dataplane_started = true;
     trace_virtio_blk_data_plane_start(s);
 
     old_context = blk_get_aio_context(s->conf->conf.blk);
@@ -244,6 +237,18 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
         event_notifier_set(virtio_queue_get_host_notifier(vq));
     }
 
+    /*
+     * These fields must be visible to the IOThread when it processes the
+     * virtqueue, otherwise it will think dataplane has not started yet.
+     *
+     * Make sure ->dataplane_started is false when blk_set_aio_context() is
+     * called above so that draining does not cause the host notifier to be
+     * detached/attached prematurely.
+     */
+    s->starting = false;
+    vblk->dataplane_started = true;
+    smp_wmb(); /* paired with aio_notify_accept() on the read side */
+
     /* Get this show started by hooking up our callbacks */
     if (!blk_in_drain(s->conf->conf.blk)) {
         aio_context_acquire(s->ctx);
@@ -273,7 +278,6 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
   fail_guest_notifiers:
     vblk->dataplane_disabled = true;
     s->starting = false;
-    vblk->dataplane_started = true;
     return -ENOSYS;
 }
 
@@ -327,6 +331,32 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
         aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
     }
 
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+    }
+
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
+    }
+
+    /*
+     * Set ->dataplane_started to false before draining so that host notifiers
+     * are not detached/attached anymore.
+     */
+    vblk->dataplane_started = false;
+
     aio_context_acquire(s->ctx);
 
     /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
@@ -340,32 +370,11 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
 
     aio_context_release(s->ctx);
 
-    /*
-     * Batch all the host notifiers in a single transaction to avoid
-     * quadratic time complexity in address_space_update_ioeventfds().
-     */
-    memory_region_transaction_begin();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
-    }
-
-    /*
-     * The transaction expects the ioeventfds to be open when it
-     * commits. Do it now, before the cleanup loop.
-     */
-    memory_region_transaction_commit();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
-    }
-
     qemu_bh_cancel(s->bh);
     notify_guest_bh(s); /* final chance to notify guest */
 
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
 
-    vblk->dataplane_started = false;
     s->stopping = false;
 }
-- 
2.40.1


