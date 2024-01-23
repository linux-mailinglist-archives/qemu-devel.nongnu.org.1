Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BDB838817
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:40:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBOU-0002lr-N7; Tue, 23 Jan 2024 02:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSBOO-0002lj-SR
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 02:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSBOM-0001oO-KF
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 02:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705995617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBhZrFIlXn8mGKkCXpOeQLZAW/9X+ngy77mEtvjSnDg=;
 b=h5SifRV04xVKsiU85tjIqFykMPx3vnsZiVwNGrkdUfKmgHU+rbvnnmDp10Wl3LFe8qs5Kn
 6SWkDLRDUnjt53oQ5kiFPU7mCqO1OQz8s10R7bjOIbXOFyJEMozesSU6HZX/43kXdE0D/W
 LQq4EjWJ4jdgNPR//6H26UIq6L6E708=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-J3QeDGgpO5CYoFjindXZkw-1; Tue, 23 Jan 2024 02:40:15 -0500
X-MC-Unique: J3QeDGgpO5CYoFjindXZkw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-783900615d7so528422285a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 23:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705995612; x=1706600412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBhZrFIlXn8mGKkCXpOeQLZAW/9X+ngy77mEtvjSnDg=;
 b=OL7xQHzaLPDrPNOHJ0NyIq4LCyImYcAyWxzMzHEr/ygx2JpA7Fn4i9KT/9qd2kVj/S
 GUTNdeVBOODG5mMM146GdX6MT3PVuizj1qXxuF4zaFNa/UsDXc+8cm8kNf/7lkY/1m02
 GGnYrIWQEGQY6UQCchFSS//A36IeJYeJRChTdqFo7CZ3mqa/RBP+Tms+C4EgeKAI96bW
 Z84RFpM7qXre1lWK8xdBZ77J/CwUkY4hVDvpLgsSqfuLSw/sLc8KNMZ3L88V+A7KSq8Z
 AYH3rNh/+asl/svKkn9whil6ehlbIIAl5s4ect0LN3FNNUdsP/WqY2Se6r5b4JmxAJJ3
 MpCA==
X-Gm-Message-State: AOJu0YxJd4jRAKMmEtBxrv6NvNHfm1pogPs5EnMSKqwopVFJu8P06bDt
 LPMNqIifS2bZF2jgP4efeGjgn8Qz2R5snWvZR62n+ZWzaoi0EIPwgm6aGw5eHQCqgTjBPmxGUx4
 CdeUuUy3iKgOcRdSLuFqHG0n6ZkIBMt+CmoSYQTBdWVNhlymG5e7j
X-Received: by 2002:a05:620a:14b4:b0:783:3496:967a with SMTP id
 x20-20020a05620a14b400b007833496967amr6577627qkj.43.1705995612712; 
 Mon, 22 Jan 2024 23:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHynbSTUSvFoBjBwwtCUfMbSqlj8+ddsloE8m7iNszQb6z2fRtxwRBs2VTo1PNH1Iiq4daGkA==
X-Received: by 2002:a05:620a:14b4:b0:783:3496:967a with SMTP id
 x20-20020a05620a14b400b007833496967amr6577610qkj.43.1705995612423; 
 Mon, 22 Jan 2024 23:40:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05620a03c100b007815c45cdc5sm2902891qkm.95.2024.01.22.23.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 23:40:12 -0800 (PST)
