Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C77EB17B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:06:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u37-0004te-BL; Tue, 14 Nov 2023 09:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u2k-0004Yz-Ba
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u2h-0001B6-Ag
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXgZRWyYFnkWK4hBcYo2VczOkWyR/AuCpmFUPGOMpbk=;
 b=hbgzJigVXqKBj4A7baI3zK/ItqDh+8PLcY+pJdkwPRd/3YwtYafqmVe4lfXDLz2a+6dEJM
 3BibRrhOB39YxMM/qy1DL2iVC0b1wuv0+Yg+FaSHR4z9rspHkj8mZmeDTvJ6V6HbXudQ3j
 DSV0YqKSivlLOtyN1Q7WWqNbWPEHen8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-KLN_n7DHMsOaalfnKitMPw-1; Tue, 14 Nov 2023 09:05:15 -0500
X-MC-Unique: KLN_n7DHMsOaalfnKitMPw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-421aca7f03eso56159901cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970715; x=1700575515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXgZRWyYFnkWK4hBcYo2VczOkWyR/AuCpmFUPGOMpbk=;
 b=UUBX8t4EwXiOwPM1nehGDc8oiipK4ASsQIApQJ/qU7C4s8tUGxCVX4HOz2Qj5P97Ap
 /dxlde9mGcAd4mKXmc9S+H+DFcorqjuDT3B//bveXI24DObTMTqlwmp/Vg33g7HNUgUk
 Ip1RZkPngkEY8E4zMjTC9b1z9KXNOWxn6HJNXNQF2oDPODe3e1FwDTR7wsczMB6RfMKG
 5+bTMUcZlPqRy0SahQLSSKPnDMMQXkGCWSQUg715xUKEuIgCnXF2evNBFE37QGWED+tY
 mgrWn4cQOZ/Z0BvCxucILv2oQNL+pdLapjay2eZNbS2Ye7x1asa9Soq+yCrPYrpt6FkS
 tQHA==
X-Gm-Message-State: AOJu0YyXnO63Itv4b8SI4xqvBQCJaSjDowmB2h1dCz3x4Z1DHwROCjuN
 GlybhqJuMWmQBVzJeOryNDcT+GwyOE3We6H35pbbxwswKrNikfGcQH3c0qMn14bSQCcScJ3vn7o
 DSIBKvZf1n+zOxKJBqgUlFuU=
X-Received: by 2002:a05:622a:306:b0:418:1565:ed50 with SMTP id
 q6-20020a05622a030600b004181565ed50mr2299264qtw.66.1699970714857; 
 Tue, 14 Nov 2023 06:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSoLm7EXlv7/T5IoO0bEOFxhMFWXSkq0XFgGsxMjIAfmkaOJeCNbXejP9Lt5Ou21nKuFOycQ==
X-Received: by 2002:a05:622a:306:b0:418:1565:ed50 with SMTP id
 q6-20020a05622a030600b004181565ed50mr2299224qtw.66.1699970714371; 
 Tue, 14 Nov 2023 06:05:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm2743569qta.48.2023.11.14.06.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:05:14 -0800 (PST)
