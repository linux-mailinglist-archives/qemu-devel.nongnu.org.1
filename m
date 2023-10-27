Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29207D9D79
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwP8c-00024E-8l; Fri, 27 Oct 2023 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwP8a-00023f-Eg
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwP8T-0002I6-Ag
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698421952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+bcT4X+9d2GRBQpSYfFKF/V30PDYnqGSftlgcTTWDg=;
 b=fKgC2jhzUYqrOz1vIAgB67ffps63zc1JIHazbKjJzeUrBXPrMwcswn3zBDSIlhSY/9h7lh
 Nh737zM0+Z0aFs8S2D6hxxJvevj2Ut5S3sm8deDxqouDZNz1irG0VyMdYvH19YQkb9XK+l
 4IPH17A3vlEzPWNSWX9pqInlk9XUyhQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-a2KmIsM3PkyOULNoiR35vw-1; Fri, 27 Oct 2023 11:52:30 -0400
X-MC-Unique: a2KmIsM3PkyOULNoiR35vw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66da680f422so28646636d6.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698421950; x=1699026750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+bcT4X+9d2GRBQpSYfFKF/V30PDYnqGSftlgcTTWDg=;
 b=XfxCF+CUoTcieF6Qo38BIc+Z9w8DsaTfDUgsuJkNOcZ2CcFrSrvNa5amp5mG4pMrl2
 Cl60ndoVv2RA/Jbyn+7mzf/OpxKBhrCbsZSe92lJMSOTF3qtz9NKP2L1rqlYqfTFdF21
 iAEI51Fmp1uM6xbuoN2oulQ8yLTpU0cEKRckhv7LXLQ9sWBgJ4b+irvZQSmnb72cNWpC
 IP1B9sW8LjTNPT1XhXh+9xZOWlLGIbRU8VE8PaMujSJqszdaQqZZ/ACib2Uz/QWuLSnd
 A4JXCNJG/3GJFpPF3s7War2xwRRTrshN5vpw1AOfYqpF7a3b4cpOfXcs92GafcDIv14z
 fayQ==
X-Gm-Message-State: AOJu0Yysk+Hee15xSDuUwqBqznN05sBzZOua3QBSHqRVDhF7HxAfkUk8
 NztJREL3TXDrLnsljTLwTLhoLwugkJ/lo6npzHJeZz6PUS68UulWffneB8QtELL6UUfHF3OezVS
 pNGGluIzbEZM3V4k=
X-Received: by 2002:ad4:5c8c:0:b0:66d:3548:9c1a with SMTP id
 o12-20020ad45c8c000000b0066d35489c1amr3965644qvh.54.1698421950310; 
 Fri, 27 Oct 2023 08:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa+F646H4UDYA79PFJVcUwYwtH2mMVkhTuf5EPOQhnChhbVK7z6AJ7Di0OqkDAgWaCfyONjw==
X-Received: by 2002:ad4:5c8c:0:b0:66d:3548:9c1a with SMTP id
 o12-20020ad45c8c000000b0066d35489c1amr3965608qvh.54.1698421949853; 
 Fri, 27 Oct 2023 08:52:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05621414ef00b0065b14fcfca6sm702921qvw.118.2023.10.27.08.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 08:52:29 -0700 (PDT)
Message-ID: <7603f300-1305-45da-9560-d073bdbc5036@redhat.com>
Date: Fri, 27 Oct 2023 17:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/37] vfio/container: Move vrdl_list, pgsizes and
 dma_max_mappings to base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-15-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> Move vrdl_list, pgsizes and dma_max_mappings to the base