Message-ID: <1560b289-3389-4027-8c93-4e71b2c6cd77@redhat.com>
Date: Tue, 23 Jan 2024 08:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744075B12BE080F9BBEC37792742@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 1/23/24 07:37, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
>> pci_device_set/unset_iommu_device()
>>
>> On 1/15/24 11:13, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> This adds pci_device_set/unset_iommu_device() to set/unset
>>> IOMMUFDDevice for a given PCIe device. Caller of set
>>> should fail if set operation fails.
>>>
>>> Extract out pci_device_get_iommu_bus_devfn() to facilitate
>>> implementation of pci_device_set/unset_iommu_device().
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/pci/pci.h | 39 ++++++++++++++++++++++++++++++++++-
>>>    hw/pci/pci.c         | 49
>> +++++++++++++++++++++++++++++++++++++++++++-
>>>    2 files changed, 86 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index fa6313aabc..a810c0ec74 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -7,6 +7,8 @@
>>>    /* PCI includes legacy ISA access.  */
>>>    #include "hw/isa/isa.h"
>>>
>>> +#include "sysemu/iommufd_device.h"
>>> +
>>>    extern bool pci_available;
>>>
>>>    /* PCI bus */
>>> @@ -384,10 +386,45 @@ typedef struct PCIIOMMUOps {
>>>         *
>>>         * @devfn: device and function number
>>>         */
>>> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>> devfn);
>>> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>> devfn);
>>> +    /**
>>> +     * @set_iommu_device: set iommufd device for a PCI device to
>> vIOMMU
>>> +     *
>>> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU
>> can't
>>> +     * utilize iommufd specific features.
>>> +     *
>>> +     * Return true if iommufd device is accepted, or else return false with
>>> +     * errp set.
>>> +     *
>>> +     * @bus: the #PCIBus of the PCI device.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * @devfn: device and function number of the PCI device.
>>> +     *
>>> +     * @idev: the data structure representing iommufd device.
>>> +     *
>>> +     */
>>> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int32_t devfn,
>>> +                            IOMMUFDDevice *idev, Error **errp);
>>> +    /**
>>> +     * @unset_iommu_device: unset iommufd device for a PCI device from
>> vIOMMU
>>> +     *
>>> +     * Optional callback.
>>> +     *
>>> +     * @bus: the #PCIBus of the PCI device.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * @devfn: device and function number of the PCI device.
>>> +     */
>>> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int32_t
>> devfn);
>>>    } PCIIOMMUOps;
>>>
>>>    AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice
>> *idev,
>>> +                                Error **errp);
>>> +void pci_device_unset_iommu_device(PCIDevice *dev);
>>>
>>>    /**
>>>     * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 76080af580..3848662f95 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -2672,7 +2672,10 @@ static void
>> pci_device_class_base_init(ObjectClass *klass, void *data)
>>>        }
>>>    }
>>>
>>> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>>> +                                           PCIBus **aliased_pbus,
>>> +                                           PCIBus **piommu_bus,
>>> +                                           uint8_t *aliased_pdevfn)
>>>    {
>>>        PCIBus *bus = pci_get_bus(dev);
>>>        PCIBus *iommu_bus = bus;
>>> @@ -2717,6 +2720,18 @@ AddressSpace
>> *pci_device_iommu_address_space(PCIDevice *dev)
>>>
>>>            iommu_bus = parent_bus;
>>>        }
>>> +    *aliased_pbus = bus;
>>> +    *piommu_bus = iommu_bus;
>>> +    *aliased_pdevfn = devfn;
>>> +}
>>> +
>>> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>> +{
>>> +    PCIBus *bus;
>>> +    PCIBus *iommu_bus;
>>> +    uint8_t devfn;
>>> +
>>> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
>>>        if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
>>>            return iommu_bus->iommu_ops->get_address_space(bus,
>>>                                     iommu_bus->iommu_opaque, devfn);
>>> @@ -2724,6 +2739,38 @@ AddressSpace
>> *pci_device_iommu_address_space(PCIDevice *dev)
>>>        return &address_space_memory;
>>>    }
>>>
>>> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice
>> *idev,
>>> +                                Error **errp)
>>> +{
>>> +    PCIBus *bus;
>>> +    PCIBus *iommu_bus;
>>> +    uint8_t devfn;
>>> +
>>> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
>>> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus &&
>>
>> Why do we test iommu_bus in pci_device_un/set_iommu_device routines
>> and
>> not in pci_device_iommu_address_space() ?
> 
> iommu_bus check in pci_device_iommu_address_space() is dropped in
> below commit, I didn't find related discussion in mail history, maybe
> by accident? I can add it back if it's not intentional.

Can iommu_bus be NULL or should we add an assert ?

C.

> 
> ba7d12eb8c  hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
> 
> Thanks
> Zhenzhong


