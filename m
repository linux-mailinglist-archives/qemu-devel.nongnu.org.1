Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9776A626
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe12-0001Yg-1U; Mon, 31 Jul 2023 21:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe0z-0001YH-1z
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe0x-00039s-7c
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:32 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-26854159c05so2981294a91.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852648; x=1691457448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oE3VWW3YMOHwHTANeHB3dRzaF5/YWKH6SNTIQRNjUR4=;
 b=nkZVgcUd7k98Gy+QUBevKadv1OA8axGvEXlcbiu6Or29JEFV0ct8bzIPaaoWmzkw08
 UVY7kmsYB9doWQ71B6EGCTojFhFFE4XD/rjUoVSx0W93bNI/vPPcD1fQ94uTdDFOnN4b
 hKI4bJ1AqSIeWceN0Qbdo5JP98ovrXgeXvODU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852648; x=1691457448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oE3VWW3YMOHwHTANeHB3dRzaF5/YWKH6SNTIQRNjUR4=;
 b=BkgnUf4jKn5fw/WK1wlkGOWKdYnDrxyzToipyvjVVi2bRY2Bnu7+wsp7NGAUmctrbF
 zGkum7WWVkyM2SApIQujPuZXWRubam9w3xS8wCwamFDbxKQjNkaYnaGPC2xkptVyVZEw
 Ft8ry86R/JWk6RB6zJieek58ElAtbcT7eJ5ewhTkJ472WvgaG2rgETe/ywwolTIVam1E
 GRvivXSI7sn7trtezXP2s0jBpCJ2A/Os5SSGefqKpIsGs8aNbgV+rskZ+v8ml6acz43W
 BINc/1UQKDr92u0axza1oI7LDtcJTWTMkiAkFDg2tILGk3I96QP3GgJXcU0AhLtV9kyB
 GtWw==
X-Gm-Message-State: ABy/qLbZXTO/dzAU6j7vdonB3+a08W3WFdOwOOAZscYpfqx6a9IBTSYs
 u7RopYk2zJkLGwIwvDVdiM0o8a5KwXKTwP9mBYM=
X-Google-Smtp-Source: APBJJlHG2lB3V6/nIF7lUovzkYqq9eMYyWgBbLCbvFsRv9gh3kF68UO2OhwKM5k9wgoEY63nT/WHVQ==
X-Received: by 2002:a17:90a:3e4e:b0:268:29cb:f93a with SMTP id
 t14-20020a17090a3e4e00b0026829cbf93amr10975578pjm.1.1690852647616; 
 Mon, 31 Jul 2023 18:17:27 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:26 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 0/9] gfxstream + rutabaga_gfx
Date: Mon, 31 Jul 2023 18:17:14 -0700
Message-Id: <20230801011723.627-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1034.google.com
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

Latest iteration of rutabaga_gfx + gfxstream patches.  Previous versions
available here:

https://patchew.org/QEMU/20230711025649.708-1-gurchetansingh@chromium.org/

https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/

Changes since v1:
- New error callback hooked into QEMU error's handlers
- Incorporated review feedback
- goldfish-opengl repo is now gone: new unified repo for guest and host

How to build both rutabaga and gfxstream guest/host libs:

https://crosvm.dev/book/appendix/rutabaga_gfx.html

Branch containing this patch series:

https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v2

Next steps:
 - Will add a v0.1.2 release "commit" after this patch series is fully
   reviewed, but before it's merged

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
 docs/system/devices/virtio-gpu.rst   |   98 +++
 hw/display/meson.build               |   22 +
 hw/display/virtio-gpu-base.c         |    6 +-
 hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
 hw/display/virtio-gpu-pci.c          |   14 +
 hw/display/virtio-gpu-rutabaga.c     | 1077 ++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              |   17 +-
 hw/display/virtio-vga-rutabaga.c     |   52 ++
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
 19 files changed, 1445 insertions(+), 20 deletions(-)
 create mode 100644 docs/system/devices/virtio-gpu.rst
 create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
 create mode 100644 hw/display/virtio-gpu-rutabaga.c
 create mode 100644 hw/display/virtio-vga-rutabaga.c

-- 
2.41.0.585.gd2178a4bd4-goog


