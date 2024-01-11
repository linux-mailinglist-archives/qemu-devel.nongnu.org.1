Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6182A606
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 03:31:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNkpX-0006pg-EJ; Wed, 10 Jan 2024 21:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNkpU-0006pF-1T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:30:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNkpQ-0002Ng-GG
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:29:59 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLLucUp9lLR0EAA--.4125S3;
 Thu, 11 Jan 2024 10:29:49 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxK9yaUp9lkw0OAA--.37431S3; 
 Thu, 11 Jan 2024 10:29:48 +0800 (CST)
Subject: Re: [PATCH v4 8/9b] target/loongarch: Implement set vcpu intr for kvm
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>
References: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
 <20240110094152.52138-2-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a9ebc41a-64b6-3662-23ff-452bd98052f9@loongson.cn>
Date: Thu, 11 Jan 2024 10:29:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240110094152.52138-2-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxK9yaUp9lkw0OAA--.37431S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw18KrWkGw1fJrWxZw17twc_yoW7WF18pF
 ZruFn8KrWrJrZ7Jas3Za45Z34DXr4fGw12vayxta4xCr47try0qF1vqrnFgFy5G3y8WFyI
 qF1fC3Wj9F1UXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.07,
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

Hi,

在 2024/1/10 下午5:41, Philippe Mathieu-Daudé 写道:
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>
> Implement loongarch kvm set vcpu interrupt interface,
> when a irq is set in vcpu, we use the KVM_INTERRUPT
> ioctl to set intr into kvm.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
> [PMD: Split from bigger patch, part 2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/kvm/kvm_loongarch.h | 16 ++++++++++++++++
>   target/loongarch/cpu.c               |  9 ++++++++-
>   target/loongarch/kvm/kvm.c           | 15 +++++++++++++++
>   target/loongarch/trace-events        |  1 +
>   4 files changed, 40 insertions(+), 1 deletion(-)
>   create mode 100644 target/loongarch/kvm/kvm_loongarch.h
>
> diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
> new file mode 100644
> index 0000000000..d945b6bb82
> --- /dev/null
> +++ b/target/loongarch/kvm/kvm_loongarch.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU LoongArch kvm interface
> + *
> + * Copyright (c) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include "cpu.h"
> +
> +#ifndef QEMU_KVM_LOONGARCH_H
> +#define QEMU_KVM_LOONGARCH_H
> +
> +int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
> +void kvm_arch_reset_vcpu(CPULoongArchState *env);
> +
> +#endif
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index d9f8661cfd..d3a8a2f521 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -12,6 +12,7 @@
>   #include "qemu/module.h"
>   #include "sysemu/qtest.h"
>   #include "sysemu/tcg.h"
> +#include "sysemu/kvm.h"
>   #include "exec/exec-all.h"
>   #include "cpu.h"
>   #include "internals.h"
> @@ -21,6 +22,10 @@
>   #include "sysemu/reset.h"
>   #endif
>   #include "vec.h"
> +#ifdef CONFIG_KVM
> +#include "kvm/kvm_loongarch.h"

This broken  tcg 'loongarch64-softmmu' build on X86 host, :-[

../target/loongarch/cpu.c: In function ‘loongarch_cpu_set_irq’:
../target/loongarch/cpu.c:122:9: error: implicit declaration of function 
‘kvm_loongarch_set_interrupt’ [-Werror=implicit-function-declaration]
   122 |         kvm_loongarch_set_interrupt(cpu, irq, level);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/loongarch/cpu.c:122:9: error: nested extern declaration of 
‘kvm_loongarch_set_interrupt’ [-Werror=nested-externs]
../target/loongarch/cpu.c: In function ‘loongarch_cpu_reset_hold’:
../target/loongarch/cpu.c:557:9: error: implicit declaration of function 
‘kvm_arch_reset_vcpu’; did you mean ‘kvm_arch_init_vcpu’? 
[-Werror=implicit-function-declaration]
   557 |         kvm_arch_reset_vcpu(env);
       |         ^~~~~~~~~~~~~~~~~~~
       |         kvm_arch_init_vcpu
../target/loongarch/cpu.c:557:9: error: nested extern declaration of 
‘kvm_arch_reset_vcpu’ [-Werror=nested-externs]
cc1: all warnings being treated as errors

I will move it out of  '#ifdef CONFIG_KVM'

Thanks.
Song Gao
> +#include <linux/kvm.h>
> +#endif
>   #ifdef CONFIG_TCG
>   #include "exec/cpu_ldst.h"
>   #include "tcg/tcg.h"
> @@ -113,7 +118,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> -    if (tcg_enabled()) {
> +    if (kvm_enabled()) {
> +        kvm_loongarch_set_interrupt(cpu, irq, level);
> +    } else if (tcg_enabled()) {
>           env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
>           if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
>               cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index d2dab3fef4..bd33ec2114 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -748,6 +748,21 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>       return ret;
>   }
>   
> +int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
> +{
> +    struct kvm_interrupt intr;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (level) {
> +        intr.irq = irq;
> +    } else {
> +        intr.irq = -irq;
> +    }
> +
> +    trace_kvm_set_intr(irq, level);
> +    return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
> +}
> +
>   void kvm_arch_accel_class_init(ObjectClass *oc)
>   {
>   }
> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
> index 021839880e..dea11edc0f 100644
> --- a/target/loongarch/trace-events
> +++ b/target/loongarch/trace-events
> @@ -12,3 +12,4 @@ kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>   kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>   kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
>   kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
> +kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"


