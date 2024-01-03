Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E48226CB
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 03:12:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKqk9-0002uj-Pb; Tue, 02 Jan 2024 21:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKqk8-0002ub-IJ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:12:28 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKqk6-0007ZJ-9M
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:12:28 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxquqHwpRlNV0BAA--.4639S3;
 Wed, 03 Jan 2024 10:12:23 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3uSGwpRlQHwXAA--.5397S3; 
 Wed, 03 Jan 2024 10:12:22 +0800 (CST)
Subject: Re: [PATCH v3 6/9] target/loongarch: Implement kvm_arch_init_vcpu
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
 <20231228084051.3235354-7-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <423b9459-83a8-8764-b224-14d751f4c864@loongson.cn>
Date: Wed, 3 Jan 2024 10:12:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231228084051.3235354-7-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx3uSGwpRlQHwXAA--.5397S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw1fuF4xCr1kGr4fCFy8WFX_yoW5Aw1kpr
 srC3Z8KrW8trZrt3Waq3W5Xr1DWr1xGF4avayxKryxCFsxJ3s3Zw4ktws8CF4rJ3y8WFyv
 vF1F9rWq9FWFq3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 cHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.762, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2023/12/28 ÏÂÎç4:40, Tianrui Zhao Ð´µÀ:
> Implement kvm_arch_init_vcpu interface for loongarch,
> in this function, we register VM change state handler.
> And when VM state changes to running, the counter value
> should be put into kvm to keep consistent with kvm,
> and when state change to stop, counter value should be
> refreshed from kvm.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu.h        |  2 ++
>   target/loongarch/kvm.c        | 23 +++++++++++++++++++++++
>   target/loongarch/trace-events |  2 ++
>   3 files changed, 27 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index f4a89bd626..8ebd6fa1a7 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -381,6 +381,8 @@ struct ArchCPU {
>   
>       /* 'compatible' string for this CPU for Linux device trees */
>       const char *dtb_compatible;
> +    /* used by KVM_REG_LOONGARCH_COUNTER ioctl to access guest time counters */
> +    uint64_t kvm_state_counter;
>   };
>   
>   /**
> diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
> index 29944b9ef8..85e7aeb083 100644
> --- a/target/loongarch/kvm.c
> +++ b/target/loongarch/kvm.c
> @@ -617,8 +617,31 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>       return ret;
>   }
>   
> +static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
> +                                          RunState state)
> +{
> +    int ret;
> +    CPUState *cs = opaque;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    if (running) {
> +        ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_COUNTER,
> +                              &cpu->kvm_state_counter);
> +        if (ret < 0) {
> +            trace_kvm_failed_put_counter(strerror(errno));
> +        }
> +    } else {
> +        ret = kvm_get_one_reg(cs, KVM_REG_LOONGARCH_COUNTER,
> +                              &cpu->kvm_state_counter);
> +        if (ret < 0) {
> +            trace_kvm_failed_get_counter(strerror(errno));
> +        }
> +    }
> +}
> +
>   int kvm_arch_init_vcpu(CPUState *cs)
>   {
> +    qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
>       return 0;
>   }
>   
> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
> index 6827ab566a..937c3c7c0c 100644
> --- a/target/loongarch/trace-events
> +++ b/target/loongarch/trace-events
> @@ -7,5 +7,7 @@ kvm_failed_get_fpu(const char *msg) "Failed to get fpu from KVM: %s"
>   kvm_failed_put_fpu(const char *msg) "Failed to put fpu into KVM: %s"
>   kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
>   kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
> +kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
> +kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>   kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>   kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"


