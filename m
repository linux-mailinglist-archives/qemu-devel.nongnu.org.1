Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C798F8C3327
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 20:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5rPl-0000Mm-2e; Sat, 11 May 2024 14:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPh-0000MY-Ue
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:42 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPf-00050k-22
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715451938;
 bh=tX1Kv00Kh4V/8LCT/g3oGEZcliaD3DWwB//5PkZ2i2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=igEGbtJQGtPDdcGVagfOSKcRyGh7ZosBOWftm8T9gpK+5toauXKql4exOKKbpVCmQ
 ueVC0W0R9Gj61IWy8SvMQCSOLowsn9d2SXJZG2EU3rV2kvJ4kcR9m8D2RqFTJqRee3
 FGbDiRQUC+a3llYnY+y/zOQiqF2taNq2Cwi6KYHYEFrJ0acV+pSLDB/eZEtpfPK3gQ
 OfwmNBVDxWEIKDnT3IvuZen/nDSu6ejYt/kVDX+/FbVa+me8stlaZaovrS58JRvV7a
 UAd5S+PiheHMTNubsjCGFHK6uf7SUiZetCvzow8L1vVmn1ACtu9lYeFv9YtuMxiZsw
 y37YYghpr/5/w==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19E163782190;
 Sat, 11 May 2024 18:25:36 +0000 (UTC)
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
Subject: [PATCH v11 10/10] virtio-gpu: Support Venus context
Date: Sat, 11 May 2024 21:22:51 +0300
Message-ID: <20240511182251.1442078-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Request Venus when initializing VirGL and if venus=true flag is set for
virtio-gpu-gl device.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |  2 ++
 hw/display/virtio-gpu-virgl.c  | 22 ++++++++++++++++++----
 hw/display/virtio-gpu.c        | 13 +++++++++++++
 include/hw/virtio/virtio-gpu.h |  3 +++
 meson.build                    |  1 +
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 431fc2881a00..1deb3e64b781 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -137,6 +137,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
+    DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 135974431492..f1cad005dd8f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1094,6 +1094,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
+#ifdef VIRGL_RENDERER_VENUS
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+    }
+#endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
@@ -1124,7 +1129,7 @@ static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
 
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset_max_ver, capset_max_size;
     GArray *capset_ids;
 
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
@@ -1133,12 +1138,21 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
     virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
 
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
-    if (capset2_max_ver) {
+                               &capset_max_ver,
+                               &capset_max_size);
+    if (capset_max_ver) {
         virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VENUS);
+        }
+    }
+
     return capset_ids;
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 052ab493a00b..0518bb858e88 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1491,6 +1491,19 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+#ifdef HAVE_VIRGL_VENUS
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "venus requires enabled blob and hostmem options");
+            return;
+        }
+#else
+        error_setg(errp, "old virglrenderer, venus unsupported");
+        return;
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7bbc6ef268eb..9940bbcbaacc 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
+    VIRTIO_GPU_FLAG_VENUS_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -117,6 +118,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
+#define virtio_gpu_venus_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
diff --git a/meson.build b/meson.build
index 0433ea200dd7..20241931730f 100644
--- a/meson.build
+++ b/meson.build
@@ -2290,6 +2290,7 @@ if virgl.version().version_compare('>=1.0.0')
   config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
   config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
   config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
+  config_host_data.set('HAVE_VIRGL_VENUS', 1)
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.44.0


