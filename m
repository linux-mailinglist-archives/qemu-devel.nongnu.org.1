Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8908216C8
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 04:59:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKVuy-0007YP-R1; Mon, 01 Jan 2024 22:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKVuu-0007Y2-Rg
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:58:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKVus-0008OR-CO
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:58:12 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxnuvOiZNl2wwBAA--.4455S3;
 Tue, 02 Jan 2024 11:58:06 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxmb3NiZNl4UAVAA--.36575S3; 
 Tue, 02 Jan 2024 11:58:05 +0800 (CST)
Subject: Re: [PATCH v3 8/9] target/loongarch: Implement set vcpu intr for kvm
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
 <20231228084051.3235354-9-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <150fb1b9-13af-30b2-04db-a84191243d4c@loongson.cn>
Date: Tue, 2 Jan 2024 11:58:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231228084051.3235354-9-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxmb3NiZNl4UAVAA--.36575S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw18KrWkGw1fJr4xCF4UAwc_yoW7Ar4kpF
 W7uFn0yr48JrZrJasxZ3Z8urn8Zr4xGr129a1Ig34xCr47X34UXr1vq3srXFZ8G3ykWr1I
 vF1Fkw15uF18X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wN
 VDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.014,
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


This patch also broken 'loongarch64-linux-user' build

在 2023/12/28 下午4:40, Tianrui Zhao 写道:
> Implement loongarch kvm set vcpu interrupt interface,
> when a irq is set in vcpu, we use the KVM_INTERRUPT
> ioctl to set intr into kvm.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu.c           | 32 +++++++++++++++++++++++---------
>   target/loongarch/kvm.c           | 15 +++++++++++++++
>   target/loongarch/kvm_loongarch.h | 16 ++++++++++++++++
>   target/loongarch/trace-events    |  1 +
>   4 files changed, 55 insertions(+), 9 deletions(-)
>   create mode 100644 target/loongarch/kvm_loongarch.h
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 83899c673f..caf82f9133 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -11,7 +11,6 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "sysemu/qtest.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"
>   #include "cpu.h"
>   #include "internals.h"
> @@ -20,8 +19,16 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/reset.h"
>   #endif
> -#include "tcg/tcg.h"
>   #include "vec.h"
> +#include "sysemu/kvm.h"
> +#include "kvm_loongarch.h"
> +#ifdef CONFIG_KVM
> +#include <linux/kvm.h>
> +#endif
> +#ifdef CONFIG_TCG
> +#include "exec/cpu_ldst.h"
> +#include "tcg/tcg.h"
> +#endif
>   
>   const char * const regnames[32] = {
>       "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> @@ -110,12 +117,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> -    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> -
> -    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
> -        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    if (kvm_enabled()) {
> +        kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else {
> -        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> +        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
>       }
>   }
>   
> @@ -140,7 +150,9 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>   
>       return (pending & status) != 0;
>   }
> +#endif
>   
> +#ifdef CONFIG_TCG
here
+#ifndef CONFIG_USER_ONLY
>   static void loongarch_cpu_do_interrupt(CPUState *cs)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> @@ -320,9 +332,7 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       }
>       return false;
>   }
> -#endif
>   
> -#ifdef CONFIG_TCG
here
+#endif

Otherwise
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
>                                                 const TranslationBlock *tb)
>   {
> @@ -560,7 +570,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
>       }
>   #endif
>   
> +#ifdef CONFIG_TCG
>       restore_fp_status(env);
> +#endif
>       cs->exception_index = -1;
>   }
>   
> @@ -802,7 +814,9 @@ static struct TCGCPUOps loongarch_tcg_ops = {
>   #include "hw/core/sysemu-cpu-ops.h"
>   
>   static const struct SysemuCPUOps loongarch_sysemu_ops = {
> +#ifdef CONFIG_TCG
>       .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
> +#endif
>   };
>   
>   static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
> diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
> index d2dab3fef4..bd33ec2114 100644
> --- a/target/loongarch/kvm.c
> +++ b/target/loongarch/kvm.c
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
> diff --git a/target/loongarch/kvm_loongarch.h b/target/loongarch/kvm_loongarch.h
> new file mode 100644
> index 0000000000..d945b6bb82
> --- /dev/null
> +++ b/target/loongarch/kvm_loongarch.h
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
> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
> index 021839880e..dea11edc0f 100644
> --- a/target/loongarch/trace-events
> +++ b/target/loongarch/trace-events
> @@ -12,3 +12,4 @@ kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>   kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>   kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
>   kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
> +kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"


