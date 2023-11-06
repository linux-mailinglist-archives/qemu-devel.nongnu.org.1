Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0737E2A67
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:54:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02qq-0000yL-5Q; Mon, 06 Nov 2023 11:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02qo-0000y4-Uk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02qm-000381-TN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTnRhkhgiqUd2MTGxHxgLt7H+ANDFPvs50gLJxO3bKQ=;
 b=XGM58+PMZHRBqICcxg/s78Qel5SIQLt6ZiVXUTx7l9qAB9bwCJrIBik9UkuPl/A1AFxlUG
 AC1zruMBLc9IIk8G43O8smfOc6Zvudt8gQh82spAB63AxPB3LRgtmKamf2RFt2fs6g7XXY
 JvzyDUzBXQO/1fYiHu4uMWpDvdF5Hg8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-knGAsLtyNEi3sgNekwGwgg-1; Mon, 06 Nov 2023 11:53:18 -0500
X-MC-Unique: knGAsLtyNEi3sgNekwGwgg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cd5166101so58543711cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289598; x=1699894398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTnRhkhgiqUd2MTGxHxgLt7H+ANDFPvs50gLJxO3bKQ=;
 b=sjJl44gJYvdcBpmhV/e7IKsNuR+8OB2mwD9yeWljir+vChE39SxzyYqFJhnKmKuqRT
 ebeEoAu5TsVZlhBoK/VHGXDndzmp5ydhIZA0MxPRrW6J5RJoOz9fi3YmyUH+8s7VSfri
 6i5FwJBgSPrK/76JTRIsP+vT3DMEkJi6PQEhLqBcZNoqbqSkW1WVv0qAtwKWxVHVpsDr
 fgDHnZizDVUcsNUuxuluKl8O68Evwi+7ctrv/BkbDbAiUImYI6kPbKYiknjxUOJ3fNLD
 /UDWjtT+G/UUG/UcbWsrdaZuvwhV1QO4QQlR6Vk12l5asuYrtnABWu8xkG1rpdkxzsLt
 2fSA==
X-Gm-Message-State: AOJu0YyPoshwgobCg/s0hasGr1fvTuTUETSA3zhgNX32+NdyVktxzo29
 IPGcYw8Qa9Tuunj013L9keoi7FDIcrAW6V/gddAC3yorKSLhUesfQpbyl1ENBpHiqKkRCZd53ZU
 FpKHNxY39bOql6pw=
X-Received: by 2002:ac8:4e47:0:b0:417:d340:c426 with SMTP id
 e7-20020ac84e47000000b00417d340c426mr37358560qtw.9.1699289597936; 
 Mon, 06 Nov 2023 08:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQSFxagQpCSbe7DldEjx9gNvN3PWsOg5iL1i9oqgPnAyhLiX0hC2NUPrW8R+R73uFvAB2hfQ==
X-Received: by 2002:ac8:4e47:0:b0:417:d340:c426 with SMTP id
 e7-20020ac84e47000000b00417d340c426mr37358533qtw.9.1699289597629; 
 Mon, 06 Nov 2023 08:53:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r22-20020ac85e96000000b0041ce9ebaad2sm3592763qtx.43.2023.11.06.08.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:53:17 -0800 (PST)
