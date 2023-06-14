Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE772B602
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 05:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Y5Q-0003aU-Iz; Sun, 11 Jun 2023 23:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q8Y5N-0003Zk-OI; Sun, 11 Jun 2023 23:19:17 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q8Y5L-0003AA-Ko; Sun, 11 Jun 2023 23:19:17 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VkqfrK7_1686539941; 
Received: from 30.221.96.167(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VkqfrK7_1686539941) by smtp.aliyun-inc.com;
 Mon, 12 Jun 2023 11:19:02 +0800
Message-ID: <ad06f409-5f14-75ea-9f9c-65a4b8596a3a@linux.alibaba.com>
Date: Mon, 12 Jun 2023 11:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] target/riscv: Support MSTATUS.MPV/GVA only when RVH
 is enabled
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-4-liweiwei@iscas.ac.cn>
 <7b8bc5a7-ccc1-a764-cb55-706b62a36a37@linux.alibaba.com>
 <91eb4769-bfc3-23da-0a97-cd91a93ec936@iscas.ac.cn>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <91eb4769-bfc3-23da-0a97-cd91a93ec936@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2023/6/12 11:16, Weiwei Li wrote:
>
> On 2023/6/12 11:08, LIU Zhiwei wrote:
>>
>> On 2023/5/29 20:17, Weiwei Li wrote:
>>> MPV and GVA bits are added by hypervisor extension to mstatus
>>> and mstatush (if MXLEN=32).
>>
>> Have you found the CSR field specifications for them, especially for 
>> GVA.
>
> Yeah.  in the section 9.4.1 of the privilege spec:
>
> "/The hypervisor extension adds two fields, MPV and GVA, to the 
> machine-level mstatus or mstatush CSR/".

I mean the WARL or other CSR field specifications here.

Zhiwei

>
> Regards,
>
> Weiwei Li
>
>>
>> Zhiwei
>>
>>>
>>> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
>>> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
>>> ---
>>>   target/riscv/csr.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index 58499b5afc..6ac11d1f11 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -1311,11 +1311,9 @@ static RISCVException 
>>> write_mstatus(CPURISCVState *env, int csrno,
>>>       }
>>>         if (xl != MXL_RV32 || env->debugger) {
>>> -        /*
>>> -         * RV32: MPV and GVA are not in mstatus. The current plan 
>>> is to
>>> -         * add them to mstatush. For now, we just don't support it.
>>> -         */
>>> -        mask |= MSTATUS_MPV | MSTATUS_GVA;
>>> +        if (riscv_has_ext(env, RVH)) {
>>> +            mask |= MSTATUS_MPV | MSTATUS_GVA;
>>> +        }
>>>           if ((val & MSTATUS64_UXL) != 0) {
>>>               mask |= MSTATUS64_UXL;
>>>           }
>>> @@ -1351,7 +1349,7 @@ static RISCVException 
>>> write_mstatush(CPURISCVState *env, int csrno,
>>>                                        target_ulong val)
>>>   {
>>>       uint64_t valh = (uint64_t)val << 32;
>>> -    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
>>> +    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | 
>>> MSTATUS_GVA : 0;
>>>         env->mstatus = (env->mstatus & ~mask) | (valh & mask);

