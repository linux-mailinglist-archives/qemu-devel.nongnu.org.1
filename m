Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49270E1DD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uzb-0008TH-9C; Tue, 23 May 2023 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1UzY-0008SO-RP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1UzV-0001YX-Qs
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f50020e0f8so34949485e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859764; x=1687451764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KptRZgpfBYhnMYPTPi1yHumyOrnlOIit30ThB+yVWk4=;
 b=F7EyYfEj6ZREzAMVemN+LI+RJJw8lI7ll1z9ITfpS6jKfySxhd+udhvaq3dWf4jfuL
 dZfH+kRTpHzGVUPRxQylBLYOFzKIBqvBtb3HIs9blDBEetJVNpEu9xqaq0JsoiEW8LW4
 pYxAiMnfx9szVefNDrHLlv6QzxYOm0NgV6fAba6qBmPcn3kGn+QTPu4Wu9U51TmhKttF
 cq9c9StYDARaoTjSA56L89egZc2LLGQ9r/tmJ0q9BTq0lkuBw5n0+Tj6yqgy72qRC0T8
 qmY0xAjYJ3CwpAtEvKMIyncAyt+LI/FaqygrWMxkxQVUPgQSFdH08l8stQzzboHbWA71
 Jryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859764; x=1687451764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KptRZgpfBYhnMYPTPi1yHumyOrnlOIit30ThB+yVWk4=;
 b=buYmAtlYkx92vIgH86ny9xjGFmt5mxAJhx5IVmgLeFGCinOPcUj7VjHNoeWn9XvWWM
 o5Kd7o/m8DWD6di1ER62lNI0tqq7dUeH9Iqx0T8R6lwYc15KngDzZdEBhUnJYm7Lsp94
 Ulyyk/jBcwLc/zLiQCv32LBDjSRZS84x7kVjIK3mk/PSddk/5EyhqqAaHodQr2sjFIoH
 6ZSVhIDiT9HdbeX0TOmr9fcSGOEYtwD61enTGaI2AZDmxJTdnSSFobOpZmx2Oitd/MvC
 7nceWcwlbrU23xWynnYw0C6DumgLM1MLF8esvhGAcBnB7W4zVSbHZzBFC/UKC08PATrr
 jaOw==
X-Gm-Message-State: AC+VfDwN2ZzgkFdl79YcEKn3qPzDjvz3psbsE5d4Ha3BuxI7P10aihxm
 MkSYHzSHqD5i8QFDhB5UJOnGZmSzPJpFyWLCDO4=
X-Google-Smtp-Source: ACHHUZ5Flp0ZHQz6Lee6Pa0Iw1+gZqn7f4AXd5pCUUkyx++VmFJn2NYv+G4Uesb3EhsYbYYzUA7THQ==
X-Received: by 2002:a5d:4e87:0:b0:30a:3ae0:f455 with SMTP id
 e7-20020a5d4e87000000b0030a3ae0f455mr7118540wru.2.1684859764200; 
 Tue, 23 May 2023 09:36:04 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a056000104e00b00307b5376b2csm11488661wrx.90.2023.05.23.09.36.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 00/11] hw/virtio: Build various target-agnostic objects just
 once
Date: Tue, 23 May 2023 18:35:49 +0200
Message-Id: <20230523163600.83391-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Less controvertial than my first approach [*] which caches
the access_is_big_endian value in VirtIODevice state, this
series just remove a unnecessary / pointless dependency on
"virtio-access.h", allowing to build various virtio objects
once for all targets.

First we introduce the qemu_target_page_mask() and _align()
helpers, similar to the _size() and _bits() equivalents,
then we mostly perform meson.build massages. Mostly trivial.

Last patch is RFC in case there is a performance issue.

https://lore.kernel.org/qemu-devel/20221212230517.28872-11-philmd@linaro.org/

Philippe Mathieu-Daudé (11):
  softmmu: Introduce qemu_target_page_mask/qemu_target_page_align
    helpers
  hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
  hw/scsi: Rearrange meson.build
  hw/scsi: Rename target-specific source set as
    'specific_virtio_scsi_ss'
  hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in Kconfig
  hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
  hw/virtio/vhost-vsock: Include missing 'virtio/virtio-bus.h' header
  hw/virtio/virtio-iommu: Use target-agnostic qemu_target_page_mask()
  hw/virtio: Remove unnecessary 'virtio-access.h' header
  hw/virtio: Build various target-agnostic objects just once
  hw/virtio: Make vhost-vdpa.c target-agnostic to build it once

 include/exec/target_page.h      |  2 ++
 hw/block/dataplane/virtio-blk.c |  1 -
 hw/s390x/virtio-ccw.c           |  1 -
 hw/scsi/vhost-scsi.c            |  1 -
 hw/scsi/vhost-user-scsi.c       |  1 -
 hw/scsi/virtio-scsi-dataplane.c |  1 -
 hw/virtio/vdpa-dev.c            |  1 -
 hw/virtio/vhost-vdpa.c          | 17 ++++++++---------
 hw/virtio/vhost-vsock-common.c  |  2 +-
 hw/virtio/vhost.c               |  1 -
 hw/virtio/virtio-crypto.c       |  1 -
 hw/virtio/virtio-iommu.c        |  4 ++--
 hw/virtio/virtio-mem.c          |  3 +--
 softmmu/physmem.c               | 10 ++++++++++
 hw/block/dataplane/meson.build  |  2 +-
 hw/scsi/Kconfig                 |  6 ++++++
 hw/scsi/meson.build             | 19 ++++++++++++-------
 hw/virtio/Kconfig               |  6 ++++++
 hw/virtio/meson.build           | 17 ++++++++++-------
 19 files changed, 59 insertions(+), 37 deletions(-)

-- 
2.38.1


