Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C77D93B1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJAp-0007MU-NU; Fri, 27 Oct 2023 05:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwJAa-0007M1-2V
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwJAY-0000TJ-4w
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4d1fVjR1RFuH0ZfbSynWDGtAMdFLaUVkCcIZ6udO3Q=;
 b=ALwBkmWWkTeLg4mTz8T/J8MSHqmb3P9AsiyfpGBfxeXyVLHehXQmrCKgzF3LY27p56/Duj
 jX1h4G2jnAgkDGt5NEwYe6DfnS1csyptCeu7MIp7uDI0ygntzj+oZV3sIF+F+u72PYG6fE
 D9GsJRB1wFcxwWbwSA7KR35PRULrKAU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-eioWNjIlMRWTU-zIcRp9Ag-1; Fri, 27 Oct 2023 05:30:13 -0400
X-MC-Unique: eioWNjIlMRWTU-zIcRp9Ag-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7789a691086so251102585a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698399012; x=1699003812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4d1fVjR1RFuH0ZfbSynWDGtAMdFLaUVkCcIZ6udO3Q=;
 b=CBw8lGX2quBaVwHg8hZRVjmiM/SrlmylSfqtbXtojdfDX5M3yDwNTqmX5de9koaX0Y
 Vmwl1mBcs0vv8Xhs4eyyVrHd8u+2M7almMDiMqfPLGHmKnqwA5iPr8OoXwqWm+gSz0ns
 nNh0r0+qcDI39STq51ecEroDfBk5a802bxCARkAG/N7nc0rgaXVLtLHmzGisUwFRRrrM
 97lVjhkiuEY4zpx5ZqLTOTlqLCws4FcTdTSD4OZ1CTKkv/a/Kp0KVlMWX3dDZjOQf1ug
 icUY2ScQHR8ozRGl5vw5bLFU3023mAwTnbwSNQ9BgiZOmW50eoqeR7j6Gnikfk4/mCia
 CISQ==
X-Gm-Message-State: AOJu0YyIFSgnRq2X6DfnOoXGfxqEDiCgTeAK5xx2h5YOrZIuV7mXC6Tr
 ZlbBTZ4+Pk+pF2EpA7oHcUdxdS5wnhWLjQgs7za/9JxJKMi5JRp6Z+0RbMCUP87V1q5rNX5+EWm
 qkEkf5UUG7hmrgjA=
X-Received: by 2002:a05:620a:4050:b0:775:9026:31ac with SMTP id
 i16-20020a05620a405000b00775902631acmr1953551qko.9.1698399012325; 
 Fri, 27 Oct 2023 02:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFKmCZq/dq89riONM/xDWpkNUCo3ZdavU6oTKxY/GcPclmTx6Bxj30bp7LX6taiKSICYRizw==
X-Received: by 2002:a05:620a:4050:b0:775:9026:31ac with SMTP id
 i16-20020a05620a405000b00775902631acmr1953533qko.9.1698399011995; 
 Fri, 27 Oct 2023 02:30:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 ay17-20020a05620a179100b00765ab6d3e81sm388550qkb.122.2023.10.27.02.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:30:11 -0700 (PDT)
