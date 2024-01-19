Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB593832ADD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpOG-0004b7-7M; Fri, 19 Jan 2024 08:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpO4-0004On-D9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpO1-0000Xi-RG
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705672700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2el4lWrwQs9wW8nWlHr9CB5rpuIqPf4mA2Y7ahHU5s=;
 b=BG7VvTdjWaUCw5NPs7U04tjNC2HDwRoEHmHQFsXG93KdczLwc13iiDpwbiacCY2PyokCoH
 P+3qlx4MjXX3Z5aeFLY6kx14sS/oQ0KOTZv+veGyK9bpNwWK48pSnUKkJsCf95zoOqbF00
 14ZzW0gdcph99IBE3pzZjWszZQ+STwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-afyjSlwWP7WcUjxUDN3GdQ-1; Fri, 19 Jan 2024 08:58:16 -0500
X-MC-Unique: afyjSlwWP7WcUjxUDN3GdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8704B862CC4;
 Fri, 19 Jan 2024 13:58:16 +0000 (UTC)
Received: from localhost (unknown [10.39.195.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC6EC25C0;
 Fri, 19 Jan 2024 13:58:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] virtio-blk: rename dataplane create/destroy functions
Date: Fri, 19 Jan 2024 08:57:44 -0500
Message-ID: <20240119135748.270944-3-stefanha@redhat.com>
In-Reply-To: <20240119135748.270944-1-stefanha@redhat.com>
References: <20240119135748.270944-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

virtio_blk_data_plane_create() and virtio_blk_data_plane_destroy() are
actually about s->vq_aio_context[] rather than managing
dataplane-specific state.

As a prerequisite to using s->vq_aio_context[] in all code paths (even
when dataplane is not used), rename these functions to reflect that they
just manage s->vq_aio_context and call them regardless of whether or not
dataplane is in use.

Note that virtio-blk supports running with -device
virtio-blk-pci,ioevent=off where the vCPU thread enters the device
emulation code. In this mode ioeventfd is not used for virtqueue
processing. However, we still want to initialize s->vq_aio_context[] to
qemu_aio_context in that case since I/O completion callbacks will be
invoked in the main loop thread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 510cb4248d..47494ebadd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1608,7 +1608,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
         IOThread *iothread = iothread_by_id(node->value->iothread);
         AioContext *ctx = iothread_get_aio_context(iothread);
 
-        /* Released in virtio_blk_data_plane_destroy() */
+        /* Released in virtio_blk_vq_aio_context_cleanup() */
         object_ref(OBJECT(iothread));
 
         if (node->value->vqs) {
@@ -1631,7 +1631,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
 }
 
 /* Context: BQL held */
-static bool virtio_blk_data_plane_create(VirtIOBlock *s, Error **errp)
+static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     VirtIOBlkConf *conf = &s->conf;
@@ -1659,11 +1659,6 @@ static bool virtio_blk_data_plane_create(VirtIOBlock *s, Error **errp)
             return false;
         }
     }
-    /* Don't try if transport does not support notifiers. */
-    if (!virtio_device_ioeventfd_enabled(vdev)) {
-        s->dataplane_disabled = true;
-        return false;
-    }
 
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
@@ -1676,7 +1671,7 @@ static bool virtio_blk_data_plane_create(VirtIOBlock *s, Error **errp)
             s->vq_aio_context[i] = ctx;
         }
 
-        /* Released in virtio_blk_data_plane_destroy() */
+        /* Released in virtio_blk_vq_aio_context_cleanup() */
         object_ref(OBJECT(conf->iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
@@ -1689,7 +1684,7 @@ static bool virtio_blk_data_plane_create(VirtIOBlock *s, Error **errp)
 }
 
 /* Context: BQL held */
-static void virtio_blk_data_plane_destroy(VirtIOBlock *s)
+static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
 
@@ -2015,7 +2010,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
     qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
-    virtio_blk_data_plane_create(s, &err);
+
+    /* Don't start dataplane if transport does not support notifiers. */
+    if (!virtio_device_ioeventfd_enabled(vdev)) {
+        s->dataplane_disabled = true;
+    }
+
+    virtio_blk_vq_aio_context_init(s, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         for (i = 0; i < conf->num_queues; i++) {
@@ -2052,7 +2053,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
 
     blk_drain(s->blk);
     del_boot_device_lchs(dev, "/disk@0,0");
-    virtio_blk_data_plane_destroy(s);
+    virtio_blk_vq_aio_context_cleanup(s);
     for (i = 0; i < conf->num_queues; i++) {
         virtio_del_queue(vdev, i);
     }
-- 
2.43.0


