Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19697F0EC7
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 10:16:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r50NB-0007JP-VX; Mon, 20 Nov 2023 04:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r50NA-0007Iq-5M
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r50N4-0006eC-Rx
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700471708;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jpBOiKqvFwdS8Fh6pMHvxYBjvNlMvhSkbuWNStXS0A=;
 b=ZioHiQpLbMvQ7y/sj9B9sz2WmK5PazvqhiCwIdi95aO7dFhwy5Y0jkQ9me9bpJBk6AM8tv
 ljInYY33WG6GfZZUIM9XfAaF+NZD/V5Lai9z40neJ0LNBoNmCrVfa9AxfcSae3492KVeIG
 CJYcfNdNBFy30l/LfVnOYLAYVqgqsQE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-w1Uv-4xJObm39F1h602Ccg-1; Mon, 20 Nov 2023 04:15:06 -0500
X-MC-Unique: w1Uv-4xJObm39F1h602Ccg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7788ce62d50so536301385a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 01:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700471706; x=1701076506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5jpBOiKqvFwdS8Fh6pMHvxYBjvNlMvhSkbuWNStXS0A=;
 b=BqCmjmC6EL1LfRoC6nhkkPEqtq8pF6qn+x/oFHcGwIzlK7FOqTDj3U/4SYqYpvwXJp
 weqi9GFyq+9ziPJXk6gqLsSYNsxpi7bVyN4lWldN1Y48fD6Tw3ffdnbubBAOC74DapSq
 TD1XVrbSDr6UpPDOUQe9b85kxawR7eph/se6Wz+tHwHi5WZRHILJuD/VAe4sDtbg5c4Y
 oPXwHXdg5+1pM0SOrMXm4E/zhiGdagjc4edkc3KNYcIoXaJsMizNyvwVjohG7Fqy85nT
 VYWFX3nM8EsLuTwxGE2rgXtwMeTC9d3ukp3C7MZAW3amIje1UQRvPKZ7P6kNgB9os9Zi
 6OSQ==
X-Gm-Message-State: AOJu0YyUwsxkfqfK5HCqRf6eiGxvn97TkBx9uEXHVCwaI8U9rWcV3Ea6
 OUFMIT0LCuciDj+f2vUfjvumQa98mSFTRxJtRnXXMISTO9gy/2g9/zWNtHVV/DbrcGsEaFldW1v
 npTS0kpHyID9ajvY=
X-Received: by 2002:a05:620a:8906:b0:76f:f0b:a1ba with SMTP id
 ql6-20020a05620a890600b0076f0f0ba1bamr7025042qkn.30.1700471706002; 
 Mon, 20 Nov 2023 01:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHcrCg9o5ScsyQnw22oVTeZ9GdTzeqhPJYxkMwJ1XwlD/JOuG1zaTFGCzq7EPZTkz7QxyyMA==
X-Received: by 2002:a05:620a:8906:b0:76f:f0b:a1ba with SMTP id
 ql6-20020a05620a890600b0076f0f0ba1bamr7025020qkn.30.1700471705631; 
 Mon, 20 Nov 2023 01:15:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a14af00b00777611164c6sm2518399qkj.15.2023.11.20.01.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 01:15:04 -0800 (PST)
Message-ID: <ab076809-9441-4933-a948-83fbb0855dd7@redhat.com>
Date: Mon, 20 Nov 2023 10:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/21] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Hi,
>
> Thanks all for giving guides and comments on previous series, this is
> the remaining part of the iommufd support.
>
> Based on Cédric's suggestion, replace old config method for IOMMUFD
> with Kconfig.
>
> Based on Jason's suggestion, drop the implementation of manually
> allocating hwpt and switch to IOAS attach/detach.
>
> Beside current test, we also tested mdev with mtty for better cover range.
>
> PATCH 1: Introduce iommufd object
> PATCH 2-9: add IOMMUFD container and cdev support
> PATCH 10-17: fd passing for cdev and linking to IOMMUFD
> PATCH 18: make VFIOContainerBase parameter const
> PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
>
>
> We have done wide test with different combinations, e.g:
> - PCI device were tested
> - FD passing and hot reset with some trick.
> - device hotplug test with legacy and iommufd backends
> - with or without vIOMMU for legacy and iommufd backends
> - divices linked to different iommufds
> - VFIO migration with a E800 net card(no dirty sync support) passthrough
> - platform, ccw and ap were only compile-tested due to environment limit
> - test mdev pass through with mtty and mix with real device and different BE
>
> Given some iommufd kernel limitations, the iommufd backend is
> not yet fully on par with the legacy backend w.r.t. features like:
> - p2p mappings (you will see related error traces)
> - dirty page sync
> - and etc.

