Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0943832973
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 13:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnuo-0003yY-R1; Fri, 19 Jan 2024 07:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQnum-0003xh-Ct
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:24:04 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQnuk-00045z-6e
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:24:04 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6de83f5a004so437389a34.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705667040; x=1706271840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0btNgAjVUmKCmuZwja3ERXlmOE1Zb/B2X5IcwYH8e68=;
 b=PYlK1Iot0uykUzmE3bYA6J7upA1Fh62wZNKeXmhODQnHlxrZRFKLVoT3OEvpDEIbNV
 w3WSPoqqESHD5Kf6plYxeU+/vyKen4gWmlkDuQhMBggdwyTC58v3l8Uv0A2gCUeQsVlc
 6/OZewkkDSLTpBbj6/t/UN7C01Pvb+ZAMqSMbja9bJL9WvurBgfF+gqpsXA8eYmbduMR
 66NK3k5NCNJV0lTVtlxpse8mOGHDifyJK3FpIoqJm2tTlD5Kr88BoL2lLVBMGkT1Wf5R
 H1gwW1Cw7z5OaQfsJmLmqi+svGrGHfrXFQZy2lWHjC/+knuxqvUzbHYa/JQ5OaW98y2E
 JNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705667040; x=1706271840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0btNgAjVUmKCmuZwja3ERXlmOE1Zb/B2X5IcwYH8e68=;
 b=KQKaz5ILThFOm99e8FewDlABQ63zGAcXPaczEAVfbG/QphIGNyuLxCiRRkGar1Y8HS
 DzZeOQgb0wmlbvXaBdGpURvnV22BuRqt88/VuHiQWakmBcYTVnfotnmkFtTmOu7OkOuZ
 PcyaXfGfnTUXx4SgmfoN2iiOnNRnlTzNEY8MmvYav3Kc+VONjOBihX4be6pddpVzBiu1
 VNFzHY91fNJprGCtk2zLDmLZ2tDM5GTnZiQ+TAUd0raZxqbscx43WoJi/S+i3x1jjCSU
 +Te/CLUcXRojlgoARgRpsjeJ+jgaiq9EGH9WILDgMHzMWH5L/OfR2YBnB9Rw19ndFl6I
 7usA==
X-Gm-Message-State: AOJu0YzOKLccnkKasai1SlLSV5hKVM/Uru3BxlpX1aHgS8aMZ+pr4naE
 PkRYvrOBc9NNY/5qoccN3sjHkPC4PfCETlGRtFp2JxWaCu5JFruMc4DnrwFCP4A=
X-Google-Smtp-Source: AGHT+IFLrwEqpJjK0fuLY/iW2An36Cgll/wO1Pje5+b1YibdM+kACz17MA/4N0nQF805h38QCFp5pg==
X-Received: by 2002:a05:6359:219:b0:175:a5d9:63fd with SMTP id
 ej25-20020a056359021900b00175a5d963fdmr2403821rwb.35.1705667040332; 
 Fri, 19 Jan 2024 04:24:00 -0800 (PST)
Received: from [192.168.68.110] ([189.38.141.140])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm4894988pfh.204.2024.01.19.04.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 04:23:59 -0800 (PST)
Message-ID: <183eff15-fc78-4377-b8f8-1565da9bf467@ventanamicro.com>
Date: Fri, 19 Jan 2024 09:23:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hw/riscv/virt: Add IOPMP support
Content-Language: en-US
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org
References: <20240112094335.922010-1-ethan84@andestech.com>
 <20240112094335.922010-4-ethan84@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240112094335.922010-4-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/12/24 06:43, Ethan Chen wrote:
> If a source device is connected to the IOPMP device, its memory
> transaction will be checked by the IOPMP rule.
> 
> When using RISC-V virt machine option "iopmp=on", the generic PCIe host
> bridge connects to IOPMP. The PCI devices on the brigde will connets to

typos: 'brigde' and 'connets'

> IOPMP with default source id(SID) from PCI BDF.
> 
> - Add 'iopmp=on' option to add an iopmp device. It checks dma
>    operations from the generic PCIe host bridge. This option is assumed
>    to be "off"
> - Add 'iopmp_cascade=on' option to add second iopmp device which is
>    cascaded by first iopmp device to machine. When iopmp option is "off"
>    , this option has no effect.
> 
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>   docs/system/riscv/virt.rst |  12 ++++
>   hw/riscv/Kconfig           |   1 +
>   hw/riscv/virt.c            | 110 ++++++++++++++++++++++++++++++++++++-
>   include/hw/riscv/virt.h    |   8 ++-
>   4 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..e07ce2cd28 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -116,6 +116,18 @@ The following machine-specific options are supported:
>     having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
>     the default number of per-HART VS-level AIA IMSIC pages is 0.
>   
> +- iopmp=[on|off]
> +
> +  When this option is "on".  An IOPMP device is added to machine. It checks dma

"When this option is "on", an IOPMP device is added ...

> +  operations from the generic PCIe host bridge. This option is assumed to be
> +  "off".
> +
> +- iopmp_cascade=[on|off]
> +
> +  When this option is "on". Second IOPMP device which is cascaded by first IOPMP

"When this option is "on", a second IOPMP device ...

