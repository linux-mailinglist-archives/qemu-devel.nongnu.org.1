Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA03715F17
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:24:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yOg-0005xd-9e; Tue, 30 May 2023 08:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q3yOR-0005sB-AW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:24:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q3yOI-000854-2W
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:23:57 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8AxyfHV6nVkYZYCAA--.5940S3;
 Tue, 30 May 2023 20:23:49 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxt7nT6nVk7JiAAA--.13250S3; 
 Tue, 30 May 2023 20:23:48 +0800 (CST)
Subject: Re: [PATCH v1 1/2] hw/loongarch/virt: Add cpu arch_id support
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230518014115.117869-1-gaosong@loongson.cn>
 <20230518014115.117869-2-gaosong@loongson.cn>
 <c5a2ab4e-74ec-14bb-8498-1c83f1fa7c3f@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <bb2421f7-82c9-21d9-527a-a67c3da0a300@loongson.cn>
Date: Tue, 30 May 2023 20:23:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c5a2ab4e-74ec-14bb-8498-1c83f1fa7c3f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dxt7nT6nVk7JiAAA--.13250S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WFy5tFy3ZFWrKry3Jry8Grg_yoW3Ar45pr
 1vyrW8tryUWrn3Jw1UJr15WFyrJr18J3WDXa10gF4rAF4UGryjgr4UWrn0gF1UGw4kJF1U
 Xr1UJFnruF47Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 b3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
 0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
 xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
 1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
 6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
 AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
 07j0FALUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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



