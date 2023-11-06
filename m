Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E279C7E2A81
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:59:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02vx-00039G-7S; Mon, 06 Nov 2023 11:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02vo-00034E-15
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02vm-00044t-8Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699289908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wz2/nqqymEd4fJQYC4omBlDDLHXLR110uKJ/JL5VrAg=;
 b=RFOYYMJFQV5jLRnI0hDfBEZd3hhUBMMTT39z28bj1EGWXRcrircfc9+Z+6ymVH6UzuDonS
 cFDkz8L1S9GRvO6U3crnb5cZcbtvvSmdrqcniC8PdUZj57MJV2yDnqkEGLZWu3wgf8ePdU
 e4bHY7f8IItS3/6tSVTyS+qwXtt0p14=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-GXuxDOkdP_ad_OatqIakRw-1; Mon, 06 Nov 2023 11:58:27 -0500
X-MC-Unique: GXuxDOkdP_ad_OatqIakRw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d08175882so55349456d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289907; x=1699894707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wz2/nqqymEd4fJQYC4omBlDDLHXLR110uKJ/JL5VrAg=;
 b=UbIdowfS608ZF44vmTIWSnS13Ju4L5QrKjh81Pnn9JboUMEl/o5ttHC66mB9mTEhv7
 HHFzF87931puO3HOUXSVV8ZsHDOUoFSHPGdHBQnnvo/qpqtv3WSb7GkaRBHaz6EratwG
 i7X9t2oecoUXEsX03FTjrpj5Svy2+2WfW7BG4Odl7KyTpLpxGB25eEs+nCdh1IqpJnxx
 5cbrIwGZzCAcUwjcTKxKoujnAvDyhhOn7cKSQgNpZQyGxhLA6DMfNL2JnInZgFksCB5q
 SOJUgwYd6hLglisMKH7OUQxqSXhnYshhnJKRjRf4K/MqjF2xnui3eKTNzBCAujUWMOMN
 vqKQ==
X-Gm-Message-State: AOJu0YyfV/REMWY9602aXaIgBchMoPSibBC61Qs55qSpyaofZYK3EWBX
 ZmqgV6+hTiG0Q25SrrfjoYKYyIjjv/Vkta9K41HDaiXyPMcaefq5qwiHqRcLNiKzDceHTyNfRfH
 MkaS8Z9jOl8qD8rI=
X-Received: by 2002:a05:6214:3009:b0:66d:65ae:18f6 with SMTP id
 ke9-20020a056214300900b0066d65ae18f6mr33805744qvb.50.1699289906946; 
 Mon, 06 Nov 2023 08:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFNzR0hWXneL7zgWaP2fEn6LN6uJa+e53C9lb5vg+BW6T29LdhjOb/7017J9tOl0Y47rQ6qg==
X-Received: by 2002:a05:6214:3009:b0:66d:65ae:18f6 with SMTP id
 ke9-20020a056214300900b0066d65ae18f6mr33805725qvb.50.1699289906612; 
 Mon, 06 Nov 2023 08:58:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a0cfd61000000b006616fbcc077sm3584120qvs.129.2023.11.06.08.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:58:26 -0800 (PST)
Message-ID: <2241cab7-4903-4af8-9670-3731e799a560@redhat.com>
Date: Mon, 6 Nov 2023 17:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/41] vfio/container: Move iova_ranges to base
 container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-20-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-20-zhenzhong.duan@intel.com>
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
> Meanwhile remove the helper function vfio_free_container as it
> only calls g_free now.
> 
> No functional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h         |  1 -
>   include/hw/vfio/vfio-container-base.h |  1 +
>   hw/vfio/common.c                      |  5 +++--
>   hw/vfio/container-base.c              |  3 +++
>   hw/vfio/container.c                   | 19 ++++++-------------
>   5 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b1c9fe711b..b9e5a0e64b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -82,7 +82,6 @@ typedef struct VFIOContainer {
>       unsigned iommu_type;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
> -    GList *iova_ranges;
>   } VFIOContainer;
>   
>   typedef struct VFIOHostDMAWindow {
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 80e4a993c5..9658ffb526 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -48,6 +48,7 @@ typedef struct VFIOContainerBase {
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
>       QLIST_HEAD(, VFIODevice) device_list;
> +    GList *iova_ranges;
>   } VFIOContainerBase;
>   
>   typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index be623e544b..8ef2e7967d 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -637,9 +637,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>               goto fail;
>           }
>   
> -        if (container->iova_ranges) {
> +        if (bcontainer->iova_ranges) {
>               ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
> -                    container->iova_ranges, &err);
> +                                                      bcontainer->iova_ranges,
> +                                                      &err);
>               if (ret) {
>                   g_free(giommu);
>                   goto fail;
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7f508669f5..0177f43741 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>       bcontainer->error = NULL;
>       bcontainer->dirty_pages_supported = false;
>       bcontainer->dma_max_mappings = 0;
> +    bcontainer->iova_ranges = NULL;
>       QLIST_INIT(&bcontainer->giommu_list);
>       QLIST_INIT(&bcontainer->vrdl_list);
>   }
> @@ -70,4 +71,6 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
>           QLIST_REMOVE(giommu, giommu_next);
>           g_free(giommu);
>       }
> +
> +    g_list_free_full(bcontainer->iova_ranges, g_free);
>   }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c8088a8174..721c0d7375 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -308,7 +308,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   }
>   
>   static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
> -                                     VFIOContainer *container)
> +                                     VFIOContainerBase *bcontainer)
>   {
>       struct vfio_info_cap_header *hdr;
>       struct vfio_iommu_type1_info_cap_iova_range *cap;
> @@ -326,8 +326,8 @@ static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
>   
>           range_set_bounds(range, cap->iova_ranges[i].start,
>                            cap->iova_ranges[i].end);
> -        container->iova_ranges =
> -            range_list_insert(container->iova_ranges, range);
> +        bcontainer->iova_ranges =
> +            range_list_insert(bcontainer->iova_ranges, range);
>       }
>   
>       return true;
> @@ -475,12 +475,6 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>       }
>   }
>   
> -static void vfio_free_container(VFIOContainer *container)
> -{
> -    g_list_free_full(container->iova_ranges, g_free);
> -    g_free(container);
> -}
> -
>   static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
> @@ -560,7 +554,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>       container = g_malloc0(sizeof(*container));
>       container->fd = fd;
> -    container->iova_ranges = NULL;
>       bcontainer = &container->bcontainer;
>       vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>   
> @@ -597,7 +590,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>               bcontainer->dma_max_mappings = 65535;
>           }
>   
> -        vfio_get_info_iova_range(info, container);
> +        vfio_get_info_iova_range(info, bcontainer);
>   
>           vfio_get_iommu_info_migration(container, info);
>           g_free(info);
> @@ -649,7 +642,7 @@ enable_discards_exit:
>       vfio_ram_block_discard_disable(container, false);
>   
>   free_container_exit:
> -    vfio_free_container(container);
> +    g_free(container);
>   
>   close_fd_exit:
>       close(fd);
> @@ -693,7 +686,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);
> -        vfio_free_container(container);
> +        g_free(container);
>   
>           vfio_put_address_space(space);
>       }


