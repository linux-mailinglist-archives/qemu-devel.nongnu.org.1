Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4974CF4D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIloJ-0001X3-Di; Mon, 10 Jul 2023 03:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIloF-0001UF-L8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIloC-0003g0-QP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:59:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QzxHL40hKz4wxm;
 Mon, 10 Jul 2023 17:59:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QzxHK0Kxbz4wZt;
 Mon, 10 Jul 2023 17:59:40 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v2 00/11] vfio queue
Date: Mon, 10 Jul 2023 09:59:37 +0200
Message-ID: <20230710075937.459263-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:

  Merge tag 'pull-tcg-20230709' of https://gitlab.com/rth7680/qemu into staging (2023-07-09 15:01:43 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20230710

for you to fetch changes up to c00aac6f1428d40a4ca2ab9b89070afc2a5bf979:

  vfio/pci: Enable AtomicOps completers on root ports (2023-07-10 09:52:52 +0200)

----------------------------------------------------------------
vfio queue:

* Fixes in error handling paths of VFIO PCI devices
* Improvements of reported errors for VFIO migration
* Linux header update
* Enablement of AtomicOps completers on root ports
* Fix for unplug of passthrough AP devices

----------------------------------------------------------------
Alex Williamson (3):
      hw/vfio/pci-quirks: Sanitize capability pointer
      pcie: Add a PCIe capability version helper
      vfio/pci: Enable AtomicOps completers on root ports

Avihai Horon (1):
      vfio: Fix null pointer dereference bug in vfio_bars_finalize()

Cédric Le Goater (1):
      linux-headers: update to v6.5-rc1

Tony Krowiak (1):
      s390x/ap: Wire up the device request notifier interface

Zhenzhong Duan (5):
      vfio/pci: Disable INTx in vfio_realize error path
      vfio/migration: Change vIOMMU blocker from global to per device
      vfio/migration: Free resources when vfio_migration_realize fails
      vfio/migration: Remove print of "Migration disabled"
      vfio/migration: Return bool type for vfio_migration_realize()

Changes in v2:

 Fixed broken S-o-b in "linux-headers: update to v6.5-rc1" commit

 hw/vfio/pci.h                                  |   1 +
 include/hw/pci/pcie.h                          |   1 +
 include/hw/vfio/vfio-common.h                  |   5 +-
 include/standard-headers/drm/drm_fourcc.h      |  43 ++++++++
 include/standard-headers/linux/const.h         |   2 +-
 include/standard-headers/linux/pci_regs.h      |   1 +
 include/standard-headers/linux/vhost_types.h   |  16 +++
 include/standard-headers/linux/virtio_blk.h    |  18 ++--
 include/standard-headers/linux/virtio_config.h |   6 ++
 include/standard-headers/linux/virtio_net.h    |   1 +
 linux-headers/asm-arm64/bitsperlong.h          |  23 -----
 linux-headers/asm-arm64/kvm.h                  |  33 ++++++
 linux-headers/asm-generic/bitsperlong.h        |  13 ++-
 linux-headers/asm-generic/unistd.h             | 134 +++++++------------------
 linux-headers/asm-mips/unistd_n32.h            |   1 +
 linux-headers/asm-mips/unistd_n64.h            |   1 +
 linux-headers/asm-mips/unistd_o32.h            |   1 +
 linux-headers/asm-powerpc/unistd_32.h          |   1 +
 linux-headers/asm-powerpc/unistd_64.h          |   1 +
 linux-headers/asm-riscv/bitsperlong.h          |  13 ---
 linux-headers/asm-riscv/kvm.h                  | 134 ++++++++++++++++++++++++-
 linux-headers/asm-riscv/unistd.h               |   9 ++
 linux-headers/asm-s390/unistd_32.h             |   2 +
 linux-headers/asm-s390/unistd_64.h             |   2 +
 linux-headers/asm-x86/kvm.h                    |   3 +
 linux-headers/asm-x86/unistd_32.h              |   1 +
 linux-headers/asm-x86/unistd_64.h              |   1 +
 linux-headers/asm-x86/unistd_x32.h             |   1 +
 linux-headers/linux/const.h                    |   2 +-
 linux-headers/linux/kvm.h                      |  18 +++-
 linux-headers/linux/mman.h                     |  14 +++
 linux-headers/linux/psp-sev.h                  |   7 ++
 linux-headers/linux/userfaultfd.h              |  17 +++-
 linux-headers/linux/vfio.h                     |  27 +++++
 linux-headers/linux/vhost.h                    |  31 ++++++
 hw/pci/pcie.c                                  |   7 ++
 hw/vfio/ap.c                                   | 113 +++++++++++++++++++++
 hw/vfio/common.c                               |  51 +---------
 hw/vfio/migration.c                            |  51 +++++++---
 hw/vfio/pci-quirks.c                           |  10 +-
 hw/vfio/pci.c                                  |  91 ++++++++++++++++-
 41 files changed, 678 insertions(+), 229 deletions(-)

