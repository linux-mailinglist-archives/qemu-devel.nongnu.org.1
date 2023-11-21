Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB5E7F27DC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MOv-00061q-KB; Tue, 21 Nov 2023 03:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MOl-00061O-Pt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:24 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MOi-0001Nv-Kh
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556380; x=1732092380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I1l56jAX44CXhQ223qB9R3C93SwXVH7zI1UlAS1YKOs=;
 b=IQpgexHNCl7QVIGj+BkfsoBBGg3onCRw6rdN0bxrjFBPO1C5B7qB0m42
 EAjc3YrRsyqVRkwIFRB12b6dyxwzkROH6yp1vBC1awDE/k3F2eQjs6W3G
 gLhj/vypeCbmsfJcJ6OpJVhsaG4JieYoXCgXiYx0qXF2UEHqBAc7XGCgZ
 a2LmWt1seLtp3DhMM7LBIWp8cPMVi1Nzz8uPpb2Jlep8kaNQJ6DoyXQLX
 OUnQdIoNR+Iu1X7LwReRn2EgVuL7Hd6yQufaDg/qUPSO0lNBGREhRojpd
 aizvUo42uH+n7VA1yFn5v/0d85rK3yD1g91OaUiERxQm53AcrGEDxfJeC w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395721947"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395721947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124815"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124815"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:14 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 00/27] vfio: Adopt iommufd
Date: Tue, 21 Nov 2023 16:43:59 +0800
Message-Id: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Thanks all for giving guides and comments on previous series, this is
the remaining part of the iommufd support.

Besides suggested changes in v6, I'd like to highlight two changes
for final review:
1. Instantiate can_be_deleted callback to fix race where iommufd object
   can be deleted before vfio device
2. After careful re-thinking, I'd like to follow Nicolin's suggestion in v5,
   remove is_ioas check which indeed looks heavy just for tracepoint.
   In fact we can get corresponding info by looking over trace context.

PATCH 1: Introduce iommufd object
PATCH 2-9: add IOMMUFD container and cdev support
PATCH 10-17: fd passing for cdev and linking to IOMMUFD
PATCH 18: make VFIOContainerBase parameter const
PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
PATCH 22-26: vfio device init code cleanup
PATCH 27: add iommufd doc


We have done wide test with different combinations, e.g:
- PCI device were tested
- FD passing and hot reset with some trick.
- device hotplug test with legacy and iommufd backends
- with or without vIOMMU for legacy and iommufd backends
- divices linked to different iommufds
- VFIO migration with a E800 net card(no dirty sync support) passthrough
- platform, ccw and ap were only compile-tested due to environment limit
- test mdev pass through with mtty and mix with real device and different BE
- test iommufd object hotplug/unplug and mix with vfio device plug/unplug

Given some iommufd kernel limitations, the iommufd backend is
not yet fully on par with the legacy backend w.r.t. features like:
- p2p mappings (you will see related error traces)
- dirty page sync
- and etc.


qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v7
Based on vfio-next, commit id: c487fb8a50

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
v7:
- Add iommufd doc (Cedric)
- Abstract iommufd_cdev_get_realized_vpdev in hot reset code (Eric)
- Add docs for vfio_device_get_name and return bool (Philippe)
- Remove is_ioas parameter (Nicolin)
- Include the general cleanup patchset in this series
- Instantiate can_be_deleted callback
- qom.json (Since: 8.2) -> (Since: 9.0)
- Add new R-b, T-b from Eric

v6:
- simplify CONFIG_IOMMUFD checking code further (Cédric)
- check iommufd_cdev_kvm_device_add return value (Cédric)
- dirrectory -> directory (Cédric)
- propagate iommufd_cdev_get_info_iova_range err and print as warning (Cédric)
- introduce a helper vfio_device_set_fd (Cédric)
- Move #include "sysemu/iommufd.h" in platform.c (Cédric)
- simplify iommufd backend uAPI, remove alloc_hwpt, get/put_ioas
- Remove CONFIG_IOMMUFD check in meson.build and treat iommufd.c general
- Add Matthew and Cédric's RB

