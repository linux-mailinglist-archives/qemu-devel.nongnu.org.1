Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4F7DC820
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxk4y-0007TY-JL; Tue, 31 Oct 2023 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxk4w-0007Sm-Gv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxk4u-0008WG-M4
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698740784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIw75LLFB//W2BwhzJ1jmK8uIqKdHKnRHuiFDWMRkcI=;
 b=Hk1WzUd8xRPnPYcpjwW5CETZd3NI2ab15PGUlCS4D+kavmL+h3itsGhyVyP3g/PV2uq9OG
 +bhKOYTyogdtEbXIOYocwilzpdi6pZb++LoQKH9sy1tISKHbP7icWSv4FhecF2XpCtaB5m
 faAN95SgTLDggREoaZa4PfvBcrk3dpY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-TiPrXnwaNb6bBQZw_EQ7oQ-1; Tue, 31 Oct 2023 04:26:22 -0400
X-MC-Unique: TiPrXnwaNb6bBQZw_EQ7oQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778b5445527so971516485a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698740782; x=1699345582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RIw75LLFB//W2BwhzJ1jmK8uIqKdHKnRHuiFDWMRkcI=;
 b=WyfFyRf/wndeSZ88vH7c1dNoPtF0Gs9JBXrAobIBYnmfykM8pOzYjDpI4tvK4XUXEH
 +XUWmbxcKELJfZoD6EU6V7gHYfkDDMUkRnATyMBGndZy1chE8GRsmzB6XfJsu3AhYsIu
 62r0dTEV2pdWzpuhClpPoCybQcYxrdIAcIPtMLk8ihdquzARRqvs8zZ5m8nqKQ9Oi3dj
 VJj0pC6R9Fx2EQwCTFJoPDRuZ8wKcZJ3bk8a40A0MCppf5fZ0+eJQlLchiO9X/dxO+wJ
 tpO1d/uUXxhw1GDbQQlT3EXrugezCRWVsvR/rj1wRhek38VHMEpxjoc+IDOOjKoOln/T
 W12A==
X-Gm-Message-State: AOJu0YxmJKTuRrdCqFS5Y7OO1HNqSgX18Zm3FXkYejCAeFOKfx7fxi9j
 hfAY6xI5SUYwyDbOTCIO8R7uJnpbRvYcpKBiXw1IRGTiEiOdYMz/e3bZyZmUFPmYSF9rF4eU1Lj
 jk75pbNrCnkNnw/A=
X-Received: by 2002:a05:620a:1922:b0:774:20b7:b88 with SMTP id
 bj34-20020a05620a192200b0077420b70b88mr3364288qkb.0.1698740782223; 
 Tue, 31 Oct 2023 01:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY9z1cDHuKgo6it5Y3aD6QSyd4c+k1ieO5YzK2bHeZC0NjhVCkoUMxcW2PtUCg0nRHyqSspg==
X-Received: by 2002:a05:620a:1922:b0:774:20b7:b88 with SMTP id
 bj34-20020a05620a192200b0077420b70b88mr3364273qkb.0.1698740781938; 
 Tue, 31 Oct 2023 01:26:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a05620a066d00b00767da10efb6sm312453qkh.97.2023.10.31.01.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 01:26:21 -0700 (PDT)
Message-ID: <99e92c9d-2434-432b-90d4-ac7d4436bf10@redhat.com>
Date: Tue, 31 Oct 2023 09:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/37] vfio/container: Move vrdl_list, pgsizes and
 dma_max_mappings to base container
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-15-zhenzhong.duan@intel.com>
 <7603f300-1305-45da-9560-d073bdbc5036@redhat.com>
 <SJ0PR11MB6744DE88DF50BFBACD9D3D6492A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744DE88DF50BFBACD9D3D6492A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/30/23 04:14, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, October 27, 2023 11:52 PM
