Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867229AF5DF
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t47Mq-0008Lm-TG; Thu, 24 Oct 2024 19:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47Mo-0008Lb-Em
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:46 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47Mm-0002tx-CA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729812934; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mP0pzUU6pnplqcfOtboIXEcvYzbiL7+2xsSxZWlL3uUOcXddcciaIeau+WO52hUf7kQaaRyWLWMKsb/XTNRVPMLapE1BTmvdmJyzf8iwhKFlQJo4dG+msNkHKP4IeIBGALZE8JA4ylgSkhFuJaGbXWsBVSAndcf/a9BcDVEXzWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729812934;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UIrT+d8Fj9BlY6KoxCZGQu3crWhc3ifr03h/cegV8uY=; 
 b=jbzraQV19fWSLhrp6sHuFCrwyue71v4jEjRaLXPqrxkNkjCH/gjkuKaWFu9Gt4qlVP9Oc5yq+GlT5oTumdG+Ql9JzxjiCRg+JRqNrFuWLdZ4MSLM89aTmdFX7KxWTJyR0d7OLwSonFNsFN42+snST+3ClQxHUvzOdhRhp4IVsVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729812934; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=UIrT+d8Fj9BlY6KoxCZGQu3crWhc3ifr03h/cegV8uY=;
 b=jwToJs9v9yByHL4jYkvI3TwvAqZMkrOH6N9XAGdx8kVbAz1N0ht58SEj5isArUQe
 Fjoj98RBbGXRoG9p3Uya1+HM7lOz4fQUFjlnAguBhWmsCe1uViZPdDn4hi9sQFYto6Z
 BisxMdBw2ptxHpY30QF16SUQvxNDmE8pX36qI7+A=
Received: by mx.zohomail.com with SMTPS id 1729812933029145.5689415582865;
 Thu, 24 Oct 2024 16:35:33 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v3 6/6] virtio-gpu: Support DRM native context
Date: Fri, 25 Oct 2024 02:33:54 +0300
Message-ID: <20241024233355.136867-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
using a new virtio-gpu-gl device option "drm=on".

Unlike Virgl and Venus contexts that operate on application API level,
DRM native contexts work on a kernel UAPI level. This lower level results
in a lightweight context implementations that yield better performance.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio-gpu.rst | 11 +++++++++++
 hw/display/virtio-gpu-gl.c         |  2 ++
 hw/display/virtio-gpu-virgl.c      | 22 ++++++++++++++++++++++
 hw/display/virtio-gpu.c            | 15 +++++++++++++++
 include/hw/virtio/virtio-gpu.h     |  3 +++
 5 files changed, 53 insertions(+)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index b7eb0fc0e727..49a75138f7ef 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
 
+DRM native context is supported since release of `virglrenderer`_ v1.0.0
+using `drm`_ protocol. ``DRM`` virtio-gpu capability set ("capset") requires
+host blob support (``hostmem`` and ``blob`` fields) and should be enabled
+using ``drm`` field. The ``hostmem`` field specifies the size of virtio-gpu
+host memory window. This is typically between 256M and 8G.
+
+.. parsed-literal::
+    -device virtio-gpu-gl,hostmem=8G,blob=on,drm=on
+
+.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
+
 virtio-gpu rutabaga
 -------------------
 
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 53d938f23f20..bd0c0692a5c4 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("drm", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 37b40e258398..89ca1878fb7c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1232,6 +1232,19 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
@@ -1294,5 +1307,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
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
index c0570ef8565a..c1acafe6246b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1492,6 +1492,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
index 99cc6286f473..f1799fcb6eee 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -98,6 +98,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
+    VIRTIO_GPU_FLAG_DRM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -118,6 +119,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_drm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.47.0


