Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590F7BAFF5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 03:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoZKg-00017L-Pl; Thu, 05 Oct 2023 21:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKd-000172-2Z
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:43 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKa-0007ys-76
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:42 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1e562706d29so758562fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696554518; x=1697159318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AP3zql3cQ5Q5QlsCUow2x4wqI+Rk1yfYb2dj+N2SRDA=;
 b=a+cpHgKZgnCRwYLZ6SMoba6s7pWLYGq5CMKHnkmaGsDARm8JpPecmYp+f0UQ8XtPJs
 v3DsdoF6+fP4oTSsVWzcKeNzzETWovVarLEDCufawGtVwm8nNZoo8ku9M94pX/e1JCrY
 WWDcA2ip/W6Ay+oULLzA6X+oIfzn+ccf+267k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696554518; x=1697159318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AP3zql3cQ5Q5QlsCUow2x4wqI+Rk1yfYb2dj+N2SRDA=;
 b=QFrtvH/D/AYaYYov/J27ESPOBu+b7O/l1RSuxaJX43LW1EE2+P6TPFygisz8YMHMeB
 NQ9sGCWKKVZd95DSUKF6VqhAMelyF2tIBSuSPvY4sTDh3DIskHCNulMrMX6ifqYYBCAE
 UlYK/RmntXOu/vYEMgeiDshR6Ufl5lcYojb/UfqNtqxealC1KnxhityNUCBHyZm705Tk
 XmZxpE8UqbJdajuECLJ6X7mZzjuqSmQVk1vtxI8V32fnhkNYILImyc7L3PuXkqvFmjTD
 7FsOSKcvrBfP5kO692s0Vrqdq7fxVZLTJQ83jv4CoFFUF+mio+QWtM3HNtDCVwsiPTYo
 jDNQ==
X-Gm-Message-State: AOJu0YxfWmVFQsTj7XtLQn/LqUK9UdquBmRw3Pbzt56r6N7c2zg0lTy+
 7BbdoU+72QHTxU2vfQWeXXnqAqyIr6qpZYMUbvM=
X-Google-Smtp-Source: AGHT+IGxJWBXFt0fRsHd7q0mEld21FamX/rd8alfeLFy8Sd7zDJzgrZUtw6GvNEcN5Oqnj7AegMO/A==
X-Received: by 2002:a05:6870:b688:b0:1d6:790e:dacc with SMTP id
 cy8-20020a056870b68800b001d6790edaccmr7614479oab.6.1696554518087; 
 Thu, 05 Oct 2023 18:08:38 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:176a:c8b6:faa3:f083])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a62ed16000000b00690fe1c928csm215079pfh.147.2023.10.05.18.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 18:08:37 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v17 0/9] gfxstream + rutabaga_gfx
Date: Thu,  5 Oct 2023 18:08:26 -0700
Message-Id: <20231006010835.444-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oa1-x31.google.com
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

Branch containing changes:

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v17

Changes since v16:

- Fixed typo mentioned here:

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01407.html

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
 hw/display/virtio-gpu-rutabaga.c     | 1113 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   16 +-
 hw/display/virtio-vga-rutabaga.c     |   50 ++
 hw/display/virtio-vga.c              |   33 +-
 hw/virtio/virtio-pci.c               |   18 +
 include/hw/virtio/virtio-gpu-bswap.h |   15 +
 include/hw/virtio/virtio-gpu.h       |   40 +
 include/hw/virtio/virtio-pci.h       |    4 +
 meson.build                          |    7 +
 meson_options.txt                    |    2 +
 scripts/meson-buildoptions.sh        |    3 +
 softmmu/qdev-monitor.c               |    3 +
 softmmu/vl.c                         |    1 +
 19 files changed, 1488 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.609.gbb76f46606-goog


