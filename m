Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E902B7B5621
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKbd-0002kf-F9; Mon, 02 Oct 2023 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKbb-0002ji-A0
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnKbX-0006hd-Hx
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696259581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tJu9NNbQML3qPbv6mOg2pjwEqYhMmEhIhfFnG0eBk8=;
 b=IqANek9S0OyalCXEo5G55wk73wgoquNWwLdZi/OKXex0YA+bF3RW7a3CpldCT2EOACYKMC
 ccA5rv2zGbKQWtViH4d6P3m58gUNqEirNLLZBkKrQ6QRsfLbNM96cDBdReFFqlgxGZtvCV
 o4FI3zxZE4+fIngcnDEVkUi4XoMRKBQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-sASXHNygOf-PVySxHfa5kg-1; Mon, 02 Oct 2023 11:12:45 -0400
X-MC-Unique: sASXHNygOf-PVySxHfa5kg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7742eeceeacso2449219085a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 08:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696259565; x=1696864365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5tJu9NNbQML3qPbv6mOg2pjwEqYhMmEhIhfFnG0eBk8=;
 b=Uu9DSCmqhbdAG9rz1Zs5BLCju5Fx4ZUm83koT9V71tVX5G44K8Bp03nUTd/M/MOzb/
 DBVI61pgYzmN66olk4olnjQ0cJirotBT0JxxoOciIo/mfcer149jMlLu/1ZfYFHyITkg
 7QoP/KJ2nQ5TgrHbNn8IV3DHIUVFrOfWS7d/qp5KAwrHjTdtxTSRrwsDSOuEbTJJaxI4
 lJoauM3YAXguFmIexhpRf6T/9+oGkvHUL2BChbtsRMbwpgFKXbIVTtfWb/GY9yJZJq/J
 ZEi9fDImKrkWy59mS6lc9vajmQZ4rZ0JK5ELM4RdphEZPrwOuND4xLMLSeNafaU7Kq7n
 Hbbg==
X-Gm-Message-State: AOJu0YwWXFod5GoUMuCKLjvnuP8DQNJVWytnfFDKFL1JytDyJuAhB9MU
 RqI7eW1GKu+aXne/+INMfpFf4hxmkYtrcxVhgjp/4W35M/hIiQ3T127kBB2Od5777aRS3VP9I1f
 33W0BQF3BDWIDpS8=
X-Received: by 2002:a05:620a:46a6:b0:775:6695:b10f with SMTP id
 bq38-20020a05620a46a600b007756695b10fmr13246031qkb.56.1696259565268; 
 Mon, 02 Oct 2023 08:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JfIq4D+5oIwO8fNRJcetdK8hAzhsOJgGemlvHRB9FJ069tuiLGmF27A77FSiVm65924STA==
X-Received: by 2002:a05:620a:46a6:b0:775:6695:b10f with SMTP id
 bq38-20020a05620a46a600b007756695b10fmr13246013qkb.56.1696259564977; 
 Mon, 02 Oct 2023 08:12:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 pi32-20020a05620a37a000b0076dacd14484sm9070859qkn.83.2023.10.02.08.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:12:44 -0700 (PDT)
Message-ID: <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
Date: Mon, 2 Oct 2023 17:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230622214845.3980-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hello Joao,

On 6/22/23 23:48, Joao Martins wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Add a pci_setup_iommu_ops() that uses a newly added structure
> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
> an address space for a PCI device in vendor specific way.
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
>   include/hw/pci/pci.h     |  7 +++++++
>   include/hw/pci/pci_bus.h |  1 +
>   hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>   3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6d0574a2999..f59aef5a329a 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>   AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>   
> +typedef struct PCIIOMMUOps PCIIOMMUOps;
> +struct PCIIOMMUOps {
> +    AddressSpace * (*get_address_space)(PCIBus *bus,
> +                                void *opaque, int32_t devfn);
> +};
> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
> +

I think you should first convert all PHBs to PCIIOMMUOps to avoid all the
tests as below and adapt pci_setup_iommu_ops() with the new parameter.

Thanks,

C.

>   pcibus_t pci_bar_address(PCIDevice *d,
>                            int reg, uint8_t type, pcibus_t size);
>   
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 56531759578f..fb770b236d69 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -35,6 +35,7 @@ struct PCIBus {
>       enum PCIBusFlags flags;
>       PCIIOMMUFunc iommu_fn;
>       void *iommu_opaque;
> +    const PCIIOMMUOps *iommu_ops;
>       uint8_t devfn_min;
>       uint32_t slot_reserved_mask;
>       pci_set_irq_fn set_irq;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7dc0..4e32c09e81d6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2639,7 +2639,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>       PCIBus *iommu_bus = bus;
>       uint8_t devfn = dev->devfn;
>   
> -    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> +    /*
> +     * get_address_space() callback is mandatory when iommu uses
> +     * pci_setup_iommu_ops(), so needs to ensure its presence in
> +     * the iommu_bus search.
> +     */
> +    while (iommu_bus &&
> +           !(iommu_bus->iommu_fn ||
> +            (iommu_bus->iommu_ops && iommu_bus->iommu_ops->get_address_space)) &&
> +           iommu_bus->parent_dev) {
>           PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
>   
>           /*
> @@ -2678,8 +2686,14 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>   
>           iommu_bus = parent_bus;
>       }
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
>       }
>       return &address_space_memory;
>   }
> @@ -2690,6 +2704,12 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>       bus->iommu_opaque = opaque;
>   }
>   
> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
> +{
> +    bus->iommu_ops = ops;
> +    bus->iommu_opaque = opaque;
> +}
> +
>   static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>   {
>       Range *range = opaque;


