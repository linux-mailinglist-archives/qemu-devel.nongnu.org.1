Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329B7CF06C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:50:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMrA-00050R-HD; Thu, 19 Oct 2023 02:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtMr6-000506-6F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtMr2-0001V7-M6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697698199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DSHlqNjybqq0wlmGNetuFySlSUr4qOYOqFMMrC4yjaA=;
 b=HGv2SXRFpwfv0yqu4duLYrOMHzyyEyHAjredyqyva6TUC1KX6BOGTHMmCnV+1S4BMoByZi
 P1NlwgmjmT3e+F/JWDu921UJdPcDFaA/oV61SysY1t25NAHKMmDINERImGo4Nr91/8eBqU
 SAUjrt4l6HgPEozfVTyYb3A7I9yJMC4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-mqcZ6-KRMEiNEe93g1FBCQ-1; Thu, 19 Oct 2023 02:49:47 -0400
X-MC-Unique: mqcZ6-KRMEiNEe93g1FBCQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778a20a16e3so13158885a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 23:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697698186; x=1698302986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSHlqNjybqq0wlmGNetuFySlSUr4qOYOqFMMrC4yjaA=;
 b=BhyvhNco6GGsEWQYtKlrQVcJwrUM27++79OFwri77HZiHAlMb4LgrTczNplPXfzwIP
 oBugliylptNcg1UABVfmqaP9GB+P0UWizjYRacjCYzvdEhcXsu/Sjz5sMsW3onGE+f5K
 2xR4BbS5Hw3YJzZYuHcv4mxNxTrhfBfI1F6KPEAj1HuKuUE94b8uQ2EKym0/kUT2EZlT
 TmYNE12XE88mQ7OVRnvSKYUgYHRvAjg4kt3yXttfZsKVLPKEuLRDuacDieOsH7iRhOG4
 bJsvv578l/0foxEOGHzhyx+M7+3TXa+us3XvB65kT8+xvDnw7Kf0R5XazkxGV5hAyeUl
 BJow==
X-Gm-Message-State: AOJu0YxgEeZNurI9sbAel23HZ5M0csqYK7AqJqFjtQuYd85BDXY2pv33
 qdnfG/EzdAkoMm86pHxK3QsdfGKALq1cu+eSF65DoFweJf8B7OmmcHzXTuyYAVAd0d3DSpGYE5s
 RN+CLotx/LoprRXU=
X-Received: by 2002:a05:620a:4d88:b0:777:24f1:5e with SMTP id
 uw8-20020a05620a4d8800b0077724f1005emr1257086qkn.71.1697698186532; 
 Wed, 18 Oct 2023 23:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxu/XY9/FNDpkE//fejnB9KPqXDIlB6Ros4gNnJkomx+TMyn/ljdsawY9nibTOrNUnZRGErw==
X-Received: by 2002:a05:620a:4d88:b0:777:24f1:5e with SMTP id
 uw8-20020a05620a4d8800b0077724f1005emr1257078qkn.71.1697698186137; 
 Wed, 18 Oct 2023 23:49:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ad4424f000000b0066d0ab215b5sm578622qvq.13.2023.10.18.23.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 23:49:45 -0700 (PDT)
Message-ID: <03c19dba-07d3-458e-9a74-b1e99d8dd0b2@redhat.com>
Date: Thu, 19 Oct 2023 08:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Content-Language: en-US
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Liu Yi L <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, David Gibson
 <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231017161404.615145-1-clg@redhat.com>
 <cc5fb80d-6ac5-4d74-e6bd-ba649245560d@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <cc5fb80d-6ac5-4d74-e6bd-ba649245560d@redhat.com>
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

