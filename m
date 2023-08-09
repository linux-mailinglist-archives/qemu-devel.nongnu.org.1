Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BE775404
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 09:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTdXK-00084T-8d; Wed, 09 Aug 2023 03:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qTdX5-000844-Mx
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:23:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qTdWx-0004YD-M1
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 03:23:03 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxXeurPtNkt6QTAA--.37698S3;
 Wed, 09 Aug 2023 15:22:19 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPCOqPtNked1QAA--.53334S3; 
 Wed, 09 Aug 2023 15:22:18 +0800 (CST)
Subject: Re: [PATCH 5/8] Adds basic CPU hot-(un)plug support for Loongarch
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
 <e5b1c3347538e518b50d6eced570202d076bec72.1689837093.git.lixianglai@loongson.cn>
 <20230728152147.010fb677@imammedo.users.ipa.redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <0f9c8ec9-34bf-51a9-83df-84b3316d4caa@loongson.cn>
Date: Wed, 9 Aug 2023 15:22:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230728152147.010fb677@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxPCOqPtNked1QAA--.53334S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfZFyxCF4UZw17Kw4DtFW7ZFc_yoW8KFW8Jo
 WfJF13Kay8Jry7GFyqk3sxt3y7G3W09anxAF95uw17uanrta1Ygr15Ja1vqa1fGFs8trW7
 Jas2qr13AFy7Aw1fl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
 43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UR
 a0PUUUUU=
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

On 7/28/23 9:21 PM, Igor Mammedov wrote:
> On Thu, 20 Jul 2023 15:15:10 +0800
> xianglai li <lixianglai@loongson.cn> wrote:
>
>> 1.Add CPU topology related functions
>> 2.Add CPU hot-plug related hook functions
>> 3.Update the in-place CPU creation process at machine initialization
> patch is to large, split it at least on those ^^ 3 parts,
> which would do a single distinct thing.
> After that it will be easier to review this.


Ok, I'll split this patch further.


>
> Also looking at hw/loongarch/acpi-build.c
> you have cpu_index == arch_id == core_id /according to comments/
> and they are mixed/used interchangeably. which is confusing
> at least. So clean it up first to use arch_id consistently
>
> then a separate patches to introduce socket/core/thread support
> with proper documentation/pointers to specs as to how arch_id
> should be calculated.
>
> And once that is ready, add hotplug on top of it.
>

