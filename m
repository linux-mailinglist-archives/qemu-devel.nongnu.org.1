Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413AA836336
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 13:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRtPh-0001f2-2d; Mon, 22 Jan 2024 07:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRtPf-0001eg-BY
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:28:27 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRtPd-00022Y-5q
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 07:28:27 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1072F3FD9F
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705926501;
 bh=NWAyyWMMkHgiB7rsdHdk3aSWgcZ+zlAGNJ8OWJyQEkU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qH3zuPbXzl5xrdCMOk7BHPDp2M8N5YH+GiQ14qYvpeNpF7Mjn6FYVB23QAh0RAIHB
 or5kJqC1ezYIi4BMSGhZCAQuqHz+N3xHP2WDm8vW5UqPjDInFfINUOv3D4m/Zwtbll
 rRY5JpIdRRqu98vBWJzth5q4xUT7iOeYxbK6Elp4NUXDG5+b/PfvxrvRjsV/0B91XI
 /PFNY+5g9SBviyhnBk+gbUdQ6G1uxhxPofmKvM2iwUv0IWEh5WoMex9qSy4WZ7Zd5S
 DN3kLL3zlV/NFty9TBWlBJNflLNK7wbmZCe5ceDw3Axa51lw7MzPK9RpznrTswfa1i
 W1BvSsQcYHBHw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33932e8b3e6so694749f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 04:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705926500; x=1706531300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWAyyWMMkHgiB7rsdHdk3aSWgcZ+zlAGNJ8OWJyQEkU=;
 b=papG7YkazbJN2ifMKf7wIBeJPzJoZ84m6wmmul22b8pkiyRH/WZ2ioGiWsfzomma3V
 T9Z3CxDabwMslw5pBC1Z5OmGC/ykMOZBpmrkl+gyTPSL2+87hOgsZYQT6JpqaxDJEI1I
 2/QbUCs+i88viKuJmv4fYTGJB9d7Z2BBLD62uYnPDp8w7ttVhW+3u3n/AagytDGZ8WEr
 FOzf3DPNOAYngcWFW5Qzbsc4/6ChypLdPeHOOdUs2YZkUvh/jkz1PbjGtNkbRUyYsMy4
 FQ1TydoWvcOODWc2QNDUz3Z8ymdvzT/LV3UEXZeQR5/Dmn1vIDQakPf7ba/fLuwl8vHU
 59hQ==
X-Gm-Message-State: AOJu0Yy7YXeyOb0dpRUWXpAg0bHXk/JVk0trkomMtGeHzSZI4H7O08tW
 CsgV5Jau4KWzxBMQYzCJWcXpwZO5XNswJEhIFJKeDgWX47I6hY2cc0yaYWywMQ/Ib3ftan8VLoc
 GMnNx54fUG/TZKHGg1WB6YPv6u+T3Lq/qnyUpiIk1JgweRsi9hqEZQ2GP8ApRvuSS8f0H
X-Received: by 2002:a5d:44c6:0:b0:337:bded:898a with SMTP id
 z6-20020a5d44c6000000b00337bded898amr2401568wrr.0.1705926500582; 
 Mon, 22 Jan 2024 04:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGpExWY9en+QTFcKTO1lzrlPjTSp1FpMONE+h9V7dzHf8Y/CNmLL+yu7rTqC5/CfssnD5jqQ==
X-Received: by 2002:a5d:44c6:0:b0:337:bded:898a with SMTP id
 z6-20020a5d44c6000000b00337bded898amr2401551wrr.0.1705926499793; 
 Mon, 22 Jan 2024 04:28:19 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b00337d5aa55cdsm10692734wru.53.2024.01.22.04.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 04:28:19 -0800 (PST)
Message-ID: <22105210-d8d1-4808-b9ed-41eee71c53ca@canonical.com>
Date: Mon, 22 Jan 2024 13:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/riscv: SMBIOS support for RISC-V virt
 machine
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
 <20231229120724.41383-4-heinrich.schuchardt@canonical.com>
 <20240122-4f4cbce3692cd684e0409f9e@orel>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240122-4f4cbce3692cd684e0409f9e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.01.24 10:57, Andrew Jones wrote:
