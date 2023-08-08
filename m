Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B892773A22
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLmM-0002A9-Qw; Tue, 08 Aug 2023 08:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qTLlz-00027G-1n
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:25:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qTLlv-0000Aj-Bs
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:25:14 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxqOghNNJkKtkSAA--.5792S3;
 Tue, 08 Aug 2023 20:25:05 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxrM4gNNJk9PlOAA--.2459S3; 
 Tue, 08 Aug 2023 20:25:04 +0800 (CST)
Subject: Re: [PATCH 7/8] Update the ACPI table for the Loongarch CPU
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <c5caccd85916783d4682b34d6c4011aaa342d73a.1689837093.git.lixianglai@loongson.cn>
 <20230728152655.1b941ee4@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <28a3f318-af65-fa68-6a91-9c1268ccc9ca@loongson.cn>
Date: Tue, 8 Aug 2023 20:25:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728152655.1b941ee4@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxrM4gNNJk9PlOAA--.2459S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF15Gw43KF4DGFW3Aw1fAFc_yoWxZw17pF
 y7AFs8tF4kJr13A390v3s8uFn5Xr4kGr42vFsrKr92kF97Kw18JF18tr43uF9rJw1xWF1v
 vr10q3W7WF4xJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l3
 8UUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

Hi Igor Mammedov:


On 7/28/23 9:26 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:12 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> 1.Create a new GED device type for Loongarch,
>> mount cpu_madt function to update the ACPI table
> madt changes should be its own patch


Okay, I'll put the Madt-related changes into a separate patch.


Thanks,

xianglai

>> 2.Update the APIC table for loongarch based on
>> CPU information to support CPU hot-(un)plug
>>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Ani Sinha <anisinha@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Yanan Wang <wangyanan55@huawei.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/acpi/acpi-cpu-hotplug-stub.c               |  9 +++++
>>   hw/loongarch/acpi-build.c                     | 35 ++++++++++++++++--
>>   hw/loongarch/generic_event_device_loongarch.c | 36 +++++++++++++++++++
>>   hw/loongarch/meson.build                      |  2 +-
>>   4 files changed, 79 insertions(+), 3 deletions(-)
>>   create mode 100644 hw/loongarch/generic_event_device_loongarch.c
>>
>> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
>> index 2aec90d968..af9fda2cf4 100644
>> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
>> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
>> @@ -19,6 +19,15 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>>       return;
>>   }
>>   
>> +void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>> +                    hwaddr mmap_io_base,
>> +                    const char *res_root,
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs)
>> +{
>> +    return;
>> +}
>> +
>>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>>   {
>>       return;
>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>> index 0b62c3a2f7..312908fb2f 100644
>> --- a/hw/loongarch/acpi-build.c
>> +++ b/hw/loongarch/acpi-build.c
>> @@ -46,6 +46,23 @@
>>   #define ACPI_BUILD_DPRINTF(fmt, ...)
>>   #endif
>>   
>> +void virt_madt_cpu_entry(int uid,
>> +                         const CPUArchIdList *apic_ids,
>> +                         GArray *entry, bool force_enabled)
>> +{
>> +    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
>> +    /* Flags – Local APIC Flags */
>> +    uint32_t flags = apic_ids->cpus[uid].cpu != NULL || force_enabled ?
>> +                     1 /* Enabled */ : 0;
>> +
>> +    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
>> +    build_append_int_noprefix(entry, 0, 1);       /* Type */
>> +    build_append_int_noprefix(entry, 8, 1);       /* Length */
>> +    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
>> +    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */
>> +    build_append_int_noprefix(entry, flags, 4); /* Flags */
>> +}
>> +
>>   /* build FADT */
>>   static void init_common_fadt_data(AcpiFadtData *data)
>>   {
>> @@ -121,15 +138,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>>       build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>>   
>>       for (i = 0; i < arch_ids->len; i++) {
>> +        uint32_t flags;
>> +
>>           /* Processor Core Interrupt Controller Structure */
>>           arch_id = arch_ids->cpus[i].arch_id;
>> +        flags = arch_ids->cpus[i].cpu ? 1 : 0;
>>   
>>           build_append_int_noprefix(table_data, 17, 1);    /* Type */
>>           build_append_int_noprefix(table_data, 15, 1);    /* Length */
>>           build_append_int_noprefix(table_data, 1, 1);     /* Version */
>> -        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
>> +        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>>           build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>> -        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>> +        build_append_int_noprefix(table_data, flags, 4);   /* Flags */
>>       }
>>   
>>       /* Extend I/O Interrupt Controller Structure */
>> @@ -292,6 +312,17 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>>                                    AML_SYSTEM_MEMORY,
>>                                    VIRT_GED_MEM_ADDR);
>>       }
>> +
>> +    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
>> +        CPUHotplugFeatures opts = {
>> +            .acpi_1_compatible = false,
>> +            .has_legacy_cphp = false
>> +        };
>> +
>> +        build_cpus_aml(dsdt, machine, opts, VIRT_GED_CPUHP_ADDR,
>> +                       "\\_SB", "\\_GPE._E01", AML_SYSTEM_MEMORY);
>> +
>> +    }
>>       acpi_dsdt_add_power_button(dsdt);
>>   }
>>   
>> diff --git a/hw/loongarch/generic_event_device_loongarch.c b/hw/loongarch/generic_event_device_loongarch.c
>> new file mode 100644
>> index 0000000000..1fe550239b
>> --- /dev/null
>> +++ b/hw/loongarch/generic_event_device_loongarch.c
>> @@ -0,0 +1,36 @@
>> +/*
>> + * loongarch variant of the generic event device for hw reduced acpi
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/generic_event_device.h"
>> +#include "hw/loongarch/virt.h"
>> +
>> +static void acpi_ged_loongarch_class_init(ObjectClass *class, void *data)
>> +{
>> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
>> +
>> +    adevc->madt_cpu = virt_madt_cpu_entry;
>> +}
>> +
>> +static const TypeInfo acpi_ged_loongarch_info = {
>> +    .name          = TYPE_ACPI_GED_LOONGARCH,
>> +    .parent        = TYPE_ACPI_GED,
>> +    .class_init    = acpi_ged_loongarch_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_HOTPLUG_HANDLER },
>> +        { TYPE_ACPI_DEVICE_IF },
>> +        { }
>> +    }
>> +};
>> +
>> +static void acpi_ged_loongarch_register_types(void)
>> +{
>> +    type_register_static(&acpi_ged_loongarch_info);
>> +}
>> +
>> +type_init(acpi_ged_loongarch_register_types)
>> diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
>> index c0421502ab..8d21addee3 100644
>> --- a/hw/loongarch/meson.build
>> +++ b/hw/loongarch/meson.build
>> @@ -3,6 +3,6 @@ loongarch_ss.add(files(
>>       'fw_cfg.c',
>>   ))
>>   loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
>> -loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
>> +loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c', 'generic_event_device_loongarch.c'))
>>   
>>   hw_arch += {'loongarch': loongarch_ss}


