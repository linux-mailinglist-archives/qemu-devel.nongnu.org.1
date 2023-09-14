Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D579FF7D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 11:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgiGx-0003kG-1b; Thu, 14 Sep 2023 05:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgiGu-0003k1-Oj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgiGs-0001T4-0O
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694682260;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQtlTFDTl2ZAo4h/9H2yviSYwi4ztIce310SXKPnnDk=;
 b=AqwFwU1v8u4rSZcU7mTRNnzc83dDd16tuLFDF5Fr5LTKat9sXMxWW/+pMNKKmxsmYhnZIU
 AcxPJGIXbAwXgvYvu2UTi2CKTNdaMMuBZIxuniJ4O+65JSFQInpypoLxrOcOUuSHEAbnpN
 Jba6/rLzlqD/jn41P0ka5ZN/XOgWdw4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-72C-m9GeOfGCPdDXz0Y2_w-1; Thu, 14 Sep 2023 05:04:18 -0400
X-MC-Unique: 72C-m9GeOfGCPdDXz0Y2_w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6491907dba4so6198286d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 02:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694682257; x=1695287057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQtlTFDTl2ZAo4h/9H2yviSYwi4ztIce310SXKPnnDk=;
 b=cSjAESreVqHII9P2Qgvq+2hxyVBaC1YkBskEsEKM2gv+8SvTTcGyVVcDjg5X/4AorM
 UMmCdJF9Mo/XJ4ZjBvo9eOKWKQNRHrILWUSRDEPk4bABNW69Mt0gRIJS/Jd1oFAJ/LDq
 cP2tOFWqaspjZh9xu/Yirak1ey9Fqa8v17RAOvKrpnoZ2NHqeSnXhuhkivMvxPR18rIB
 drJRbyRP7QbZdqsgKwFfHfUT5+nkURQ+pzU3XxOe7QExDpovBEJ7/TBdgljl+qLj5PUq
 EEbtDjTLXD/vKb7bgc2xQTcNtvX21KEozdKQfG8DrAofuk1/4ZAORpphjr8XDHMbrfrz
 fPcg==
X-Gm-Message-State: AOJu0YxDPu2hmr3+CJi2UXRQOD731uiKR63zuK/zP/fSwOE93A7bcKfF
 O/dgjEPTQsRqgNjpBoz/WqGgtQYgvOoLjVgskF67qyuApwyzIrDPGAZrHv2nsQgYf9HR8qSp6lj
 KM/QjXXmCjRIXICYvuxjCrj8=
X-Received: by 2002:a0c:b3cd:0:b0:655:d0ad:a908 with SMTP id
 b13-20020a0cb3cd000000b00655d0ada908mr1286368qvf.17.1694682257066; 
 Thu, 14 Sep 2023 02:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqq3y2ez97+n3Zw3KG2sasrkjqNI1EVdWFK+iRL0tlrkce2vGiwR8O0khEoQXnUnDbQzsLTg==
X-Received: by 2002:a0c:b3cd:0:b0:655:d0ad:a908 with SMTP id
 b13-20020a0cb3cd000000b00655d0ada908mr1286342qvf.17.1694682256719; 
 Thu, 14 Sep 2023 02:04:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a0cf44f000000b0064f5d70d072sm332352qvm.37.2023.09.14.02.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 02:04:15 -0700 (PDT)
Message-ID: <8cd9a176-17b5-b6de-dc54-ba10124e9fe3@redhat.com>
Date: Thu, 14 Sep 2023 11:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 00/22] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong

On 8/30/23 12:37, Zhenzhong Duan wrote:
> Hi All,
>
> As the kernel side iommufd cdev and hot reset feature have been queued,
> also hwpt alloc has been added in Jason's for_next branch [1], I'd like
> to update a new version matching kernel side update and with rfc flag
> removed. Qemu code can be found at [2], look forward more comments!
>
>
> We have done wide test with different combinations, e.g:
>
> - PCI device were tested
> - FD passing and hot reset with some trick.
> - device hotplug test with legacy and iommufd backends
> - with or without vIOMMU for legacy and iommufd backends
> - divices linked to different iommufds
> - VFIO migration with a E800 net card(no dirty sync support) passthrough
> - platform, ccw and ap were only compile-tested due to environment limit
>
>
> Given some iommufd kernel limitations, the iommufd backend is
> not yet fully on par with the legacy backend w.r.t. features like:
> - p2p mappings (you will see related error traces)
> - dirty page sync
> - and etc.
>
>
> Changelog:
> v1:
> - Alloc hwpt instead of using auto hwpt
> - elaborate iommufd code per Nicolin
> - consolidate two patches and drop as.c
> - typo error fix and function rename
>
> I didn't list change log of rfc stage, see [3] if anyone is interested.
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
> [2] https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v1
> [3] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02529.html

