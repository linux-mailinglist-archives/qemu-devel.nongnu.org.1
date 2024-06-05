Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C528FC688
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jun 2024 10:34:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5D-0001Cj-JU; Wed, 05 Jun 2024 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5B-0001CR-Bb
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:21 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm57-0005yS-W2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576398; x=1749112398;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O3esBEbDq4gVnm179e06sZ6fP6C5rcTaaLBYavrneFk=;
 b=ZFg+ktNiKAkD8UxypNW/j2z12jTMma1uyDhtD1yE67aC+J15ZMnqSqo1
 s1NW+zPH3reM/Z8+92H4x2IBNR4VLq6XD72xNIFgsdr/hcKQitvDPVcO9
 SK3zhoE8+0le8nQtu7rviyh63XcxEqamlwGxFeJ83zM3B0uMChXY2fsN0
 u+l/ABAiT/9PlSr5deFgx6dxObUu8ml2kVnKnMYvjQ1GLOobW4KLNxSqc
 33ODf7n4icY5nX5tTUbEDEez/F8JX9LX0Yg/z2D7T77R0sjB1JZTSmbYS
 aRbhGJ6xb3O+J0ctV9+fIZadMG9Cf1hS+T3IJk8J2sZBYI9+C6Ykf9uAn w==;
X-CSE-ConnectionGUID: VX669lFbRmqQSTojLHr3bQ==
X-CSE-MsgGUID: 3ml/hrWRR2q1jA8g4WSFBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575286"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575286"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:14 -0700
X-CSE-ConnectionGUID: mRtxg75lTe26fgkw+OXAgw==
X-CSE-MsgGUID: y5G/w0XIQGmeLtQBR8YsNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954737"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 00/17] Add a host IOMMU device abstraction to check with
 vIOMMU
Date: Wed,  5 Jun 2024 16:30:26 +0800
Message-Id: <20240605083043.317831-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This series introduce a HostIOMMUDevice abstraction and sub-classes.
Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
between vIOMMU and HostIOMMUDevice.

A HostIOMMUDevice is an abstraction for an assigned device that is protected
by a physical IOMMU (aka host IOMMU). The userspace interaction with this
physical IOMMU can be done either through the VFIO IOMMU type 1 legacy
backend or the new iommufd backend. The assigned device can be a VFIO device
or a VDPA device. The HostIOMMUDevice is needed to interact with the host
IOMMU that protects the assigned device. It is especially useful when the
device is also protected by a virtual IOMMU as this latter use the translation
services of the physical IOMMU and is constrained by it. In that context the
HostIOMMUDevice can be passed to the virtual IOMMU to collect physical IOMMU
capabilities such as the supported address width. In the future, the virtual
IOMMU will use the HostIOMMUDevice to program the guest page tables in the
first translation stage of the physical IOMMU.

HostIOMMUDeviceClass::realize() is introduced to initialize
HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.

HostIOMMUDeviceClass::get_cap() is introduced to query host IOMMU
device capabilities.

The class tree is as below:

                              HostIOMMUDevice
                                     | .caps
                                     | .realize()
                                     | .get_cap()
                                     |
            .-----------------------------------------------.
            |                        |                      |
HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
            |                        |                      | [.iommufd]
                                                            | [.devid]
                                                            | [.ioas_id]
                                                            | [.attach_hwpt()]
                                                            | [.detach_hwpt()]
                                                            |
                                            .----------------------.
                                            |                      |
                         HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
                                          | [.vdev]                | {.vdev}

* The attributes in [] will be implemented in nesting series.
* The classes in {} will be implemented in future.
* .vdev in different class points to different agent device,
* i.e., VFIODevice or VDPADevice.

PATCH1-4: Introduce HostIOMMUDevice and its sub classes
PATCH5-10: Implement .realize() and .get_cap() handler
PATCH11-14: Create HostIOMMUDevice instance and pass to vIOMMU
PATCH15-17: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)

Test done:
make check
vfio device hotplug/unplug with different backend on linux
reboot, kexec
build test on linux and windows11

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v7

Besides the compatibility check in this series, in nesting series, this
host IOMMU device is extended for much wider usage. For anyone interested
on the nesting series, here is the link:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
v7:
- drop config CONFIG_HOST_IOMMU_DEVICE (Cédric)
- introduce HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX (Eric)
- use iova_ranges method in iommufd.realize() (Eric)
- introduce HostIOMMUDevice::name to facilitate tracing (Eric)
- implement a custom destroy hash function (Cédric)
- drop VTDHostIOMMUDevice and save HostIOMMUDevice in hash table (Eric)
- move patch5 after patch1 (Eric)
- squash patch3 and 4, squash patch12 and 13 (Eric)
- refine comments (Eric)
- collect Eric's R-B

