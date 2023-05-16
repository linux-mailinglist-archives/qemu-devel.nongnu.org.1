Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3A7056B2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzxc-0002Jw-VX; Tue, 16 May 2023 15:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxa-0002Il-Kr
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxY-0001JY-Lw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRBk3QHXWdSEXDTSHgVJYXRAQiXNN4MdRJe8NcVGhXU=;
 b=iAK3l8Mt9x5YCOGTSqQKS/+J0ZjaH9yF9bt1vdxJUgQwEzohNlF2go4F6HdlFP8KfBA7+M
 koDGccwfc9HtibNoQLq5MfQpc4s4HFK9sXE4s4fHz2ETySsjwiITqDPs3oLPL1tLKmKg9Z
 6la0aNc2qTEvCGV76S/EOUXaVAYeDSo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-yjE8Q2lfPmWXjJNlZq6Baw-1; Tue, 16 May 2023 15:03:41 -0400
X-MC-Unique: yjE8Q2lfPmWXjJNlZq6Baw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 032B81C060D4;
 Tue, 16 May 2023 19:03:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68FC1492B00;
 Tue, 16 May 2023 19:03:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 eesposit@redhat.com, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v6 16/20] virtio: make it possible to detach host notifier
 from any thread
Date: Tue, 16 May 2023 15:02:34 -0400
Message-Id: <20230516190238.8401-17-stefanha@redhat.com>
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virtio_queue_aio_detach_host_notifier() does two things:
1. It removes the fd handler from the event loop.
2. It processes the virtqueue one last time.

The first step can be peformed by any thread and without taking the
AioContext lock.

The second step may need the AioContext lock (depending on the device
implementation) and runs in the thread where request processing takes
place. virtio-blk and virtio-scsi therefore call
virtio_queue_aio_detach_host_notifier() from a BH that is scheduled in
AioContext.

The next patch will introduce a .drained_begin() function that needs to
call virtio_queue_aio_detach_host_notifier(). .drained_begin() functions
cannot call aio_poll() to wait synchronously for the BH. It is possible
for a .drained_poll() callback to asynchronously wait for the BH, but
that is more complex than necessary here.

Move the virtqueue processing out to the callers of
virtio_queue_aio_detach_host_notifier() so that the function can be
called from any thread. This is in preparation for the next patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c |  7 +++++++
 hw/scsi/virtio-scsi-dataplane.c | 14 ++++++++++++++
 hw/virtio/virtio.c              |  3 ---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index af1c24c40c..4f5c7cd55f 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -287,8 +287,15 @@ static void virtio_blk_data_plane_stop_bh(void *opaque)
 
     for (i = 0; i < s->conf->num_queues; i++) {
         VirtQueue *vq = virtio_get_queue(s->vdev, i);
+        EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
 
         virtio_queue_aio_detach_host_notifier(vq, s->ctx);
+
+        /*
+         * Test and clear notifier after disabling event, in case poll callback
+         * didn't have time to run.
+         */
+        virtio_queue_host_notifier_read(host_notifier);
     }
 }
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index f3214e1c57..b3a1ed21f7 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -71,12 +71,26 @@ static void virtio_scsi_dataplane_stop_bh(void *opaque)
 {
     VirtIOSCSI *s = opaque;
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    EventNotifier *host_notifier;
     int i;
 
     virtio_queue_aio_detach_host_notifier(vs->ctrl_vq, s->ctx);
+    host_notifier = virtio_queue_get_host_notifier(vs->ctrl_vq);
+
+    /*
+     * Test and clear notifier after disabling event, in case poll callback
+     * didn't have time to run.
+     */
+    virtio_queue_host_notifier_read(host_notifier);
+
     virtio_queue_aio_detach_host_notifier(vs->event_vq, s->ctx);
+    host_notifier = virtio_queue_get_host_notifier(vs->event_vq);
+    virtio_queue_host_notifier_read(host_notifier);
+
     for (i = 0; i < vs->conf.num_queues; i++) {
         virtio_queue_aio_detach_host_notifier(vs->cmd_vqs[i], s->ctx);
+        host_notifier = virtio_queue_get_host_notifier(vs->cmd_vqs[i]);
+        virtio_queue_host_notifier_read(host_notifier);
     }
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 272d930721..cb09cb6464 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3516,9 +3516,6 @@ void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioContext *ct
 void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx)
 {
     aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL, NULL, NULL);
-    /* Test and clear notifier before after disabling event,
-     * in case poll callback didn't have time to run. */
-    virtio_queue_host_notifier_read(&vq->host_notifier);
 }
 
 void virtio_queue_host_notifier_read(EventNotifier *n)
-- 
2.40.1