Message-ID: <66c63ea1-4c61-4804-a53f-b74e49c73adb@redhat.com>
Date: Tue, 14 Nov 2023 15:05:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/21] vfio: Make VFIOContainerBase poiner parameter
 const in VFIOIOMMUOps callbacks
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-19-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Some of the callbacks in VFIOIOMMUOps pass VFIOContainerBase poiner,
> those callbacks only need read access to the sub object of VFIOContainerBase.
> So make VFIOContainerBase, VFIOContainer and VFIOIOMMUFDContainer as const
> in these callbacks.
> 
> Local functions called by those callbacks also need same changes to avoid
> build error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h         | 12 ++++++----
>   include/hw/vfio/vfio-container-base.h | 12 ++++++----
>   hw/vfio/common.c                      |  9 +++----
>   hw/vfio/container-base.c              |  2 +-
>   hw/vfio/container.c                   | 34 ++++++++++++++-------------
>   hw/vfio/iommufd.c                     |  8 +++----
>   6 files changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 567e5f7bea..7954531d05 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -244,13 +244,15 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
>   
>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
> -bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer);
> -bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer);
> -int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +bool
> +vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
> +bool
> +vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size);
> -int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
> -                                 uint64_t size, ram_addr_t ram_addr);
> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +                          uint64_t size, ram_addr_t ram_addr);
>   
>   int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 45bb19c767..2ae297ccda 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -82,7 +82,7 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section);
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start);
> -int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
>                                         hwaddr iova, hwaddr size);
>   
> @@ -93,18 +93,20 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
>   
>   struct VFIOIOMMUOps {
>       /* basic feature */
> -    int (*dma_map)(VFIOContainerBase *bcontainer,
> +    int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);
> -    int (*dma_unmap)(VFIOContainerBase *bcontainer,
> +    int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
>                        IOMMUTLBEntry *iotlb);
>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                            AddressSpace *as, Error **errp);
>       void (*detach_device)(VFIODevice *vbasedev);
>       /* migration feature */
> -    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
> -    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
> +    int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> +                                   bool start);
> +    int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
> +                              VFIOBitmap *vbmap,
>                                 hwaddr iova, hwaddr size);
>       /* PCI specific */
>       int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6569732b7a..08a3e57672 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -204,7 +204,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>       return true;
>   }
>   
> -bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
> +bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>   {
>       VFIODevice *vbasedev;
>   
> @@ -221,7 +221,8 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainerBase *bcontainer)
>    * Check if all VFIO devices are running and migration is active, which is
>    * essentially equivalent to the migration being in pre-copy phase.
>    */
> -bool vfio_devices_all_running_and_mig_active(VFIOContainerBase *bcontainer)
> +bool
> +vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>   {
>       VFIODevice *vbasedev;
>   
> @@ -1139,7 +1140,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       return 0;
>   }
>   
> -int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size)
>   {
> @@ -1162,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
>       return 0;
>   }
>   
> -int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr)
>   {
>       bool all_device_dirty_tracking =
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index eee2dcfe76..1ffd25bbfa 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -63,7 +63,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>       return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>   }
>   
> -int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
>                                         hwaddr iova, hwaddr size)
>   {
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 1dbf9b9a17..b22feb8ded 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -61,11 +61,11 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
>       }
>   }
>   
> -static int vfio_dma_unmap_bitmap(VFIOContainer *container,
> +static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    const VFIOContainerBase *bcontainer = &container->bcontainer;
>       struct vfio_iommu_type1_dma_unmap *unmap;
>       struct vfio_bitmap *bitmap;
>       VFIOBitmap vbmap;
> @@ -117,11 +117,12 @@ unmap_exit:
>   /*
>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>    */
> -static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
> -                                 ram_addr_t size, IOMMUTLBEntry *iotlb)
> +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                                  bcontainer);
>       struct vfio_iommu_type1_dma_unmap unmap = {
>           .argsz = sizeof(unmap),
>           .flags = 0,
> @@ -174,11 +175,11 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>       return 0;
>   }
>   
> -static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
> +static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                  ram_addr_t size, void *vaddr, bool readonly)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                                  bcontainer);
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
>           .flags = VFIO_DMA_MAP_FLAG_READ,
> @@ -207,11 +208,12 @@ static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
>       return -errno;
>   }
>   
> -static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                               bool start)
> +static int
> +vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                    bool start)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                                  bcontainer);
>       int ret;
>       struct vfio_iommu_type1_dirty_bitmap dirty = {
>           .argsz = sizeof(dirty),
> @@ -233,12 +235,12 @@ static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>       return ret;
>   }
>   
> -static int vfio_legacy_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                             VFIOBitmap *vbmap,
>                                             hwaddr iova, hwaddr size)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                                  bcontainer);
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
>       struct vfio_iommu_type1_dirty_bitmap_get *range;
>       int ret;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e08a217057..bc45dd1842 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -26,10 +26,10 @@
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
>   
> -static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
> +static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
>   {
> -    VFIOIOMMUFDContainer *container =
> +    const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
>       return iommufd_backend_map_dma(container->be,
> @@ -37,11 +37,11 @@ static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
>                                      iova, size, vaddr, readonly);
>   }
>   
> -static int iommufd_cdev_unmap(VFIOContainerBase *bcontainer,
> +static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                 hwaddr iova, ram_addr_t size,
>                                 IOMMUTLBEntry *iotlb)
>   {
> -    VFIOIOMMUFDContainer *container =
> +    const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */


