Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0837E2B00
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03Tm-0008M4-IC; Mon, 06 Nov 2023 12:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Tk-0008KX-VV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Tg-00041y-Uw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e70Clxp8VHcazj6H+2iqFFoow1lZV39HD+VFuueXWXM=;
 b=IC87uY7A8bChasudqieH5Zdf8TnMyQqdsXAFrU/puJiKo+rDnrcimRkMVMhabkEGCWfxGP
 XxSTCS2bLtWXaIIZxlygbLqhLyvDpX8zmCcb0d2Of4mN/42ZE/PEMGSeRX3acRz9n4mYLS
 miv2wGvy+kAbrO7O7bBc3+/K2DOa6Z0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-jhfoJh_yP4SHsJQNQ6sPlw-1; Mon, 06 Nov 2023 12:33:30 -0500
X-MC-Unique: jhfoJh_yP4SHsJQNQ6sPlw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4a9420acd14so1813859e0c.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292009; x=1699896809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e70Clxp8VHcazj6H+2iqFFoow1lZV39HD+VFuueXWXM=;
 b=wUsny+QCV44Iesfyplx99hsyIp6qxotMMRbTvWCzpnzGSduX6gsv3hZnwW1tbav4wN
 tnMxBhE60lLcBvJ0504VvCYIhebwHaFDCK6BqdDLJR3zHrXADJ+qDxdRSc14Gp0QO7wW
 yOONyjSbRPdW6wm+zi8I1hJIgCdD+weR9x7DZclTAJ2yy4LVKd8nTWD5dk8aa1OznTWi
 MxbO1whz6Tc0XDKNEBKioFlA8fshhPe7LzcPkPnjEFw0Z+KhP7kGGdymKEPs6pUSPBcq
 Sro/KpIzb9Z7Sq1M6zazszaFha62pzfe0s/tP+aYuEux5g2JWYnIhaGJrQu4Elw47GQ+
 M4Qg==
X-Gm-Message-State: AOJu0YwGYRkpoPYmJkgDh2yKHPmYM8Lgk93A9t/MgUlnQ9PGX7LBZOl0
 Io6M4d7+Eo2MWn81UAApsCv5vyLttQ0GHTsCHtYYPXdHzhXyL7zZffXrlZDS7fGs+G+cBjZydeu
 nMj8VEd53uTB0c5Q=
X-Received: by 2002:a1f:17c6:0:b0:4ab:fdb9:cb1f with SMTP id
 189-20020a1f17c6000000b004abfdb9cb1fmr6614793vkx.15.1699292009509; 
 Mon, 06 Nov 2023 09:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+0h61kIs3LAPOOtJz1lZDrJXllTPc2HraKMs5QPV5AqrtPXtFVYkB/eUyOntNKRi7P2tvtg==
X-Received: by 2002:a1f:17c6:0:b0:4ab:fdb9:cb1f with SMTP id
 189-20020a1f17c6000000b004abfdb9cb1fmr6614772vkx.15.1699292009178; 
 Mon, 06 Nov 2023 09:33:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a05620a244b00b007778503ebf4sm3463812qkn.16.2023.11.06.09.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 09:33:28 -0800 (PST)
Message-ID: <42508355-9891-4d20-96fe-c470bc7d9747@redhat.com>
Date: Mon, 6 Nov 2023 18:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
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
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-23-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-23-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> No fucntional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         |  5 -----
>   include/hw/vfio/vfio-container-base.h |  5 +++++
>   hw/vfio/common.c                      |  8 ++------
>   hw/vfio/container-base.c              | 21 +++++++++++++++++++++
>   hw/vfio/spapr.c                       | 19 ++++++++++++++-----
>   5 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9e5a0e64b..055f679363 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -169,11 +169,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>   void vfio_put_address_space(VFIOAddressSpace *space);
>   
>   /* SPAPR specific */
> -int vfio_container_add_section_window(VFIOContainer *container,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp);
> -void vfio_container_del_section_window(VFIOContainer *container,
> -                                       MemoryRegionSection *section);
>   int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
>   void vfio_spapr_container_deinit(VFIOContainer *container);
>   
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index f62a14ac73..4b6f017c6f 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -75,6 +75,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
> +int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> +                                      MemoryRegionSection *section,
> +                                      Error **errp);
> +void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
> +                                       MemoryRegionSection *section);
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start);
>   int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 483ba82089..572ae7c934 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -571,8 +571,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       void *vaddr;
> @@ -595,7 +593,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> -    if (vfio_container_add_section_window(container, section, &err)) {
> +    if (vfio_container_add_section_window(bcontainer, section, &err)) {
>           goto fail;
>       }
>   
> @@ -738,8 +736,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
>       hwaddr iova, end;
>       Int128 llend, llsize;
>       int ret;
> @@ -818,7 +814,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   
>       memory_region_unref(section->mr);
>   
> -    vfio_container_del_section_window(container, section);
> +    vfio_container_del_section_window(bcontainer, section);
>   }
>   
>   typedef struct VFIODirtyRanges {
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 0177f43741..71f7274973 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -31,6 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
>   
> +int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> +                                      MemoryRegionSection *section,
> +                                      Error **errp)
> +{
> +    if (!bcontainer->ops->add_window) {
> +        return 0;
> +    }

These should an assert right ? because only called on the pseries
platform which defines the handlers.


Thanks,

C.

  


> +    return bcontainer->ops->add_window(bcontainer, section, errp);
> +}
> +
> +void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
> +                                       MemoryRegionSection *section)
> +{
> +    if (!bcontainer->ops->del_window) {
> +        return;
> +    }
> +
> +    return bcontainer->ops->del_window(bcontainer, section);
> +}
> +
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start)
>   {
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index e1a6b35563..5be1911aad 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -319,10 +319,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -int vfio_container_add_section_window(VFIOContainer *container,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp)
> +static int
> +vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
> +                                        MemoryRegionSection *section,
> +                                        Error **errp)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
>       VFIOHostDMAWindow *hostwin;
>       hwaddr pgsize = 0;
>       int ret;
> @@ -407,9 +410,13 @@ int vfio_container_add_section_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -void vfio_container_del_section_window(VFIOContainer *container,
> -                                       MemoryRegionSection *section)
> +static void
> +vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
> +                                        MemoryRegionSection *section)
>   {
> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                            bcontainer);
> +
>       if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>           return;
>       }
> @@ -430,6 +437,8 @@ static VFIOIOMMUOps vfio_iommu_spapr_ops;
>   static void setup_spapr_ops(VFIOContainerBase *bcontainer)
>   {
>       vfio_iommu_spapr_ops = *bcontainer->ops;
> +    vfio_iommu_spapr_ops.add_window = vfio_spapr_container_add_section_window;
> +    vfio_iommu_spapr_ops.del_window = vfio_spapr_container_del_section_window;
>       bcontainer->ops = &vfio_iommu_spapr_ops;
>   }
>   


