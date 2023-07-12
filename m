Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8B75004A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURK-00045O-JZ; Wed, 12 Jul 2023 03:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURE-000452-O8
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:05 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURB-0005sl-0W
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147541; x=1720683541;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N254egRX2Ps4ghMfc1dXRKh+XUjBO2BcAmjztDox/bg=;
 b=NmkhAxk5BLhgnSo29pCHbcIkVlpsAvJMEPw/36MkiF/zqbRdZkWpLrRC
 CMeU8/AQCNPPcikWhNWVu1Ea7XJkxq0iTUUnw0QAIt4wG2g++lyBIAVPb
 mRExs0dtvO01ftI5CAhLXqwrnfS/c9lsMm+NN77RXVFsQnjf51WioRote
 pxvNUgMEvg8XYJM0xdfwIxZfJ4ru/tHmosOJiSqlSOKmSZ+JG3KzfV56I
 b06okDGrPv2DkaxoqQiaKz5nsUXNtiLtMId0qtLJ2is086wRpT3lqMV/m
 VCbhM3CCfGdl1yBUbNTTRq5n2GLEM/wj0HsPTYmsUUwdbJ1VeVeEp0PaG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953535"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953535"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835023920"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835023920"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:38:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Date: Wed, 12 Jul 2023 15:25:04 +0800
Message-Id: <20230712072528.275577-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With the introduction of iommufd, the Linux kernel provides a generic
interface for userspace drivers to propagate their DMA mappings to kernel
for assigned devices. This series does the porting of the VFIO devices
onto the /dev/iommu uapi and let it coexist with the legacy implementation.

This QEMU integration is the result of a collaborative work between
Yi Liu, Yi Sun, Nicolin Chen and Eric Auger.

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

This series depends on Yi's kernel series:
"[PATCH v14 00/26] Add vfio_device cdev for iommufd support"
https://lore.kernel.org/all/20230711025928.6438-1-yi.l.liu@intel.com/
and
"[PATCH v9 00/10] Enhance vfio PCI hot reset for vfio cdev device"
https://lore.kernel.org/kvm/20230711023126.5531-1-yi.l.liu@intel.com/

which can be found at:
https://github.com/yiliu1765/iommufd/tree/vfio_device_cdev_v14

This qemu series can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_rfcv4

Test done:
- PCI device were tested
- platform, ccw and ap were only compile-tested
- FD passing and hot reset with some trick.
- device hotplug test with legacy and iommufd backends (limited tests)
- vIOMMU test run for both legacy and iommufd backends (limited tests)


Given some iommufd kernel limitations, the iommufd backend is
not yet fully on par with the legacy backend w.r.t. features like:
- p2p mappings (you will see related error traces)
- live migration
- and etc.

About TODOs in rfcv3:
- Add DMA alias check for iommufd BE (group level)
attach_ioas will fail for aliased device, so I think that's not a problem.

- Make pci.c to be BE agnostic. Needs kernel change as well to fix the
  VFIO_DEVICE_PCI_HOT_RESET gap
I didn't make pci.c fully group agnostic because pci device reset is
device scope operation, force mapping it to container scope callback
isn't a good idea. Instead I added iommufd code in pci.c and fixed
VFIO_DEVICE_PCI_HOT_RESET gap there.

- Cleanup the VFIODevice fields as it's used in both backends
- Replace list with g_tree
This TODO is not viable due to iterator callback depending on list element.

- Add locks
I think it's not necessory as BQL already ensure that.

base-commit: 887cba855b

Change log:
v3 -> v4:
- rebase on top of v8.0.3
- Add one patch from Yi which is about vfio device add in kvm
- Remove IOAS_COPY optimization and focus on functions in this patchset
- Fix wrong name issue reported and fix suggested by Matthew
- Fix compilation issue reported and fix sugggsted by Nicolin
- Use query_dirty_bitmap callback to replace get_dirty_bitmap for better granularity
- Add dev_iter_next() callback to avoid adding so many callback
  at container scope, add VFIODevice.hwpt to support that
- Restore all functions back to common from container whenever possible,
  mainly migration and reset related functions
- Add --enable/disable-iommufd config option, enabled by default in linux
- Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
- Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
- vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove redundant code
- Add FD passing support for vfio device backed by IOMMUFD
- Fix hot unplug resource leak issue in vfio_legacy_detach_device()
- Fix FD leak in vfio_get_devicefd()

v3: https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg07189.html

