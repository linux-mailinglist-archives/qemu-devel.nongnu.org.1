Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA7A5891B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 00:08:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPk7-0003Ws-PL; Sun, 09 Mar 2025 19:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPjw-0003UZ-Tv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:31 -0400
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPju-0004jC-T4
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741561627; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LKKFDIKdpodzWA2Pl/mNofRpUCWrdN2l5HR+ntpdV2LfmkOCxv0xWZfEg53lFRPm73i593+EvMB8qEDu+0wvCLeahaxjlLv7lvHQ4zHZcwm1WyPdhLK4Ih1rTUoxYoxqprBP8lCf5aXunGcH09fvTIKyDIU4YyszLEKZPVlGhqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741561627;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pygFRisAQ59d6C3E1zmX+5bDnZem2wfFu0UhBK1SqvI=; 
 b=NX3styTrzKQUzLrsRueQNfSOeC4oqd5Tpu3bCPe4yR56quufW6++i82uuYQaQvqQ/m1jZfdiVW3618z1LHsuLgNhKyg23CTIQyC8Cy+4rLMc5x5ahZHmsTJ70xr8F0Fjyq8+aQEuDZXNzESsqxXC0fgmWXW4VJuiiqFr60T9LDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741561627; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pygFRisAQ59d6C3E1zmX+5bDnZem2wfFu0UhBK1SqvI=;
 b=Lm9U2lIZM9Feegm5WHLN6gLgAWn1OU5MQViPsRVziJB36uFNCvKMWs2AMbzZlfaA
 r1N6EhgKkxZnl2G4EhKRxpKulemSoGUkD7iMZrNWi6b25/G0oTOcwvEEDd7DMl+uWDM
 Mkmow8S0G+XbKbLzwTkg0o+RdCAAq84Z9fOnEZCc=
Received: by mx.zohomail.com with SMTPS id 1741561625215643.525695700454;
 Sun, 9 Mar 2025 16:07:05 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v9 05/10] virtio-gpu: Support DRM native context
Date: Mon, 10 Mar 2025 02:05:34 +0300
Message-ID: <20250309230539.125374-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
References: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
using a new virtio-gpu-gl device option "drm_native_context=on".

Unlike Virgl and Venus contexts that operate on application API level,
DRM native contexts work on a kernel UAPI level. This lower level results
in a lightweight context implementations that yield better performance.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio-gpu.rst | 11 +++++++++++
 hw/display/virtio-gpu-gl.c         |  2 ++
 hw/display/virtio-gpu-virgl.c      | 22 ++++++++++++++++++++++
 hw/display/virtio-gpu.c            | 15 +++++++++++++++
 include/hw/virtio/virtio-gpu.h     |  3 +++
 5 files changed, 53 insertions(+)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index b7eb0fc0e727..f20c60016376 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
 
+DRM native context is supported since release of `virglrenderer`_ v1.0.0
+using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
+host blob support (``hostmem`` and ``blob`` fields) and should be enabled
+using ``drm_native_context`` field.  The ``hostmem`` field specifies the size
+of virtio-gpu host memory window. This is typically between 256M and 8G.
+
+.. parsed-literal::
+    -device virtio-gpu-gl,hostmem=8G,blob=on,drm_native_context=on
+
+.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
+
 virtio-gpu rutabaga
 -------------------
 
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index d9bb50ac1d4a..5f374ad56396 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ee896eced67c..184ad2c588f7 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1248,6 +1248,19 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_DRM;
+
+        if (!gl->context_fence_enabled) {
+            /*
+             * Virglrenderer skips enabling DRM context support without
+             * enabled async-fence feature. VirtIO-GPU will initialize
+             * successfully, but DRM context won't be available in guest.
+             */
+            error_report("DRM native context requires EGL display");
+            return -EINVAL;
+        }
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1310,5 +1323,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DRM);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 11a7a8575027..165a0976480d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1505,6 +1505,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR >= 1
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "drm requires enabled blob and hostmem options");
+            return;
+        }
+    #else
+        error_setg(errp, "old virglrenderer, drm unsupported");
+        return;
+    #endif
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index bd2cccdc60d7..dcdf52b192b5 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_DRM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -121,6 +122,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_drm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.48.1


