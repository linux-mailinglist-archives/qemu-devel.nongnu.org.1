Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083577CA438
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJyr-0003wC-9P; Mon, 16 Oct 2023 05:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsJyp-0003r3-K1
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qsJyn-0001A2-MW
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697448820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKKtOb/qZRC28/rkOpdP0ukylCxqsOEsRb6T3lec3xc=;
 b=GFXZGY2Gs95LHo+XLIyH2v/TbcDO3oHlRPnvQw+xw/Ew27rCUQPBXwSleoDywxNJuZ29/E
 CNbzKpzAtOeFIUekz5CLRSxsO48sA1qFm+XXGVfNtMzTgeIwALQx/o0Yn9Li+y3ahjbAe0
 zIoqbwPulrKSuOwqLNcS47wAjXaEgvc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-KfSMVmzLNmmHIah4xKiNKA-1; Mon, 16 Oct 2023 05:33:38 -0400
X-MC-Unique: KfSMVmzLNmmHIah4xKiNKA-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-49d96b4b823so1225024e0c.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697448818; x=1698053618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKKtOb/qZRC28/rkOpdP0ukylCxqsOEsRb6T3lec3xc=;
 b=ufjGAbFeEJsSXbw3B7FMSypurx13TApExNycZ2euBM7s6IL/rCg/0Pll07lYQpFDXh
 P3trdlaAA9pbanjgjCQjDML8ik4AsFiLxQP5UYjFBvXDe7ijF1cuydMZGQODg/70RNtY
 bHKxKUWRVAhp5WoaPx0iTSMEc/8MxBYmK3eHfvHJERmI3LlqnitykgBxV2jHzueSQrnV
 YBWxg+oSctfnNzaL2pS03kaMp57iCTHUvpq5e5E8oqkIS9qINRneF6dJ7I834Fql5+jN
 wdu85BzEFM6ReWOWneysG4uVWpyj133JPa4qB0Hjj3xi2zhY2o7T/CfSBXJEhP72F/Pa
 SolA==
X-Gm-Message-State: AOJu0Ywxnb1EPDGQinWMyp7j7HSDTDpoMk9inxB8VoDaz2BKWk/ehhtE
 ZsAtx1WR5WWTrcx+7MOhAqH5pKvSglsFZyKiiGZY7KhuRHL2lEBrV+uWCPk9u6KpSG2rYLvEmWy
 fX0YUkY6aRXLA58M=
X-Received: by 2002:a1f:cb42:0:b0:495:cac2:253b with SMTP id
 b63-20020a1fcb42000000b00495cac2253bmr21637346vkg.0.1697448818103; 
 Mon, 16 Oct 2023 02:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBVOyLfB3TuhDnszcYj84TPWWxS3kn4I1Zc5nnlHsL0thnhxM19C0f3I8/EKwVQpx/JHX4bw==
X-Received: by 2002:a1f:cb42:0:b0:495:cac2:253b with SMTP id
 b63-20020a1fcb42000000b00495cac2253bmr21637322vkg.0.1697448817770; 
 Mon, 16 Oct 2023 02:33:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l12-20020ad44bcc000000b00641899958efsm3293827qvw.130.2023.10.16.02.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:33:37 -0700 (PDT)
Message-ID: <40388501-a79c-4abd-96b6-5804cddbed76@redhat.com>
Date: Mon, 16 Oct 2023 11:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>, Liu Yi L <yi.l.liu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20231013145634.224457-1-clg@redhat.com>
 <4aa32a57-97e7-37c5-2873-4699629f4199@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4aa32a57-97e7-37c5-2873-4699629f4199@linaro.org>
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

On 10/16/23 07:03, Philippe Mathieu-Daudé wrote:
> Hi Cédric, Liu, Joao,
> 
> On 13/10/23 16:56, Cédric Le Goater wrote:
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
>>         - included hw/remote/iommu.c   ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>
>>   Hello,
>>
>>   Initially sent by Yi Liu as part of series "intel_iommu: expose
>>   Shared Virtual Addressing to VMs" [1], this patch would also simplify
>>   the changes Joao wants to introduce in "vfio: VFIO migration support
>>   with vIOMMU" [2].
>>
>>   Has anyone objections ?
>>
>>   Thanks,
>>
>>   C.
>>
>>   [1] https://lore.kernel.org/qemu-devel/20210302203827.437645-5-yi.l.liu@intel.com/
>>   [2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>>
>>
>>
>>   include/hw/pci/pci.h     |  8 ++++++--
>>   include/hw/pci/pci_bus.h |  2 +-
>>   hw/alpha/typhoon.c       |  6 +++++-
>>   hw/arm/smmu-common.c     |  6 +++++-
>>   hw/i386/amd_iommu.c      |  6 +++++-
>>   hw/i386/intel_iommu.c    |  6 +++++-
>>   hw/pci-host/designware.c |  6 +++++-
>>   hw/pci-host/dino.c       |  6 +++++-
>>   hw/pci-host/pnv_phb3.c   |  6 +++++-
>>   hw/pci-host/pnv_phb4.c   |  6 +++++-
>>   hw/pci-host/ppce500.c    |  6 +++++-
>>   hw/pci-host/raven.c      |  6 +++++-
>>   hw/pci-host/sabre.c      |  6 +++++-
>>   hw/pci/pci.c             | 18 +++++++++++++-----
>>   hw/ppc/ppc440_pcix.c     |  6 +++++-
>>   hw/ppc/spapr_pci.c       |  6 +++++-
>>   hw/remote/iommu.c        |  6 +++++-
>>   hw/s390x/s390-pci-bus.c  |  8 ++++++--
>>   hw/virtio/virtio-iommu.c |  6 +++++-
>>   19 files changed, 101 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index b70a0b95ff5ae367ed7f98483ec8d1d1b6274530..486e54174b1755995328f2352fd4571d01e107dc 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -366,10 +366,14 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>>   void pci_device_deassert_intx(PCIDevice *dev);
>> -typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>> +typedef struct PCIIOMMUOps PCIIOMMUOps;
> 
> Preferably:
> 
> typedef ...
> 
>> +struct PCIIOMMUOps {

yes.

>         /* documentation ... */
> 
>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>> +                                void *opaque, int32_t devfn);
>> +};
> 
> ... PCIIOMMUOps;
> 
> Should this be PciIommuOps?

I think this is one of the exceptions to the QEMU coding style and
the other PCI types keep a capital PCI, PCIIORegion, PCIINTxRoute,
PCIEAERErr, etc.

Let's be consistent with the existing naming scheme, PCIIOMMUOps.

> Do we need 'int32_t' for devfn or 'int' is enough?

int is enough.

> Would "lookup_address_space" be clearer?

The calling routing is pci_device_iommu_address_space(). Let's keep
get_address_space() for now.

>>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
> 
> Since the prototype is modified, we can take the opportunity to
> document it :)

OK. That would be the first documentation entry in pci.h. I guess it
won't do any harm but will it be collected in the documentation under
"Internal QEMU APIs" ?
  
>> +void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
> 
> Otherwise the change makes sense.


Thanks,

C.