Okay, I'll do it according to your suggestion.


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
>>   hw/loongarch/virt.c         | 381 ++++++++++++++++++++++++++++++++++--
>>   include/hw/loongarch/virt.h |  11 +-
>>   target/loongarch/cpu.h      |   4 +
>>   3 files changed, 382 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index e19b042ce8..5919389f42 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -46,6 +46,9 @@
>>   #include "hw/block/flash.h"
>>   #include "qemu/error-report.h"
>>   
>> +static int virt_get_socket_id(const MachineState *ms, int cpu_index);
>> +static int virt_get_core_id(const MachineState *ms, int cpu_index);
>> +static int virt_get_thread_id(const MachineState *ms, int cpu_index);
>>   
>>   static void virt_flash_create(LoongArchMachineState *lams)
>>   {
>> @@ -447,12 +450,12 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
>>   {
>>       DeviceState *dev;
>>       MachineState *ms = MACHINE(lams);
>> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_CPU_HOTPLUG_EVT;
>>   
>>       if (ms->ram_slots) {
>>           event |= ACPI_GED_MEM_HOTPLUG_EVT;
>>       }
>> -    dev = qdev_new(TYPE_ACPI_GED);
>> +    dev = qdev_new(TYPE_ACPI_GED_LOONGARCH);
>>       qdev_prop_set_uint32(dev, "ged-event", event);
>>   
>>       /* ged event */
>> @@ -461,6 +464,7 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, VIRT_GED_MEM_ADDR);
>>       /* ged regs used for reset and power down */
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
>>   
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>>                          qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
>> @@ -583,6 +587,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>>   
>>       extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
>> +    lams->extioi = extioi;
>>   
>>       /*
>>        * The connection of interrupts:
>> @@ -624,11 +629,11 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>>                                       sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
>>                                       1));
>>           /*
>> -	 * extioi iocsr memory region
>> -	 * only one extioi is added on loongarch virt machine
>> -	 * external device interrupt can only be routed to cpu 0-3
>> -	 */
>> -	if (cpu < EXTIOI_CPUS)
>> +         * extioi iocsr memory region
>> +         * only one extioi is added on loongarch virt machine
>> +         * external device interrupt can only be routed to cpu 0-3
>> +         */
>> +        if (cpu < EXTIOI_CPUS)
>>               memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
>>                                   sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
>>                                   cpu));
>> @@ -789,7 +794,6 @@ static void loongarch_init(MachineState *machine)
>>       NodeInfo *numa_info = machine->numa_state->nodes;
>>       int i;
>>       hwaddr fdt_base;
>> -    const CPUArchIdList *possible_cpus;
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       CPUState *cpu;
>>       char *ramName = NULL;
>> @@ -810,12 +814,40 @@ static void loongarch_init(MachineState *machine)
>>       create_fdt(lams);
>>       /* Init CPUs */
>>   
>> -    possible_cpus = mc->possible_cpu_arch_ids(machine);
>> -    for (i = 0; i < possible_cpus->len; i++) {
>> -        cpu = cpu_create(machine->cpu_type);
>> +    mc->possible_cpu_arch_ids(machine);
>> +
>> +    for (i = 0; i < machine->smp.cpus; i++) {
>> +        Object *cpuobj;
>> +        cpuobj = object_new(machine->cpu_type);
>> +
>> +        cpu = CPU(cpuobj);
>>           cpu->cpu_index = i;
> I'd move this to foo_cpu_pre_plug()

I guess I don't need to assign a value to the cpu->cpu_index,

it should be automatically assigned to the cpu_exec_realizefn->cpu_list_add.

I'll remove it in the next release.


>
>> -        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
> and this to foo_cpu_plug()	


Yes, it's already inside, this one is to remove the line of code.


>> +
>> +        object_property_set_int(cpuobj, "socket-id",
>> +                                virt_get_socket_id(machine, i), NULL);
>> +        object_property_set_int(cpuobj, "core-id",
>> +                                virt_get_core_id(machine, i), NULL);
>> +        object_property_set_int(cpuobj, "thread-id",
>> +                                virt_get_thread_id(machine, i), NULL);
> you don't need to calculate foo_ids here, they shall be calculated once at
> the 1st time possible_cpu_arch_ids() are called and then reuse
> CPUArchId.props here.
> see x86_possible_cpu_arch_ids() for an example
>

Yes, I'm not calculating the foo_ids here, I'm just taking the value 
from the possible_cpu_arch_ids

and reusing it to assign the property of the cpuobj.


>> +        /*
>> +         * The CPU in place at the time of machine startup will also enter
>> +         * the CPU hot-plug process when it is created, but at this time,
>> +         * the GED device has not been created, resulting in exit in the CPU
>> +         * hot-plug process, which can avoid the incumbent CPU repeatedly
>> +         * applying for resources.
>> +         *
>> +         * The interrupt resource of the in-place CPU will be requested at
>> +         * the current function call loongarch_irq_init().
>> +         *
>> +         * The interrupt resource of the subsequently inserted CPU will be
>> +         * requested in the CPU hot-plug process.
>> +         */
>> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>> +        object_unref(cpuobj);
>>       }
>> +
>> +    lams->boot_cpus = machine->smp.cpus;
>> +
>>       fdt_add_cpu_nodes(lams);
>>   
>>       /* Node0 memory */
>> @@ -986,11 +1018,107 @@ static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>       pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>>   }
>>   
>> +static int virt_get_cpu_id_from_cpu_topo(const MachineState *ms,
>> +                                            DeviceState *dev)
> name suggest it's topo->id helper,
> then feed it topo arguments instead of dev.


Ok!


