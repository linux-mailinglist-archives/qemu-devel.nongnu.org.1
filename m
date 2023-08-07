Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 364287730A1
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT78p-000586-OL; Mon, 07 Aug 2023 16:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78m-00057v-4C
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78k-0006gr-Ir
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xD27uz9lwEBIgcuTs4tdsM5dnZ8LU2gTNw6lVv+7ZdA=;
 b=I+0KAxTBaCvcM9AmfxIcRGUmfUNnS2e25lEZdCNI1ooLn/TD8e5zXS10H/mmgnYqqrgqHA
 oRcvdfpCQM7ydPSBrsdTAbfHCqa4IxKkE9Dw2kv01G0drZok055v7WcvYswZrL9OuuprJ7
 NZSYr52YxXNG1aMzZ2yfkqGaTV/xOu4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-CPpGrhwePgypIAGB56hIfg-1; Mon, 07 Aug 2023 16:47:41 -0400
X-MC-Unique: CPpGrhwePgypIAGB56hIfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25354185A791;
 Mon,  7 Aug 2023 20:47:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9347E1759C;
 Mon,  7 Aug 2023 20:47:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 3/6] virtio-gpu: reset gfx resources in main thread
Date: Tue,  8 Aug 2023 00:47:14 +0400
Message-ID: <20230807204717.2483983-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
References: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Calling OpenGL from different threads can have bad consequences if not
carefully reviewed. It's not generally supported. In my case, I was
debugging a crash in glDeleteTextures from OPENGL32.DLL, where I asked
qemu for gl=es, and thus ANGLE implementation was expected. libepoxy did
resolution of the global pointer for glGenTexture to the GLES version
from the main thread. But it resolved glDeleteTextures to the GL
version, because it was done from a different thread without correct
context. Oops.

Let's stick to the main thread for GL calls by using a BH.

Note: I didn't use atomics for reset_finished check, assuming the BQL
will provide enough of sync, but I might be wrong.

Acked-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230726173929.690601-3-marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  3 +++
 hw/display/virtio-gpu.c        | 38 +++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 05bee09e1a..390c4642b8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,6 +169,9 @@ struct VirtIOGPU {
 
     QEMUBH *ctrl_bh;
     QEMUBH *cursor_bh;
+    QEMUBH *reset_bh;
+    QemuCond reset_cond;
+    bool reset_finished;
 
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b1f5d392bb..bbd5c6561a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/iov.h"
+#include "sysemu/cpus.h"
 #include "ui/console.h"
 #include "trace.h"
 #include "sysemu/dma.h"
@@ -41,6 +42,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
 
 static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                        struct virtio_gpu_simple_resource *res);
+static void virtio_gpu_reset_bh(void *opaque);
 
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
@@ -1387,6 +1389,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
                                      &qdev->mem_reentrancy_guard);
     g->cursor_bh = qemu_bh_new_guarded(virtio_gpu_cursor_bh, g,
                                        &qdev->mem_reentrancy_guard);
+    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
+    qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
@@ -1398,20 +1402,44 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
+    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
+    qemu_cond_destroy(&g->reset_cond);
     virtio_gpu_base_device_unrealize(qdev);
 }
 
-void virtio_gpu_reset(VirtIODevice *vdev)
+static void virtio_gpu_reset_bh(void *opaque)
 {
-    VirtIOGPU *g = VIRTIO_GPU(vdev);
+    VirtIOGPU *g = VIRTIO_GPU(opaque);
     struct virtio_gpu_simple_resource *res, *tmp;
-    struct virtio_gpu_ctrl_command *cmd;
     int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         virtio_gpu_resource_destroy(g, res);
     }
 
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
+    }
+
+    g->reset_finished = true;
+    qemu_cond_signal(&g->reset_cond);
+}
+
+void virtio_gpu_reset(VirtIODevice *vdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(vdev);
+    struct virtio_gpu_ctrl_command *cmd;
+
+    if (qemu_in_vcpu_thread()) {
+        g->reset_finished = false;
+        qemu_bh_schedule(g->reset_bh);
+        while (!g->reset_finished) {
+            qemu_cond_wait_iothread(&g->reset_cond);
+        }
+    } else {
+        virtio_gpu_reset_bh(g);
+    }
+
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
@@ -1425,10 +1453,6 @@ void virtio_gpu_reset(VirtIODevice *vdev)
         g_free(cmd);
     }
 
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
-    }
-
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 }
 
-- 
2.41.0


