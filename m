Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90F82D786
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:40:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKNY-0000d5-58; Mon, 15 Jan 2024 05:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNW-0000cu-KD
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:38 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNU-0002iw-2J
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315176; x=1736851176;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O/EFMrxu0CYBwrfahAsOSKzJacDdyiZXXp8rnR7A7LY=;
 b=VJv49OuhK8Tsww3yaZfgjahA1Cc13+zGKLsR8xTwTvROqfz9lTTA3JbB
 is4Ey7ip3cCDtY9N46mGg43KkyMt4vjbALlfR98ETMZa/QB8GSt0cew4Q
 eoFEKlUWElqfSNjqSlM0MI82teoSZC5KUmVRta3e9aP7t4yeBA9N3MGmx
 KHQ0fIE5f4oYinuWPBR+noz51/i0h24Qfn3chqgHSfHpB496yxFEjIxZQ
 A755y2LUy3ZgxFnhAr1LeuVxeIZ2m99cg+z6v8NJSKSFxHPLBNuRtqier
 7VDCn/BaRHXpt9lSDf7uzLrnnWVIuryz1bDSbEtqvES9dKCDQ4D/7OIrZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067408"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065306"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065306"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:27 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv1 00/23] intel_iommu: Enable stage-1 translation
Date: Mon, 15 Jan 2024 18:37:12 +0800
Message-Id: <20240115103735.132209-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series enables stage-1 translation support in intel iommu which
we called "modern" mode. In this mode, we don't do shadowing of
guest page table for passthrough device but pass stage-1 page table
to host side to construct a nested domain; we also support emulated
device by translating the stage-1 page table. There was some effort
to enable this feature in old days, see [1] for details.

The key design is to utilize the dual-stage IOMMU translation
(also known as IOMMU nested translation) capability in host IOMMU.
As the below diagram shows, guest I/O page table pointer in GPA
(guest physical address) is passed to host and be used to perform
the stage-1 address translation. Along with it, modifications to
present mappings in the guest I/O page table should be followed
with an IOTLB invalidation.

        .-------------.  .---------------------------.
        |   vIOMMU    |  | Guest I/O page table      |
        |             |  '---------------------------'
        .----------------/
        | PASID Entry |--- PASID cache flush --+
        '-------------'                        |
        |             |                        V
        |             |           I/O page table pointer in GPA
        '-------------'
    Guest
    ------| Shadow |---------------------------|--------
          v        v                           v
    Host
        .-------------.  .------------------------.
        |   pIOMMU    |  |  FS for GIOVA->GPA     |
        |             |  '------------------------'
        .----------------/  |
        | PASID Entry |     V (Nested xlate)
        '----------------\.----------------------------------.
        |             |   | SS for GPA->HPA, unmanaged domain|
        |             |   '----------------------------------'
        '-------------'
Where:
 - FS = First stage page tables
 - SS = Second stage page tables
<Intel VT-d Nested translation>

There are some interactions between VFIO and vIOMMU.
* vIOMMU registers PCIIOMMUOps to PCI subsystem which VFIO can
  use to registers/unregisters IOMMUDevice object.
* VFIO registers an IOMMUFDDevice object at vfio device realize
  stage to vIOMMU, this is implemented as a prerequisite series[2].
* vIOMMU calls IOMMUFDDevice interface callback IOMMUFDDeviceOps
  to bind/unbind device to IOMMUFD backed domains, either nested
  domain or not.

See below diagram:

        VFIO Device                                 Intel IOMMU
    .-----------------.                         .-------------------.
    |                 |                         |                   |
    |       .---------|PCIIOMMUOps              |.-------------.    |
    |       | IOMMUFD |(set_iommu_device)       || IOMMUFD     |    |
    |       | Device  |------------------------>|| Device list |    |
    |       .---------|(unset_iommu_device)     |.-------------.    |
    |                 |                         |       |           |
    |                 |                         |       V           |
    |       .---------|         IOMMUFDDeviceOps|  .---------.      |
    |       | IOMMUFD |            (attach_hwpt)|  | IOMMUFD |      |
    |       | link    |<------------------------|  | Device  |      |
    |       .---------|            (detach_hwpt)|  .---------.      |
    |                 |                         |       |           |
    |                 |                         |       ...         |
    .-----------------.                         .-------------------.

Based on Yi's suggestion, we updated a new design of managing ioas and
hwpt, made it support multiple iommufd objects and the ERRATA_772415
case, meanwhile tried to be optimal to share ioas and hwpt whenever
possible.

Stage-2 page table could be shared by different devices if there is
no conflict and devices link to same iommufd object, i.e. devices
under same host IOMMU can share same stage-2 page table. If there
is conflict, i.e. there is one device under non cache coherency
mode which is different from others, it requires a seperate
stage-2 page table in non-CC mode.

SPR platform has ERRATA_772415 which requires no readonly mappings
in stage-2 page table. This series supports creating VTDIOASContainer
with no readonly mappings. I'm not clear if there is a rare case that
some IOMMUs on a multiple IOMMUs host have ERRATA_772415, this design
can survive even in that case.

See below example diagram for a full view:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.    .-------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
    .------------------.    .------------------.    .-------------------.
             |                       |                              |
             |                       .-->...                        |
             V                                                      V
      .-------------------.    .-------------------.          .---------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
      .-------------------.    .-------------------.          .---------------.
          |            |               |                            |
          |            |               |                            |
    .-----------.  .-----------.  .------------.              .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
    |           |  |           |  | (iommufd0) |              | (iommufd0) |
    .-----------.  .-----------.  .------------.              .------------.

This series is also a prerequisite work for vSVA, i.e. Sharing
guest application address space with passthrough devices.

To enable "modern" mode, only need to add "x-scalable-mode=modern".
i.e. -device intel-iommu,x-scalable-mode=modern,...

Passthrough device should use iommufd backend to work in "modern" mode.
i.e. -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

If host doens't support nested translation, qemu will fail
with an unsupported report.

Test done:
- devices hotplug/unplug
- different devices linked to different iommufds

PATCH1-2:  Some preparing work to update header and IOMMUFD uAPI
PATCH3-4:  Initialize vfio IOMMUFDDevice interface and pass to vIOMMU
PATCH5:    Introduce a placeholder variable for scalable modern mode
PATCH6:    Sync host cap/ecap with vIOMMU default cap/ecap in modern mode
PATCH7-22: Implement first stage page table for passthrough and emulated device
PATCH23:   Introduce "modern" mode to distinguish with legacy mode

Qemu code can be found at [3]
Matching kernel code can be found at [4]

TODO:
- RAM discard
- dirty tracking on stage-2 page table

THOUGHTS:
This design is optimal in sharing ioas/hwpt whenever posssible, but it also
bring some overhead for vIOMMU to implement a simliar memory listener as
vfio_memory_listener, i.e., this memory listener should also support ram
discard and dirty tracking.

We have also implemented another design internally, by reusing ioas from vfio
to create s2hwpt, this way each device has its own s2hwpt and sharing vfio's
ioas, so vfio_memory_listener is reused, no code redundency. But shis have
three flaws,
 1. address space switch should be bypassed for vfio device which means vfio
    device and emulated device can't share same address space.
 2. still need to create seperate ioas/hwpt if ERRATA_772415.
 3. no ioas/hwpt sharing.

Not clear which design is prefered in community, internally we like current
design a bit more, welcome comments and suggestions.

[1] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02730.html
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv1
[4] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

Thanks
Zhenzhong


Yi Liu (11):
  intel_iommu: process PASID cache invalidation
  intel_iommu: add PASID cache management infrastructure
  intel_iommu: replay pasid binds after context cache invalidation
  intel_iommu: process PASID-based iotlb invalidation
  intel_iommu: propagate PASID-based iotlb invalidation to host
  intel_iommu: process PASID-based Device-TLB invalidation
  intel_iommu: rename slpte in iotlb_entry to pte
  intel_iommu: implement firt level translation
  intel_iommu: introduce pasid iotlb cache
  intel_iommu: refresh pasid bind after pasid cache force reset
  intel_iommu: modify x-scalable-mode to be string option

