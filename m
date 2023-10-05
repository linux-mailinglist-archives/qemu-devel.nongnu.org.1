Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF907B9A09
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 04:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoEKy-0004aK-0O; Wed, 04 Oct 2023 22:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoEKv-0004Qc-Pt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 22:43:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoEKt-0006v6-Nj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 22:43:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c877f27e8fso3586385ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 19:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696473813; x=1697078613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RQnHmueUqQl8D6QRZcZYl6n3iDxtzhW+gZ+LsCoAIzc=;
 b=Z6qmrKCMTrCOIfEiJE2y9mO+f10Utcif+wYGwfjZincEMp9oLAO/rd/6xWysGvE1L9
 Do93YwD7MAmhbaC3gTN/hQbFfxFquSL69lfZputON3UE8BizF4TGhtmO1VzC+xUM2Y+O
 CJkoIWHdAcX1SqQxhWpD1Hqy7IGUMRjfKLAjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696473813; x=1697078613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQnHmueUqQl8D6QRZcZYl6n3iDxtzhW+gZ+LsCoAIzc=;
 b=I4mVAH/5yMt/keZ0doAYnvT2o3Ijt0rZ1/6P6k0mc9bbwJDsI/EFPrJQEW/zIykxfn
 j7oBRZDrKC5Ztsva6wGCVjN17poPMp4hz8FcGpbey6sDOSAHHgYINDWDYpCM79Qrh9vq
 B0IZOWuTSK34SOL3mZHMUsbJsDVJ7Mu3SvPmVZc5COTl0iysSpyN5TMnN65+3H+O05iZ
 KRbWty1zlrW5sAW4RGAKcuDj7JJOKOiQ/PYNL5GW1sHWHw/4mDMloPNgK6oKFdDKqboa
 kH6mWZCk74jufWJTLsDDVpUcpSUTpd0AhW8jHmw6iFPkl4r1E/woWgsbk3CHzs8VvX3t
 0b7A==
X-Gm-Message-State: AOJu0YxAuaAilWV55TKknh0cO7OhFr31FUpZd5nJwBKLF/PB0TcXyf1L
 +0CnkCKMkuEsFfUjk7bN4BtlGQl1lO5TpKT4AmI=
X-Google-Smtp-Source: AGHT+IG5ykvWAppYz64Ygd3v1RbacubyTImQQINf++M7xX+fEM4IjZ/7zLzymX+G30T8HyQWzsKZSw==
X-Received: by 2002:a17:902:ced2:b0:1be:f45c:bc38 with SMTP id
 d18-20020a170902ced200b001bef45cbc38mr4848581plg.2.1696473813155; 
 Wed, 04 Oct 2023 19:43:33 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:95d7:bc26:d70d:81bd])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902ce8800b001c76fcccee8sm295209plg.156.2023.10.04.19.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 19:43:32 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v16 0/9] rutabaga_gfx + gfxstream
Date: Wed,  4 Oct 2023 19:43:21 -0700
Message-Id: <20231005024330.836-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x635.google.com
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

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v16

Changes since v15:

- Incorporated review feedback from here:

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00800.html

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
2.42.0.582.g8ccd20d70d-goog


