Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88AE7E2A61
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:51:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02oc-0007GP-1V; Mon, 06 Nov 2023 11:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oY-0007GD-2g
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02oW-0002lt-4v
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhxUSHqgxFTeILp36fFMH9B/fIivx7h2z2wLf6jg8J8=;
 b=eQCQsIL5V0JkBn+vnHXQfzNmY2LFQ71zfNwtPN6bA1sOCrrpbJek2JVc8FZvMFHI21nu4l
 J39TnxqJmk6JA6OE+++X8pBEEHofsCr99BJN8eYzakEnO4WxJPGHWdklelBZlEML43zGo3
 w/bBXYA1QbZeoUVTrT8rHa2IZ663ay8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-paCPWGJXNjiM5zI_ZJ5Khg-1; Mon, 06 Nov 2023 11:50:58 -0500
X-MC-Unique: paCPWGJXNjiM5zI_ZJ5Khg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5afa071d100so95409197b3.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289457; x=1699894257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IhxUSHqgxFTeILp36fFMH9B/fIivx7h2z2wLf6jg8J8=;
 b=ljS82R+a9srcLPMt/bPZQ3EPtZJEr/ZOloU2x2uBgODaIPXWAGOaqYMb8L2+2lzod7
 kpcHcfQwZQ+0rjEbrHsu2eTkociM9x/qxS7FtIA8IPdM9iEzGO/dcUS4njJw7pSElZit
 iOSMrpOl1mx+m/W8flt9S+SDDc/6VJAaTsk4+XOtyr42zO0K0okYjd55ly5jh3qGP13L
 Y2OeHOdoAMfdJ6SB6TXcZ2sTChrLOeuKKPUbPhV5uL7A4L1vfOVvJqAlWgYlFvVesh3v
 Zi1GfH2CZ2LfVS0r0OwxCmCKRY4j3OW4h07U5yT9UZeoYxf+yCcp/CTi0L5qPJ88y8GY
 9glQ==
X-Gm-Message-State: AOJu0Yw3vmxcu6EdgPnlUrUVEj3sGhrUwSO3eSfntHj3kCOyXrXP7JcM
 /earyictnITHj68vJfJxEFSh3x/ZSLCJMMpJWIBvmqoNVbcKcNYk87SEPh7UyXLWrlcs4POyH61
 m+ubG7L5GmuiZDr8=
X-Received: by 2002:a25:aa47:0:b0:d9a:5895:2c74 with SMTP id
 s65-20020a25aa47000000b00d9a58952c74mr27753458ybi.42.1699289457554; 
 Mon, 06 Nov 2023 08:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz39sQGZwsNiXbFdKl5jZ3jXp8eES5kHHMlgbmdI5ku8b8aW0R266yl2VhSr+w8y0bAPNNbw==
X-Received: by 2002:a25:aa47:0:b0:d9a:5895:2c74 with SMTP id
 s65-20020a25aa47000000b00d9a58952c74mr27753435ybi.42.1699289457118; 
 Mon, 06 Nov 2023 08:50:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mz20-20020a0562142d1400b006713142482fsm3576258qvb.74.2023.11.06.08.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:50:56 -0800 (PST)
