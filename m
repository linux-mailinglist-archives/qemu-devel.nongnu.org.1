Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127A74E48C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Yg-00035Z-Fy; Mon, 10 Jul 2023 22:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Ye-00034s-Lv
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yc-0005OX-Ty
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso4570009b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044212; x=1691636212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R7SkoDmkkl32kXF2MJQS4eEFT0ofl5mlMf9Tjv5sBLo=;
 b=gV4aqozGO/KIecM+VMFnZxHRpRXh1YWgYgT/3WK+jcrtyD6HZZ/TUTbpyagZ2rwW6h
 lf4lEps2wyd2xsNaDGUTO5fI1xwWf7S2/gXucY00McRMMucOhvvLNkM/mFVQenvvRzI9
 0kebqRaP8BnPo2Yoc1hahCk5rVGsjcgB5tiOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044212; x=1691636212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7SkoDmkkl32kXF2MJQS4eEFT0ofl5mlMf9Tjv5sBLo=;
 b=R78DL/YxkXuICyNjMYdIaqjKtT2pfDORSt2J4KJ+x1TfkTPkHH9zixLG7n9Ml4WgiL
 /Ra3aoXnS39caevaNwtcabgxn4UGzHqIakHfuiBSHV2dM8ggMMEHZePPe+NcDCGhMzIE
 kMRc9X8nmK2F/K8mUoUPwPnh4Br1NjsRE7725bpKg+myg6qo3KIQeULZgtxVJnK4p8ze
 P7jpxVDtha9I9cbhLDP6K0kxt7WXdfzUKNg4ZhyJTD8OMVHLzFa/myqBpV9TSJJtJOEF
 156ed1mghadhaB8+lpbusJoHy0kvegOiQHCJseyZZm3jnwdCyAZq/l6vJu+dmAfPBucb
 pihw==
X-Gm-Message-State: ABy/qLbajfpFd4b7QC+RYMHlK1BnbuHQEFkdOVmss6BgeBpkr8wqXt7Q
 CHKQFE+3aaGSK4iqIMGRYmBK3xiznh8Mry7h+4k=
X-Google-Smtp-Source: APBJJlHicQsF9UjfNcOZhnimsL+3EwmJY9y9PCakup4XktrxB2rEBkk9AeN2P4OKjWB0xp7TY05ZzA==
X-Received: by 2002:a05:6a00:124c:b0:66b:6021:10fe with SMTP id
 u12-20020a056a00124c00b0066b602110femr18409312pfi.31.1689044212296; 
 Mon, 10 Jul 2023 19:56:52 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:56:51 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 0/9] gfxstream + rutabaga_gfx
Date: Mon, 10 Jul 2023 19:56:40 -0700
Message-Id: <20230711025649.708-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x436.google.com
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

From: Gurchetan Singh <gurchetansingh@google.com>

Latest iteration of rutabaga_gfx + gfxstream patches.  Previous version
and more background available here:

https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/

Changes since RFC:
- All important memory tests pass
- Went with separate virtio-gpu-rutabaga device as suggested by Bernard
  Berschow
- Incorporated review feedback, mostly from Akihiko Odaki
- gfxstream has new unified guest/host repo + build system improvements
- added documentation on virtio-gpu
- new instructions on how to build available in the tracking bug [a]

In terms of API stability/versioning/packaging, once this series is
reviewed, the plan is to cut a "gfxstream upstream release branch".  We
will have the same API guarantees as any other QEMU project then, i.e no
breaking API changes for 5 years.

The Android Emulator will build both gfxstream (to get bug fixes fast)
and QEMU8.0+ (due to regulatory requirements) from sources.  So we haven't
created a gfxstream Debian/Ubuntu package since we actually don't need it.
Though, we plan to upload our QEMU8.0+ gfxstream enabled builds somewhere
on AOSP when it's ready.

It's more important for us to be in-tree to reduce technical debt given
this.  Let us know if there are any strong opinions on packaging.

Otherwise, feedback + reviews welcome!

[a] https://gitlab.com/qemu-project/qemu/-/issues/1611

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
 docs/system/devices/virtio-gpu.rst   |   80 ++
 hw/display/meson.build               |   22 +
 hw/display/virtio-gpu-base.c         |    6 +-
 hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1088 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   17 +-
 hw/display/virtio-vga-rutabaga.c     |   52 ++
 hw/display/virtio-vga.c              |   33 +-
 hw/virtio/virtio-pci.c               |   18 +
 include/hw/virtio/virtio-gpu-bswap.h |   18 +
 include/hw/virtio/virtio-gpu.h       |   34 +
 include/hw/virtio/virtio-pci.h       |    4 +
 meson.build                          |    7 +
 meson_options.txt                    |    2 +
 scripts/meson-buildoptions.sh        |    3 +
 softmmu/qdev-monitor.c               |    3 +
 softmmu/vl.c                         |    1 +
 19 files changed, 1431 insertions(+), 20 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.41.0.255.g8b1d071c50-goog


