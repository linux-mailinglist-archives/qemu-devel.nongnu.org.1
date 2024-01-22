Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEB835C24
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 08:57:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRpAg-00057S-OG; Mon, 22 Jan 2024 02:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rRpAd-000577-Ho
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:56:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rRpAY-0005ep-7S
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:56:38 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxXOmqH65lW20DAA--.3902S3;
 Mon, 22 Jan 2024 15:56:27 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxf8+nH65lnyERAA--.13983S3; 
 Mon, 22 Jan 2024 15:56:25 +0800 (CST)
Subject: Re: [PATCH 1/1] target/loongarch/kvm: Enable LSX/LASX extension
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org, zhaotianrui@loongson.cn
References: <20240122060901.4056487-1-gaosong@loongson.cn>
 <d1b0557a-b591-6bf1-6ad9-ed5103b44726@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <78b307de-d0e1-e127-37a4-87e36375f6b9@loongson.cn>
Date: Mon, 22 Jan 2024 15:56:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d1b0557a-b591-6bf1-6ad9-ed5103b44726@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxf8+nH65lnyERAA--.13983S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1Utr1ktr1kGF1kKw47Jrc_yoWrGF47pr
 n7AFW5Wry5Jrn3Jw1Ut34UXFyUXr4xGanrXr1xXFyjyr4UZr10gry0qrsFgF15Jw48Jr18
 tr1UZrnrZF1DJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.72,
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

在 2024/1/22 下午3:12, maobibo 写道:
>
>
> On 2024/1/22 下午2:09, Song Gao wrote:
>> The kernel had already support LSX and LASX [1],
>> but QEMU is disable LSX/LASX for kvm. This patch adds
>> kvm_check_cpucfg to check CPUCFG2.
>>
>> [1]: 
>> https://lore.kernel.org/all/CABgObfZHRf7E_7Jk4uPRmSyxTy3EiuuYwHC35jQncNL9s-zTDA@mail.gmail.com/
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   linux-headers/asm-loongarch/kvm.h |  1 +
>>   target/loongarch/kvm/kvm.c        | 35 ++++++++++++++++++++++++-------
>>   2 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/linux-headers/asm-loongarch/kvm.h 
>> b/linux-headers/asm-loongarch/kvm.h
>> index c6ad2ee610..923d0bd382 100644
>> --- a/linux-headers/asm-loongarch/kvm.h
>> +++ b/linux-headers/asm-loongarch/kvm.h
>> @@ -79,6 +79,7 @@ struct kvm_fpu {
>>   #define LOONGARCH_REG_64(TYPE, REG)    (TYPE | KVM_REG_SIZE_U64 | 
>> (REG << LOONGARCH_REG_SHIFT))
>>   #define KVM_IOC_CSRID(REG) LOONGARCH_REG_64(KVM_REG_LOONGARCH_CSR, 
>> REG)
>>   #define KVM_IOC_CPUCFG(REG) 
>> LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
>> +#define KVM_LOONGARCH_VCPU_CPUCFG    0
>>     struct kvm_debug_exit_arch {
>>   };
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 84bcdf5f86..41b6947c7b 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -537,6 +537,28 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>>       return ret;
>>   }
>>   +static int kvm_check_cpucfg(int id, CPUState *cs)
>> +{
>> +    int ret;
>> +    uint64_t val;
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_LOONGARCH_VCPU_CPUCFG,
>> +        .attr = id,
>> +        .addr = (uint64_t)&val,
>> +    };
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>> +
>> +    if (!ret) {
>> +        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
>> +        env->cpucfg[id] &= val;
> With feature bit represents supported or disabled, it is ok to use
> logic of qemu feature bitmap and kvm supported feature bitmap.
>
> However about feature version, there will be problem with "and logic".
> Can we use minimal version here?
>
Yes, we can,  I will correct it on v2.

Thanks.
Song Gao
> Regards
> Bibo Mao
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int kvm_loongarch_put_cpucfg(CPUState *cs)
>>   {
>>       int i, ret = 0;
>> @@ -545,14 +567,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>>       uint64_t val;
>>         for (i = 0; i < 21; i++) {
>> +    if (i == 2) {
>> +            ret = kvm_check_cpucfg(i, cs);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +    }
>>           val = env->cpucfg[i];
>> -        /* LSX and LASX and LBT are not supported in kvm now */
>> -        if (i == 2) {
>> -            val &= ~(BIT(R_CPUCFG2_LSX_SHIFT) | 
>> BIT(R_CPUCFG2_LASX_SHIFT));
>> -            val &= ~(BIT(R_CPUCFG2_LBT_X86_SHIFT) |
>> -                     BIT(R_CPUCFG2_LBT_ARM_SHIFT) |
>> -                     BIT(R_CPUCFG2_LBT_MIPS_SHIFT));
>> -        }
>>           ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>>           if (ret < 0) {
>>               trace_kvm_failed_put_cpucfg(strerror(errno));
>>


