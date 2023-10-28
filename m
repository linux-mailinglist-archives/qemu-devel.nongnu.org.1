Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C07DA722
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 15:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwj4M-0005cy-SJ; Sat, 28 Oct 2023 09:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qwj4L-0005cD-9R
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 09:09:37 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qwj4J-0006h2-5I
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 09:09:37 -0400
Received: from [192.168.1.5] (unknown [223.72.62.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E89D744450;
 Sat, 28 Oct 2023 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698498567; bh=/jlTfz048H+6HUPKxpQft1mqyCDetkhrCNvlWAbwRmk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Fo01ef+v1LRE7iJb9FoJuqJ0olVGc2n6D1Svaxul0rMqjADxUEXo1Ko74Wcl4bpoq
 uG7RVw38vmbn4wjl8PWKjVJ+IkM53+x5Sty7JxafpYRd07i35UgcRMbCauJ899dc/h
 b9SXzkTWLHtEQFu+fj6S3gvvXYehOad9ooVUL53s=
Message-ID: <ae3088b6-f472-4dd2-a5bc-9effb61ffaa0@jia.je>
Date: Sat, 28 Oct 2023 21:09:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
To: gaosong <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, bibo mao <maobibo@loongson.cn>
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
 <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
 <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
 <062ee798-c112-46d4-82b8-983e85ffe2ed@jia.je>
 <6482c6cf-1f4b-a7b9-d106-4c687360e810@loongson.cn>
Content-Language: en-US
From: Jiajie Chen <c@jia.je>
In-Reply-To: <6482c6cf-1f4b-a7b9-d106-4c687360e810@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/10/26 14:54, gaosong wrote:
> 在 2023/10/26 上午9:38, Jiajie Chen 写道:
>>
>> On 2023/10/26 03:04, Richard Henderson wrote:
>>> On 10/25/23 10:13, Jiajie Chen wrote:
>>>>> On 2023/10/24 07:26, Richard Henderson wrote:
>>>>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, 
>>>>>> TCGv_i128 block.
>>>>>> See target/ppc/translate.c, gen_stqcx_.
>>>>>
>>>>> The situation here is slightly different: aarch64 and ppc64 have 
>>>>> both 128-bit ll and sc, however LoongArch v1.1 only has 64-bit ll 
>>>>> and 128-bit sc.
>>>
>>> Ah, that does complicate things.
>>>
>>>> Possibly use the combination of ll.d and ld.d:
>>>>
>>>>
>>>> ll.d lo, base, 0
>>>> ld.d hi, base, 4
>>>>
>>>> # do some computation
>>>>
>>>> sc.q lo, hi, base
>>>>
>>>> # try again if sc failed
>>>>
>>>> Then a possible implementation of gen_ll() would be: align base to 
>>>> 128-bit boundary, read 128-bit from memory, save 64-bit part to rd 
>>>> and record whole 128-bit data in llval. Then, in gen_sc_q(), it 
>>>> uses a 128-bit cmpxchg.
>>>>
>>>>
>>>> But what about the reversed instruction pattern: ll.d hi, base, 4; 
>>>> ld.d lo, base 0?
>>>
>>> It would be worth asking your hardware engineers about the bounds of 
>>> legal behaviour. Ideally there would be some very explicit language, 
>>> similar to
>>
>>
>> I'm a community developer not affiliated with Loongson. Song Gao, 
>> could you provide some detail from Loongson Inc.?
>>
>>
>
> ll.d   r1, base, 0
> dbar 0x700          ==> see 2.2.8.1
> ld.d  r2, base,  8
> ...
> sc.q r1, r2, base


Thanks! I think we may need to detect the ll.d-dbar-ld.d sequence and 
translate the sequence into one tcg_gen_qemu_ld_i128 and split the 
result into two 64-bit parts. Can do this in QEMU?


>
>
> For this series,
> I think we need set the new config bits to the 'max cpu', and change 
> linux-user/target_elf.h ''any' to 'max', so that we can use these new 
> instructions on linux-user mode.

I will work on it.


>
> Thanks
> Song Gao
>>>
>>> https://developer.arm.com/documentation/ddi0487/latest/
>>> B2.9.5 Load-Exclusive and Store-Exclusive instruction usage 
>>> restrictions
>>>
>>> But you could do the same thing, aligning and recording the entire 
>>> 128-bit quantity, then extract the ll.d result based on address bit 
>>> 6.  This would complicate the implementation of sc.d as well, but 
>>> would perhaps bring us "close enough" to the actual architecture.
>>>
>>> Note that our Arm store-exclusive implementation isn't quite in spec 
>>> either.  There is quite a large comment within translate-a64.c 
>>> store_exclusive() about the ways things are not quite right.  But it 
>>> seems to be close enough for actual usage to succeed.
>>>
>>>
>>> r~
>

