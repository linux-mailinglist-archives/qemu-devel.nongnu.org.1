Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C228A250D0
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 00:28:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tejMT-0002Zf-TQ; Sun, 02 Feb 2025 18:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejMR-0002ZH-2o
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:26:43 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejMO-0003UA-Ls
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:26:42 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738538784; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nzBx2ZaqE2R7zqzSMve5U7oDHqfWhGpxAcb2szp7IF8AYbcF2lj0PwVVhVWAkBHOvCLXk3X7vsFGoisZrcIqPtc6xpCXPfg/5pR2QewCTosWkA3Te9CzkiUUouItHgsrVL/Kk8T8gNHtnZg7/xOxspsMGAIkC66KEfWorPx04H4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738538784;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wZVVhBceus/ZvhLXav64s6GossVdZ9tHNxOQVsXSJbU=; 
 b=S6feHH73LN6WTtaN7R0e8K3iG2Yl0yW66YjuQYVOxM+gawDPmynzh5LURdL0hd+VdEF1EcJSwMmsfVcpxOw0os8BSvJcLdRaz82hS+Q68Q7BDoaXN+w9m+F1NNHBgF41O8mFSg3tTKzRc8235RlT6RzUvyRUDBKkDJSPQEhNruc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738538784; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wZVVhBceus/ZvhLXav64s6GossVdZ9tHNxOQVsXSJbU=;
 b=M99hfFzlMhfFe2PDCEUv+xcnLS2adCt6Y3NwbDSQt3epsaE3hwdwkx9dbUCeeBq/
 rcEpU2b7JAwlQJIkce5UsqI9k2xMlO92+9uU2KohUwJGelKmtTV4pLaNTAQJCY4Mbh2
 4aZBbLYEtWD0oeIkBOrbbcZmjfHczndWMw4kz6+Q=
Received: by mx.zohomail.com with SMTPS id 1738538779112172.02994032248387;
 Sun, 2 Feb 2025 15:26:19 -0800 (PST)
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
Subject: [PATCH v7 00/10] Support virtio-gpu DRM native context
Date: Mon,  3 Feb 2025 02:21:26 +0300
Message-ID: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

This patchset adds DRM native context support to VirtIO-GPU on Qemu.

Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
DRM native context [1] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

[1] https://www.youtube.com/watch?v=9sFP_yddLLQ

Today there are four DRM native context drivers existing in a wild:

  - Freedreno (Qualcomm SoC GPUs), completely upstreamed
  - AMDGPU, completely upstreamed
  - Intel (i915), merge requests are opened
  - Asahi (Apple SoC GPUs), partially merged upstream

# How to try out DRM context:

1. DRM context uses host blobs and on host requires latest 6.13 version
of Linux kernel that contains necessary KVM fixes.

2. Use latest Mesa (both guest and host) and libvirglrenderer versions.
 Use build flags documented in tha patch #10 of this series.

3. On guest, use latest Linux kernel v6.14-rc or newer.

Example Qemu cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
      -machine q35,accel=kvm,memory-backend=mem1 \
      -object memory-backend-memfd,id=mem1,size=8G -m 8G

# Note about known performance problem in Qemu:

DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in Qemu. Exact reason is unknown. Mappings work
fast on Crosvm For DRM contexts this problem is more visible than for
Venus/Virgl.

Changelog:

v7: - Added r-b from Alex Bennée to the async fencing patch.

    - Updated virtio-gpu doc patch with addressed review comments
      from Akihiko Odaki.

v6: - Fixed compilation warning using older version of virglrenderer,
      which wasn't fixed properly in v5.

    - Added t-bs from Alex Bennée.

    - Added patches to improve virgl/venus doc by adding links
      to the Mesa doc as was suggested by Akihiko Odaki.

    - Updated patch that documents guest/host requirements. Added
      links to Asahi nctx and reworked the doc structure by adding
      requirements to each context-type section instead of having
      one big blob or requirements, which was objected by Akihiko Odaki.

v5: - Added r-bs from Akihiko Odaki.

    - Added acks from Michael Tsirkin.

    - Fixed compilation warning using older version of virglrenderer that
      was reported by Alex Bennée. Noticed that I need to keep old
      virgl_write_fence() code around for the older virglrenderer in
      "Support  asynchronous fencing" patch, so added it back and verified
      that old virglrenderer works properly.

    - Added new patch from Alex Bennée that adds more virtio-gpu 
      documentation with a couple corrections and additions to it from me.

    - Rebased patches on top of latest staging tree.

v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config 
      option, better handling EGL error and extending comment telling
      that it's safe to enable SDL2 EGL preference hint. As was suggested
      by Akihiko Odaki.

    - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
      the async-fencing patch for more consistency of the code. As was
      suggested by Akihiko Odaki.

    - Added missing braces around if-statement that was spotted by
      Alex Bennée.

    - Renamed 'drm=on' option of virtio-gpu-gl device to 
      'drm_native_context=on' for more clarity as was suggested by 
      Alex Bennée. Haven't added added new context-type option that 
      was also proposed by Alex, might do it with a separate patch.
      This context-type option will duplicate and depecate existing
      options, but in a longer run likely will be worthwhile adding
      it.

    - Dropped Linux headers-update patch as headers has been updated
      in the staging tree.

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

Alex Bennée (1):
  docs/system: virtio-gpu: Document host/guest requirements

Dmitry Osipenko (8):
  ui/sdl2: Restore original context after new context creation
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/gtk: Don't disable scanout when display is refreshed
  docs/system: virtio-gpu: Add link to Mesa VirGL doc
  docs/system: virtio-gpu: Update Venus link

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio-gpu.rst | 108 ++++++++++++++++++-
 hw/display/virtio-gpu-gl.c         |   5 +
 hw/display/virtio-gpu-virgl.c      | 164 ++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c            |  15 +++
 include/hw/virtio/virtio-gpu.h     |  16 +++
 include/ui/sdl2.h                  |   7 ++
 meson.build                        |   6 +-
 ui/gtk-egl.c                       |   1 -
 ui/gtk-gl-area.c                   |   1 -
 ui/sdl2-gl.c                       |  68 +++++++++++-
 ui/sdl2.c                          |  42 ++++++++
 11 files changed, 422 insertions(+), 11 deletions(-)

-- 
2.47.1