Message-ID: <70e8f3e0-ddff-4155-9ee6-4660d2ed0178@redhat.com>
Date: Fri, 27 Oct 2023 11:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/37] vfio/common: Move vfio_host_win_add/del into
 spapr.c
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-6-zhenzhong.duan@intel.com>
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
> Only spapr supports a customed host window list, other vfio driver
> assume 64bit host window. So remove the check in listener callback
> and move vfio_host_win_add/del into spapr.c and make static.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  5 ---
>   hw/vfio/common.c              | 64 -----------------------------------
>   hw/vfio/container.c           | 16 ---------
>   hw/vfio/spapr.c               | 38 +++++++++++++++++++++
>   4 files changed, 38 insertions(+), 85 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3174b3c5c..b9c7a7e588 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -207,11 +207,6 @@ typedef struct {
>       hwaddr pages;
>   } VFIOBitmap;
>   
> -void vfio_host_win_add(VFIOContainer *container,
> -                       hwaddr min_iova, hwaddr max_iova,
> -                       uint64_t iova_pgsizes);
> -int vfio_host_win_del(VFIOContainer *container, hwaddr min_iova,
> -                      hwaddr max_iova);
>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
>   bool vfio_devices_all_running_and_saving(VFIOContainer *container);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e72055e752..0ebf4d9256 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -245,44 +245,6 @@ bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>       return true;
>   }
>   
> -void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
> -                       hwaddr max_iova, uint64_t iova_pgsizes)
> -{
> -    VFIOHostDMAWindow *hostwin;
> -
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> -        if (ranges_overlap(hostwin->min_iova,
> -                           hostwin->max_iova - hostwin->min_iova + 1,
> -                           min_iova,
> -                           max_iova - min_iova + 1)) {
> -            hw_error("%s: Overlapped IOMMU are not enabled", __func__);
> -        }
> -    }
> -
> -    hostwin = g_malloc0(sizeof(*hostwin));
> -
> -    hostwin->min_iova = min_iova;
> -    hostwin->max_iova = max_iova;
> -    hostwin->iova_pgsizes = iova_pgsizes;
> -    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
> -}
> -
> -int vfio_host_win_del(VFIOContainer *container,
> -                      hwaddr min_iova, hwaddr max_iova)
> -{
> -    VFIOHostDMAWindow *hostwin;
> -
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> -        if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
> -            QLIST_REMOVE(hostwin, hostwin_next);
> -            g_free(hostwin);
> -            return 0;
> -        }
> -    }
> -
> -    return -1;
> -}
> -
>   static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>   {
>       return (!memory_region_is_ram(section->mr) &&
> @@ -531,22 +493,6 @@ static void vfio_unregister_ram_discard_listener(VFIOContainer *container,
>       g_free(vrdl);
>   }
>   
> -static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
> -                                            hwaddr iova, hwaddr end)
> -{
> -    VFIOHostDMAWindow *hostwin;
> -    bool hostwin_found = false;
> -
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> -        if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
> -            hostwin_found = true;
> -            break;
> -        }
> -    }
> -
> -    return hostwin_found ? hostwin : NULL;
> -}
> -
>   static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>   {
>       MemoryRegion *mr = section->mr;
> @@ -647,13 +593,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           goto fail;
>       }
>   
> -    hostwin = vfio_find_hostwin(container, iova, end);
> -    if (!hostwin) {
> -        error_setg(&err, "Container %p can't map guest IOVA region"
> -                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
> -        goto fail;
> -    }
> -
>       memory_region_ref(section->mr);
>   
>       if (memory_region_is_iommu(section->mr)) {
> @@ -835,9 +774,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           hwaddr pgmask;
>           VFIOHostDMAWindow *hostwin;
>   
> -        hostwin = vfio_find_hostwin(container, iova, end);
> -        assert(hostwin); /* or region_add() would have failed */
> -
>           pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>           try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 204b244b11..242010036a 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -551,7 +551,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->dma_max_mappings = 0;
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->giommu_list);
> -    QLIST_INIT(&container->hostwin_list);
>       QLIST_INIT(&container->vrdl_list);
>   
>       ret = vfio_init_container(container, group->fd, errp);
> @@ -591,14 +590,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>           vfio_get_iommu_info_migration(container, info);
>           g_free(info);
> -
> -        /*
> -         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> -         * information to get the actual window extent rather than assume
> -         * a 64-bit IOVA address space.
> -         */
> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
> -
>           break;
>       }
>       case VFIO_SPAPR_TCE_v2_IOMMU:
> @@ -687,7 +678,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       if (QLIST_EMPTY(&container->group_list)) {
>           VFIOAddressSpace *space = container->space;
>           VFIOGuestIOMMU *giommu, *tmp;
> -        VFIOHostDMAWindow *hostwin, *next;
>   
>           QLIST_REMOVE(container, next);
>   
> @@ -698,12 +688,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
>               g_free(giommu);
>           }
>   
> -        QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
> -                           next) {
> -            QLIST_REMOVE(hostwin, hostwin_next);
> -            g_free(hostwin);
> -        }
> -
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);
>           vfio_free_container(container);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 43adbdb7b3..3495737ab2 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -146,6 +146,44 @@ static const MemoryListener vfio_prereg_listener = {
>       .region_del = vfio_prereg_listener_region_del,
>   };
>   
> +static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
> +                              hwaddr max_iova, uint64_t iova_pgsizes)
> +{
> +    VFIOHostDMAWindow *hostwin;
> +
> +    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +        if (ranges_overlap(hostwin->min_iova,
> +                           hostwin->max_iova - hostwin->min_iova + 1,
> +                           min_iova,
> +                           max_iova - min_iova + 1)) {
> +            hw_error("%s: Overlapped IOMMU are not enabled", __func__);
> +        }
> +    }
> +
> +    hostwin = g_malloc0(sizeof(*hostwin));
> +
> +    hostwin->min_iova = min_iova;
> +    hostwin->max_iova = max_iova;
> +    hostwin->iova_pgsizes = iova_pgsizes;
> +    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
> +}
> +
> +static int vfio_host_win_del(VFIOContainer *container,
> +                             hwaddr min_iova, hwaddr max_iova)
> +{
> +    VFIOHostDMAWindow *hostwin;
> +
> +    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +        if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
> +            QLIST_REMOVE(hostwin, hostwin_next);
> +            g_free(hostwin);
> +            return 0;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
>   static int vfio_spapr_remove_window(VFIOContainer *container,
>                                       hwaddr offset_within_address_space)
>   {


