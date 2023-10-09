Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7937BE646
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpt2P-0004Vf-Qs; Mon, 09 Oct 2023 12:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt2O-0004VU-K7
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt2N-0004yG-5f
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696868598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftn60ogtZKvUd1i4IEbbgz7zv3XYWLxo5QGDZ8HmIeo=;
 b=Z7ICc3luT+udUpocaR+HnvdUd7ptgu4vxWHuGP+Q6BTaxlsyf8efqF0oUAIRTpuUkKuJtX
 gfh3PHEfc6zM7IsTLsiRkkmL8cN/QV8+Uebj3Dhw6RozIXGHRgcnnPYHMZj8XMpFCkOn5l
 3qPVqGCM7NGENDSwqJeKShFogHaJgFg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5b6OGXDVOpuqvoTHvTS-NQ-1; Mon, 09 Oct 2023 12:23:07 -0400
X-MC-Unique: 5b6OGXDVOpuqvoTHvTS-NQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b65c46bca8so365575366b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696868586; x=1697473386;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ftn60ogtZKvUd1i4IEbbgz7zv3XYWLxo5QGDZ8HmIeo=;
 b=rqhdlrm5zce8zeJ3GScfjqrEdw5Y/r5eDU/NQ1lNHo9HHBhO4PCL+r1d8ROIgkugws
 TpN78fDcfuWgAbtASsLsVaNxwsoo0+tk0jVGYN4m6TggDTfFQzQvC13QX2mBjGntNKkQ
 QYftBB86IQK3n7wxyd4lnXIfzjf6LSaFhM3y0dwzdRN1v/8zLGgMv3x6/dAoTbFGexKt
 6cpyoTJZZygL3NJ53VkY0l8sX/ioXD50X6i0ABIMznbFtRg7Ht7qsLvricjoq/tqFFRf
 KwTtCLwpRiSKrICxxR1yaaGGthu5jFhf/1IuPoc5rk8p4qGqMopT/DK/TCZymlD/iRtp
 QLKQ==
X-Gm-Message-State: AOJu0YwHCmo1UDyT+RdObIBshj4G0JpnkDWTVYwPEzMETlHpNVG4h1uQ
 ZGmRQZkwgzfion+2BE8UC8cDZzkp+MJ05mWgV3MElwz8e2D9e0hmppN7EwQL9EgeaJ+k772IFw1
 3UdTpCIZH4r89mv0=
X-Received: by 2002:a17:907:7798:b0:9a9:f14a:22dc with SMTP id
 ky24-20020a170907779800b009a9f14a22dcmr14508439ejc.8.1696868586247; 
 Mon, 09 Oct 2023 09:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3OG2lcxqR5MVVz292K+e9FmsoGXN3FpjP1aM65I3RPSBKHLzOYE9S8EaZjjQgRT13vfpPtQ==
X-Received: by 2002:a17:907:7798:b0:9a9:f14a:22dc with SMTP id
 ky24-20020a170907779800b009a9f14a22dcmr14508403ejc.8.1696868585900; 
 Mon, 09 Oct 2023 09:23:05 -0700 (PDT)
Received: from redhat.com ([2.55.57.209]) by smtp.gmail.com with ESMTPSA id
 u18-20020a1709064ad200b0099d0a8ccb5fsm6973775ejt.152.2023.10.09.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:23:05 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:22:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 5/6] hw/pci: Clean up global variable shadowing of
 address_space_io variable