Message-ID: <92ac9fc0-8974-47d2-b06b-ffa2128c096e@redhat.com>
Date: Mon, 6 Nov 2023 17:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/41] vfio/container: Move pgsizes and
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
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-16-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-16-zhenzhong.duan@intel.com>
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
> v4: Split vrdl_list change out in a seperate patch
> 
>   include/hw/vfio/vfio-common.h         |  2 --
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   hw/vfio/common.c                      | 17 +++++++++--------
>   hw/vfio/container-base.c              |  1 +
>   hw/vfio/container.c                   | 11 +++++------
>   hw/vfio/spapr.c                       | 10 ++++++----
>   6 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index bc67e1316c..d3dc2f9dcb 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -85,8 +85,6 @@ typedef struct VFIOContainer {
>       bool initialized;
>       uint64_t dirty_pgsizes;
>       uint64_t max_dirty_bitmap_size;
> -    unsigned long pgsizes;
> -    unsigned int dma_max_mappings;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 7090962496..85ec7e1a56 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -36,6 +36,8 @@ typedef struct VFIOAddressSpace {
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
>       VFIOAddressSpace *space;
> +    unsigned long pgsizes;
> +    unsigned int dma_max_mappings;
>       bool dirty_pages_supported;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index cf6618f6ed..1cb53d369e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -401,6 +401,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>   static void vfio_register_ram_discard_listener(VFIOContainer *container,
>                                                  MemoryRegionSection *section)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl;
>   
> @@ -419,8 +420,8 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
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
> @@ -441,7 +442,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>        * number of sections in the address space we could have over time,
>        * also consuming DMA mappings.
>        */
> -    if (container->dma_max_mappings) {
> +    if (bcontainer->dma_max_mappings) {
>           unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
>   
>   #ifdef CONFIG_KVM
> @@ -462,11 +463,11 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
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
> @@ -626,7 +627,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                               iommu_idx);
>   
>           ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
> -                                                     container->pgsizes,
> +                                                     bcontainer->pgsizes,
>                                                        &err);
>           if (ret) {
>               g_free(giommu);
> @@ -675,7 +676,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>       llsize = int128_sub(llend, int128_make64(iova));
>   
>       if (memory_region_is_ram_device(section->mr)) {
> -        hwaddr pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
> +        hwaddr pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
>   
>           if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
>               trace_vfio_listener_region_add_no_dma_map(
> @@ -777,7 +778,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       if (memory_region_is_ram_device(section->mr)) {
>           hwaddr pgmask;
>   
> -        pgmask = (1ULL << ctz64(container->pgsizes)) - 1;
> +        pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
>           try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
>           vfio_unregister_ram_discard_listener(container, section);
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 5d654ae172..dcce111349 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -52,6 +52,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>       bcontainer->ops = ops;
>       bcontainer->space = space;
>       bcontainer->dirty_pages_supported = false;
> +    bcontainer->dma_max_mappings = 0;
>       QLIST_INIT(&bcontainer->giommu_list);
>   }
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7bd81eab09..c5a6262882 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>           if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>               container->iommu_type == VFIO_TYPE1v2_IOMMU) {
>               trace_vfio_legacy_dma_unmap_overflow_workaround();
> -            unmap.size -= 1ULL << ctz64(container->pgsizes);
> +            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
>               continue;
>           }
>           error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
> @@ -559,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container = g_malloc0(sizeof(*container));
>       container->fd = fd;
>       container->error = NULL;
> -    container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
> @@ -589,13 +588,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
>   
>           vfio_get_info_iova_range(info, container);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 83da2f7ec2..4f76bdd3ca 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -226,6 +226,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>                                       hwaddr *pgsize)
>   {
>       int ret = 0;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>       uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
>       unsigned entries, bits_total, bits_per_level, max_levels;
> @@ -239,13 +240,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>       if (pagesize > rampagesize) {
>           pagesize = rampagesize;
>       }
> -    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
> +    pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
>       pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>       if (!pagesize) {
>           error_report("Host doesn't support page size 0x%"PRIx64
>                        ", the supported mask is 0x%lx",
>                        memory_region_iommu_get_min_page_size(iommu_mr),
> -                     container->pgsizes);
> +                     bcontainer->pgsizes);
>           return -EINVAL;
>       }
>   
> @@ -421,6 +422,7 @@ void vfio_container_del_section_window(VFIOContainer *container,
>   
>   int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       struct vfio_iommu_spapr_tce_info info;
>       bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>       int ret, fd = container->fd;
> @@ -461,7 +463,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>       }
>   
>       if (v2) {
> -        container->pgsizes = info.ddw.pgsizes;
> +        bcontainer->pgsizes = info.ddw.pgsizes;
>           /*
>            * There is a default window in just created container.
>            * To make region_add/del simpler, we better remove this
> @@ -476,7 +478,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>           }
>       } else {
>           /* The default table uses 4K pages */
> -        container->pgsizes = 0x1000;
> +        bcontainer->pgsizes = 0x1000;
>           vfio_host_win_add(container, info.dma32_window_start,
>                             info.dma32_window_start +
>                             info.dma32_window_size - 1,


