Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E17838B97
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDrv-0007jU-B5; Tue, 23 Jan 2024 05:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSDrs-0007j0-Le
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSDrq-0003lm-Mw
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706005134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovRoMyuUq2L5WZswyWnurEbHT4jbM2kY33ALyDs3T7I=;
 b=WWeKPQ0lNTAopD9AU5FcIn4vS2SWkpcnFtCkMAKBjoYy9QEfjVMS7yLOycLYF4WZPacIKq
 A9jwMLRMRZkPfCb+kzg4sgOn2lixjJsOeSR2Ed++AENwYz4+Kxw0vywv6CE+4zFpChx4gA
 W48T+6POKSAgYGmdXnPHXl9aZpbpHHE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-wkwc7fNfNjeDZUEJDbfXIw-1; Tue, 23 Jan 2024 05:18:52 -0500
X-MC-Unique: wkwc7fNfNjeDZUEJDbfXIw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78377692045so513745085a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005127; x=1706609927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovRoMyuUq2L5WZswyWnurEbHT4jbM2kY33ALyDs3T7I=;
 b=mRINlFaZ2+FnQh4uCzJclBe3wF1DhqVCzKuvdA7qUOtSILTtChay4vP4fhrNaHx3t6
 RF0EtzVF8OKhI+MTTCm+FchnIORfvfevjAnnp1qz+moxlxxG+/KpJ4fJdt58rettKihk
 5i6V4HBjFOs4gV20xF6AxgMIDET/bDmTbjj8SwZZDOj5Y0/NcPMwMhlwOVgOReAZ9m26
 1wtQrt+o8hY8iyRInwTzKmtmXCHZN8Ktcoq5IBdTVZ0GEdyhW8ljj+oS3sOL17haa+2s
 dlL7821t+bOHwr1LFX+Ju6HFMIbEsJnSDCVMrRdyKsNFd9ihppCeiC8CVsNYno1RLR+Z
 ygFA==
X-Gm-Message-State: AOJu0Ywo8fPh7kiLGpQI5OuFSagUEodZcbWWBQxkPXnl0CfN6Exq7GrV
 zhC5Vr+EEkbSP3VQ4EZgFsvqDSKLu9Jjd45kSWST1mKqjq2boNkswWyamIAViYqWaXgGxLkeOxU
 ulScKLXScgzTp6xj/dIcn5kqub3m/YUrE+zPlKoQPAtPwtmmbq7WJ
X-Received: by 2002:a05:620a:15ac:b0:783:5baf:a9b7 with SMTP id
 f12-20020a05620a15ac00b007835bafa9b7mr6007289qkk.148.1706005127097; 
 Tue, 23 Jan 2024 02:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg1/+pKAmbcrUNMfIgdczFL0WSuAeaF+axCnPR0l5XedZELLOSIggQfVmY2luk4C+R2tdBOw==
X-Received: by 2002:a05:620a:15ac:b0:783:5baf:a9b7 with SMTP id
 f12-20020a05620a15ac00b007835bafa9b7mr6007275qkk.148.1706005126762; 
 Tue, 23 Jan 2024 02:18:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a05620a084100b007834318c7absm3003345qku.79.2024.01.23.02.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 02:18:44 -0800 (PST)
Message-ID: <39a50e45-73e8-4f17-871b-336dc2fdc35f@redhat.com>
Date: Tue, 23 Jan 2024 11:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
 <f2ca6b36-922c-42e4-98d6-59616099980a@redhat.com>
 <SJ0PR11MB6744075B12BE080F9BBEC37792742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1560b289-3389-4027-8c93-4e71b2c6cd77@redhat.com>
 <SJ0PR11MB6744254204FF8E9D3E1169C892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744254204FF8E9D3E1169C892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 1/23/24 10:25, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
