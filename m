Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D7AC9FA5
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Jun 2025 19:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLmS5-0002z1-B8; Sun, 01 Jun 2025 13:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLmRu-0002yS-Hq
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 13:26:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLmRr-0007Cd-65
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 13:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748798772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tlznJHM3fvHD30nSislQ6xI1auKC3qJrYEidhsJg5RA=;
 b=an4BqYas7wLbtOx53W9q47fWq8A+jdKn5ORQiHotyGjc6qYrdT1VjJMD23zqDiWW8T/n4+
 /Ly2AfoMYo0y1qwYRsV09wC4OdLGj90zHw43IbTTn15ci9gymrv/V2d8P7aQhQ2vreCS2y
 ZRyDkgiVmJnQNaBD6u9iCrshEntO4RQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247--Rd9mI4cMK-Ws2JQR6qgkQ-1; Sun, 01 Jun 2025 13:26:11 -0400
X-MC-Unique: -Rd9mI4cMK-Ws2JQR6qgkQ-1
X-Mimecast-MFC-AGG-ID: -Rd9mI4cMK-Ws2JQR6qgkQ_1748798770
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442e0e6eb84so21449245e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 10:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748798770; x=1749403570;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlznJHM3fvHD30nSislQ6xI1auKC3qJrYEidhsJg5RA=;
 b=WV6QF9xU6FiJZ4dTwMR2Tnqn+1d/y1KufDUxd5Qleid6RhlMWIhHcmpg1RaXNv/5+g
 khit8kuMSDX0HsVyDuVSUpIN/jPUoqvUJwf+t6L6j2yRJUfVMzZM6PgP34FXyLjJRyec
 4JrydOVYk03Xxih1Uv07O74R5sISz7JHeoTgA1H1erWBT5Ba5FkQDYu6p0JNwpCQ7XLV
 45mP68Cfl372lqF8K4UJrse6GHG9IqBFcy699dAjBlcOJ3vBQ6eo3TIOI4YZAMRujBkv
 OJ6wrwE46kEfbQ4H0la8ejYVRh4GTnJ+WvOj6mzBeGIN23Q7hehMdH30N8w9mNjlOggg
 FMYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRguC6pPgORx9rlssq71WZKknNGIMWG12vfmn4VOQymCcQrtfz6mtFoxuEmjfwwmwXTO/Ez5BkWLoF@nongnu.org
X-Gm-Message-State: AOJu0Ywhh0YWBQJqVJqnR3lJqpBaGYNqOVRpU1VyJ7x/HtACetcAOxan
 uTGGEZ7XJ3cXUfY6+lrbv+/OQd/z9urccXBNAAzgQMCoU3E9pKCGVrW0Lzr75CV4DcJ0tCEQy89
 37w02cXnqlKbHGI6krhi8b8gkIL3pwrr3ar2oYls2TME+Y9Lh4N6JFmKr
X-Gm-Gg: ASbGncsW0ofD0g9a/SQEsjvX+u+DZb5FZT5r3XC920HJRazJbuT8WgcpjcnH6/e5WKM
 J2mH+2fAZY7nxCafbHAekPMPbaR1beVBEKjWjgjEhOwQEtvifv5weOfbIeyjB5d8BlLsO+qnYoP
 sT8w+gUdeDTxskLgFqQJq1F5hCU8DOLYe9pkUbzjp0g7zddFiIDYaP9d3eBWlxQmj9WqhuUgpcb
 AQWy3HYlCGbsZbUr5QHPznAzURz2Lk5lgiwOaq0KeaOe1ZTndVNSW+bFWSVlIpJW0JwnHkBp+ar
 Rhy5ITpcoZZX7YG7lZPZwPjrgPcjKIlS06vd9fxrFxmwyGYO5g==
X-Received: by 2002:a05:6000:1887:b0:3a4:dbac:2dc1 with SMTP id
 ffacd0b85a97d-3a4f7ab16abmr7779016f8f.54.1748798769797; 
 Sun, 01 Jun 2025 10:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHrfhvQCFHnPw7nz0WxsLAWyo+FLBbNhJQg+6CmZfLx9MnytnRDYu3HPBarpKXXQK9CMMx7A==
X-Received: by 2002:a05:6000:1887:b0:3a4:dbac:2dc1 with SMTP id
 ffacd0b85a97d-3a4f7ab16abmr7778988f8f.54.1748798769348; 
 Sun, 01 Jun 2025 10:26:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe2b35dsm12003196f8f.0.2025.06.01.10.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 10:26:08 -0700 (PDT)
