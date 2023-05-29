Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D210B714875
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3avy-00058q-Sr; Mon, 29 May 2023 07:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q3ava-00055u-4R
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:20:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q3avP-0005Lh-6l
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:20:39 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Dx_+t3inRkODQCAA--.5040S3;
 Mon, 29 May 2023 19:20:24 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axo8B1inRkcNV+AA--.10757S3; 
 Mon, 29 May 2023 19:20:21 +0800 (CST)
Subject: Re: [PATCH v1] hw/loongarch: Add numa support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230518090651.187119-1-gaosong@loongson.cn>
 <156017ec-c185-7ea0-f96f-50d32a359ae4@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <6a384685-2f29-b4d2-5c51-1bd72f4e2f03@loongson.cn>
Date: Mon, 29 May 2023 19:20:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <156017ec-c185-7ea0-f96f-50d32a359ae4@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axo8B1inRkcNV+AA--.10757S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KFW5Aw45Gr1rKr4UWw15Jwb_yoW8GF17Go
 W7Kw1rJr15Jr1j9r1UGr4UXrW3WF1UGrnrtry8CrWfX3WIyF4UJ3yUJryDt3y7JF4kGryU
 JryUJryjyFW7Aw15n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
 UUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
 0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
 0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



在 2023/5/29 上午11:12, Tianrui Zhao 写道:
>
>
> 在 2023年05月18日 17:06, Song Gao 写道:
>> 1. Implement some functions for LoongArch numa support;
>> 2. Implement fdt_add_memory_node() for fdt;
>> 3. build_srat() fills node_id and adds build numa memory.
>>
>> Base-on:
>> https://patchew.org/QEMU/20230518014115.117869-1-gaosong@loongson.cn/
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/acpi-build.c | 42 ++++++++++++-----
>>   hw/loongarch/virt.c       | 96 ++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 116 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>> index 232344e1c7..bb5adb9c1e 100644
>> --- a/hw/loongarch/acpi-build.c
>> +++ b/hw/loongarch/acpi-build.c
>> @@ -163,11 +163,12 @@ build_madt(GArray *table_data, BIOSLinker 
>> *linker, LoongArchMachineState *lams)
>>   static void
>>   build_srat(GArray *table_data, BIOSLinker *linker, MachineState 
>> *machine)
>>   {
>> -    int i, arch_id;
>> +    int i, arch_id, node_id;
>> +    uint64_t mem_len, mem_base;
>> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>> -    MachineState *ms = MACHINE(lams);
>> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> -    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>> +    MachineClass *mc = MACHINE_GET_CLASS(lams);
>> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
>>       AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = 
>> lams->oem_id,
>>                           .oem_table_id = lams->oem_table_id };
>>   @@ -177,12 +178,13 @@ build_srat(GArray *table_data, BIOSLinker 
>> *linker, MachineState *machine)
>>         for (i = 0; i < arch_ids->len; ++i) {
>>           arch_id = arch_ids->cpus[i].arch_id;
>> +        node_id = arch_ids->cpus[i].props.node_id;
>>             /* Processor Local APIC/SAPIC Affinity Structure */
>>           build_append_int_noprefix(table_data, 0, 1);  /* Type */
>>           build_append_int_noprefix(table_data, 16, 1); /* Length */
>>           /* Proximity Domain [7:0] */
>> -        build_append_int_noprefix(table_data, 0, 1);
>> +        build_append_int_noprefix(table_data, node_id, 1);
>>           build_append_int_noprefix(table_data, arch_id, 1); /* APIC 
>> ID */
>>           /* Flags, Table 5-36 */
>>           build_append_int_noprefix(table_data, 1, 4);
>> @@ -192,15 +194,33 @@ build_srat(GArray *table_data, BIOSLinker 
>> *linker, MachineState *machine)
>>           build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>>       }
>>   +    /* Node0 */
>>       build_srat_memory(table_data, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE,
>>                         0, MEM_AFFINITY_ENABLED);
>> +    mem_base = VIRT_HIGHMEM_BASE;
>> +    if (!nb_numa_nodes) {
>> +        mem_len = machine->ram_size - VIRT_LOWMEM_SIZE;
>> +    } else {
>> +        mem_len = machine->numa_state->nodes[0].node_mem - 
>> VIRT_LOWMEM_SIZE;
>> +    }
>> +    build_srat_memory(table_data, mem_base, mem_len, 0, 
>> MEM_AFFINITY_ENABLED);
>> +
>> +    /* Node1 - Nodemax */
>> +    if (nb_numa_nodes) {
>> +        mem_base += mem_len;
>> +        for (i = 1; i < nb_numa_nodes; ++i) {
>> +            if (machine->numa_state->nodes[i].node_mem > 0) {
>> +                build_srat_memory(table_data, mem_base,
>> + machine->numa_state->nodes[i].node_mem, i,
>> +                                  MEM_AFFINITY_ENABLED);
>> +                mem_base += machine->numa_state->nodes[i].node_mem;
>> +            }
>> +        }
>> +    }
>>   -    build_srat_memory(table_data, VIRT_HIGHMEM_BASE, 
>> machine->ram_size - VIRT_LOWMEM_SIZE,
>> -                      0, MEM_AFFINITY_ENABLED);
>> -
>> -    if (ms->device_memory) {
>> -        build_srat_memory(table_data, ms->device_memory->base,
>> - memory_region_size(&ms->device_memory->mr),
>> +    if (machine->device_memory) {
>> +        build_srat_memory(table_data, machine->device_memory->base,
>> + memory_region_size(&machine->device_memory->mr),
>>                             0, MEM_AFFINITY_HOTPLUGGABLE | 
>> MEM_AFFINITY_ENABLED);
>>       }
>>   diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 6e1c42fb2b..c9235f740e 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -164,11 +164,18 @@ static void fdt_add_cpu_nodes(const 
>> LoongArchMachineState *lams)
>>       for (num = smp_cpus - 1; num >= 0; num--) {
>>           char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
>>           LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
>> +        CPUState *cs = CPU(cpu);
>>             qemu_fdt_add_subnode(ms->fdt, nodename);
>>           qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", 
>> "cpu");
>>           qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
>>                                   cpu->dtb_compatible);
>> +
>> +        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
>> +            qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id",
>> + ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
>> +        }
>> +
>>           qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
>>           qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
>> qemu_fdt_alloc_phandle(ms->fdt));
>> @@ -280,6 +287,22 @@ static void 
>> fdt_add_irqchip_node(LoongArchMachineState *lams)
>>       g_free(nodename);
>>   }
>>   +static void fdt_add_memory_node(MachineState *ms,
>> +                                uint64_t base, uint64_t size, int 
>> node_id)
>> +{
>> +    char *nodename = g_strdup_printf("/memory@%lx", base);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, nodename);
>> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
>> +    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", 
>> "memory");
>> +
>> +    if (ms->numa_state && ms->numa_state->num_nodes) {
>> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id", 
>> node_id);
>> +    }
>> +
>> +    g_free(nodename);
>> +}
>> +
>>   #define PM_BASE 0x10080000
>>   #define PM_SIZE 0x100
>>   #define PM_CTRL 0x10
>> @@ -766,14 +789,17 @@ static void loongarch_init(MachineState *machine)
>>       const char *cpu_model = machine->cpu_type;
>>       ram_addr_t offset = 0;
>>       ram_addr_t ram_size = machine->ram_size;
>> -    uint64_t highram_size = 0;
>> +    uint64_t highram_size = 0, phyAddr = 0;
>>       MemoryRegion *address_space_mem = get_system_memory();
>>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>> +    NodeInfo *numa_info = machine->numa_state->nodes;
>>       int i;
>>       hwaddr fdt_base;
>>       const CPUArchIdList *possible_cpus;
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       CPUState *cpu;
>> +    char *ramName = NULL;
>>         if (!cpu_model) {
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>> @@ -798,17 +824,45 @@ static void loongarch_init(MachineState *machine)
>>           machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>>       }
>>       fdt_add_cpu_nodes(lams);
>> -    /* Add memory region */
>> -    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.lowram",
>> -                             machine->ram, 0, 256 * MiB);
>> -    memory_region_add_subregion(address_space_mem, offset, 
>> &lams->lowmem);
>> -    offset += 256 * MiB;
>> -    memmap_add_entry(0, 256 * MiB, 1);
>> -    highram_size = ram_size - 256 * MiB;
>> -    memory_region_init_alias(&lams->highmem, NULL, "loongarch.highmem",
>> +
>> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
> Hi gaosong
>
> Why need we add machine->ram into address_space_mem at 0 addr ? I 
> think it may break the previous system memory space and the address of 
> high_ram is VIRT_HIGHMEM_BASE, so it may should not add the whole ram 
> into system memory space directly.   I think we should remove it, as 
> the following code will add the different ram part into system memory 
> space at right address.
>
> what do you think of it?
>
No need,   I'll remove it.

Thanks.
Song Gao
>
>> +
>> +    /* Node0 memory */
>> +    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
>> +    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 
>> 0);
>> +    memory_region_init_alias(&lams->lowmem, NULL, 
>> "loongarch.node0.lowram",
>> +                             machine->ram, offset, VIRT_LOWMEM_SIZE);
>> +    memory_region_add_subregion(address_space_mem, phyAddr, 
>> &lams->lowmem);
>> +
>> +    offset += VIRT_LOWMEM_SIZE;
>> +    if (nb_numa_nodes > 0) {
>> +        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
>> +        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
>> +    } else {
>> +        highram_size = ram_size - VIRT_LOWMEM_SIZE;
>> +    }
>> +    phyAddr = VIRT_HIGHMEM_BASE;
>> +    memmap_add_entry(phyAddr, highram_size, 1);
>> +    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
>> +    memory_region_init_alias(&lams->highmem, NULL, 
>> "loongarch.node0.highram",
>>                                machine->ram, offset, highram_size);
>> -    memory_region_add_subregion(address_space_mem, 0x90000000, 
>> &lams->highmem);
>> -    memmap_add_entry(0x90000000, highram_size, 1);
>> +    memory_region_add_subregion(address_space_mem, phyAddr, 
>> &lams->highmem);
>> +
>> +    /* Node1 - Nodemax memory */
>> +    offset += highram_size;
>> +    phyAddr += highram_size;
>> +
>> +    for (i = 1; i < nb_numa_nodes; i++) {
>> +        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
>> +        ramName = g_strdup_printf("loongarch.node%d.ram", i);
>> +        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
>> +                                 offset, numa_info[i].node_mem);
>> +        memory_region_add_subregion(address_space_mem, phyAddr, 
>> nodemem);
>> +        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
>> +        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, 
>> i);
>> +        offset += numa_info[i].node_mem;
>> +        phyAddr += numa_info[i].node_mem;
>> +    }
>>         /* initialize device memory address space */
>>       if (machine->ram_size < machine->maxram_size) {
>> @@ -1051,6 +1105,21 @@ static const CPUArchIdList 
>> *virt_possible_cpu_arch_ids(MachineState *ms)
>>       return ms->possible_cpus;
>>   }
>>   +static CpuInstanceProperties
>> +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
>> +
>> +    assert(cpu_index < possible_cpus->len);
>> +    return possible_cpus->cpus[cpu_index].props;
>> +}
>> +
>> +static int64_t virt_get_default_cpu_node_id(const MachineState *ms, 
>> int idx)
>> +{
>> +    return idx % ms->numa_state->num_nodes;
>> +}
>> +
>>   static void loongarch_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1068,6 +1137,11 @@ static void loongarch_class_init(ObjectClass 
>> *oc, void *data)
>>       mc->default_boot_order = "c";
>>       mc->no_cdrom = 1;
>>       mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>> +    mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>> +    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>> +    mc->numa_mem_supported = true;
>> +    mc->auto_enable_numa_with_memhp = true;
>> +    mc->auto_enable_numa_with_memdev = true;
>>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>>       hc->plug = loongarch_machine_device_plug_cb;
>>       hc->pre_plug = virt_machine_device_pre_plug;


