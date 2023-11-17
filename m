Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7A7EF320
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 13:58:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3yPH-0004hy-FA; Fri, 17 Nov 2023 07:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3yPA-0004hW-NN
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3yP8-0006e9-UW
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700225821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIpQVLYLETa5zLI4IWcrTf5J5kiZ8+x87ML2u5mZ3MU=;
 b=gePAqDKxQxYNblCcnxJ2D4+wv/bdsqob2/gRh/XsAHIjO3syAfWLyD7EZW3AheU7jDutNQ
 SpmQ4FknsE64mB3OKOPx44e0Q0giGf/mwz+R7g9s1FGDUf+LvORSCgZYnhVAtwrTPiaPEl
 iL9DXfJmF5ZkdZEa4cq1lY/Huue0yrw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-heLnRFCaMdS40kMyEKBD0g-1; Fri, 17 Nov 2023 07:56:59 -0500
X-MC-Unique: heLnRFCaMdS40kMyEKBD0g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778a455f975so198928485a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 04:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700225819; x=1700830619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIpQVLYLETa5zLI4IWcrTf5J5kiZ8+x87ML2u5mZ3MU=;
 b=CoIxRXIjeqgmzG5AQbpOFZttoz5k2z1QYnTpnAahkENnmkwJeVW6c+JmeOjLJVyMQc
 iepFiW+bC3Q5EqRPPe9uT+zAyI2K2MvD+dYTndLZ0X9pw7zBQMkfXm3sWLf8d8b/8Mum
 +DUP6YcrLamfmxGH4Yrv2Yl+SlKOMrDgeU4+HHrc/z2Exm/p776iIbvh1NNLqkOL/GDa
 nGcx+0cgumKCBl10b535FXSWM8bomi9dWM18+73GRjETcv2y4NxZwXSubj6MrTjgGe+r
 xcd3W6s/BhGpwnahFYceaMVG999yhfNjtnGrBKgw/7kW105Ju35ORCItt0VVgt1/L0ks
 FutQ==
X-Gm-Message-State: AOJu0Yx0NivUWc8tSr6GLAfKfq8563qvWzsSLkyLM2pAbNu6xNfjrUvg
 2Stg7L1zW3XQkVVkR9qQhk0E+xee3Hm7mqBdU3tm13TNG5rlhR/C4E7WFbu0ci69EXuKEU7yFEH
 5GSTS1VjNv9EG3B4=
X-Received: by 2002:a05:620a:17ac:b0:777:27f9:7e54 with SMTP id
 ay44-20020a05620a17ac00b0077727f97e54mr14892428qkb.50.1700225819329; 
 Fri, 17 Nov 2023 04:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUPCCXgvja5fl8ReElWSz29hpqDhbHT0olpslDAVWtJS95xE7SBjpsicwbZ36F5cpojCcfQw==
X-Received: by 2002:a05:620a:17ac:b0:777:27f9:7e54 with SMTP id
 ay44-20020a05620a17ac00b0077727f97e54mr14892395qkb.50.1700225819082; 
 Fri, 17 Nov 2023 04:56:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 py17-20020a05620a879100b0076f35d17d06sm581860qkn.69.2023.11.17.04.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 04:56:58 -0800 (PST)
Message-ID: <811b1ee6-6f1e-4cca-a503-46c9a87cf851@redhat.com>
Date: Fri, 17 Nov 2023 13:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On 11/17/23 12:39, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, November 17, 2023 7:10 PM
>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>
>> Hello,
>>
>>> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> hwaddr iova,
>>> +                            ram_addr_t size, void *vaddr, bool readonly)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_map map = {
>>> +        .size = sizeof(map),
>>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>>> +        .ioas_id = ioas_id,
>>> +        .__reserved = 0,
>>> +        .user_va = (uintptr_t)vaddr,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    if (!readonly) {
>>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>>> +    }
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
>>> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
>>> +                                  vaddr, readonly, ret);
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +        error_report("IOMMU_IOAS_MAP failed: %m");
>>> +    }
>>> +    return ret;
>>> +}
>>
>> When using a UEFI guest, QEMU reports errors when mapping regions
>> in the top PCI space :
>>
>>    iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000001000
>> size=0x3000 addr=0x7fce2c28b000 readonly=0 (-1)
>>    qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>    qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>> 0x380000001000, 0x3000, 0x7fce2c28b000) = -22 (Invalid argument)
>>
>>    iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000004000
>> size=0x4000 addr=0x7fce2c980000 readonly=0 (-1)
>>    qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>    qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>> 0x380000004000, 0x4000, 0x7fce2c980000) = -22 (Invalid argument)
>>
>> This is because IOMMUFD reserved IOVAs areas are :
>>
>>   [ fee00000 - feefffff ]
>>   [ 8000000000 - ffffffffffffffff ] (39 bits address space)
>>
>> which were allocated when the device was initially attached.
>> The topology is basic. Something is wrong.
> 	
> Thanks for your report. This looks a hardware limit of
> host IOMMU address width(39) < guest physical address width.
>
  > A similar issue with a fix submitted below, ccing related people.
> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02937.html
> It looks the fix will not work for hotplug.
> 
> Or below qemu cmdline may help:
> "-cpu host,host-phys-bits-limit=39"

Not that much. The IOMMU_IOAS_MAP failure becomes a "Bad address".

Thanks,

C.