>> pci_device_set/unset_iommu_device()
>>
>> On 1/23/24 07:37, Duan, Zhenzhong wrote:
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
>>>> pci_device_set/unset_iommu_device()
>>>>
>>>> On 1/15/24 11:13, Zhenzhong Duan wrote:
>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>
>>>>> This adds pci_device_set/unset_iommu_device() to set/unset
>>>>> IOMMUFDDevice for a given PCIe device. Caller of set
>>>>> should fail if set operation fails.
>>>>>
>>>>> Extract out pci_device_get_iommu_bus_devfn() to facilitate
>>>>> implementation of pci_device_set/unset_iommu_device().
>>>>>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>    include/hw/pci/pci.h | 39
>> ++++++++++++++++++++++++++++++++++-
>>>>>    hw/pci/pci.c         | 49
>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>>    2 files changed, 86 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>>>> index fa6313aabc..a810c0ec74 100644
>>>>> --- a/include/hw/pci/pci.h
>>>>> +++ b/include/hw/pci/pci.h
>>>>> @@ -7,6 +7,8 @@
>>>>>    /* PCI includes legacy ISA access.  */
>>>>>    #include "hw/isa/isa.h"
>>>>>
>>>>> +#include "sysemu/iommufd_device.h"
>>>>> +
>>>>>    extern bool pci_available;
>>>>>
>>>>>    /* PCI bus */
>>>>> @@ -384,10 +386,45 @@ typedef struct PCIIOMMUOps {
>>>>>         *
>>>>>         * @devfn: device and function number
>>>>>         */
>>>>> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>>>> devfn);
>>>>> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque,
>> int
>>>> devfn);
>>>>> +    /**
>>>>> +     * @set_iommu_device: set iommufd device for a PCI device to
>>>> vIOMMU
>>>>> +     *
>>>>> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU
>>>> can't
>>>>> +     * utilize iommufd specific features.
>>>>> +     *
>>>>> +     * Return true if iommufd device is accepted, or else return false with
>>>>> +     * errp set.
>>>>> +     *
>>>>> +     * @bus: the #PCIBus of the PCI device.
>>>>> +     *
>>>>> +     * @opaque: the data passed to pci_setup_iommu().
>>>>> +     *
>>>>> +     * @devfn: device and function number of the PCI device.
>>>>> +     *
>>>>> +     * @idev: the data structure representing iommufd device.
>>>>> +     *
>>>>> +     */
>>>>> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int32_t devfn,
>>>>> +                            IOMMUFDDevice *idev, Error **errp);
>>>>> +    /**
>>>>> +     * @unset_iommu_device: unset iommufd device for a PCI device
>> from
>>>> vIOMMU
>>>>> +     *
>>>>> +     * Optional callback.
>>>>> +     *
>>>>> +     * @bus: the #PCIBus of the PCI device.
>>>>> +     *
>>>>> +     * @opaque: the data passed to pci_setup_iommu().
>>>>> +     *
>>>>> +     * @devfn: device and function number of the PCI device.
>>>>> +     */
>>>>> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int32_t
>>>> devfn);
>>>>>    } PCIIOMMUOps;
>>>>>
>>>>>    AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>>>> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice
>>>> *idev,
>>>>> +                                Error **errp);
>>>>> +void pci_device_unset_iommu_device(PCIDevice *dev);
>>>>>
>>>>>    /**
>>>>>     * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index 76080af580..3848662f95 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -2672,7 +2672,10 @@ static void
>>>> pci_device_class_base_init(ObjectClass *klass, void *data)
>>>>>        }
>>>>>    }
>>>>>
>>>>> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>>>> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>>>>> +                                           PCIBus **aliased_pbus,
>>>>> +                                           PCIBus **piommu_bus,
>>>>> +                                           uint8_t *aliased_pdevfn)
>>>>>    {
>>>>>        PCIBus *bus = pci_get_bus(dev);
>>>>>        PCIBus *iommu_bus = bus;
>>>>> @@ -2717,6 +2720,18 @@ AddressSpace
>>>> *pci_device_iommu_address_space(PCIDevice *dev)
>>>>>            iommu_bus = parent_bus;
>>>>>        }
>>>>> +    *aliased_pbus = bus;
>>>>> +    *piommu_bus = iommu_bus;
>>>>> +    *aliased_pdevfn = devfn;
>>>>> +}
>>>>> +
>>>>> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>>>> +{
>>>>> +    PCIBus *bus;
>>>>> +    PCIBus *iommu_bus;
>>>>> +    uint8_t devfn;
>>>>> +
>>>>> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus,
>> &devfn);
>>>>>        if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
>>>>>            return iommu_bus->iommu_ops->get_address_space(bus,
>>>>>                                     iommu_bus->iommu_opaque, devfn);
>>>>> @@ -2724,6 +2739,38 @@ AddressSpace
>>>> *pci_device_iommu_address_space(PCIDevice *dev)
>>>>>        return &address_space_memory;
>>>>>    }
>>>>>
>>>>> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice
>>>> *idev,
>>>>> +                                Error **errp)
>>>>> +{
>>>>> +    PCIBus *bus;
>>>>> +    PCIBus *iommu_bus;
>>>>> +    uint8_t devfn;
>>>>> +
>>>>> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus,
>> &devfn);
>>>>> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus &&
>>>> Why do we test iommu_bus in pci_device_un/set_iommu_device
>> routines
>>>> and
>>>> not in pci_device_iommu_address_space() ?
>>> iommu_bus check in pci_device_iommu_address_space() is dropped in
>>> below commit, I didn't find related discussion in mail history, maybe
>>> by accident? I can add it back if it's not intentional.
>> Can iommu_bus be NULL or should we add an assert ?
> I dig into the history changes of pci_device_iommu_address_space() and
> below commit added iommu_bus check.
>
> 5af2ae230514  pci: Fix pci_device_iommu_address_space() bus propagation
>
> In theory, !iommu_bus->parent_dev take precedency over !iommu_bus,
> So we never see iommu_bus NULL, assert may be better.

I think we had such a discussion in
https://www.mail-archive.com/qemu-devel@nongnu.org/msg994766.html
But maybe this was related to a different call place. I remember I
challenged the check at some point

Eric
>
> Thanks
> Zhenzhong
>


