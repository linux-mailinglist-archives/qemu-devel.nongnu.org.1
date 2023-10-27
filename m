Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5087D9B5A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNmx-0003Zd-FL; Fri, 27 Oct 2023 10:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNmv-0003ZV-Qe
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNmt-00047V-6E
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698416770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE74aWiY25rEBjP6zS30qfxRTGbm6V35DcrvyaU6u8k=;
 b=cB+flAEqxUNwZZOBrEMIcagOh9aiy+7GwdIWG53bRuDNkdmteQXvfcpl/oNG7eDqUb8j3l
 wq27OKmlKy2BltajRQqxFvFQDdF2JCEEaN3e4UaOt0vLMVRA4A3tW3IVvMDJmfZFBfy/yl
 1/gqZuX67okT3QxYshETIbL+SyEY/Kk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-nnr0_tA4Mmy2cNOsY7Iewg-1; Fri, 27 Oct 2023 10:26:09 -0400
X-MC-Unique: nnr0_tA4Mmy2cNOsY7Iewg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d7b90c8ecso27718456d6.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698416768; x=1699021568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sE74aWiY25rEBjP6zS30qfxRTGbm6V35DcrvyaU6u8k=;
 b=qhy3DnvPjW5MZ68Oesl44mvwYwf0PZ/Nn9VxHADxkxhRhH3eUobfKmxZdMIMeKl1MH
 JGdUr66oyvx/s/gl0zJBJ4L4YXazu4vNeiELQWcS9Ow63EJW9kzMpzovpkR8lISkMpyA
 j+SjtHQSSmPL8z9XD9f+AMf+7qJeL0vG/DRe9XskZfEVZBCkW166f5MZpcvqVngvnpof
 WkZpGW53mCAxNZtEpbCyt/pGikVX/wmYEDd7YYU0B/dKDGGzY3XAPUingEkgVi53emIG
 EDOiMjVuU5Y3iDVNG0zeob6q2YEMFhQGHMje/9WOukx2N4a2SgxyksYlND8TI4EypLVJ
 UE8Q==
X-Gm-Message-State: AOJu0YwQ5SAAERhqoEGoxpfYPBUtZJd+DbshWS/2maAu1kKJ2vq2ABkH
 Gt5xnlUXkIEJrsrHEz3nL3/ZXJYTTKG8KdXSs1EirxSCwpctpKeBNCbs91FHL345I/vyPW3xYZS
 vsu00pWPSnUGaV8Y=
X-Received: by 2002:a05:6214:29cd:b0:66d:8524:ec07 with SMTP id
 gh13-20020a05621429cd00b0066d8524ec07mr2777320qvb.49.1698416768594; 
 Fri, 27 Oct 2023 07:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFExgAploPDyLkl6VSLL8IiIrwpTYhEspdJOBs73aq9zVhz49bkIR31QZHsFWXA5cSLuJf+Ow==
X-Received: by 2002:a05:6214:29cd:b0:66d:8524:ec07 with SMTP id
 gh13-20020a05621429cd00b0066d8524ec07mr2777300qvb.49.1698416768285; 
 Fri, 27 Oct 2023 07:26:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a0ce514000000b0065b17b925d0sm658644qvm.38.2023.10.27.07.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 07:26:07 -0700 (PDT)
