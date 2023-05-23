Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E286470D9C2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1OqA-00031u-5y; Tue, 23 May 2023 06:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q1Oq7-00031m-EJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:01:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q1Oq2-0005qH-J9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:01:59 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Bxy_IJj2xkawYAAA--.164S3;
 Tue, 23 May 2023 18:01:45 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxBMUIj2xkcx1wAA--.57918S3; 
 Tue, 23 May 2023 18:01:44 +0800 (CST)
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, QEMU devel <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
 <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
 <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <29e26b7b-497c-a446-be86-8dda70b606d7@loongson.cn>
Date: Tue, 23 May 2023 18:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxBMUIj2xkcx1wAA--.57918S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw15Gr43uw1kWF15Zw1kXwb_yoW8CFyrpF
 W7Aa13tF4DtrnFka9Yg3s8uF1jkr1fJr47Wrs8X3429ayq9w18Wry8Cr4Uu3W7uwn8Jr1Y
 v3W0vasrCF17ZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
 kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
 AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
 cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
 80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
 yTuYvjxU2BT5DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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



在 2023/5/23 上午11:22, Jiaxun Yang 写道:
>
>> 2023年5月23日 02:25，Song Gao <gaosong@loongson.cn> 写道：
>>
>>
>>
>> 在 2023/5/22 下午9:44, Philippe Mathieu-Daudé 写道:
>>> On 22/5/23 13:47, Jiaxun Yang wrote:
>>>>
>>>>> 2023年5月22日 04:52，Huacai Chen <chenhuacai@kernel.org> 写道：
>>>>>
>>>>> Hi, Jiaxun,
>>>>>
>>>>> Rename loongarch_ipi to loongson_ipi? It will be shared by both MIPS
>>>>> and LoongArch in your series.
>>>> Hi Huacai,
>>>>
>>>> Thanks for the point, what’s the opinion from LoongArch mainatiners?
>>>>
>>>> Or perhaps rename it as loong_ipi to reflect the nature that it’s shared
>>>> by MIPS based Loongson and LoongArch based Loongson?
>>> I'm not a LoongArch maintainer, but a model named "loong_ipi" makes
>>> sense to me.
>>>
>>> Please add it to the two Virt machine sections in MAINTAINERS.
> Hi Song,
>
>> 'loonggson_ipi' is better, qemu doesn't have naming with 'loong' as prefix.
> Thanks, I’ll take looongson_ipi then.
>
>> And  patch2 should not use macros. Some attributes should be added to distinguish between MIPS and LongArch.
> By attribute do you mean property?
Yes.
> If so I don’t see any necessity, the IP block
> Is totally the same on MIPS and LoongArch. I’m guarding them out because
> We have different way to get IOCSR address space on MIPS, which is due
> to be implemented.
>
> I can further abstract out a function to get IOCSR address space. But still,
> I think the best way to differ those two architecture is using TARGET_* macros,
> as it doesn’t make much sense to have unused code for another architecture
> compiled.
Most of the code in hw/intc or hw/ uses property to distinguish between 
different devices,  not TARGE_* macro.

I still think it is better to use property.

Thanks.
Song Gao
>> All references to loongarch_ipi should also be changed.
> Sure.
>
> Thanks
> - Jiaxun


