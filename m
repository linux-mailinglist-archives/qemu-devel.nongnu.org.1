Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E907D78D54E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIon-0004Cd-AO; Wed, 30 Aug 2023 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIoh-0004CM-DW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:52:55 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIoc-0007e8-3y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392770; x=1724928770;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0VYRgaAZshoqo7NbI78fnI3MKfOzD32Ulj+kvUO3l50=;
 b=YN+MfWTyuslG2fwM/tLGYriXOatMVlWZD0NR2jpu5lHg3Ua++zMPb0Hd
 TZ6/GsURT4c/Dc6Sr3A7j5rJkzOdywl+SjcHg8W+OI1QLcCWbm1jIEyzo
 SF8E6AW7/4wfmEbB4YrBgmp6y0aHJhjmGR104e5hxxtC/YKLHwHcvnXmt
 idD9sDL3sf8mGbFbEeaDQ/rBqgORAoUxF5Bj8p98G2r6zov58I1D+xlGE
 cmHh5crjReSH707ScIQsw4WOWkin+ILCyd6M/DOPNt8TDKVecxfNZ0AxC
 Opo1YZwoQFtpcjp1VuMxNvlGuuFFF5XXouhO5WKzjqwro41WE81fFlpUC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016352"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016352"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715865931"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715865931"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:52:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 00/22] vfio: Adopt iommufd
Date: Wed, 30 Aug 2023 18:37:32 +0800
Message-Id: <20230830103754.36461-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi All,

As the kernel side iommufd cdev and hot reset feature have been queued,
also hwpt alloc has been added in Jason's for_next branch [1], I'd like
to update a new version matching kernel side update and with rfc flag
removed. Qemu code can be found at [2], look forward more comments!


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


Changelog:
v1:
- Alloc hwpt instead of using auto hwpt
- elaborate iommufd code per Nicolin
- consolidate two patches and drop as.c
- typo error fix and function rename

I didn't list change log of rfc stage, see [3] if anyone is interested.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
[2] https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v1
[3] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02529.html


--------------------------------------------------------------------------

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


Thanks,
Yi, Yi, Eric, Zhenzhong


Eric Auger (8):
  scripts/update-linux-headers: Add iommufd.h
  vfio/common: Introduce vfio_container_add|del_section_window()
  vfio/container: Introduce vfio_[attach/detach]_device
  vfio/platform: Use vfio_[attach/detach]_device
  vfio/ap: Use vfio_[attach/detach]_device
  vfio/ccw: Use vfio_[attach/detach]_device
  backends/iommufd: Introduce the iommufd object
  vfio/pci: Allow the selection of a given iommu backend

Yi Liu (5):
  vfio/common: Move IOMMU agnostic helpers to a separate file
  vfio/common: Move legacy VFIO backend code into separate container.c
  vfio: Add base container
  util/char_dev: Add open_cdev()
  vfio/iommufd: Implement the iommufd backend

Zhenzhong Duan (9):
  Update linux-header to support iommufd cdev and hwpt alloc
  vfio/common: Extract out vfio_kvm_device_[add/del]_fd
  vfio/common: Add a vfio device iterator
  vfio/common: Refactor vfio_viommu_preset() to be group agnostic
  vfio/common: Simplify vfio_viommu_preset()
  Add iommufd configure option
  vfio/iommufd: Add vfio device iterator callback for iommufd
  vfio/pci: Adapt vfio pci hot reset support with iommufd BE
  vfio/pci: Make vfio cdev pre-openable by passing a file handle

 MAINTAINERS                           |   13 +
 backends/Kconfig                      |    4 +
 backends/iommufd.c                    |  291 ++++
 backends/meson.build                  |    3 +
 backends/trace-events                 |   13 +
 hw/vfio/ap.c                          |   68 +-
 hw/vfio/ccw.c                         |  120 +-
 hw/vfio/common.c                      | 1948 +++----------------------
 hw/vfio/container-base.c              |  160 ++
 hw/vfio/container.c                   | 1208 +++++++++++++++
 hw/vfio/helpers.c                     |  626 ++++++++
 hw/vfio/iommufd.c                     |  554 +++++++
 hw/vfio/meson.build                   |    6 +
 hw/vfio/pci.c                         |  319 +++-
 hw/vfio/platform.c                    |   43 +-
 hw/vfio/spapr.c                       |   22 +-
 hw/vfio/trace-events                  |   21 +-
 include/hw/vfio/vfio-common.h         |  111 +-
 include/hw/vfio/vfio-container-base.h |  158 ++
 include/qemu/char_dev.h               |   16 +
 include/standard-headers/linux/fuse.h |    3 +
 include/sysemu/iommufd.h              |   49 +
 linux-headers/linux/iommufd.h         |  444 ++++++
 linux-headers/linux/kvm.h             |   13 +-
 linux-headers/linux/vfio.h            |  148 +-
 meson.build                           |    6 +
 meson_options.txt                     |    2 +
 qapi/qom.json                         |   18 +-
 qemu-options.hx                       |   13 +
 scripts/meson-buildoptions.sh         |    3 +
 scripts/update-linux-headers.sh       |    3 +-
 util/chardev_open.c                   |   61 +
 util/meson.build                      |    1 +
 33 files changed, 4395 insertions(+), 2073 deletions(-)
 create mode 100644 backends/iommufd.c
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


