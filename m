Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839147DC931
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkoj-0006zd-Pk; Tue, 31 Oct 2023 05:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qxkoh-0006zM-Jj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:13:43 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qxkoV-0000lE-1w
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:13:42 -0400
Received: from [192.168.1.5] (unknown [223.72.62.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E344C4456C;
 Tue, 31 Oct 2023 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698743608; bh=/6F7qNL5O8UezCzbMBO9JZdBSkMWdWF9nmQNpn8A81k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cmxGGtp6ZXWzuSlCE1DbellAN6knVlhPMUvqsYroyzTxTXruss7QKV5h4G7eMuT2H
 2hmhLFiIjTqNCvQq4j7zqV8f+GpfCkrP++a3DoH2r0c758JEh0FoqNTGcMhe58YBti
 by/qnomLcdEvxaQ3eJGPk0es5l+t9GpKk8E6Faz4=
Message-ID: <5cffe61f-6aac-4765-a39b-68f1c90daa09@jia.je>
Date: Tue, 31 Oct 2023 17:13:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
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
 <ae3088b6-f472-4dd2-a5bc-9effb61ffaa0@jia.je>
 <b03d1fa3-b553-734b-7adf-839dc67a2dd5@loongson.cn>
 <603b8709-4288-4268-abd4-642366b0b7e2@jia.je>
 <798c78df-cc9d-78dd-5bbd-0de2ead0eb1f@loongson.cn>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <798c78df-cc9d-78dd-5bbd-0de2ead0eb1f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


On 2023/10/31 17:11, gaosong wrote:
> 在 2023/10/30 下午7:54, Jiajie Chen 写道:
>>
>> On 2023/10/30 16:23, gaosong wrote:
>>> 在 2023/10/28 下午9:09, Jiajie Chen 写道:
>>>>
>>>> On 2023/10/26 14:54, gaosong wrote:
>>>>> 在 2023/10/26 上午9:38, Jiajie Chen 写道:
>>>>>>
>>>>>> On 2023/10/26 03:04, Richard Henderson wrote:
>>>>>>> On 10/25/23 10:13, Jiajie Chen wrote:
>>>>>>>>> On 2023/10/24 07:26, Richard Henderson wrote:
>>>>>>>>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, 
>>>>>>>>>> TCGv_i128 block.
>>>>>>>>>> See target/ppc/translate.c, gen_stqcx_.
>>>>>>>>>
>>>>>>>>> The situation here is slightly different: aarch64 and ppc64 
>>>>>>>>> have both 128-bit ll and sc, however LoongArch v1.1 only has 
>>>>>>>>> 64-bit ll and 128-bit sc.
>>>>>>>
>>>>>>> Ah, that does complicate things.
>>>>>>>
>>>>>>>> Possibly use the combination of ll.d and ld.d:
>>>>>>>>
>>>>>>>>
>>>>>>>> ll.d lo, base, 0
>>>>>>>> ld.d hi, base, 4
>>>>>>>>
>>>>>>>> # do some computation
>>>>>>>>
>>>>>>>> sc.q lo, hi, base
>>>>>>>>
>>>>>>>> # try again if sc failed
>>>>>>>>
>>>>>>>> Then a possible implementation of gen_ll() would be: align base 
>>>>>>>> to 128-bit boundary, read 128-bit from memory, save 64-bit part 
>>>>>>>> to rd and record whole 128-bit data in llval. Then, in 
>>>>>>>> gen_sc_q(), it uses a 128-bit cmpxchg.
>>>>>>>>
>>>>>>>>
>>>>>>>> But what about the reversed instruction pattern: ll.d hi, base, 
>>>>>>>> 4; ld.d lo, base 0?
>>>>>>>
>>>>>>> It would be worth asking your hardware engineers about the 
>>>>>>> bounds of legal behaviour. Ideally there would be some very 
>>>>>>> explicit language, similar to
>>>>>>
>>>>>>
>>>>>> I'm a community developer not affiliated with Loongson. Song Gao, 
>>>>>> could you provide some detail from Loongson Inc.?
>>>>>>
>>>>>>
>>>>>
>>>>> ll.d   r1, base, 0
>>>>> dbar 0x700          ==> see 2.2.8.1
>>>>> ld.d  r2, base,  8
>>>>> ...
>>>>> sc.q r1, r2, base
>>>>
>>>>
>>>> Thanks! I think we may need to detect the ll.d-dbar-ld.d sequence 
>>>> and translate the sequence into one tcg_gen_qemu_ld_i128 and split 
>>>> the result into two 64-bit parts. Can do this in QEMU?
>>>>
>>>>
>>> Oh, I'm not sure.
>>>
>>> I think we just need to implement sc.q. We don't need to care about 
>>> 'll.d-dbar-ld.d'. It's just like 'll.q'.
>>> It needs the user to ensure that .
>>>
>>> ll.q' is
>>> 1) ll.d r1 base, 0 ==> set LLbit, load the low 64 bits into r1
>>> 2) dbar 0x700　
>>> 3) ld.d r2 base, 8 ==> load the high 64 bits to r2
>>>
>>> sc.q needs to
>>> 1) Use 64-bit cmpxchg.
>>> 2) Write 128 bits to memory.
>>
>> Consider the following code:
>>
>>
>> ll.d r1, base, 0
>>
>> dbar 0x700
>>
>> ld.d r2, base, 8
>>
>> addi.d r2, r2, 1
>>
>> sc.q r1, r2, base
>>
>>
>> We translate them into native code:
>>
>>
>> ld.d r1, base, 0
>>
>> mv LLbit, 1
>>
>> mv LLaddr, base
>>
>> mv LLval, r1
>>
>> dbar 0x700
>>
>> ld.d r2, base, 8
>>
>> addi.d r2, r2, 1
>>
>> if (LLbit == 1 && LLaddr == base) {
>>
>>     cmpxchg addr=base compare=LLval new=r1
>>
>>     128-bit write {r2, r1} to base if cmpxchg succeeded
>>
>> }
>>
>> set r1 if sc.q succeeded
>>
>>
>>
>> If the memory content of base+8 has changed between ld.d r2 and 
>> addi.d r2, the atomicity is not guaranteed, i.e. only the high part 
>> has changed, the low part hasn't.
>>
>>
> Sorry,  my mistake.  need use cmpxchg_i128.   See 
> target/arm/tcg/translate-a64.c   gen_store_exclusive().
>
> gen_scq(rd, rk, rj)
> {
>      ...
>     TCGv_i128 t16 = tcg_temp_new_i128();
>     TCGv_i128 c16 = tcg_temp_new_i128();
>     TCGv_i64 low = tcg_temp_new_i64();
>     TCGv_i64 high= tcg_temp_new_i64();
>     TCGv_i64 temp = tcg_temp_new_i64();
>
>     tcg_gen_concat_i64_i128(t16, cpu_gpr[rd],  cpu_gpr[rk]));
>
>     tcg_gen_qemu_ld(low, cpu_lladdr, ctx->mem_idx,  MO_TEUQ);
>     tcg_gen_addi_tl(temp, cpu_lladdr, 8);
>     tcg_gen_mb(TCG_BAR_SC | TCG_MO_LD_LD);
>     tcg_gen_qemu_ld(high, temp, ctx->mem_idx, MO_TEUQ);


