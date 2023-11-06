Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EF7E2A65
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:53:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02r2-0001Au-Ds; Mon, 06 Nov 2023 11:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02r1-00018o-2Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02qy-00039I-44
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pioPo67MuSr21Bq6Ib3+MfQody4WRSIqOAEq5jX188=;
 b=VR0i2XIHc0Ggv7r7n/AifhQftO42jJN3irS+i0HRlYX1rkEMaeZKIqofMEuHUxijcAJ0YR
 guNOiqWp2AISLNufnYAYN60zjFC6Hi+Aif+W9+e8yfrZerMviG5XFC/T534RJSdUpmzg8j
 aZLpJdaO1xdQhPO2H2YBcrNs9a5BwEM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-uhr6gRRcMkadxY9Ga6y6MQ-1; Mon, 06 Nov 2023 11:53:30 -0500
X-MC-Unique: uhr6gRRcMkadxY9Ga6y6MQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41eaf5d20d8so24867981cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289609; x=1699894409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3pioPo67MuSr21Bq6Ib3+MfQody4WRSIqOAEq5jX188=;
 b=DSKL3UtHzXiLOgSE02F8v8eZEpohtQTssTphJOdyOdjTVI6kPJa6kkTIlwW8RPQRei
 acHF5MSxWXXGgwOY77WwgoZ5dR+yJNE5oPoZokZIaG6a+KqpDvmaynJDat5wBrNigDdM
 PJmdrrr+qMwP9/h4M5G/rR1wOj+3dQjG6T8jEtfvHGtWol588WidC+Zse4OWoGKKvD4v
 ox9JG9ahUUwyp1tUpjyiyDl4Ublzi9Dp8h+3sp79ao4+UdAZr+okAkAjNC4/k1V6hybu
 1O1ew1Vnljr9Ft/two4pdW+f5zgHs9rJwWKRcjEhuLQxwPhyA29lE+pVPtrXl6LOYrlR
 WdAg==
X-Gm-Message-State: AOJu0Yw/AcafcxQTe4eMy8t9uoQ/OianfoUft1Qiqr8La2F+fJclIOJa
 QC0aYKsNAJ76682fGOXSS8zGfnaWMcpv+N8rF4VgFME78lmcyt9Nv7+1Wj++Smlhdw+1c4auSBL
 m8xDEa14iNYjMShJKl8Dx2KM=
X-Received: by 2002:ac8:4e51:0:b0:41c:e92a:c604 with SMTP id
 e17-20020ac84e51000000b0041ce92ac604mr38321383qtw.59.1699289609064; 
 Mon, 06 Nov 2023 08:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8o0iDXZxgweSEpPv1yRdFhSd0OTL7QWNdxSpmP0IDNt9ucucMCWVB6D8a1TCJemCoiaS6Fg==
X-Received: by 2002:ac8:4e51:0:b0:41c:e92a:c604 with SMTP id
 e17-20020ac84e51000000b0041ce92ac604mr38321354qtw.59.1699289608742; 
 Mon, 06 Nov 2023 08:53:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r22-20020ac85e96000000b0041ce9ebaad2sm3592763qtx.43.2023.11.06.08.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:53:28 -0800 (PST)
Message-ID: <e553a68f-4213-4f27-9083-5f7a2c2a77ff@redhat.com>
Date: Mon, 6 Nov 2023 17:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/41] vfio/container: Move vrdl_list to base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-17-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-17-zhenzhong.duan@intel.com>
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
> No functional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h         | 11 --------
>   include/hw/vfio/vfio-container-base.h | 11 ++++++++
>   hw/vfio/common.c                      | 38 +++++++++++++--------------
>   hw/vfio/container-base.c              |  1 +
>   hw/vfio/container.c                   |  1 -
>   5 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d3dc2f9dcb..8a607a4c17 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -87,20 +87,9 @@ typedef struct VFIOContainer {
>       uint64_t max_dirty_bitmap_size;
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
> index 85ec7e1a56..8e05b5ac5a 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -40,6 +40,7 @@ typedef struct VFIOContainerBase {
>       unsigned int dma_max_mappings;
>       bool dirty_pages_supported;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> +    QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
>       QLIST_HEAD(, VFIODevice) device_list;
>   } VFIOContainerBase;
> @@ -52,6 +53,16 @@ typedef struct VFIOGuestIOMMU {
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
> index 1cb53d369e..f15665789f 100644
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
> @@ -398,10 +399,9 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>       return 0;
>   }
>   
> -static void vfio_register_ram_discard_listener(VFIOContainer *container,
> +static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>                                                  MemoryRegionSection *section)
>   {
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>       VFIORamDiscardListener *vrdl;
>   
> @@ -412,7 +412,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>       g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
>   
>       vrdl = g_new0(VFIORamDiscardListener, 1);
> -    vrdl->container = container;
> +    vrdl->bcontainer = bcontainer;
>       vrdl->mr = section->mr;
>       vrdl->offset_within_address_space = section->offset_within_address_space;
>       vrdl->size = int128_get64(section->size);
> @@ -427,7 +427,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>                                 vfio_ram_discard_notify_populate,
>                                 vfio_ram_discard_notify_discard, true);
>       ram_discard_manager_register_listener(rdm, &vrdl->listener, section);
> -    QLIST_INSERT_HEAD(&container->vrdl_list, vrdl, next);
> +    QLIST_INSERT_HEAD(&bcontainer->vrdl_list, vrdl, next);
>   
>       /*
>        * Sanity-check if we have a theoretically problematic setup where we could
> @@ -451,7 +451,7 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
>           }
>   #endif
>   
> -        QLIST_FOREACH(vrdl, &container->vrdl_list, next) {
> +        QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
>               hwaddr start, end;
>   
>               start = QEMU_ALIGN_DOWN(vrdl->offset_within_address_space,
> @@ -473,13 +473,13 @@ static void vfio_register_ram_discard_listener(VFIOContainer *container,
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
> @@ -663,7 +663,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>        * about changes.
>        */
>       if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_register_ram_discard_listener(container, section);
> +        vfio_register_ram_discard_listener(bcontainer, section);
>           return;
>       }
>   
> @@ -781,7 +781,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
>           try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        vfio_unregister_ram_discard_listener(container, section);
> +        vfio_unregister_ram_discard_listener(bcontainer, section);
>           /* Unregistering will trigger an unmap. */
>           try_unmap = false;
>       }
> @@ -1260,17 +1260,17 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
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
> @@ -1324,7 +1324,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>           }
>           return 0;
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(container, section);
> +        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
>       }
>   
>       ram_addr = memory_region_get_ram_addr(section->mr) +
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index dcce111349..584eee4ba1 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>       bcontainer->dirty_pages_supported = false;
>       bcontainer->dma_max_mappings = 0;
>       QLIST_INIT(&bcontainer->giommu_list);
> +    QLIST_INIT(&bcontainer->vrdl_list);
>   }
>   
>   void vfio_container_destroy(VFIOContainerBase *bcontainer)
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c5a6262882..6ba2e2f8c4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -560,7 +560,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->fd = fd;
>       container->error = NULL;
>       container->iova_ranges = NULL;
> -    QLIST_INIT(&container->vrdl_list);
>       bcontainer = &container->bcontainer;
>       vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>   


