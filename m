Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C17C4E96
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRC-0008NB-FF; Wed, 11 Oct 2023 05:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qqVR2-0007Va-O6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qqVQv-0004yk-UE
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:20 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dxfet5aSZlbfcwAA--.26218S3;
 Wed, 11 Oct 2023 17:23:05 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHC92aSZlhSIgAA--.3006S2; 
 Wed, 11 Oct 2023 17:23:04 +0800 (CST)
Subject: Re: [PATCH RFC v4 4/9] target/loongarch: Implement kvm get/set
 registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <cover.1696841645.git.lixianglai@loongson.cn>
 <f4399db694265f34dbe9aafd024c56470e8a0f54.1696841645.git.lixianglai@loongson.cn>
 <1f552f71-3b47-a2be-67c5-fdca86bf59f7@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <e1a55222-a588-3921-627a-da8ffa3e7297@loongson.cn>
Date: Wed, 11 Oct 2023 17:23:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1f552f71-3b47-a2be-67c5-fdca86bf59f7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxHC92aSZlhSIgAA--.3006S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4xXrW5tF1kZFWftFy3Jrc_yoWrZr1kpr
 18Jr1UJryUJr18Jr1UJr1UJFyUJr1UJw1UXr1xJF1UAr1UJr1jqr1UXr1jgr1UJr48Jr1U
 Jr1UJr1UZr1UJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25Ef
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
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

Hi Philippe Mathieu-Daudé:

> Hi Li and Zhao,
>
> On 9/10/23 11:01, xianglai li wrote:
>> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>>
>> Implement kvm_arch_get/set_registers interfaces, many regs
>> can be get/set in the function, such as core regs, csr regs,
>> fpu regs, mp state, etc.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
>>
>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   meson.build                   |   1 +
>>   target/loongarch/cpu.c        |   3 +
>>   target/loongarch/cpu.h        |   2 +
>>   target/loongarch/kvm.c        | 406 +++++++++++++++++++++++++++++++++-
>>   target/loongarch/trace-events |  13 ++
>>   target/loongarch/trace.h      |   1 +
>>   6 files changed, 424 insertions(+), 2 deletions(-)
>>   create mode 100644 target/loongarch/trace-events
>>   create mode 100644 target/loongarch/trace.h
>
>
>> +static int kvm_larch_getq(CPUState *cs, uint64_t reg_id,
>> +                                 uint64_t *addr)
>> +{
>> +    struct kvm_one_reg csrreg = {
>> +        .id = reg_id,
>> +        .addr = (uintptr_t)addr
>> +    };
>> +
>> +    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &csrreg);
>> +}
>
> This is kvm_get_one_reg().

I'll replace kvm_larch_getq() with kvm_get_one_reg().


>
>
>> +static int kvm_larch_putq(CPUState *cs, uint64_t reg_id,
>> +                                 uint64_t *addr)
>> +{
>> +    struct kvm_one_reg csrreg = {
>> +        .id = reg_id,
>> +        .addr = (uintptr_t)addr
>> +    };
>> +
>> +    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &csrreg);
>> +}
>
> This is kvm_set_one_reg().
>
I'll replace kvm_larch_putq() with kvm_set_one_reg().

Thanks,

Xianglai.


>> +
>> +#define KVM_GET_ONE_UREG64(cs, ret, regidx, addr)                 \
>> + ({                                                            \
>> +        err = kvm_larch_getq(cs, KVM_IOC_CSRID(regidx), addr);    \
>> +        if (err < 0) {                                            \
>> +            ret = err;                                            \
>> +            trace_kvm_failed_get_csr(regidx, strerror(errno));    \
>> + }                                                         \
>> +    })
>> +
>> +#define KVM_PUT_ONE_UREG64(cs, ret, regidx, addr)                 \
>> + ({                                                            \
>> +        err = kvm_larch_putq(cs, KVM_IOC_CSRID(regidx), addr);    \
>> +        if (err < 0) {                                            \
>> +            ret = err;                                            \
>> +            trace_kvm_failed_put_csr(regidx, strerror(errno));    \
>> + }                                                         \
>> +    })
>


