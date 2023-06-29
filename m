Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F9742167
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmQC-0005xB-8e; Thu, 29 Jun 2023 03:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmPz-0005vM-HK
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:50:28 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmPw-0000VC-Nq
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:50:18 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b6994a8ce3so5365131fa.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688025013; x=1690617013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOWZEW7WOxw3yZYx6eG/7IbuY6wAos/mE5uX8kPsJpg=;
 b=QtTP913P2oE7DXYpS+go9D9/RXllDPf3mTHZ8lr0by0+YyFjX13E0XmWpo2fd9IEyb
 Qr0I2Wu3I4meMIh2BF9hoSO9R0mBX/AEO+f3x2NfaisTFqB2FCFJRlrjJN5gnc/jhZ4B
 5YfxZ++EyqmwH/UMjyMicc2OWEb0kuzkEoS/3GXnrCdHoMb+PMiYzKJ0aKlTTLiHUWnr
 m1oM8HLVzT2M8YugZaU7Fc8d3TLJOIQbm0WHqLikDvSofgIG2s+3Oih7Bn0VlGaExzdB
 NzazgeDBhXXOvWH3hHK/6DBF7G9Jk1U2hIxlFkEcYaJfrEwWr6Is6gmWUWQxYDy31V7v
 x1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688025013; x=1690617013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOWZEW7WOxw3yZYx6eG/7IbuY6wAos/mE5uX8kPsJpg=;
 b=ULkYOTVxX4y1NaBvhQnhLDteGa4n3dFdl0uqPG5H1OTFOtuH0ICI18geq+jT6I+TCm
 DkdTf7CmJyuRmZSsArf7jWtUzKLZQrz8syV4/V+XB7ZVtdadG2LNgrFRh1wUwAnFSI+l
 9tKpxFX09vjXjymqwcTMAuQF3mEjYE1xVbfHLF3NEiVOfumlXomOj4uV7w5tP+exyADE
 /tklt0U3BeeWHpS9dxzFQxEV0FEnOpLNY4lyXfy/CeMsLQ+6egbUML36Jsc8zLMrOzPY
 J5cP0guLw9ALnnCm8KSku5NmlwuQcdEefnwpd8bx3A+vFEf1Mp/vHgX4g9RS2KmJTI5Q
 ofbg==
X-Gm-Message-State: AC+VfDwpWC7NnQSFBhZYGqfrcSykH74REqCxG2qkO27Bsz4D+b8p7L3K
 z8b7dpWughbqY9sGdjC4A08ycw==
X-Google-Smtp-Source: ACHHUZ42hjPgfbGE/SiEzeOGpFveigBlzgVuUFcg5qs0GZ7LbpR9u2hXeomvsJGXx3hEZ6/ZEwvyaQ==
X-Received: by 2002:a2e:805a:0:b0:2b6:bb08:91c4 with SMTP id
 p26-20020a2e805a000000b002b6bb0891c4mr3253962ljg.42.1688025013405; 
 Thu, 29 Jun 2023 00:50:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003fba94c9e18sm5933626wmj.4.2023.06.29.00.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:50:12 -0700 (PDT)
Message-ID: <60562e53-7b90-7b92-5978-729ee95e5d54@linaro.org>
Date: Thu, 29 Jun 2023 09:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 14/16] hw/pci-host/i440fx: Resolve i440fx_init()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230628195204.1241-1-shentey@gmail.com>
 <20230628195204.1241-15-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628195204.1241-15-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Bernhard,

