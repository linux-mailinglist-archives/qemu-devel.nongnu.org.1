Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D27E3FB4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lob-00065a-B9; Tue, 07 Nov 2023 08:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0LoG-0005rP-LA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0Lo1-0006tI-TW
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699362463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2Twqho3sxvZ/01Wmu7D8pviyCgd2tuHm73HPyMYW3E=;
 b=Y0lGfnZZlngpL0lrIvGAgvtmcXVu7XO6aLuqks/j1FbA4z0cBtrupi9xg4V2Dsj5dj9dWv
 2wnV/OPxsWjDmdhNAE62o10eTzeyMzn7J+KrxZIA36CMbjkWW1GxK9kAs04g1F0xc71b4X
 IRrsHmBFDFOr/6WQ08A4oTQXdutLNaQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-YGDr1eSzOcCMnD3mEtAjZQ-1; Tue, 07 Nov 2023 08:07:42 -0500
X-MC-Unique: YGDr1eSzOcCMnD3mEtAjZQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-670b675b2c5so69629706d6.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362461; x=1699967261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2Twqho3sxvZ/01Wmu7D8pviyCgd2tuHm73HPyMYW3E=;
 b=Z0q+ubqXDN50VfbHJjJLE00EAfFPVqJUV6dkpSvdkUx4h6g0dmcvPmxq84n41D9S49
 3YW2Smk7TRuoFnmOpk6dbjlwN0C+qyrcYoxugrj8GFdCNeytKYASzlSeaPOAuZeX+9Tr
 md6DwPM2a6m8mTCAdp9BYMy0lOh/HclaWLkgwQKlOynXZYzsGBpz8PZXsna17tiM23YO
 jgKGAyhf1BCM//AEQeU4crAfEKvC9vr34JjEtVPEV4H8me86fD/kXHJUKZZvKhJzVS1S
 npaKYOR/GbtSDtZghKF762bGONieZTSBdxbClds5kXKUQNuSs2E0koEjEmSp4oDrelpB
 xx7g==
X-Gm-Message-State: AOJu0YwApAAe3af2pGbYdZemfEROKb//T+Cfel2ABj58APO+aPbpUSKi
 /ZxSuOUcXUpkVbLtS8ARhl8BiLTwd7cbVWkTV0M8cbKytKuLo6EB8WAipqnGRsoLmD4pPOAjy0i
 eBQN7sCukLZJAUFA=
X-Received: by 2002:ad4:5c4a:0:b0:66d:627e:24c0 with SMTP id
 a10-20020ad45c4a000000b0066d627e24c0mr45458146qva.38.1699362461410; 
 Tue, 07 Nov 2023 05:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJnZwJHsFV8JPQfhM0PPBdHwxV8kUN7wJLFnug72g38tD8qrBKiY05C61v1e1wJFT3HgLZYQ==
X-Received: by 2002:ad4:5c4a:0:b0:66d:627e:24c0 with SMTP id
 a10-20020ad45c4a000000b0066d627e24c0mr45458125qva.38.1699362461162; 
 Tue, 07 Nov 2023 05:07:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 kg9-20020a05622a760900b0041812703b7esm4332459qtb.52.2023.11.07.05.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:07:40 -0800 (PST)
Message-ID: <12e06515-b88f-463d-9db1-e76686927062@redhat.com>
Date: Tue, 7 Nov 2023 14:07:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
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
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-23-zhenzhong.duan@intel.com>
 <42508355-9891-4d20-96fe-c470bc7d9747@redhat.com>
 <SJ0PR11MB67440CDA57F75F3BAB9A60F792A9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67440CDA57F75F3BAB9A60F792A9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/7/23 04:06, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, November 7, 2023 1:33 AM
>> Subject: Re: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
>> add/del_section_window
>>
>> On 11/2/23 08:12, Zhenzhong Duan wrote:
>>> No fucntional change intended.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h         |  5 -----
>>>    include/hw/vfio/vfio-container-base.h |  5 +++++
>>>    hw/vfio/common.c                      |  8 ++------
>>>    hw/vfio/container-base.c              | 21 +++++++++++++++++++++
>>>    hw/vfio/spapr.c                       | 19 ++++++++++++++-----
>>>    5 files changed, 42 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b9e5a0e64b..055f679363 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -169,11 +169,6 @@ VFIOAddressSpace
>> *vfio_get_address_space(AddressSpace *as);
>>>    void vfio_put_address_space(VFIOAddressSpace *space);
>>>
>>>    /* SPAPR specific */
>>> -int vfio_container_add_section_window(VFIOContainer *container,
>>> -                                      MemoryRegionSection *section,
>>> -                                      Error **errp);
>>> -void vfio_container_del_section_window(VFIOContainer *container,
>>> -                                       MemoryRegionSection *section);
>>>    int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
>>>    void vfio_spapr_container_deinit(VFIOContainer *container);
>>>
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> index f62a14ac73..4b6f017c6f 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -75,6 +75,11 @@ int vfio_container_dma_map(VFIOContainerBase
>> *bcontainer,
>>>    int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>>>                                 hwaddr iova, ram_addr_t size,
>>>                                 IOMMUTLBEntry *iotlb);
>>> +int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>> +                                      MemoryRegionSection *section,
>>> +                                      Error **errp);
>>> +void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>> +                                       MemoryRegionSection *section);
>>>    int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>>                                               bool start);
>>>    int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 483ba82089..572ae7c934 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -571,8 +571,6 @@ static void vfio_listener_region_add(MemoryListener
>> *listener,
>>>    {
>>>        VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>>                                                     listener);
>>> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>> -                                            bcontainer);
>>>        hwaddr iova, end;
>>>        Int128 llend, llsize;
>>>        void *vaddr;
>>> @@ -595,7 +593,7 @@ static void vfio_listener_region_add(MemoryListener
>> *listener,
>>>            return;
>>>        }
>>>
>>> -    if (vfio_container_add_section_window(container, section, &err)) {
>>> +    if (vfio_container_add_section_window(bcontainer, section, &err)) {
>>>            goto fail;
>>>        }
>>>
>>> @@ -738,8 +736,6 @@ static void vfio_listener_region_del(MemoryListener
>> *listener,
>>>    {
>>>        VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>>                                                     listener);
>>> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>> -                                            bcontainer);
>>>        hwaddr iova, end;
>>>        Int128 llend, llsize;
>>>        int ret;
>>> @@ -818,7 +814,7 @@ static void vfio_listener_region_del(MemoryListener
>> *listener,
>>>
>>>        memory_region_unref(section->mr);
>>>
>>> -    vfio_container_del_section_window(container, section);
>>> +    vfio_container_del_section_window(bcontainer, section);
>>>    }
>>>
>>>    typedef struct VFIODirtyRanges {
>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>> index 0177f43741..71f7274973 100644
>>> --- a/hw/vfio/container-base.c
>>> +++ b/hw/vfio/container-base.c
>>> @@ -31,6 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase
>> *bcontainer,
>>>        return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>>>    }
>>>
>>> +int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>> +                                      MemoryRegionSection *section,
>>> +                                      Error **errp)
>>> +{
>>> +    if (!bcontainer->ops->add_window) {
>>> +        return 0;
>>> +    }
>>
>> These should an assert right ? because only called on the pseries
>> platform which defines the handlers.
> 
> Because we use a unified vfio_memory_listener for legacy, spapr and iommufd
> backend, so we need the check for legacy and iommufd backend.
> 
> Another choice is to introduce separate region_add/del callbacks for spapr,
> then we can add assert. But that way we will have redundant code.

Yeah. I thought so. I will take a look. I have more comments to come.

Thanks,

C.



