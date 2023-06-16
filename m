Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD19732888
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3bi-0001Kg-65; Fri, 16 Jun 2023 03:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA3be-0001Jy-OI
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA3bZ-0006da-I7
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:47 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8CxtOjpCoxkh+AFAA--.2205S3;
 Fri, 16 Jun 2023 15:10:34 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxfcroCoxky_0cAA--.7897S3; 
 Fri, 16 Jun 2023 15:10:32 +0800 (CST)
Subject: Re: [PATCH v2 1/2] hw/loongarch/virt: Add cpu arch_id support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230613120552.2471420-1-zhaotianrui@loongson.cn>
 <20230613120552.2471420-2-zhaotianrui@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <3b92e25d-f2fa-c8ef-c5d1-b5fdde1d3090@loongson.cn>
Date: Fri, 16 Jun 2023 15:10:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230613120552.2471420-2-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxfcroCoxky_0cAA--.7897S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar1UXFyUGF1DCrWxWryUJwc_yoWxJryUpw
 4jyayFvrnrXr93ZwsrG34agF1rAr1kWw12ga1xKrsYk3WDK348JFW8KwsIyFZFkwn7WF1D
 Xr4kta17WFW7ArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1RBT5UUUUU==
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



ÔÚ 2023/6/13 ÏÂÎç8:05, Tianrui Zhao Ð´µÀ:
> With acpi madt table, there is cpu physical coreid, which may
> be different with logical id in qemu. This patch adds cpu arch_id
> support, and fill madt table with arch_id. For the present cpu
> arch_id is still equal to logical id.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c | 20 ++++++++++++++------
>   hw/loongarch/virt.c       | 34 ++++++++++++++++++++++++++++++++--
>   2 files changed, 46 insertions(+), 8 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 8e3ce07367..232344e1c7 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -107,7 +107,9 @@ static void
>   build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>   {
>       MachineState *ms = MACHINE(lams);
> -    int i;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
> +    int i, arch_id;
>       AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lams->oem_id,
>                           .oem_table_id = lams->oem_table_id };
>   
> @@ -117,13 +119,15 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>       build_append_int_noprefix(table_data, 0, 4);
>       build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>   
> -    for (i = 0; i < ms->smp.cpus; i++) {
> +    for (i = 0; i < arch_ids->len; i++) {
>           /* Processor Core Interrupt Controller Structure */
> +        arch_id = arch_ids->cpus[i].arch_id;
> +
>           build_append_int_noprefix(table_data, 17, 1);    /* Type */
>           build_append_int_noprefix(table_data, 15, 1);    /* Length */
>           build_append_int_noprefix(table_data, 1, 1);     /* Version */
>           build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
> -        build_append_int_noprefix(table_data, i, 4);     /* Core ID */
> +        build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>           build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>       }
>   
> @@ -159,9 +163,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>   static void
>   build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   {
> -    uint64_t i;
> +    int i, arch_id;
>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>       MachineState *ms = MACHINE(lams);
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>       AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
>                           .oem_table_id = lams->oem_table_id };
>   
> @@ -169,13 +175,15 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       build_append_int_noprefix(table_data, 1, 4); /* Reserved */
>       build_append_int_noprefix(table_data, 0, 8); /* Reserved */
>   
> -    for (i = 0; i < ms->smp.cpus; ++i) {
> +    for (i = 0; i < arch_ids->len; ++i) {
> +        arch_id = arch_ids->cpus[i].arch_id;
> +
>           /* Processor Local APIC/SAPIC Affinity Structure */
>           build_append_int_noprefix(table_data, 0, 1);  /* Type  */
>           build_append_int_noprefix(table_data, 16, 1); /* Length */
>           /* Proximity Domain [7:0] */
>           build_append_int_noprefix(table_data, 0, 1);
> -        build_append_int_noprefix(table_data, i, 1); /* APIC ID */
> +        build_append_int_noprefix(table_data, arch_id, 1); /* APIC ID */
>           /* Flags, Table 5-36 */
>           build_append_int_noprefix(table_data, 1, 4);
>           build_append_int_noprefix(table_data, 0, 1); /* Local SAPIC EID */
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index ceddec1b23..ced5a862f8 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -771,6 +771,9 @@ static void loongarch_init(MachineState *machine)
>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>       int i;
>       hwaddr fdt_base;
> +    const CPUArchIdList *possible_cpus;
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    CPUState *cpu;
>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -787,8 +790,12 @@ static void loongarch_init(MachineState *machine)
>       }
>       create_fdt(lams);
>       /* Init CPUs */
> -    for (i = 0; i < machine->smp.cpus; i++) {
> -        cpu_create(machine->cpu_type);
> +
> +    possible_cpus = mc->possible_cpu_arch_ids(machine);
> +    for (i = 0; i < possible_cpus->len; i++) {
> +        cpu = cpu_create(machine->cpu_type);
> +        cpu->cpu_index = i;
> +        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>       }
>       fdt_add_cpu_nodes(lams);
>       /* Add memory region */
> @@ -1022,6 +1029,28 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       return NULL;
>   }
>   
> +static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    int n;
> +    unsigned int max_cpus = ms->smp.max_cpus;
> +
> +    if (ms->possible_cpus) {
> +        assert(ms->possible_cpus->len == max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len = max_cpus;
> +    for (n = 0; n < ms->possible_cpus->len; n++) {
> +        ms->possible_cpus->cpus[n].type = ms->cpu_type;
> +        ms->possible_cpus->cpus[n].arch_id = n;
> +        ms->possible_cpus->cpus[n].props.has_core_id = true;
> +        ms->possible_cpus->cpus[n].props.core_id = n % ms->smp.cores;
> +    }
> +    return ms->possible_cpus;
> +}
> +
>   static void loongarch_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1038,6 +1067,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_VIRTIO;
>       mc->default_boot_order = "c";
>       mc->no_cdrom = 1;
> +    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>       mc->default_nic = "virtio-net-pci";
>       hc->plug = loongarch_machine_device_plug_cb;


