Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD67B72AE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmGi-00088z-Hp; Tue, 03 Oct 2023 16:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGd-00084g-CW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGa-0004as-It
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c62d61dc96so10193775ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696365915; x=1696970715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPRoe1Z+pnUafK0TuSSHgeUBCFeZKQNZ2M7A6f2nDVk=;
 b=konJ7gwv6jMBQ/lvGZCDbd679y6519yNpkSEpMfRfne+qEto7MxgCkvY2tTeYseeTp
 S20rJN0GkfLJVXClUOT/w8+ZuNnlhrqv2mSPh5Nkh8uS2vJc2MLR++IKK3YxEaGfnxuE
 lr1WJnuq+ZRmJ+uzQUQ8ew+erhzAsG4CwvHog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365915; x=1696970715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPRoe1Z+pnUafK0TuSSHgeUBCFeZKQNZ2M7A6f2nDVk=;
 b=wGGfCErSFdOQQuLLEfTSnHrJkLBGkLcvQAbQqcDDG4fxvnBixsJ8rRAd0xleDltZHy
 HhdBGCwOe3IxQYuskYmb7iWkPsP8z761t/DQLBx8VRcnxEO4yufA7v1dy5gAOPlJF66e
 y5Wb24JVfL4l8ZqMlRdySIZRFrVQ8kEn2hY3t0cqF3CIxYgyj05XaU3Ec4sThkIRdaoX
 fJgT+s+JZ2LBRENV25eGA6jbwEdpBZN4zEQx4Zmg+j0fkgwPxuj3GRaf4ovZ2ZM7YmS1
 kgD4P9MppheOkmQGOMdfpe/54bv20MkseHIWv6W4yLZKQZl//lBaaDuWUMsuL/gNgBIy
 kBsQ==
X-Gm-Message-State: AOJu0Yx1lWOtzA0OY6tgKMBvcQwTt8Mw+PFXfWuRa1rw3Lnl1KHyBnX1
 F738EnIeEhTEF8CC010ofpt+2rDZWEmzQGYUoBs=
X-Google-Smtp-Source: AGHT+IGHN2dJ+EfcZ9DTqCzGSYKnxl3bW28PBLl6ImEdJn5//nvSg5ArfvhJnDIDN1CYmTZv7ZEXRw==
X-Received: by 2002:a17:90a:d815:b0:277:1070:74a2 with SMTP id
 a21-20020a17090ad81500b00277107074a2mr459518pjv.23.1696365914806; 
 Tue, 03 Oct 2023 13:45:14 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9076:49ec:5f9a:e5ec])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b002777b8fc74bsm3739pjy.21.2023.10.03.13.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:45:14 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v15 9/9] docs/system: add basic virtio-gpu documentation
Date: Tue,  3 Oct 2023 13:45:00 -0700
Message-Id: <20231003204500.518-10-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231003204500.518-1-gurchetansingh@chromium.org>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This adds basic documentation for virtio-gpu.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/system/device-emulation.rst   |   1 +
 docs/system/devices/virtio-gpu.rst | 112 +++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
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
index 0000000000..cb73dd7998
--- /dev/null
+++ b/docs/system/devices/virtio-gpu.rst
@@ -0,0 +1,112 @@
+..
+   SPDX-License-Identifier: GPL-2.0-or-later
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
+    -device virtio-gpu
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
+    -device virtio-gpu-gl
+
+.. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
+.. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
+
+virtio-gpu rutabaga
+-------------------
+
+virtio-gpu can also leverage rutabaga_gfx to provide `gfxstream`_
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
+At least one virtio-gpu capability set ("capset") must be specified when
+starting the device.  The currently capsets supported are ``gfxstream-vulkan``
+and ``cross-domain`` for Linux guests. For Android guests, the experimental
+``x-gfxstream-gles`` and ``x-gfxstream-composer`` capsets are also supported.
+
+The device will try to auto-detect the wayland socket path if the
+``cross-domain`` capset name is set.  The user may optionally specify
+``wayland-socket-path`` for non-standard paths.
+
+The ``wsi`` option can be set to ``surfaceless`` or ``headless``.
+Surfaceless doesn't create a native window surface, but does copy from the
+render target to the Pixman buffer if a virtio-gpu 2D hypercall is issued.
+Headless is like surfaceless, but doesn't copy to the Pixman buffer.
+Surfaceless is the default if ``wsi`` is not specified.
+
+.. parsed-literal::
+    -device virtio-gpu-rutabaga,gfxstream-vulkan=on,cross-domain=on,
+       hostmem=8G,wayland-socket-path=/tmp/nonstandard/mock_wayland.sock,
+       wsi=headless
+
+.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
+.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
-- 
2.42.0.582.g8ccd20d70d-goog