>> +{
>> +    int cpu_index, sock_vcpu_num, core_vcpu_num;
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +
>> +    /* calculate total logical cpus across socket/cluster/core */
>> +    sock_vcpu_num = cpu->socket_id * (ms->smp.threads * ms->smp.cores);
>> +    core_vcpu_num = cpu->core_id * ms->smp.threads;
>> +
>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
>> +    cpu_index = (sock_vcpu_num + core_vcpu_num) + cpu->thread_id;
>> +
>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>> +
>> +    return cpu_index;
>> +}
>> +
>> +/* find cpu slot in machine->possible_cpus by core_id */
>> +static CPUArchId *loongarch_find_cpu_slot(MachineState *ms, uint32_t cpu_index,
>> +                                        int *idx)
>> +{
>> +    int index = cpu_index;
>> +
>> +    if (index >= ms->possible_cpus->len) {
>> +        return NULL;
>> +    }
>> +    if (idx) {
>> +        *idx = index;
>> +    }
>> +    return &ms->possible_cpus->cpus[index];
>> +}
>> +
>> +static void loongarch_cpu_pre_plug(HotplugHandler *hotplug_dev,
>> +                            DeviceState *dev, Error **errp)
>> +{
>> +    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
>> +    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    CPUState *cs = CPU(dev);
>> +    CPUArchId *cpu_slot;
>> +    Error *local_err = NULL;
>> +
>> +    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
>> +        error_setg(&local_err, "CPU hotplug not supported for this machine");
>> +        goto out;
>> +    }
>> +
>> +    /* sanity check the cpu */
>> +    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
>> +        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s'",
>> +                   ms->cpu_type);
>> +        goto out;
>> +    }
>> +
>> +    if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
>> +        error_setg(&local_err,
>> +                   "Invalid thread-id %u specified, must be in range 1:%u",
>> +                   cpu->thread_id, ms->smp.threads - 1);
>> +        goto out;
>> +    }
>> +
>> +    if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>> +        error_setg(&local_err,
>> +                   "Invalid core-id %u specified, must be in range 1:%u",
>> +                   cpu->core_id, ms->smp.cores);
>> +        goto out;
>> +    }
>> +
>> +    if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>> +        error_setg(&local_err,
>> +                   "Invalid socket-id %u specified, must be in range 1:%u",
>> +                   cpu->socket_id, ms->smp.sockets - 1);
>> +        goto out;
>> +    }
>> +    cs->cpu_index = virt_get_cpu_id_from_cpu_topo(ms, dev);
>> +
>> +    cpu_slot = loongarch_find_cpu_slot(ms, cs->cpu_index, NULL);
>> +    if (CPU(cpu_slot->cpu)) {
>> +        error_setg(&local_err,
>> +                   "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>> +                   cs->cpu_index, cpu->socket_id, cpu->core_id,
>> +                   cpu->thread_id, cpu_slot->arch_id);
>> +        goto out;
>> +    }
>> +
>> +    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
>> +
>> +    return ;
>> +out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>>   static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>>                                               DeviceState *dev, Error **errp)
>>   {
>>       if (memhp_type_supported(dev)) {
>>           virt_mem_pre_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
>> +        loongarch_cpu_pre_plug(hotplug_dev, dev, errp);
>>       }
>>   }
>>   
>> @@ -1004,11 +1132,45 @@ static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
>>                                      errp);
>>   }
>>   
>> +static void loongarch_cpu_unplug_request(HotplugHandler *hotplug_dev,
>> +                                        DeviceState *dev, Error **errp)
>> +{
>> +    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
>> +    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
>> +    Error *local_err = NULL;
>> +    HotplugHandlerClass *hhc;
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    CPUState *cs = CPU(dev);
>> +
>> +    if (!lsms->acpi_ged) {
>> +        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
>> +        goto out;
>> +    }
>> +
>> +    if (cs->cpu_index == 0) {
>> +        error_setg(&local_err,
>> +                   "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
>> +                   cs->cpu_index, cpu->socket_id,
>> +                   cpu->core_id, cpu->thread_id);
>> +        goto out;
>> +    }
>> +
>> +
>> +    hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
>> +    hhc->unplug_request(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
>> +
>> +    return;
>> + out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>>   static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>>                                             DeviceState *dev, Error **errp)
>>   {
>>       if (memhp_type_supported(dev)) {
>>           virt_mem_unplug_request(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
>> +        loongarch_cpu_unplug_request(hotplug_dev, dev, errp);
>>       }
>>   }
>>   
>> @@ -1022,11 +1184,93 @@ static void virt_mem_unplug(HotplugHandler *hotplug_dev,
>>       qdev_unrealize(dev);
>>   }
>>   
>> +static void loongarch_cpu_destroy(MachineState *machine, LoongArchCPU *cpu)
> I'd fold this into unplug handler, and the same for _cpu_create
> you aren't destroying/creating CPU at this point but rather
> wiring it up with other external to it components.


What do you think about giving it a different name,

putting it inside the unplug handler will cause the unplug handler 
function to be too long?


>> +{
>> +    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
>> +    CPULoongArchState *env = &cpu->env;
>> +    DeviceState *ipi = env->ipistate;
>> +    CPUState *cs = CPU(cpu);
>> +    unsigned int cpu_index = cs->cpu_index;
>> +    DeviceState *extioi = lsms->extioi;
>> +    int pin;
>> +
>> +    qemu_unregister_reset(reset_load_elf, DEVICE(cpu));
>> +
>> +    lsms->boot_cpus--;
>> +    if (lsms->fw_cfg) {
>> +        fw_cfg_modify_i16(lsms->fw_cfg, FW_CFG_NB_CPUS,
>> +                          (uint16_t)lsms->boot_cpus);
>> +    }
> do you really need boot_cpus?
> adding FWCFG variable is adding ABI, with potential to maintain it for a long time
>
> it seems that before this series you also had support for multiple CPUs
> and didn't care about FWCFG, so quest is why it's being added now.


I looked up this fw_cfg about the number of CPUs we really don't need 
it, I'll delete it.

>> +
>> +    /* disconnect ipi irq to cpu irq */
>> +    qdev_disconnect_gpio_out_named(ipi, NULL, 0);
>> +    /* del IPI iocsr memory region */
>> +    memory_region_del_subregion(&env->system_iocsr,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
>> +                                0));
>> +    memory_region_del_subregion(&env->system_iocsr,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
>> +                                1));
>> +
>> +    env->ipistate = NULL;
>> +    object_unparent(OBJECT(ipi));
>> +
>> +    /*
>> +     * disconnect ext irq to the cpu irq
>> +     * cpu_pin[9:2] <= intc_pin[7:0]
>> +     */
>> +    if (cpu_index < EXTIOI_CPUS) {
>> +        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
>> +            qdev_disconnect_gpio_out_named(extioi, NULL, (cpu_index * 8 + pin));
>> +        }
>> +    }
>> +
>> +    /*
>> +     * del extioi iocsr memory region
>> +     * only one extioi is added on loongarch virt machine
>> +     * external device interrupt can only be routed to cpu 0-3
>> +     */
>> +    if (cpu_index < EXTIOI_CPUS)
>> +        memory_region_del_subregion(&env->system_iocsr,
>> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
>> +                            cpu_index));
>> +}
>> +
>> +static void loongarch_cpu_unplug(HotplugHandler *hotplug_dev,
>> +                                DeviceState *dev, Error **errp)
>> +{
>> +    CPUArchId *found_cpu;
>> +    HotplugHandlerClass *hhc;
>> +    Error *local_err = NULL;
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
>> +    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
>> +    CPUState *cs = CPU(dev);
>> +
>> +    hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
>> +    hhc->unplug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
>> +
>> +    if (local_err) {
>> +        goto out;
>> +    }
>> +
>> +    loongarch_cpu_destroy(machine, cpu);
>> +
>> +    found_cpu = loongarch_find_cpu_slot(MACHINE(lsms), cs->cpu_index, NULL);
>> +    found_cpu->cpu = NULL;
>> +
>> +    return;
>> +out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>>   static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
>>                                             DeviceState *dev, Error **errp)
>>   {
>>       if (memhp_type_supported(dev)) {
>>           virt_mem_unplug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
>> +        loongarch_cpu_unplug(hotplug_dev, dev, errp);
>>       }
>>   }
>>   
>> @@ -1040,6 +1284,92 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
>>                            dev, &error_abort);
>>   }
>>   
>> +
>> +static LoongArchCPU *loongarch_cpu_create(MachineState *machine,
>> +                                LoongArchCPU *cpu, Error **errp)
>> +{
>> +    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
>> +    CPUState *cs = CPU(cpu);
>> +    unsigned int cpu_index = cs->cpu_index;
>> +    DeviceState *cpudev = DEVICE(cpu);
>> +    DeviceState *extioi = lsms->extioi;
>> +    CPULoongArchState *env = &cpu->env;
>> +    DeviceState *ipi;
>> +    int pin;
>> +
>> +    qemu_register_reset(reset_load_elf, cpu);
>> +
>> +    lsms->boot_cpus++;
>> +    if (lsms->fw_cfg) {
>> +        fw_cfg_modify_i16(lsms->fw_cfg, FW_CFG_NB_CPUS,
>> +                          (uint16_t)lsms->boot_cpus);
>> +    }
>> +
>> +    ipi = qdev_new(TYPE_LOONGARCH_IPI);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), errp);
>> +
>> +    /* connect ipi irq to cpu irq */
>> +    qdev_connect_gpio_out(ipi, 0, qdev_get_gpio_in(cpudev, IRQ_IPI));
>> +    /* IPI iocsr memory region */
>> +    memory_region_add_subregion(&env->system_iocsr, SMP_IPI_MAILBOX,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
>> +                                0));
>> +    memory_region_add_subregion(&env->system_iocsr, MAIL_SEND_ADDR,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
>> +                                1));
>> +    /*
>> +     * extioi iocsr memory region
>> +     * only one extioi is added on loongarch virt machine
>> +     * external device interrupt can only be routed to cpu 0-3
>> +     */
>> +    if (cpu_index < EXTIOI_CPUS)
>> +        memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
>> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
>> +                            cpu_index));
>> +    env->ipistate = ipi;
>> +
>> +    /*
>> +     * connect ext irq to the cpu irq
>> +     * cpu_pin[9:2] <= intc_pin[7:0]
>> +     */
>> +    if (cpu_index < EXTIOI_CPUS) {
>> +        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
>> +            qdev_connect_gpio_out(extioi, (cpu_index * 8 + pin),
>> +                                  qdev_get_gpio_in(cpudev, pin + 2));
>> +        }
>> +    }
>> +
>> +    return cpu;
>> +}
>> +
>> +static void loongarch_cpu_plug(HotplugHandler *hotplug_dev,
>> +                                DeviceState *dev, Error **errp)
>> +{
>> +    CPUArchId *found_cpu;
>> +    HotplugHandlerClass *hhc;
>> +    Error *local_err = NULL;
>> +    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
>> +    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    CPUState *cs = CPU(dev);
>> +
>> +    if (lsms->acpi_ged) {
> dont' you need CPUs if you don't have ged?
> /is it possible that ged doesn't exists?/

For those CPUs that are already in place at startup, their 
initialization predates the initialization of the GED,

and the initialization of these CPUs is done in the loongarch_irq_init 
function,

but I feel that this is somewhat redundant and I will integrate them in 
the CPU plug handler in the next version of the patch.



>
>> +        loongarch_cpu_create(machine, cpu, errp);
>> +        hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
>> +        hhc->plug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
>> +        if (local_err) {
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    found_cpu = loongarch_find_cpu_slot(MACHINE(lsms), cs->cpu_index, NULL);
>> +    found_cpu->cpu = OBJECT(dev);
>> +
>> +    return;
>> +out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>>   static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                           DeviceState *dev, Error **errp)
>>   {
>> @@ -1053,6 +1383,8 @@ static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>           }
>>       } else if (memhp_type_supported(dev)) {
>>           virt_mem_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
>> +        loongarch_cpu_plug(hotplug_dev, dev, errp);
>>       }
>>   }
>>   
>> @@ -1062,16 +1394,39 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>   
>>       if (device_is_dynamic_sysbus(mc, dev) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
>>           memhp_type_supported(dev)) {
>>           return HOTPLUG_HANDLER(machine);
>>       }
>>       return NULL;
>>   }
>>   
>> +static int virt_get_socket_id(const MachineState *ms, int cpu_index)
>> +{
>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>> +
>> +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
>> +}
>> +
>> +static int virt_get_core_id(const MachineState *ms, int cpu_index)
>> +{
>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>> +
>> +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
>> +}
>> +
>> +static int virt_get_thread_id(const MachineState *ms, int cpu_index)
>> +{
>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>> +
>> +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
>> +}
>> +
>>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>   {
>>       int n;
>>       unsigned int max_cpus = ms->smp.max_cpus;
>> +    unsigned int smp_threads = ms->smp.threads;
>>   
>>       if (ms->possible_cpus) {
>>           assert(ms->possible_cpus->len == max_cpus);
>> @@ -1082,6 +1437,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>                                     sizeof(CPUArchId) * max_cpus);
>>       ms->possible_cpus->len = max_cpus;
>>       for (n = 0; n < ms->possible_cpus->len; n++) {
>> +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
>>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>>           ms->possible_cpus->cpus[n].arch_id = n;
>>   
>> @@ -1125,6 +1481,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>>       MachineClass *mc = MACHINE_CLASS(oc);
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>   
>> +    mc->has_hotpluggable_cpus = true;
>>       mc->desc = "Loongson-3A5000 LS7A1000 machine";
>>       mc->init = loongarch_init;
>>       mc->default_ram_size = 1 * GiB;
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index f1659655c6..9ebdba676e 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -31,6 +31,7 @@
>>   #define VIRT_GED_EVT_ADDR       0x100e0000
>>   #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
>>   #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
>> +#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_CPU_HOTPLUG_REG_LEN)
>>   
>>   struct LoongArchMachineState {
>>       /*< private >*/
>> @@ -42,7 +43,7 @@ struct LoongArchMachineState {
>>       MemoryRegion bios;
>>       bool         bios_loaded;
>>       /* State for other subsystems/APIs: */
>> -    FWCfgState  *fw_cfg;
>> +    FWCfgState   *fw_cfg;
>>       Notifier     machine_done;
>>       Notifier     powerdown_notifier;
>>       OnOffAuto    acpi;
>> @@ -50,13 +51,19 @@ struct LoongArchMachineState {
>>       char         *oem_table_id;
>>       DeviceState  *acpi_ged;
>>       int          fdt_size;
>> -    DeviceState *platform_bus_dev;
>> +    DeviceState  *platform_bus_dev;
>>       PCIBus       *pci_bus;
>>       PFlashCFI01  *flash;
>> +    DeviceState  *extioi;
>> +    unsigned int boot_cpus;
>>   };
>>   
>>   #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
>>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
>>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>>   void loongarch_acpi_setup(LoongArchMachineState *lams);
>> +void virt_madt_cpu_entry(int uid,
>> +                         const CPUArchIdList *apic_ids, GArray *entry,
>> +                         bool force_enabled);
>> +
>>   #endif
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index ed04027af1..f4439c245f 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -367,6 +367,10 @@ struct ArchCPU {
>>       CPUState parent_obj;
>>       /*< public >*/
>>   
>> +    int32_t socket_id;  /* socket-id of this VCPU */
>> +    int32_t core_id;    /* core-id of this VCPU */
>> +    int32_t thread_id;  /* thread-id of this VCPU */
>> +    int32_t node_id;    /* NUMA node this CPU belongs to */
>>       CPUNegativeOffsetState neg;
>>       CPULoongArchState env;
>>       QEMUTimer timer;