Message-ID: <1e5db685-0d49-43f0-8ff6-bc9f88d05131@redhat.com>
Date: Fri, 27 Oct 2023 16:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/37] vfio/container: Switch to dma_map|unmap API
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-9-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         |  4 ---
>   include/hw/vfio/vfio-container-base.h |  7 ++++
>   hw/vfio/common.c                      | 45 +++++++++++++-----------
>   hw/vfio/container-base.c              | 49 +++++++++++++++++++++++++++
>   hw/vfio/container.c                   | 22 ++++++++----
>   hw/vfio/meson.build                   |  1 +
>   hw/vfio/trace-events                  |  2 +-
>   7 files changed, 98 insertions(+), 32 deletions(-)
>   create mode 100644 hw/vfio/container-base.c
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8ded5cd8e4..97056224f4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -208,10 +208,6 @@ void vfio_put_address_space(VFIOAddressSpace *space);
>   bool vfio_devices_all_running_and_saving(VFIOContainer *container);
>   
>   /* container->fd */
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> -                   ram_addr_t size, IOMMUTLBEntry *iotlb);
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> -                 ram_addr_t size, void *vaddr, bool readonly);
>   int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
>   int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
>                               hwaddr iova, hwaddr size);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 5becbd51a7..077e638ee8 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -45,6 +45,13 @@ typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
>   } VFIOContainerBase;
>   
> +int vfio_container_dma_map(VFIOContainerBase *bcontainer,
> +                           hwaddr iova, ram_addr_t size,
> +                           void *vaddr, bool readonly);
> +int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> +                             hwaddr iova, ram_addr_t size,
> +                             IOMMUTLBEntry *iotlb);
> +
>   struct VFIOIOMMUOps {
>       /* basic feature */
>       int (*dma_map)(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0ebf4d9256..141f2b54a4 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -292,7 +292,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>   static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>   {
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> -    VFIOContainer *container = giommu->container;
> +    VFIOContainerBase *bcontainer = &giommu->container->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
>       int ret;
> @@ -322,21 +322,22 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>            * of vaddr will always be there, even if the memory object is
>            * destroyed and its backing memory munmap-ed.
>            */
> -        ret = vfio_dma_map(container, iova,
> -                           iotlb->addr_mask + 1, vaddr,
> -                           read_only);
> +        ret = vfio_container_dma_map(bcontainer, iova,
> +                                     iotlb->addr_mask + 1, vaddr,
> +                                     read_only);
>           if (ret) {
> -            error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
> -                         container, iova,
> +                         bcontainer, iova,
>                            iotlb->addr_mask + 1, vaddr, ret, strerror(-ret));
>           }
>       } else {
> -        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
> +        ret = vfio_container_dma_unmap(bcontainer, iova,
> +                                       iotlb->addr_mask + 1, iotlb);
>           if (ret) {
> -            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
> -                         container, iova,
> +                         bcontainer, iova,
>                            iotlb->addr_mask + 1, ret, strerror(-ret));
>               vfio_set_migration_error(ret);
>           }
> @@ -355,9 +356,10 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>       int ret;
>   
>       /* Unmap with a single call. */
> -    ret = vfio_dma_unmap(vrdl->container, iova, size , NULL);
> +    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
> +                                   iova, size , NULL);
>       if (ret) {
> -        error_report("%s: vfio_dma_unmap() failed: %s", __func__,
> +        error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
>                        strerror(-ret));
>       }
>   }
> @@ -385,8 +387,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                  section->offset_within_address_space;
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
> -        ret = vfio_dma_map(vrdl->container, iova, next - start,
> -                           vaddr, section->readonly);
> +        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
> +                                     next - start, vaddr, section->readonly);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -685,10 +687,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           }
>       }
>   
> -    ret = vfio_dma_map(container, iova, int128_get64(llsize),
> -                       vaddr, section->readonly);
> +    ret = vfio_container_dma_map(&container->bcontainer,
> +                                 iova, int128_get64(llsize), vaddr,
> +                                 section->readonly);
>       if (ret) {
> -        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> +        error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
>                      container, iova, int128_get64(llsize), vaddr, ret,
>                      strerror(-ret));
> @@ -786,18 +789,20 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           if (int128_eq(llsize, int128_2_64())) {
>               /* The unmap ioctl doesn't accept a full 64-bit span. */
>               llsize = int128_rshift(llsize, 1);
> -            ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
> +            ret = vfio_container_dma_unmap(&container->bcontainer, iova,
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
> +        ret = vfio_container_dma_unmap(&container->bcontainer, iova,
> +                                       int128_get64(llsize), NULL);
>           if (ret) {
> -            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
>                            container, iova, int128_get64(llsize), ret,
>                            strerror(-ret));
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> new file mode 100644
> index 0000000000..9db8b89b2f
> --- /dev/null
> +++ b/hw/vfio/container-base.c
> @@ -0,0 +1,49 @@
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

Please reduce the header with an SPDX identifier.

> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/vfio/vfio-container-base.h"
> +
> +int vfio_container_dma_map(VFIOContainerBase *bcontainer,
> +                           hwaddr iova, ram_addr_t size,
> +                           void *vaddr, bool readonly)
> +{
> +    if (!bcontainer->ops->dma_map) {

I think this could be an assert instead ?

> +        return -EINVAL;
> +    }
> +
> +    return bcontainer->ops->dma_map(bcontainer, iova, size, vaddr, readonly);
> +}
> +
> +int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> +                             hwaddr iova, ram_addr_t size,
> +                             IOMMUTLBEntry *iotlb)
> +{
> +    if (!bcontainer->ops->dma_unmap) {
> +        return -EINVAL;
> +    }
> +
> +    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
> +}
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4bc43ddfa4..c04df26323 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -115,9 +115,11 @@ unmap_exit:
>   /*
>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>    */
> -int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
> -                   ram_addr_t size, IOMMUTLBEntry *iotlb)
> +static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
> +                                 ram_addr_t size, IOMMUTLBEntry *iotlb)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
>       struct vfio_iommu_type1_dma_unmap unmap = {
>           .argsz = sizeof(unmap),
>           .flags = 0,
> @@ -151,7 +153,7 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>            */
>           if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>               container->iommu_type == VFIO_TYPE1v2_IOMMU) {
> -            trace_vfio_dma_unmap_overflow_workaround();
> +            trace_vfio_legacy_dma_unmap_overflow_workaround();
>               unmap.size -= 1ULL << ctz64(container->pgsizes);
>               continue;
>           }
> @@ -170,9 +172,11 @@ int vfio_dma_unmap(VFIOContainer *container, hwaddr iova,
>       return 0;
>   }
>   
> -int vfio_dma_map(VFIOContainer *container, hwaddr iova,
> -                 ram_addr_t size, void *vaddr, bool readonly)
> +static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
> +                               ram_addr_t size, void *vaddr, bool readonly)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
>           .flags = VFIO_DMA_MAP_FLAG_READ,
> @@ -191,7 +195,8 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>        * the VGA ROM space.
>        */
>       if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
> +        (errno == EBUSY &&
> +         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
>            ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>           return 0;
>       }
> @@ -937,4 +942,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>       vfio_put_group(group);
>   }
>   
> -const VFIOIOMMUOps vfio_legacy_ops;
> +const VFIOIOMMUOps vfio_legacy_ops = {
> +    .dma_map = vfio_legacy_dma_map,
> +    .dma_unmap = vfio_legacy_dma_unmap,
> +};
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
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 0eb2387cf2..9f7fedee98 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -116,7 +116,7 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
>   vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
> -vfio_dma_unmap_overflow_workaround(void) ""
> +vfio_legacy_dma_unmap_overflow_workaround(void) ""
>   vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   


