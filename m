Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701457BD353
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjgr-00032D-1g; Mon, 09 Oct 2023 02:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjgm-00031Q-Rb
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:24:24 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjgj-0002jG-66
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:24:23 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b9ad5760b9so705116466b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696832659; x=1697437459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok10S8aDQOseAoViFiKPjnUdmJ9q01EUPzhbmNMpeyw=;
 b=j27QKpnOjklopPurzK4ikQ4Z33xzPkWX4IhcO1bOzfCgGkdmL/caz8+17vgkdNvDGB
 MMfFa9DP1wgfttJ6a8oqfOFA6abvi6peQQvEbojL5lvRHc+4gklJfs9arBFbopo3UQbK
 labcWOvIOPguhTUJLG96UxOQ5oPryXwDG67ZPHeS8F7eq81W9QQGDp3vBnF7woFFQGnW
 FJBv+kIL9W/qfnk3rku1ggPsU/0yprQaOvg7WfxGomOPo8ntpSLKeraUCUh9ZvWpc52R
 wCcNC9OeVyvFdnJQn7Y69YntLhkQSqzd+gSbkrdV3ugqTFMrfm17/PetwSZcb7RBFqd6
 MO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696832659; x=1697437459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ok10S8aDQOseAoViFiKPjnUdmJ9q01EUPzhbmNMpeyw=;
 b=AP5NIya61evudfH5+2bdGla5pI5P44SSQp/yzBie4r+teB8WVF7bTIswsfSawej2Zm
 ikNQRofIJLZdAujTRake4IKlX0upR4zpoCNZRrt+3fnVfr1sGDpqcPDge89uBRFaPXfA
 Yz4qieF89yk6h4nrVXCMkTCGVV6E00/X4qVcREEKrNAktMI4EHwRETE1/GVz9pMwe/0j
 Y3h+LqQi75wZzD+k9DRpy/JSbjUKFCUB+Wc2E0nSoqu46JukDl90o5P628a1OTGaJ/fd
 OxJEl2SUfCC8ddLBeiVCHTdDK3oFzNn5tlarlm2X6OMwdgpVU2p7SjxDGP2JKJE6TJcZ
 if4A==
X-Gm-Message-State: AOJu0YzkQDBVTR6L9Ttk+frlj15cF9+x5vKNwxlqSVAGbuAtwjKb3EPM
 KtqOBqRgNGuUWoXsndQdWlC40Q==
X-Google-Smtp-Source: AGHT+IHhOirMSubejYqwFcFTUvuaYUwmMTje9UJfAXuOzw86OyDi63HgveCPwio21Hs5KK2CCsBWzQ==
X-Received: by 2002:a17:906:318f:b0:9b2:cf77:a105 with SMTP id
 15-20020a170906318f00b009b2cf77a105mr12032100ejy.15.1696832659272; 
 Sun, 08 Oct 2023 23:24:19 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a17090619cd00b009ae587ce135sm6304533ejd.223.2023.10.08.23.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:24:18 -0700 (PDT)
Message-ID: <12262a4d-c806-1de6-b814-5c18560ed06d@linaro.org>
Date: Mon, 9 Oct 2023 08:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] hw/ppc: Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 Bernhard Beschow <shentey@gmail.com>, Rene Engel <ReneEngel80@emailn.de>,
 vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <624a60acb0b81e6837b249890c59f3010ab12bbc.1696542537.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <624a60acb0b81e6837b249890c59f3010ab12bbc.1696542537.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 6/10/23 00:13, BALATON Zoltan wrote:
