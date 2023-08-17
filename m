Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E577EF0D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWSfg-0006C2-FW; Wed, 16 Aug 2023 22:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfe-0006Bm-0x
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfb-0006lN-4F
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:33 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26b2beae166so3194391a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692239008; x=1692843808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EFPbCY6+8GL9sIgUl2TGUAtCzyuQh/hZe3VkjowChTs=;
 b=JqhARXsNZAFtSyllzjXA8TCwDs3dYXhGIULx4MAnM08QZZalKTEHRBU5LV+/N0U9hl
 nNKo7CDrtq46FWz86r1tOaP38POMfrJyPoP1y0lfzDud5uY9Klx+eg5CLFvBPHDGGaX2
 55vcetPNe5x32cHcjzmprQD3oe57jA0hrgAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692239008; x=1692843808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EFPbCY6+8GL9sIgUl2TGUAtCzyuQh/hZe3VkjowChTs=;
 b=R96OuJWoDuHqOq6xGPGF8gJl5ZdiQyIMypJ0NaG+5BUGFeugimiXG+7OyQIU8HTSoL
 wsFg3IZzSHaMc1jCJ1trBd9OMiVf14mG7kjBiGAk5GFAkvyVrm/dNbVJmP0BluNhBJNE
 XKO7QN5qtuSD1KM4KFDvbEfGjYmgDsQagoq3MpYJSIsfqKHO3l0mQ1Q06WJ1/UrcsEnJ
 xoMQqfrf0sffJxO1qzovASyWUdpVpeUJ/6NdYOmBXaMnSY5+F9IFPBPtI5LVYipAZVhM
 vzQGrrdNVS4ccu3+vZ8gBadq03qwwLMq209mTR3quEzD8bVWpiBRhkH3bK9eYL/clICC
 +9gg==
X-Gm-Message-State: AOJu0YzlXUCMAX+L9XnmAYt5WMMqtkVvnSy1Udq8rLwhJ4h+I7IX0vu4
 77p6Gmo1VQneLyvPJIH4cjWnC4JMDjwEpXaeOSs=
X-Google-Smtp-Source: AGHT+IGY4ka7sYh3jURjRsEW4shUFHmgRWF7VHsjrfq12BGHY9L4YeB2Cn5soCwrdDHHTVT85TPaVA==
X-Received: by 2002:a17:90a:f40d:b0:263:287e:3991 with SMTP id
 ch13-20020a17090af40d00b00263287e3991mr2916863pjb.22.1692239008516; 
 Wed, 16 Aug 2023 19:23:28 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:b7f8:4544:6dd7:85d])
 by smtp.gmail.com with ESMTPSA id
 hg14-20020a17090b300e00b00267eead2f16sm401085pjb.36.2023.08.16.19.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 19:23:27 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v7 0/9] gfxstream + rutabaga_gfx
Date: Wed, 16 Aug 2023 19:23:13 -0700
Message-Id: <20230817022322.466-1-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x102e.google.com
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

Prior versions:

v6:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02520.html

v5:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02339.html

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

Changes since v6:
- Incorporated review feedback

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v7

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
 hw/display/virtio-gpu-rutabaga.c     | 1115 ++++++++++++++++++++++++++
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
 19 files changed, 1497 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.rc1.204.g551eb34607-goog


