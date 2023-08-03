Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D3E76F654
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 01:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRi9y-0007GT-I8; Thu, 03 Aug 2023 19:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9u-0007Fw-H6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:10 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9s-0003al-6Z
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a43cbb432aso1163007b6e.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691106905; x=1691711705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+iepu267AqFLf76GrQfReahN0Er33vAj2dB6AV3Z9lA=;
 b=IYMCnGyMwXidpiMjgYRH8cKR+NA9UAoWC12kKLwtBFLxK7sKaEvsdXzj0CcJq2wEd4
 r66xwr97FfBEg+RDCka/Uo/IS6hVpx0nzWCKFTDxI7KBG4XDg2Zc1tVJefuV2ubgCOn5
 sXVxirSwKtZXXP9Xib3gvNHpvfNt1a/d1vr8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691106905; x=1691711705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+iepu267AqFLf76GrQfReahN0Er33vAj2dB6AV3Z9lA=;
 b=LosRbIaLfgOHnwaTGWw5OvOxmsNVSOLqN+Jdmo0/X7XHeQr5pgLty5s7tYjZlXUIO1
 eQapgs6jcNROVJ7a6ewO0VWxDJ7zwRkl2Fi9/7FIni4HFd7SAr1xA6NCbSDS9XyIPaIb
 ylEdl4lgzerwaRjCv9vgqimMCno6RY6FgvSrYd0DRuamg67gidycgPm6egTPDYVzqWYW
 qleIPKwAScfP2rbhC4OSZGCJe5GUxC2Ti3T1308ZrrCOWqhCxemnepwg9/+saw/BRYTT
 Y6sMmvPv+qiDGzUHcHQSmfjjgmhl1gJH8NUBrBd4yFH2F8wSO89FLRELlg5Rx+AFbC9V
 aLuQ==
X-Gm-Message-State: AOJu0YwQZcqM8JiSxwCzS+xEgtcPRdZxcNeyCwPYDiGI2za+5JxGJ/zA
 Oj9mp2XVRBseE2TWYjOfXAmxzC72dUUejC8wuZE=
X-Google-Smtp-Source: AGHT+IFSAK7/3UW9XF2sMhm3oB3+Vz/pormAKH0WNXYhWnlomLvillYAguJHo29E4UCQvuqXEib8Zw==
X-Received: by 2002:a05:6808:e82:b0:3a7:26fd:b229 with SMTP id
 k2-20020a0568080e8200b003a726fdb229mr103544oil.48.1691106905421; 
 Thu, 03 Aug 2023 16:55:05 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9efb:b80c:dd5c:56c9])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a63a708000000b0055387ffef10sm364329pgf.24.2023.08.03.16.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 16:55:04 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v3 0/9] gfxstream + rutabaga_gfx
Date: Thu,  3 Aug 2023 16:54:53 -0700
Message-Id: <20230803235502.373-1-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x22e.google.com
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

Prior versions:

https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html

https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html

https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/

Changes since v2:
- Incorporated review feedback

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v3

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
 docs/system/devices/virtio-gpu.rst   |  115 +++
 hw/display/meson.build               |   22 +
 hw/display/virtio-gpu-base.c         |    6 +-
 hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1121 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   17 +-
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
 19 files changed, 1505 insertions(+), 20 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.41.0.585.gd2178a4bd4-goog