Message-ID: <218ce6a3-7d86-4e4e-8e26-2a0000226d62@redhat.com>
Date: Mon, 6 Nov 2023 17:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/41] vfio/container: Switch to IOMMU BE
 set_dirty_page_tracking/query_dirty_bitmap API
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-13-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-13-zhenzhong.duan@intel.com>
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> dirty_pages_supported field is also moved to the base container
> 
> No fucntional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: use assert


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
>   include/hw/vfio/vfio-common.h         |  6 ------
>   include/hw/vfio/vfio-container-base.h |  6 ++++++
>   hw/vfio/common.c                      | 12 ++++++++----
>   hw/vfio/container-base.c              | 16 ++++++++++++++++
>   hw/vfio/container.c                   | 21 ++++++++++++++-------
>   5 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index bd4de6cb3a..60f2785fe0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -83,7 +83,6 @@ typedef struct VFIOContainer {
>       unsigned iommu_type;
>       Error *error;
>       bool initialized;
> -    bool dirty_pages_supported;
>       uint64_t dirty_pgsizes;
>       uint64_t max_dirty_bitmap_size;
>       unsigned long pgsizes;
> @@ -190,11 +189,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
>   bool vfio_devices_all_running_and_saving(VFIOContainer *container);
>   
> -/* container->fd */
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start);
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> -                            hwaddr iova, hwaddr size);
> -
>   /* SPAPR specific */
>   int vfio_container_add_section_window(VFIOContainer *container,
>                                         MemoryRegionSection *section,
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index c7cc6ec9c5..f244f003d0 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -36,6 +36,7 @@ typedef struct VFIOAddressSpace {
>   typedef struct VFIOContainerBase {
>       const VFIOIOMMUOps *ops;
>       VFIOAddressSpace *space;
> +    bool dirty_pages_supported;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
>   } VFIOContainerBase;
> @@ -54,6 +55,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
> +int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> +                                           bool start);
> +int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap,
> +                                      hwaddr iova, hwaddr size);
>   
>   void vfio_container_init(VFIOContainerBase *bcontainer,
>                            VFIOAddressSpace *space,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1d8202537e..b1a875ca93 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1079,7 +1079,8 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
>       if (vfio_devices_all_device_dirty_tracking(container)) {
>           ret = vfio_devices_dma_logging_start(container);
>       } else {
> -        ret = vfio_set_dirty_page_tracking(container, true);
> +        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
> +                                                     true);
>       }
>   
>       if (ret) {
> @@ -1097,7 +1098,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>       if (vfio_devices_all_device_dirty_tracking(container)) {
>           vfio_devices_dma_logging_stop(container);
>       } else {
> -        ret = vfio_set_dirty_page_tracking(container, false);
> +        ret = vfio_container_set_dirty_page_tracking(&container->bcontainer,
> +                                                     false);
>       }
>   
>       if (ret) {
> @@ -1165,7 +1167,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       VFIOBitmap vbmap;
>       int ret;
>   
> -    if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
> +    if (!container->bcontainer.dirty_pages_supported &&
> +        !all_device_dirty_tracking) {
>           cpu_physical_memory_set_dirty_range(ram_addr, size,
>                                               tcg_enabled() ? DIRTY_CLIENTS_ALL :
>                                               DIRTY_CLIENTS_NOCODE);
> @@ -1180,7 +1183,8 @@ int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       if (all_device_dirty_tracking) {
>           ret = vfio_devices_query_dirty_bitmap(container, &vbmap, iova, size);
>       } else {
> -        ret = vfio_query_dirty_bitmap(container, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(&container->bcontainer, &vbmap,
> +                                                iova, size);
>       }
>   
>       if (ret) {
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 3933391e0d..5d654ae172 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -31,11 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
>   
> +int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> +                                           bool start)
> +{
> +    g_assert(bcontainer->ops->set_dirty_page_tracking);
> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
> +}
> +
> +int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap,
> +                                      hwaddr iova, hwaddr size)
> +{
> +    g_assert(bcontainer->ops->query_dirty_bitmap);
> +    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
> +}
> +
>   void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>                            const VFIOIOMMUOps *ops)
>   {
>       bcontainer->ops = ops;
>       bcontainer->space = space;
> +    bcontainer->dirty_pages_supported = false;
>       QLIST_INIT(&bcontainer->giommu_list);
>   }
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index f12fcb6fe1..3ab74e2615 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>   
>       if (iotlb && vfio_devices_all_running_and_mig_active(container)) {
>           if (!vfio_devices_all_device_dirty_tracking(container) &&
> -            container->dirty_pages_supported) {
> +            container->bcontainer.dirty_pages_supported) {
>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>           }
>   
> @@ -205,14 +205,17 @@ static int vfio_legacy_dma_map(VFIOContainerBase *bcontainer, hwaddr iova,
>       return -errno;
>   }
>   
> -int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
> +static int vfio_legacy_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> +                                               bool start)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
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
> @@ -232,9 +235,12 @@ int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
>       return ret;
>   }
>   
> -int vfio_query_dirty_bitmap(VFIOContainer *container, VFIOBitmap *vbmap,
> -                            hwaddr iova, hwaddr size)
> +static int vfio_legacy_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> +                                          VFIOBitmap *vbmap,
> +                                          hwaddr iova, hwaddr size)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
>       struct vfio_iommu_type1_dirty_bitmap_get *range;
>       int ret;
> @@ -461,7 +467,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>        * qemu_real_host_page_size to mark those dirty.
>        */
>       if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
> -        container->dirty_pages_supported = true;
> +        container->bcontainer.dirty_pages_supported = true;
>           container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
>           container->dirty_pgsizes = cap_mig->pgsize_bitmap;
>       }
> @@ -553,7 +559,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container = g_malloc0(sizeof(*container));
>       container->fd = fd;
>       container->error = NULL;
> -    container->dirty_pages_supported = false;
>       container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->vrdl_list);
> @@ -937,4 +942,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   const VFIOIOMMUOps vfio_legacy_ops = {
>       .dma_map = vfio_legacy_dma_map,
>       .dma_unmap = vfio_legacy_dma_unmap,
> +    .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
> +    .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
>   };