> +  device is added to machine. When IOPMP option is "off", this option has no
> +  effect. This option is assumed to be "off".
> +
>   Running Linux kernel
>   --------------------
>   
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a50717be87..c207b94747 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select RISCV_IOPMP
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f9fd1341fc..c7a5035074 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -52,6 +52,7 @@
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
> +#include "hw/misc/riscv_iopmp.h"
>   
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -74,6 +75,8 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
> +    [VIRT_IOPMP2] =       { 0x10300000,      0x100000 },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1011,6 +1014,44 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
>       g_free(nodename);
>   }
>   
> +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *memmap,
> +                             uint32_t irq_mmio_phandle) {
> +    char *name;

Use g_autofree to avoid having to g_free() the string in the end:

g_autofree char *name = NULL;

> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOPMP].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP].base,
> +        0x0, memmap[VIRT_IOPMP].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
> +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ);
> +    } else {
> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IRQ, 0x4);
> +    }
> +    g_free(name);
> +}
> +
> +static void create_fdt_iopmp2(RISCVVirtState *s, const MemMapEntry *memmap,
> +                             uint32_t irq_mmio_phandle) {
> +    char *name;

Use g_autofree here too.

> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/iopmp2@%lx", (long)memmap[VIRT_IOPMP2].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopmp");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IOPMP2].base,
> +        0x0, memmap[VIRT_IOPMP2].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
> +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP2_IRQ);
> +    } else {
> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP2_IRQ, 0x4);
> +    }
> +    g_free(name);
> +}
> +
>   static void finalize_fdt(RISCVVirtState *s)
>   {
>       uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> @@ -1029,6 +1070,13 @@ static void finalize_fdt(RISCVVirtState *s)
>       create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
>   
>       create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> +
> +    if (s->have_iopmp) {
> +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> +        if (s->have_iopmp_cascade) {
> +            create_fdt_iopmp2(s, virt_memmap, irq_mmio_phandle);
> +        }
> +    }
>   }
>   
>   static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> @@ -1531,7 +1579,7 @@ static void virt_machine_init(MachineState *machine)
>               qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>       }
>   
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    DeviceState *gpex_dev = gpex_pcie_init(system_memory, pcie_irqchip, s);

Move the "DeviceState *gpex_dev" declaration to the start of the function, then
initialize it here.


Thanks,


Daniel

>   
>       create_platform_bus(s, mmio_irqchip);
>   
> @@ -1542,6 +1590,23 @@ static void virt_machine_init(MachineState *machine)
>       sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
>           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>   
> +    if (s->have_iopmp) {
> +        /* IOPMP */
> +        DeviceState *iopmp_dev = sysbus_create_simple(TYPE_IOPMP,
> +            memmap[VIRT_IOPMP].base,
> +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> +
> +        /* PCI with IOPMP */
> +        iopmp_setup_pci(iopmp_dev, PCI_HOST_BRIDGE(gpex_dev)->bus);
> +
> +        if (s->have_iopmp_cascade) {
> +            DeviceState *iopmp_dev2 = sysbus_create_simple(TYPE_IOPMP,
> +                memmap[VIRT_IOPMP2].base,
> +                qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP2_IRQ));
> +            cascade_iopmp(iopmp_dev, iopmp_dev2);
> +        }
> +    }
> +
>       for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
>           /* Map legacy -drive if=pflash to machine properties */
>           pflash_cfi01_legacy_drive(s->flash[i],
> @@ -1647,6 +1712,35 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
>       s->have_aclint = value;
>   }
>   
> +static bool virt_get_iopmp(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_iopmp;
> +}
> +
> +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_iopmp = value;
> +}
> +
> +static bool virt_get_iopmp_cascade(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_iopmp_cascade;
> +}
> +
> +static void virt_set_iopmp_cascade(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_iopmp_cascade = value;
> +}
> +
> +
>   bool virt_is_acpi_enabled(RISCVVirtState *s)
>   {
>       return s->acpi != ON_OFF_AUTO_OFF;
> @@ -1749,6 +1843,20 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                 NULL, NULL);
>       object_class_property_set_description(oc, "acpi",
>                                             "Enable ACPI");
> +
> +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> +                                   virt_set_iopmp);
> +    object_class_property_set_description(oc, "iopmp",
> +                                          "Set on/off to enable/disable "
> +                                          "iopmp device");
> +
> +    object_class_property_add_bool(oc, "iopmp-cascade",
> +                                   virt_get_iopmp_cascade,
> +                                   virt_set_iopmp_cascade);
> +    object_class_property_set_description(oc, "iopmp-cascade",
> +                                          "Set on/off to enable/disable "
> +                                          "iopmp2 device which is cascaded by "
> +                                          "iopmp1 device");
>   }
>   
>   static const TypeInfo virt_machine_typeinfo = {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index f89790fd58..07d95fde61 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -55,6 +55,8 @@ struct RISCVVirtState {
>   
>       int fdt_size;
>       bool have_aclint;
> +    bool have_iopmp;
> +    bool have_iopmp_cascade;
>       RISCVVirtAIAType aia_type;
>       int aia_guests;
>       char *oem_id;
> @@ -84,12 +86,16 @@ enum {
>       VIRT_PCIE_MMIO,
>       VIRT_PCIE_PIO,
>       VIRT_PLATFORM_BUS,
> -    VIRT_PCIE_ECAM
> +    VIRT_PCIE_ECAM,
> +    VIRT_IOPMP,
> +    VIRT_IOPMP2,
>   };
>   
>   enum {
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
> +    IOPMP_IRQ = 12,
> +    IOPMP2_IRQ = 13,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
>       VIRTIO_COUNT = 8,
>       PCIE_IRQ = 0x20, /* 32 to 35 */

