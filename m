Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF324A2DF41
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Feb 2025 18:00:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thAei-0003AX-Ed; Sun, 09 Feb 2025 11:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1thAeb-0002pr-AV
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 11:59:33 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1thAeY-0007Sp-PS
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 11:59:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739120359; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ch7Wr0WpEnC6kcEhkYTOQKUQFr3yp3PZ5y20NQzHWW4mydEfrRSOKJUQyHsVn1jCSF5i6k+kZdxtOlitguLL+jKCdr0BnzQ6DlMltecXPCaStb6PDu1a2shKfOS2rd9qeM0HJRXJyAg17gIjD3GqFCWgksiDTutsU40SCxaGO10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739120359;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=64uV+I0WgV7YvBrDsehY8khnJNZ+HrjZx/C48Sc9hm8=; 
 b=V/JsZ9DjxCjTfCb9tb+jusBJK3TnYhaDRS4QXqarJN4SU/VLGxdthyuNGO9aKOIx3VK4BNEePQWn3UgQ0N97pXygjgor7JMAVrNBPha0V0Z09wksnak4UyGNxuDGBdv+vw5XVEcF9NxR50grKUfx2QwsBVy+7uOKJZP8Rlzc1gM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739120359; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=64uV+I0WgV7YvBrDsehY8khnJNZ+HrjZx/C48Sc9hm8=;
 b=DWUeyxiO9qFHRMA7ks5bgDeX3fyTuSMoDzSB0rGXk8ASGFykiu1q2FJvk8b4soYN
 KHDTAerP2YBadXRlDQfs0UNV76NV/4SpuBtHD02zVJwEmuoA5LmZSvDmdp0CIQkECJG
 EOwwOXrjDT8+nlK5X8P3F7R8vh7R3Atj5Mn1nc5A=
Received: by mx.zohomail.com with SMTPS id 1739120356466466.17990285617464;
 Sun, 9 Feb 2025 08:59:16 -0800 (PST)
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
Subject: [PATCH v8 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
Date: Sun,  9 Feb 2025 19:56:49 +0300
Message-ID: <20250209165649.544005-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209165649.544005-1-dmitry.osipenko@collabora.com>
References: <20250209165649.544005-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Alex Bennée <alex.bennee@linaro.org>

This attempts to tidy up the VirtIO GPU documentation to make the list
of requirements clearer. There are still a lot of moving parts and the
distros have some catching up to do before this is all handled
automatically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
[dmitry.osipenko@collabora.com: Extended and corrected doc]
---
 docs/system/devices/virtio-gpu.rst | 106 ++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
index ea3eb052df3c..664fc4000fa9 100644
--- a/docs/system/devices/virtio-gpu.rst
+++ b/docs/system/devices/virtio-gpu.rst
@@ -5,14 +5,34 @@ virtio-gpu
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
-The virtio-gpu device paravirtualizes the GPU and display controller.
+The virtio-gpu device provides a GPU and display controller
+paravirtualized using VirtIO. It supports a number of different modes
+from simple 2D displays to fully accelerated 3D graphics.
+
+virtio-gpu requirements
+-----------------------
 
 Linux kernel support
---------------------
+^^^^^^^^^^^^^^^^^^^^
 
 virtio-gpu requires a guest Linux kernel built with the
 ``CONFIG_DRM_VIRTIO_GPU`` option.
 
+Host Linux kernel requirements vary depending on a used virtio-gpu
+capabilities. See further sections for a detailed descriptions.
+
+3D acceleration
+^^^^^^^^^^^^^^^
+
+3D acceleration of a virtualized GPU is still an evolving field.
+Depending on the 3D mode you are running you may need to override
+distribution supplied libraries with more recent versions or enable
+build options. There are a number of requirements the host must meet
+to be able to be able to support guests. QEMU must be able to access the
+host's GPU and for the best performance be able to reliably share GPU
+memory with the guest. Details of 3D acceleration requirements are
+described in a further sections.
+
 QEMU virtio-gpu variants
 ------------------------
 
@@ -65,8 +85,14 @@ intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
 representation back to OpenGL API calls.
 
+By default OpenGL version on guest is limited to 4.3. In order to enable
+OpenGL 4.6 support, virtio-gpu host blobs feature (``hostmem`` and ``blob``
+fields) should be enabled.  The ``hostmem`` field specifies the size of
+virtio-gpu host memory window. This is typically between 256M and 8G.
+
 .. parsed-literal::
     -device virtio-gpu-gl
+    -device virtio-gpu-gl,hostmem=8G,blob=true
 
 .. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
@@ -94,6 +120,62 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
 
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel
+    - virglrenderer build flags
+  * - OpenGL pass-through
+    - Any Linux version compatible with QEMU if not using host blobs feature,
+      Linux 6.13+ otherwise
+    - N/A
+  * - Vulkan pass-through
+    - Linux 6.13+
+    - -Dvenus=true -Drender-server=true
+  * - AMDGPU DRM native context
+    - Linux 6.13+
+    - -Ddrm-renderers=amdgpu-experimental
+  * - Freedreno DRM native context
+    - Linux 6.4+
+    - -Ddrm-renderers=msm
+  * - Intel i915 DRM native context
+    - Linux 6.13+
+    - -Ddrm-renderers=i915-experimental `mr1384`_
+  * - Asahi DRM native context
+    - Downstream version of Asahi Linux kernel
+    - -Ddrm-renderers=asahi-experimental `mr1274`_
+
+.. _mr1384: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
+.. _mr1274: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1274
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Mesa Version
+    - Mesa build flags
+  * - OpenGL pass-through
+    - 16.0.0+
+    - -Dgallium-drivers=virgl
+  * - Vulkan pass-through
+    - 24.2.0+
+    - -Dvulkan-drivers=virtio
+  * - AMDGPU DRM native context
+    - 25.0.0+
+    - -Dgallium-drivers=radeonsi -Dvulkan-drivers=amd -Damdgpu-virtio=true
+  * - Freedreno DRM native context
+    - 23.1.0+
+    - -Dgallium-drivers=freedreno -Dvulkan-drivers=freedreno
+  * - Intel i915 DRM native context
+    - `mr29870`_
+    - -Dgallium-drivers=iris -Dvulkan-drivers=intel -Dintel-virtio-experimental=true
+  * - Asahi DRM native context
+    - 24.2.0+
+    - -Dgallium-drivers=asahi -Dvulkan-drivers=asahi
+
+.. _mr29870: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
+
 virtio-gpu rutabaga
 -------------------
 
@@ -133,3 +215,23 @@ Surfaceless is the default if ``wsi`` is not specified.
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
 .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
+
+.. list-table:: Linux Host Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Kernel
+    - Rutabaga build flags
+  * - Vulkan+Wayland pass-through
+    - Linux 6.13+
+    - Follow `gfxstream-enabled rutabaga`_ build instructions
+
+.. list-table:: Linux Guest Requirements
+  :header-rows: 1
+
+  * - Capability
+    - Mesa Version
+    - Mesa build flags
+  * - Vulkan pass-through
+    - 24.3.0+
+    - -Dvulkan-drivers=gfxstream
-- 
2.47.1


