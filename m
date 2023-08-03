Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACF76F65B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 01:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRiA7-0007KF-B4; Thu, 03 Aug 2023 19:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRiA3-0007JC-RW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:19 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRiA1-0003db-Jw
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:19 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-56d455462c2so347196eaf.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691106916; x=1691711716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/IApk4Xq1HUaKqawHvCLbalHnY9sH9RPK23qe8q7i8=;
 b=d1m9rfQQxHS024ga7oFZYJeBKub9w39wacRjS6z9dlsnqVr44gLS6b0KtHVg9lszvI
 9c8T+jMXuBVEpIrW6Pg0Ii0xoL/LoRaw51ig2Zf9kpUVHPaAc33lJJ/SSuwrNZmTq9/5
 GorVSKQY2C1t2MKSU9aS/+QrIrsL+yj6iigfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691106916; x=1691711716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/IApk4Xq1HUaKqawHvCLbalHnY9sH9RPK23qe8q7i8=;
 b=Vr7AkbUUiOMGbDDFJsoQcSXKyE33WoT1ria/hPwz5vfqaIVhZcQk/zuF4jM0AZp4t2
 QVR171KK4bkkkKLQlNUUJxUDesmSxZ/y1YmC/BykLGx6AaSOO7O2PWsjMa49G5yqTSRK
 VwBhzmlmQsK0XISD8H1UEyCBU1S4XrXMCvCO2QFbWw8Frg/p+B1zgWp4PQO8ySOHiM7M
 rA1MsMoIiL4PBrolX/WLAGesLx/XuRMnWJuLOi8UI/G6M015ZIPUdHHmXKlVbkvrTx1J
 b+o3YHV9Vwa+s5JWpvxvZZXJR3OtQolmjrZYXBcwmC8QKEqkFqi1GevlmJm2ezVOiiF9
 3MMg==
X-Gm-Message-State: AOJu0Yx5zKLo1DnQYv23VEJx2zkE5uulaUNAP3P6WraPNVz8HbSAYweK
 LKfTTL3+WAXa5Xd8kS/sX1w+1oRu9C8he/M0rqo=
X-Google-Smtp-Source: AGHT+IFcIwJWyGd9U9IpdAjW2fBQTkA5RMUOczkc7yhoaQYlquxeXw8g3Ad3Zl7etO5rTVsPr5fQIg==
X-Received: by 2002:a05:6358:419b:b0:134:ce45:b782 with SMTP id
 w27-20020a056358419b00b00134ce45b782mr185080rwc.21.1691106915873; 
 Thu, 03 Aug 2023 16:55:15 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9efb:b80c:dd5c:56c9])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a63a708000000b0055387ffef10sm364329pgf.24.2023.08.03.16.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 16:55:15 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v3 9/9] docs/system: add basic virtio-gpu documentation
Date: Thu,  3 Aug 2023 16:55:02 -0700
Message-Id: <20230803235502.373-10-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803235502.373-1-gurchetansingh@google.com>
References: <20230803235502.373-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oo1-xc2c.google.com
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

From: Gurchetan Singh <gurchetansingh@chromium.org>

This adds basic documentation for virtio-gpu.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>

---
v2: - Incorporated suggestions by Akihiko Odaki
    - Listed the currently supported capset_names (Bernard)

v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross

 docs/system/device-emulation.rst   |   1 +
 docs/system/devices/virtio-gpu.rst | 115 +++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
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
index 0000000000..2b8ecdac32
--- /dev/null
+++ b/docs/system/devices/virtio-gpu.rst
@@ -0,0 +1,115 @@
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
+QEMU virtio-gpu device variants come in the following form:
+
+ * ``virtio-vga[-BACKEND]``
+ * ``virtio-gpu[-BACKEND][-INTERFACE]``
+ * ``vhost-user-vga``
+ * ``vhost-user-pci``
+
+**Backends:** QEMU provides a 2D virtio-gpu backend, and two accelerated
+backends: virglrenderer ('gl' device label) and rutabaga_gfx ('rutabaga'
+device label).  There is a vhost-user backend that runs the graphics stack
+in a separate process for improved isolation.
+
+**Interfaces:** QEMU further categorizes virtio-gpu device variants based
+on the interface exposed to the guest. The interfaces can be classified
+into VGA and non-VGA variants. The VGA ones are prefixed with virtio-vga
+or vhost-user-vga while the non-VGA ones are prefixed with virtio-gpu or
+vhost-user-gpu.
+
+The VGA ones always use the PCI interface, but for the non-VGA ones, the
+user can further pick between MMIO or PCI. For MMIO, the user can suffix
+the device name with -device, though vhost-user-gpu does not support MMIO.
+For PCI, the user can suffix it with -pci. Without these suffixes, the
+platform default will be chosen.
+
+This document uses the PCI interface in examples.
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
+When using virgl accelerated graphics mode in the guest, OpenGL API calls
+are translated into an intermediate representation (see `Gallium3D`_). The
+intermediate representation is communicated to the host and the
+`virglrenderer`_ library on the host translates the intermediate
+representation back to OpenGL API calls.
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
+virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_
+rendering and `Wayland display passthrough`_.  With the gfxstream rendering
+mode, GLES and Vulkan calls are forwarded to the host with minimal
+modification.
+
+The crosvm book provides directions on how to build a `gfxstream-enabled
+rutabaga`_ and launch a `guest Wayland proxy`_.
+
+This device does require host blob support (``hostmem`` field below). The
+``hostmem`` field specifies the size of virtio-gpu host memory window.
+This is typically between 256M and 8G.
+
+Atleast one capset (see colon separated ``capset_names`` below) must be
+specified when starting the device.  The currently supported
+``capset_names`` are ``gfxstream-vulkan`` and ``cross-domain`` on Linux
+guests. For Android guests, ``gfxstream-gles`` is also supported.
+
+The device will try to auto-detect the wayland socket path if the
+``cross-domain`` capset name is set.  The user may optionally specify
+``wayland_socket_path`` for non-standard paths.
+
+The ``wsi`` option can be set to ``surfaceless`` or ``headless``.
+Surfaceless doesn't create a native window surface, but does copy from the
+render target to the Pixman buffer if a virtio-gpu 2D hypercall is issued.
+Headless is like surfaceless, but doesn't copy to the Pixman buffer.
+Surfaceless is the default if ``wsi`` is not specified.
+
+.. parsed-literal::
+    -device virtio-gpu-rutabaga-pci,capset_names=gfxstream-vulkan:cross-domain,
+       hostmem=8G,wayland_socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY",
+       wsi=headless
+
+.. _rutabaga_gfx: https://github.com/google/crosvm/blob/main/rutabaga_gfx/ffi/src/include/rutabaga_gfx_ffi.h
+.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
+.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
-- 
2.41.0.585.gd2178a4bd4-goog


