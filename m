Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E4D77D794
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 03:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW5BN-0002h8-7C; Tue, 15 Aug 2023 21:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BI-0002fm-Bp
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BF-00059L-3P
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so10531795ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692148714; x=1692753514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bu9EQLJfLvrrCFb9/sXWzQZRMU29WrJH7feImpmy20c=;
 b=kUPPH4XSuXqmjLS745IdpXRFVwrvwKDwr0gwvusKczljJnOHhciTdKvOgI7C3phehV
 +qIt7dZtBbJpNgxHxWixQWkDd8Eot5DSbYSuRa6nkcXfE2PJ8nETYCnbXyFw1vEVqnnb
 199BISbjqPiLYG3VWrhufvXJJ/bXUpwyn8vis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692148714; x=1692753514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bu9EQLJfLvrrCFb9/sXWzQZRMU29WrJH7feImpmy20c=;
 b=cPXDb5hmBZHsfPtnpwNombt+y1r4ItWlfgSkzpOpE/MF8clOey/wlVAgEpEUNsUWbs
 7048yBFFPzI3Ex3zy3B0ylZR/24a91C7fLCMPMi22NfH0XURl5dYmhVY1TiutR39k4EQ
 Ej4N1fTR8xdGL1QTDEB6/QmuJiaojIEvql4LL6IqeR715+7RWl29/68kTb17gsoznNIP
 JWrNkJno/DDZQ39NcPhL7tLC+MllcSj6PR1lyAa1g44wrXoGNZHdXW92wpjVH021iXt5
 p2H3LlESs7ERM+S8+16pBPkGyofZQay0x7wkP7HlfZFOJ4jgC8xIxgzP1BhSLoEDVMA3
 +enQ==
X-Gm-Message-State: AOJu0Yxgw7eZD48y5kFh4z4yjuMEPnFfF1lhJZ+9VEOAwwTRrIC3mYP3
 pj2Ye+36tfQrJreaR5hxTNpYhvapV+0YhqRKyij3GA==
X-Google-Smtp-Source: AGHT+IE4s6y2tMoSRCzNTdxtC0cyPMgF4DNbOI4ZeO5LbpMLKUQtghalPjW1gw4jTAPi9Qp6lJAnkg==
X-Received: by 2002:a17:902:6b47:b0:1bb:c06e:647a with SMTP id
 g7-20020a1709026b4700b001bbc06e647amr430600plt.53.1692148714498; 
 Tue, 15 Aug 2023 18:18:34 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5f11:65df:7276:aadf])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a170902da8200b001bc7306d321sm11723562plx.282.2023.08.15.18.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 18:18:34 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v6 0/9] gfxstream + rutabaga_gfx
Date: Tue, 15 Aug 2023 18:18:22 -0700
Message-Id: <20230816011831.599-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

Changes since v5:
- Incorporated review feedback and added r-b tags
- All patches reviewed and/or ack'ed now.

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v6

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


