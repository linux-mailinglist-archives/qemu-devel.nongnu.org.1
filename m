Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B07D7D18
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuGo-0007W3-Al; Thu, 26 Oct 2023 02:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qvuGg-0007Vb-4u
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:55:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qvuGQ-0004Ph-E0
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:54:57 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxxPAoDTplwcA0AA--.38586S3;
 Thu, 26 Oct 2023 14:54:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxeuQjDTpl9VUzAA--.45551S3; 
 Thu, 26 Oct 2023 14:54:29 +0800 (CST)
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
To: Jiajie Chen <c@jia.je>, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org
Cc: git@xen0n.name, bibo mao <maobibo@loongson.cn>
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
 <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
 <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
 <062ee798-c112-46d4-82b8-983e85ffe2ed@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6482c6cf-1f4b-a7b9-d106-4c687360e810@loongson.cn>
Date: Thu, 26 Oct 2023 14:54:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <062ee798-c112-46d4-82b8-983e85ffe2ed@jia.je>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxeuQjDTpl9VUzAA--.45551S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1UAry5Aw1UWF18Ar15ZFc_yoW8Kw13pF
 Z5AFWxKF4jqan7Cr4Fgw1UZrW5tFyxJa45Wr95KFy8Kas0vF9agw4xtanI9a90qrWkuw10
 qry2v34fZF15ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

在 2023/10/26 上午9:38, Jiajie Chen 写道:
>
> On 2023/10/26 03:04, Richard Henderson wrote:
>> On 10/25/23 10:13, Jiajie Chen wrote:
>>>> On 2023/10/24 07:26, Richard Henderson wrote:
>>>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 
>>>>> block.
>>>>> See target/ppc/translate.c, gen_stqcx_.
>>>>
>>>> The situation here is slightly different: aarch64 and ppc64 have 
>>>> both 128-bit ll and sc, however LoongArch v1.1 only has 64-bit ll 
>>>> and 128-bit sc.
>>
>> Ah, that does complicate things.
>>
>>> Possibly use the combination of ll.d and ld.d:
>>>
>>>
>>> ll.d lo, base, 0
>>> ld.d hi, base, 4
>>>
>>> # do some computation
>>>
>>> sc.q lo, hi, base
>>>
>>> # try again if sc failed
>>>
>>> Then a possible implementation of gen_ll() would be: align base to 
>>> 128-bit boundary, read 128-bit from memory, save 64-bit part to rd 
>>> and record whole 128-bit data in llval. Then, in gen_sc_q(), it uses 
>>> a 128-bit cmpxchg.
>>>
>>>
>>> But what about the reversed instruction pattern: ll.d hi, base, 4; 
>>> ld.d lo, base 0?
>>
>> It would be worth asking your hardware engineers about the bounds of 
>> legal behaviour. Ideally there would be some very explicit language, 
>> similar to
>
>
> I'm a community developer not affiliated with Loongson. Song Gao, 
> could you provide some detail from Loongson Inc.?
>
>

ll.d   r1, base, 0
dbar 0x700          ==> see 2.2.8.1
ld.d  r2, base,  8
...
sc.q r1, r2, base


For this series,
I think we need set the new config bits to the 'max cpu', and change 
linux-user/target_elf.h ''any' to 'max', so that we can use these new 
instructions on linux-user mode.

Thanks
Song Gao
>>
>> https://developer.arm.com/documentation/ddi0487/latest/
>> B2.9.5 Load-Exclusive and Store-Exclusive instruction usage restrictions
>>
>> But you could do the same thing, aligning and recording the entire 
>> 128-bit quantity, then extract the ll.d result based on address bit 
>> 6.  This would complicate the implementation of sc.d as well, but 
>> would perhaps bring us "close enough" to the actual architecture.
>>
>> Note that our Arm store-exclusive implementation isn't quite in spec 
>> either.  There is quite a large comment within translate-a64.c 
>> store_exclusive() about the ways things are not quite right.  But it 
>> seems to be close enough for actual usage to succeed.
>>
>>
>> r~


