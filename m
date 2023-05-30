Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58660715DFD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xvV-0004rL-97; Tue, 30 May 2023 07:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1q3xvR-0004qu-2Q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1q3xvN-0008Qs-UM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:04 -0400
Received: from loongson.cn (unknown [10.20.42.86])
 by gateway (Coremail) with SMTP id _____8BxlPDP43VkaJICAA--.5746S3;
 Tue, 30 May 2023 19:53:52 +0800 (CST)
Received: from [10.20.42.86] (unknown [10.20.42.86])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxddHN43VklY2AAA--.11953S3; 
 Tue, 30 May 2023 19:53:50 +0800 (CST)
Subject: Re: [PATCH v1 1/2] hw/loongarch/virt: Add cpu arch_id support
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230518014115.117869-1-gaosong@loongson.cn>
 <20230518014115.117869-2-gaosong@loongson.cn>
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
From: Tianrui Zhao <zhaotianrui@loongson.cn>
Message-ID: <c5a2ab4e-74ec-14bb-8498-1c83f1fa7c3f@loongson.cn>
Date: Tue, 30 May 2023 19:53:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230518014115.117869-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxddHN43VklY2AAA--.11953S3
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ar1UXF4DKr4DAFWDGF48Zwb_yoW7KFW5pw
 4jyayFvwnrXr93ZwsrG34agF1rAr1kWw1aga1xKrsYk3WDK348JFW8KwsIyFZFkw1kWF1D
 Xr48G3W7WF47ArUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 baAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
 62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I
 0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
 3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
 WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
 cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
 AFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
 43ZEXa7IU1RBT5UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.09, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



在 2023年05月18日 09:41, Song Gao 写道:
> With acpi madt table, there is cpu physical coreid, which may
> be different with logical id in qemu. This patch adds cpu arch_id
> support, and fill madt table with arch_id. For the present cpu
> arch_id is still equal to logical id.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c | 20 ++++++++++++++------
>   hw/loongarch/virt.c       | 34 ++++++++++++++++++++++++++++++++--
>   2 files changed, 46 insertions(+), 8 deletions(-)
>
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
> index 2b7588e32a..83c1e43ff5 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -770,6 +770,9 @@ static void loongarch_init(MachineState *machine)
>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>       int i;
>       hwaddr fdt_base;
> +    const CPUArchIdList *possible_cpus;
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    CPUState *cpu;
>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -786,8 +789,12 @@ static void loongarch_init(MachineState *machine)
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
> @@ -1021,6 +1028,28 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
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
> +        ms->possible_cpus->cpus[n].props.core_id = n;
Should this be core_id = (n / ms->smp.threads) % ms->smp.cores ?

Thanks
Tianrui Zhao
> +    }
> +    return ms->possible_cpus;
> +}
> +
>   static void loongarch_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1037,6 +1066,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_VIRTIO;
>       mc->default_boot_order = "c";
>       mc->no_cdrom = 1;
> +    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>       hc->plug = loongarch_machine_device_plug_cb;
>       hc->pre_plug = virt_machine_device_pre_plug;


