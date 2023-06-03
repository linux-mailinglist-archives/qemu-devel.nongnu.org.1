Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D085C720E83
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 09:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5LqN-0002xH-KB; Sat, 03 Jun 2023 03:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1q5LqK-0002wo-1g
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:38:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1q5LqG-0006om-Dc
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:38:31 -0400
Received: from loongson.cn (unknown [10.20.42.170])
 by gateway (Coremail) with SMTP id _____8Bxq+ro7XpkgeIDAA--.4099S3;
 Sat, 03 Jun 2023 15:38:16 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx87Dn7XpkAAuHAA--.22468S3; 
 Sat, 03 Jun 2023 15:38:16 +0800 (CST)
Message-ID: <08ed3e4a-f027-cbe0-23d6-b426544119ad@loongson.cn>
Date: Sat, 3 Jun 2023 15:38:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, QEMU devel
 <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
 <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
 <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
 <29e26b7b-497c-a446-be86-8dda70b606d7@loongson.cn>
 <B5BE30A5-7DE7-479A-B012-23076EFA7831@flygoat.com>
 <2bb3f255-1401-0ba3-20c9-a6e10a176474@linaro.org>
From: "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <2bb3f255-1401-0ba3-20c9-a6e10a176474@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx87Dn7XpkAAuHAA--.22468S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7urW3XF4Uuw13WryrtrW7twb_yoW8ur48pF
 y7tFs09F4DtFy5K34Fgwn09Fn0vF4xGa1Uurn5Xw4qka1qvryrW34YkrsxuFn8Ar4kJr1Y
 v3WqvFn7ZF17taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bh8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
 x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7
 CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
 4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
 k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
 6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2BT5DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
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



在 2023/5/23 21:07, Philippe Mathieu-Daudé 写道:
> On 23/5/23 13:18, Jiaxun Yang wrote:
>>
>>
>>> 2023年5月23日 11:01，Song Gao <gaosong@loongson.cn> 写道：
>>>
>>>
>>>
>>> 在 2023/5/23 上午11:22, Jiaxun Yang 写道:
>> [...]
>>>>
>>>>>
>>>> Is totally the same on MIPS and LoongArch. I’m guarding them out because
>>>> We have different way to get IOCSR address space on MIPS, which is due
>>>> to be implemented.
>>>>
>>>> I can further abstract out a function to get IOCSR address space. But still,
>>>> I think the best way to differ those two architecture is using TARGET_* macros,
>>>> as it doesn’t make much sense to have unused code for another architecture
>>>> compiled.
>>> Most of the code in hw/intc or hw/ uses property to distinguish between different devices,  not TARGE_* macro.
>>
>> They are the *same* device, with different way to handle IOCSR address space.
>>
>> Another problem is casting CPUState with LOONGARCH_CPU() is something invalid on
>> MIPS, vice-versa. We are potentially introducing a security issue here.
>>
>> I know nobody have done something like this before, but not necessarily to be a bad idea.
>>
>> I’ll introduce something like:
>>
>> +#ifdef TARGET_LOONGARCH64
>> +static inline void *AddressSpace get_iocsr_as(int cpuid)
>> +{
>> +    CPUState *cs = qemu_get_cpu(cpuid);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +
>> +    return &cpu->env.address_space_iocsr;
>> +}
>> +#endif
>> +
>> +#ifdef TARGET_MIPS64
>> +static inline void *AddressSpace get_iocsr_as(int cpuid)
>> +{
>> +    CPUState *cs = qemu_get_cpu(cpuid);
>> +    MIPSCPU *cpu = MIPS_CPU(cs);
>> +
>> +    return &cpu->env.iocsr.as;
>> +}
>> +#endif
> 
> Introduce a QOM interface that provides a get_iocsr_as() implementation.
> 
> See for example how TYPE_IDAU_INTERFACE works.
another simple method, rename loongarch_ipi.c with loong_ipi_common.c, adding extra two 
files loongarch_ipi.c and loongson_ipi.c inheriting from loong_ipi_common.c

Regards
Bibo, Mao


