Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B4B45420
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Sep 2025 12:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTM0-000702-8m; Fri, 05 Sep 2025 06:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uuTLx-0006zJ-1R
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:07:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uuTLs-0002oU-FI
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:07:32 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxqdFYtrpojgkHAA--.14892S3;
 Fri, 05 Sep 2025 18:07:20 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxQMJVtrpoFOJ_AA--.5218S3;
 Fri, 05 Sep 2025 18:07:19 +0800 (CST)
Subject: Re: [PATCH v6 08/11] hw/loongarch: Implement avec set irq
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-9-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6e1546d3-d9d3-a1ba-5373-ad826017ad93@loongson.cn>
Date: Fri, 5 Sep 2025 18:05:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxQMJVtrpoFOJ_AA--.5218S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF45Kr4rWF45GF45Gr4rZwc_yoW5ZFWfpa
 s7CF90gF48Jr47Z3Z3X3s8Z3Z8ZF4xWry2vanI9r9akF4xGr1kXrykJ39rZF48C3ykWr4j
 qr1rWa15ua47JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8P5r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
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



On 2025/9/4 下午8:18, Song Gao wrote:
> Implement avec set irq and update CSR_MSIS.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c         | 58 ++++++++++++++++++++++++++++++--
>   include/hw/intc/loongarch_avec.h |  3 ++
>   2 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index 1f9f376898..03a20a7b60 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -16,6 +16,13 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "hw/qdev-properties.h"
> +#include "target/loongarch/cpu.h"
> +#include "qemu/error-report.h"
> +
> +/* msg addr field */
> +FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
> +FIELD(MSG_ADDR, CPU_NUM, 12, 8)
> +FIELD(MSG_ADDR, FIX, 28, 12)
>   
>   static uint64_t loongarch_avec_mem_read(void *opaque,
>                                           hwaddr addr, unsigned size)
> @@ -23,13 +30,60 @@ static uint64_t loongarch_avec_mem_read(void *opaque,
>       return 0;
>   }
>   
> +static void do_set_vcpu_avec_irq(CPUState *cs, run_on_cpu_data data)
> +{
> +    AVECCore *core = data.host_ptr;
> +    CPULoongArchState *env;
> +
> +    assert(cs->cpu_index == core->dest_cpu);
> +    env = &LOONGARCH_CPU(cs)->env;
> +    if (core->level) {
> +        set_bit(core->pending, &env->CSR_MSGIS[core->pending / 64]);
> +    }
> +    g_free(core);
> +}
> +
> +
> +static void avec_update_csr(AVECCore *core, int cpu_num,
> +                            int irq_num, int level)
> +{
> +    CPUState *cs = qemu_get_cpu(cpu_num);
> +
> +    core->pending = irq_num;
> +    core->dest_cpu = cpu_num;
> +    core->level = level;
> +    async_run_on_cpu(cs, do_set_vcpu_avec_irq,
> +                         RUN_ON_CPU_HOST_PTR(core));
> +}
> +
> +static void avec_set_irq(LoongArchAVECState *s, int cpu_num,
> +                         int irq_num, int level)
> +{
> +    AVECCore *core;
> +
> +    core = g_new(AVECCore, 1);
> +
> +    if (level) {
> +        avec_update_csr(core, cpu_num, irq_num, level);
> +    }
> +    qemu_set_irq(s->cpu[cpu_num].parent_irq, level);

Is it possible that qemu_set_irq reaches before async_run_on_cpu?
since it is async function.

Regargs
Bibo Mao
> +}
> +
>   static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
>                                        uint64_t val, unsigned size)
>   {
> -    return;
> +    int irq_num, cpu_num = 0;
> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
> +    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
> +    CPUState *cs;
> +
> +    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +    cs = cpu_by_arch_id(cpu_num);
> +    cpu_num = cs->cpu_index;
> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
> +    avec_set_irq(s, cpu_num, irq_num, 1);
>   }
>   
> -
>   static const MemoryRegionOps loongarch_avec_ops = {
>       .read = loongarch_avec_mem_read,
>       .write = loongarch_avec_mem_write,
> diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
> index 3e8cf7d2c1..83656f8df4 100644
> --- a/include/hw/intc/loongarch_avec.h
> +++ b/include/hw/intc/loongarch_avec.h
> @@ -18,6 +18,9 @@ OBJECT_DECLARE_TYPE(LoongArchAVECState, LoongArchAVECClass, LOONGARCH_AVEC)
>   typedef struct AVECCore {
>       CPUState *cpu;
>       qemu_irq parent_irq;
> +    uint64_t pending;
> +    uint64_t dest_cpu;
> +    bool   level;
>       uint64_t arch_id;
>   } AVECCore;
>   
> 


