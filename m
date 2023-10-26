Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07967D8128
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxsX-0007JE-IV; Thu, 26 Oct 2023 06:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsU-0007Ix-V9
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:14 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsQ-0001Gp-NJ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317170; x=1729853170;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K8d+Gq9OMnPI/24lBOrlnPCVlZcqr5oM2TtO6V1DcYo=;
 b=Rvvshwt9rmM0pyYSAm/nQ5fnD8cLfja9eBG8zURj0e5wSdb1cW6OxD31
 6bOVskYyOmQKvKzikeR8mn59fJY2UmnlzKTeGQ34P/SBSioaJ2Zz43g6E
 PmFAvCY2++J3fo00QhQWNlrHvcYqHtnKhwkqfvk9njxUMI+GShZMJCNW4
 cJ3yYGtetCjwgCM8dtZ1wgOKhiGNxza5BFAInK8y6oK4AfBslGfPn/AVy
 cqVsgGxw/SaFr7bkydbt46DA1AgYjRme+zWcuIH1GTom9XC5MFxoOLGqW
 33wQPIT+I8FTnkeCwYPRnfxUox0SpkzXdU5RPECbgCSJW3opIVbCZH3Tc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563165"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563165"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463541"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:45:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 00/37] vfio: Adopt iommufd
Date: Thu, 26 Oct 2023 18:30:27 +0800
Message-Id: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks all for giving guides and comments on previous series, here is
the v3 of pure iommufd support part.

Based on Cédric's suggestion, this series includes an effort to remove
spapr code from container.c, now all spapr functions are moved to spapr.c
or spapr_pci_vfio.c, but there are still a few trival check on
VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
callbacks and duplicate code just to remove them. Some functions are moved
to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
spapr_pci_vfio.c is arch specific, or else we need to introduce stub
functions to those spapr functions moved.


PATCH 1-5: Move spapr functions to spapr*.c
PATCH 6-18: Abstract out base container
PATCH 19-22: Introduce sparpr container and its specific interface
PATCH 23: Add --enable/--disable-iommufd config support
PATCH 24: Introduce iommufd object
PATCH 25-29: add IOMMUFD container and cdev support
PATCH 30-37: fd passing for IOMMUFD object and cdev


We have done wide test with different combinations, e.g:
- PCI device were tested
- FD passing and hot reset with some trick.
- device hotplug test with legacy and iommufd backends
- with or without vIOMMU for legacy and iommufd backends
- divices linked to different iommufds
- VFIO migration with a E800 net card(no dirty sync support) passthrough
- platform, ccw and ap were only compile-tested due to environment limit


Given some iommufd kernel limitations, the iommufd backend is
not yet fully on par with the legacy backend w.r.t. features like:
- p2p mappings (you will see related error traces)
- dirty page sync
- and etc.


qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v3
Based on vfio-next, commit id: fd0e1c8bc1

--------------------------------------------------------------------------

Below are some background and graph about the design:

With the introduction of iommufd, the Linux kernel provides a generic
interface for userspace drivers to propagate their DMA mappings to kernel
for assigned devices. This series does the porting of the VFIO devices
onto the /dev/iommu uapi and let it coexist with the legacy implementation.

At QEMU level, interactions with the /dev/iommu are abstracted by a new
iommufd object (compiled in with the CONFIG_IOMMUFD option).

Any QEMU device (e.g. vfio device) wishing to use /dev/iommu must be
linked with an iommufd object. In this series, the vfio-pci device is
granted with such capability (other VFIO devices are not yet ready):

It gets a new optional parameter named iommufd which allows to pass
an iommufd object:

    -object iommufd,id=iommufd0
    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0

Note the /dev/iommu and vfio cdev can be externally opened by a
management layer. In such a case the fd is passed:

    -object iommufd,id=iommufd0,fd=22
    -device vfio-pci,iommufd=iommufd0,fd=23

If the fd parameter is not passed, the fd is opened by QEMU.
See https://www.mail-archive.com/qemu-devel@nongnu.org/msg937155.html
for detailed discuss on this requirement.

If no iommufd option is passed to the vfio-pci device, iommufd is not
used and the end-user gets the behavior based on the legacy vfio iommu
interfaces:

    -device vfio-pci,host=0000:02:00.0

While the legacy kernel interface is group-centric, the new iommufd
interface is device-centric, relying on device fd and iommufd.

To support both interfaces in the QEMU VFIO device we reworked the vfio
container abstraction so that the generic VFIO code can use either
backend.

The VFIOContainer object becomes a base object derived into
a) the legacy VFIO container and
b) the new iommufd based container.

