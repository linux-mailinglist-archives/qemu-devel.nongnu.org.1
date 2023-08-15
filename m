Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD677C48A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 02:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVi27-0004HL-Ju; Mon, 14 Aug 2023 20:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi25-0004H4-NH
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi22-0004qi-Od
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso11360055ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692059730; x=1692664530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RFsml07mWkK9dXPFexLMw/4+cxRrYTdYpZitf414sFw=;
 b=YUuf6pbkt2TLCeOncsWAu3QCZQBTKrl5kE/TmZ3UxJ+byWSQwcsxHhxqYWKngKO44T
 ORDSux0Nfm42fy29aa5fJz+LAo23aKexgysDB/417ylmjfuEXSsfTXpWhHHaJmCf1Tt2
 tbaXAxXkELYSadWbKRjQNF2scVj8LllurtiI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692059730; x=1692664530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RFsml07mWkK9dXPFexLMw/4+cxRrYTdYpZitf414sFw=;
 b=BVRmapzQNDTikW7/Dvilr+FQlbmY1NTJY5nd4A7sQdjTMWaX7bsQXZcwq9mDJKcOYd
 qDdI8w69NmEBWn0WnNO+cpDa/FDfUegG/bC6Bdt9SF11+eQ5Nxk29BE+R0lQCuEJsFb1
 LLH8vDVXS3BL3ckckn8CxReIDSriPFjc0H3DCGBk6aJMr7VnL6d1KFx/HoOso59aHTOA
 uClXM1RkncJbLfp4DnOwc55xFSNQibLdzY+unO/uVpDz832qwptGPqqm9NVqynSO1IIr
 5j8NHJkfCqKWfs7ta0oWq+yx9RfYufGVFH3TSEBBUJK61afqa9ude9CcrMRHznmTHytg
 USiA==
X-Gm-Message-State: AOJu0YxaL7iqN05UODfPKPslPu+NbPM1G5c3i028gvs9TrwDKseN7AKh
 xegzFMwjuPFcL12XeWxUfPkI7k91b6p9Xdt5Ves=
X-Google-Smtp-Source: AGHT+IFgb1JA8DP7WMhxdVQjzMOQIznJkHe4vlthDZML0ApQGeCOHX6t/biploFJDvpApkwDnXdMeA==
X-Received: by 2002:a17:902:714f:b0:1bc:4415:3c1 with SMTP id
 u15-20020a170902714f00b001bc441503c1mr543871plm.7.1692059729690; 
 Mon, 14 Aug 2023 17:35:29 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5e8f:33b0:7163:af34])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001bdc8a5e96csm2319612plb.169.2023.08.14.17.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 17:35:29 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: [PATCH v5 0/9] gfxstream + rutabaga_gfx
Date: Mon, 14 Aug 2023 17:35:17 -0700
Message-Id: <20230815003526.631-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x62f.google.com
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

From: Gurchetan Singh <gurchetansingh@google.com>

Prior versions:

v4:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg01566.html

v3:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00565.html

v2:
https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html

v1:
https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html

RFC:
https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/

Changes since v4:
- Incorporated review feedback

There area a few things I didn't fully incorporate and here are reasons
why:

"Perhaps it's better to add another parameter to CHECK() and pass values
other than VIRTIO_GPU_RESP_ERR_UNSPEC where appropriate although I doubt
anyone cares" - Akihiko Odaki

The rutabaga_debug_cb will give a more detailed description of the error
in most cases anyways, so I didn't change the macro for simplicity.

"I think it's better to make a hard error if the user requested
RUTABAGA_CAPSET_CROSS_DOMAIN but the default socket path does not fit in
wayland_socket_path." - Akihiko Odaki

It is possible to use cross-domain without enabling Wayland, for guest
swapchain allocation [a] which often needs special handling.  We might
want to use this capability on MacOS/Windows in the future without
Wayland, hence we shouldn't hard error if the default wayland socket
isn't found.

[a] https://android.googlesource.com/platform/external/minigbm/+/refs/heads/main/virtgpu_cross_domain.c

"Originally, Antonio Caggiano implemented the virgl_cmd_resource_xxx_blob
in virtio-gpu-virgl.c. Could you have a way to re-use that kinds of
functions in your implemenation?" - Ray Huang

Those patches haven't landed yet.  Once a blob-enabled series does land, I
do think makes sense to factor out generic helpers where-ever possible.

Otherwise, all other suggestions are in v5.

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v5

Antonio Caggiano (2):
  virtio-gpu: CONTEXT_INIT feature
  virtio-gpu: blob prep

Dr. David Alan Gilbert (1):
  virtio: Add shared memory capability

Gerd Hoffmann (1):
  virtio-gpu: hostmem

Gurchetan Singh (5):
  gfxstream + rutabaga prep: added need defintions, fields, and options
  gfxstream + rutabaga: add initial support for gfxstream
  gfxstream + rutabaga: meson support
  gfxstream + rutabaga: enable rutabaga
  docs/system: add basic virtio-gpu documentation

 docs/system/device-emulation.rst     |    1 +
 docs/system/devices/virtio-gpu.rst   |  113 +++
 hw/display/meson.build               |   22 +
 hw/display/virtio-gpu-base.c         |    6 +-
 hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1114 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   16 +-
 hw/display/virtio-vga-rutabaga.c     |   51 ++
 hw/display/virtio-vga.c              |   33 +-
 hw/virtio/virtio-pci.c               |   18 +
 include/hw/virtio/virtio-gpu-bswap.h |   18 +
 include/hw/virtio/virtio-gpu.h       |   41 +
 include/hw/virtio/virtio-pci.h       |    4 +
 meson.build                          |    7 +
 meson_options.txt                    |    2 +
 scripts/meson-buildoptions.sh        |    3 +
 softmmu/qdev-monitor.c               |    3 +
 softmmu/vl.c                         |    1 +
 19 files changed, 1496 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.41.0.694.ge786442a9b-goog


