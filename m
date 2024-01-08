Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92C8268A3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk85-00034C-SE; Mon, 08 Jan 2024 02:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk7x-00032d-Ar
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:32:53 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk7r-0004Yc-DO
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:32:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m471Wdlz4wd4;
 Mon,  8 Jan 2024 18:32:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m454lQDz4wcc;
 Mon,  8 Jan 2024 18:32:37 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/17] vfio queue
Date: Mon,  8 Jan 2024 08:32:15 +0100
Message-ID: <20240108073232.118228-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d37328:

  Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into staging (2024-01-05 16:08:58 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240107

for you to fetch changes up to 19368b1905b4b917e915526fcbd5bfa3f7439451:

  backends/iommufd: Remove mutex (2024-01-05 21:25:20 +0100)

----------------------------------------------------------------
vfio queue:

* Minor cleanups
* Fix for a regression in device reset introduced in 8.2
* Coverity fixes, including the removal of the iommufd backend mutex
* Introduced VFIOIOMMUClass, to avoid compiling spapr when !CONFIG_PSERIES

----------------------------------------------------------------
Avihai Horon (1):
      vfio/migration: Add helper function to set state or reset device

Cédric Le Goater (14):
      vfio/spapr: Extend VFIOIOMMUOps with a release handler
      vfio/container: Introduce vfio_legacy_setup() for further cleanups
      vfio/container: Initialize VFIOIOMMUOps under vfio_init_container()
      vfio/container: Introduce a VFIOIOMMU QOM interface
      vfio/container: Introduce a VFIOIOMMU legacy QOM interface
      vfio/container: Intoduce a new VFIOIOMMUClass::setup handler
      vfio/spapr: Introduce a sPAPR VFIOIOMMU QOM interface
      vfio/iommufd: Introduce a VFIOIOMMU iommufd QOM interface
      vfio/spapr: Only compile sPAPR IOMMU support when needed
      vfio/iommufd: Remove CONFIG_IOMMUFD usage
      vfio/container: Replace basename with g_path_get_basename
      vfio/iommufd: Remove the use of stat() to check file existence
      backends/iommufd: Remove check on number of backend users
      backends/iommufd: Remove mutex

Volker Rümelin (1):
      hw/vfio: fix iteration over global VFIODevice list

Zhenzhong Duan (1):
      vfio/container: Rename vfio_init_container to vfio_set_iommu

 include/hw/vfio/vfio-common.h         |   2 -
 include/hw/vfio/vfio-container-base.h |  27 +++++-
 include/sysemu/iommufd.h              |   2 -
 backends/iommufd.c                    |  12 ---
 hw/vfio/common.c                      |  19 +++--
 hw/vfio/container-base.c              |  12 ++-
 hw/vfio/container.c                   | 153 +++++++++++++++++++++-------------
 hw/vfio/iommufd.c                     |  41 +++++----
 hw/vfio/migration.c                   |  41 ++++-----
 hw/vfio/pci.c                         |   2 +-
 hw/vfio/spapr.c                       |  60 +++++++------
 hw/vfio/meson.build                   |   2 +-
 12 files changed, 222 insertions(+), 151 deletions(-)