> On Fri, Dec 29, 2023 at 01:07:23PM +0100, Heinrich Schuchardt wrote:
>> Generate SMBIOS tables for the RISC-V mach-virt.
>> Add CONFIG_SMBIOS=y to the RISC-V default config.
>> Set the default processor family in the type 4 table.
>>
>> The implementation is based on the corresponding ARM and Loongson code.
>>
>> With the patch the following firmware tables are provided:
>>
>>      etc/smbios/smbios-anchor
>>      etc/smbios/smbios-tables
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>> 	set processor family
>> ---
>>   hw/riscv/Kconfig |  1 +
>>   hw/riscv/virt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index b6a5eb4452..1e11ac9432 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -41,6 +41,7 @@ config RISCV_VIRT
>>       select RISCV_IMSIC
>>       select SIFIVE_PLIC
>>       select SIFIVE_TEST
>> +    select SMBIOS
>>       select VIRTIO_MMIO
>>       select FW_CFG_DMA
>>       select PLATFORM_BUS
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index d2eac24156..a876dd8f34 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -36,6 +36,7 @@
>>   #include "hw/riscv/boot.h"
>>   #include "hw/riscv/numa.h"
>>   #include "kvm/kvm_riscv.h"
>> +#include "hw/firmware/smbios.h"
>>   #include "hw/intc/riscv_aclint.h"
>>   #include "hw/intc/riscv_aplic.h"
>>   #include "hw/intc/riscv_imsic.h"
>> @@ -1249,6 +1250,45 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
>>                                   sysbus_mmio_get_region(sysbus, 0));
>>   }
>>   
>> +static void virt_build_smbios(RISCVVirtState *s)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(s);
>> +    MachineState *ms = MACHINE(s);
>> +    uint8_t *smbios_tables, *smbios_anchor;
>> +    size_t smbios_tables_len, smbios_anchor_len;
>> +    struct smbios_phys_mem_area mem_array;
>> +    const char *product = "QEMU Virtual Machine";
>> +
>> +    if (kvm_enabled()) {
>> +        product = "KVM Virtual Machine";
>> +    }
>> +
>> +    smbios_set_defaults("QEMU", product, mc->name, false,
>> +                        true, SMBIOS_ENTRY_POINT_TYPE_64);
>> +
>> +#if defined(TARGET_RISCV32)
>> +    smbios_set_default_processor_family(0x200);
>> +#elif defined(TARGET_RISCV64)
>> +    smbios_set_default_processor_family(0x201);
>> +#endif
> 
> I think we should use misa_mxl_max to determine the family, rather than
> TARGET_*, because, iirc, we're slowly working our ways towards allowing
> rv32 cpus to be instantiated with qemu-system-riscv64.

Hello Andrew,

thank you for reviewing. I guess you mean something like:

     if (riscv_is_32bit(&s->soc[0])) {
         smbios_set_default_processor_family(0x200);
#if defined(TARGET_RISCV64)
     } else {
         smbios_set_default_processor_family(0x201);
#endif
     }

riscv_is_32bit returns harts->harts[0].env.misa_mxl_max == MXL_RV32.

Some real hardware has a 32bit hart and multiple 64bit harts. Will QEMU 
support mixing harts with different bitness on the virt machine in 
future? In that case we would have to revisit the code using 
misa_mxl_max in multiple places.

Best regards

Heinrich

> 
>> +
>> +    /* build the array of physical mem area from base_memmap */
>> +    mem_array.address = s->memmap[VIRT_DRAM].base;
>> +    mem_array.length = ms->ram_size;
>> +
>> +    smbios_get_tables(ms, &mem_array, 1,
>> +                      &smbios_tables, &smbios_tables_len,
>> +                      &smbios_anchor, &smbios_anchor_len,
>> +                      &error_fatal);
>> +
>> +    if (smbios_anchor) {
>> +        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-tables",
>> +                        smbios_tables, smbios_tables_len);
>> +        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-anchor",
>> +                        smbios_anchor, smbios_anchor_len);
>> +    }
>> +}
>> +
>>   static void virt_machine_done(Notifier *notifier, void *data)
>>   {
>>       RISCVVirtState *s = container_of(notifier, RISCVVirtState,
>> @@ -1337,6 +1377,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
>>           riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
>>       }
>>   
>> +    virt_build_smbios(s);
>> +
>>       if (virt_is_acpi_enabled(s)) {
>>           virt_acpi_setup(s);
>>       }
>> -- 
>> 2.43.0
>>
>>
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew


