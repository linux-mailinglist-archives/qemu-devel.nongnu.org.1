Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EC742B3C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEvSh-0000m2-C3; Thu, 29 Jun 2023 13:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEvSb-0000ey-7Y
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:29:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEvSZ-0004fO-CM
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:29:36 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51de841a727so389281a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688059772; x=1690651772;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y02j66XW2Y2W8+CcWMOe3qMsTx1mOLC3LD5RrAIqE2A=;
 b=bvrnDLoc93SWrU4SOrIM8oL9RJV6UTMBeyHplSIpoF/hGdBuA9kmUYwu2zQBj8ztij
 rRkYQNk5K/LarpZD1hypoaTS3nP+YNGZ3y4BmSzDtf898XzH5WwhekXoV5dE61ymZaVJ
 Tli3EXvXIpqKFBRJRd2uD16q7TMALYFXyUSIPhh7SSOgTOoI55fq3RNchjwshyqbBmOy
 W4gP5iqNxeXymTu0GGW9u09xU13ILpQYnOVojnlS/hAE77TEyJ/sG/5F419V2IdjHim6
 YiamUgk0KBBD79QdMOMPZbsFHxN7J6z+Vn7fbq8fPtyINTliAr0yXhNWIajH417xOcua
 pUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688059772; x=1690651772;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y02j66XW2Y2W8+CcWMOe3qMsTx1mOLC3LD5RrAIqE2A=;
 b=VQlUPc8HaLFjOllqx3obdLcq3lTzCn96tILF6iRLHDopH/GI0B0s4J0s0azQ/QKnqL
 duzRmSm+qvLM30RRotCqPjoaRCBdmnCKZL4wdJAgJGbT/uYtXoJAX/EQDhi5yFbssPUH
 DVYqIUbXL4BhX+4ZCUoelewbyo/WPQF2cjZrNpqxR5+72E5Tgr5R0lI+BmDGbUADC51n
 9jptV+R25hgysurGfQYSKcDutnm2Q0EBc3kxi0J4bddv/O/NhzUqdGSCnpqKUCJKTBVN
 8ovrX1v5exaRts5eQWMReuCZJSZHXaEZnlhiMxUd8/6ESzptLQ67fInReVK9NZ3MZTJc
 B7IQ==
X-Gm-Message-State: AC+VfDyMSo7PZOq8GhBY5gQQGiICJzWOO2kJVdNzQK0Eol3LLTr0jqTw
 c6nWjIzzKKorvWcs7HjHkyA=
X-Google-Smtp-Source: ACHHUZ5LxJ9X11120u+SxZ+lNjnuYr+Ukgm8v+9oSM80l5gHPve4mgI8WpRAuuv1Ke3ZZhLOYj88VA==
X-Received: by 2002:aa7:c50b:0:b0:51d:91cc:32e8 with SMTP id
 o11-20020aa7c50b000000b0051d91cc32e8mr10233646edq.29.1688059772171; 
 Thu, 29 Jun 2023 10:29:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-043-218.77.11.pool.telefonica.de.
 [77.11.43.218]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa7d604000000b0051a4a1abdbbsm5960098edr.49.2023.06.29.10.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 10:29:31 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:52:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 14/16] hw/pci-host/i440fx: Resolve i440fx_init()
In-Reply-To: <60562e53-7b90-7b92-5978-729ee95e5d54@linaro.org>
References: <20230628195204.1241-1-shentey@gmail.com>
 <20230628195204.1241-15-shentey@gmail.com>
 <60562e53-7b90-7b92-5978-729ee95e5d54@linaro.org>
Message-ID: <C5FDA555-BD6F-4862-8937-51B1A45FF845@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 29=2E Juni 2023 07:50:10 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>Hi Bernhard,

Hi Phil,

