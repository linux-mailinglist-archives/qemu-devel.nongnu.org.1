Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652219AF5DB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Oct 2024 01:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t47MK-0008Gd-Tn; Thu, 24 Oct 2024 19:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47MJ-0008G4-Kn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:15 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t47MH-0002rN-7t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 19:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729812898; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dHbp8wg2AcrFDP2wl1GT+iuRitSnhEoof6hZRrGzlMr9b+eScOsTwYYN/AEDz2vPBN5i1B+UtOgjO4D0XWKtmCBVZ0quumZyfTrjsNopryJg8HzMDr/IKBEX6OdnZ6JqZH+1UGr2sGdHt3olVXEQY9JTP5VXNgtirM/cG2leDyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729812898;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E2b8CbCWKUrYfXCQ0gikGV2oBssBosdH+21z5JvsTvE=; 
 b=kaYlaLlM3m1T4sG8wOduaIF0Qmz8o3sl2jbZGEQDQYKtkuz4Iw0NpoZlEPr1oznTlYgOTfA3V2A5wB23dFIkGAnJgvcw3QZKDP9BGieAcYPli3DFHqhoRACW+6WfFu3YZwt3XrZ7v8a2GH3tU4y/3q4vd7iNN9Uww7B6Nfz/YHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729812898; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=E2b8CbCWKUrYfXCQ0gikGV2oBssBosdH+21z5JvsTvE=;
 b=LABx9T6o+9luiBDzpeOogqVAfIyYSLoSD7MCpIS+M11Rk0FuTTrYfDg16SPLUk4e
 A0/PkMKgy/APxTeOQDdrTTExk2byj+vcRy/9+wOWQafzgYC+xFjwq0XXU3bVjt0QN7O
 MFh3c81KWitZxJ8xCoEYwuwHR8P93mruh57G7WoA=
Received: by mx.zohomail.com with SMTPS id 1729812896360132.5397881193137;
 Thu, 24 Oct 2024 16:34:56 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Support virtio-gpu DRM native context
Date: Fri, 25 Oct 2024 02:33:48 +0300
Message-ID: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
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

This patchset adds DRM native context support to VirtIO-GPU on Qemu.
It's based on the pending Venus v18 patches [1] that bring host blobs
support to virtio-gpu-gl device.

Based-on: 20241024210311.118220-1-dmitry.osipenko@collabora.com

[1] https://lore.kernel.org/qemu-devel/20241024210311.118220-1-dmitry.osipenko@collabora.com/

Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
DRM native context [2] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

[2] https://www.youtube.com/watch?v=9sFP_yddLLQ

Today there are four known DRM native context drivers existing in a wild:

  - Freedreno (Qualcomm SoC GPUs), completely upstreamed
  - AMDGPU, mostly merged into upstreams
  - Intel (i915), merge requests are opened
  - Asahi (Apple SoC GPUs), WIP status


# How to try out DRM context:

1. Like Venus and Virgl context, DRM context requires applying WIP
KVM patches [3] to host kernel, otherwise mapping of GPU memory blobs
will likely fail.

[3] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com/

2. Use latest libvirglrenderer from upstream git/main for Freedreno
and AMDGPU native contexts. For Intel use patches [4].

[4] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384

3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
Mesa patches [5], for Intel [6].