Message-ID: <20231009122253-mutt-send-email-mst@kernel.org>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009094747.54240-6-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 09, 2023 at 11:47:45AM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   hw/pci/pci.c:504:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>                                          MemoryRegion *address_space_io,
>                                                        ^
>   hw/pci/pci.c:533:38: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>                          MemoryRegion *address_space_io,
>                                        ^
>   hw/pci/pci.c:543:40: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>                            MemoryRegion *address_space_io,
>                                          ^
>   hw/pci/pci.c:590:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>                                 MemoryRegion *address_space_io,
>                                               ^
>   include/exec/address-spaces.h:35:21: note: previous declaration is here
>   extern AddressSpace address_space_io;
>                       ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/pci/pci.h |  9 +++------
>  hw/pci/pci.c         | 25 +++++++++----------------
>  2 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index b70a0b95ff..ea5aff118b 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -279,12 +279,10 @@ bool pci_bus_is_express(const PCIBus *bus);
>  
>  void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                         const char *name,
> -                       MemoryRegion *address_space_mem,
> -                       MemoryRegion *address_space_io,
> +                       MemoryRegion *mem, MemoryRegion *io,
>                         uint8_t devfn_min, const char *typename);
>  PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> +                         MemoryRegion *mem, MemoryRegion *io,
>                           uint8_t devfn_min, const char *typename);
>  void pci_root_bus_cleanup(PCIBus *bus);
>  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq,
> @@ -304,8 +302,7 @@ int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
>  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
>                                pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                                void *irq_opaque,
> -                              MemoryRegion *address_space_mem,
> -                              MemoryRegion *address_space_io,
> +                              MemoryRegion *mem, MemoryRegion *io,
>                                uint8_t devfn_min, int nirq,
>                                const char *typename);
>  void pci_unregister_root_bus(PCIBus *bus);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b0d21bf43a..7d09e1a39d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -500,15 +500,14 @@ bool pci_bus_bypass_iommu(PCIBus *bus)
>  }
>  
>  static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
> -                                       MemoryRegion *address_space_mem,
> -                                       MemoryRegion *address_space_io,
> +                                       MemoryRegion *mem, MemoryRegion *io,
>                                         uint8_t devfn_min)
>  {
>      assert(PCI_FUNC(devfn_min) == 0);
>      bus->devfn_min = devfn_min;
>      bus->slot_reserved_mask = 0x0;
> -    bus->address_space_mem = address_space_mem;
> -    bus->address_space_io = address_space_io;
> +    bus->address_space_mem = mem;
> +    bus->address_space_io = io;
>      bus->flags |= PCI_BUS_IS_ROOT;
>  
>      /* host bridge */
> @@ -529,25 +528,21 @@ bool pci_bus_is_express(const PCIBus *bus)
>  
>  void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                         const char *name,
> -                       MemoryRegion *address_space_mem,
> -                       MemoryRegion *address_space_io,
> +                       MemoryRegion *mem, MemoryRegion *io,
>                         uint8_t devfn_min, const char *typename)
>  {
>      qbus_init(bus, bus_size, typename, parent, name);
> -    pci_root_bus_internal_init(bus, parent, address_space_mem,
> -                               address_space_io, devfn_min);
> +    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
>  }
>  
>  PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> +                         MemoryRegion *mem, MemoryRegion *io,
>                           uint8_t devfn_min, const char *typename)
>  {
>      PCIBus *bus;
>  
>      bus = PCI_BUS(qbus_new(typename, parent, name));
> -    pci_root_bus_internal_init(bus, parent, address_space_mem,
> -                               address_space_io, devfn_min);
> +    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
>      return bus;
>  }
>  
> @@ -586,15 +581,13 @@ void pci_bus_irqs_cleanup(PCIBus *bus)
>  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
>                                pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                                void *irq_opaque,
> -                              MemoryRegion *address_space_mem,
> -                              MemoryRegion *address_space_io,
> +                              MemoryRegion *mem, MemoryRegion *io,
>                                uint8_t devfn_min, int nirq,
>                                const char *typename)
>  {
>      PCIBus *bus;
>  
> -    bus = pci_root_bus_new(parent, name, address_space_mem,
> -                           address_space_io, devfn_min, typename);
> +    bus = pci_root_bus_new(parent, name, mem, io, devfn_min, typename);
>      pci_bus_irqs(bus, set_irq, irq_opaque, nirq);
>      pci_bus_map_irqs(bus, map_irq);
>      return bus;
> -- 
> 2.41.0


