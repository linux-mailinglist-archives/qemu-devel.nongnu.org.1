Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8C7D9BB0
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwNzW-00076w-4I; Fri, 27 Oct 2023 10:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNzP-000745-Mt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwNzN-0007nU-Hd
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698417544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evz6o7o9uFzDXU/EXlrU2HES86Ci7KA0G2Mwb4jXqI0=;
 b=Wm+qinycn1kl0AxK6ty/nO1A71xtj48FJRIkLwHyYrwRKCNDO2dIsU44JTNE8Or866ILo9
 D15dj6aZwM+DBydtEO+GnTMd7yn0i7fSuYCK3kkeTc9f5C6YRCahuj0BMj5XNJTNRUo3ZY
 x0oiIJC0m4VOUYxSe/k1nvQnKCTmVxY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-9TIl6OsWPHyT9V1sy_xdoA-1; Fri, 27 Oct 2023 10:38:52 -0400
X-MC-Unique: 9TIl6OsWPHyT9V1sy_xdoA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-584287629e2so2774020eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417532; x=1699022332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evz6o7o9uFzDXU/EXlrU2HES86Ci7KA0G2Mwb4jXqI0=;
 b=CqNOwImFND2DhWEAqRzpnXjCTRWk8SnWB4MEgXThbWfzwnTphmML75rGrgnzEz0QNe
 VZtsyKLAeRUNdrmlmIV33sFZQMTECe8Lb78pueGl4WJAlosCDz4tYkSfR2qDd01LrvTO
 1JnlPQ+k4Znj8Sr70PHvOX5CcDgK6Zqy2GypibTs5Dq+2ilnpKDXL1zfAQYddGZjNKjx
 bXcwKCrurVrxu84CHbsTUm8jjzfnvhu1hAoouGMaOIg+mNeHZlG7bnaD6fH5EJHZVnYE
 x3z9YtHs+MmOegD43jzk0noMUk2kZAnmMqpTrLsBMQjR7KbfTjTwEwGp6HtjgkozfpC1
 Po0A==
X-Gm-Message-State: AOJu0Ywba9eayapeTdrkAMLORIRhovsrbqzZnJpQKR1wYuybLo+JscOQ
 60G+pgptyQJskcHkKsSL3CX0VU250k+bz0xRkJZzo8ngEfxo0eR/tCmTYenuICpxiHK+sqE9oZj
 jfYs2/ywZ29pEZ/A=
X-Received: by 2002:a05:6358:1a82:b0:168:cfc5:82c with SMTP id
 gm2-20020a0563581a8200b00168cfc5082cmr2575149rwb.13.1698417531796; 
 Fri, 27 Oct 2023 07:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSOYFNr+9OAPfIUhtZKFIehDTO5RQ48pEGGRUFvXttqwj9nJtxDgszO2isrpWpS9vJfulog==
X-Received: by 2002:a05:6358:1a82:b0:168:cfc5:82c with SMTP id
 gm2-20020a0563581a8200b00168cfc5082cmr2575131rwb.13.1698417531430; 
 Fri, 27 Oct 2023 07:38:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 dp17-20020a05621409d100b00655d711180dsm665001qvb.17.2023.10.27.07.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 07:38:50 -0700 (PDT)
Message-ID: <614e98f1-d35e-4f0a-98e6-e51ad61c179d@redhat.com>
Date: Fri, 27 Oct 2023 16:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/37] vfio/common: Move giommu_list in base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-10-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-10-zhenzhong.duan@intel.com>
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
> Move the giommu_list field in the base object and store the
> base container in the VFIOGuestIOMMU.
> 
> We introduce vfio_container_init/destroy helper on the base
> container.

This could have been a prereq patch.

> 
> No fucntional change intended.

functional

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> [ clg: context changes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

You can drop my Sob here and in all patches. The changes I did were
due to the recent 'iova_ranges' addition and the context was fuzzy.
Nothing major.

The rest looks good.

Thanks,

C.

> ---
>   include/hw/vfio/vfio-common.h         |  9 ---------
>   include/hw/vfio/vfio-container-base.h | 13 +++++++++++++
>   hw/vfio/common.c                      | 17 +++++++++++------
>   hw/vfio/container-base.c              | 18 ++++++++++++++++++
>   hw/vfio/container.c                   | 13 +++----------
>   5 files changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 97056224f4..fcb4003a21 100644
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
> index 077e638ee8..71e1e4324e 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -43,8 +43,17 @@ typedef struct {
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
> @@ -52,6 +61,10 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
>   
> +void vfio_container_init(VFIOContainerBase *bcontainer,
> +                         const VFIOIOMMUOps *ops);
> +void vfio_container_destroy(VFIOContainerBase *bcontainer);
> +
>   struct VFIOIOMMUOps {
>       /* basic feature */
>       int (*dma_map)(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 141f2b54a4..4f130ad87c 100644
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
> @@ -613,7 +614,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           giommu->iommu_mr = iommu_mr;
>           giommu->iommu_offset = section->offset_within_address_space -
>                                  section->offset_within_region;
> -        giommu->container = container;
> +        giommu->bcontainer = bcontainer;
>           llend = int128_add(int128_make64(section->offset_within_region),
>                              section->size);
>           llend = int128_sub(llend, int128_one());
> @@ -648,7 +649,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>               g_free(giommu);
>               goto fail;
>           }
> -        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> +        QLIST_INSERT_HEAD(&bcontainer->giommu_list, giommu, giommu_next);
>           memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>   
>           return;
> @@ -733,6 +734,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
>       VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       int ret;
> @@ -745,7 +747,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       if (memory_region_is_iommu(section->mr)) {
>           VFIOGuestIOMMU *giommu;
>   
> -        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>               if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>                   giommu->n.start == section->offset_within_region) {
>                   memory_region_unregister_iommu_notifier(section->mr,
> @@ -1208,7 +1210,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
> @@ -1286,12 +1290,13 @@ static int vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainer *container,
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
> index 9db8b89b2f..6be7ce65ad 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -47,3 +47,21 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>   
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
> +
> +void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
> +{
> +    bcontainer->ops = ops;
> +    QLIST_INIT(&bcontainer->giommu_list);
> +}
> +
> +void vfio_container_destroy(VFIOContainerBase *bcontainer)
> +{
> +    VFIOGuestIOMMU *giommu, *tmp;
> +
> +    QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
> +        memory_region_unregister_iommu_notifier(
> +                MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> +        QLIST_REMOVE(giommu, giommu_next);
> +        g_free(giommu);
> +    }
> +}
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c04df26323..b2b6e05287 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -556,10 +556,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->dirty_pages_supported = false;
>       container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
> -    QLIST_INIT(&container->giommu_list);
>       QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
> -    bcontainer->ops = &vfio_legacy_ops;
> +    vfio_container_init(bcontainer, &vfio_legacy_ops);
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -661,6 +660,7 @@ put_space_exit:
>   static void vfio_disconnect_container(VFIOGroup *group)
>   {
>       VFIOContainer *container = group->container;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> @@ -685,16 +685,9 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   
>       if (QLIST_EMPTY(&container->group_list)) {
>           VFIOAddressSpace *space = container->space;
> -        VFIOGuestIOMMU *giommu, *tmp;
>   
>           QLIST_REMOVE(container, next);
> -
> -        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> -            memory_region_unregister_iommu_notifier(
> -                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
> -            QLIST_REMOVE(giommu, giommu_next);
> -            g_free(giommu);
> -        }
> +        vfio_container_destroy(bcontainer);
>   
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);