>> Subject: Re: [PATCH v3 14/37] vfio/container: Move vrdl_list, pgsizes and
>> dma_max_mappings to base container
>>
>> On 10/26/23 12:30, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
> ...
> 
>>>    void vfio_container_destroy(VFIOContainerBase *bcontainer)
>>>    {
>>> +    VFIORamDiscardListener *vrdl, *vrdl_tmp;
>>>        VFIOGuestIOMMU *giommu, *tmp;
>>>
>>>        QLIST_REMOVE(bcontainer, next);
>>>
>>> +    QLIST_FOREACH_SAFE(vrdl, &bcontainer->vrdl_list, next, vrdl_tmp) {
>>> +        RamDiscardManager *rdm;
>>> +
>>> +        rdm = memory_region_get_ram_discard_manager(vrdl->mr);
>>> +        ram_discard_manager_unregister_listener(rdm, &vrdl->listener);
>>> +        QLIST_REMOVE(vrdl, next);
>>> +        g_free(vrdl);
>>> +    }
>>
>> Where was this done previously ?
> 
> Good catch! This should be removed.
> 
>> May be the vrdl list should be handled
>> separatly from pgsizes and dma_max_mappings.
> 
> Good suggestion! Will do.
> 
>>
>>>        QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next,
>> tmp) {
>>>            memory_region_unregister_iommu_notifier(
>>>                    MEMORY_REGION(giommu->iommu_mr), &giommu->n);
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 8d5b408e86..0e265ffa67 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase
>> *bcontainer, hwaddr iova,
>>>            if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>>>                container->iommu_type == VFIO_TYPE1v2_IOMMU) {
>>>                trace_vfio_legacy_dma_unmap_overflow_workaround();
>>> -            unmap.size -= 1ULL << ctz64(container->pgsizes);
>>> +            unmap.size -= 1ULL << ctz64(container->bcontainer.pgsizes);
>>>                continue;
>>>            }
>>>            error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>>> @@ -559,9 +559,7 @@ static int vfio_connect_container(VFIOGroup *group,
>> AddressSpace *as,
>>>        container = g_malloc0(sizeof(*container));
>>>        container->fd = fd;
>>>        container->error = NULL;
>>> -    container->dma_max_mappings = 0;
>>>        container->iova_ranges = NULL;
>>> -    QLIST_INIT(&container->vrdl_list);
>>>        bcontainer = &container->bcontainer;
>>>        vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>>>
>>> @@ -589,13 +587,13 @@ static int vfio_connect_container(VFIOGroup *group,
>> AddressSpace *as,
>>>            }
>>>
>>>            if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
>>> -            container->pgsizes = info->iova_pgsizes;
>>> +            container->bcontainer.pgsizes = info->iova_pgsizes;
>>>            } else {
>>> -            container->pgsizes = qemu_real_host_page_size();
>>> +            container->bcontainer.pgsizes = qemu_real_host_page_size();
>>>            }
>>>
>>> -        if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
>>> -            container->dma_max_mappings = 65535;
>>> +        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
>>> +            container->bcontainer.dma_max_mappings = 65535;
>>>            }
>>>
>>>            vfio_get_info_iova_range(info, container);
>>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>>> index 3495737ab2..dbc4c24052 100644
>>> --- a/hw/vfio/spapr.c
>>> +++ b/hw/vfio/spapr.c
>>> @@ -223,13 +223,13 @@ static int vfio_spapr_create_window(VFIOContainer
>> *container,
>>>        if (pagesize > rampagesize) {
>>>            pagesize = rampagesize;
>>>        }
>>> -    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
>>> +    pgmask = container->bcontainer.pgsizes & (pagesize | (pagesize - 1));
>>>        pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>>>        if (!pagesize) {
>>>            error_report("Host doesn't support page size 0x%"PRIx64
>>>                         ", the supported mask is 0x%lx",
>>>                         memory_region_iommu_get_min_page_size(iommu_mr),
>>> -                     container->pgsizes);
>>> +                     container->bcontainer.pgsizes);
>>>            return -EINVAL;
>>>        }
>>>
>>> @@ -385,7 +385,7 @@ void
>> vfio_container_del_section_window(VFIOContainer *container,
>>>
>>>    bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>>>    {
>>> -
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>>        struct vfio_iommu_spapr_tce_info info;
>>>        bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
>>>        int ret, fd = container->fd;
>>> @@ -424,7 +424,7 @@ bool vfio_spapr_container_init(VFIOContainer
>> *container, Error **errp)
>>>        }
>>>
>>>        if (v2) {
>>> -        container->pgsizes = info.ddw.pgsizes;
>>> +        bcontainer->pgsizes = info.ddw.pgsizes;
>>>            /*
>>>             * There is a default window in just created container.
>>>             * To make region_add/del simpler, we better remove this
>>> @@ -439,7 +439,7 @@ bool vfio_spapr_container_init(VFIOContainer
>> *container, Error **errp)
>>>            }
>>>        } else {
>>>            /* The default table uses 4K pages */
>>> -        container->pgsizes = 0x1000;
>>> +        bcontainer->pgsizes = 0x1000;
>>>            vfio_host_win_add(container, info.dma32_window_start,
>>>                              info.dma32_window_start +
>>>                              info.dma32_window_size - 1,
>>> @@ -455,7 +455,15 @@ listener_unregister_exit:
>>>
>>>    void vfio_spapr_container_deinit(VFIOContainer *container)
>>>    {
>>> +    VFIOHostDMAWindow *hostwin, *next;
>>> +
>>>        if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>>>            memory_listener_unregister(&container->prereg_listener);
>>>        }
>>> +    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
>>> +                       next) {
>>> +        QLIST_REMOVE(hostwin, hostwin_next);
>>> +        g_free(hostwin);
>>> +    }
>>> +
>>>    }
>>
>> I am sure this change  belongs to this patch.
        
"I am not sure" but you read my mind !

> 
> Good catch! Yes, I should move it into below patch.
> "vfio/common: Move vfio_host_win_add/del into spapr.c"

yes.

Thanks,

C.




> 
> Thanks
> Zhenzhong


