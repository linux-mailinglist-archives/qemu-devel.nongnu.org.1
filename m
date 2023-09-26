Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A397AEC69
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql70f-000269-8g; Tue, 26 Sep 2023 08:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ql709-0001FC-N9
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:17:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1ql706-0001hd-2G
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:17:16 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Cx5_HHyxJl4bEsAA--.19737S3;
 Tue, 26 Sep 2023 20:17:11 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx+y7GyxJlNrwSAA--.1887S2; 
 Tue, 26 Sep 2023 20:17:10 +0800 (CST)
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <3922235e-4774-c3dc-64dc-2fb8d580b32d@loongson.cn>
Date: Tue, 26 Sep 2023 20:17:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx+y7GyxJlNrwSAA--.1887S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF1fArW5Zr1rKF48Xw48KrX_yoWxuFyrpa
 9xAF4a9rWDXr4UZ3WSqa42yas8Xw4kG34xZ397Kr9aka4jk3s3Cr4Yga1UZFy2yw1IgF4x
 ur1Yg3Wku3W5AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDU
 UUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Hi  Salil Mehta via :

> Hi Xianglai,
> FYI. RFC V2 is out and you can now drop the arch agnostic patches from
> your patch-set. Please check the details in the cover letter which one
> you need to pick and rebase from:
>
> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/T/#t
>
> I am planning to float the architecture agnostic patch-set within this
> week which will have same patches and in same order as mentioned in
> the cover letter. This will untie the development across different
> architectures.


Very Good!

Looking forward to the release of your architecture-independent patches.

I will remove the first two patches in the next version.

Thanks,

Xianglai.


>
> Many thanks
> Salil.
>
>> From: xianglai li <lixianglai@loongson.cn>
>> Sent: Tuesday, September 26, 2023 10:54 AM
>> To: qemu-devel@nongnu.org
>> Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
>> <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>; Xiaojuan
>> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>> Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo Mao
>> <maobibo@loongson.cn>
>> Subject: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
>>
>> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch
>> is based on PCI and is IO port based and hence existing cpus AML code
>> assumes _CRS objects would evaluate to a system resource which describes
>> IO Port address.
>> But on Loongarch arch CPUs control device(\\_SB.PRES) register interface
>> is memory-mapped hence _CRS object should evaluate to system resource
>> which describes memory-mapped base address.
>>
>> This cpus AML code change updates the existing interface of the build cpus
>> AML
>> function to accept both IO/MEMORY type regions and update the _CRS object
>> correspondingly.
>>
>> Co-authored-by: "Bernhard Beschow" <shentey@gmail.com>
>> Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
>> Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
>> Cc: "Bernhard Beschow" <shentey@gmail.com>
>> Cc: "Salil Mehta" <salil.mehta@huawei.com>
>> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
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
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/acpi/cpu.c         | 20 +++++++++++++++-----
>>   hw/i386/acpi-build.c  |  3 ++-
>>   include/hw/acpi/cpu.h |  5 +++--
>>   3 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index 5bad983928..0afa04832e 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -6,6 +6,7 @@
>>   #include "qapi/qapi-events-acpi.h"
>>   #include "trace.h"
>>   #include "sysemu/numa.h"
>> +#include "hw/acpi/cpu_hotplug.h"
>>
>>   #define OVMF_CPUHP_SMI_CMD 4
>>
>> @@ -332,9 +333,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
>>   #define CPU_FW_EJECT_EVENT "CEJF"
>>
>>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures
>> opts,
>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr mmap_io_base,
>>                       const char *res_root,
>> -                    const char *event_handler_method)
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs)
>>   {
>>       Aml *ifctx;
>>       Aml *field;
>> @@ -359,14 +361,22 @@ void build_cpus_aml(Aml *table, MachineState
>> *machine, CPUHotplugFeatures opts,
>>           aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>>
>>           crs = aml_resource_template();
>> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
>> +        if (rs == AML_SYSTEM_IO) {
>> +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base,
>> mmap_io_base, 1,
>>                                  ACPI_CPU_HOTPLUG_REG_LEN));
>> +        } else {
>> +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
>> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
>> +        }
>> +
>>           aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>>
>> +        g_assert(rs == AML_SYSTEM_IO || rs == AML_SYSTEM_MEMORY);
>>           /* declare CPU hotplug MMIO region with related access fields */
>>           aml_append(cpu_ctrl_dev,
>> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
>> -                                 ACPI_CPU_HOTPLUG_REG_LEN));
>> +            aml_operation_region("PRST", rs,
>> +                                         aml_int(mmap_io_base),
>> +                                         ACPI_CPU_HOTPLUG_REG_LEN));
>>
>>           field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
>>                             AML_WRITE_AS_ZEROS);
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 863a939210..7016205d15 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>>           };
>>           build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
>> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
>> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
>> +                       AML_SYSTEM_IO);
>>       }
>>
>>       if (pcms->memhp_io_base && nr_mem) {
>> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
>> index bc901660fb..601f644e57 100644
>> --- a/include/hw/acpi/cpu.h
>> +++ b/include/hw/acpi/cpu.h
>> @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const
>> CPUArchIdList *apic_ids,
>>                                     GArray *entry, bool force_enabled);
>>
>>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures
>> opts,
>> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr mmap_io_base,
>>                       const char *res_root,
>> -                    const char *event_handler_method);
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs);
>>
>>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
>> ***list);
>>
>> --
>> 2.39.1
>>


