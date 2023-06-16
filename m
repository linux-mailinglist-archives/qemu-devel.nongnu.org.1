Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1C732886
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3bj-0001LN-Si; Fri, 16 Jun 2023 03:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA3bb-0001JZ-0k
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA3bY-0006e0-5w
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:46 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Cxd+nuCoxki+AFAA--.10569S3;
 Fri, 16 Jun 2023 15:10:38 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxfcruCoxk2v0cAA--.7898S3; 
 Fri, 16 Jun 2023 15:10:38 +0800 (CST)
Subject: Re: [PATCH v2 2/2] hw/intc: Set physical cpuid route for LoongArch
 ipi device
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230613120552.2471420-1-zhaotianrui@loongson.cn>
 <20230613120552.2471420-3-zhaotianrui@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <ed9b9fbe-b5d0-017d-8020-61c03fbd0a57@loongson.cn>
Date: Fri, 16 Jun 2023 15:10:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230613120552.2471420-3-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxfcruCoxk2v0cAA--.7898S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw45Ww17CFyDZF43Jr13GFX_yoWrWr4xpF
 ZruF1agF40qFZxX3Z3Xa4UXrn8Arn7Wa429F4IkanYkF4DWrykWF1kG34DXFWDA34rWF4j
 vrs7Kr42gF47trgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
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
> LoongArch ipi device uses physical cpuid to route to different
> vcpus rather logical cpuid, and the physical cpuid is the same
> with cpuid in acpi dsdt and srat table.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_ipi.c | 44 ++++++++++++++++++++++++++++++++++-------
>   hw/loongarch/virt.c     |  1 +
>   target/loongarch/cpu.h  |  2 ++
>   3 files changed, 40 insertions(+), 7 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 3e45381652..67858b521c 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -17,6 +17,8 @@
>   #include "target/loongarch/internals.h"
>   #include "trace.h"
>   
> +static void loongarch_ipi_writel(void *, hwaddr, uint64_t, unsigned);
> +
>   static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
>   {
>       IPICore *s = opaque;
> @@ -75,13 +77,42 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
>                         data, MEMTXATTRS_UNSPECIFIED, NULL);
>   }
>   
> +static int archid_cmp(const void *a, const void *b)
> +{
> +   CPUArchId *archid_a = (CPUArchId *)a;
> +   CPUArchId *archid_b = (CPUArchId *)b;
> +
> +   return archid_a->arch_id - archid_b->arch_id;
> +}
> +
> +static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
> +{
> +    CPUArchId apic_id, *found_cpu;
> +
> +    apic_id.arch_id = id;
> +    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> +        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> +        archid_cmp);
> +
> +    return found_cpu;
> +}
> +
> +static CPUState *ipi_getcpu(int arch_id)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    CPUArchId *archid;
> +
> +    archid = find_cpu_by_archid(machine, arch_id);
> +    return CPU(archid->cpu);
> +}
> +
>   static void ipi_send(uint64_t val)
>   {
>       uint32_t cpuid;
>       uint8_t vector;
> -    CPULoongArchState *env;
>       CPUState *cs;
>       LoongArchCPU *cpu;
> +    LoongArchIPI *s;
>   
>       cpuid = extract32(val, 16, 10);
>       if (cpuid >= LOONGARCH_MAX_CPUS) {
> @@ -92,11 +123,10 @@ static void ipi_send(uint64_t val)
>       /* IPI status vector */
>       vector = extract8(val, 0, 5);
>   
> -    cs = qemu_get_cpu(cpuid);
> +    cs = ipi_getcpu(cpuid);
>       cpu = LOONGARCH_CPU(cs);
> -    env = &cpu->env;
> -    address_space_stl(&env->address_space_iocsr, 0x1008,
> -                      BIT(vector), MEMTXATTRS_UNSPECIFIED, NULL);
> +    s = LOONGARCH_IPI(cpu->env.ipistate);
> +    loongarch_ipi_writel(&s->ipi_core, CORE_SET_OFF, BIT(vector), 4);
>   }
>   
>   static void mail_send(uint64_t val)
> @@ -114,7 +144,7 @@ static void mail_send(uint64_t val)
>       }
>   
>       addr = 0x1020 + (val & 0x1c);
> -    cs = qemu_get_cpu(cpuid);
> +    cs = ipi_getcpu(cpuid);
>       cpu = LOONGARCH_CPU(cs);
>       env = &cpu->env;
>       send_ipi_data(env, val, addr);
> @@ -135,7 +165,7 @@ static void any_send(uint64_t val)
>       }
>   
>       addr = val & 0xffff;
> -    cs = qemu_get_cpu(cpuid);
> +    cs = ipi_getcpu(cpuid);
>       cpu = LOONGARCH_CPU(cs);
>       env = &cpu->env;
>       send_ipi_data(env, val, addr);
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index ced5a862f8..17bc37bccd 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -617,6 +617,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>               memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
>                                   sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
>                                   cpu));
> +        env->ipistate = ipi;
>       }
>   
>       /*
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 1f37e36b7c..b23f38c3d5 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -351,6 +351,8 @@ typedef struct CPUArchState {
>       MemoryRegion iocsr_mem;
>       bool load_elf;
>       uint64_t elf_address;
> +    /* Store ipistate to access from this struct */
> +    DeviceState *ipistate;
>   #endif
>   } CPULoongArchState;
>   