>
>On 28/6/23 21:52, Bernhard Beschow wrote:
>> i440fx_init() is a legacy init function=2E The previous patches worked =
towards
>> TYPE_I440FX_PCI_HOST_BRIDGE to be instantiated the QOM way=2E Do this n=
ow by
>> transforming the parameters passed to i440fx_init() into property assig=
nments=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/pci-host/i440fx=2Eh | 10 ----------
>>   hw/i386/pc_piix=2Ec            | 30 +++++++++++++++++++++---------
>>   hw/pci-host/i440fx=2Ec         | 34 +++++----------------------------=
-
>>   3 files changed, 26 insertions(+), 48 deletions(-)
>>=20
>> diff --git a/include/hw/pci-host/i440fx=2Eh b/include/hw/pci-host/i440f=
x=2Eh
>> index 2d7bae5a45=2E=2Ec988f70890 100644
>> --- a/include/hw/pci-host/i440fx=2Eh
>> +++ b/include/hw/pci-host/i440fx=2Eh
>> @@ -34,14 +34,4 @@ struct PCII440FXState {
>>     #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i44=
0FX"
>>   -PCIBus *i440fx_init(const char *pci_type,
>> -                    DeviceState *dev,
>> -                    MemoryRegion *address_space_mem,
>> -                    MemoryRegion *address_space_io,
>> -                    ram_addr_t below_4g_mem_size,
>> -                    ram_addr_t above_4g_mem_size,
>> -                    MemoryRegion *pci_memory,
>> -                    MemoryRegion *ram_memory);
>> -
>> -
>>   #endif
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 87bee368fc=2E=2E1df309b8e2 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -126,7 +126,7 @@ static void pc_init1(MachineState *machine,
>>       MemoryRegion *rom_memory;
>>       ram_addr_t lowmem;
>>       uint64_t hole64_size;
>> -    DeviceState *i440fx_host;
>> +    Object *i440fx_host;
>>         /*
>>        * Calculate ram split, for memory below and above 4G=2E  It's a =
bit
>> @@ -201,8 +201,8 @@ static void pc_init1(MachineState *machine,
>>           pci_memory =3D g_new(MemoryRegion, 1);
>>           memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>>           rom_memory =3D pci_memory;
>> -        i440fx_host =3D qdev_new(host_type);
>> -        hole64_size =3D object_property_get_uint(OBJECT(i440fx_host),
>> +        i440fx_host =3D OBJECT(qdev_new(host_type));
>
>[*]
>
>> +        hole64_size =3D object_property_get_uint(i440fx_host,
>>                                                  PCI_HOST_PROP_PCI_HOLE=
64_SIZE,
>>                                                  &error_abort);
>>       } else {
>> @@ -243,12 +243,24 @@ static void pc_init1(MachineState *machine,
>>           PIIX3State *piix3;
>>           PCIDevice *pci_dev;
>>   -        pci_bus =3D i440fx_init(pci_type,
>> -                              i440fx_host,
>> -                              system_memory, system_io,
>> -                              x86ms->below_4g_mem_size,
>> -                              x86ms->above_4g_mem_size,
>> -                              pci_memory, ram_memory);
>> +        object_property_add_child(OBJECT(machine), "i440fx", i440fx_ho=
st);
>
>I'd keep the object_property_add_child() close to qdev_new() in [*]=2E
>Matter of taste=2E=2E=2E

Okay=2E I'd add a dedicated patch before this one since it has value in it=
s own (removal of qdev_get_machine() usage *and* doing what you propose)=2E

Best regards,
Bernhard

>
>> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
>> +                                 OBJECT(ram_memory), &error_fatal);
>> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
>> +                                 OBJECT(pci_memory), &error_fatal);
>> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM=
,
>> +                                 OBJECT(system_memory), &error_fatal);
>> +        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
>> +                                 OBJECT(system_io), &error_fatal);
>> +        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SI=
ZE,
>> +                                 x86ms->below_4g_mem_size, &error_fata=
l);
>> +        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SI=
ZE,
>> +                                 x86ms->above_4g_mem_size, &error_fata=
l);
>> +        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE=
,
>> +                                pci_type, &error_fatal);
>> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_f=
atal);
>> +
>> +        pci_bus =3D PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "p=
ci=2E0"));
>>           pci_bus_map_irqs(pci_bus,
>>                            xen_enabled() ? xen_pci_slot_get_pirq
>>                                          : pc_pci_slot_get_pirq);
>> diff --git a/hw/pci-host/i440fx=2Ec b/hw/pci-host/i440fx=2Ec
>> index e8e66afc11=2E=2E62d6287681 100644
>> --- a/hw/pci-host/i440fx=2Ec
>> +++ b/hw/pci-host/i440fx=2Ec
>> @@ -249,9 +249,14 @@ static void i440fx_pcihost_initfn(Object *obj)
>>     static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
>>   {
>> +    ERRP_GUARD();
>
>Unrelated change?
>
>Otherwise:
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>
>>       I440FXState *s =3D I440FX_PCI_HOST_BRIDGE(dev);
>>       PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>> +    PCIBus *b;
>> +    PCIDevice *d;
>> +    PCII440FXState *f;
>> +    unsigned i;
>>         memory_region_add_subregion(s->io_memory, 0xcf8, &phb->conf_mem=
);
>>       sysbus_init_ioports(sbd, 0xcf8, 4);
>> @@ -262,37 +267,10 @@ static void i440fx_pcihost_realize(DeviceState *d=
ev, Error **errp)
>>       /* register i440fx 0xcf8 port as coalesced pio */
>>       memory_region_set_flush_coalesced(&phb->data_mem);
>>       memory_region_add_coalescing(&phb->conf_mem, 0, 4);
>> -}
>> -
>> -PCIBus *i440fx_init(const char *pci_type,
>> -                    DeviceState *dev,
>> -                    MemoryRegion *address_space_mem,
>> -                    MemoryRegion *address_space_io,
>> -                    ram_addr_t below_4g_mem_size,
>> -                    ram_addr_t above_4g_mem_size,
>> -                    MemoryRegion *pci_address_space,
>> -                    MemoryRegion *ram_memory)
>> -{
>> -    I440FXState *s =3D I440FX_PCI_HOST_BRIDGE(dev);
>> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>> -    PCIBus *b;
>> -    PCIDevice *d;
>> -    PCII440FXState *f;
>> -    unsigned i;
>> -
>> -    s->system_memory =3D address_space_mem;
>> -    s->io_memory =3D address_space_io;
>> -    s->pci_address_space =3D pci_address_space;
>> -    s->ram_memory =3D ram_memory;
>> -    s->below_4g_mem_size =3D below_4g_mem_size;
>> -    s->above_4g_mem_size =3D above_4g_mem_size;
>> -    s->pci_type =3D (char *)pci_type;
>>         b =3D pci_root_bus_new(dev, NULL, s->pci_address_space,
>>                            s->io_memory, 0, TYPE_PCI_BUS);
>>       phb->bus =3D b;
>> -    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev=
));
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>         d =3D pci_create_simple(b, 0, s->pci_type);
>>       f =3D I440FX_PCI_DEVICE(d);
>> @@ -336,8 +314,6 @@ PCIBus *i440fx_init(const char *pci_type,
>>       d->config[I440FX_COREBOOT_RAM_SIZE] =3D ram_size;
>>         i440fx_update_memory_mappings(f);
>> -
>> -    return b;
>>   }
>>     static void i440fx_class_init(ObjectClass *klass, void *data)
>

