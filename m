Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A246C7EF3E6
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 14:57:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zKm-0007Yd-TD; Fri, 17 Nov 2023 08:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3zKj-0007YS-Is
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3zKg-0005am-4g
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700229388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C72q2Tq6iOYYNx3UA+eKwsyf4+fqsKrjtrc1kybbzhA=;
 b=ZPyg1CYWtvgHRg+SobxYl/cxseBMVBeqnGHTeUjn8nBhYsACCsCQSIIT9fNWaComK0RO/S
 SglBgZ5uL7RuT8iQAShbAUWMzneQQfxy6dYZ01PH69iWhhYQl/j5dT30yLpaf0PeGpa9HM
 pFJGVes3c+PGM7jOAMWt11M5lPzb2v8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-U81TUpSON96BEX499LudrQ-1; Fri, 17 Nov 2023 08:56:27 -0500
X-MC-Unique: U81TUpSON96BEX499LudrQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d1e755077so24572466d6.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 05:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700229387; x=1700834187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C72q2Tq6iOYYNx3UA+eKwsyf4+fqsKrjtrc1kybbzhA=;
 b=u8/bkXAgwtQK3jvfb9ErduE1qIlt8eTVYZbgBY3gjvJa6K3xJGTmm0wKPNScBNchnX
 e9KYnZVWpZ+KSLoI0b+Qswtap7tIfZlYkZG7wj2Uo0PxZfEltDDouSWLsSX+p4GOcvHb
 QjG4lABhqhjaFjHgJTh242nFhowGxDH3I+bk1z1cxmwJct0cCs8VUPsXM4Kllo8tQ8gD
 4yos5gDVHM3Li56pHNDmzW2Z/RgVB27WJZXgC2e4RWzMAzhvnDRjlDmwbUKKrF1do2oh
 3awCVdJo/vN2FeF8is2+JuzZGR2D1MElf0Uvb5se770Vr5X5LStCn+wqSmPUHHm8Huad
 bp9A==
X-Gm-Message-State: AOJu0Yy9SgQzCzg7Ru1Cebt6fyC4eadH1JzEzI+JZLFKCuAXKRoZOwFQ
 STJYEohVfCeygxfMAiGSC9k+b5mXY+zSKzAXQ/+iTRWhmXoRmtyMwp2xqVw4Opni80oMtoDGtBX
 1CjmyhNlK6P47FEg=
X-Received: by 2002:a0c:eb4e:0:b0:677:a09a:83bd with SMTP id
 c14-20020a0ceb4e000000b00677a09a83bdmr11941447qvq.19.1700229387146; 
 Fri, 17 Nov 2023 05:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu5/zdtXqrr83X188pMCW/t0/hGnk4xm6NRrFppXOBOxFxjBLCOBXUu5WQvHUlANV+XkvDKQ==
X-Received: by 2002:a0c:eb4e:0:b0:677:a09a:83bd with SMTP id
 c14-20020a0ceb4e000000b00677a09a83bdmr11941414qvq.19.1700229386888; 
 Fri, 17 Nov 2023 05:56:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e13-20020ad450cd000000b006263a9e7c63sm639103qvq.104.2023.11.17.05.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 05:56:26 -0800 (PST)
Message-ID: <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
Date: Fri, 17 Nov 2023 14:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: eric.auger@redhat.com, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
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

On 11/17/23 14:29, Eric Auger wrote:
> Hi Cédric,
> 
> On 11/17/23 12:39, Duan, Zhenzhong wrote:
>> Hi Cédric,
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Friday, November 17, 2023 7:10 PM
>>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>>
>>> Hello,
>>>
>>>> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> hwaddr iova,
>>>> +                            ram_addr_t size, void *vaddr, bool readonly)
>>>> +{
>>>> +    int ret, fd = be->fd;
>>>> +    struct iommu_ioas_map map = {
>>>> +        .size = sizeof(map),
>>>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>>>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>>>> +        .ioas_id = ioas_id,
>>>> +        .__reserved = 0,
>>>> +        .user_va = (uintptr_t)vaddr,
>>>> +        .iova = iova,
>>>> +        .length = size,
>>>> +    };
>>>> +
>>>> +    if (!readonly) {
>>>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>>>> +    }
>>>> +
>>>> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
>>>> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
>>>> +                                  vaddr, readonly, ret);
>>>> +    if (ret) {
>>>> +        ret = -errno;
>>>> +        error_report("IOMMU_IOAS_MAP failed: %m");
>>>> +    }
>>>> +    return ret;
>>>> +}
>>> When using a UEFI guest, QEMU reports errors when mapping regions
>>> in the top PCI space :
>>>
>>>    iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000001000
>>> size=0x3000 addr=0x7fce2c28b000 readonly=0 (-1)
>>>    qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>>    qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>>> 0x380000001000, 0x3000, 0x7fce2c28b000) = -22 (Invalid argument)
>>>
>>>    iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000004000
>>> size=0x4000 addr=0x7fce2c980000 readonly=0 (-1)
>>>    qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>>    qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>>> 0x380000004000, 0x4000, 0x7fce2c980000) = -22 (Invalid argument)
>>>
>>> This is because IOMMUFD reserved IOVAs areas are :
>>>
>>>   [ fee00000 - feefffff ]
>>>   [ 8000000000 - ffffffffffffffff ] (39 bits address space)
>>>
>>> which were allocated when the device was initially attached.
>>> The topology is basic. Something is wrong.
>> 	
>> Thanks for your report. This looks a hardware limit of
>> host IOMMU address width(39) < guest physical address width.
>>
>> A similar issue with a fix submitted below, ccing related people.
>> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02937.html
>> It looks the fix will not work for hotplug.
>>
>> Or below qemu cmdline may help:
>> "-cpu host,host-phys-bits-limit=39"
> 
> don't you have the same issue with legacy VFIO code, you should?

I tend to be lazy and use seabios for guests on the command line.
I do see the error with legacy VFIO and uefi.

However, with the address space size work-around and iommufd, the
error is different, an EFAULT now. Some page pinning issue it seems.

Thanks,

C.


