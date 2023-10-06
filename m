Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2E7BB179
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeCO-00058P-DJ; Fri, 06 Oct 2023 02:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCJ-00056G-OT
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCF-0002eH-C6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1yvt6fXGz4xNq;
 Fri,  6 Oct 2023 17:20:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1yvs4S7vz4xGP;
 Fri,  6 Oct 2023 17:20:09 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/21] vfio queue
Date: Fri,  6 Oct 2023 08:19:44 +0200
Message-ID: <20231006062005.1040296-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cI0A=FU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20231006

for you to fetch changes up to 6e86aaef9ac57066aa923211a164df95b7b3cdf7:

  vfio/common: Move legacy VFIO backend code into separate container.c (2023-10-05 22:04:52 +0200)

----------------------------------------------------------------
vfio queue:

* Fix for VFIO display when using Intel vGPUs
* Support for dynamic MSI-X
* Preliminary work for IOMMUFD support

----------------------------------------------------------------
Alex Williamson (1):
      vfio/display: Fix missing update to set backing fields

Eric Auger (7):
      scripts/update-linux-headers: Add iommufd.h
      vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
      vfio/common: Introduce vfio_container_add|del_section_window()
      vfio/pci: Introduce vfio_[attach/detach]_device
      vfio/platform: Use vfio_[attach/detach]_device
      vfio/ap: Use vfio_[attach/detach]_device
      vfio/ccw: Use vfio_[attach/detach]_device

Jing Liu (4):
      vfio/pci: detect the support of dynamic MSI-X allocation
      vfio/pci: enable vector on dynamic MSI-X allocation
      vfio/pci: use an invalid fd to enable MSI-X
      vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation

Yi Liu (2):
      vfio/common: Move IOMMU agnostic helpers to a separate file
      vfio/common: Move legacy VFIO backend code into separate container.c

Zhenzhong Duan (7):
      vfio/pci: rename vfio_put_device to vfio_pci_put_device
      linux-headers: Add iommufd.h
      vfio/common: Extract out vfio_kvm_device_[add/del]_fd
      vfio/common: Move VFIO reset handler registration to a group agnostic function
      vfio/common: Introduce a per container device list
      vfio/common: Store the parent container in VFIODevice
      vfio/common: Introduce a global VFIODevice list

 hw/vfio/pci.h                   |    1 +
 include/hw/vfio/vfio-common.h   |   60 +-
 linux-headers/linux/iommufd.h   |  444 +++++++++
 hw/vfio/ap.c                    |   69 +-
 hw/vfio/ccw.c                   |  122 +--
 hw/vfio/common.c                | 1885 +++------------------------------------
 hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
 hw/vfio/display.c               |    2 +
 hw/vfio/helpers.c               |  612 +++++++++++++
 hw/vfio/pci.c                   |  194 ++--
 hw/vfio/platform.c              |   43 +-
 hw/vfio/meson.build             |    2 +
 hw/vfio/trace-events            |    6 +-
 scripts/update-linux-headers.sh |    3 +-
 14 files changed, 2580 insertions(+), 2024 deletions(-)
 create mode 100644 linux-headers/linux/iommufd.h
 create mode 100644 hw/vfio/container.c
 create mode 100644 hw/vfio/helpers.c