The base object implements generic code such as code related to
memory_listener and address space management whereas the derived
objects implement callbacks specific to either BE, legacy and
iommufd. Indeed each backend has its own way to setup secure context
and dma management interface. The below diagram shows how it looks
like with both BEs.

                    VFIO                           AddressSpace/Memory
    +-------+  +----------+  +-----+  +-----+
    |  pci  |  | platform |  |  ap |  | ccw |
    +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
        |           |           |        |        |   AddressSpace       |
        |           |           |        |        +------------+---------+
    +---V-----------V-----------V--------V----+               /
    |           VFIOAddressSpace              | <------------+
    |                  |                      |  MemoryListener
    |          VFIOContainer list             |
    +-------+----------------------------+----+
            |                            |
            |                            |
    +-------V------+            +--------V----------+
    |   iommufd    |            |    vfio legacy    |
    |  container   |            |     container     |
    +-------+------+            +--------+----------+
            |                            |
            | /dev/iommu                 | /dev/vfio/vfio
            | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
Userspace   |                            |
============+============================+===========================
Kernel      |  device fd                 |
            +---------------+            | group/container fd
            | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
            |  ATTACH_IOAS) |            | device fd
            |               |            |
            |       +-------V------------V-----------------+
    iommufd |       |                vfio                  |
(map/unmap  |       +---------+--------------------+-------+
ioas_copy)  |                 |                    | map/unmap
            |                 |                    |
     +------V------+    +-----V------+      +------V--------+
     | iommfd core |    |  device    |      |  vfio iommu   |
     +-------------+    +------------+      +---------------+

[Secure Context setup]
- iommufd BE: uses device fd and iommufd to setup secure context
              (bind_iommufd, attach_ioas)
- vfio legacy BE: uses group fd and container fd to setup secure context
                  (set_container, set_iommu)
[Device access]
- iommufd BE: device fd is opened through /dev/vfio/devices/vfioX
- vfio legacy BE: device fd is retrieved from group fd ioctl
[DMA Mapping flow]
1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
2. VFIO populates DMA map/unmap via the container BEs
   *) iommufd BE: uses iommufd
   *) vfio legacy BE: uses container fd


Changelog:
v3:
- Rename base container as VFIOContainerBase and legacy container as container (Cédric)
- Drop VFIO_IOMMU_BACKEND_OPS class and use struct instead (Cédric)
- Cleanup container.c by introducing spapr backend and move spapr code out (Cédric)
- Introduce vfio_iommu_spapr_ops (Cédric)
- Add doc of iommufd in qom.json and have iommufd member sorted (Markus)
- patch19 and patch21 are splitted to two parts to facilitate review

v2:
- patch "vfio: Add base container" in v1 is split into patch1-15 per Cédric
- add fd passing to platform/ap/ccw vfio device
- add (uintptr_t) cast in iommufd_backend_map_dma() per Cédric
- rename char_dev.h to chardev_open.h for same naming scheme per Daniel
- add full copyright per Daniel and Jason


Note changelog below are from full IOMMUFD series:

v1:
- Alloc hwpt instead of using auto hwpt
- elaborate iommufd code per Nicolin
- consolidate two patches and drop as.c
- typo error fix and function rename

rfcv4:
- rebase on top of v8.0.3
- Add one patch from Yi which is about vfio device add in kvm
- Remove IOAS_COPY optimization and focus on functions in this patchset
- Fix wrong name issue reported and fix suggested by Matthew
- Fix compilation issue reported and fix sugggsted by Nicolin
- Use query_dirty_bitmap callback to replace get_dirty_bitmap for better
granularity
- Add dev_iter_next() callback to avoid adding so many callback
  at container scope, add VFIODevice.hwpt to support that
- Restore all functions back to common from container whenever possible,
  mainly migration and reset related functions
- Add --enable/disable-iommufd config option, enabled by default in linux
- Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
- Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
- vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove
redundant code
- Add FD passing support for vfio device backed by IOMMUFD
- Fix hot unplug resource leak issue in vfio_legacy_detach_device()
- Fix FD leak in vfio_get_devicefd()

rfcv3:
- rebase on top of v7.2.0
- Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
  VFIO backends
- Fix use after free in error path, reported by Alister
- Split common.c in several steps to ease the review

rfcv2:
- remove the first three patches of rfcv1
- add open cdev helper suggested by Jason
- remove the QOMification of the VFIOContainer and simply use standard ops
(David)
- add "-object iommufd" suggested by Alex

Thanks
Zhenzhong

