Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F48D1BD9
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 14:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwO2-0001G6-Rp; Tue, 28 May 2024 08:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sBwNz-0001E3-4i
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:57:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sBwNv-0001xo-R5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:57:02 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bxb+uW1FVmq7AAAA--.3165S3;
 Tue, 28 May 2024 20:56:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHMeU1FVmc+8LAA--.31507S3; 
 Tue, 28 May 2024 20:56:54 +0800 (CST)
Subject: Re: [RFC v2 1/2] target/loongarch: Add loongson binary translation
 feature
To: maobibo <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240527083501.844854-1-maobibo@loongson.cn>
 <20240527083501.844854-2-maobibo@loongson.cn>
 <40cad008-6959-495c-97c0-978c0868bf86@linaro.org>
 <765c5c3e-5d8f-cf48-6e24-ac027ac834b6@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <fda2e584-a9d8-c656-0113-1532841c7230@loongson.cn>
Date: Tue, 28 May 2024 20:56:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <765c5c3e-5d8f-cf48-6e24-ac027ac834b6@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxHMeU1FVmc+8LAA--.31507S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4UGrW5Cr15CFyxXrW8GrX_yoW5tryxpr
 1kAFW5AryUJrn3Aw43X345XFy5Jr48Jw1UWF1fJFyUAF4DGr12qr18Xr4vgF1DJw48XF10
 qr15JrnxuFn8AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.786,
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

在 2024/5/28 上午9:07, maobibo 写道:
> Hi Philippe,
>
> Thanks for reviewing my patch.
> I reply inline.
>
> On 2024/5/27 下午6:37, Philippe Mathieu-Daudé wrote:
>> Hi Bibo,
>>
>> On 27/5/24 10:35, Bibo Mao wrote:
>>> Loongson Binary Translation (LBT) is used to accelerate binary
>>> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
>>> eflags (eflags) and x87 fpu stack pointer (ftop).
>>>
>>> Now LBT feature is added in kvm mode, not supported in TCG mode since
>>> it is not emulated. There are two feature flags such as forced_features
>>> and default_features for each vcpu, the real feature is still in 
>>> cpucfg.
>>> Flag forced_features is parsed from command line, default_features is
>>> parsed from cpu type.
>>>
>>> Flag forced_features has higher priority than flag default_features,
>>> default_features will be used if there is no command line option for 
>>> LBT
>>> feature. If the feature is not supported with KVM host, it reports 
>>> error
>>> and exits if forced_features is set, else it disables feature and 
>>> continues
>>> if default_features is set.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   target/loongarch/cpu.c                | 69 
>>> +++++++++++++++++++++++++++
>>>   target/loongarch/cpu.h                | 12 +++++
>>>   target/loongarch/kvm/kvm.c            | 26 ++++++++++
>>>   target/loongarch/kvm/kvm_loongarch.h  | 16 +++++++
>>>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>>>   5 files changed, 124 insertions(+), 1 deletion(-)
>>
>>
>>> +static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
>>> +{
>>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>>> +
>>> +    if (!kvm_enabled()) {
>>
>> Either set errp, ...
>>
>>> +        return;
>>> +    }
>>> +
>>> +    if (value) {
>>> +        /* Enable binary translation for all architectures */
>>> +        cpu->env.forced_features |= BIT_ULL(LOONGARCH_FEATURE_LBT);
>>> +    } else {
>>> +        /* Disable default features also */
>>> +        cpu->env.default_features &= ~BIT_ULL(LOONGARCH_FEATURE_LBT);
>>> +    }
>>> +}
>>> +
>>>   void loongarch_cpu_post_init(Object *obj)
>>>   {
>>>       object_property_add_bool(obj, "lsx", loongarch_get_lsx,
>>>                                loongarch_set_lsx);
>>>       object_property_add_bool(obj, "lasx", loongarch_get_lasx,
>>>                                loongarch_set_lasx);
>>
>> ... or only add the property if KVM is enabled:
>>
>>     if (kvm_enabled()) {
> Sure, will do. I think this method is better.
>
> By the way bitmap method forced_features/default_feature is variant
> of OnOffAuto method. Bitmap method uses two bit, OnOffAuto method uses 
> separate feature variable. We do not know which method is better or 
> which is the future trend.
>
I think the OnOffAuto variable is better.

The default_features is just a copy of cpucfg, and is not required.

Thanks.
Song Gao
> Regards
> Bibo Mao
>>
>>> +    object_property_add_bool(obj, "lbt", loongarch_get_lbt,
>>> +                             loongarch_set_lbt);
>>>   }