Do you have a branch to share?

It does not apply to upstream

Thanks

Eric
>
>
> --------------------------------------------------------------------------
>
> With the introduction of iommufd, the Linux kernel provides a generic
> interface for userspace drivers to propagate their DMA mappings to kernel
> for assigned devices. This series does the porting of the VFIO devices
> onto the /dev/iommu uapi and let it coexist with the legacy implementation.
>
> This QEMU integration is the result of a collaborative work between
> Yi Liu, Yi Sun, Nicolin Chen and Eric Auger.
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
> Thanks,
> Yi, Yi, Eric, Zhenzhong
>
>
> Eric Auger (8):
>   scripts/update-linux-headers: Add iommufd.h
>   vfio/common: Introduce vfio_container_add|del_section_window()
>   vfio/container: Introduce vfio_[attach/detach]_device
>   vfio/platform: Use vfio_[attach/detach]_device
>   vfio/ap: Use vfio_[attach/detach]_device
>   vfio/ccw: Use vfio_[attach/detach]_device
>   backends/iommufd: Introduce the iommufd object
>   vfio/pci: Allow the selection of a given iommu backend
>
> Yi Liu (5):
>   vfio/common: Move IOMMU agnostic helpers to a separate file
>   vfio/common: Move legacy VFIO backend code into separate container.c
>   vfio: Add base container
>   util/char_dev: Add open_cdev()
>   vfio/iommufd: Implement the iommufd backend
>
> Zhenzhong Duan (9):
>   Update linux-header to support iommufd cdev and hwpt alloc
>   vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>   vfio/common: Add a vfio device iterator
>   vfio/common: Refactor vfio_viommu_preset() to be group agnostic
>   vfio/common: Simplify vfio_viommu_preset()
>   Add iommufd configure option
>   vfio/iommufd: Add vfio device iterator callback for iommufd
>   vfio/pci: Adapt vfio pci hot reset support with iommufd BE
>   vfio/pci: Make vfio cdev pre-openable by passing a file handle
>
>  MAINTAINERS                           |   13 +
>  backends/Kconfig                      |    4 +
>  backends/iommufd.c                    |  291 ++++
>  backends/meson.build                  |    3 +
>  backends/trace-events                 |   13 +
>  hw/vfio/ap.c                          |   68 +-
>  hw/vfio/ccw.c                         |  120 +-
>  hw/vfio/common.c                      | 1948 +++----------------------
>  hw/vfio/container-base.c              |  160 ++
>  hw/vfio/container.c                   | 1208 +++++++++++++++
>  hw/vfio/helpers.c                     |  626 ++++++++
>  hw/vfio/iommufd.c                     |  554 +++++++
>  hw/vfio/meson.build                   |    6 +
>  hw/vfio/pci.c                         |  319 +++-
>  hw/vfio/platform.c                    |   43 +-
>  hw/vfio/spapr.c                       |   22 +-
>  hw/vfio/trace-events                  |   21 +-
>  include/hw/vfio/vfio-common.h         |  111 +-
>  include/hw/vfio/vfio-container-base.h |  158 ++
>  include/qemu/char_dev.h               |   16 +
>  include/standard-headers/linux/fuse.h |    3 +
>  include/sysemu/iommufd.h              |   49 +
>  linux-headers/linux/iommufd.h         |  444 ++++++
>  linux-headers/linux/kvm.h             |   13 +-
>  linux-headers/linux/vfio.h            |  148 +-
>  meson.build                           |    6 +
>  meson_options.txt                     |    2 +
>  qapi/qom.json                         |   18 +-
>  qemu-options.hx                       |   13 +
>  scripts/meson-buildoptions.sh         |    3 +
>  scripts/update-linux-headers.sh       |    3 +-
>  util/chardev_open.c                   |   61 +
>  util/meson.build                      |    1 +
>  33 files changed, 4395 insertions(+), 2073 deletions(-)
>  create mode 100644 backends/iommufd.c
>  create mode 100644 hw/vfio/container-base.c
>  create mode 100644 hw/vfio/container.c
>  create mode 100644 hw/vfio/helpers.c
>  create mode 100644 hw/vfio/iommufd.c
>  create mode 100644 include/hw/vfio/vfio-container-base.h
>  create mode 100644 include/qemu/char_dev.h
>  create mode 100644 include/sysemu/iommufd.h
>  create mode 100644 linux-headers/linux/iommufd.h
>  create mode 100644 util/chardev_open.c
>


