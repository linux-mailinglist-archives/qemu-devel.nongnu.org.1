Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04616784E2C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcd6-0006uy-3U; Tue, 22 Aug 2023 21:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd3-0006tk-Hm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:49 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd0-00026L-9L
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:49 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1c4d67f493bso3753041fac.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692753944; x=1693358744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tj52fB48WKxx1+s8M/1bUAz7eQMsaiJoe9zD5jZGUsA=;
 b=Fc1dVh049KYqJr2ga52zZXIaTe140sx5Dne0+IT81EvcPoy9xux44cdWA2jvaRJPJR
 jmAPagDw0B17chKvERnwIugScaSJ0OMjYsl1nNUyZn5HDPEYjqVSRjm7ra19UvBxCNrd
 oGVpQd6lJgj1S2g6+hDMnnjSw4c655vNhSJMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692753944; x=1693358744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tj52fB48WKxx1+s8M/1bUAz7eQMsaiJoe9zD5jZGUsA=;
 b=dFKL2uD/3Rv+vENilwtDaic/+1QFFcJq/VsY7PxH5j6rwp2Rnt7aqnZu/CTpgAKfOP
 IyNmjE/c5opcfjMr5djWoHaB+IO43jfKGXuNqSqqzo4f4FXh80S39M91BoaorjGFh5Ol
 TSABLewSO/L3Toqhv7BgxeNtwXPxGFhZ46P8VcYWPQAY+Hlfv5DHOu/XwVRD5sgHO4IA
 NjLKNXLP4itF/xhldnYZ+KczRlDtwElkma+oYzuidkMKXRqgBj7eS14EHDVVfIu+h137
 PCzaw2tGDK1pT+lKiFBo+2n/v39MN3cwwt07mKJyOnDy0qbw8Xhyy3euFGPYNHZEtwHp
 7nwQ==
X-Gm-Message-State: AOJu0Yzec7JruKYK6tcJut+VLxwshSfJgC6uCqRKeaK3x3NOmgairCoZ
 ExjbrHd5FZwXXzD6ESHL0W2g98YLyOUjWOvQtDM=
X-Google-Smtp-Source: AGHT+IHWzRiVOOW5KIb7waPjEKCutOIjEVAtDrTwlnwu2hYwgoYSMH8pNTUiUzQZXE8NTiT7q1oM/A==
X-Received: by 2002:a05:6870:b30a:b0:1b0:68f7:da8 with SMTP id
 a10-20020a056870b30a00b001b068f70da8mr13719705oao.12.1692753944156; 
 Tue, 22 Aug 2023 18:25:44 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a483:9c7e:d68:4057])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm10291409pjb.1.2023.08.22.18.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:25:43 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: [PATCH v11 0/9] rutabaga_gfx + gfxstream
Date: Tue, 22 Aug 2023 18:25:32 -0700
Message-Id: <20230823012541.485-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oa1-x33.google.com
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

Changes since v10:
- Licensing and comment fixes

- Official "release commits" issued for rutabaga_gfx_ffi,
  gfxstream, aemu-base.  For example, see crrev.com/c/4778941

- The release commits can make packaging easier, though once
  again all known users will likely just build from sources
  anyways

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v11

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
 hw/display/virtio-gpu-pci-rutabaga.c |   50 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1121 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   16 +-
 hw/display/virtio-vga-rutabaga.c     |   53 ++
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
 19 files changed, 1506 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.rc1.204.g551eb34607-goog


