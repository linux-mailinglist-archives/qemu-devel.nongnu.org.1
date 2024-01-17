Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C518307AA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:12:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6dm-0001pM-AN; Wed, 17 Jan 2024 09:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ6dl-0001p1-3q
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ6dj-0002bq-38
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705500694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXkqhN/Bkcvj3f8GcZ+oOJmiL4zISqABhTpgLq3waZQ=;
 b=FEL42bGQ9dk86kAf74zLF35Xv+0t6E/S29I5BSZ4N3J1FiFCSTdjawm3FrBFSHLTVvijJJ
 1TWmCwewDtDxL7aL3n/PIwz34Mk2UZG66KZOf0qyANXq5c9l57l/BwD1xO47MUHz5B3s5J
 ZSvv/NJAHP8MbMnw/hUnMbhYxOBh7EM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416--zJyzWyEMBOMYokVGM1xPQ-1; Wed, 17 Jan 2024 09:11:33 -0500
X-MC-Unique: -zJyzWyEMBOMYokVGM1xPQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68153fe8af1so89938006d6.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500687; x=1706105487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXkqhN/Bkcvj3f8GcZ+oOJmiL4zISqABhTpgLq3waZQ=;
 b=voUgweBD6a2gy8yKwZT9pz53fBZOMMcRSA++q0toWJNBQ4d4X07MIo8ya770RQCpDQ
 gPZkvBuRrRRW/K8XdGgygBmUyKF54fqYVCt2ojWKpvlXNTT145PSrEonyqwlmSqc5qPn
 ZWqkrznf8AspQVssWcgcLXvKEkcEpEUGwA+mzoa4FNAeYRunBCTOvpEEV82Lu2UAuSG3
 hXQbX8mmwhLkyvvIyxfj2/OnQyPuZOI1ClikhlW2/FY+DYP4EgGeHNhcSaCLnCw4XJrU
 a34njjV7AQPJnVuo5foatnjxc9APm3FqrKeOXJJ6wtfJZXJ3Gq/P2iSnyq3hm+29Ana6
 i3ZQ==
X-Gm-Message-State: AOJu0YwbRq/1tI/pqAyaOWDg2tykwtfnidPYeZbetrnY7hhNmCFMdRUI
 ltY62l3gJLydv6t3nKnatDLTnlw5MgFHf3Z55fG6vZsVItyojta9G4mLbVQ4m/rM5VM0kJTNtJj
 tSu/feTadyXLO+8ag1gyx8fc=
X-Received: by 2002:a0c:e4c4:0:b0:681:783f:b795 with SMTP id
 g4-20020a0ce4c4000000b00681783fb795mr1588619qvm.117.1705500687683; 
 Wed, 17 Jan 2024 06:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy7nHeUGVETYitAE1Ne2zsAemZVl7kYF+lzGxSmrbXOAdVFmF3G7/09FKGmxYdD7B64OU+aA==
X-Received: by 2002:a0c:e4c4:0:b0:681:783f:b795 with SMTP id
 g4-20020a0ce4c4000000b00681783fb795mr1588598qvm.117.1705500687354; 
 Wed, 17 Jan 2024 06:11:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a056214008700b0067f789a59c8sm5000646qvr.113.2024.01.17.06.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:11:26 -0800 (PST)
Message-ID: <ba280754-665e-49af-9442-9a37a1f5ce75@redhat.com>
Date: Wed, 17 Jan 2024 15:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Zhenzhong,

On 1/15/24 11:13, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds pci_device_set/unset_iommu_device() to set/unset
> IOMMUFDDevice for a given PCIe device. Caller of set
> should fail if set operation fails.
>
> Extract out pci_device_get_iommu_bus_devfn() to facilitate
> implementation of pci_device_set/unset_iommu_device().
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/pci/pci.h | 39 ++++++++++++++++++++++++++++++++++-
>  hw/pci/pci.c         | 49 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index fa6313aabc..a810c0ec74 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -7,6 +7,8 @@
>  /* PCI includes legacy ISA access.  */
>  #include "hw/isa/isa.h"
>  
> +#include "sysemu/iommufd_device.h"
> +
>  extern bool pci_available;
>  
>  /* PCI bus */
> @@ -384,10 +386,45 @@ typedef struct PCIIOMMUOps {
>       *
>       * @devfn: device and function number
>       */
> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @set_iommu_device: set iommufd device for a PCI device to vIOMMU
> +     *
> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
> +     * utilize iommufd specific features.
> +     *
> +     * Return true if iommufd device is accepted, or else return false with
> +     * errp set.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     *
> +     * @idev: the data structure representing iommufd device.
> +     *
> +     */
> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int32_t devfn,
> +                            IOMMUFDDevice *idev, Error **errp);
> +    /**
> +     * @unset_iommu_device: unset iommufd device for a PCI device from vIOMMU
> +     *
> +     * Optional callback.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     */
> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int32_t devfn);
>  } PCIIOMMUOps;
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice *idev,
> +                                Error **errp);
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>  
>  /**
>   * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580..3848662f95 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2672,7 +2672,10 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>      }
>  }
>  
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                                           PCIBus **aliased_pbus,
> +                                           PCIBus **piommu_bus,
> +                                           uint8_t *aliased_pdevfn)
nit: I would drop the p in aliased_pbus andaliased_pdevfn. Maybe you
should allow the caller to pass NUL for aliased_pbus and aliased_pdevfn
as it is the case for pci_device_set_iommu_device() I may resue that
helper in [RFC 2/7] hw/pci: Introduce pci_device_iommu_bus
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> @@ -2717,6 +2720,18 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> +    *aliased_pbus = bus;
> +    *piommu_bus = iommu_bus;
> +    *aliased_pdevfn = devfn;
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
>      if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
>          return iommu_bus->iommu_ops->get_address_space(bus,
>                                   iommu_bus->iommu_opaque, devfn);
> @@ -2724,6 +2739,38 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>      return &address_space_memory;
>  }
>  
> +int pci_device_set_iommu_device(PCIDevice *dev, IOMMUFDDevice *idev,
> +                                Error **errp)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus &&
> +        iommu_bus->iommu_ops && iommu_bus->iommu_ops->set_iommu_device) {
> +        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
> +                                                      iommu_bus->iommu_opaque,
> +                                                      dev->devfn, idev, errp);
> +    }
> +    return 0;
> +}
> +
> +void pci_device_unset_iommu_device(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus &&
> +        iommu_bus->iommu_ops && iommu_bus->iommu_ops->unset_iommu_device) {
> +        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
> +                                                        iommu_bus->iommu_opaque,
> +                                                        dev->devfn);
> +    }
> +}
> +
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      /*
Thanks

Eric