Eric Auger (11):
  vfio/container: Switch to dma_map|unmap API
  vfio/common: Move giommu_list in base container
  vfio/container: Move space field to base container
  vfio/container: Switch to IOMMU BE
    set_dirty_page_tracking/query_dirty_bitmap API
  vfio/container: Convert functions to base container
  vfio/container: Move vrdl_list, pgsizes and dma_max_mappings to base
    container
  vfio/container: Move listener to base container
  vfio/container: Move dirty_pgsizes and max_dirty_bitmap_size to base
    container
  vfio/container: Implement attach/detach_device
  backends/iommufd: Introduce the iommufd object
  vfio/pci: Allow the selection of a given iommu backend

Yi Liu (2):
  util/char_dev: Add open_cdev()
  vfio/iommufd: Implement the iommufd backend

Zhenzhong Duan (24):
  vfio/container: Move IBM EEH related functions into spapr_pci_vfio.c
  vfio/container: Move vfio_container_add/del_section_window into
    spapr.c
  vfio/container: Move spapr specific init/deinit into spapr.c
  vfio/spapr: Make vfio_spapr_create/remove_window static
  vfio/common: Move vfio_host_win_add/del into spapr.c
  vfio: Introduce base object for VFIOContainer and targetted interface
  vfio/container: Introduce a empty VFIOIOMMUOps
  vfio/container: Move per container device list in base container
  vfio/container: Move iova_ranges to base container
  vfio/spapr: Introduce spapr backend and target interface
  vfio/spapr: switch to spapr IOMMU BE add/del_section_window
  vfio/spapr: Move prereg_listener into spapr container
  vfio/spapr: Move hostwin_list into spapr container
  Add iommufd configure option
  vfio/iommufd: Switch to manual hwpt allocation
  vfio/iommufd: Add support for iova_ranges
  vfio/iommufd: Bypass EEH if iommufd backend
  vfio/pci: Extract out a helper vfio_pci_get_pci_hot_reset_info
  vfio/pci: Adapt vfio pci hot reset support with iommufd BE
  vfio/pci: Make vfio cdev pre-openable by passing a file handle
  vfio: Allow the selection of a given iommu backend for platform ap and
    ccw
  vfio/platform: Make vfio cdev pre-openable by passing a file handle
  vfio/ap: Make vfio cdev pre-openable by passing a file handle
  vfio/ccw: Make vfio cdev pre-openable by passing a file handle

 MAINTAINERS                           |  13 +
 meson.build                           |   6 +
 qapi/qom.json                         |  20 +
 include/hw/vfio/vfio-common.h         | 120 ++----
 include/hw/vfio/vfio-container-base.h | 126 ++++++
 include/hw/vfio/vfio-platform.h       |   1 +
 include/hw/vfio/vfio.h                |   7 -
 include/qemu/chardev_open.h           |  16 +
 include/sysemu/iommufd.h              |  46 +++
 backends/iommufd-stub.c               |  59 +++
 backends/iommufd.c                    | 268 ++++++++++++
 hw/ppc/spapr_pci_vfio.c               | 100 ++++-
 hw/vfio/ap.c                          |  38 +-
 hw/vfio/ccw.c                         |  40 +-
 hw/vfio/common.c                      | 323 +++++++--------
 hw/vfio/container-base.c              | 131 ++++++
 hw/vfio/container.c                   | 434 ++++----------------
 hw/vfio/helpers.c                     |  34 +-
 hw/vfio/iommufd.c                     | 562 ++++++++++++++++++++++++++
 hw/vfio/pci.c                         | 253 ++++++++++--
 hw/vfio/platform.c                    |  45 ++-
 hw/vfio/spapr.c                       | 293 ++++++++++++--
 util/chardev_open.c                   |  81 ++++
 backends/Kconfig                      |   4 +
 backends/meson.build                  |   5 +
 backends/trace-events                 |  12 +
 hw/vfio/meson.build                   |   4 +
 hw/vfio/trace-events                  |  17 +-
 meson_options.txt                     |   2 +
 qemu-options.hx                       |  13 +
 scripts/meson-buildoptions.sh         |   3 +
 util/meson.build                      |   1 +
 32 files changed, 2400 insertions(+), 677 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container-base.h
 delete mode 100644 include/hw/vfio/vfio.h
 create mode 100644 include/qemu/chardev_open.h
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 backends/iommufd-stub.c
 create mode 100644 backends/iommufd.c
 create mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/iommufd.c
 create mode 100644 util/chardev_open.c

-- 
2.34.1


