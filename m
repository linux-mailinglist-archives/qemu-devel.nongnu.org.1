Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23757A6991
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:24:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieS3-0002Vi-4K; Tue, 19 Sep 2023 13:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qieRx-0002Us-Tb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qieRt-0000oV-3m
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695144224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSrSoMlS3OSzm/1NY2x3NYjN7NiqVMWmYdHVWYCxB1c=;
 b=Rx3pp30zmlVIgn93ra/W2OFoNeFGIHQ7/WZ2NDOIFLY2NYoJkGvUVZxqvzEQ+0qaiflwL0
 B2FBvg4dBDPuVBjyjN9XX0BrqU2JCaPjDfCpOWuLbT62qPuZKJYWItYUhXe5epCk8i346q
 qbNuqVIs7gNquPqH7aSb5bG8RsGLNdE=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-F712mTxON7WQoC2_vj-4Vw-1; Tue, 19 Sep 2023 13:23:42 -0400
X-MC-Unique: F712mTxON7WQoC2_vj-4Vw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7a4f58bd3d4so2182174241.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695144222; x=1695749022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSrSoMlS3OSzm/1NY2x3NYjN7NiqVMWmYdHVWYCxB1c=;
 b=RbPz0+77j3x6IlLA34Nj7xS0tZ2XmcnW24NBPEUKgD/IIjL8jexYBq7ixd9YNJ7fAz
 FluKs3TAAZzsbR+boPFtMxIRW/lOGg4pD8eZeFSG/EiUM8QD+54bzZwwMmWMh7GG/eI3
 uuNIQKgZc30wwWh7Axa5asd2LJ6v5H+7hFZ3wOrs/1eHr68DoUBBg868OQi55oSejAr/
 qkzvsiRZwctutb2T9skQzl4lEPQXJWMf3zFFyNGxwjG7Ew/SwIraADlA8o4nLSMC+P9P
 hf6pyrHyw4Rho9lUubxHQxOBbD+aZmIqwN25/peZGiEdUg1mYzX80UvhqIDXRWEl2cA5
 wNuw==
X-Gm-Message-State: AOJu0YxwZ6nI0WlWA1ZGed8M2LTA1kmPQ9rBNmcTVagmLHhqdkhitEL7
 sHa+wfLeuV76C4wiWlfZj98xdUB2ymbcZ/ibC3FJmX6Ivf8A81NwSnHmMGLzlYXB0LecfgiRgeD
 VwnFDudkYSwILPlg=
X-Received: by 2002:a67:e2d7:0:b0:451:64e:4645 with SMTP id
 i23-20020a67e2d7000000b00451064e4645mr549948vsm.12.1695144221780; 
 Tue, 19 Sep 2023 10:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjPidB8749vSbjbp3f4ricdqNsrVJGsH9qUNpUOy430L7OUM+2Cx/Yt1UslmsK4aFqzVGgyQ==
X-Received: by 2002:a67:e2d7:0:b0:451:64e:4645 with SMTP id
 i23-20020a67e2d7000000b00451064e4645mr549913vsm.12.1695144221222; 
 Tue, 19 Sep 2023 10:23:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a0cf50e000000b0065862497fd2sm525387qvm.22.2023.09.19.10.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 10:23:40 -0700 (PDT)
Message-ID: <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
Date: Tue, 19 Sep 2023 19:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 13/22] vfio: Add base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Abstract the VFIOContainer to be a base object. It is supposed to be
> embedded by legacy VFIO container and later on, into the new iommufd
> based container.
> 
> The base container implements generic code such as code related to
> memory_listener and address space management. The VFIOContainerOps
> implements callbacks that depend on the kernel user space being used.
> 
> 'common.c' and vfio device code only manipulates the base container with
> wrapper functions that calls the functions defined in VFIOContainerOpsClass.
> Existing 'container.c' code is converted to implement the legacy container
> ops functions.
> 
> Below is the base container. It's named as VFIOContainer, old VFIOContainer
> is replaced with VFIOLegacyContainer.

Usualy, we introduce the new interface solely, port the current models
on top of the new interface, wire the new models in the current
implementation and remove the old implementation. Then, we can start
adding extensions to support other implementations.

spapr should be taken care of separatly following the principle above.
With my PPC hat, I would not even read such a massive change, too risky
for the subsystem. This path will need (much) further splitting to be
understandable and acceptable.

Also, please include the .h file first, it helps in reading. Have you
considered using an InterfaceClass ?

Thanks,

C.