Message-ID: <11cb31a6-7787-4496-8e92-758c6578b4a0@redhat.com>
Date: Sun, 1 Jun 2025 19:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/43] Live update: vfio and iommufd
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Levon <john.levon@nutanix.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/29/25 21:23, Steve Sistare wrote:
> Support vfio and iommufd devices with the cpr-transfer live migration mode.
> Devices that do not support live migration can still support cpr-transfer,
> allowing live update to a new version of QEMU on the same host, with no loss
> of guest connectivity.
> 
> No user-visible interfaces are added.
> 
> For legacy containers:
> 
> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
> skip the ioctls that configure the device, because it is already configured.
> 
> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
> QEMU and update the locked memory accounting.  The physical pages remain
> pinned, because the descriptor of the device that locked them remains open,
> so DMA to those pages continues without interruption.  Mediated devices are
> not supported, however, because they require the VA to always be valid, and
> there is a brief window where no VA is registered.
> 
> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
> data structures, and attaches the interrupts to the new KVM instance.  This
> logic also applies to iommufd containers.
> 
> For iommufd containers:
> 
> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
> backed by a file (including a memfd), so DMA mappings do not depend on VA,
> which can differ after live update.  This allows mediated devices to be
> supported.
> 
> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
> QEMU, during vfio_realize, skip the ioctls that configure the device, because
> it is already configured.
> 
> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
> locked memory accounting.
> 
> Patches 4 to 12 are specific to legacy containers.
> Patches 25 to 41 are specific to iommufd containers.> The remainder apply to both.

Steve,

I am considering patches 1-23 for vfio-next. This is to be able to merge
quickly a first part because we still have time ahead of us and to catch
issues early. It will also help John to rebase.

I think patch 16 can be simplified. If you agree, and Michael too, please
resend just this patch. I will update the series and send a PR.

Thanks,