[5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
[6] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870

4. On guest, use latest Linux kernel v6.6+. Apply patch [7] if you're
   running Xorg in guest.

[7] https://lore.kernel.org/dri-devel/20241020224725.179937-1-dmitry.osipenko@collabora.com/

Example Qemu cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm=on \
      -machine q35,accel=kvm,memory-backend=mem1 \
      -object memory-backend-memfd,id=mem1,size=8G -m 8G


# Note about known performance problem in Qemu:

DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in Qemu. Exact reason is unknown. Mappings work
fast on Crosvm For DRM contexts this problem is more visible than for
Venus/Virgl.

Changelog:

v3: - Improved EGL presence-check code on X11 systems for the SDL2
      hint that prefers EGL over GLX by using better ifdefs and checking
      Xlib presence at a build time to avoid build failure if lib SDL2
      and system are configured with a disabled X11 support. Also added
      clarifying comment telling that X11 hint doesn't affect Wayland
      systems. Suggested by Akihiko Odaki.

    - Corrected strerror(err) that used negative error where it should
      be positive and vice versa that was caught by Akihiko Odaki. Added
      clarifying comment for the case where we get positive error code
      from virglrenderer that differs from other virglrenderer API functions.

    - Improved QSLIST usage by dropping mutex protecting the async fence
      list and using atomic variant of QSLIST helpers instead. Switched away
      from using FOREACH helper to improve readability of the code, showing
      that we don't precess list in unoptimal way. Like was suggested by
      Akihiko Odaki.

    - Updated patchset base to Venus v18.

v2: - Updated SDL2-dmabuf patch by making use of error_report() and
      checking presense of X11+EGL in the system before making SDL2
      to prefer EGL backend over GLX, suggested by Akihiko Odaki.

    - Improved SDL2's dmabuf-presence check that wasn't done properly
      in v1, where EGL was set up only after first console was fully
      inited, and thus, SDL's display .has_dmabuf callback didn't work
      for the first console. Now dmabuf support status is pre-checked
      before console is registered.

    - Updated commit description of the patch that fixes SDL2's context
      switching logic with a more detailed explanation of the problem.
      Suggested by Akihiko Odaki.

    - Corrected rebase typo in the async-fencing patch and switched
      async-fencing to use a sigle-linked list instead of the double,
      as was suggested by Akihiko Odaki.

    - Replaced "=true" with "=on" in the DRM native context documentation
      example and made virtio_gpu_virgl_init() to fail with a error message
      if DRM context can't be initialized instead of giving a warning
      message, as was suggested by Akihiko Odaki.

    - Added patchew's dependecy tag to the cover letter as was suggested by
      Akihiko Odaki.

Dmitry Osipenko (5):
  ui/sdl2: Restore original context after new context creation
  linux-headers: Update to Linux v6.12-rc1
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio-gpu.rst            |  11 +
 hw/display/virtio-gpu-gl.c                    |   5 +
 hw/display/virtio-gpu-virgl.c                 | 154 ++++++++++--
 hw/display/virtio-gpu.c                       |  15 ++
 include/hw/virtio/virtio-gpu.h                |  16 ++
 include/standard-headers/drm/drm_fourcc.h     |  43 ++++
 include/standard-headers/linux/const.h        |  17 ++
 include/standard-headers/linux/ethtool.h      | 226 ++++++++++++++++++
 include/standard-headers/linux/fuse.h         |  22 +-
 .../linux/input-event-codes.h                 |   2 +
 include/standard-headers/linux/pci_regs.h     |  41 +++-
 .../standard-headers/linux/virtio_balloon.h   |  16 +-
 include/standard-headers/linux/virtio_gpu.h   |   1 +
 include/ui/sdl2.h                             |   7 +
 linux-headers/asm-arm64/mman.h                |   9 +
 linux-headers/asm-arm64/unistd.h              |  25 +-
 linux-headers/asm-generic/unistd.h            |   6 +-
 linux-headers/asm-loongarch/kvm.h             |  24 ++
 linux-headers/asm-loongarch/unistd.h          |   4 +-
 linux-headers/asm-riscv/kvm.h                 |   7 +
 linux-headers/asm-riscv/unistd.h              |  41 +---
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   3 +
 linux-headers/linux/const.h                   |  17 ++
 linux-headers/linux/iommufd.h                 | 143 +++++++++--
 linux-headers/linux/kvm.h                     |  23 +-
 linux-headers/linux/mman.h                    |   1 +
 linux-headers/linux/psp-sev.h                 |  28 +++
 meson.build                                   |   4 +
 ui/sdl2-gl.c                                  |  66 +++++
 ui/sdl2.c                                     |  40 ++++
 33 files changed, 914 insertions(+), 107 deletions(-)

-- 
2.47.0


