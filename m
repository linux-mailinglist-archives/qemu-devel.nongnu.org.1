Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6237AFB61
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOO6-00025g-Ky; Wed, 27 Sep 2023 02:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlOO2-00024q-6p
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlONz-0001B4-Q9
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695797462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rdlt1TCpfCt+jo2cf3tu/FqgGzk4RomDYbEkz7pj9SQ=;
 b=OBqjutAsi+MrQM0OAl9lESEypMLHE7uyTKC6rfCA7nmuRo0+Q4zU+LZQOhUgmEW86m88rw
 jOvjlJEsjqG8qqdd4FE5tOKg5zEDDanNgkUNhDNZP6A8zKc0QXy1Cn/2+gYhrd8NrKl2j5
 BlkY0/Vp9mPNlYMcuikXzToE0TAzF8o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-0PQvlDE8N0uWecCMLq_QKQ-1; Wed, 27 Sep 2023 02:51:00 -0400
X-MC-Unique: 0PQvlDE8N0uWecCMLq_QKQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7757523b84aso100518885a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695797460; x=1696402260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rdlt1TCpfCt+jo2cf3tu/FqgGzk4RomDYbEkz7pj9SQ=;
 b=Ky3lMnMsM7sXR+RbSSBL0+t1W9nt8aUnMxK+KOC+1erVDpIU+M1MJOe14yBPGVAtE6
 LA9Wqi/qiPNHd9U+QollpO5U0AD5+NLezukXJu3STzWkJjb3SIs4O787DS3SjFu0IJEb
 40Qf6zbLPSpN2pCP1+DMiNUPCU/rnQLGMQkZXSxmcvipfcuKK50zQyauvBiBoxMZk+iW
 b6+n7z6bWKy/0wwpcseGHjZo026+QoIDIqNgOT9mPakraLbQkBb7nY9n5R9M8Kj5BtAb
 WX5OQl3+RahIme+0xcLu9dd8810WYr0Z+X9+sgVNb+Fb9Z9TL94V6evmpmXwaWDhMXNo
 oG8Q==
X-Gm-Message-State: AOJu0YwsgkZ9O4+qmSrEu3uQgxRtUAqb8I+xiv2OerAhysyIWXIXc8ji
 SGwvMi0C7fOPMV/L1rw47ADl6YdcJ9oV8RtxiuWygqNgomjRP5hgntTd6AUYl50T0TiyBM8m2y7
 Rt2hVCO0UUwaTayQ=
X-Received: by 2002:a05:620a:28c3:b0:773:d66f:9cb2 with SMTP id
 l3-20020a05620a28c300b00773d66f9cb2mr1237738qkp.31.1695797459983; 
 Tue, 26 Sep 2023 23:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvgwMlXQ2xgpKGFZS6CwjeP+0/KRxEZTn9TZiRyMjZdqWDV2zwf6nwMcMhUrqj9gUZGsjn9A==
X-Received: by 2002:a05:620a:28c3:b0:773:d66f:9cb2 with SMTP id
 l3-20020a05620a28c300b00773d66f9cb2mr1237726qkp.31.1695797459723; 
 Tue, 26 Sep 2023 23:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05620a110500b0076f058f5834sm3140794qkk.61.2023.09.26.23.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 23:50:59 -0700 (PDT)
Message-ID: <74180354-cf74-f140-43c6-bb424b9704db@redhat.com>
Date: Wed, 27 Sep 2023 08:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
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
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
 <facf584a-e8bf-5386-8660-ac7dd3e6dde8@redhat.com>
 <SJ0PR11MB6744CFE4E7D6AB400FD8BE6D92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <PH7PR11MB6722E273E32EE622608E863692C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <PH7PR11MB6722E273E32EE622608E863692C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/27/23 04:08, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Duan, Zhenzhong
>> Sent: Thursday, September 21, 2023 6:14 PM
>> Subject: RE: [PATCH v1 04/22] vfio/common: Introduce
>> vfio_container_add|del_section_window()
>>
>> Hi Cédric,
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Thursday, September 21, 2023 4:29 PM
>>> Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
>>> vfio_container_add|del_section_window()
>>>
>>> Hello Zhenzhong,
>>>
>>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> Introduce helper functions that isolate the code used for
>>>> VFIO_SPAPR_TCE_v2_IOMMU. This code reliance is IOMMU backend
>>>> specific whereas the rest of the code in the callers, ie.
>>>> vfio_listener_region_add|del is not.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
>>>>    1 file changed, 89 insertions(+), 67 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 9ca695837f..67150e4575 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -796,6 +796,92 @@ static bool
>>> vfio_get_section_iova_range(VFIOContainer *container,
>>>>        return true;
>>>>    }
>>>>
>>>> +static int vfio_container_add_section_window(VFIOContainer *container,
>>>> +                                             MemoryRegionSection *section,
>>>> +                                             Error **errp)
>>>> +{
>>>> +    VFIOHostDMAWindow *hostwin;
>>>> +    hwaddr pgsize = 0;
>>>> +    int ret;
>>>> +
>>>> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
>>>> +        return 0;
>>>> +    }
>>>
>>> This test makes me think that we should register a specific backend
>>> for the pseries machines, implementing the add/del_window handler,
>>> since others do not need it. Correct ?
>>
>> Yes, introducing a specific backend could help removing above check.
>> But each backend has a VFIOIOMMUBackendOps, we need same check
>> as above to select Ops.
>>
>>>
>>> It would avoid this ugly test. Let's keep that in mind when the
>>> backends are introduced.
>>>
>>>> +
>>>> +    /* For now intersections are not allowed, we may relax this later */
>>>> +    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
>>>> +        if (ranges_overlap(hostwin->min_iova,
>>>> +                           hostwin->max_iova - hostwin->min_iova + 1,
>>>> +                           section->offset_within_address_space,
>>>> +                           int128_get64(section->size))) {
>>>> +            error_setg(errp,
>>>> +                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
>>>> +                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
>>>> +                section->offset_within_address_space,
>>>> +                section->offset_within_address_space +
>>>> +                    int128_get64(section->size) - 1,
>>>> +                hostwin->min_iova, hostwin->max_iova);
>>>> +            return -EINVAL;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    ret = vfio_spapr_create_window(container, section, &pgsize);
>>>> +    if (ret) {
>>>> +        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    vfio_host_win_add(container, section->offset_within_address_space,
>>>> +                      section->offset_within_address_space +
>>>> +                      int128_get64(section->size) - 1, pgsize);
>>>> +#ifdef CONFIG_KVM
>>>
>>> the ifdef test doesn't seem useful because the compiler should compile
>>> out the section below since, in that case, kvm_enabled() is defined as :
>>>
>>>    #define kvm_enabled()           (0)
>>
>> Looks so, I'll remove it in v2.
> 
> Forgot to let you know, finally I failed to remove the ifdef test in v2 due to
> many "undeclared" compile errors. I guess the reason is grammatical check
> Is triggered before optimization in compiler.
> 
> For example:
> error: ‘KVM_DEV_VFIO_GROUP’ undeclared
> error: ‘vfio_kvm_device_fd’ undeclared


Yes. It would need helpers to hide the kernel structs and defined.
Let's address it later, after the backends are introduced.

Thanks for looking into it.

C.


