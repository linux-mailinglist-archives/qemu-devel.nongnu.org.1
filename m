Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC274E491
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Yu-00039F-Qs; Mon, 10 Jul 2023 22:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Ys-00038L-Im
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:10 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yq-0005Qn-Ri
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:10 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3942c6584f0so3690907b6e.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044227; x=1691636227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjLMhETVE4SGvOiHi76JURucMgHFf5TrgNuBMjUglz8=;
 b=Naf9kBZddyj+tNOtjIRWkN+5hfa8G+OiGdD7lK2dpxEn9cZFvOqbRHnyMRwWWAqwHt
 L9g+AuG3oTWpoRJW6lT74IY9OIrU6v2aJFE4kJVBlJlYAAwdjSGEiw4FQnnM6bj+36y7
 jbmClseSfq2ybyM/wBe5dWi0rRZlMW47O93+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044227; x=1691636227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjLMhETVE4SGvOiHi76JURucMgHFf5TrgNuBMjUglz8=;
 b=Q74mUxr6GScn4MLCIMYguA2ziDWBKXHoEluVEDqM/kSii6CWKz/VT5gizgTuOSY+Ul
 Cuw+0SdUYuGJvPecN/R5QlWYTjgKErJZhJdv06kMvuPNx17AzK3zvpbCinHGePCpyTMD
 fQqRR32z1ZuxaYe7CSPA2jUbe/F1l2DzMzOqsHSbiAM2klL78zqqvZSaNnf7+B6bCohM
 GQouiZhN/ZILuASKs/8XC06NONZ0T64KibXvHQwF7ygQfhRe2B5M5SwNFoks2dQTrjB8
 9b0mnHowBNuekv6pmatOJz7rQ6NNSRFzPAI8j5GLDC0q5f0XC66Ln4PTgu/DinASHp8m
 Vkog==
X-Gm-Message-State: ABy/qLZErjzf+HSc9VhpXcA/HlXX3tqQx/OF4ySBcie19GnqWkE/UBvN
 pcG4S+NL4r8RRZJuYPDwl47+7ZIXGw+mLJtziz4=
X-Google-Smtp-Source: APBJJlHkWg8PaiqdELGApmbe/6taRr3u2TKdoL3WtthQTd7j6oiq107a2Cy3aTJD25WDWI8T6MfEDQ==
X-Received: by 2002:a05:6808:13c5:b0:3a3:e6d4:69d6 with SMTP id
 d5-20020a05680813c500b003a3e6d469d6mr13548331oiw.7.1689044227496; 
 Mon, 10 Jul 2023 19:57:07 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:57:07 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 9/9] docs/system: add basic virtio-gpu documentation
Date: Mon, 10 Jul 2023 19:56:49 -0700
Message-Id: <20230711025649.708-10-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This adds basic documentation for virtio-gpu.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-gpu.rst | 80 ++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 docs/system/devices/virtio-gpu.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 4491c4cbf7..1167f3a9f2 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -91,6 +91,7 @@ Emulated Devices
    devices/nvme.rst
    devices/usb.rst
    devices/vhost-user.rst
+   devices/virtio-gpu.rst
    devices/virtio-pmem.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/virtio-gpu.rst
new file mode 100644
index 0000000000..2426039540
--- /dev/null
+++ b/docs/system/devices/virtio-gpu.rst
@@ -0,0 +1,80 @@
+..
+   SPDX-License-Identifier: GPL-2.0
+
+virtio-gpu
+==========
+
+This document explains the setup and usage of the virtio-gpu device.
+The virtio-gpu device paravirtualizes the GPU and display controller.
+
+Linux kernel support
+--------------------
+
+virtio-gpu requires a guest Linux kernel built with the
+``CONFIG_DRM_VIRTIO_GPU`` option.
+
+QEMU virtio-gpu variants
+------------------------
+
+There are many virtio-gpu device variants, listed below:
+
+ * ``virtio-vga``
+ * ``virtio-gpu-pci``
+ * ``virtio-vga-gl``
+ * ``virtio-gpu-gl-pci``
+ * ``virtio-vga-rutabaga``
+ * ``virtio-gpu-rutabaga-pci``
+ * ``vhost-user-vga``
+ * ``vhost-user-gl-pci``
+
+QEMU provides a 2D virtio-gpu backend, and two accelerated backends:
+virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga' device
+label).  There is also a vhost-user backend that runs the 2D device
+in a separate process.  Each device type as VGA or PCI variant.  This
+document uses the PCI variant in examples.
+
+virtio-gpu 2d
+-------------
+
+The default 2D mode uses a guest software renderer (llvmpipe, lavapipe,
+Swiftshader) to provide the OpenGL/Vulkan implementations.
+
+.. parsed-literal::
+    -device virtio-gpu-pci
+
+virtio-gpu virglrenderer
+------------------------
+
+When using virgl accelerated graphics mode, OpenGL API calls are translated
+into an intermediate representation (see `Gallium3D`_). The intermediate
+representation is communicated to the host and the `virglrenderer`_ library
+on the host translates the intermediate representation back to OpenGL API
+calls.
+
+.. parsed-literal::
+    -device virtio-gpu-gl-pci
+
+.. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
+.. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
+
+virtio-gpu rutabaga
+-------------------
+
+virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_ rendering
+and `Wayland display passthrough`_.  With the gfxstream rendering mode, GLES
+and Vulkan calls are forwarded directly to the host with minimal modification.
+
+Please refer the `crosvm book`_ on how to setup the guest for Wayland
+passthrough (QEMU uses the same implementation).
+
+This device does require host blob support (``hostmem`` field below), but not
+all capsets (``capset_names`` below) have to enabled when starting the device.
+
+.. parsed-literal::
+    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,\\
+      hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
+
+.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
+.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
+.. _crosvm book: https://crosvm.dev/book/devices/wayland.html
-- 
2.41.0.255.g8b1d071c50-goog


