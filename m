Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DD732889
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3bl-0001LZ-OD; Fri, 16 Jun 2023 03:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA3bj-0001LG-0j
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA3bg-0006f5-3t
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:54 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8DxyOn1CoxkkuAFAA--.12448S3;
 Fri, 16 Jun 2023 15:10:45 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxG8rzCoxk6v0cAA--.7768S3; 
 Fri, 16 Jun 2023 15:10:43 +0800 (CST)
Subject: Re: [PATCH v2] hw/loongarch: Add numa support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230613122613.2471743-1-zhaotianrui@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <864a9f01-a120-7fa5-c03f-685d98840bab@loongson.cn>
Date: Fri, 16 Jun 2023 15:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230613122613.2471743-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxG8rzCoxk6v0cAA--.7768S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Cw18GFWDWr18urW8Ww4UAwc_yoWkKw48pF
 4IkFWFgr43XFn3Wrs7KF15WF95Aws7Gay7Xa4xCrWF9F9rWryUCFW8K3yayFyDC34kXF15
 ZF1Dtr9Iga1xtrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 LvtUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.098, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/6/13 ÏÂÎç8:26, Tianrui Zhao Ð´µÀ:
> From: Song Gao <gaosong@loongson.cn>
>
> 1. Implement some functions for LoongArch numa support;
> 2. Implement fdt_add_memory_node() for fdt;
> 3. build_srat() fills node_id and adds build numa memory.
>
> Base-on:
> https://patchew.org/QEMU/20230613120552.2471420-1-zhaotianrui@loongson.cn/
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/Kconfig      |   1 +
>   hw/loongarch/acpi-build.c |  60 +++++++++++++++++-----
>   hw/loongarch/virt.c       | 102 +++++++++++++++++++++++++++++++++-----
>   3 files changed, 139 insertions(+), 24 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index eb112af990..1e7c5b43c5 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -21,3 +21,4 @@ config LOONGARCH_VIRT
>       select FW_CFG_DMA
>       select DIMM
>       select PFLASH_CFI01
> +    select ACPI_HMAT
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 232344e1c7..f526f3abba 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -34,6 +34,7 @@
>   #include "sysemu/tpm.h"
>   #include "hw/platform-bus.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/hmat.h"
>   
>   #define ACPI_BUILD_ALIGN_SIZE             0x1000
>   #define ACPI_BUILD_TABLE_SIZE             0x20000
> @@ -163,11 +164,12 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>   static void
>   build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   {
> -    int i, arch_id;
> +    int i, arch_id, node_id;
> +    uint64_t mem_len, mem_base;
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
> -    MachineState *ms = MACHINE(lams);
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> -    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
> +    MachineClass *mc = MACHINE_GET_CLASS(lams);
> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
>       AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
>                           .oem_table_id = lams->oem_table_id };
>   
> @@ -177,12 +179,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   
>       for (i = 0; i < arch_ids->len; ++i) {
>           arch_id = arch_ids->cpus[i].arch_id;
> +        node_id = arch_ids->cpus[i].props.node_id;
>   
>           /* Processor Local APIC/SAPIC Affinity Structure */
>           build_append_int_noprefix(table_data, 0, 1);  /* Type  */
>           build_append_int_noprefix(table_data, 16, 1); /* Length */
>           /* Proximity Domain [7:0] */
> -        build_append_int_noprefix(table_data, 0, 1);
> +        build_append_int_noprefix(table_data, node_id, 1);
>           build_append_int_noprefix(table_data, arch_id, 1); /* APIC ID */
>           /* Flags, Table 5-36 */
>           build_append_int_noprefix(table_data, 1, 4);
> @@ -192,16 +195,36 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>           build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>       }
>   
> +    /* Node0 */
>       build_srat_memory(table_data, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE,
>                         0, MEM_AFFINITY_ENABLED);
> +    mem_base = VIRT_HIGHMEM_BASE;
> +    if (!nb_numa_nodes) {
> +        mem_len = machine->ram_size - VIRT_LOWMEM_SIZE;
> +    } else {
> +        mem_len = machine->numa_state->nodes[0].node_mem - VIRT_LOWMEM_SIZE;
> +    }
> +    if (mem_len)
> +        build_srat_memory(table_data, mem_base, mem_len, 0, MEM_AFFINITY_ENABLED);
> +
> +    /* Node1 - Nodemax */
> +    if (nb_numa_nodes) {
> +        mem_base += mem_len;
> +        for (i = 1; i < nb_numa_nodes; ++i) {
> +            if (machine->numa_state->nodes[i].node_mem > 0) {
> +                build_srat_memory(table_data, mem_base,
> +                                  machine->numa_state->nodes[i].node_mem, i,
> +                                  MEM_AFFINITY_ENABLED);
> +                mem_base += machine->numa_state->nodes[i].node_mem;
> +            }
> +        }
> +    }
>   
> -    build_srat_memory(table_data, VIRT_HIGHMEM_BASE, machine->ram_size - VIRT_LOWMEM_SIZE,
> -                      0, MEM_AFFINITY_ENABLED);
> -
> -    if (ms->device_memory) {
> -        build_srat_memory(table_data, ms->device_memory->base,
> -                          memory_region_size(&ms->device_memory->mr),
> -                          0, MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +    if (machine->device_memory) {
> +        build_srat_memory(table_data, machine->device_memory->base,
> +                          memory_region_size(&machine->device_memory->mr),
> +                          nb_numa_nodes - 1,
> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>       }
>   
>       acpi_table_end(linker, &table);
> @@ -417,6 +440,19 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       acpi_add_table(table_offsets, tables_blob);
>       build_srat(tables_blob, tables->linker, machine);
>   
> +    if (machine->numa_state->num_nodes) {
> +        if (machine->numa_state->have_numa_distance) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_slit(tables_blob, tables->linker, machine, lams->oem_id,
> +                       lams->oem_table_id);
> +        }
> +        if (machine->numa_state->hmat_enabled) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_hmat(tables_blob, tables->linker, machine->numa_state,
> +                       lams->oem_id, lams->oem_table_id);
> +        }
> +    }
> +
>       acpi_add_table(table_offsets, tables_blob);
>       {
>           AcpiMcfgInfo mcfg = {
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 17bc37bccd..a2fcbf7643 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -164,11 +164,16 @@ static void fdt_add_cpu_nodes(const LoongArchMachineState *lams)
>       for (num = smp_cpus - 1; num >= 0; num--) {
>           char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
>           LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
> +        CPUState *cs = CPU(cpu);
>   
>           qemu_fdt_add_subnode(ms->fdt, nodename);
>           qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
>           qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
>                                   cpu->dtb_compatible);
> +        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
> +            qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id",
> +                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
> +        }
>           qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
>           qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
>                                 qemu_fdt_alloc_phandle(ms->fdt));
> @@ -280,6 +285,22 @@ static void fdt_add_irqchip_node(LoongArchMachineState *lams)
>       g_free(nodename);
>   }
>   
> +static void fdt_add_memory_node(MachineState *ms,
> +                                uint64_t base, uint64_t size, int node_id)
> +{
> +    char *nodename = g_strdup_printf("/memory@%lx", base);
> +
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
> +
> +    if (ms->numa_state && ms->numa_state->num_nodes) {
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id", node_id);
> +    }
> +
> +    g_free(nodename);
> +}
> +
>   #define PM_BASE 0x10080000
>   #define PM_SIZE 0x100
>   #define PM_CTRL 0x10
> @@ -767,14 +788,17 @@ static void loongarch_init(MachineState *machine)
>       const char *cpu_model = machine->cpu_type;
>       ram_addr_t offset = 0;
>       ram_addr_t ram_size = machine->ram_size;
> -    uint64_t highram_size = 0;
> +    uint64_t highram_size = 0, phyAddr = 0;
>       MemoryRegion *address_space_mem = get_system_memory();
>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
> +    int nb_numa_nodes = machine->numa_state->num_nodes;
> +    NodeInfo *numa_info = machine->numa_state->nodes;
>       int i;
>       hwaddr fdt_base;
>       const CPUArchIdList *possible_cpus;
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       CPUState *cpu;
> +    char *ramName = NULL;
>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -799,17 +823,43 @@ static void loongarch_init(MachineState *machine)
>           machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>       }
>       fdt_add_cpu_nodes(lams);
> -    /* Add memory region */
> -    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.lowram",
> -                             machine->ram, 0, 256 * MiB);
> -    memory_region_add_subregion(address_space_mem, offset, &lams->lowmem);
> -    offset += 256 * MiB;
> -    memmap_add_entry(0, 256 * MiB, 1);
> -    highram_size = ram_size - 256 * MiB;
> -    memory_region_init_alias(&lams->highmem, NULL, "loongarch.highmem",
> -                             machine->ram, offset, highram_size);
> -    memory_region_add_subregion(address_space_mem, 0x90000000, &lams->highmem);
> -    memmap_add_entry(0x90000000, highram_size, 1);
> +
> +    /* Node0 memory */
> +    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
> +    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
> +    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.node0.lowram",
> +                             machine->ram, offset, VIRT_LOWMEM_SIZE);
> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->lowmem);
> +
> +    offset += VIRT_LOWMEM_SIZE;
> +    if (nb_numa_nodes > 0) {
> +        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
> +        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
> +    } else {
> +        highram_size = ram_size - VIRT_LOWMEM_SIZE;
> +    }
> +    phyAddr = VIRT_HIGHMEM_BASE;
> +    memmap_add_entry(phyAddr, highram_size, 1);
> +    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
> +    memory_region_init_alias(&lams->highmem, NULL, "loongarch.node0.highram",
> +                              machine->ram, offset, highram_size);
> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->highmem);
> +
> +    /* Node1 - Nodemax memory */
> +    offset += highram_size;
> +    phyAddr += highram_size;
> +
> +    for (i = 1; i < nb_numa_nodes; i++) {
> +        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
> +        ramName = g_strdup_printf("loongarch.node%d.ram", i);
> +        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
> +                                 offset,  numa_info[i].node_mem);
> +        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
> +        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
> +        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
> +        offset += numa_info[i].node_mem;
> +        phyAddr += numa_info[i].node_mem;
> +    }
>   
>       /* initialize device memory address space */
>       if (machine->ram_size < machine->maxram_size) {
> @@ -1052,6 +1102,29 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>       return ms->possible_cpus;
>   }
>   
> +static CpuInstanceProperties
> +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}
> +
> +static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    int64_t nidx = 0;
> +
> +    if (ms->numa_state->num_nodes) {
> +        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
> +        if (ms->numa_state->num_nodes <= nidx) {
> +            nidx = ms->numa_state->num_nodes - 1;
> +        }
> +    }
> +    return nidx;
> +}
> +
>   static void loongarch_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1069,6 +1142,11 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>       mc->default_boot_order = "c";
>       mc->no_cdrom = 1;
>       mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
> +    mc->numa_mem_supported = true;
> +    mc->auto_enable_numa_with_memhp = true;
> +    mc->auto_enable_numa_with_memdev = true;
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>       mc->default_nic = "virtio-net-pci";
>       hc->plug = loongarch_machine_device_plug_cb;


