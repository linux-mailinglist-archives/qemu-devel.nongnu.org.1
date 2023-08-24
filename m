Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C31787C08
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZJwj-0007CF-Ua; Thu, 24 Aug 2023 19:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwe-0007AH-5k
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:56 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwb-00057x-Mu
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:55 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a81154c5f5so274961b6e.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920450; x=1693525250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5mZJ/G9G8dbiqHhTItOWFKtfpROFk6f/RXWPsdMCA+w=;
 b=a3C4lH5/9ctA8domm+Vzj6mXHxQUERhzKojLqYhGz/IbtA0/RK0x6MUAxdd3gYlSFY
 I6KAiiUQOUKswQMaR0vWnKzoFKCl05bNfFJbq1aB8hRAhSUr+E/GmMy7O2X/jSRmNGuM
 dWNbPjMK3IChvxPKpPjD+oB9iWJ/R+J6LkZUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920450; x=1693525250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5mZJ/G9G8dbiqHhTItOWFKtfpROFk6f/RXWPsdMCA+w=;
 b=ZFPS/CDlGfYomQ7YKvFxOTeQyM9ZgOOR1VkzzNICsYiBoQk6+tf4qX/TaQ9yOB0bct
 hmX9z4I6v06DxVkArIClxvSrXfNXriSCU4I0JPKO3pVcAOgpvA+pKDU67606qsrNdkKU
 4HzfIqozP3osauSQH9IrnqmpGNmdUK084pAflbYLYzj/5Di9k53QjGSTPvHW0yTIkB/1
 V2PRpk21PXDzhPadUDqTuC/YkfZpmwH4e3vTSDrDECNCKjPPWWxF2IXAfIxIB1yzxf+J
 s8SvoqSmV3s+CJQfym3TqSH7IArjYUqS/epJ3ncXRvCJyBsQ4sxA/NDUJRPE73BdZ7gB
 RJpw==
X-Gm-Message-State: AOJu0YyWrtEI1kiUG945J6urWN4If/rzBFQC0cuCqP/yHpuvdLIzYUEM
 ya9W70HvHikov+kgZH8YuYmwLRJMLPIhZMxTcpw=
X-Google-Smtp-Source: AGHT+IHwjLF3exsYZA+L+PBT5dKE88V2Cqy9vQwENSXlf4nzlclI0K3nYmAlruZWkfNgf7aBA/6ZRA==
X-Received: by 2002:a54:4d92:0:b0:3a8:29a9:e4d7 with SMTP id
 y18-20020a544d92000000b003a829a9e4d7mr1134103oix.36.1692920449781; 
 Thu, 24 Aug 2023 16:40:49 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:1fa0:9cd:3c53:231b])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b0066a31111cc5sm274798pfb.152.2023.08.24.16.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 16:40:49 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v12 0/9] rutabaga_gfx + gfxstream
Date: Thu, 24 Aug 2023 16:40:37 -0700
Message-Id: <20230824234046.499-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x231.google.com
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

Changes since v11:
- Incorporated review feedback

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series (now on QEMU Gitlab):

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v12

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


