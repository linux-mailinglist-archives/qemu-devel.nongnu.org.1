Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B782D701
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:17:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1D-0007fP-99; Mon, 15 Jan 2024 05:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1B-0007fA-2l
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:33 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK18-0007OK-Sw
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313790; x=1736849790;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zEE3smuX5+p0r2N/zIkIQdAcWpRUx2aKWK0qCb/xbLg=;
 b=fDlQMFghdQEKZmu+2njmZLDO9W5UJAUp80lhr2rAO32wLfB1IP6r+Kxz
 mzgey5j3IYGbHqmzKjLqjqfpbs4C01M8ftm5+SVFgkBLEhGKM7P0Zg/G/
 68nc5WlSTiaNkTf+qrhke8fMJpM6uPx1RNlOc0PMK9OhpdFXLXJa5HHyK
 G78L7W2ekX5A+jfCRL9VRb2mG0l094ZdGn4EJgCLULHDiag+O7pydL2DB
 LD/ysMwiDiouQHOv53pw3nxNzlrt+xh6Nx3B/jfT2rn80ep0z9eQu4ECF
 REYNgiCg9VfMK94dIfB8081azFE1CI9AHAS5Y3Bb7PKRlNkbyWcPbiw3O g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032413"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032413"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599477"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599477"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:20 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv1 0/6] Check and sync host IOMMU cap/ecap with vIOMMU
Date: Mon, 15 Jan 2024 18:13:07 +0800
Message-Id: <20240115101313.131139-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

This introduces a framework for vIOMMU to get hw IOMMU cap/ecap information
through IOMMUFD interface and check or sync with vIOMMU's own cap/ecap
config.

This framework works by having device side, i.e. VFIO, register a
IOMMUFDDevice to vIOMMU, IOMMUFDDevice includes necessary data to
archive that. Currently only VFIO device is supported, but it
could also be used for other devices, i.e., VDPA.

This is also a prerequisite for incoming iommufd nesting series:
'intel_iommu: Enable stage-1 translation'.

PATCH1-4: initialize IOMMUFDDevice and pass to vIOMMU
PATCH5-6: cap/ecap sync mechanism between host IOMMU and vIOMMU

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_rfcv1

Thanks
Zhenzhong

Yi Liu (3):
  hw/pci: introduce pci_device_set/unset_iommu_device()
  intel_iommu: add set/unset_iommu_device callback
  intel_iommu: add a framework to check and sync host IOMMU cap/ecap

Zhenzhong Duan (3):
  backends/iommufd_device: introduce IOMMUFDDevice
  vfio: initialize IOMMUFDDevice and pass to vIOMMU
  intel_iommu: extract out vtd_cap_init to initialize cap/ecap

 MAINTAINERS                     |   4 +-
 include/hw/i386/intel_iommu.h   |  14 ++
 include/hw/pci/pci.h            |  39 +++++-
 include/hw/vfio/vfio-common.h   |   2 +
 include/sysemu/iommufd_device.h |  31 +++++
 backends/iommufd_device.c       |  50 +++++++
 hw/i386/intel_iommu.c           | 239 ++++++++++++++++++++++++++------
 hw/pci/pci.c                    |  49 ++++++-
 hw/vfio/iommufd.c               |   2 +
 hw/vfio/pci.c                   |  24 +++-
 backends/meson.build            |   2 +-
 11 files changed, 402 insertions(+), 54 deletions(-)
 create mode 100644 include/sysemu/iommufd_device.h
 create mode 100644 backends/iommufd_device.c

-- 
2.34.1