v6:
- open coded host_iommu_device_get_cap() to avoid #ifdef in intel_iommu.c (Cédric)

v5:
- pci_device_set_iommu_device return true (Cédric)
- fix build failure on windows (thanks Cédric found that issue)

v4:
- move properties vdev, iommufd and devid to nesting series where need it (Cédric)
- fix 32bit build with clz64 (Cédric)
- change check_cap naming to get_cap (Cédric)
- return bool if error is passed through errp (Cédric)
- drop HostIOMMUDevice[LegacyVFIO|IOMMUFD|IOMMUFDVFIO] declaration (Cédric)
- drop HOST_IOMMU_DEVICE_CAP_IOMMUFD (Cédric)
- replace include directive with forward declaration (Cédric)

v3:
- refine declaration and doc for HostIOMMUDevice (Cédric, Philippe)
- introduce HostIOMMUDeviceCaps, .realize() and .check_cap() (Cédric)
- introduce helper range_get_last_bit() for range operation (Cédric)
- separate pci_device_get_iommu_bus_devfn() in a prereq patch (Cédric)
- replace HIOD_ abbreviation with HOST_IOMMU_DEVICE_ (Cédric)
- add header in include/sysemu/iommufd.h (Cédric)

v2:
- use QOM to abstract host IOMMU device and its sub-classes (Cédric)
- move host IOMMU device creation in attach_device() (Cédric)
- refine pci_device_set/unset_iommu_device doc further (Eric)
- define host IOMMU info format of different backend
- implement get_host_iommu_info() for different backend (Cédric)
- drop cap/ecap update logic (MST)
- check aw-bits from get_host_iommu_info() in legacy mode

v1:
- use HostIOMMUDevice handle instead of union in VFIODevice (Eric)
- change host_iommu_device_init to host_iommu_device_create
- allocate HostIOMMUDevice in host_iommu_device_create callback
  and set the VFIODevice base_hdev handle (Eric)
- refine pci_device_set/unset_iommu_device doc (Eric)
- use HostIOMMUDevice handle instead of union in VTDHostIOMMUDevice (Eric)
- convert HostIOMMUDevice to sub object pointer in vtd_check_hdev

rfcv2:
- introduce common abstract HostIOMMUDevice and sub struct for different BEs (Eric, Cédric)
- remove iommufd_device.[ch] (Cédric)
- remove duplicate iommufd/devid define from VFIODevice (Eric)
- drop the p in aliased_pbus and aliased_pdevfn (Eric)
- assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (Cédric, Eric)
- use errp in iommufd_device_get_info (Eric)
- split and simplify cap/ecap check/sync code in intel_iommu.c (Cédric)
- move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (Cédric)
- make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (Cédric)
- block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
- add R-B

Yi Liu (2):
  hw/pci: Introduce pci_device_[set|unset]_iommu_device()
  intel_iommu: Implement [set|unset]_iommu_device() callbacks

Zhenzhong Duan (15):
  backends: Introduce HostIOMMUDevice abstract
  backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
  vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
  backends/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO]
    devices
  range: Introduce range_get_last_bit()
  vfio/container: Implement HostIOMMUDeviceClass::realize() handler
  backends/iommufd: Introduce helper function
    iommufd_backend_get_device_info()
  vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
  vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
  backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
  vfio: Create host IOMMU device instance
  hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
  vfio/pci: Pass HostIOMMUDevice to vIOMMU
  intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
  intel_iommu: Check compatibility with host IOMMU capabilities

 MAINTAINERS                           |   2 +
 include/hw/i386/intel_iommu.h         |   2 +
 include/hw/pci/pci.h                  |  38 ++++-
 include/hw/vfio/vfio-common.h         |   8 +
 include/hw/vfio/vfio-container-base.h |   3 +
 include/qemu/range.h                  |  11 ++
 include/sysemu/host_iommu_device.h    |  91 ++++++++++++
 include/sysemu/iommufd.h              |  19 +++
 backends/host_iommu_device.c          |  33 +++++
 backends/iommufd.c                    |  76 ++++++++--
 hw/i386/intel_iommu.c                 | 203 ++++++++++++++++++++------
 hw/pci/pci.c                          |  75 +++++++++-
 hw/vfio/common.c                      |  16 +-
 hw/vfio/container.c                   |  41 +++++-
 hw/vfio/helpers.c                     |  17 +++
 hw/vfio/iommufd.c                     |  37 ++++-
 hw/vfio/pci.c                         |  19 ++-
 backends/meson.build                  |   1 +
 18 files changed, 623 insertions(+), 69 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

-- 
2.34.1


