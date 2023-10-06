Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F077BB372
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogTQ-0000rJ-07; Fri, 06 Oct 2023 04:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogTJ-0000r3-6J
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1qogTG-00047W-C1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696581964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0fItp18fYNd9dMdqdD4NpZ2uuTmANuaBbmmjM7vTAQ=;
 b=G5G3IlOWNmpZq8OXKXuj5wp2ZaVYhHJodTVu/M6Vj0hIc5PxObOWFxNp9Gm5WQt9eALXXt
 JYXXUv9R03s1ZDUk+vide08FEqsj94d/ath6R7+QqSN8aa4QrOSsgMlayp3j8/Y87bdv9w
 pMTHF5gbsc7cGHj0d5o0c4uVEsiYtJ0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-V7Pbjz0LPQaH6JV8A0M7Bg-1; Fri, 06 Oct 2023 04:46:03 -0400
X-MC-Unique: V7Pbjz0LPQaH6JV8A0M7Bg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-775869cf2f5so420914885a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696581963; x=1697186763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0fItp18fYNd9dMdqdD4NpZ2uuTmANuaBbmmjM7vTAQ=;
 b=FLD0//BUNrkWA1QX0o04cykKRxUL5RrZOfG4bjcRcV2kPZm6VFgPUCWr6UGyyr1hGu
 jyNN3Me61o+psaZCN1rnuGk2sfBmWDJrKO7IPC4hAGHfaNFj4+WKLZ41gvaQhemVJ90j
 wAtVH+yksaFtZaNWbiYpEKTBm4kZabkFJPpsa0PdOImPCVbGz5Vy187gWyhjCMBWNZco
 ZkdD0z4YyTK2kanFgzqjUaaDijUlUZCTbqItLo1Vm+h1YyrA5DVaaxfgvQlfBg8lIZFj
 AJ8W/MQ+JfjMidBEasxBbA68eYih/FAiWpIhr7q3FmwrMfrYCTZ2K/FLCalTcSBoBA7Z
 Zy8Q==
X-Gm-Message-State: AOJu0Yw1cqgHQ7mXVCh8RXEAESsAAN68nVCnbF86Y0GJsPFdRuep1aVD
 pWmAbnEot8YwE/c92Yt+WNocAgU3iXS3rpaNLzzolKjwMRr6W8PeN8AsxE12rmuBYgGanxcBoGc
 vBx368wcHFQCsl8k=
X-Received: by 2002:a05:620a:171e:b0:76e:f73d:65ae with SMTP id
 az30-20020a05620a171e00b0076ef73d65aemr4899230qkb.6.1696581962778; 
 Fri, 06 Oct 2023 01:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgSmpgzpAdqag8p41Kqka9MUSUZVXgyiW4tPdSaOutb5RxCSJ7mTsyUE8KgSi3WFnrBlJpQ==
X-Received: by 2002:a05:620a:171e:b0:76e:f73d:65ae with SMTP id
 az30-20020a05620a171e00b0076ef73d65aemr4899211qkb.6.1696581962503; 
 Fri, 06 Oct 2023 01:46:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a0c8cc9000000b0064c9f754794sm1210509qvb.86.2023.10.06.01.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:46:01 -0700 (PDT)
Message-ID: <439d42e6-0627-43d1-1a45-dbc92ef83380@redhat.com>
Date: Fri, 6 Oct 2023 10:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20230622214845.3980-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hi Joao,

On 6/22/23 23:48, Joao Martins wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Add a pci_setup_iommu_ops() that uses a newly added structure
> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
> an address space for a PCI device in vendor specific way.
double 'an'
> 
> In preparation to expand to supplying vIOMMU attributes, add a
> alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
> For now the PCIIOMMUOps just defines the address_space, but it will
> be extended to have another callback.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> [joao: Massage commit message and subject, and make it a complementary
> rather than changing every single consumer of pci_setup_iommu()]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
> ---
>  include/hw/pci/pci.h     |  7 +++++++
>  include/hw/pci/pci_bus.h |  1 +
>  hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>  3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6d0574a2999..f59aef5a329a 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>  
> +typedef struct PCIIOMMUOps PCIIOMMUOps;
> +struct PCIIOMMUOps {
> +    AddressSpace * (*get_address_space)(PCIBus *bus,
> +                                void *opaque, int32_t devfn);
> +};
> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
> +
>  pcibus_t pci_bar_address(PCIDevice *d,
>                           int reg, uint8_t type, pcibus_t size);
>  
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 56531759578f..fb770b236d69 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -35,6 +35,7 @@ struct PCIBus {
>      enum PCIBusFlags flags;
>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
> +    const PCIIOMMUOps *iommu_ops;
>      uint8_t devfn_min;
>      uint32_t slot_reserved_mask;
>      pci_set_irq_fn set_irq;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7dc0..4e32c09e81d6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2639,7 +2639,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>      PCIBus *iommu_bus = bus;
>      uint8_t devfn = dev->devfn;
>  
> -    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> +    /*
> +     * get_address_space() callback is mandatory when iommu uses
> +     * pci_setup_iommu_ops(), so needs to ensure its presence in
> +     * the iommu_bus search.
the fact that it is mandatory should also be documented along with the
PCIIOMMUOps struct definition and enforced at  pci_setup_iommu_ops()
removing the need for checking iommu_bus->iommu_ops->get_address_space
> +     */
> +    while (iommu_bus &&
> +           !(iommu_bus->iommu_fn ||
> +            (iommu_bus->iommu_ops && iommu_bus->iommu_ops->get_address_space)) &&
> +           iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
>  
>          /*
> @@ -2678,8 +2686,14 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
> -        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
> +        if (iommu_bus->iommu_fn) {
> +           return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
> +        } else if (iommu_bus->iommu_ops &&
> +                   iommu_bus->iommu_ops->get_address_space) {
> +           return iommu_bus->iommu_ops->get_address_space(bus,
> +                                           iommu_bus->iommu_opaque, devfn);
> +        }
>      }
>      return &address_space_memory;
>  }
> @@ -2690,6 +2704,12 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>      bus->iommu_opaque = opaque;
>  }
>  
> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
> +{
> +    bus->iommu_ops = ops;
> +    bus->iommu_opaque = opaque;
maybe assert if both iommu_fn and iommu_ops are set to make sure the
conversion is not done partially? If I understand it correctly either of
those 2 ops should be set and not both.
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range = opaque;

Thanks

Eric


