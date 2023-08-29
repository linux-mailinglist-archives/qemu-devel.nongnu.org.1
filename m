Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16678BC2B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 02:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qamj0-0007c9-8j; Mon, 28 Aug 2023 20:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qamij-0007bI-9l
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:36:37 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qamig-0007cN-MH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:36:37 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a99eeb95aaso2745594b6e.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693269392; x=1693874192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PiEKGDkyhHu9Dt76Xl4N2DqnOq0z29F5msuQU3uVi/8=;
 b=ftyryCqg4GfKDLIDsSn+LnyquXY2PgoaWGI6ByfZ+nQJs7RIr7hkOehcQdaG7Fxb67
 H2KRJddWyXO+2Gt0Z6dRv8vO9VhVqPdi8AJOz/3f2vQz6YQ/q5o6BEZgmKLOmdxLPK4N
 G5kgsVGSlNI4DYhHxtspMYq0MY8eokMidV7u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693269392; x=1693874192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PiEKGDkyhHu9Dt76Xl4N2DqnOq0z29F5msuQU3uVi/8=;
 b=kpnHdOqa4LRRNzT6QnVVXD07yal7BPpPaIzvZLJcoVgI3rY+oocruMs0rWK7fjk7ft
 PInpw3TzEml2IX6oJF+9yuMlohob8q9KxqoVy+rizAGUBVIT5E5A/VjSPeLNasm1Kb8r
 if5KVODo/+wVde0H0iOtTRZsfPaOpBmAwWxmd3PT7yRl+cFWFEKrYkj3Zq39oPs11md1
 qMYVZ9JXWmI/FpTvzuLhaUk7QWyAjQtsjEL3ipZfJY1+9fNSDMlWs0acOv4ZuTbl4tO6
 S0Y3pxlSdHvNjj0MXuCocP0WEOS/I48HWjtpVjw8iVSblcniU+EYA0gE9sB5a3p0PvXm
 4f8A==
X-Gm-Message-State: AOJu0Yyu+66kY2GrYUmblFvhufXfm8CspfP9GPB50QGkfiJzz2dckkDa
 e7C7gQbmCzrEFpIn8mVCvAEc5MeOipCOh5KhQ3U=
X-Google-Smtp-Source: AGHT+IHpMQUHh1ay1dsnQyImdsnpj/VXoJ0vUOqmiYXf1ory7/dVnrmI5yyCAXV5XHbJw1H3DPqCqw==
X-Received: by 2002:a05:6808:15a0:b0:3a7:238a:143e with SMTP id
 t32-20020a05680815a000b003a7238a143emr16977375oiw.2.1693269392536; 
 Mon, 28 Aug 2023 17:36:32 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5fa1:f455:2676:5eee])
 by smtp.gmail.com with ESMTPSA id
 c3-20020aa78c03000000b0068890c19c49sm7214782pfd.180.2023.08.28.17.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 17:36:31 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v13 0/9] rutabaga_gfx + gfxstream
Date: Mon, 28 Aug 2023 17:36:20 -0700
Message-Id: <20230829003629.410-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x229.google.com
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

Changes since v12:
- Added r-b tags from Antonio Caggiano and Akihiko Odaki
- Removed review version from commit messages
- I think we're good to merge since we've had multiple people test and review this series??

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13

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
 docs/system/devices/virtio-gpu.rst   |  112 +++
 hw/display/meson.build               |   22 +
 hw/display/virtio-gpu-base.c         |    6 +-
 hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1119 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   16 +-
 hw/display/virtio-vga-rutabaga.c     |   50 ++
 hw/display/virtio-vga.c              |   33 +-
 hw/virtio/virtio-pci.c               |   18 +
 include/hw/virtio/virtio-gpu-bswap.h |   15 +
 include/hw/virtio/virtio-gpu.h       |   41 +
 include/hw/virtio/virtio-pci.h       |    4 +
 meson.build                          |    7 +
 meson_options.txt                    |    2 +
 scripts/meson-buildoptions.sh        |    3 +
 softmmu/qdev-monitor.c               |    3 +
 softmmu/vl.c                         |    1 +
 19 files changed, 1495 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


