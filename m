Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B37B72B4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmGX-00081K-6W; Tue, 03 Oct 2023 16:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGT-00080o-Ll
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGP-0004Z5-U3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27760c31056so917311a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696365903; x=1696970703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JMKnq2QOOQJH7Jer4IdGwPkLpIy2dlLYdDJL1x3b9fs=;
 b=UIo2Jje66Yx6Ll0ApgaurzabeWuf5tEp4hMkzJXD5qjQnnNRr71Cf48LHfCWSWVbpu
 4a+vmROofQxuRDV3fgaDennKRVZEeXlADC9qPsJkHUgrqLxZL+reP2ZPHD9u0qf5D9+8
 /F24XZMIaGI5nrcTsgek/TKA62yWdj7sGaon8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365903; x=1696970703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMKnq2QOOQJH7Jer4IdGwPkLpIy2dlLYdDJL1x3b9fs=;
 b=uXUqzsxnv5r+eEoo6PUerepl1SiG3+6zhcNDd2R4BoqZW+Pte+Y6ZCQndRlXtajXkF
 pNOvuaci5Ovf77R8PLAblLCz0bKFJrTf/NrKaIiTZVwHHsyqKgN5TgftimSSUni0Xx0r
 bQ9goEZGBb1Pz03Lw3BMxS9nIeBQ8G5oygzazPUvSW4LZhCeUs5dNdtBGbuYUCeTTbnY
 senE+KcFD1/rcUbXC18ffDDSUKg0BH+PWRYIaRAa+Ry8SLolmTx6kJe6akZM2pHx4jkN
 0XwipVTV04gsvLqSAeKZI/B89P/T0E9OINJ1Nu1ZbOoevjQcV6mASq6dEWYgN6pl4Q8s
 fhsQ==
X-Gm-Message-State: AOJu0YwglaiENt8y5tNq441oTxhC8uIah0BZZAiiTeUDxamQd0/T/p3R
 KL1jFGSOt+ZAUi4eLUfL1EoA+GqOV+lLPIgcV6c=
X-Google-Smtp-Source: AGHT+IFP0QU1dXmorGMz1rU6IJkWKaxq3jW8KTXRrp4UIDsVuLIEvKWng0xHjK9hTvk8wWbmkupunw==
X-Received: by 2002:a17:90a:ee86:b0:277:522d:11e5 with SMTP id
 i6-20020a17090aee8600b00277522d11e5mr476220pjz.2.1696365903380; 
 Tue, 03 Oct 2023 13:45:03 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9076:49ec:5f9a:e5ec])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b002777b8fc74bsm3739pjy.21.2023.10.03.13.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:45:03 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v15 0/9] rutabaga_gfx + gfxstream
Date: Tue,  3 Oct 2023 13:44:51 -0700
Message-Id: <20231003204500.518-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1035.google.com
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

Prior version:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07402.html

Branch containing changes:

https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v15

Changes since v14:

- Thomas Huth suggested the use of the "x-" prefix for experimental
  properties. Now, we have "x-gfxstream-gles" and "x-gfxstream-composer"
  since those capsets are only runnable with Android guests and we're
  not sure if anybody else will use them.

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07465.html

What still needs to happen:

- As mentioned in v14:
    * AEMU: d6e6b99 "Delete VpxFrameParser.cpp"
    * gfxstream: 2131f78d Merge "gfxstream: add egl & gles deps.."

are the proposed v.0.1.2 release points.  If those commits are sufficient
for packaging AEMU + gfxstream, let me know and I'll have official release
tags made.  If additional changes are required for packaging, let me know
as well.

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
 hw/display/virtio-gpu-rutabaga.c     | 1122 ++++++++++++++++++++++++++
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
 19 files changed, 1497 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.582.g8ccd20d70d-goog


