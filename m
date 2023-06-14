Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79A72B89D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 09:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8bxg-0001N0-0A; Mon, 12 Jun 2023 03:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q8bxZ-0001M4-EX; Mon, 12 Jun 2023 03:27:29 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q8bxW-00047M-N6; Mon, 12 Jun 2023 03:27:29 -0400
Received: from [192.168.100.156] (unknown [203.168.25.149])
 by APP-05 (Coremail) with SMTP id zQCowAAHKQbRyIZkw0crAQ--.52143S2;
 Mon, 12 Jun 2023 15:27:15 +0800 (CST)
Message-ID: <ccbe8b1e-3f0d-72db-7863-bf3f4ebdf525@iscas.ac.cn>
Date: Mon, 12 Jun 2023 15:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: liweiwei@iscas.ac.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, dbarboza@ventanamicro.com, wangjunqiang@iscas.ac.cn,
 lazyparser@gmail.com
Subject: Re: [PATCH 3/4] target/riscv: Support MSTATUS.MPV/GVA only when RVH
 is enabled
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-4-liweiwei@iscas.ac.cn>
 <7b8bc5a7-ccc1-a764-cb55-706b62a36a37@linux.alibaba.com>
 <91eb4769-bfc3-23da-0a97-cd91a93ec936@iscas.ac.cn>
 <ad06f409-5f14-75ea-9f9c-65a4b8596a3a@linux.alibaba.com>
 <5037c47f-1277-4dfc-aa8a-3b62a06b97d7@iscas.ac.cn>
 <c22265b1-6ef4-72d5-3c4c-e14829b0ec42@linux.alibaba.com>
From: Weiwei Li <liweiwei@iscas.ac.cn>
In-Reply-To: <c22265b1-6ef4-72d5-3c4c-e14829b0ec42@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHKQbRyIZkw0crAQ--.52143S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xJFW7Xr1kWFy3ZrWUArb_yoW5CFy5pr
 1kAFWUJrW5Jr4kAr12qr1UWryYyryUKa4UXr1kJF18Jr4Dtr1Y9F1UZr4qgr1DXrWxGr1j
 vF1UXasrZF17ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
 0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE7c1l42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRRnmiDUUUU
X-Originating-IP: [203.168.25.149]
X-CM-SenderInfo: 5olzvxxzhlqxpvfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=liweiwei@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 2023/6/12 13:40, LIU Zhiwei wrote:
>
> On 2023/6/12 12:35, Weiwei Li wrote:
>>
>> On 2023/6/12 11:18, LIU Zhiwei wrote:
>>>
>>> On 2023/6/12 11:16, Weiwei Li wrote:
>>>>
>>>> On 2023/6/12 11:08, LIU Zhiwei wrote:
>>>>>
>>>>> On 2023/5/29 20:17, Weiwei Li wrote:
>>>>>> MPV and GVA bits are added by hypervisor extension to mstatus
>>>>>> and mstatush (if MXLEN=32).
>>>>>
>>>>> Have you found the CSR field specifications for them, especially 
>>>>> for GVA.
>>>>
>>>> Yeah.  in the section 9.4.1 of the privilege spec:
>>>>
>>>> "/The hypervisor extension adds two fields, MPV and GVA, to the 
>>>> machine-level mstatus or mstatush CSR/".
>>>
>>> I mean the WARL or other CSR field specifications here.
>>
>> I don't quite get your idea. The only specification for MPV and GVA  
>> I found is in section 9.4.1.  The spec for most of mstatus fields can 
>> be found in  Section 3.1.6
>> "Machine Status Registers (mstatus and mstatush)".
>
> I mean is the GVA field read only or WARL(WPRI or WLRL) for the 
> software? It could be written by the implementation. But I am not sure 
> whether it could be written by the software.

No, I didn't find any description about this.

Regards,

Weiwei Li

>
> Zhiwei
>
>>
>> Regards,
>>
>> Weiwei Li
>>
>>>
>>> Zhiwei
>>>
>>>>
>>>> Regards,
>>>>
>>>> Weiwei Li
>>>>
>>>>>
>>>>> Zhiwei
>>>>>
>>>>>>
>>>>>> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
>>>>>> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
>>>>>> ---
>>>>>>   target/riscv/csr.c | 10 ++++------
>>>>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>>>> index 58499b5afc..6ac11d1f11 100644
>>>>>> --- a/target/riscv/csr.c
>>>>>> +++ b/target/riscv/csr.c
>>>>>> @@ -1311,11 +1311,9 @@ static RISCVException 
>>>>>> write_mstatus(CPURISCVState *env, int csrno,
>>>>>>       }
>>>>>>         if (xl != MXL_RV32 || env->debugger) {
>>>>>> -        /*
>>>>>> -         * RV32: MPV and GVA are not in mstatus. The current 
>>>>>> plan is to
>>>>>> -         * add them to mstatush. For now, we just don't support it.
>>>>>> -         */
>>>>>> -        mask |= MSTATUS_MPV | MSTATUS_GVA;
>>>>>> +        if (riscv_has_ext(env, RVH)) {
>>>>>> +            mask |= MSTATUS_MPV | MSTATUS_GVA;
>>>>>> +        }
>>>>>>           if ((val & MSTATUS64_UXL) != 0) {
>>>>>>               mask |= MSTATUS64_UXL;
>>>>>>           }
>>>>>> @@ -1351,7 +1349,7 @@ static RISCVException 
>>>>>> write_mstatush(CPURISCVState *env, int csrno,
>>>>>>                                        target_ulong val)
>>>>>>   {
>>>>>>       uint64_t valh = (uint64_t)val << 32;
>>>>>> -    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
>>>>>> +    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | 
>>>>>> MSTATUS_GVA : 0;
>>>>>>         env->mstatus = (env->mstatus & ~mask) | (valh & mask);


