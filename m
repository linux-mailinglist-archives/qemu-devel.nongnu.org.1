Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEE76A628
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe1F-0001cm-Ud; Mon, 31 Jul 2023 21:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe1E-0001cd-Lw
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:48 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe1C-0003K5-QR
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9d68a7abaso3922132a34.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852665; x=1691457465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWoWjO74TGFbJFWuRN7PtgQZicNmirMY+BnV95/WW3M=;
 b=mN81Gr15F67YHPY7+VbotpoeqhbB67Ihwow7T4Rd0A0UDOLcTyEl8Ufx6zH8NZbUbA
 qWho7WHpVzo2Il/dIjAZqddvFT3NM/oqnKJamhvW0Rk9clljoCz1F0D1cMqx0YNHJQjY
 VGxyOctxXBTEPEYuS1tY89BvfwSoYd0uNMgO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852665; x=1691457465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWoWjO74TGFbJFWuRN7PtgQZicNmirMY+BnV95/WW3M=;
 b=CH7pnc9UQq+peeTmuU3rzPJ92FVtASwohFZKOfBKrGvTUHKbqbGV53LVElA8VaDqUg
 6Ci2g5g3hclJvLAQHEtAHmX4ek1OPIQOegqm2+DDMdc71UGabD1hSpXpWpW20d6D/jAK
 pF3pcpqpLTWO8EtXPn4ZASd09bk6uRrogI6oPzlSszHKP+IXMRQcB6tpGtZUNf5g/eX+
 y5106OUaW6DLErEwvKQB1vlABEat5ZAHI6hzq38xLbvvC2e1G34T3rtMqAvdptjMkF1A
 4dWbiB6WECLpQT0g/e3q/xbGWIk1ZdHyqDiAR+95C91x/01gjbAvdOApl5j+k+A9hdWN
 pjFg==
X-Gm-Message-State: ABy/qLbDHtlY14Jl2mBiwDOf/ex+Hmh6/DdMnDCskBzQjbnh/aLdRSHp
 g8g5Oec2WgimWeP4oE0O6/5Mlkbxe0cvwJBIA+s=
X-Google-Smtp-Source: APBJJlHYd8OQhr9yqOZJYLh4BH/NZpt4gf7vSSuieXpLcR9IhfeW1ztdQZ+8EBQnvylw60aMmM5F9g==
X-Received: by 2002:a05:6808:4044:b0:3a4:35bb:edae with SMTP id
 cz4-20020a056808404400b003a435bbedaemr10196811oib.29.1690852664925; 
 Mon, 31 Jul 2023 18:17:44 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:43 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 9/9] docs/system: add basic virtio-gpu documentation
Date: Mon, 31 Jul 2023 18:17:23 -0700
Message-Id: <20230801011723.627-10-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ot1-x329.google.com
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
v2: - Incorporated suggestions by Akihiko Odaki
    - Listed the currently supported capset_names (Bernard)

 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-gpu.rst | 98 ++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
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
index 0000000000..f359584033
--- /dev/null
+++ b/docs/system/devices/virtio-gpu.rst
@@ -0,0 +1,98 @@
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
+QEMU provides a 2D virtio-gpu backend, and two accelerated backends:
+virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga' device
+label).  There is a vhost-user backend that runs the graphics stack in
+a separate process for improved isolation.
+
+Theses backends can be further classified into VGA and non-VGA variants.
+The VGA ones are prefixed with virtio-vga or vhost-user-vga while the
+non-VGA ones are prefixed with virtio-gpu or vhost-user-gpu.
+
+The VGA ones always use PCI interface, but for the non-VGA ones, you can
+further pick simple MMIO or PCI. For MMIO, you can suffix the device
+name with -device though vhost-user-gpu apparently does not support
+MMIO. For PCI, you can suffix it with -pci. Without these suffixes, the
+platform default will be chosen.  The syntax of  available combinations
+is listed below.
+
+ * ``virtio-vga[-BACKEND]``
+ * ``virtio-gpu[-BACKEND][-INTERFACE]``
+ * ``vhost-user-vga``
+ * ``vhost-user-pci``
+
+This document uses the PCI variant in examples.
+
+virtio-gpu 2d
+-------------
+
+The default 2D backend only performs 2D operations. The guest needs to
+employ a software renderer for 3D graphics.
+
+Typically, the software renderer is provided by `Mesa`_ or `SwiftShader`_.
+Mesa's implementations (LLVMpipe, Lavapipe and virgl below) work out of box
+on typical modern Linux distributions.
+
+.. parsed-literal::
+    -device virtio-gpu-pci
+
+.. _Mesa: https://www.mesa3d.org/
+.. _SwiftShader: https://github.com/google/swiftshader
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
+The crosvm book provides directions on how to build a `gfxstream-enabled
+rutabaga`_ and launch a `guest Wayland compositor`_.
+
+This device does require host blob support (``hostmem`` field below), but not
+all capsets (``capset_names`` below) have to enabled when starting the device.
+
+The currently supported ``capset_names`` are ``gfxstream-vulkan`` and
+``cross-domain`` on Linux guests.  For Android guests, ``gfxstream-gles`` is
+also supported.
+
+.. parsed-literal::
+    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,\\
+      hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
+
+.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
+.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
+.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _guest Wayland compositor: https://crosvm.dev/book/devices/wayland.html
-- 
2.41.0.585.gd2178a4bd4-goog


