Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B270787C0B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZJwp-0007Fb-Nt; Thu, 24 Aug 2023 19:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwo-0007FA-FU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:41:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwl-0005C9-2K
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:41:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a1af910e0so333597b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920461; x=1693525261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ho9HeZI3luA1ufSSwN32tBR3Ue4Up97l+h1mrjp+sWA=;
 b=nS7L9yJtuhdIKqO5GjcfHKM9olUDEPbNTw6LEsnX6Cc4uaHJJeWhS8gdbyRIeXsyOa
 dycCZBVKI54Gl8DEBeb548hcjR0FoTdoUaf2jYCuprbJ1liG9N9qollpGVLrqdVvTY9g
 UgqEb+BJ67gVnRH+7sdWE50j+Ranmzyl/uTLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920461; x=1693525261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ho9HeZI3luA1ufSSwN32tBR3Ue4Up97l+h1mrjp+sWA=;
 b=MJcn8WZ3nb0M1cwuxmfqUMTA9s9L9XrBNJOiMfQzjAwzQF0LlCzWfA1sWo31Mf0qoo
 X6XN8aDqDUzUPtTzShVwmVCkN++eRVAH9/2ggWNjHT77dj2eCQRocEjCfdIVbe6j5aeq
 zM3QYK2+RDNjk/2pNwXDCJHw9SWbIHh7H18jkyzslVo7M11IbhCln3IsKXebQ5XbyiJ4
 m1LUXZgKsYePHllIzjURtzCRS9bB0mJoRO9a73FUrdgG9El4Ja6065UGEf+VyQ2MLrX4
 vHnw1O+uyE76FTZqIykb6YJvZj6uyFhIpjjZ3OJNtJYbT1OuSg+tgM1Iz0TetzN8lo+q
 qEXw==
X-Gm-Message-State: AOJu0YxGOJMZi2QdrLZjhR3IiagaFcTKdzg+qE1SgueC9eOisdq3Ms9W
 Czn0cHitw4/xYf1CPaKHEHhoc5tD47Eespidr2s=
X-Google-Smtp-Source: AGHT+IHVExZwTt97HEyeDZDFQroxE5a1gV1E8n53N2QOAD0lu/ipfXuAHscwnvbRP5FSzrXsycEc/A==
X-Received: by 2002:a05:6a00:22c1:b0:686:f84d:a4ec with SMTP id
 f1-20020a056a0022c100b00686f84da4ecmr16537080pfj.27.1692920461162; 
 Thu, 24 Aug 2023 16:41:01 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:1fa0:9cd:3c53:231b])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b0066a31111cc5sm274798pfb.152.2023.08.24.16.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 16:41:00 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v12 9/9] docs/system: add basic virtio-gpu documentation
Date: Thu, 24 Aug 2023 16:40:46 -0700
Message-Id: <20230824234046.499-10-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230824234046.499-1-gurchetansingh@chromium.org>
References: <20230824234046.499-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42d.google.com
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
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

---
v2: - Incorporated suggestions by Akihiko Odaki
    - Listed the currently supported capset_names (Bernard)

v3: - Incorporated suggestions by Akihiko Odaki and Alyssa Ross

v4: - Incorporated suggestions by Akihiko Odaki

v5: - Removed pci suffix from examples
    - Verified that -device virtio-gpu-rutabaga works.  Strangely
      enough, I don't remember changing anything, and I remember
      it not working.  I did rebase to top of tree though.
    - Fixed meson examples in crosvm docs

v8: - Remove different links for "rutabaga_gfx" and
      "gfxstream-enabled rutabaga" (Akihiko)

v11: - Use GPL-2.0-or-later license (Phillippe)

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
index 0000000000..21465e4ce2
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
+At least one capset (see colon separated ``capset_names`` below) must be
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
+    -device virtio-gpu-rutabaga,capset_names=gfxstream-vulkan:cross-domain,
+       hostmem=8G,wayland_socket_path=/tmp/nonstandard/mock_wayland.sock,
+       wsi=headless
+
+.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
+.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


