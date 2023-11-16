Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28417EDBF7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WoI-0006jp-Td; Thu, 16 Nov 2023 02:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3WoG-0006jh-J5
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3WoF-00069P-2f
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700119746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqacinZiFLm9qfoifjFpSjjWRIgfRKYuyaP5fQWfAPE=;
 b=EMSyig8hKGcTmI2RDkkY3BjwN+ucZ9xcdEusMBrdyRbVoBpat7ZQb11xn2ett0NILTZ79O
 MYnaM16azDUx8kbmldmVnIupXoLS4d43xvkGWaEkltFlNzWOY+V3my4b4I93aObF+1OcXZ
 85JYXd/AMx8RMyLmI4UWhabU0Hd5JTI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-vrMZUtaHMK28LviDCBB5MQ-1; Thu, 16 Nov 2023 02:29:04 -0500
X-MC-Unique: vrMZUtaHMK28LviDCBB5MQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778ac2308e6so61875485a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119744; x=1700724544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LqacinZiFLm9qfoifjFpSjjWRIgfRKYuyaP5fQWfAPE=;
 b=CY1B/gFwgVEf8x6jj99cybJ5hJ97/NlftqwFyLlT8T20ec+gZq9/JT8fnaM46l/AXG
 74YYvO2dmZBi97tCea/dxJLWZQJGNQ4Dme3rJIjs/bGPZfdGRqmzbSvJS3eKUkexFYEE
 N7jFKoqPAXRmMdau5RJVPlRNx+XIjUCa9MFMYfac3gqJBUn6BXrubfnJoZQJCfa+wetN
 v7fLc32ftTmV9H2fuSGj5PJ1EgmGOngm2JbDdO7F1xhWIBtjU4e4qFHNhI6iT2kcRv5L
 WXPfBYxcwZc2O+t00BN/0d2BiTiQpuP/uwyAYOTVHUQLUMu2kfY8ijUQ9bxT5zxb0+38
 QUZQ==
X-Gm-Message-State: AOJu0Yydotr93CnctEwMmAUNf8GF6GrCK2xXrSovLmwaGOAHKy5bL+0+
 RD3Aly56RNCwuOYlbNq11JT4bfSVn/8KtBQ6m+wMMfkg8VXLm5Etlze4x8C1LsWge+ZxQd9iaM5
 F6yCjHNzevQ7JcEVhuagP5Cs=
X-Received: by 2002:a05:620a:4145:b0:777:29d8:5dc2 with SMTP id
 k5-20020a05620a414500b0077729d85dc2mr9889499qko.66.1700119743859; 
 Wed, 15 Nov 2023 23:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGORJlKflA2nFp9anO4yJC1hmbfV4wbM1IaexMIQY+vYN3i1xtgB9q8e8SeDpWrtiR/pJkmig==
X-Received: by 2002:a05:620a:4145:b0:777:29d8:5dc2 with SMTP id
 k5-20020a05620a414500b0077729d85dc2mr9889484qko.66.1700119743678; 
 Wed, 15 Nov 2023 23:29:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05620a101600b007671b599cf5sm4076620qkj.40.2023.11.15.23.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:29:03 -0800 (PST)
Message-ID: <2da90861-3f10-47cf-9f6e-39d52b8c929f@redhat.com>
Date: Thu, 16 Nov 2023 08:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
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
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
 <20231115083218.1973627-2-zhenzhong.duan@intel.com>
 <fcf2c5ec-ca54-45c4-b6a6-4f302a6cddf7@redhat.com>
 <SJ0PR11MB6744ED3C5F3F828BECBDC6FD92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744ED3C5F3F828BECBDC6FD92B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/16/23 03:16, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, November 15, 2023 9:12 PM
>> Subject: Re: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
>> vfio_instance_init
>>
>> On 11/15/23 09:32, Zhenzhong Duan wrote:
>>> Some of the VFIODevice initializations is in vfio_realize,
>>> move all of them in vfio_instance_init.
>>>
>>> No functional change intended.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/vfio/pci.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index b23b492cce..5a2b7a2d6b 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2969,9 +2969,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>        if (vfio_device_get_name(vbasedev, errp)) {
>>>            return;
>>>        }
>>> -    vbasedev->ops = &vfio_pci_ops;
>>> -    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>> -    vbasedev->dev = DEVICE(vdev);
>>>
>>>        /*
>>>         * Mediated devices *might* operate compatibly with discarding of RAM,
>> but
>>> @@ -3320,6 +3317,7 @@ static void vfio_instance_init(Object *obj)
>>>    {
>>>        PCIDevice *pci_dev = PCI_DEVICE(obj);
>>>        VFIOPCIDevice *vdev = VFIO_PCI(obj);
>>> +    VFIODevice *vbasedev = &vdev->vbasedev;
>>>
>>>        device_add_bootindex_property(obj, &vdev->bootindex,
>>>                                      "bootindex", NULL,
>>> @@ -3328,7 +3326,11 @@ static void vfio_instance_init(Object *obj)
>>>        vdev->host.bus = ~0U;
>>>        vdev->host.slot = ~0U;
>>>        vdev->host.function = ~0U;
>>> -    vdev->vbasedev.fd = -1;
>>> +
>>> +    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>> +    vbasedev->ops = &vfio_pci_ops;
>>> +    vbasedev->dev = DEVICE(vdev);
>>> +    vbasedev->fd = -1;
>>
>> VFIODevice is similar to a base QOM parent. Could we introduce an helper
>> routine like we did with vfio_device_set_fd() ?
> 
> Sure, will do.

Since this series is reviewed, could you please consolidate with an extra
patch on top of this v1 ?

Thanks,

C.