v2 -> v3:
- rebase on top of v7.2.0
- Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
  VFIO backends
- Fix use after free in error path, reported by Alister
- Split common.c in several steps to ease the review

v1 -> v2:
- remove the first three patches of rfcv1
- add open cdev helper suggested by Jason
- remove the QOMification of the VFIOContainer and simply use standard ops (David)
- add "-object iommufd" suggested by Alex

v1: https://lore.kernel.org/qemu-devel/20220414104710.28534-1-yi.l.liu@intel.com/

Thanks,
Yi, Yi, Eric, Zhenzhong

Eric Auger (9):
  scripts/update-linux-headers: Add iommufd.h
  vfio/common: Introduce vfio_container_add|del_section_window()
  vfio/container: Introduce vfio_[attach/detach]_device
  vfio/platform: Use vfio_[attach/detach]_device
  vfio/ap: Use vfio_[attach/detach]_device
  vfio/ccw: Use vfio_[attach/detach]_device
  vfio/container-base: Introduce [attach/detach]_device container
    callbacks
  backends/iommufd: Introduce the iommufd object
  vfio/as: Allow the selection of a given iommu backend

Yi Liu (6):
  vfio/common: Move IOMMU agnostic helpers to a separate file
  vfio/common: Move legacy VFIO backend code into separate container.c
  vfio/common: Rename into as.c
  vfio: Add base container
  util/char_dev: Add open_cdev()
  vfio/iommufd: Implement the iommufd backend

Zhenzhong Duan (9):
  Update linux-header per VFIO device cdev v14
  vfio/common: Extract out vfio_kvm_device_[add/del]_fd
  vfio/common: Add a vfio device iterator
  vfio/common: Refactor vfio_viommu_preset() to be group agnostic
  vfio/as: Simplify vfio_viommu_preset()
  Add iommufd configure option
  vfio/as: Add vfio device iterator callback for iommufd
  vfio/pci: Adapt vfio pci hot reset support with iommufd BE
  vfio/iommufd: Make vfio cdev pre-openable by passing a file handle

 MAINTAINERS                           |   13 +
 backends/Kconfig                      |    4 +
 backends/iommufd.c                    |  268 +++
 backends/meson.build                  |    3 +
 backends/trace-events                 |   12 +
 hw/vfio/ap.c                          |   66 +-
 hw/vfio/as.c                          | 1555 +++++++++++++
 hw/vfio/ccw.c                         |  122 +-
 hw/vfio/common.c                      | 3078 -------------------------
 hw/vfio/container-base.c              |  146 ++
 hw/vfio/container.c                   | 1218 ++++++++++
 hw/vfio/helpers.c                     |  598 +++++
 hw/vfio/iommufd.c                     |  546 +++++
 hw/vfio/meson.build                   |    8 +-
 hw/vfio/pci.c                         |  354 ++-
 hw/vfio/platform.c                    |   43 +-
 hw/vfio/spapr.c                       |   22 +-
 hw/vfio/trace-events                  |   16 +-
 include/hw/vfio/vfio-common.h         |  109 +-
 include/hw/vfio/vfio-container-base.h |  158 ++
 include/qemu/char_dev.h               |   16 +
 include/sysemu/iommufd.h              |   47 +
 linux-headers/linux/iommufd.h         |  347 +++
 linux-headers/linux/kvm.h             |   13 +-
 linux-headers/linux/vfio.h            |  142 +-
 meson.build                           |    6 +
 meson_options.txt                     |    2 +
 qapi/qom.json                         |   18 +-
 qemu-options.hx                       |   13 +
 scripts/meson-buildoptions.sh         |    3 +
 scripts/update-linux-headers.sh       |    3 +-
 util/chardev_open.c                   |   61 +
 util/meson.build                      |    1 +
 33 files changed, 5601 insertions(+), 3410 deletions(-)
 create mode 100644 backends/iommufd.c
 create mode 100644 hw/vfio/as.c
 delete mode 100644 hw/vfio/common.c
 create mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/container.c
 create mode 100644 hw/vfio/helpers.c
 create mode 100644 hw/vfio/iommufd.c
 create mode 100644 include/hw/vfio/vfio-container-base.h
 create mode 100644 include/qemu/char_dev.h
 create mode 100644 include/sysemu/iommufd.h
 create mode 100644 linux-headers/linux/iommufd.h
 create mode 100644 util/chardev_open.c

-- 
2.34.1