C.

  




  
> Changes from previous versions:
>    * V1 of this series contains minor changes from the "Live update: vfio" and
>      "Live update: iommufd" series, mainly bug fixes and refactored patches.
> 
> Changes in V2:
>    * refactored various vfio code snippets into new cpr helpers
>    * refactored vfio struct members into cpr-specific structures
>    * refactored various small changes into their own patches
>    * split complex patches.  Notably:
>      - split "refactor for cpr" into 5 patches
>      - split "reconstruct device" into 4 patches
>    * refactored vfio_connect_container using helpers and made its
>      error recovery more robust.
>    * moved vfio pci msi/vector/intx cpr functions to cpr.c
>    * renamed "reused" to cpr_reused and cpr.reused
>    * squashed vfio_cpr_[un]register_container to their call sites
>    * simplified iommu_type setting after cpr
>    * added cpr_open_fd and cpr_is_incoming helpers
>    * removed changes from vfio_legacy_dma_map, and instead temporarily
>      override dma_map and dma_unmap ops.
>    * deleted error_report and returned Error to callers where possible.
>    * simplified the memory_get_xlat_addr interface
>    * fixed flags passed to iommufd_backend_alloc_hwpt
>    * defined MIG_PRI_UNINITIALIZED
>    * added maintainers
> 
> Changes in V3:
>    * removed cleanup patches that were already pulled
>    * rebased to latest master
> 
> Changes in V4:
>    * added SPDX-License-Identifier
>    * patch "vfio/container: preserve descriptors"
>      - rewrote search loop in vfio_container_connect
>      - do not return pfd from vfio_cpr_container_match
>      - add helper for VFIO_GROUP_GET_DEVICE_FD
>    * deleted patch "export vfio_legacy_dma_map"
>    * patch "vfio/container: restore DMA vaddr"
>      - deleted redundant error_report from vfio_legacy_cpr_dma_map
>      - save old dma_map function
>    * patch "vfio-pci: skip reset during cpr"
>      - use cpr_is_incoming instead of cpr_reused
>    * renamed err -> local_err in all new code
>    * patch "export MSI functions"
>      -  renamed with vfio_pci prefix, and defined wrappers for low level
>         routines instead of exporting them.
>    * patch "close kvm after cpr"
>      - fixed build error for !CONFIG_KVM
>    * added the cpr_resave_fd helper
>    * dropped patch "pass ramblock to vfio_container_dma_map", relying on
>      "pass MemoryRegion" from the vfio-user series instead.
>    * deleted "reused" variables, replaced with cpr_is_incoming()
>    * renamed cpr_needed_for_reuse -> cpr_incoming_needed
>    * rewrote patch "pci: skip reset during cpr"
>    * rebased to latest master
> 
>    for iommufd:
>      * deleted redundant error_report from iommufd_backend_map_file_dma
>      * added interface doc for dma_map_file
>      * check return value of cpr_open_fd
>      * deleted "export iommufd_cdev_get_info_iova_range"
>      * deleted "reconstruct device"
>      * deleted "reconstruct hw_caps"
>      * deleted "define hwpt constructors"
>      * seperated cpr registration for iommufd be and vfio container
>      * correctly attach to multiple containers per iommufd using ioas_id
>      * simplified "reconstruct hwpt" by matching against hwpt_id.
>      * added patch "add vfio_device_free_name"
> 
> 
> Steve Sistare (43):
>    MAINTAINERS: Add reviewer for CPR
>    vfio: return mr from vfio_get_xlat_addr
>    vfio/container: pass MemoryRegion to DMA operations
>    vfio/pci: vfio_pci_put_device on failure
>    migration: cpr helpers
>    migration: lower handler priority
>    vfio: vfio_find_ram_discard_listener
>    vfio: move vfio-cpr.h
>    vfio/container: register container for cpr
>    vfio/container: preserve descriptors
>    vfio/container: discard old DMA vaddr
>    vfio/container: restore DMA vaddr
>    vfio/container: mdev cpr blocker
>    vfio/container: recover from unmap-all-vaddr failure
>    pci: export msix_is_pending
>    pci: skip reset during cpr
>    vfio-pci: skip reset during cpr
>    vfio/pci: vfio_pci_vector_init
>    vfio/pci: vfio_notifier_init
>    vfio/pci: pass vector to virq functions
>    vfio/pci: vfio_notifier_init cpr parameters
>    vfio/pci: vfio_notifier_cleanup
>    vfio/pci: export MSI functions
>    vfio-pci: preserve MSI
>    vfio-pci: preserve INTx
>    migration: close kvm after cpr
>    migration: cpr_get_fd_param helper
>    backends/iommufd: iommufd_backend_map_file_dma
>    backends/iommufd: change process ioctl
>    physmem: qemu_ram_get_fd_offset
>    vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>    vfio/iommufd: invariant device name
>    vfio/iommufd: add vfio_device_free_name
>    vfio/iommufd: device name blocker
>    vfio/iommufd: register container for cpr
>    migration: vfio cpr state hook
>    vfio/iommufd: cpr state
>    vfio/iommufd: preserve descriptors
>    vfio/iommufd: reconstruct device
>    vfio/iommufd: reconstruct hwpt
>    vfio/iommufd: change process
>    iommufd: preserve DMA mappings
>    vfio/container: delete old cpr register
> 
>   MAINTAINERS                           |  10 ++
>   hw/vfio/pci.h                         |  10 ++
>   hw/vfio/vfio-cpr.h                    |  15 --
>   include/exec/cpu-common.h             |   1 +
>   include/hw/pci/msix.h                 |   1 +
>   include/hw/pci/pci_device.h           |   3 +
>   include/hw/vfio/vfio-container-base.h |  38 ++++-
>   include/hw/vfio/vfio-container.h      |   2 +
>   include/hw/vfio/vfio-cpr.h            |  78 +++++++++
>   include/hw/vfio/vfio-device.h         |   5 +
>   include/migration/cpr.h               |  21 +++
>   include/migration/vmstate.h           |   6 +-
>   include/system/iommufd.h              |   6 +
>   include/system/kvm.h                  |   1 +
>   include/system/memory.h               |  19 ++-
>   accel/kvm/kvm-all.c                   |  28 ++++
>   accel/stubs/kvm-stub.c                |   5 +
>   backends/iommufd.c                    | 101 +++++++++++-
>   hw/pci/msix.c                         |   2 +-
>   hw/pci/pci.c                          |   5 +
>   hw/vfio/ap.c                          |   2 +-
>   hw/vfio/ccw.c                         |   2 +-
>   hw/vfio/container-base.c              |  13 +-
>   hw/vfio/container.c                   | 101 +++++++++---
>   hw/vfio/cpr-iommufd.c                 | 220 ++++++++++++++++++++++++++
>   hw/vfio/cpr-legacy.c                  | 288 ++++++++++++++++++++++++++++++++++
>   hw/vfio/cpr.c                         | 161 +++++++++++++++++--
>   hw/vfio/device.c                      |  40 +++--
>   hw/vfio/helpers.c                     |  10 ++
>   hw/vfio/iommufd.c                     |  86 ++++++++--
>   hw/vfio/listener.c                    |  93 +++++++----
>   hw/vfio/pci.c                         | 232 ++++++++++++++++++++-------
>   hw/vfio/platform.c                    |   2 +-
>   hw/vfio/vfio-stubs.c                  |  13 ++
>   hw/virtio/vhost-vdpa.c                |   9 +-
>   migration/cpr-transfer.c              |  18 +++
>   migration/cpr.c                       |  95 +++++++++--
>   migration/migration.c                 |   1 +
>   migration/savevm.c                    |   4 +-
>   system/memory.c                       |  32 +---
>   system/physmem.c                      |   5 +
>   backends/trace-events                 |   2 +
>   hw/vfio/meson.build                   |   4 +
>   43 files changed, 1576 insertions(+), 214 deletions(-)
>   delete mode 100644 hw/vfio/vfio-cpr.h
>   create mode 100644 include/hw/vfio/vfio-cpr.h
>   create mode 100644 hw/vfio/cpr-iommufd.c
>   create mode 100644 hw/vfio/cpr-legacy.c
>   create mode 100644 hw/vfio/vfio-stubs.c
> 
> base-commit: d2e9b78162e31b1eaf20f3a4f563da82da56908d