在 2023/5/30 下午7:53, Tianrui Zhao 写道:
>
>
> 在 2023年05月18日 09:41, Song Gao 写道:
>> With acpi madt table, there is cpu physical coreid, which may
>> be different with logical id in qemu. This patch adds cpu arch_id
>> support, and fill madt table with arch_id. For the present cpu
>> arch_id is still equal to logical id.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/acpi-build.c | 20 ++++++++++++++------
>>   hw/loongarch/virt.c       | 34 ++++++++++++++++++++++++++++++++--
>>   2 files changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>> index 8e3ce07367..232344e1c7 100644
>> --- a/hw/loongarch/acpi-build.c
>> +++ b/hw/loongarch/acpi-build.c
>> @@ -107,7 +107,9 @@ static void
>>   build_madt(GArray *table_data, BIOSLinker *linker, 
>> LoongArchMachineState *lams)
>>   {
>>       MachineState *ms = MACHINE(lams);
>> -    int i;
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>> +    int i, arch_id;
>>       AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = 
>> lams->oem_id,
>>                           .oem_table_id = lams->oem_table_id };
>>   @@ -117,13 +119,15 @@ build_madt(GArray *table_data, BIOSLinker 
>> *linker, LoongArchMachineState *lams)
>>       build_append_int_noprefix(table_data, 0, 4);
>>       build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); 
>> /* Flags */
>>   -    for (i = 0; i < ms->smp.cpus; i++) {
>> +    for (i = 0; i < arch_ids->len; i++) {
>>           /* Processor Core Interrupt Controller Structure */
>> +        arch_id = arch_ids->cpus[i].arch_id;
>> +
>>           build_append_int_noprefix(table_data, 17, 1);    /* Type */
>>           build_append_int_noprefix(table_data, 15, 1);    /* Length */
>>           build_append_int_noprefix(table_data, 1, 1);     /* Version */
>>           build_append_int_noprefix(table_data, i + 1, 4); /* ACPI 
>> Processor ID */
>> -        build_append_int_noprefix(table_data, i, 4);     /* Core ID */
>> +        build_append_int_noprefix(table_data, arch_id, 4); /* Core 
>> ID */
>>           build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>>       }
>>   @@ -159,9 +163,11 @@ build_madt(GArray *table_data, BIOSLinker 
>> *linker, LoongArchMachineState *lams)
>>   static void
>>   build_srat(GArray *table_data, BIOSLinker *linker, MachineState 
>> *machine)
>>   {
>> -    uint64_t i;
>> +    int i, arch_id;
>>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>>       MachineState *ms = MACHINE(lams);
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>>       AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = 
>> lams->oem_id,
>>                           .oem_table_id = lams->oem_table_id };
>>   @@ -169,13 +175,15 @@ build_srat(GArray *table_data, BIOSLinker 
>> *linker, MachineState *machine)
>>       build_append_int_noprefix(table_data, 1, 4); /* Reserved */
>>       build_append_int_noprefix(table_data, 0, 8); /* Reserved */
>>   -    for (i = 0; i < ms->smp.cpus; ++i) {
>> +    for (i = 0; i < arch_ids->len; ++i) {
>> +        arch_id = arch_ids->cpus[i].arch_id;
>> +
>>           /* Processor Local APIC/SAPIC Affinity Structure */
>>           build_append_int_noprefix(table_data, 0, 1);  /* Type */
>>           build_append_int_noprefix(table_data, 16, 1); /* Length */
>>           /* Proximity Domain [7:0] */
>>           build_append_int_noprefix(table_data, 0, 1);
>> -        build_append_int_noprefix(table_data, i, 1); /* APIC ID */
>> +        build_append_int_noprefix(table_data, arch_id, 1); /* APIC 
>> ID */
>>           /* Flags, Table 5-36 */
>>           build_append_int_noprefix(table_data, 1, 4);
>>           build_append_int_noprefix(table_data, 0, 1); /* Local SAPIC 
>> EID */
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 2b7588e32a..83c1e43ff5 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -770,6 +770,9 @@ static void loongarch_init(MachineState *machine)
>>       LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
>>       int i;
>>       hwaddr fdt_base;
>> +    const CPUArchIdList *possible_cpus;
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    CPUState *cpu;
>>         if (!cpu_model) {
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>> @@ -786,8 +789,12 @@ static void loongarch_init(MachineState *machine)
>>       }
>>       create_fdt(lams);
>>       /* Init CPUs */
>> -    for (i = 0; i < machine->smp.cpus; i++) {
>> -        cpu_create(machine->cpu_type);
>> +
>> +    possible_cpus = mc->possible_cpu_arch_ids(machine);
>> +    for (i = 0; i < possible_cpus->len; i++) {
>> +        cpu = cpu_create(machine->cpu_type);
>> +        cpu->cpu_index = i;
>> +        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>>       }
>>       fdt_add_cpu_nodes(lams);
>>       /* Add memory region */
>> @@ -1021,6 +1028,28 @@ static HotplugHandler 
>> *virt_machine_get_hotplug_handler(MachineState *machine,
>>       return NULL;
>>   }
>>   +static const CPUArchIdList 
>> *virt_possible_cpu_arch_ids(MachineState *ms)
>> +{
>> +    int n;
>> +    unsigned int max_cpus = ms->smp.max_cpus;
>> +
>> +    if (ms->possible_cpus) {
>> +        assert(ms->possible_cpus->len == max_cpus);
>> +        return ms->possible_cpus;
>> +    }
>> +
>> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>> +                                  sizeof(CPUArchId) * max_cpus);
>> +    ms->possible_cpus->len = max_cpus;
>> +    for (n = 0; n < ms->possible_cpus->len; n++) {
>> +        ms->possible_cpus->cpus[n].type = ms->cpu_type;
>> +        ms->possible_cpus->cpus[n].arch_id = n;
>> +        ms->possible_cpus->cpus[n].props.has_core_id = true;
>> +        ms->possible_cpus->cpus[n].props.core_id = n;
> Should this be core_id = (n / ms->smp.threads) % ms->smp.cores ?
>
The LoongArch kernel  is' t support set smp.threads.

Thanks.
Song Gao
>> +    }
>> +    return ms->possible_cpus;
>> +}
>> +
>>   static void loongarch_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1037,6 +1066,7 @@ static void loongarch_class_init(ObjectClass 
>> *oc, void *data)
>>       mc->block_default_type = IF_VIRTIO;
>>       mc->default_boot_order = "c";
>>       mc->no_cdrom = 1;
>> +    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>>       hc->plug = loongarch_machine_device_plug_cb;
>>       hc->pre_plug = virt_machine_device_pre_plug;


