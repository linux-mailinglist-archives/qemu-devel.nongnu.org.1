Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1983885F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBcs-00069E-LV; Tue, 23 Jan 2024 02:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rSBce-00068o-LZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 02:55:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rSBcb-00047l-1T
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 02:55:04 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxWPDIcK9lpxAEAA--.16352S3;
 Tue, 23 Jan 2024 15:54:49 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVMzEcK9lQvETAA--.29438S3; 
 Tue, 23 Jan 2024 15:54:47 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch/kvm: Enable LSX/LASX extension
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org, zhaotianrui@loongson.cn
References: <20240122090206.1083584-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <cf038e76-b95d-b145-1e40-2201d9ba4581@loongson.cn>
Date: Tue, 23 Jan 2024 15:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240122090206.1083584-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVMzEcK9lQvETAA--.29438S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1rWFWrWFWUtF43WFykZwc_yoW5Cr1kpF
 47AFsYgryrtr9rGwsFq34qqr43Zr4xGwsrua47XrZ2yrn0vr1xW34ktanrGF15Gw18Gay0
 vF4vyan09a1kJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.22,
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



On 2024/1/22 下午5:02, Song Gao wrote:
> The kernel had already support LSX and LASX [1],
> but QEMU is disable LSX/LASX for kvm. This patch adds
> kvm_check_cpucfg2() to check CPUCFG2.
> 
> [1]: https://lore.kernel.org/all/CABgObfZHRf7E_7Jk4uPRmSyxTy3EiuuYwHC35jQncNL9s-zTDA@mail.gmail.com/
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   linux-headers/asm-loongarch/kvm.h |  1 +
>   target/loongarch/kvm/kvm.c        | 45 ++++++++++++++++++++++++++-----
>   2 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
> index c6ad2ee610..923d0bd382 100644
> --- a/linux-headers/asm-loongarch/kvm.h
> +++ b/linux-headers/asm-loongarch/kvm.h
> @@ -79,6 +79,7 @@ struct kvm_fpu {
>   #define LOONGARCH_REG_64(TYPE, REG)	(TYPE | KVM_REG_SIZE_U64 | (REG << LOONGARCH_REG_SHIFT))
>   #define KVM_IOC_CSRID(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CSR, REG)
>   #define KVM_IOC_CPUCFG(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
> +#define KVM_LOONGARCH_VCPU_CPUCFG	0
>   
>   struct kvm_debug_exit_arch {
>   };
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 84bcdf5f86..2712bb7ab6 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -537,6 +537,38 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>       return ret;
>   }
>   
> +static int kvm_check_cpucfg2(CPUState *cs)
> +{
> +    int ret;
> +    uint64_t val;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_LOONGARCH_VCPU_CPUCFG,
> +        .attr = 2,
> +        .addr = (uint64_t)&val,
> +    };
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
> +
> +    if (!ret) {
> +        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +        env->cpucfg[2] &= val;
> +
> +        if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
> +            /* The FP minimal version is 1. */
> +            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, FP_VER, 1);
> +        }
> +
> +        if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LLFTP)) {
> +            /* The LLFTP minimal version is 1. */
> +            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LLFTP_VER, 1);
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>   static int kvm_loongarch_put_cpucfg(CPUState *cs)
>   {
>       int i, ret = 0;
> @@ -545,14 +577,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>       uint64_t val;
>   
>       for (i = 0; i < 21; i++) {
> +	if (i == 2) {
> +            ret = kvm_check_cpucfg2(cs);
> +            if (ret) {
> +                return ret;
> +            }
> +	}
>           val = env->cpucfg[i];
> -        /* LSX and LASX and LBT are not supported in kvm now */
> -        if (i == 2) {
> -            val &= ~(BIT(R_CPUCFG2_LSX_SHIFT) | BIT(R_CPUCFG2_LASX_SHIFT));
> -            val &= ~(BIT(R_CPUCFG2_LBT_X86_SHIFT) |
> -                     BIT(R_CPUCFG2_LBT_ARM_SHIFT) |
> -                     BIT(R_CPUCFG2_LBT_MIPS_SHIFT));
> -        }
>           ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>           if (ret < 0) {
>               trace_kvm_failed_put_cpucfg(strerror(errno));
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


