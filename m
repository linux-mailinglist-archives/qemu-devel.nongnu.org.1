Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB8F763DEA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 19:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOiUF-0002xs-7R; Wed, 26 Jul 2023 13:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOiUD-0002xj-0n
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qOiUA-0006cv-H2
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690393181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYM6uxaZfl+DHpNBghH3CGOwHwAM9yI3jvUiWgUH0Qg=;
 b=edihfhfdbm9WVzQNepEgDc63UUZDihHNYfbOEzP+TP3MWi6lMi7s+mjgXKv0ZwWWgrXMlg
 jRsiCoTESyxyu1eTDY+DMH3nTuIXkBWsD+8mfA0+xBPhBYIJXPiRn/z94sWu5mr/V43eWO
 MTeWQ/NUlliWZeQKIfrj8Il4C2ifwxA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-AlGvtBaXP12wsUimSc81iw-1; Wed, 26 Jul 2023 13:39:37 -0400
X-MC-Unique: AlGvtBaXP12wsUimSc81iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F5823C0ED5C
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 17:39:37 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 710F4C2C7D3;
 Wed, 26 Jul 2023 17:39:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] virtio-gpu: free BHs, by implementing unrealize
Date: Wed, 26 Jul 2023 21:39:28 +0400
Message-ID: <20230726173929.690601-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230726173929.690601-1-marcandre.lureau@redhat.com>
References: <20230726173929.690601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu-base.c   |  2 +-
 hw/display/virtio-gpu.c        | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7ea8ae2bee..05bee09e1a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -238,6 +238,7 @@ bool virtio_gpu_base_device_realize(DeviceState *qdev,
                                     VirtIOHandleOutput ctrl_cb,
                                     VirtIOHandleOutput cursor_cb,
                                     Error **errp);
+void virtio_gpu_base_device_unrealize(DeviceState *qdev);
 void virtio_gpu_base_reset(VirtIOGPUBase *g);
 void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
                         struct virtio_gpu_resp_display_info *dpy_info);
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7ab7d08d0a..ca1fb7b16f 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -244,7 +244,7 @@ virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
     trace_virtio_gpu_features(((features & virgl) == virgl));
 }
 
-static void
+void
 virtio_gpu_base_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e8603d78ca..b1f5d392bb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1392,6 +1392,15 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     QTAILQ_INIT(&g->fenceq);
 }
 
+static void virtio_gpu_device_unrealize(DeviceState *qdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(qdev);
+
+    g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
+    g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
+    virtio_gpu_base_device_unrealize(qdev);
+}
+
 void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
@@ -1492,6 +1501,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;
 
     vdc->realize = virtio_gpu_device_realize;
+    vdc->unrealize = virtio_gpu_device_unrealize;
     vdc->reset = virtio_gpu_reset;
     vdc->get_config = virtio_gpu_get_config;
     vdc->set_config = virtio_gpu_set_config;
-- 
2.41.0


