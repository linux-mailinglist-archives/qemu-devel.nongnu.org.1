Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D17E272C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:41:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jJ-0004Ua-MH; Mon, 06 Nov 2023 09:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00j6-0003ak-1E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:16 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00iy-0000l4-Go
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDSr5F9nz4xWQ;
 Tue,  7 Nov 2023 01:37:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDSq1wxqz4xjN;
 Tue,  7 Nov 2023 01:36:58 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/22] vfio queue
Date: Mon,  6 Nov 2023 15:36:31 +0100
Message-ID: <20231106143653.302391-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20231106

for you to fetch changes up to a2347c60a86a7c2a227ebab186a195d16e1e3901:

  vfio/common: Move vfio_host_win_add/del into spapr.c (2023-11-06 13:23:23 +0100)

----------------------------------------------------------------
vfio queue:

* Support for non 64b IOVA space
* Introduction of a PCIIOMMUOps callback structure to ease future
  extensions
* Fix for a buffer overrun when writing the VF token
* PPC cleanups preparing ground for IOMMUFD support

----------------------------------------------------------------
Cédric Le Goater (4):
      util/uuid: Add UUID_STR_LEN definition
      vfio/pci: Fix buffer overrun when writing the VF token
      util/uuid: Remove UUID_FMT_LEN
      util/uuid: Define UUID_STR_LEN from UUID_NONE string

Eric Auger (12):
      memory: Let ReservedRegion use Range
      memory: Introduce memory_region_iommu_set_iova_ranges
      vfio: Collect container iova range info
      virtio-iommu: Rename reserved_regions into prop_resv_regions
      range: Make range_compare() public
      util/reserved-region: Add new ReservedRegion helpers
      virtio-iommu: Introduce per IOMMUDevice reserved regions
      range: Introduce range_inverse_array()
      virtio-iommu: Record whether a probe request has been issued
      virtio-iommu: Implement set_iova_ranges() callback
      virtio-iommu: Consolidate host reserved regions and property set ones
      test: Add some tests for range and resv-mem helpers

Yi Liu (1):
      hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps

Zhenzhong Duan (5):
      vfio/container: Move IBM EEH related functions into spapr_pci_vfio.c
      vfio/container: Move vfio_container_add/del_section_window into spapr.c
      vfio/container: Move spapr specific init/deinit into spapr.c
      vfio/spapr: Make vfio_spapr_create/remove_window static
      vfio/common: Move vfio_host_win_add/del into spapr.c

 docs/devel/index-api.rst         |   1 +
 docs/devel/pci.rst               |   8 +
 include/exec/memory.h            |  36 ++++-
 include/hw/pci/pci.h             |  36 ++++-
 include/hw/pci/pci_bus.h         |   2 +-
 include/hw/vfio/vfio-common.h    |  16 +-
 include/hw/vfio/vfio.h           |   7 -
 include/hw/virtio/virtio-iommu.h |   7 +-
 include/qemu/range.h             |  14 ++
 include/qemu/reserved-region.h   |  32 ++++
 include/qemu/uuid.h              |   5 +-
 block/parallels-ext.c            |   2 +-
 block/vdi.c                      |   2 +-
 hw/alpha/typhoon.c               |   6 +-
 hw/arm/smmu-common.c             |   6 +-
 hw/core/qdev-properties-system.c |  11 +-
 hw/hyperv/vmbus.c                |   4 +-
 hw/i386/amd_iommu.c              |   6 +-
 hw/i386/intel_iommu.c            |   6 +-
 hw/pci-host/astro.c              |   6 +-
 hw/pci-host/designware.c         |   6 +-
 hw/pci-host/dino.c               |   6 +-
 hw/pci-host/pnv_phb3.c           |   6 +-
 hw/pci-host/pnv_phb4.c           |   6 +-
 hw/pci-host/ppce500.c            |   6 +-
 hw/pci-host/raven.c              |   6 +-
 hw/pci-host/sabre.c              |   6 +-
 hw/pci/pci.c                     |  18 ++-
 hw/ppc/ppc440_pcix.c             |   6 +-
 hw/ppc/spapr_pci.c               |   6 +-
 hw/ppc/spapr_pci_vfio.c          | 100 +++++++++++-
 hw/remote/iommu.c                |   6 +-
 hw/s390x/s390-pci-bus.c          |   8 +-
 hw/vfio/ap.c                     |   1 -
 hw/vfio/ccw.c                    |   1 -
 hw/vfio/common.c                 |  80 ++--------
 hw/vfio/container.c              | 328 ++++++---------------------------------
 hw/vfio/helpers.c                |   1 -
 hw/vfio/pci.c                    |   2 +-
 hw/vfio/spapr.c                  | 282 +++++++++++++++++++++++++++++++--
 hw/virtio/virtio-iommu-pci.c     |   8 +-
 hw/virtio/virtio-iommu.c         | 161 +++++++++++++++++--
 migration/savevm.c               |   4 +-
 system/memory.c                  |  13 ++
 tests/unit/test-resv-mem.c       | 316 +++++++++++++++++++++++++++++++++++++
 tests/unit/test-uuid.c           |   2 +-
 util/range.c                     |  61 +++++++-
 util/reserved-region.c           |  91 +++++++++++
 util/uuid.c                      |   2 +-
 hw/virtio/trace-events           |   1 +
 tests/unit/meson.build           |   1 +
 util/meson.build                 |   1 +
 52 files changed, 1303 insertions(+), 452 deletions(-)
 create mode 100644 docs/devel/pci.rst
 delete mode 100644 include/hw/vfio/vfio.h
 create mode 100644 include/qemu/reserved-region.h
 create mode 100644 tests/unit/test-resv-mem.c
 create mode 100644 util/reserved-region.c

