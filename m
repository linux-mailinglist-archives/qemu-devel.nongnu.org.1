Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAA8C3330
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 20:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5rPa-0000K7-6x; Sat, 11 May 2024 14:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPX-0000JS-Us
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:31 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPU-0004zS-TL
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715451925;
 bh=XkGEJowXsaobsuCyn7JXewaWmvdES6n2Hv+/cjLkoyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sW7MCpoPHssUYVaZmSGu4ki0o0rj+grnq6cZonymWAzdGbOvRgmTR+lMRIVqmNaR9
 dFM7EG5UukxiZSw/0R6nxYfOKDo1AnCXlRdDMId1V5yzOCiiHNl14RiG5BBIFFKEEy
 WL5ZoweOmU445WMfMoedz17XKlCzpCCw2XGg8bjpOE5ecqLjmCvQVJF6MVjujDiaLJ
 XQZvIUlgUF2+ScebAFNTvBSsLpEmWOaL7NGTmVF9UdhNaWqN/DGzNYcF2tYf2FkbiF
 QQCXGbQ1TcQIL4AkPl2L4HrLhKaF7KIkN6v+Ww+gwPXhPGy09A7x575I0vuzTxeYGf
 2RplrlojO7Rtw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 541C63780BFE;
 Sat, 11 May 2024 18:25:23 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v11 05/10] virtio-gpu: Add virgl resource management
Date: Sat, 11 May 2024 21:22:46 +0300
Message-ID: <20240511182251.1442078-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Huang Rui <ray.huang@amd.com>

In a preparation to adding host blobs support to virtio-gpu, add virgl
resource management that allows to retrieve resource based on its ID
and virgl resource wrapper on top of simple resource that will be contain
fields specific to virgl.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8306961ad502..c6c63ca1c373 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -22,6 +22,23 @@
 
 #include <virglrenderer.h>
 
+struct virtio_gpu_virgl_resource {
+    struct virtio_gpu_simple_resource base;
+};
+
+static struct virtio_gpu_virgl_resource *
+virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    res = virtio_gpu_find_resource(g, resource_id);
+    if (!res) {
+        return NULL;
+    }
+
+    return container_of(res, struct virtio_gpu_virgl_resource, base);
+}
+
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
 static void *
 virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
@@ -35,11 +52,34 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
 {
     struct virtio_gpu_resource_create_2d c2d;
     struct virgl_renderer_resource_create_args args;
+    struct virtio_gpu_virgl_resource *res;
 
     VIRTIO_GPU_FILL_CMD(c2d);
     trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
                                        c2d.width, c2d.height);
 
+    if (c2d.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, c2d.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, c2d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.width = c2d.width;
+    res->base.height = c2d.height;
+    res->base.format = c2d.format;
+    res->base.resource_id = c2d.resource_id;
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+
     args.handle = c2d.resource_id;
     args.target = 2;
     args.format = c2d.format;
@@ -59,11 +99,34 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
 {
     struct virtio_gpu_resource_create_3d c3d;
     struct virgl_renderer_resource_create_args args;
+    struct virtio_gpu_virgl_resource *res;
 
     VIRTIO_GPU_FILL_CMD(c3d);
     trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
                                        c3d.width, c3d.height, c3d.depth);
 
+    if (c3d.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, c3d.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, c3d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.width = c3d.width;
+    res->base.height = c3d.height;
+    res->base.format = c3d.format;
+    res->base.resource_id = c3d.resource_id;
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+
     args.handle = c3d.resource_id;
     args.target = c3d.target;
     args.format = c3d.format;
@@ -82,12 +145,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
                                      struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_resource_unref unref;
+    struct virtio_gpu_virgl_resource *res;
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
 
     VIRTIO_GPU_FILL_CMD(unref);
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
 
+    res = virtio_gpu_virgl_find_resource(g, unref.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, unref.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);
@@ -95,6 +167,10 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
     }
     virgl_renderer_resource_unref(unref.resource_id);
+
+    QTAILQ_REMOVE(&g->reslist, &res->base, next);
+
+    g_free(res);
 }
 
 static void virgl_cmd_context_create(VirtIOGPU *g,
-- 
2.44.0