The problem is that, the high value read here might not equal to the 
previously read one in ll.d r2, base 8 instruction.


> tcg_gen_concat_i64_i128(c16, low,  high);
>
>     tcg_gen_atomic_cmpxchg_i128(t16, cpu_lladdr, c16, t16, 
> ctx->mem_idx, MO_128);
>
>     ...
> }
>
> I am not sure this is right.
>
> I think Richard can give you more suggestions. @Richard
>
> Thanks.
> Song Gao
>>
>>> Thanks.
>>> Song Gao
>>>>>
>>>>>
>>>>> For this series,
>>>>> I think we need set the new config bits to the 'max cpu', and 
>>>>> change linux-user/target_elf.h ''any' to 'max', so that we can use 
>>>>> these new instructions on linux-user mode.
>>>>
>>>> I will work on it.
>>>>
>>>>
>>>>>
>>>>> Thanks
>>>>> Song Gao
>>>>>>>
>>>>>>> https://developer.arm.com/documentation/ddi0487/latest/
>>>>>>> B2.9.5 Load-Exclusive and Store-Exclusive instruction usage 
>>>>>>> restrictions
>>>>>>>
>>>>>>> But you could do the same thing, aligning and recording the 
>>>>>>> entire 128-bit quantity, then extract the ll.d result based on 
>>>>>>> address bit 6.  This would complicate the implementation of sc.d 
>>>>>>> as well, but would perhaps bring us "close enough" to the actual 
>>>>>>> architecture.
>>>>>>>
>>>>>>> Note that our Arm store-exclusive implementation isn't quite in 
>>>>>>> spec either.  There is quite a large comment within 
>>>>>>> translate-a64.c store_exclusive() about the ways things are not 
>>>>>>> quite right.  But it seems to be close enough for actual usage 
>>>>>>> to succeed.
>>>>>>>
>>>>>>>
>>>>>>> r~
>>>>>
>>>
>

