Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE467E2A63
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:51:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02oP-00079G-Ss; Mon, 06 Nov 2023 11:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oK-000770-0j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oH-0002di-3O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvMm6Xzj4qW1gD/UfFBX8i1ZQuO6u5RtLC9Zr3rXGDo=;
 b=HuD9KuSMh4MvSuX4+rknkBD2Sqx18HCjXjF2NQKPZZ/SBSlkRFiF3OOcAokiMoi2uvbsma
 EcIZKwXgs6BWdW8XoEAkuGLZXzMTVmaxMzWjAEAqpIX44rF2jvmfoZKEb5X+UqbrmEcHZW
 jEz8mPxGwg06aAlTSrDWFo1LqBaK+mk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pFGu2gO7N_qoUDmRBjteOw-1; Mon, 06 Nov 2023 11:50:22 -0500
X-MC-Unique: pFGu2gO7N_qoUDmRBjteOw-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-da0c7d27fb0so5353674276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289421; x=1699894221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvMm6Xzj4qW1gD/UfFBX8i1ZQuO6u5RtLC9Zr3rXGDo=;
 b=dzNeHkCLbM+9dGNdY79Yq1ERpNyqwEHrX+o6XhCh+YRpYrKrX/lLMkifhYqwYHvUW7
 DjmkFgLpQg2p+XZ/gjRwXsbxwfDhCBO0bWyKxnlpZZ51NVxXidUZIhjDMLAAb0fYEjQF
 ZWP7RxfJ5OLpmkoOKnBRFAdwpO+K5Qay7sDz2foRv4AXTX/yW5EYMAjqrM9AlLzweZIQ
 o3lJoeBtLpwxpUacpkqeNjtyXDoY/gGjQxzQK9yYeWk9efjRooz91GCOV9v33f0Cwo8d
 IeVlY3PiW/huU2//QTE01ia3GZmJXtzazKpFRnzdTDuGj7cqwlI5LxpEC4KyI7viFVCq
 1DmQ==
X-Gm-Message-State: AOJu0Yx3MEtb8WgtoxH7ViwnBueW+EPRkUmZshy8bUMtWRglWJakigmN
 CnDpcf3Sz03THqhH52NvURUdTUxpc2LpT1P0PqQM9FrnsUdwqbFVun97nAPBGm0k8JHxD454RhT
 a6qSVRoRD2WTSpHg=
X-Received: by 2002:a25:cb05:0:b0:da0:6933:d8d with SMTP id
 b5-20020a25cb05000000b00da069330d8dmr30214261ybg.63.1699289421428; 
 Mon, 06 Nov 2023 08:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF2oux+fAFPxlTEfn1Hp8OvagyhmMZ88/qSk/rWa/+AdAW5YIcqfsPUO3RHqS8jmaeEds9Cg==
X-Received: by 2002:a25:cb05:0:b0:da0:6933:d8d with SMTP id
 b5-20020a25cb05000000b00da069330d8dmr30214238ybg.63.1699289421177; 
 Mon, 06 Nov 2023 08:50:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mz20-20020a0562142d1400b006713142482fsm3576258qvb.74.2023.11.06.08.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:50:20 -0800 (PST)