> container object
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> [ clg: context changes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h         | 13 -------
>   include/hw/vfio/vfio-container-base.h | 13 +++++++
>   hw/vfio/common.c                      | 49 ++++++++++++++-------------
>   hw/vfio/container-base.c              | 12 +++++++
>   hw/vfio/container.c                   | 12 +++----
>   hw/vfio/spapr.c                       | 18 +++++++---
>   6 files changed, 68 insertions(+), 49 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fb3c7aea8f..65ae2d76cf 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -85,24 +85,11 @@ typedef struct VFIOContainer {
>       bool initialized;
>       uint64_t dirty_pgsizes;
>       uint64_t max_dirty_bitmap_size;
> -    unsigned long pgsizes;
> -    unsigned int dma_max_mappings;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
> -    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       GList *iova_ranges;
>   } VFIOContainer;
>   
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
>   typedef struct VFIOHostDMAWindow {
>       hwaddr min_iova;
>       hwaddr max_iova;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index f1de1ef120..849c8b34b2 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -50,8 +50,11 @@ typedef struct VFIOAddressSpace {
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
>       VFIOAddressSpace *space;
> +    unsigned long pgsizes;
> +    unsigned int dma_max_mappings;
>       bool dirty_pages_supported;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> +    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
>       QLIST_HEAD(, VFIODevice) device_list;
>   } VFIOContainerBase;
> @@ -64,6 +67,16 @@ typedef struct VFIOGuestIOMMU {
>       QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
>   } VFIOGuestIOMMU;
>   
> +typedef struct VFIORamDiscardListener {
> +    VFIOContainerBase *bcontainer;
> +    MemoryRegion *mr;
> +    hwaddr offset_within_address_space;
> +    hwaddr size;
> +    uint64_t granularity;
> +    RamDiscardListener listener;
> +    QLIST_ENTRY(VFIORamDiscardListener) next;
> +} VFIORamDiscardListener;
> +
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
>                              void *vaddr, bool readonly);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 91411d9844..9b34e7e0f8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -351,13 +351,13 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>   {
>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>                                                   listener);
> +    VFIOContainerBase *bcontainer = vrdl->bcontainer;
>       const hwaddr size = int128_get64(section->size);
>       const hwaddr iova = section->offset_within_address_space;
>       int ret;
>   
>       /* Unmap with a single call. */
> -    ret = vfio_container_dma_unmap(&vrdl->container->bcontainer,
> -                                   iova, size , NULL);
> +    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
>       if (ret) {
>           error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
>                        strerror(-ret));
> @@ -369,6 +369,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>   {
>       VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
>                                                   listener);
> +    VFIOContainerBase *bcontainer = vrdl->bcontainer;
>       const hwaddr end = section->offset_within_region +
>                          int128_get64(section->size);
>       hwaddr start, next, iova;
> @@ -387,8 +388,8 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                  section->offset_within_address_space;
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
> -        ret = vfio_container_dma_map(&vrdl->container->bcontainer, iova,
> -                                     next - start, vaddr, section->readonly);
> +        ret = vfio_container_dma_map(bcontainer, iova, next - start,
> +                                     vaddr, section->readonly);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -398,7 +399,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>       return 0;
>   }
>   
> -static void vfio_register_ram_discard_listener(VFIOContainer *container,
> +static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>                                                  MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> @@ -411,7 +412,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>       g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
>   
>       vrdl = g_new0(VFIORamDiscardListener, 1);
> -    vrdl->container = container;
> +    vrdl->bcontainer = bcontainer;
>       vrdl->mr = section->mr;
>       vrdl->offset_within_address_space = section->offset_within_address_space;
>       vrdl->size = int128_get64(section->size);
> @@ -419,14 +420,14 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>                                                                   section->mr);
>   
>       g_assert(vrdl->granularity && is_power_of_2(vrdl->granularity));
> -    g_assert(container->pgsizes &&
> -             vrdl->granularity >= 1ULL << ctz64(container->pgsizes));
> +    g_assert(bcontainer->pgsizes &&
> +             vrdl->granularity >= 1ULL << ctz64(bcontainer->pgsizes));
>   
>       ram_discard_listener_init(&vrdl->listener,
>                                 vfio_ram_discard_notify_populate,
>                                 vfio_ram_discard_notify_discard, true);
>       ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
> -    QLIST_INSERT_HEAD(&container->vrdl_list, vrdl, next);
> +    QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
>   
>       /*
>        * Sanity-check if we have a theoretically problematic setup where we could
> @@ -441,7 +442,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>        * number of sections in the address space we could have over time,
>        * also consuming DMA mappings.
>        */
> -    if (container->dma_max_mappings) {
> +    if (bcontainer->dma_max_mappings) {
>           unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
>   
>   #ifdef CONFIG_KVM
> @@ -450,7 +451,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>           }
>   #endif
>   
> -        QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
> +        QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
>               hwaddr start, end;
>   
>               start = QEMU_ALIGN_DOWN(vrdl->offset_within_address_space,
> @@ -462,23 +463,23 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>           }
>   
>           if (vrdl_mappings + max_memslots - vrdl_count >
> -            container->dma_max_mappings) {
> +            bcontainer->dma_max_mappings) {
>               warn_report("%s: possibly running out of DMA mappings. E.g., try"
>                           " increasing the 'block-size' of virtio-mem devies."
>                           " Maximum possible DMA mappings: %d, Maximum possible"
> -                        " memslots: %d", __func__, container->dma_max_mappings,
> +                        " memslots: %d", __func__, bcontainer->dma_max_mappings,
>                           max_memslots);
>           }
>       }
>   }
>   
> -static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
> +static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
>                                                    MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl = NULL;
>   
> -    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
> +    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
>           if (vrdl->mr == section->mr &&
>               vrdl->offset_within_address_space ==
>               section->offset_within_address_space) {
> @@ -627,7 +628,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                               iommu_idx);
>   
>           ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
> -                                                     container->pgsizes,
> +                                                     bcontainer->pgsizes,
>                                                        &err);
>           if (ret) {
>               g_free(giommu);
> @@ -663,7 +664,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>        * about changes.
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_register_ram_discard_listener(container, section);
> +        vfio_register_ram_discard_listener(bcontainer, section);
>           return;
>       }
>   
> @@ -782,7 +783,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>           try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_unregister_ram_discard_listener(container, section);
> +        vfio_unregister_ram_discard_listener(bcontainer, section);
>           /* Unregistering will trigger an unmap. */
>           try_unmap = false;
>       }
> @@ -1261,17 +1262,17 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>        * Sync the whole mapped region (spanning multiple individual mappings)
>        * in one go.
>        */
> -    return vfio_get_dirty_bitmap(&vrdl->container->bcontainer, iova, size,
> -                                 ram_addr);
> +    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
>   }
>   
> -static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
> -                                                   MemoryRegionSection *section)
> +static int
> +vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
> +                                            MemoryRegionSection *section)
>   {
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl = NULL;
>   
> -    QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
> +    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
>           if (vrdl->mr == section->mr &&
>               vrdl->offset_within_address_space ==
>               section->offset_within_address_space) {
> @@ -1325,7 +1326,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>           }
>           return 0;
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
> +        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
>       }
>   
>       ram_addr = memory_region_get_ram_addr(section->mr) +
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index a7cf517dd2..568f891841 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -76,15 +76,27 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>       bcontainer->ops = ops;
>       bcontainer->space = space;
>       bcontainer->dirty_pages_supported = false;
> +    bcontainer->dma_max_mappings = 0;
>       QLIST_INIT(&bcontainer->giommu_list);
> +    QLIST_INIT(&bcontainer->vrdl_list);
>   }
>   
>   void vfio_container_destroy(VFIOContainerBase *bcontainer)
>   {
> +    VFIORamDiscardListener *vrdl, *vrdl_tmp;
>       VFIOGuestIOMMU *giommu, *tmp;
>   
>       QLIST_REMOVE(bcontainer, next);
>   
> +    QLIST_FOREACH_SAFE(vrdl, &bcontainer->vrdl_list, next, vrdl_tmp) {
> +        RamDiscardManager *rdm;
> +
> +        rdm = memory_region_get_ram_discard_manager(vrdl->mr);
> +        ram_discard_manager_unregister_listener(rdm, &vrdl->listener);
> +        QLIST_REMOVE(vrdl, next);
> +        g_free(vrdl);
> +    }

Where was this done previously ? May be the vrdl list should be handled
separatly from pgsizes and dma_max_mappings.

>       QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
>           memory_region_unregister_iommu_notifier(
>                   MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 8d5b408e86..0e265ffa67 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>           if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>               container->iommu_type == VFIO_TYPE1v2_IOMMU) {
>               trace_vfio_legacy_dma_unmap_overflow_workaround();
> -            unmap.size -= 1ULL << ctz64(container->pgsizes);
> +            unmap.size -= 1ULL << ctz64(container->bcontainer.pgsizes);
>               continue;
>           }
>           error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
> @@ -559,9 +559,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container = g_malloc0(sizeof(*container));
>       container->fd = fd;
>       container->error = NULL;
> -    container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
> -    QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
>       vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>   
> @@ -589,13 +587,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           }
>   
>           if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
> -            container->pgsizes = info->iova_pgsizes;
> +            container->bcontainer.pgsizes = info->iova_pgsizes;
>           } else {
> -            container->pgsizes = qemu_real_host_page_size();
> +            container->bcontainer.pgsizes = qemu_real_host_page_size();
>           }
>   
> -        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
> -            container->dma_max_mappings = 65535;
> +        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
> +            container->bcontainer.dma_max_mappings = 65535;
>           }
>   
>           vfio_get_info_iova_range(info, container);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 3495737ab2..dbc4c24052 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -223,13 +223,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
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
> @@ -385,7 +385,7 @@ void vfio_container_del_section_window(VFIOContainer *container,
>   
>   bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   {
> -
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       struct vfio_iommu_spapr_tce_info info;
>       bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>       int ret, fd = container->fd;
> @@ -424,7 +424,7 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>       }
>   
>       if (v2) {
> -        container->pgsizes = info.ddw.pgsizes;
> +        bcontainer->pgsizes = info.ddw.pgsizes;
>           /*
>            * There is a default window in just created container.
>            * To make region_add/del simpler, we better remove this
> @@ -439,7 +439,7 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>           }
>       } else {
>           /* The default table uses 4K pages */
> -        container->pgsizes = 0x1000;
> +        bcontainer->pgsizes = 0x1000;
>           vfio_host_win_add(container, info.dma32_window_start,
>                             info.dma32_window_start +
>                             info.dma32_window_size - 1,
> @@ -455,7 +455,15 @@ listener_unregister_exit:
>   
>   void vfio_spapr_container_deinit(VFIOContainer *container)
>   {
> +    VFIOHostDMAWindow *hostwin, *next;
> +
>       if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>           memory_listener_unregister(&container->prereg_listener);
>       }
> +    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
> +                       next) {
> +        QLIST_REMOVE(hostwin, hostwin_next);
> +        g_free(hostwin);
> +    }
> +
>   }

I am sure this change  belongs to this patch.

Thanks,

C.