Yi Sun (2):
  intel_iommu: piotlb invalidation should notify unmap
  intel_iommu: invalidate piotlb when flush pasid

Yu Zhang (1):
  intel_iommu: fix the fault reason report

Zhenzhong Duan (9):
  Update linux header to support nested hwpt alloc
  backends/iommufd: add helpers for allocating user-managed HWPT
  backends/iommufd_device: introduce IOMMUFDDevice targeted interface
  vfio: implement IOMMUFDDevice interface callbacks
  intel_iommu: add a placeholder variable for scalable modern mode
  intel_iommu: check and sync host IOMMU cap/ecap in scalable modern
    mode
  vfio/iommufd_device: Add ioas_id in IOMMUFDDevice and pass to vIOMMU
  intel_iommu: bind/unbind guest page table to host
  intel_iommu: ERRATA_772415 workaround

 hw/i386/intel_iommu_internal.h                |  109 +-
 include/hw/i386/intel_iommu.h                 |   63 +-
 include/standard-headers/drm/drm_fourcc.h     |    2 +
 include/standard-headers/linux/fuse.h         |   10 +-
 include/standard-headers/linux/pci_regs.h     |   24 +-
 include/standard-headers/linux/vhost_types.h  |    7 +
 .../standard-headers/linux/virtio_config.h    |    5 +
 include/standard-headers/linux/virtio_pci.h   |   11 +
 include/sysemu/iommufd.h                      |    7 +
 include/sysemu/iommufd_device.h               |   12 +-
 linux-headers/asm-arm64/kvm.h                 |   32 +
 linux-headers/asm-generic/unistd.h            |   14 +-
 linux-headers/asm-loongarch/bitsperlong.h     |    1 +
 linux-headers/asm-loongarch/kvm.h             |  108 +
 linux-headers/asm-loongarch/mman.h            |    1 +
 linux-headers/asm-loongarch/unistd.h          |    5 +
 linux-headers/asm-mips/unistd_n32.h           |    4 +
 linux-headers/asm-mips/unistd_n64.h           |    4 +
 linux-headers/asm-mips/unistd_o32.h           |    4 +
 linux-headers/asm-powerpc/unistd_32.h         |    4 +
 linux-headers/asm-powerpc/unistd_64.h         |    4 +
 linux-headers/asm-riscv/kvm.h                 |   12 +
 linux-headers/asm-s390/unistd_32.h            |    4 +
 linux-headers/asm-s390/unistd_64.h            |    4 +
 linux-headers/asm-x86/unistd_32.h             |    4 +
 linux-headers/asm-x86/unistd_64.h             |    3 +
 linux-headers/asm-x86/unistd_x32.h            |    3 +
 linux-headers/linux/iommufd.h                 |  259 +-
 linux-headers/linux/kvm.h                     |   11 +
 linux-headers/linux/psp-sev.h                 |    1 +
 linux-headers/linux/stddef.h                  |    9 +-
 linux-headers/linux/userfaultfd.h             |    9 +-
 linux-headers/linux/vfio.h                    |   47 +-
 linux-headers/linux/vhost.h                   |    8 +
 backends/iommufd.c                            |   61 +
 backends/iommufd_device.c                     |   17 +-
 hw/i386/intel_iommu.c                         | 2822 ++++++++++++++---
 hw/vfio/iommufd.c                             |   37 +-
 backends/trace-events                         |    2 +
 hw/i386/trace-events                          |   16 +
 40 files changed, 3256 insertions(+), 504 deletions(-)
 create mode 100644 linux-headers/asm-loongarch/bitsperlong.h
 create mode 100644 linux-headers/asm-loongarch/kvm.h
 create mode 100644 linux-headers/asm-loongarch/mman.h
 create mode 100644 linux-headers/asm-loongarch/unistd.h

-- 
2.34.1


