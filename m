Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903F819057
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:07:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHD-0001uG-4B; Tue, 19 Dec 2023 13:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHB-0001u1-DP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:09 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfH8-0006wg-PL
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmC0273Zz4wxx;
 Wed, 20 Dec 2023 05:57:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmBv6j2Kz4wcJ;
 Wed, 20 Dec 2023 05:56:55 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/47] vfio queue
Date: Tue, 19 Dec 2023 19:55:56 +0100
Message-ID: <20231219185643.725448-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

The following changes since commit bd00730ec0f621706d0179768436f82c39048499:

  Open 9.0 development tree (2023-12-19 09:46:22 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20231219

for you to fetch changes up to 4278df9d1d2383b738338c857406357660f11e42:

  hw/ppc/Kconfig: Imply VFIO_PCI (2023-12-19 19:03:38 +0100)

----------------------------------------------------------------
vfio queue:

* Introduce an IOMMU interface backend for VFIO devices
* Convert IOMMU type1 and sPAPR IOMMU to respective backends
* Introduce a new IOMMUFD backend for ARM, x86_64 and s390x platforms

----------------------------------------------------------------
Cédric Le Goater (4):
      hw/arm: Activate IOMMUFD for virt machines
      kconfig: Activate IOMMUFD for s390x machines
      hw/i386: Activate IOMMUFD for q35 machines
      hw/ppc/Kconfig: Imply VFIO_PCI

Eric Auger (11):
      vfio/container: Switch to dma_map|unmap API
      vfio/common: Move giommu_list in base container
      vfio/container: Move space field to base container
      vfio/container: Switch to IOMMU BE set_dirty_page_tracking/query_dirty_bitmap API
      vfio/container: Convert functions to base container
      vfio/container: Move pgsizes and dma_max_mappings to base container
      vfio/container: Move listener to base container
      vfio/container: Move dirty_pgsizes and max_dirty_bitmap_size to base container
      vfio/container: Implement attach/detach_device
      backends/iommufd: Introduce the iommufd object
      vfio/pci: Allow the selection of a given iommu backend

Yi Liu (2):
      util/char_dev: Add open_cdev()
      vfio/iommufd: Implement the iommufd backend

Zhenzhong Duan (30):
      vfio: Introduce base object for VFIOContainer and targeted interface
      vfio/container: Introduce a empty VFIOIOMMUOps
      vfio/common: Introduce vfio_container_init/destroy helper
      vfio/container: Move per container device list in base container
      vfio/container: Move vrdl_list to base container
      vfio/container: Move iova_ranges to base container
      vfio/spapr: Introduce spapr backend and target interface
      vfio/spapr: switch to spapr IOMMU BE add/del_section_window
      vfio/spapr: Move prereg_listener into spapr container
      vfio/spapr: Move hostwin_list into spapr container
      vfio/common: return early if space isn't empty
      vfio/iommufd: Relax assert check for iommufd backend
      vfio/iommufd: Add support for iova_ranges and pgsizes
      vfio/pci: Extract out a helper vfio_pci_get_pci_hot_reset_info
      vfio/pci: Introduce a vfio pci hot reset interface
      vfio/iommufd: Enable pci hot reset through iommufd cdev interface
      vfio/pci: Make vfio cdev pre-openable by passing a file handle
      vfio/platform: Allow the selection of a given iommu backend
      vfio/platform: Make vfio cdev pre-openable by passing a file handle
      vfio/ap: Allow the selection of a given iommu backend
      vfio/ap: Make vfio cdev pre-openable by passing a file handle
      vfio/ccw: Allow the selection of a given iommu backend
      vfio/ccw: Make vfio cdev pre-openable by passing a file handle
      vfio: Make VFIOContainerBase poiner parameter const in VFIOIOMMUOps callbacks
      vfio/pci: Move VFIODevice initializations in vfio_instance_init
      vfio/platform: Move VFIODevice initializations in vfio_platform_instance_init
      vfio/ap: Move VFIODevice initializations in vfio_ap_instance_init
      vfio/ccw: Move VFIODevice initializations in vfio_ccw_instance_init
      vfio: Introduce a helper function to initialize VFIODevice
      docs/devel: Add VFIO iommufd backend documentation

 MAINTAINERS                           |  11 +
 docs/devel/index-internals.rst        |   1 +
 docs/devel/vfio-iommufd.rst           | 166 +++++++++
 qapi/qom.json                         |  19 +
 hw/vfio/pci.h                         |   6 +
 include/hw/vfio/vfio-common.h         |  96 ++----
 include/hw/vfio/vfio-container-base.h | 121 +++++++
 include/qemu/chardev_open.h           |  16 +
 include/sysemu/iommufd.h              |  38 ++
 backends/iommufd.c                    | 245 +++++++++++++
 hw/ppc/spapr_pci_vfio.c               |  46 ++-
 hw/vfio/ap.c                          |  47 ++-
 hw/vfio/ccw.c                         |  53 ++-
 hw/vfio/common.c                      | 261 ++++++++------
 hw/vfio/container-base.c              | 101 ++++++
 hw/vfio/container.c                   | 329 +++++++++++++-----
 hw/vfio/helpers.c                     |  54 +++
 hw/vfio/iommufd.c                     | 630 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                         | 218 +++---------
 hw/vfio/platform.c                    |  44 ++-
 hw/vfio/spapr.c                       | 108 ++++--
 util/chardev_open.c                   |  81 +++++
 backends/Kconfig                      |   4 +
 backends/meson.build                  |   1 +
 backends/trace-events                 |  10 +
 hw/arm/Kconfig                        |   1 +
 hw/i386/Kconfig                       |   1 +
 hw/ppc/Kconfig                        |   2 +-
 hw/s390x/Kconfig                      |   1 +
 hw/vfio/meson.build                   |   4 +
 hw/vfio/trace-events                  |  15 +-
 qemu-options.hx                       |  12 +
 util/meson.build                      |   1 +
 33 files changed, 2229 insertions(+), 514 deletions(-)
 create mode 100644 docs/devel/vfio-iommufd.rst
 create mode 100644 include/hw/vfio/vfio-container-base.h
 create mode 100644 include/qemu/chardev_open.h
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 backends/iommufd.c
 create mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/iommufd.c
 create mode 100644 util/chardev_open.c