Feel free to add my T-b:
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
>
> qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v6
> Based on vfio-next, commit id: 1a22fb936e
>
> --------------------------------------------------------------------------
>
> Below are some background and graph about the design:
>
> With the introduction of iommufd, the Linux kernel provides a generic
> interface for userspace drivers to propagate their DMA mappings to kernel
> for assigned devices. This series does the porting of the VFIO devices
> onto the /dev/iommu uapi and let it coexist with the legacy implementation.
>
> At QEMU level, interactions with the /dev/iommu are abstracted by a new
> iommufd object (compiled in with the CONFIG_IOMMUFD option).
>
> Any QEMU device (e.g. vfio device) wishing to use /dev/iommu must be
> linked with an iommufd object. In this series, the vfio-pci device is
> granted with such capability (other VFIO devices are not yet ready):
>
> It gets a new optional parameter named iommufd which allows to pass
> an iommufd object:
>
>     -object iommufd,id=iommufd0
>     -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
>
> Note the /dev/iommu and vfio cdev can be externally opened by a
> management layer. In such a case the fd is passed:
>
>     -object iommufd,id=iommufd0,fd=22
>     -device vfio-pci,iommufd=iommufd0,fd=23
>
> If the fd parameter is not passed, the fd is opened by QEMU.
> See https://www.mail-archive.com/qemu-devel@nongnu.org/msg937155.html
> for detailed discuss on this requirement.
>
> If no iommufd option is passed to the vfio-pci device, iommufd is not
> used and the end-user gets the behavior based on the legacy vfio iommu
> interfaces:
>
>     -device vfio-pci,host=0000:02:00.0
>
> While the legacy kernel interface is group-centric, the new iommufd
> interface is device-centric, relying on device fd and iommufd.
>
> To support both interfaces in the QEMU VFIO device we reworked the vfio
> container abstraction so that the generic VFIO code can use either
> backend.
>
> The VFIOContainer object becomes a base object derived into
> a) the legacy VFIO container and
> b) the new iommufd based container.
>
> The base object implements generic code such as code related to
> memory_listener and address space management whereas the derived
> objects implement callbacks specific to either BE, legacy and
> iommufd. Indeed each backend has its own way to setup secure context
> and dma management interface. The below diagram shows how it looks
> like with both BEs.
>
>                     VFIO                           AddressSpace/Memory
>     +-------+  +----------+  +-----+  +-----+
>     |  pci  |  | platform |  |  ap |  | ccw |
>     +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
>         |           |           |        |        |   AddressSpace       |
>         |           |           |        |        +------------+---------+
>     +---V-----------V-----------V--------V----+               /
>     |           VFIOAddressSpace              | <------------+
>     |                  |                      |  MemoryListener
>     |          VFIOContainer list             |
>     +-------+----------------------------+----+
>             |                            |
>             |                            |
>     +-------V------+            +--------V----------+
>     |   iommufd    |            |    vfio legacy    |
>     |  container   |            |     container     |
>     +-------+------+            +--------+----------+
>             |                            |
>             | /dev/iommu                 | /dev/vfio/vfio
>             | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
> Userspace   |                            |
> ============+============================+===========================
> Kernel      |  device fd                 |
>             +---------------+            | group/container fd
>             | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
>             |  ATTACH_IOAS) |            | device fd
>             |               |            |
>             |       +-------V------------V-----------------+
>     iommufd |       |                vfio                  |
> (map/unmap  |       +---------+--------------------+-------+
> ioas_copy)  |                 |                    | map/unmap
>             |                 |                    |
>      +------V------+    +-----V------+      +------V--------+
>      | iommfd core |    |  device    |      |  vfio iommu   |
>      +-------------+    +------------+      +---------------+
>
> [Secure Context setup]
> - iommufd BE: uses device fd and iommufd to setup secure context
>               (bind_iommufd, attach_ioas)
> - vfio legacy BE: uses group fd and container fd to setup secure context
>                   (set_container, set_iommu)
> [Device access]
> - iommufd BE: device fd is opened through /dev/vfio/devices/vfioX
> - vfio legacy BE: device fd is retrieved from group fd ioctl
> [DMA Mapping flow]
> 1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
> 2. VFIO populates DMA map/unmap via the container BEs
>    *) iommufd BE: uses iommufd
>    *) vfio legacy BE: uses container fd
>
>
> Changelog:
> v6:
> - simplify CONFIG_IOMMUFD checking code further (Cédric)
> - check iommufd_cdev_kvm_device_add return value (Cédric)
> - dirrectory -> directory (Cédric)
> - propagate iommufd_cdev_get_info_iova_range err and print as warning (Cédric)
> - introduce a helper vfio_device_set_fd (Cédric)
> - Move #include "sysemu/iommufd.h" in platform.c (Cédric)
> - simplify iommufd backend uAPI, remove alloc_hwpt, get/put_ioas
> - Dare to keep Matthew's RB as related change is minor
>
> v5:
> - Change to use Kconfig for CONFIG_IOMMUFD and drop stub file (Cédric)
> - Add (uintptr_t) to info->allowed_iovas (Cédric)
> - Switch to IOAS attach/detach and hide hwpt (Jason)
> - move chardev_open.[h|c] under the IOMMUFD entry (Cédric)
> - Move vfio_legacy_pci_hot_reset into container.c (Cédric)
> - Add missed pgsizes initialization in vfio_get_info_iova_range
> - split linking iommufd patch into three to be cleaner
> - Fix comments on PCI BAR unmap
>
> v4:
> - add CONFIG_IOMMUFD check for IOMMUFDProperties (Markus)
> - add doc for default case without fd (Markus)
> - Fix build issue reported by Markus and Cédric
> - Simply use SPDX identifier in new file (Cédric)
> - make vfio_container_init/destroy helper a seperate patch (Cédric)
> - make vrdl_list movement a seperate patch (Cédric)
> - add const for some callback parameters (Cédric)
> - add g_assert in VFIOIOMMUOps callback (Cédric)
> - introduce pci_hot_reset callback (Cédric)
> - remove VFIOIOMMUSpaprOps (Cédric)
> - initialize g_autofree to NULL (Cédric)
> - adjust func name prefix and trace event in iommufd.c (Cédric)
> - add RB
>
> v3:
> - Rename base container as VFIOContainerBase and legacy container as container (Cédric)
> - Drop VFIO_IOMMU_BACKEND_OPS class and use struct instead (Cédric)
> - Cleanup container.c by introducing spapr backend and move spapr code out (Cédric)
> - Introduce vfio_iommu_spapr_ops (Cédric)
> - Add doc of iommufd in qom.json and have iommufd member sorted (Markus)
> - patch19 and patch21 are splitted to two parts to facilitate review
>
> v2:
> - patch "vfio: Add base container" in v1 is split into patch1-15 per Cédric
> - add fd passing to platform/ap/ccw vfio device
> - add (uintptr_t) cast in iommufd_backend_map_dma() per Cédric
> - rename char_dev.h to chardev_open.h for same naming scheme per Daniel
> - add full copyright per Daniel and Jason
>
>
> Note changelog below are from full IOMMUFD series:
>
> v1:
> - Alloc hwpt instead of using auto hwpt
> - elaborate iommufd code per Nicolin
> - consolidate two patches and drop as.c
> - typo error fix and function rename
>
> rfcv4:
> - rebase on top of v8.0.3
> - Add one patch from Yi which is about vfio device add in kvm
> - Remove IOAS_COPY optimization and focus on functions in this patchset
> - Fix wrong name issue reported and fix suggested by Matthew
> - Fix compilation issue reported and fix sugggsted by Nicolin
> - Use query_dirty_bitmap callback to replace get_dirty_bitmap for better
> granularity
> - Add dev_iter_next() callback to avoid adding so many callback
>   at container scope, add VFIODevice.hwpt to support that
> - Restore all functions back to common from container whenever possible,
>   mainly migration and reset related functions
> - Add --enable/disable-iommufd config option, enabled by default in linux
> - Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
> - Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
> - vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove
> redundant code
> - Add FD passing support for vfio device backed by IOMMUFD
> - Fix hot unplug resource leak issue in vfio_legacy_detach_device()
> - Fix FD leak in vfio_get_devicefd()
>
> rfcv3:
> - rebase on top of v7.2.0
> - Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
>   VFIO backends
> - Fix use after free in error path, reported by Alister
> - Split common.c in several steps to ease the review
>
> rfcv2:
> - remove the first three patches of rfcv1
> - add open cdev helper suggested by Jason
> - remove the QOMification of the VFIOContainer and simply use standard ops
> (David)
> - add "-object iommufd" suggested by Alex
>
> Thanks
> Zhenzhong
>
>
> Cédric Le Goater (3):
>   hw/arm: Activate IOMMUFD for virt machines
>   kconfig: Activate IOMMUFD for s390x machines
>   hw/i386: Activate IOMMUFD for q35 machines
>
> Eric Auger (2):
>   backends/iommufd: Introduce the iommufd object
>   vfio/pci: Allow the selection of a given iommu backend
>
> Yi Liu (2):
>   util/char_dev: Add open_cdev()
>   vfio/iommufd: Implement the iommufd backend
>
> Zhenzhong Duan (14):
>   vfio/common: return early if space isn't empty
>   vfio/iommufd: Relax assert check for iommufd backend
>   vfio/iommufd: Add support for iova_ranges and pgsizes
>   vfio/pci: Extract out a helper vfio_pci_get_pci_hot_reset_info
>   vfio/pci: Introduce a vfio pci hot reset interface
>   vfio/iommufd: Enable pci hot reset through iommufd cdev interface
>   vfio/pci: Make vfio cdev pre-openable by passing a file handle
>   vfio/platform: Allow the selection of a given iommu backend
>   vfio/platform: Make vfio cdev pre-openable by passing a file handle
>   vfio/ap: Allow the selection of a given iommu backend
>   vfio/ap: Make vfio cdev pre-openable by passing a file handle
>   vfio/ccw: Allow the selection of a given iommu backend
>   vfio/ccw: Make vfio cdev pre-openable by passing a file handle
>   vfio: Make VFIOContainerBase poiner parameter const in VFIOIOMMUOps
>     callbacks
>
>  MAINTAINERS                           |  10 +
>  qapi/qom.json                         |  19 +
>  hw/vfio/pci.h                         |   6 +
>  include/hw/vfio/vfio-common.h         |  26 +-
>  include/hw/vfio/vfio-container-base.h |  15 +-
>  include/qemu/chardev_open.h           |  16 +
>  include/sysemu/iommufd.h              |  44 ++
>  backends/iommufd.c                    | 228 ++++++++++
>  hw/vfio/ap.c                          |  29 +-
>  hw/vfio/ccw.c                         |  31 +-
>  hw/vfio/common.c                      |  24 +-
>  hw/vfio/container-base.c              |   6 +-
>  hw/vfio/container.c                   | 208 ++++++++-
>  hw/vfio/helpers.c                     |  44 ++
>  hw/vfio/iommufd.c                     | 630 ++++++++++++++++++++++++++
>  hw/vfio/pci.c                         | 212 ++-------
>  hw/vfio/platform.c                    |  38 +-
>  util/chardev_open.c                   |  81 ++++
>  backends/Kconfig                      |   4 +
>  backends/meson.build                  |   1 +
>  backends/trace-events                 |  10 +
>  hw/arm/Kconfig                        |   1 +
>  hw/i386/Kconfig                       |   1 +
>  hw/s390x/Kconfig                      |   1 +
>  hw/vfio/meson.build                   |   3 +
>  hw/vfio/trace-events                  |  11 +
>  qemu-options.hx                       |  12 +
>  util/meson.build                      |   1 +
>  28 files changed, 1493 insertions(+), 219 deletions(-)
>  create mode 100644 include/qemu/chardev_open.h
>  create mode 100644 include/sysemu/iommufd.h
>  create mode 100644 backends/iommufd.c
>  create mode 100644 hw/vfio/iommufd.c
>  create mode 100644 util/chardev_open.c
>


