Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400070F315
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwO-0004MK-5p; Wed, 24 May 2023 05:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwM-0004LX-7u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:37:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwJ-0006lG-2q
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:37:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30a4ebbda56so550423f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921069; x=1687513069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nXhkK4lgfSGJkas3VAy9ID2rrn3QU3K1htRoh5aSHvA=;
 b=zau8ZF+U6KcTAfb7SzJ+6Vq6UF4Xpp1UC2UP3uOgcJmHkMHQta4HKlNK4Pw5ovWnY5
 nQcEZukPQ8bzGoyTcSv6KcHTLHmhBpmHR6LU5i28tTKiScXO+wFFQ+uwyCkNGtVhc5SY
 vR4aKKG86IK9AzX6GLOYgwkVutCcRHvK1XIrBxO0fdepDTMdl4ZJgu0zGF9B01OjVYJP
 wJBp1afj2adWd/Yn4TCUavwywBMqm+8HkVHLzWUsUrTG47ePblyn5h9qZgqKYKwYvkss
 IqMjrQFiuBaVPqSfzvm09esWDtiLUPvo21R0Lsc+FZlSL6I/r7fgD9DBYqGP3UTCXlkV
 Vemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921069; x=1687513069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXhkK4lgfSGJkas3VAy9ID2rrn3QU3K1htRoh5aSHvA=;
 b=bsmrEBzW/YecG7F+fA8H6HEdH0gYJhAtDwJREXcYAtmiGRELF/O5kL/iUKFGA020i/
 x90FF1+rgyeu8hdxxRLrc8NRSCurRKEpqGHXKEfnMx8C957uAthLEOoZ+6OBdgFSTkSp
 k0cLyl46eVT+EJBRXQ3DJkeRDybPjKBnWOyJJof3uSFu4FXdofsOr0xp4nX1dCF2z6MO
 p7WEtWof8BSmUX+up2ngKxEv8o+nisER+0QRHfsJUrF3i31DgFXi4wyjLaiNhvLZnJyl
 TlKbe4vqSNLwRMwojbBL6zZhLWp2lsnb+GtbgJDCor8r6SLVRzAevT8pgwG7Oc/FiPos
 6JpQ==
X-Gm-Message-State: AC+VfDzt54mulOuXtbi00EsjnkzqoRYX4Sz6wA1DMVbtvkDstgnZ2b/s
 8k5yMUQMH03sncTPZqczFmz0udz1KFUmegkEhD1OXg==
X-Google-Smtp-Source: ACHHUZ6pN4mIx0Lij1Jf3KwbZEGJs7CXgXYINvQ6v4MCKdF2b0XDrSglleH3o6UX0oPgOmP63QDOjA==
X-Received: by 2002:adf:fa42:0:b0:30a:a9ca:31d5 with SMTP id
 y2-20020adffa42000000b0030aa9ca31d5mr1613247wrr.2.1684921069271; 
 Wed, 24 May 2023 02:37:49 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b003077a19cf75sm13849100wri.60.2023.05.24.02.37.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:37:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 00/10] hw/virtio: Build various target-agnostic objects
 just once
Date: Wed, 24 May 2023 11:37:34 +0200
Message-Id: <20230524093744.88442-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

All patches reviewed.

Since v1:
- Addressed Richard & Thomas review comments
  . qemu_target_page_align() dropped
  . qemu_target_page_mask() returns signed
  . meson shuffle
- Collected R-b/T-b/A-b tags
- Dropped vhost-vdpa patch (to be posted as another series)

Less controvertial than my first approach [*] which caches
the access_is_big_endian value in VirtIODevice state, this
series just remove a unnecessary / pointless dependency on
"virtio-access.h", allowing to build various virtio objects
once for all targets.

[*] https://lore.kernel.org/qemu-devel/20221212230517.28872-11-philmd@linaro.org/

Philippe Mathieu-Daudé (10):
  softmmu: Introduce qemu_target_page_mask() helper
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

 include/exec/target_page.h      |  1 +
 hw/block/dataplane/virtio-blk.c |  1 -
 hw/s390x/virtio-ccw.c           |  1 -
 hw/scsi/vhost-scsi.c            |  1 -
 hw/scsi/vhost-user-scsi.c       |  1 -
 hw/scsi/virtio-scsi-dataplane.c |  1 -
 hw/virtio/vdpa-dev.c            |  1 -
 hw/virtio/vhost-vdpa.c          |  1 -
 hw/virtio/vhost-vsock-common.c  |  2 +-
 hw/virtio/vhost.c               |  1 -
 hw/virtio/virtio-crypto.c       |  1 -
 hw/virtio/virtio-iommu.c        |  4 ++--
 hw/virtio/virtio-mem.c          |  3 +--
 softmmu/physmem.c               |  5 +++++
 hw/block/dataplane/meson.build  |  2 +-
 hw/scsi/Kconfig                 |  6 ++++++
 hw/scsi/meson.build             | 20 +++++++++++++-------
 hw/virtio/Kconfig               |  6 ++++++
 hw/virtio/meson.build           | 14 ++++++++------
 19 files changed, 44 insertions(+), 28 deletions(-)

-- 
2.38.1