v5:
- Change to use Kconfig for CONFIG_IOMMUFD and drop stub file (Cédric)
- Add (uintptr_t) to info->allowed_iovas (Cédric)
- Switch to IOAS attach/detach and hide hwpt (Jason)
- move chardev_open.[h|c] under the IOMMUFD entry (Cédric)
- Move vfio_legacy_pci_hot_reset into container.c (Cédric)
- Add missed pgsizes initialization in vfio_get_info_iova_range
- split linking iommufd patch into three to be cleaner
- Fix comments on PCI BAR unmap

v4:
- add CONFIG_IOMMUFD check for IOMMUFDProperties (Markus)
- add doc for default case without fd (Markus)
- Fix build issue reported by Markus and Cédric
- Simply use SPDX identifier in new file (Cédric)
- make vfio_container_init/destroy helper a seperate patch (Cédric)
- make vrdl_list movement a seperate patch (Cédric)
- add const for some callback parameters (Cédric)
- add g_assert in VFIOIOMMUOps callback (Cédric)
- introduce pci_hot_reset callback (Cédric)
- remove VFIOIOMMUSpaprOps (Cédric)
- initialize g_autofree to NULL (Cédric)
- adjust func name prefix and trace event in iommufd.c (Cédric)
- add RB

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


Cédric Le Goater (3):
  hw/arm: Activate IOMMUFD for virt machines
  kconfig: Activate IOMMUFD for s390x machines
  hw/i386: Activate IOMMUFD for q35 machines

Eric Auger (2):
  backends/iommufd: Introduce the iommufd object
  vfio/pci: Allow the selection of a given iommu backend

Yi Liu (2):
  util/char_dev: Add open_cdev()
  vfio/iommufd: Implement the iommufd backend

Zhenzhong Duan (20):
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
  vfio: Make VFIOContainerBase poiner parameter const in VFIOIOMMUOps
    callbacks
  vfio/pci: Move VFIODevice initializations in vfio_instance_init
  vfio/platform: Move VFIODevice initializations in
    vfio_platform_instance_init
  vfio/ap: Move VFIODevice initializations in vfio_ap_instance_init
  vfio/ccw: Move VFIODevice initializations in vfio_ccw_instance_init
  vfio: Introduce a helper function to initialize VFIODevice
  docs/devel: Add VFIO iommufd backend documentation

 MAINTAINERS                           |  11 +
 docs/devel/index-internals.rst        |   1 +
 docs/devel/vfio-iommufd.rst           | 166 +++++++
 qapi/qom.json                         |  19 +
 hw/vfio/pci.h                         |   6 +
 include/hw/vfio/vfio-common.h         |  29 +-
 include/hw/vfio/vfio-container-base.h |  15 +-
 include/qemu/chardev_open.h           |  16 +
 include/sysemu/iommufd.h              |  38 ++
 backends/iommufd.c                    | 245 ++++++++++
 hw/vfio/ap.c                          |  47 +-
 hw/vfio/ccw.c                         |  53 ++-
 hw/vfio/common.c                      |  24 +-
 hw/vfio/container-base.c              |   6 +-
 hw/vfio/container.c                   | 208 ++++++++-
 hw/vfio/helpers.c                     |  54 +++
 hw/vfio/iommufd.c                     | 630 ++++++++++++++++++++++++++
 hw/vfio/pci.c                         | 218 ++-------
 hw/vfio/platform.c                    |  44 +-
 util/chardev_open.c                   |  81 ++++
 backends/Kconfig                      |   4 +
 backends/meson.build                  |   1 +
 backends/trace-events                 |  10 +
 hw/arm/Kconfig                        |   1 +
 hw/i386/Kconfig                       |   1 +
 hw/s390x/Kconfig                      |   1 +
 hw/vfio/meson.build                   |   3 +
 hw/vfio/trace-events                  |  11 +
 qemu-options.hx                       |  12 +
 util/meson.build                      |   1 +
 30 files changed, 1706 insertions(+), 250 deletions(-)
 create mode 100644 docs/devel/vfio-iommufd.rst
 create mode 100644 include/qemu/chardev_open.h
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 backends/iommufd.c
 create mode 100644 hw/vfio/iommufd.c
 create mode 100644 util/chardev_open.c

-- 
2.34.1


