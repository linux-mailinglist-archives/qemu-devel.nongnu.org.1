Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0B9C03E4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Nov 2024 12:26:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90eO-0002Iq-M7; Thu, 07 Nov 2024 06:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t90eL-0002Ii-L6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:26:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t90eD-0005XW-Ri
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:26:04 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxGeG4oyxnK0Q3AA--.43899S3;
 Thu, 07 Nov 2024 19:25:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMDxvke2oyxnqOVJAA--.726S3;
 Thu, 07 Nov 2024 19:25:44 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Add reset interface for virt-machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241031065418.3111892-1-maobibo@loongson.cn>
 <971b47d0-949b-4454-884b-28ec070f9365@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <68dd5927-1b5b-131e-b2f3-1a55630fe034@loongson.cn>
Date: Thu, 7 Nov 2024 19:26:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <971b47d0-949b-4454-884b-28ec070f9365@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMDxvke2oyxnqOVJAA--.726S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy5ZryxtF4kKw1UGFWrtFc_yoW7CrWUpr
 97AFW5JrWkGrn7Xw47J34UuFyDXr1xKanIvF1IqFy0kF4DWryjqr4jqr9I9F1DA395WF1Y
 vr1kXw17ZF47X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.588,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

在 2024/11/1 上午12:16, Philippe Mathieu-Daudé 写道:
> Cc'ing Peter who is working on the Reset API.
>
> On 31/10/24 03:54, Bibo Mao wrote:
>> With generic cpu reset interface, pc register is entry of FLASH for
>> UEFI BIOS. However with direct kernel booting requirement, there is
>> little different, pc register of primary cpu is entry address of ELF
>> file.
>>
>> At the same time with requirement of cpu hotplug, hot-added CPU should
>> register reset interface for this cpu object. Now reset callback is
>> not registered for hot-added CPU.
>>
>> With this patch reset callback for CPU is register when CPU instance
>> is created, and reset interface is added for virt-machine board. In
>> reset interface of virt-machine, reset for direct kernel booting
>> requirement is called.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/boot.c         |  9 +--------
>>   hw/loongarch/virt.c         | 14 ++++++++++++++
>>   include/hw/loongarch/boot.h |  1 +
>>   target/loongarch/cpu.c      | 10 ++++++++++
>>   4 files changed, 26 insertions(+), 8 deletions(-)
>>
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index cb668703bd..cbb4e3737d 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -216,12 +216,11 @@ static int64_t load_kernel_info(struct 
>> loongarch_boot_info *info)
>>       return kernel_entry;
>>   }
>>   -static void reset_load_elf(void *opaque)
>> +void reset_load_elf(void *opaque)
>>   {
>>       LoongArchCPU *cpu = opaque;
>>       CPULoongArchState *env = &cpu->env;
>>   -    cpu_reset(CPU(cpu));
>>       if (env->load_elf) {
>>       if (cpu == LOONGARCH_CPU(first_cpu)) {
>>               env->gpr[4] = env->boot_info->a0;
>> @@ -320,12 +319,6 @@ static void loongarch_direct_kernel_boot(struct 
>> loongarch_boot_info *info)
>>   void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info)
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>> -    int i;
>> -
>> -    /* register reset function */
>> -    for (i = 0; i < ms->smp.cpus; i++) {
>> -        qemu_register_reset(reset_load_elf, 
>> LOONGARCH_CPU(qemu_get_cpu(i)));
>> -    }
>>         info->kernel_filename = ms->kernel_filename;
>>       info->kernel_cmdline = ms->kernel_cmdline;
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 9a635d1d3d..80680d178c 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -1434,6 +1434,19 @@ static int64_t 
>> virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>>       }
>>   }
>>   +static void virt_reset(MachineState *machine, ResetType type)
>> +{
>> +    CPUState *cs;
>> +
>> +    /* Reset all devices including CPU devices */
>> +    qemu_devices_reset(type);
>> +
>> +    /* Reset PC and register context for kernel direct booting 
>> method */
>> +    CPU_FOREACH(cs) {
>> +        reset_load_elf(LOONGARCH_CPU(cs));
>> +    }
>> +}
>> +
>>   static void virt_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1457,6 +1470,7 @@ static void virt_class_init(ObjectClass *oc, 
>> void *data)
>>       mc->auto_enable_numa_with_memdev = true;
>>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>>       mc->default_nic = "virtio-net-pci";
>> +    mc->reset = virt_reset;
>>       hc->plug = virt_device_plug_cb;
>>       hc->pre_plug = virt_device_pre_plug;
>>       hc->unplug_request = virt_device_unplug_request;
>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index b3b870df1f..c7020ec9bb 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -115,5 +115,6 @@ struct memmap_entry {
>>   };
>>     void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info);
>> +void reset_load_elf(void *opaque);
>>     #endif /* HW_LOONGARCH_BOOT_H */
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 7212fb5f8f..f7f8fcc024 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -592,6 +592,13 @@ static void 
>> loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>>       info->print_insn = print_insn_loongarch;
>>   }
>>   +#ifndef CONFIG_USER_ONLY
>> +static void loongarch_cpu_reset_cb(void *opaque)
>> +{
>> +    cpu_reset((CPUState *) opaque);
>> +}
>> +#endif
>> +
>>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>   {
>>       CPUState *cs = CPU(dev);
>> @@ -607,6 +614,9 @@ static void loongarch_cpu_realizefn(DeviceState 
>> *dev, Error **errp)
>>       loongarch_cpu_register_gdb_regs_for_features(cs);
>>         cpu_reset(cs);
>> +#ifndef CONFIG_USER_ONLY
>> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);
>> +#endif
>>       qemu_init_vcpu(cs);
>>         lacc->parent_realize(dev, errp);
>>
>> base-commit: 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29


