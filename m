Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F07750BC
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYfN-00072T-KW; Tue, 08 Aug 2023 22:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfM-00072L-26
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfJ-00015B-W9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:15 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6877eb31261so4661109b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691547071; x=1692151871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PhBjlsVG6wRu0Ng5uYBTQij4H5Q4egVJWIOX6H/2OMA=;
 b=lROQo6LCpkiD7kqpvLQC396BEchDaPzs12bvaRDBSiarKacnlFzjR8DNuBtK11xYwJ
 S8ShXpq7rGg/MIau30aQcGk7nFJIolWAM3AL7xn4VDKPGnzsc8/P1CjqwNszhf4BwUyZ
 QEECwI8swtZq3g7TsVwPW0EKBi4sC9lW2y+7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691547071; x=1692151871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PhBjlsVG6wRu0Ng5uYBTQij4H5Q4egVJWIOX6H/2OMA=;
 b=OT6KY+0LRJGvCByBE36xJ4Eqe5842qVwj0VlR+gipt1DwjUAdFWf1WoEJZ2jla7qVi
 IsDTV+yMMg14JVi0OLoUtjflzDLl/gYSNSnXLfFcHi6JzDFbeajUWZ7Q1Ico8uVd/Tpo
 Qrm67i/2vRckC41cwHNN2qlcw6f4HHTUMfiD6J92YRS96fg9IOmMuyl54LgAFifmG7aY
 T/H8R9/gue2px8ZNLzRY+KbX3eU+2TxdDUMuusKyaC/y0KIt35mLZwIqRJky7/6qgDxd
 tLAgJPEO7dSmt+jlHbwGQ2l/UEZyGk0evcHq5gV3gk2YsKlCvY0uhn+FU4xN3Njbnw1t
 LDvA==
X-Gm-Message-State: AOJu0Yz+9AQhXEft8362NJ6t+DuaaK7npjFUr27f48r9L4jkkTCRPNpJ
 CZUW7scbzjpDG8TUDFVKagv8qTbWfUZpv5I/WcvRNQ==
X-Google-Smtp-Source: AGHT+IGr6Yb6XMba0L3DyogRUR1Flth7jO7CfyyXTfD3nHsES27eumoGZSOzA1u4W4Dh6f2EWqypGA==
X-Received: by 2002:a05:6a00:1ac6:b0:675:8f71:28f1 with SMTP id
 f6-20020a056a001ac600b006758f7128f1mr1251850pfv.30.1691547071408; 
 Tue, 08 Aug 2023 19:11:11 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a5a2:f074:e7af:41fe])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b00687494a59bfsm8681887pfo.61.2023.08.08.19.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 19:11:11 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com
Subject: [PATCH v4 0/9] gfxstream + rutabaga_gfx
Date: Tue,  8 Aug 2023 19:10:59 -0700
Message-Id: <20230809021108.674-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x432.google.com
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

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00565.html

https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html

https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html

https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/

Changes since v3:
- Incorporated review feedback

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v4

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
 hw/display/virtio-gpu-rutabaga.c     | 1116 ++++++++++++++++++++++++++
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
 19 files changed, 1500 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.41.0.640.ga95def55d0-goog