On 28/6/23 21:52, Bernhard Beschow wrote:
> i440fx_init() is a legacy init function. The previous patches worked towards
> TYPE_I440FX_PCI_HOST_BRIDGE to be instantiated the QOM way. Do this now by
> transforming the parameters passed to i440fx_init() into property assignments.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/pci-host/i440fx.h | 10 ----------
>   hw/i386/pc_piix.c            | 30 +++++++++++++++++++++---------
>   hw/pci-host/i440fx.c         | 34 +++++-----------------------------
>   3 files changed, 26 insertions(+), 48 deletions(-)
> 
> diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
> index 2d7bae5a45..c988f70890 100644
> --- a/include/hw/pci-host/i440fx.h
> +++ b/include/hw/pci-host/i440fx.h
> @@ -34,14 +34,4 @@ struct PCII440FXState {
>   
>   #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
>   
> -PCIBus *i440fx_init(const char *pci_type,
> -                    DeviceState *dev,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    ram_addr_t below_4g_mem_size,
> -                    ram_addr_t above_4g_mem_size,
> -                    MemoryRegion *pci_memory,
> -                    MemoryRegion *ram_memory);
> -
> -
>   #endif
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 87bee368fc..1df309b8e2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -126,7 +126,7 @@ static void pc_init1(MachineState *machine,
>       MemoryRegion *rom_memory;
>       ram_addr_t lowmem;
>       uint64_t hole64_size;
> -    DeviceState *i440fx_host;
> +    Object *i440fx_host;
>   
>       /*
>        * Calculate ram split, for memory below and above 4G.  It's a bit
> @@ -201,8 +201,8 @@ static void pc_init1(MachineState *machine,
>           pci_memory = g_new(MemoryRegion, 1);
>           memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>           rom_memory = pci_memory;
> -        i440fx_host = qdev_new(host_type);
> -        hole64_size = object_property_get_uint(OBJECT(i440fx_host),
> +        i440fx_host = OBJECT(qdev_new(host_type));

[*]

> +        hole64_size = object_property_get_uint(i440fx_host,
>                                                  PCI_HOST_PROP_PCI_HOLE64_SIZE,
>                                                  &error_abort);
>       } else {
> @@ -243,12 +243,24 @@ static void pc_init1(MachineState *machine,
>           PIIX3State *piix3;
>           PCIDevice *pci_dev;
>   
> -        pci_bus = i440fx_init(pci_type,
> -                              i440fx_host,
> -                              system_memory, system_io,
> -                              x86ms->below_4g_mem_size,
> -                              x86ms->above_4g_mem_size,
> -                              pci_memory, ram_memory);
> +        object_property_add_child(OBJECT(machine), "i440fx", i440fx_host);

I'd keep the object_property_add_child() close to qdev_new() in [*].
Matter of taste...

> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
> +                                 OBJECT(ram_memory), &error_fatal);
> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
> +                                 OBJECT(pci_memory), &error_fatal);
> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM,
> +                                 OBJECT(system_memory), &error_fatal);
> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
> +                                 OBJECT(system_io), &error_fatal);
> +        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SIZE,
> +                                 x86ms->below_4g_mem_size, &error_fatal);
> +        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SIZE,
> +                                 x86ms->above_4g_mem_size, &error_fatal);
> +        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE,
> +                                pci_type, &error_fatal);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_fatal);
> +
> +        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "pci.0"));
>           pci_bus_map_irqs(pci_bus,
>                            xen_enabled() ? xen_pci_slot_get_pirq
>                                          : pc_pci_slot_get_pirq);
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index e8e66afc11..62d6287681 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -249,9 +249,14 @@ static void i440fx_pcihost_initfn(Object *obj)
>   
>   static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();

Unrelated change?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
>       PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    PCIBus *b;
> +    PCIDevice *d;
> +    PCII440FXState *f;
> +    unsigned i;
>   
>       memory_region_add_subregion(s->io_memory, 0xcf8, &phb->conf_mem);
>       sysbus_init_ioports(sbd, 0xcf8, 4);
> @@ -262,37 +267,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
>       /* register i440fx 0xcf8 port as coalesced pio */
>       memory_region_set_flush_coalesced(&phb->data_mem);
>       memory_region_add_coalescing(&phb->conf_mem, 0, 4);
> -}
> -
> -PCIBus *i440fx_init(const char *pci_type,
> -                    DeviceState *dev,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    ram_addr_t below_4g_mem_size,
> -                    ram_addr_t above_4g_mem_size,
> -                    MemoryRegion *pci_address_space,
> -                    MemoryRegion *ram_memory)
> -{
> -    I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
> -    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
> -    PCIBus *b;
> -    PCIDevice *d;
> -    PCII440FXState *f;
> -    unsigned i;
> -
> -    s->system_memory = address_space_mem;
> -    s->io_memory = address_space_io;
> -    s->pci_address_space = pci_address_space;
> -    s->ram_memory = ram_memory;
> -    s->below_4g_mem_size = below_4g_mem_size;
> -    s->above_4g_mem_size = above_4g_mem_size;
> -    s->pci_type = (char *)pci_type;
>   
>       b = pci_root_bus_new(dev, NULL, s->pci_address_space,
>                            s->io_memory, 0, TYPE_PCI_BUS);
>       phb->bus = b;
> -    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>   
>       d = pci_create_simple(b, 0, s->pci_type);
>       f = I440FX_PCI_DEVICE(d);
> @@ -336,8 +314,6 @@ PCIBus *i440fx_init(const char *pci_type,
>       d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
>   
>       i440fx_update_memory_mappings(f);
> -
> -    return b;
>   }
>   
>   static void i440fx_class_init(ObjectClass *klass, void *data)