On 10/18/23 15:28, Eric Auger wrote:
> Hi Cédric,
> 
> On 10/17/23 18:14, Cédric Le Goater wrote:
>> From: Liu Yi L <yi.l.liu@intel.com>
>>
>> This patch modifies pci_setup_iommu() to set PCIIOMMUOps
>> instead of setting PCIIOMMUFunc. PCIIOMMUFunc is used to
>> get an address space for a PCI device in vendor specific
>> way. The PCIIOMMUOps still offers this functionality. But
>> using PCIIOMMUOps leaves space to add more iommu related
>> vendor specific operations.
>>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Yi Sun <yi.y.sun@linux.intel.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Cc: Jagannathan Raman <jag.raman@oracle.com>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> [ clg: - refreshed on latest QEMU
>>         - included hw/remote/iommu.c   ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>
>>   Hello,
>>
>>   Initially sent by Yi Liu as part of series "intel_iommu: expose
>>   Shared Virtual Addressing to VMs" [1], this patch would also simplify
>>   the changes Joao wants to introduce in "vfio: VFIO migration support
>>   with vIOMMU" [2].
>>
>>   Has anyone objections ?
>>
>>   Thanks,
>>
>>   C.
>>
>>   [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
>>   [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>>
>>   Changes in v2 :
>>
>>   - PCIIOMMUOps definition cleanups
>>
>>   include/hw/pci/pci.h     |  7 +++++--
>>   include/hw/pci/pci_bus.h |  2 +-
>>   hw/alpha/typhoon.c       |  6 +++++-
>>   hw/arm/smmu-common.c     |  6 +++++-
>>   hw/i386/amd_iommu.c      |  6 +++++-
>>   hw/i386/intel_iommu.c    |  6 +++++-
>>   hw/pci-host/designware.c |  6 +++++-
>>   hw/pci-host/dino.c       |  6 +++++-
>>   hw/pci-host/pnv_phb3.c   |  6 +++++-
>>   hw/pci-host/pnv_phb4.c   |  6 +++++-
>>   hw/pci-host/ppce500.c    |  6 +++++-
>>   hw/pci-host/raven.c      |  6 +++++-
>>   hw/pci-host/sabre.c      |  6 +++++-
>>   hw/pci/pci.c             | 18 +++++++++++++-----
>>   hw/ppc/ppc440_pcix.c     |  6 +++++-
>>   hw/ppc/spapr_pci.c       |  6 +++++-
>>   hw/remote/iommu.c        |  6 +++++-
>>   hw/s390x/s390-pci-bus.c  |  8 ++++++--
>>   hw/virtio/virtio-iommu.c |  6 +++++-
>>   19 files changed, 100 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index b70a0b95ff5ae367ed7f98483ec8d1d1b6274530..59673daef5429a983af74f5b8e0a020a32793df0 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -366,10 +366,13 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>>   
>>   void pci_device_deassert_intx(PCIDevice *dev);
>>   
>> -typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>> +typedef struct PCIIOMMUOps {
>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>> +                                        void *opaque, int devfn);
> I think this should be better documented, something like
> memory.h IOMMUMemoryRegionClass. Also need to document if the callback
> are mandatory or optional.

OK. Let's do that.

>> +} PCIIOMMUOps;
>>   
>>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>> +void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
>>   
>>   pcibus_t pci_bar_address(PCIDevice *d,
>>                            int reg, uint8_t type, pcibus_t size);
>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>> index 56531759578ffe2c6eccc92ebae4acabf47e390d..226131254621f257eefb45356489c125381e6a87 100644
>> --- a/include/hw/pci/pci_bus.h
>> +++ b/include/hw/pci/pci_bus.h
>> @@ -33,7 +33,7 @@ enum PCIBusFlags {
>>   struct PCIBus {
>>       BusState qbus;
>>       enum PCIBusFlags flags;
>> -    PCIIOMMUFunc iommu_fn;
>> +    const PCIIOMMUOps *iommu_ops;
>>       void *iommu_opaque;
>>       uint8_t devfn_min;
>>       uint32_t slot_reserved_mask;
>> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
>> index 49a80550c54d4ed9ee40f9959cbf2c83240d8e39..e8711ae16a3e16c733405034be5e65688ef4d3df 100644
>> --- a/hw/alpha/typhoon.c
>> +++ b/hw/alpha/typhoon.c
>> @@ -738,6 +738,10 @@ static AddressSpace *typhoon_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &s->pchip.iommu_as;
>>   }
>>   
>> +static const PCIIOMMUOps typhoon_iommu_ops = {
>> +    .get_address_space = typhoon_pci_dma_iommu,
>> +};
>> +
>>   static void typhoon_set_irq(void *opaque, int irq, int level)
>>   {
>>       TyphoonState *s = opaque;
>> @@ -897,7 +901,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
>>                                "iommu-typhoon", UINT64_MAX);
>>       address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
>>                          "pchip0-pci");
>> -    pci_setup_iommu(b, typhoon_pci_dma_iommu, s);
>> +    pci_setup_iommu(b, &typhoon_iommu_ops, s);
>>   
>>       /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
>>       memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index f35ae9aa22cb1a62cc16c2534cb3c290862b0799..9a8ac45431abb80fc5e9f60104248cb356509088 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -605,6 +605,10 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>>       return &sdev->as;
>>   }
>>   
>> +static const PCIIOMMUOps smmu_ops = {
>> +    .get_address_space = smmu_find_add_as,
>> +};
>> +
>>   IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
>>   {
>>       uint8_t bus_n, devfn;
>> @@ -661,7 +665,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>>       s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>>   
>>       if (s->primary_bus) {
>> -        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
>> +        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
>>       } else {
>>           error_setg(errp, "SMMU is not attached to any PCI bus!");
>>       }
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 8d0f2f99ddbf49c3df834b6d40d2b23cafbb81ea..94f0f8a7f22130e5684926a8790182376723e58e 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1450,6 +1450,10 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &iommu_as[devfn]->as;
>>   }
>>   
>> +static const PCIIOMMUOps amdvi_iommu_ops = {
>> +    .get_address_space = amdvi_host_dma_iommu,
>> +};
>> +
>>   static const MemoryRegionOps mmio_mem_ops = {
>>       .read = amdvi_mmio_read,
>>       .write = amdvi_mmio_write,
>> @@ -1582,7 +1586,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>   
>>       sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
>> -    pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
>> +    pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>>       amdvi_init(s);
>>   }
>>   
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 2c832ab68b3774dbec6eee4ffe7c13e7a1bf7bcc..87b07a390482160e6db630a2c2c4f6f522e0dc72 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -4034,6 +4034,10 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &vtd_as->as;
>>   }
>>   
>> +static PCIIOMMUOps vtd_iommu_ops = {
>> +    .get_address_space = vtd_host_dma_iommu,
>> +};
>> +
>>   static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>   {
>>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>> @@ -4157,7 +4161,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>>                                         g_free, g_free);
>>       vtd_init(s);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
>> -    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
>> +    pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>>       /* Pseudo address space under root PCI bus. */
>>       x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
>>       qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index 6f5442f108874f6217fa122ac08c1ce27ad20cb9..f477f97847d753341f341281ed2abed2ce242574 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -663,6 +663,10 @@ static AddressSpace *designware_pcie_host_set_iommu(PCIBus *bus, void *opaque,
>>       return &s->pci.address_space;
>>   }
>>   
>> +static const PCIIOMMUOps designware_iommu_ops = {
>> +    .get_address_space = designware_pcie_host_set_iommu,
>> +};
>> +
>>   static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>>   {
>>       PCIHostState *pci = PCI_HOST_BRIDGE(dev);
>> @@ -705,7 +709,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>>       address_space_init(&s->pci.address_space,
>>                          &s->pci.address_space_root,
>>                          "pcie-bus-address-space");
>> -    pci_setup_iommu(pci->bus, designware_pcie_host_set_iommu, s);
>> +    pci_setup_iommu(pci->bus, &designware_iommu_ops, s);
>>   
>>       qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
>>   }
>> diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
>> index 82503229faf8a44b3974b2256b641ce18a77692b..5b0947a16c9ec4abf8668bc4563b1cc181f154f3 100644
>> --- a/hw/pci-host/dino.c
>> +++ b/hw/pci-host/dino.c
>> @@ -354,6 +354,10 @@ static AddressSpace *dino_pcihost_set_iommu(PCIBus *bus, void *opaque,
>>       return &s->bm_as;
>>   }
>>   
>> +static const PCIIOMMUOps dino_iommu_ops = {
>> +    .get_address_space = dino_pcihost_set_iommu,
>> +};
>> +
>>   /*
>>    * Dino interrupts are connected as shown on Page 78, Table 23
>>    * (Little-endian bit numbers)
>> @@ -481,7 +485,7 @@ static void dino_pcihost_init(Object *obj)
>>           g_free(name);
>>       }
>>   
>> -    pci_setup_iommu(phb->bus, dino_pcihost_set_iommu, s);
>> +    pci_setup_iommu(phb->bus, &dino_iommu_ops, s);
>>   
>>       sysbus_init_mmio(sbd, &s->this_mem);
>>   
>> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
>> index c5e58f4086aef34fa0b5307c10b261c0c6e3ac34..2a74dbe45f59b207b57b3b8af8856ac5cf04d114 100644
>> --- a/hw/pci-host/pnv_phb3.c
>> +++ b/hw/pci-host/pnv_phb3.c
>> @@ -968,6 +968,10 @@ static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &ds->dma_as;
>>   }
>>   
>> +static PCIIOMMUOps pnv_phb3_iommu_ops = {
>> +    .get_address_space = pnv_phb3_dma_iommu,
>> +};
>> +
>>   static void pnv_phb3_instance_init(Object *obj)
>>   {
>>       PnvPHB3 *phb = PNV_PHB3(obj);
>> @@ -1012,7 +1016,7 @@ void pnv_phb3_bus_init(DeviceState *dev, PnvPHB3 *phb)
>>       object_property_set_int(OBJECT(pci->bus), "chip-id", phb->chip_id,
>>                               &error_abort);
>>   
>> -    pci_setup_iommu(pci->bus, pnv_phb3_dma_iommu, phb);
>> +    pci_setup_iommu(pci->bus, &pnv_phb3_iommu_ops, phb);
>>   }
>>   
>>   static void pnv_phb3_realize(DeviceState *dev, Error **errp)
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 29cb11a5d94c6a72a8111dd95346be906a7bc4fe..37c7afc18c9b17b25df8356907f0d87d7d621ac2 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -1518,6 +1518,10 @@ static void pnv_phb4_xscom_realize(PnvPHB4 *phb)
>>                               &phb->phb_regs_mr);
>>   }
>>   
>> +static PCIIOMMUOps pnv_phb4_iommu_ops = {
>> +    .get_address_space = pnv_phb4_dma_iommu,
>> +};
>> +
>>   static void pnv_phb4_instance_init(Object *obj)
>>   {
>>       PnvPHB4 *phb = PNV_PHB4(obj);
>> @@ -1557,7 +1561,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
>>       object_property_set_int(OBJECT(pci->bus), "chip-id", phb->chip_id,
>>                               &error_abort);
>>   
>> -    pci_setup_iommu(pci->bus, pnv_phb4_dma_iommu, phb);
>> +    pci_setup_iommu(pci->bus, &pnv_phb4_iommu_ops, phb);
>>       pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
>>   }
>>   
>> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
>> index 38814247f2a5b7c1a6b55e18673f3fe8c348fbee..453a4e6ed3b02ed448c3fad71bd45eb73a5dbbb3 100644
>> --- a/hw/pci-host/ppce500.c
>> +++ b/hw/pci-host/ppce500.c
>> @@ -435,6 +435,10 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *bus, void *opaque,
>>       return &s->bm_as;
>>   }
>>   
>> +static const PCIIOMMUOps ppce500_iommu_ops = {
>> +    .get_address_space = e500_pcihost_set_iommu,
>> +};
>> +
>>   static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>>   {
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> @@ -469,7 +473,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>>       memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
>>       memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>>       address_space_init(&s->bm_as, &s->bm, "pci-bm");
>> -    pci_setup_iommu(b, e500_pcihost_set_iommu, s);
>> +    pci_setup_iommu(b, &ppce500_iommu_ops, s);
>>   
>>       pci_create_simple(b, 0, "e500-host-bridge");
>>   
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index 9a11ac4b2b610646790ed2016f73a16bce4fa42f..86c3a4908712988637484967e88155afb1413742 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -223,6 +223,10 @@ static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
>>       return &s->bm_as;
>>   }
>>   
>> +static const PCIIOMMUOps raven_iommu_ops = {
>> +    .get_address_space = raven_pcihost_set_iommu,
>> +};
>> +
>>   static void raven_change_gpio(void *opaque, int n, int level)
>>   {
>>       PREPPCIState *s = opaque;
>> @@ -320,7 +324,7 @@ static void raven_pcihost_initfn(Object *obj)
>>       memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
>>       memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
>>       address_space_init(&s->bm_as, &s->bm, "raven-bm");
>> -    pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
>> +    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
>>   
>>       h->bus = &s->pci_bus;
>>   
>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>> index dcb2e230b67274d4b87c86eb884e052c26031c27..d0851b48b02237d41f64f6cce6f0aa4740ca0d87 100644
>> --- a/hw/pci-host/sabre.c
>> +++ b/hw/pci-host/sabre.c
>> @@ -112,6 +112,10 @@ static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &is->iommu_as;
>>   }
>>   
>> +static const PCIIOMMUOps sabre_iommu_ops = {
>> +    .get_address_space = sabre_pci_dma_iommu,
>> +};
>> +
>>   static void sabre_config_write(void *opaque, hwaddr addr,
>>                                  uint64_t val, unsigned size)
>>   {
>> @@ -384,7 +388,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>>       /* IOMMU */
>>       memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
>>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
>> -    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
>> +    pci_setup_iommu(phb->bus, &sabre_iommu_ops, s->iommu);
>>   
>>       /* APB secondary busses */
>>       pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b0d21bf43a9da8e624507dad868f0aa775fb2ad6..06e38a4b2e35b6d5737d535078025493f42fefd8 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2685,7 +2685,13 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>       PCIBus *iommu_bus = bus;
>>       uint8_t devfn = dev->devfn;
>>   
>> -    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
>> +    /*
>> +     * get_address_space() callback is mandatory, so needs to ensure its
>> +     * presence in the iommu_bus search.
>> +     */
>> +    while (iommu_bus && (!iommu_bus->iommu_ops ||
>> +           !iommu_bus->iommu_ops->get_address_space) &&
>> +           iommu_bus->parent_dev) {
>>           PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
>>   
>>           /*
>> @@ -2724,15 +2730,17 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>   
>>           iommu_bus = parent_bus;
>>       }
>> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
>> -        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
>> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops &&
>> +                     iommu_bus->iommu_ops->get_address_space) {
>> +        return iommu_bus->iommu_ops->get_address_space(bus,
>> +                                 iommu_bus->iommu_opaque, devfn);
>>       }
>>       return &address_space_memory;
>>   }
>>   
>> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>> +void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>>   {
>> -    bus->iommu_fn = fn;
>> +    bus->iommu_ops = ops;
> As commented on Joao's series, if some cbs are mandatory, why don't we
> enforce it here? This avoids checking if
> iommu_bus->iommu_ops->get_address_space in pci_device_iommu_address_space

yes. We could add an assert on ops->get_address_space I think.

>>       bus->iommu_opaque = opaque;
>>   }
>>   
>> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
>> index 672090de9478e9c8e9ba8151b72bcaf93495d223..df4ee374d04bea092c4f81098f82514c12c0519c 100644
>> --- a/hw/ppc/ppc440_pcix.c
>> +++ b/hw/ppc/ppc440_pcix.c
>> @@ -449,6 +449,10 @@ static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int devfn)
>>       return &s->bm_as;
>>   }
>>   
>> +static const PCIIOMMUOps ppc440_iommu_ops = {
>> +    .get_address_space = ppc440_pcix_set_iommu,
>> +};
>> +
>>   /*
>>    * Some guests on sam460ex write all kinds of garbage here such as
>>    * missing enable bit and low bits set and still expect this to work
>> @@ -503,7 +507,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>>       memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
>>       memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>>       address_space_init(&s->bm_as, &s->bm, "pci-bm");
>> -    pci_setup_iommu(h->bus, ppc440_pcix_set_iommu, s);
>> +    pci_setup_iommu(h->bus, &ppc440_iommu_ops, s);
>>   
>>       memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
>>       memory_region_init_io(&h->conf_mem, OBJECT(s), &ppc440_pcix_host_conf_ops,
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 370c5a90f2184bbe75de9a3b950096960c67189e..a27024e45a4188c5b21e7d41ecf3d337bbbb47f0 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -780,6 +780,10 @@ static AddressSpace *spapr_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &phb->iommu_as;
>>   }
>>   
>> +static const PCIIOMMUOps spapr_iommu_ops = {
>> +    .get_address_space = spapr_pci_dma_iommu,
>> +};
>> +
>>   static char *spapr_phb_vfio_get_loc_code(SpaprPhbState *sphb,  PCIDevice *pdev)
>>   {
>>       g_autofree char *path = NULL;
>> @@ -1978,7 +1982,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>       memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
>>                                   &sphb->msiwindow);
>>   
>> -    pci_setup_iommu(bus, spapr_pci_dma_iommu, sphb);
>> +    pci_setup_iommu(bus, &spapr_iommu_ops, sphb);
>>   
>>       pci_bus_set_route_irq_fn(bus, spapr_route_intx_pin_to_irq);
>>   
>> diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
>> index 1391dd712ceda0bb5b524651362350471f31f93a..7c56aad0fc14a3a411303dcf3baacef5edfd3d1e 100644
>> --- a/hw/remote/iommu.c
>> +++ b/hw/remote/iommu.c
>> @@ -100,6 +100,10 @@ static void remote_iommu_finalize(Object *obj)
>>       iommu->elem_by_devfn = NULL;
>>   }
>>   
>> +static const PCIIOMMUOps remote_iommu_ops = {
>> +    .get_address_space = remote_iommu_find_add_as,
>> +};
>> +
>>   void remote_iommu_setup(PCIBus *pci_bus)
>>   {
>>       RemoteIommu *iommu = NULL;
>> @@ -108,7 +112,7 @@ void remote_iommu_setup(PCIBus *pci_bus)
>>   
>>       iommu = REMOTE_IOMMU(object_new(TYPE_REMOTE_IOMMU));
>>   
>> -    pci_setup_iommu(pci_bus, remote_iommu_find_add_as, iommu);
>> +    pci_setup_iommu(pci_bus, &remote_iommu_ops, iommu);
>>   
>>       object_property_add_child(OBJECT(pci_bus), "remote-iommu", OBJECT(iommu));
>>   
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 2ca36f9f3be11866b6c9cb83a61da01d93a4b7c0..347580ebacfe1dd832063b667aa593097ba6926d 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -652,6 +652,10 @@ static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>       return &iommu->as;
>>   }
>>   
>> +static const PCIIOMMUOps s390_iommu_ops = {
>> +    .get_address_space = s390_pci_dma_iommu,
>> +};
>> +
>>   static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
>>   {
>>       uint8_t expected, actual;
>> @@ -839,7 +843,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>>       b = pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_map_irq,
>>                                 NULL, get_system_memory(), get_system_io(), 0,
>>                                 64, TYPE_PCI_BUS);
>> -    pci_setup_iommu(b, s390_pci_dma_iommu, s);
>> +    pci_setup_iommu(b, &s390_iommu_ops, s);
>>   
>>       bus = BUS(b);
>>       qbus_set_hotplug_handler(bus, OBJECT(dev));
>> @@ -1058,7 +1062,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>   
>>           pdev = PCI_DEVICE(dev);
>>           pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>> -        pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>> +        pci_setup_iommu(&pb->sec_bus, &s390_iommu_ops, s);
>>   
>>           qbus_set_hotplug_handler(BUS(&pb->sec_bus), OBJECT(s));
>>   
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index be51635895ce88cb69ec987a5c7d3fa33a703c9e..4c62378f210a63dcd49e596a56802101bb14f0af 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -444,6 +444,10 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>>       return &sdev->as;
>>   }
>>   
>> +static const PCIIOMMUOps virtio_iommu_ops = {
>> +    .get_address_space = virtio_iommu_find_add_as,
>> +};
>> +
>>   static int virtio_iommu_attach(VirtIOIOMMU *s,
>>                                  struct virtio_iommu_req_attach *req)
>>   {
>> @@ -1206,7 +1210,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>       s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>>   
>>       if (s->primary_bus) {
>> -        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
>> +        pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
>>       } else {
>>           error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
>>       }
> Besides I don't have any objection.

Thanks,

C.