Message-ID: <976a6bb0-a517-4e25-9970-ca2e2c36d904@redhat.com>
Date: Mon, 6 Nov 2023 17:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/41] vfio/common: Move giommu_list in base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-11-zhenzhong.duan@intel.com>
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
> Move the giommu_list field in the base container and store
> the base container in the VFIOGuestIOMMU.
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         |  9 ---------
>   include/hw/vfio/vfio-container-base.h |  9 +++++++++
>   hw/vfio/common.c                      | 17 +++++++++++------
>   hw/vfio/container-base.c              |  9 +++++++++
>   hw/vfio/container.c                   |  8 --------
>   5 files changed, 29 insertions(+), 23 deletions(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 24a26345e5..6be082b8f2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -95,7 +95,6 @@ typedef struct VFIOContainer {
>       uint64_t max_dirty_bitmap_size;
>       unsigned long pgsizes;
>       unsigned int dma_max_mappings;
> -    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> @@ -104,14 +103,6 @@ typedef struct VFIOContainer {
>       GList *iova_ranges;
>   } VFIOContainer;
>   
> -typedef struct VFIOGuestIOMMU {
> -    VFIOContainer *container;
> -    IOMMUMemoryRegion *iommu_mr;
> -    hwaddr iommu_offset;
> -    IOMMUNotifier n;
> -    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
> -} VFIOGuestIOMMU;
> -
>   typedef struct VFIORamDiscardListener {
>       VFIOContainer *container;
>       MemoryRegion *mr;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 577f52ccbc..a11aec5755 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -29,8 +29,17 @@ typedef struct {
>    */
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
> +    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>   } VFIOContainerBase;
>   
> +typedef struct VFIOGuestIOMMU {
> +    VFIOContainerBase *bcontainer;
> +    IOMMUMemoryRegion *iommu_mr;
> +    hwaddr iommu_offset;
> +    IOMMUNotifier n;
> +    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
> +} VFIOGuestIOMMU;
> +
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
>                              void *vaddr, bool readonly);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e610771888..43580bcc43 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -292,7 +292,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>   static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>   {
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
> -    VFIOContainerBase *bcontainer = &giommu->container->bcontainer;
> +    VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
>       int ret;
> @@ -569,6 +569,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
>       VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -612,7 +613,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           giommu->iommu_mr = iommu_mr;
>           giommu->iommu_offset = section->offset_within_address_space -
>                                  section->offset_within_region;
> -        giommu->container = container;
> +        giommu->bcontainer = bcontainer;
>           llend = int128_add(int128_make64(section->offset_within_region),
>                              section->size);
>           llend = int128_sub(llend, int128_one());
> @@ -647,7 +648,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>               g_free(giommu);
>               goto fail;
>           }
> -        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> +        QLIST_INSERT_HEAD(&bcontainer->giommu_list, giommu, giommu_next);
>           memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>   
>           return;
> @@ -732,6 +733,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
>       VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       int ret;
> @@ -744,7 +746,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       if (memory_region_is_iommu(section->mr)) {
>           VFIOGuestIOMMU *giommu;
>   
> -        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>               if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>                   giommu->n.start == section->offset_within_region) {
>                   memory_region_unregister_iommu_notifier(section->mr,
> @@ -1206,7 +1208,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       vfio_giommu_dirty_notifier *gdn = container_of(n,
>                                                   vfio_giommu_dirty_notifier, n);
>       VFIOGuestIOMMU *giommu = gdn->giommu;
> -    VFIOContainer *container = giommu->container;
> +    VFIOContainerBase *bcontainer = giommu->bcontainer;
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       ram_addr_t translated_addr;
>       int ret = -EINVAL;
> @@ -1284,12 +1288,13 @@ static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
>   static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>                                     MemoryRegionSection *section)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       ram_addr_t ram_addr;
>   
>       if (memory_region_is_iommu(section->mr)) {
>           VFIOGuestIOMMU *giommu;
>   
> -        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>               if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>                   giommu->n.start == section->offset_within_region) {
>                   Int128 llend;
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index e929435751..20bcb9669a 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -34,8 +34,17 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>   void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
>   {
>       bcontainer->ops = ops;
> +    QLIST_INIT(&bcontainer->giommu_list);
>   }
>   
>   void vfio_container_destroy(VFIOContainerBase *bcontainer)
>   {
> +    VFIOGuestIOMMU *giommu, *tmp;
> +
> +    QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
> +        memory_region_unregister_iommu_notifier(
> +                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> +        QLIST_REMOVE(giommu, giommu_next);
> +        g_free(giommu);
> +    }
>   }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 32a0251dd1..133d3c8f5c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -556,7 +556,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->dirty_pages_supported = false;
>       container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
> -    QLIST_INIT(&container->giommu_list);
>       QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
>       vfio_container_init(bcontainer, &vfio_legacy_ops);
> @@ -686,16 +685,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   
>       if (QLIST_EMPTY(&container->group_list)) {
>           VFIOAddressSpace *space = container->space;
> -        VFIOGuestIOMMU *giommu, *tmp;
>   
>           QLIST_REMOVE(container, next);
>   
> -        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> -            memory_region_unregister_iommu_notifier(
> -                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> -            QLIST_REMOVE(giommu, giommu_next);
> -            g_free(giommu);
> -        }
>           vfio_container_destroy(bcontainer);
>   
>           trace_vfio_disconnect_container(container->fd);