> 
> struct VFIOContainer {
>      VFIOIOMMUBackendOpsClass *ops;
>      VFIOAddressSpace *space;
>      MemoryListener listener;
>      Error *error;
>      bool initialized;
>      bool dirty_pages_supported;
>      uint64_t dirty_pgsizes;
>      uint64_t max_dirty_bitmap_size;
>      unsigned long pgsizes;
>      unsigned int dma_max_mappings;
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>      QLIST_ENTRY(VFIOContainer) next;
> };
> 
> struct VFIOLegacyContainer {
>      VFIOContainer bcontainer;
>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>      MemoryListener prereg_listener;
>      unsigned iommu_type;
>      QLIST_HEAD(, VFIOGroup) group_list;
> };
> 
> Co-authored-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/common.c                      |  72 +++++---
>   hw/vfio/container-base.c              | 160 +++++++++++++++++
>   hw/vfio/container.c                   | 247 ++++++++++++++++----------
>   hw/vfio/meson.build                   |   1 +
>   hw/vfio/spapr.c                       |  22 +--
>   hw/vfio/trace-events                  |   4 +-
>   include/hw/vfio/vfio-common.h         |  85 ++-------
>   include/hw/vfio/vfio-container-base.h | 155 ++++++++++++++++
>   8 files changed, 540 insertions(+), 206 deletions(-)
>   create mode 100644 hw/vfio/container-base.c
>   create mode 100644 include/hw/vfio/vfio-container-base.h
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 044710fc1f..86b6af5740 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -379,19 +379,20 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>            * of vaddr will always be there, even if the memory object is
>            * destroyed and its backing memory munmap-ed.
>            */
> -        ret = vfio_dma_map(container, iova,
> -                           iotlb->addr_mask + 1, vaddr,
> -                           read_only);
> +        ret = vfio_container_dma_map(container, iova,
> +                                     iotlb->addr_mask + 1, vaddr,
> +                                     read_only);
>           if (ret) {
> -            error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
>                            container, iova,
>                            iotlb->addr_mask + 1, vaddr, ret, strerror(-ret));
>           }
>       } else {
> -        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
> +        ret = vfio_container_dma_unmap(container, iova,
> +                                       iotlb->addr_mask + 1, iotlb);
>           if (ret) {
> -            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
>                            container, iova,
>                            iotlb->addr_mask + 1, ret, strerror(-ret));
> @@ -407,14 +408,15 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>   {
>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>                                                   listener);
> +    VFIOContainer *container = vrdl->container;
>       const hwaddr size = int128_get64(section->size);
>       const hwaddr iova = section->offset_within_address_space;
>       int ret;
>   
>       /* Unmap with a single call. */
> -    ret = vfio_dma_unmap(vrdl->container, iova, size , NULL);
> +    ret = vfio_container_dma_unmap(container, iova, size , NULL);
>       if (ret) {
> -        error_report("%s: vfio_dma_unmap() failed: %s", __func__,
> +        error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
>                        strerror(-ret));
>       }
>   }
> @@ -424,6 +426,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>   {
>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>                                                   listener);
> +    VFIOContainer *container = vrdl->container;
>       const hwaddr end = section->offset_within_region +
>                          int128_get64(section->size);
>       hwaddr start, next, iova;
> @@ -442,8 +445,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                  section->offset_within_address_space;
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
> -        ret = vfio_dma_map(vrdl->container, iova, next - start,
> -                           vaddr, section->readonly);
> +        ret = vfio_container_dma_map(container, iova, next - start,
> +                                     vaddr, section->readonly);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -756,10 +759,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           }
>       }
>   
> -    ret = vfio_dma_map(container, iova, int128_get64(llsize),
> -                       vaddr, section->readonly);
> +    ret = vfio_container_dma_map(container, iova, int128_get64(llsize),
> +                                 vaddr, section->readonly);
>       if (ret) {
> -        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> +        error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
>                      container, iova, int128_get64(llsize), vaddr, ret,
>                      strerror(-ret));
> @@ -775,7 +778,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>   
>   fail:
>       if (memory_region_is_ram_device(section->mr)) {
> -        error_report("failed to vfio_dma_map. pci p2p may not work");
> +        error_report("failed to vfio_container_dma_map. pci p2p may not work");
>           return;
>       }
>       /*
> @@ -860,18 +863,20 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           if (int128_eq(llsize, int128_2_64())) {
>               /* The unmap ioctl doesn't accept a full 64-bit span. */
>               llsize = int128_rshift(llsize, 1);
> -            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
> +            ret = vfio_container_dma_unmap(container, iova,
> +                                           int128_get64(llsize), NULL);
>               if (ret) {
> -                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                                "0x%"HWADDR_PRIx") = %d (%s)",
>                                container, iova, int128_get64(llsize), ret,
>                                strerror(-ret));
>               }
>               iova += int128_get64(llsize);
>           }
> -        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
> +        ret = vfio_container_dma_unmap(container, iova,
> +                                       int128_get64(llsize), NULL);
>           if (ret) {
> -            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
>                            container, iova, int128_get64(llsize), ret,
>                            strerror(-ret));
> @@ -1103,7 +1108,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
>       if (vfio_devices_all_device_dirty_tracking(container)) {
>           ret = vfio_devices_dma_logging_start(container);
>       } else {
> -        ret = vfio_set_dirty_page_tracking(container, true);
> +        ret = vfio_container_set_dirty_page_tracking(container, true);
>       }
>   
>       if (ret) {
> @@ -1121,7 +1126,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>       if (vfio_devices_all_device_dirty_tracking(container)) {
>           vfio_devices_dma_logging_stop(container);
>       } else {
> -        ret = vfio_set_dirty_page_tracking(container, false);
> +        ret = vfio_container_set_dirty_page_tracking(container, false);
>       }
>   
>       if (ret) {
> @@ -1204,7 +1209,7 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       if (all_device_dirty_tracking) {
>           ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
>       } else {
> -        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(container, &vbmap, iova, size);
>       }
>   
>       if (ret) {
> @@ -1214,8 +1219,7 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>                                                            vbmap.pages);
>   
> -    trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
> -                                ram_addr, dirty_pages);
> +    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
>   out:
>       g_free(vbmap.bitmap);
>   
> @@ -1525,3 +1529,25 @@ retry:
>   
>       return info;
>   }
> +
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp)
> +{
> +    const VFIOIOMMUBackendOpsClass *ops;
> +
> +    ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
> +                  object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
> +    if (!ops) {
> +        error_setg(errp, "VFIO IOMMU Backend not found!");
> +        return -ENODEV;
> +    }
> +    return ops->attach_device(name, vbasedev, as, errp);
> +}
> +
> +void vfio_detach_device(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->container) {
> +        return;
> +    }
> +    vbasedev->container->ops->detach_device(vbasedev);
> +}
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> new file mode 100644
> index 0000000000..876e95c6dd
> --- /dev/null
> +++ b/hw/vfio/container-base.c
> @@ -0,0 +1,160 @@
> +/*
> + * VFIO BASE CONTAINER
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/vfio/vfio-container-base.h"
> +
> +VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
> +                                 VFIODevice *curr)
> +{
> +    if (!container->ops->dev_iter_next) {
> +        return NULL;
> +    }
> +
> +    return container->ops->dev_iter_next(container, curr);
> +}
> +
> +int vfio_container_dma_map(VFIOContainer *container,
> +                           hwaddr iova, ram_addr_t size,
> +                           void *vaddr, bool readonly)
> +{
> +    if (!container->ops->dma_map) {
> +        return -EINVAL;
> +    }
> +
> +    return container->ops->dma_map(container, iova, size, vaddr, readonly);
> +}
> +
> +int vfio_container_dma_unmap(VFIOContainer *container,
> +                             hwaddr iova, ram_addr_t size,
> +                             IOMMUTLBEntry *iotlb)
> +{
> +    if (!container->ops->dma_unmap) {
> +        return -EINVAL;
> +    }
> +
> +    return container->ops->dma_unmap(container, iova, size, iotlb);
> +}
> +
> +int vfio_container_set_dirty_page_tracking(VFIOContainer *container,
> +                                            bool start)
> +{
> +    /* Fallback to all pages dirty if dirty page sync isn't supported */
> +    if (!container->ops->set_dirty_page_tracking) {
> +        return 0;
> +    }
> +
> +    return container->ops->set_dirty_page_tracking(container, start);
> +}
> +
> +int vfio_container_query_dirty_bitmap(VFIOContainer *container,
> +                                      VFIOBitmap *vbmap,
> +                                      hwaddr iova, hwaddr size)
> +{
> +    if (!container->ops->query_dirty_bitmap) {
> +        return -EINVAL;
> +    }
> +
> +    return container->ops->query_dirty_bitmap(container, vbmap, iova, size);
> +}
> +
> +int vfio_container_add_section_window(VFIOContainer *container,
> +                                      MemoryRegionSection *section,
> +                                      Error **errp)
> +{
> +    if (!container->ops->add_window) {
> +        return 0;
> +    }
> +
> +    return container->ops->add_window(container, section, errp);
> +}
> +
> +void vfio_container_del_section_window(VFIOContainer *container,
> +                                       MemoryRegionSection *section)
> +{
> +    if (!container->ops->del_window) {
> +        return;
> +    }
> +
> +    return container->ops->del_window(container, section);
> +}
> +
> +void vfio_container_init(VFIOContainer *container,
> +                         VFIOAddressSpace *space,
> +                         struct VFIOIOMMUBackendOpsClass *ops)
> +{
> +    container->ops = ops;
> +    container->space = space;
> +    container->error = NULL;
> +    container->dirty_pages_supported = false;
> +    container->dma_max_mappings = 0;
> +    QLIST_INIT(&container->giommu_list);
> +    QLIST_INIT(&container->hostwin_list);
> +    QLIST_INIT(&container->vrdl_list);
> +}
> +
> +void vfio_container_destroy(VFIOContainer *container)
> +{
> +    VFIORamDiscardListener *vrdl, *vrdl_tmp;
> +    VFIOGuestIOMMU *giommu, *tmp;
> +    VFIOHostDMAWindow *hostwin, *next;
> +
> +    QLIST_SAFE_REMOVE(container, next);
> +
> +    QLIST_FOREACH_SAFE(vrdl, &container->vrdl_list, next, vrdl_tmp) {
> +        RamDiscardManager *rdm;
> +
> +        rdm = memory_region_get_ram_discard_manager(vrdl->mr);
> +        ram_discard_manager_unregister_listener(rdm, &vrdl->listener);
> +        QLIST_REMOVE(vrdl, next);
> +        g_free(vrdl);
> +    }
> +
> +    QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> +        memory_region_unregister_iommu_notifier(
> +                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> +        QLIST_REMOVE(giommu, giommu_next);
> +        g_free(giommu);
> +    }
> +
> +    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
> +                       next) {
> +        QLIST_REMOVE(hostwin, hostwin_next);
> +        g_free(hostwin);
> +    }
> +}
> +
> +static const TypeInfo vfio_iommu_backend_ops_type_info = {
> +    .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
> +    .parent = TYPE_OBJECT,
> +    .abstract = true,
> +    .class_size = sizeof(VFIOIOMMUBackendOpsClass),
> +};
> +
> +static void vfio_iommu_backend_ops_register_types(void)
> +{
> +    type_register_static(&vfio_iommu_backend_ops_type_info);
> +}
> +type_init(vfio_iommu_backend_ops_register_types);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c71fddc09a..bb29b3612d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -42,7 +42,8 @@
>   VFIOGroupList vfio_group_list =
>       QLIST_HEAD_INITIALIZER(vfio_group_list);
>   
> -static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
> +static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
> +                                          bool state)
>   {
>       switch (container->iommu_type) {
>       case VFIO_TYPE1v2_IOMMU:
> @@ -65,11 +66,18 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
>       }
>   }
>   
> -VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
> -                                         VFIODevice *curr)
> +static VFIODevice *vfio_legacy_dev_iter_next(VFIOContainer *bcontainer,
> +                                             VFIODevice *curr)
>   {
>       VFIOGroup *group;
>   
> +    assert(object_class_dynamic_cast(OBJECT_CLASS(bcontainer->ops),
> +                                     TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
> +
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
> +
>       if (!curr) {
>           group = QLIST_FIRST(&container->group_list);
>       } else {
> @@ -85,10 +93,11 @@ VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
>       return QLIST_FIRST(&group->device_list);
>   }
>   
> -static int vfio_dma_unmap_bitmap(VFIOContainer *container,
> +static int vfio_dma_unmap_bitmap(VFIOLegacyContainer *container,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
> +    VFIOContainer *bcontainer = &container->bcontainer;
>       struct vfio_iommu_type1_dma_unmap *unmap;
>       struct vfio_bitmap *bitmap;
>       VFIOBitmap vbmap;
> @@ -116,7 +125,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
>       bitmap->size = vbmap.size;
>       bitmap->data = (__u64 *)vbmap.bitmap;
>   
> -    if (vbmap.size > container->max_dirty_bitmap_size) {
> +    if (vbmap.size > bcontainer->max_dirty_bitmap_size) {
>           error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
>           ret = -E2BIG;
>           goto unmap_exit;
> @@ -140,9 +149,13 @@ unmap_exit:
>   /*
>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>    */
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> -                   ram_addr_t size, IOMMUTLBEntry *iotlb)
> +static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
> +                          ram_addr_t size, IOMMUTLBEntry *iotlb)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
> +
>       struct vfio_iommu_type1_dma_unmap unmap = {
>           .argsz = sizeof(unmap),
>           .flags = 0,
> @@ -152,9 +165,9 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>       bool need_dirty_sync = false;
>       int ret;
>   
> -    if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
> -        if (!vfio_devices_all_device_dirty_tracking(container) &&
> -            container->dirty_pages_supported) {
> +    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
> +        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> +            bcontainer->dirty_pages_supported) {
>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>           }
>   
> @@ -176,8 +189,8 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>            */
>           if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>               container->iommu_type == VFIO_TYPE1v2_IOMMU) {
> -            trace_vfio_dma_unmap_overflow_workaround();
> -            unmap.size -= 1ULL << ctz64(container->pgsizes);
> +            trace_vfio_legacy_dma_unmap_overflow_workaround();
> +            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
>               continue;
>           }
>           error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
> @@ -185,7 +198,7 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>       }
>   
>       if (need_dirty_sync) {
> -        ret = vfio_get_dirty_bitmap(container, iova, size,
> +        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>                                       iotlb->translated_addr);
>           if (ret) {
>               return ret;
> @@ -195,9 +208,13 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>       return 0;
>   }
>   
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> -                 ram_addr_t size, void *vaddr, bool readonly)
> +static int vfio_legacy_dma_map(VFIOContainer *bcontainer, hwaddr iova,
> +                               ram_addr_t size, void *vaddr, bool readonly)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
> +
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
>           .flags = VFIO_DMA_MAP_FLAG_READ,
> @@ -216,7 +233,8 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>        * the VGA ROM space.
>        */
>       if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
> +        (errno == EBUSY &&
> +         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
>            ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>           return 0;
>       }
> @@ -225,14 +243,18 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       return -errno;
>   }
>   
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
> +static int vfio_legacy_set_dirty_page_tracking(VFIOContainer *bcontainer,
> +                                               bool start)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
>       int ret;
>       struct vfio_iommu_type1_dirty_bitmap dirty = {
>           .argsz = sizeof(dirty),
>       };
>   
> -    if (!container->dirty_pages_supported) {
> +    if (!bcontainer->dirty_pages_supported) {
>           return 0;
>       }
>   
> @@ -252,9 +274,13 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
>       return ret;
>   }
>   
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> -                            hwaddr iova, hwaddr size)
> +static int vfio_legacy_query_dirty_bitmap(VFIOContainer *bcontainer,
> +                                          VFIOBitmap *vbmap,
> +                                          hwaddr iova, hwaddr size)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
>       struct vfio_iommu_type1_dirty_bitmap_get *range;
>       int ret;
> @@ -289,18 +315,24 @@ int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
>       return ret;
>   }
>   
> -static void vfio_listener_release(VFIOContainer *container)
> +static void vfio_listener_release(VFIOLegacyContainer *container)
>   {
> -    memory_listener_unregister(&container->listener);
> +    VFIOContainer *bcontainer = &container->bcontainer;
> +
> +    memory_listener_unregister(&bcontainer->listener);
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>           memory_listener_unregister(&container->prereg_listener);
>       }
>   }
>   
> -int vfio_container_add_section_window(VFIOContainer *container,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp)
> +static int
> +vfio_legacy_add_section_window(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section,
> +                               Error **errp)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
>       VFIOHostDMAWindow *hostwin;
>       hwaddr pgsize = 0;
>       int ret;
> @@ -310,7 +342,7 @@ int vfio_container_add_section_window(VFIOContainer *container,
>       }
>   
>       /* For now intersections are not allowed, we may relax this later */
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +    QLIST_FOREACH(hostwin, &bcontainer->hostwin_list, hostwin_next) {
>           if (ranges_overlap(hostwin->min_iova,
>                              hostwin->max_iova - hostwin->min_iova + 1,
>                              section->offset_within_address_space,
> @@ -332,7 +364,7 @@ int vfio_container_add_section_window(VFIOContainer *container,
>           return ret;
>       }
>   
> -    vfio_host_win_add(container, section->offset_within_address_space,
> +    vfio_host_win_add(bcontainer, section->offset_within_address_space,
>                         section->offset_within_address_space +
>                         int128_get64(section->size) - 1, pgsize);
>   #ifdef CONFIG_KVM
> @@ -365,16 +397,21 @@ int vfio_container_add_section_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -void vfio_container_del_section_window(VFIOContainer *container,
> -                                       MemoryRegionSection *section)
> +static void
> +vfio_legacy_del_section_window(VFIOContainer *bcontainer,
> +                               MemoryRegionSection *section)
>   {
> +    VFIOLegacyContainer *container = container_of(bcontainer,
> +                                                  VFIOLegacyContainer,
> +                                                  bcontainer);
> +
>       if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>           return;
>       }
>   
>       vfio_spapr_remove_window(container,
>                                section->offset_within_address_space);
> -    if (vfio_host_win_del(container,
> +    if (vfio_host_win_del(bcontainer,
>                             section->offset_within_address_space,
>                             section->offset_within_address_space +
>                             int128_get64(section->size) - 1) < 0) {
> @@ -427,7 +464,7 @@ static void vfio_kvm_device_del_group(VFIOGroup *group)
>   /*
>    * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>    */
> -static int vfio_get_iommu_type(VFIOContainer *container,
> +static int vfio_get_iommu_type(VFIOLegacyContainer *container,
>                                  Error **errp)
>   {
>       int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> @@ -443,7 +480,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
>       return -EINVAL;
>   }
>   
> -static int vfio_init_container(VFIOContainer *container, int group_fd,
> +static int vfio_init_container(VFIOLegacyContainer *container, int group_fd,
>                                  Error **errp)
>   {
>       int iommu_type, ret;
> @@ -478,7 +515,7 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
>       return 0;
>   }
>   
> -static int vfio_get_iommu_info(VFIOContainer *container,
> +static int vfio_get_iommu_info(VFIOLegacyContainer *container,
>                                  struct vfio_iommu_type1_info **info)
>   {
>   
> @@ -522,11 +559,12 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
>       return NULL;
>   }
>   
> -static void vfio_get_iommu_info_migration(VFIOContainer *container,
> -                                         struct vfio_iommu_type1_info *info)
> +static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
> +                                          struct vfio_iommu_type1_info *info)
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_iommu_type1_info_cap_migration *cap_mig;
> +    VFIOContainer *bcontainer = &container->bcontainer;
>   
>       hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
>       if (!hdr) {
> @@ -541,16 +579,19 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>        * qemu_real_host_page_size to mark those dirty.
>        */
>       if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
> -        container->dirty_pages_supported = true;
> -        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
> -        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
> +        bcontainer->dirty_pages_supported = true;
> +        bcontainer->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
> +        bcontainer->dirty_pgsizes = cap_mig->pgsize_bitmap;
>       }
>   }
>   
>   static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
> -    VFIOContainer *container;
> +    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
> +        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
> +    VFIOContainer *bcontainer;
> +    VFIOLegacyContainer *container;
>       int ret, fd;
>       VFIOAddressSpace *space;
>   
> @@ -587,7 +628,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>        * details once we know which type of IOMMU we are using.
>        */
>   
> -    QLIST_FOREACH(container, &space->containers, next) {
> +    QLIST_FOREACH(bcontainer, &space->containers, next) {
> +        container = container_of(bcontainer, VFIOLegacyContainer, bcontainer);
>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>               ret = vfio_ram_block_discard_disable(container, true);
>               if (ret) {
> @@ -623,14 +665,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       }
>   
>       container = g_malloc0(sizeof(*container));
> -    container->space = space;
>       container->fd = fd;
> -    container->error = NULL;
> -    container->dirty_pages_supported = false;
> -    container->dma_max_mappings = 0;
> -    QLIST_INIT(&container->giommu_list);
> -    QLIST_INIT(&container->hostwin_list);
> -    QLIST_INIT(&container->vrdl_list);
> +    bcontainer = &container->bcontainer;
> +    vfio_container_init(bcontainer, space, ops);
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -656,13 +693,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           }
>   
>           if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
> -            container->pgsizes = info->iova_pgsizes;
> +            bcontainer->pgsizes = info->iova_pgsizes;
>           } else {
> -            container->pgsizes = qemu_real_host_page_size();
> +            bcontainer->pgsizes = qemu_real_host_page_size();
>           }
>   
> -        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
> -            container->dma_max_mappings = 65535;
> +        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
> +            bcontainer->dma_max_mappings = 65535;
>           }
>           vfio_get_iommu_info_migration(container, info);
>           g_free(info);
> @@ -672,7 +709,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>            * information to get the actual window extent rather than assume
>            * a 64-bit IOVA address space.
>            */
> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
> +        vfio_host_win_add(bcontainer, 0, (hwaddr)-1, bcontainer->pgsizes);
>   
>           break;
>       }
> @@ -699,10 +736,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>               memory_listener_register(&container->prereg_listener,
>                                        &address_space_memory);
> -            if (container->error) {
> +            if (bcontainer->error) {
>                   memory_listener_unregister(&container->prereg_listener);
>                   ret = -1;
> -                error_propagate_prepend(errp, container->error,
> +                error_propagate_prepend(errp, bcontainer->error,
>                       "RAM memory listener initialization failed: ");
>                   goto enable_discards_exit;
>               }
> @@ -721,7 +758,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           }
>   
>           if (v2) {
> -            container->pgsizes = info.ddw.pgsizes;
> +            bcontainer->pgsizes = info.ddw.pgsizes;
>               /*
>                * There is a default window in just created container.
>                * To make region_add/del simpler, we better remove this
> @@ -736,8 +773,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>               }
>           } else {
>               /* The default table uses 4K pages */
> -            container->pgsizes = 0x1000;
> -            vfio_host_win_add(container, info.dma32_window_start,
> +            bcontainer->pgsizes = 0x1000;
> +            vfio_host_win_add(bcontainer, info.dma32_window_start,
>                                 info.dma32_window_start +
>                                 info.dma32_window_size - 1,
>                                 0x1000);
> @@ -748,28 +785,28 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       vfio_kvm_device_add_group(group);
>   
>       QLIST_INIT(&container->group_list);
> -    QLIST_INSERT_HEAD(&space->containers, container, next);
> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>   
>       group->container = container;
>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>   
> -    container->listener = vfio_memory_listener;
> +    bcontainer->listener = vfio_memory_listener;
>   
> -    memory_listener_register(&container->listener, container->space->as);
> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>   
> -    if (container->error) {
> +    if (bcontainer->error) {
>           ret = -1;
> -        error_propagate_prepend(errp, container->error,
> +        error_propagate_prepend(errp, bcontainer->error,
>               "memory listener initialization failed: ");
>           goto listener_release_exit;
>       }
>   
> -    container->initialized = true;
> +    bcontainer->initialized = true;
>   
>       return 0;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
> -    QLIST_REMOVE(container, next);
> +    QLIST_REMOVE(bcontainer, next);
>       vfio_kvm_device_del_group(group);
>       vfio_listener_release(container);
>   
> @@ -790,7 +827,8 @@ put_space_exit:
>   
>   static void vfio_disconnect_container(VFIOGroup *group)
>   {
> -    VFIOContainer *container = group->container;
> +    VFIOLegacyContainer *container = group->container;
> +    VFIOContainer *bcontainer = &container->bcontainer;
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> @@ -810,25 +848,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       }
>   
>       if (QLIST_EMPTY(&container->group_list)) {
> -        VFIOAddressSpace *space = container->space;
> -        VFIOGuestIOMMU *giommu, *tmp;
> -        VFIOHostDMAWindow *hostwin, *next;
> -
> -        QLIST_REMOVE(container, next);
> -
> -        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> -            memory_region_unregister_iommu_notifier(
> -                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> -            QLIST_REMOVE(giommu, giommu_next);
> -            g_free(giommu);
> -        }
> -
> -        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
> -                           next) {
> -            QLIST_REMOVE(hostwin, hostwin_next);
> -            g_free(hostwin);
> -        }
> +        VFIOAddressSpace *space = bcontainer->space;
>   
> +        vfio_container_destroy(bcontainer);
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);
>           g_free(container);
> @@ -840,13 +862,15 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>   {
>       VFIOGroup *group;
> +    VFIOContainer *bcontainer;
>       char path[32];
>       struct vfio_group_status status = { .argsz = sizeof(status) };
>   
>       QLIST_FOREACH(group, &vfio_group_list, next) {
>           if (group->groupid == groupid) {
>               /* Found it.  Now is it already in the right context? */
> -            if (group->container->space->as == as) {
> +            bcontainer = &group->container->bcontainer;
> +            if (bcontainer->space->as == as) {
>                   return group;
>               } else {
>                   error_setg(errp, "group %d used in multiple address spaces",
> @@ -990,7 +1014,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>   /*
>    * Interfaces for IBM EEH (Enhanced Error Handling)
>    */
> -static bool vfio_eeh_container_ok(VFIOContainer *container)
> +static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
>   {
>       /*
>        * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
> @@ -1018,7 +1042,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
>       return true;
>   }
>   
> -static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
> +static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
>   {
>       struct vfio_eeh_pe_op pe_op = {
>           .argsz = sizeof(pe_op),
> @@ -1041,19 +1065,21 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
>       return ret;
>   }
>   
> -static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
> +static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
>   {
>       VFIOAddressSpace *space = vfio_get_address_space(as);
> -    VFIOContainer *container = NULL;
> +    VFIOLegacyContainer *container = NULL;
> +    VFIOContainer *bcontainer = NULL;
>   
>       if (QLIST_EMPTY(&space->containers)) {
>           /* No containers to act on */
>           goto out;
>       }
>   
> -    container = QLIST_FIRST(&space->containers);
> +    bcontainer = QLIST_FIRST(&space->containers);
> +    container = container_of(bcontainer, VFIOLegacyContainer, bcontainer);
>   
> -    if (QLIST_NEXT(container, next)) {
> +    if (QLIST_NEXT(bcontainer, next)) {
>           /*
>            * We don't yet have logic to synchronize EEH state across
>            * multiple containers
> @@ -1069,14 +1095,14 @@ out:
>   
>   bool vfio_eeh_as_ok(AddressSpace *as)
>   {
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> +    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
>   
>       return (container != NULL) && vfio_eeh_container_ok(container);
>   }
>   
>   int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>   {
> -    VFIOContainer *container = vfio_eeh_as_container(as);
> +    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
>   
>       if (!container) {
>           return -ENODEV;
> @@ -1110,8 +1136,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>       return groupid;
>   }
>   
> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                       AddressSpace *as, Error **errp)
> +static int vfio_legacy_attach_device(char *name, VFIODevice *vbasedev,
> +                                     AddressSpace *as, Error **errp)
>   {
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
> @@ -1137,15 +1163,46 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       ret = vfio_get_device(group, name, vbasedev, errp);
>       if (ret) {
>           vfio_put_group(group);
> +        return ret;
>       }
> +    vbasedev->container = &group->container->bcontainer;
>   
>       return ret;
>   }
>   
> -void vfio_detach_device(VFIODevice *vbasedev)
> +static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);
> +    vbasedev->container = NULL;
> +}
> +
> +static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
> +                                                     void *data) {
> +    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
> +
> +    ops->dev_iter_next = vfio_legacy_dev_iter_next;
> +    ops->dma_map = vfio_legacy_dma_map;
> +    ops->dma_unmap = vfio_legacy_dma_unmap;
> +    ops->attach_device = vfio_legacy_attach_device;
> +    ops->detach_device = vfio_legacy_detach_device;
> +    ops->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
> +    ops->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
> +    ops->add_window = vfio_legacy_add_section_window;
> +    ops->del_window = vfio_legacy_del_section_window;
> +}
> +
> +static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
> +    .name = TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS,
> +
> +    .parent = TYPE_VFIO_IOMMU_BACKEND_OPS,
> +    .class_init = vfio_iommu_backend_legacy_ops_class_init,
> +    .abstract = true,
> +};
> +static void vfio_iommu_backend_legacy_ops_register_types(void)
> +{
> +    type_register_static(&vfio_iommu_backend_legacy_ops_type);
>   }
> +type_init(vfio_iommu_backend_legacy_ops_register_types);
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 2a6912c940..eb6ce6229d 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
>   vfio_ss.add(files(
>     'helpers.c',
>     'common.c',
> +  'container-base.c',
>     'container.c',
>     'spapr.c',
>     'migration.c',
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 9ec1e95f6d..7647e7d492 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -39,8 +39,8 @@ static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
>   static void vfio_prereg_listener_region_add(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
> +                                                  prereg_listener);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -83,9 +83,9 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>            * can gracefully fail.  Runtime, there's not much we can do other
>            * than throw a hardware error.
>            */
> -        if (!container->initialized) {
> -            if (!container->error) {
> -                error_setg_errno(&container->error, -ret,
> +        if (!container->bcontainer.initialized) {
> +            if (!container->bcontainer.error) {
> +                error_setg_errno(&container->bcontainer.error, -ret,
>                                    "Memory registering failed");
>               }
>           } else {
> @@ -97,8 +97,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>   static void vfio_prereg_listener_region_del(MemoryListener *listener,
>                                               MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(listener, VFIOContainer,
> -                                            prereg_listener);
> +    VFIOLegacyContainer *container = container_of(listener, VFIOLegacyContainer,
> +                                                  prereg_listener);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -141,7 +141,7 @@ const MemoryListener vfio_prereg_listener = {
>       .region_del = vfio_prereg_listener_region_del,
>   };
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> +int vfio_spapr_create_window(VFIOLegacyContainer *container,
>                                MemoryRegionSection *section,
>                                hwaddr *pgsize)
>   {
> @@ -159,13 +159,13 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       if (pagesize > rampagesize) {
>           pagesize = rampagesize;
>       }
> -    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
> +    pgmask = container->bcontainer.pgsizes & (pagesize | (pagesize - 1));
>       pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>       if (!pagesize) {
>           error_report("Host doesn't support page size 0x%"PRIx64
>                        ", the supported mask is 0x%lx",
>                        memory_region_iommu_get_min_page_size(iommu_mr),
> -                     container->pgsizes);
> +                     container->bcontainer.pgsizes);
>           return -EINVAL;
>       }
>   
> @@ -233,7 +233,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -int vfio_spapr_remove_window(VFIOContainer *container,
> +int vfio_spapr_remove_window(VFIOLegacyContainer *container,
>                                hwaddr offset_within_address_space)
>   {
>       struct vfio_iommu_spapr_tce_remove remove = {
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index bd32970854..1692bcd8f1 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -119,8 +119,8 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
>   vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
> -vfio_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
> +vfio_legacy_dma_unmap_overflow_workaround(void) ""
> +vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # platform.c
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 95bcafdaf6..b1a76dcc9c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -30,6 +30,7 @@
>   #include <linux/vfio.h>
>   #endif
>   #include "sysemu/sysemu.h"
> +#include "hw/vfio/vfio-container-base.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -74,64 +75,22 @@ typedef struct VFIOMigration {
>       bool initial_data_sent;
>   } VFIOMigration;
>   
> -typedef struct VFIOAddressSpace {
> -    AddressSpace *as;
> -    QLIST_HEAD(, VFIOContainer) containers;
> -    QLIST_ENTRY(VFIOAddressSpace) list;
> -} VFIOAddressSpace;
> -
>   struct VFIOGroup;
>   
> -typedef struct VFIOContainer {
> -    VFIOAddressSpace *space;
> +typedef struct VFIOLegacyContainer {
> +    VFIOContainer bcontainer;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
> -    MemoryListener listener;
>       MemoryListener prereg_listener;
>       unsigned iommu_type;
> -    Error *error;
> -    bool initialized;
> -    bool dirty_pages_supported;
> -    uint64_t dirty_pgsizes;
> -    uint64_t max_dirty_bitmap_size;
> -    unsigned long pgsizes;
> -    unsigned int dma_max_mappings;
> -    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
> -    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> -    QLIST_ENTRY(VFIOContainer) next;
> -} VFIOContainer;
> -
> -typedef struct VFIOGuestIOMMU {
> -    VFIOContainer *container;
> -    IOMMUMemoryRegion *iommu_mr;
> -    hwaddr iommu_offset;
> -    IOMMUNotifier n;
> -    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
> -} VFIOGuestIOMMU;
> -
> -typedef struct VFIORamDiscardListener {
> -    VFIOContainer *container;
> -    MemoryRegion *mr;
> -    hwaddr offset_within_address_space;
> -    hwaddr size;
> -    uint64_t granularity;
> -    RamDiscardListener listener;
> -    QLIST_ENTRY(VFIORamDiscardListener) next;
> -} VFIORamDiscardListener;
> -
> -typedef struct VFIOHostDMAWindow {
> -    hwaddr min_iova;
> -    hwaddr max_iova;
> -    uint64_t iova_pgsizes;
> -    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
> -} VFIOHostDMAWindow;
> +} VFIOLegacyContainer;
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
>   
>   typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
>       struct VFIOGroup *group;
> +    VFIOContainer *container;
>       char *sysfsdev;
>       char *name;
>       DeviceState *dev;
> @@ -165,7 +124,7 @@ struct VFIODeviceOps {
>   typedef struct VFIOGroup {
>       int fd;
>       int groupid;
> -    VFIOContainer *container;
> +    VFIOLegacyContainer *container;
>       QLIST_HEAD(, VFIODevice) device_list;
>       QLIST_ENTRY(VFIOGroup) next;
>       QLIST_ENTRY(VFIOGroup) container_next;
> @@ -198,37 +157,13 @@ typedef struct VFIODisplay {
>       } dmabuf;
>   } VFIODisplay;
>   
> -typedef struct {
> -    unsigned long *bitmap;
> -    hwaddr size;
> -    hwaddr pages;
> -} VFIOBitmap;
> -
> -void vfio_host_win_add(VFIOContainer *container,
> +void vfio_host_win_add(VFIOContainer *bcontainer,
>                          hwaddr min_iova, hwaddr max_iova,
>                          uint64_t iova_pgsizes);
> -int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
> +int vfio_host_win_del(VFIOContainer *bcontainer, hwaddr min_iova,
>                         hwaddr max_iova);
>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
> -bool vfio_devices_all_running_and_saving(VFIOContainer *container);
> -
> -/* container->fd */
> -VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
> -                                         VFIODevice *curr);
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> -                   ram_addr_t size, IOMMUTLBEntry *iotlb);
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> -                 ram_addr_t size, void *vaddr, bool readonly);
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> -                            hwaddr iova, hwaddr size);
> -
> -int vfio_container_add_section_window(VFIOContainer *container,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp);
> -void vfio_container_del_section_window(VFIOContainer *container,
> -                                       MemoryRegionSection *section);
>   
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
> @@ -285,10 +220,10 @@ vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
>   #endif
>   extern const MemoryListener vfio_prereg_listener;
>   
> -int vfio_spapr_create_window(VFIOContainer *container,
> +int vfio_spapr_create_window(VFIOLegacyContainer *container,
>                                MemoryRegionSection *section,
>                                hwaddr *pgsize);
> -int vfio_spapr_remove_window(VFIOContainer *container,
> +int vfio_spapr_remove_window(VFIOLegacyContainer *container,
>                                hwaddr offset_within_address_space);
>   
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> new file mode 100644
> index 0000000000..b18fa92146
> --- /dev/null
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -0,0 +1,155 @@
> +/*
> + * VFIO BASE CONTAINER
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
> +
> +#include "exec/memory.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/hwaddr.h"
> +#endif
> +
> +typedef struct VFIOContainer VFIOContainer;
> +
> +typedef struct VFIOAddressSpace {
> +    AddressSpace *as;
> +    QLIST_HEAD(, VFIOContainer) containers;
> +    QLIST_ENTRY(VFIOAddressSpace) list;
> +} VFIOAddressSpace;
> +
> +typedef struct VFIOGuestIOMMU {
> +    VFIOContainer *container;
> +    IOMMUMemoryRegion *iommu_mr;
> +    hwaddr iommu_offset;
> +    IOMMUNotifier n;
> +    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
> +} VFIOGuestIOMMU;
> +
> +typedef struct VFIORamDiscardListener {
> +    VFIOContainer *container;
> +    MemoryRegion *mr;
> +    hwaddr offset_within_address_space;
> +    hwaddr size;
> +    uint64_t granularity;
> +    RamDiscardListener listener;
> +    QLIST_ENTRY(VFIORamDiscardListener) next;
> +} VFIORamDiscardListener;
> +
> +typedef struct VFIOHostDMAWindow {
> +    hwaddr min_iova;
> +    hwaddr max_iova;
> +    uint64_t iova_pgsizes;
> +    QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
> +} VFIOHostDMAWindow;
> +
> +typedef struct {
> +    unsigned long *bitmap;
> +    hwaddr size;
> +    hwaddr pages;
> +} VFIOBitmap;
> +
> +typedef struct VFIODevice VFIODevice;
> +typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
> +
> +/*
> + * This is the base object for vfio container backends
> + */
> +struct VFIOContainer {
> +    VFIOIOMMUBackendOpsClass *ops;
> +    VFIOAddressSpace *space;
> +    MemoryListener listener;
> +    Error *error;
> +    bool initialized;
> +    bool dirty_pages_supported;
> +    uint64_t dirty_pgsizes;
> +    uint64_t max_dirty_bitmap_size;
> +    unsigned long pgsizes;
> +    unsigned int dma_max_mappings;
> +    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> +    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> +    QLIST_ENTRY(VFIOContainer) next;
> +};
> +
> +VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
> +                                 VFIODevice *curr);
> +int vfio_container_dma_map(VFIOContainer *container,
> +                           hwaddr iova, ram_addr_t size,
> +                           void *vaddr, bool readonly);
> +int vfio_container_dma_unmap(VFIOContainer *container,
> +                             hwaddr iova, ram_addr_t size,
> +                             IOMMUTLBEntry *iotlb);
> +bool vfio_container_devices_all_dirty_tracking(VFIOContainer *container);
> +int vfio_container_set_dirty_page_tracking(VFIOContainer *container,
> +                                            bool start);
> +int vfio_container_query_dirty_bitmap(VFIOContainer *container,
> +                                      VFIOBitmap *vbmap,
> +                                      hwaddr iova, hwaddr size);
> +int vfio_container_add_section_window(VFIOContainer *container,
> +                                      MemoryRegionSection *section,
> +                                      Error **errp);
> +void vfio_container_del_section_window(VFIOContainer *container,
> +                                       MemoryRegionSection *section);
> +
> +void vfio_container_init(VFIOContainer *container,
> +                         VFIOAddressSpace *space,
> +                         struct VFIOIOMMUBackendOpsClass *ops);
> +void vfio_container_destroy(VFIOContainer *container);
> +
> +#define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
> +#define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
> +
> +DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
> +                       VFIO_IOMMU_BACKEND_OPS, TYPE_VFIO_IOMMU_BACKEND_OPS)
> +
> +struct VFIOIOMMUBackendOpsClass {
> +    /*< private >*/
> +    ObjectClass parent_class;
> +
> +    /*< public >*/
> +    /* required */
> +    VFIODevice *(*dev_iter_next)(VFIOContainer *container, VFIODevice *curr);
> +    int (*dma_map)(VFIOContainer *container,
> +                   hwaddr iova, ram_addr_t size,
> +                   void *vaddr, bool readonly);
> +    int (*dma_unmap)(VFIOContainer *container,
> +                     hwaddr iova, ram_addr_t size,
> +                     IOMMUTLBEntry *iotlb);
> +    int (*attach_device)(char *name, VFIODevice *vbasedev,
> +                         AddressSpace *as, Error **errp);
> +    void (*detach_device)(VFIODevice *vbasedev);
> +    /* migration feature */
> +    int (*set_dirty_page_tracking)(VFIOContainer *container, bool start);
> +    int (*query_dirty_bitmap)(VFIOContainer *bcontainer, VFIOBitmap *vbmap,
> +                              hwaddr iova, hwaddr size);
> +
> +    /* SPAPR specific */
> +    int (*add_window)(VFIOContainer *container,
> +                      MemoryRegionSection *section,
> +                      Error **errp);
> +    void (*del_window)(VFIOContainer *container,
> +                       MemoryRegionSection *section);
> +};
> +
> +
> +#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */


