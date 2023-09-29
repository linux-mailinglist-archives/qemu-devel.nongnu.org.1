Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9E7B3B17
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmJs6-0007bK-Jq; Fri, 29 Sep 2023 16:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs4-0007ay-Q1
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJrv-0004IV-Gz
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so12430165b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696018425; x=1696623225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A+1p3SvGyESj9lg0qsnjXx78OjO9MpLaipXvLy3sL98=;
 b=G4XjQEZEHa2nLqkci7l/4wGJS1huFUwST4HwgVXg5G+wxikzJJp1+lxHy0fqQZfqcP
 Yl6L7BZsQD8JXUDU4p2uttiiGtBDN9AULzAo/y6VJMz8Q8RsTeE75P8I49CRvxuH+zht
 gNht7mKPTxNcclr5HlMzjrvtqeUrKZAyZkjB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696018425; x=1696623225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+1p3SvGyESj9lg0qsnjXx78OjO9MpLaipXvLy3sL98=;
 b=AFr7bUj6g+nRUxigkrOP/MvzUFobOknYk5xugowEeH8DlnW9Pex1096aKk4IOQBwvC
 l14E8YnPm6bujoNFz2i+/Fj5gN4sEegy9rmvt/gMANbckbKC0Va1HZv0CQYygfCynkVm
 r6GtvZWFzhu1LONNgxWPEsogvjFhgdYDFzxZSuqIKcJjxLuV4QKb85dTy82nBGs0vDnW
 0uqmeq6/MjXdkvW9y0kh3aDSBiTzzQ8sNmrR3fRDRKxymHFqdeEZNsRVOVFaRaqUR4U6
 NylS9fyv6cwRdZouz8F4kWvhh6ZGXNoqQfdMVqfmM2ovBxe/lTWvIBo9m8Pp54gBx0Q2
 HNzQ==
X-Gm-Message-State: AOJu0Yy45VqncYSB/yhbhAWA1tjAj5CwQ0jfMJJOKIUVI9Ra8umPisrW
 5RIv5QJUN0xdAJSRI/5lQIfT4yYf8szHezi5H9U=
X-Google-Smtp-Source: AGHT+IGEypztCs2kGwmopqTLjo3LjfrwMPDFaboC7O/Xu8z4kEj83pl/XI41/crmQPcs5qfIJXpJmA==
X-Received: by 2002:a05:6a00:21ce:b0:68e:4587:3da8 with SMTP id
 t14-20020a056a0021ce00b0068e45873da8mr5823759pfj.21.1696018425091; 
 Fri, 29 Sep 2023 13:13:45 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:18fe:3fb1:d86b:1e68])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b00686236718d8sm15267033pfe.41.2023.09.29.13.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 13:13:44 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v14 0/9] rutabaga_gfx + gfxstream
Date: Fri, 29 Sep 2023 13:13:32 -0700
Message-Id: <20230929201341.332-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05005.html

Even though reviewed, there were a few issues that needed to be addressed.

1) Packaging/Releasing

Marc-Andre Lureau pointed a few issues with packaging the AEMU library:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg02734.html

https://android-review.googlesource.com/q/topic:%22aemu-package-fix%22
https://android-review.googlesource.com/c/platform/hardware/google/aemu/+/2751077

I therefore propose the current ToT:

- AEMU: d6e6b99 "Delete VpxFrameParser.cpp"
- gfxstream: 2131f78d Merge "gfxstream: add egl & gles deps.."

as the 0.1.2 release points.  Let me know if that works for packaging and
I will get release tags made.  There is a rutabaga release tag already, let
me know if another is desired.  Thanks!

2) Command line interface

The command line interface is now "gfxstream-vulkan=on,cross-domain=on" as
per discussion here:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg03038.html

"wayland_socket_path" is also now "wayland-socket-path" to the command-line
users.

3) Potential bug after memory unmap

Akihiko Odaki pointed out a potential memory map, but it one that would
only be triggered by fuzzing/malicious actors.

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg05141.html
https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg05540.html

I just documented the bug as suggested since I suspect for cross-platform
support that code in particular will need to be refactored anyways, so
avoid optimizing for now.

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
 hw/display/virtio-gpu-rutabaga.c     | 1127 ++++++++++++++++++++++++++
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
 19 files changed, 1502 insertions(+), 19 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.42.0.582.g8ccd20d70d-goog