> The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
> with patches to support AmigaOS and is very similar to pegasos2 so can
> be easily emulated sharing most code with pegasos2. The reason to
> emulate it is that AmigaOS comes in different versions for AmigaOne
> and PegasosII which only have drivers for one machine and firmware so
> these only run on the specific machine. Adding this board allows
> another AmigaOS version to be used reusing already existing peagasos2
> emulation. (The AmigaOne was the first of these boards so likely most
> widespread which then inspired Pegasos that was later replaced with
> PegasosII due to problems with Articia S, so these have a lot of
> similarity. Pegasos mainly ran MorphOS while the PegasosII version of
> AmigaOS was added later and therefore less common than the AmigaOne
> version.)
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   MAINTAINERS                             |   8 ++
>   configs/devices/ppc-softmmu/default.mak |   1 +
>   hw/ppc/Kconfig                          |   7 +
>   hw/ppc/amigaone.c                       | 164 ++++++++++++++++++++++++
>   hw/ppc/meson.build                      |   2 +
>   5 files changed, 182 insertions(+)
>   create mode 100644 hw/ppc/amigaone.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f0e20fde6..03f908c153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,6 +1490,14 @@ F: hw/pci-host/mv64361.c
>   F: hw/pci-host/mv643xx.h
>   F: include/hw/pci-host/mv64361.h
>   
> +amigaone

'AmigaOne' like in subject and description?

> +M: BALATON Zoltan <balaton@eik.bme.hu>
> +L: qemu-ppc@nongnu.org
> +S: Maintained
> +F: hw/ppc/amigaone.c
> +F: hw/pci-host/articia.c
> +F: include/hw/pci-host/articia.h
> +
>   Virtual Open Firmware (VOF)
>   M: Alexey Kardashevskiy <aik@ozlabs.ru>


> +static void amigaone_init(MachineState *machine)
> +{
> +    PowerPCCPU *cpu;
> +    CPUPPCState *env;
> +    MemoryRegion *rom, *pci_mem, *mr;
> +    const char *fwname = machine->firmware ?: PROM_FILENAME;
> +    char *filename;
> +    ssize_t sz;
> +    PCIBus *pci_bus;
> +    Object *via;
> +    DeviceState *dev;
> +    I2CBus *i2c_bus;
> +    uint8_t *spd_data;
> +    int i;
> +
> +    /* init CPU */
> +    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> +    env = &cpu->env;
> +    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
> +        error_report("Incompatible CPU, only 6xx bus supported");
> +        exit(1);
> +    }
> +    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
> +    qemu_register_reset(amigaone_cpu_reset, cpu);
> +
> +    /* RAM */
> +    if (machine->ram_size > 2 * GiB) {
> +        error_report("RAM size more than 2 GiB is not supported");
> +        exit(1);
> +    }
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +    if (machine->ram_size < 1 * GiB + 32 * KiB) {
> +        /* Firmware uses this area for startup */

This is odd. Does this machine really support 2GiB?

Could it be 1GiB max, mapped twice?

> +        mr = g_new(MemoryRegion, 1);
> +        memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
> +        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
> +    }
> +
> +    /* allocate and load firmware */
> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
> +    if (!filename) {
> +        error_report("Could not find firmware '%s'", fwname);
> +        exit(1);
> +    }
> +    rom = g_new(MemoryRegion, 1);
> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
> +    sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
> +    if (sz <= 0 || sz > PROM_SIZE) {
> +        error_report("Could not load firmware '%s'", filename);
> +        exit(1);
> +    }
> +    g_free(filename);
> +
> +    /* Articia S */
> +    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
> +
> +    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
> +    if (machine->ram_size > 512 * MiB) {
> +        spd_data = spd_data_generate(SDR, machine->ram_size / 2);
> +    } else {
> +        spd_data = spd_data_generate(SDR, machine->ram_size);
> +    }
> +    fix_spd_data(spd_data);
> +    smbus_eeprom_init_one(i2c_bus, 0x51, spd_data);
> +    if (machine->ram_size > 512 * MiB) {
> +        smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
> +    }

This seems to confirm my doubts, you use at most 2 SPD of 512MiB DIMMs,
so max for this machine is 1 GiB.

> +    pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
> +                             0, 0x1000000);
> +    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
> +                             0x80000000, 0x7d000000);
> +    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
> +    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
> +
> +    /* VIA VT82c686B South Bridge (multifunction PCI device) */
> +    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
> +                                                 TYPE_VT82C686B_ISA));
> +    object_property_add_alias(OBJECT(machine), "rtc-time",
> +                              object_resolve_path_component(via, "rtc"),
> +                              "date");
> +    qdev_connect_gpio_out(DEVICE(via), 0,
> +                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
> +                                                             "pirq", i));
> +    }
> +    pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
> +    pci_vga_init(pci_bus);
> +}


