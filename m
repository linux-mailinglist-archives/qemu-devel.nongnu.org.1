Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A066D77232C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyqP-00067C-Uk; Mon, 07 Aug 2023 07:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSyqM-00065M-Sm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:56:15 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSyqK-0008Su-Kw
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 07:56:14 -0400
Received: from [172.20.10.3] (unknown [112.97.80.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 5EA8641AD0;
 Mon,  7 Aug 2023 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691409370; bh=1ysSsPRHaGExhJb2etqRvf4S2WLcEFIOuvDolC2clIA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QLpsFS1umnKYz1nl2qyjY+qSdp4d7t+iFksbRR6wUz8jHCHLETMHG+2BMmjSc23Jw
 1Ht4zP/Zfx7VU7iycm4Se6VJW+ZwNOMcYxQ/6t/GSKRujKshJWSIjbqTroFufkZrYa
 cgOmDZp3M+Y5pHyEiA2ggteqm0a29yCGDyZJ7wzQ=
Message-ID: <454773f2-e9ca-e001-72cd-e6ee2017b9fc@jia.je>
Date: Mon, 7 Aug 2023 19:56:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 6/6] target/loongarch: Support LoongArch32 VPPN
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-7-c@jia.je>
 <07898c8a-c787-f692-77dc-9c0d7b7ca2b6@loongson.cn>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <07898c8a-c787-f692-77dc-9c0d7b7ca2b6@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/7 19:53, gaosong wrote:
> 在 2023/8/7 下午5:45, Jiajie Chen 写道:
>> VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu-csr.h    |  6 ++++--
>>   target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
>>   2 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index b93f99a9ef..9501a969af 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -57,7 +57,8 @@ FIELD(CSR_TLBIDX, PS, 24, 6)
>>   FIELD(CSR_TLBIDX, NE, 31, 1)
>>     #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
>> -FIELD(CSR_TLBEHI, VPPN, 13, 35)
>> +FIELD(CSR_TLBEHI_32, VPPN, 13, 35)
>> +FIELD(CSR_TLBEHI_64, VPPN, 13, 19)
>>
>
> FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
> FIELD(CSR_TLBEHI_64, VPPN, 13, 35)
Thanks for correction.
>
>>   #define LOONGARCH_CSR_TLBELO0 0x12 /* TLB EntryLo0 */
>>   #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
>> @@ -164,7 +165,8 @@ FIELD(CSR_TLBRERA, PC, 2, 62)
>>   #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
>>   #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
>>   FIELD(CSR_TLBREHI, PS, 0, 6)
>> -FIELD(CSR_TLBREHI, VPPN, 13, 35)
>> +FIELD(CSR_TLBREHI_32, VPPN, 13, 35)
>> +FIELD(CSR_TLBREHI_64, VPPN, 13, 19)
>
> FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
> FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
Thanks for correction.
>
> We should test booting a 64 bit kernel or system,
> and adding a 32bit example in patch0 would be more useful.
I have tested booting a bare-metal supervisor: 
https://github.com/jiegec/supervisor-la32.
>
>
> Thanks.
> Song Gao
>
>>   #define LOONGARCH_CSR_TLBRPRMD 0x8f /* TLB refill mode info */
>>   FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
>>   FIELD(CSR_TLBRPRMD, PIE, 2, 1)
>> diff --git a/target/loongarch/tlb_helper.c 
>> b/target/loongarch/tlb_helper.c
>> index cf6f5863f9..7926c40252 100644
>> --- a/target/loongarch/tlb_helper.c
>> +++ b/target/loongarch/tlb_helper.c
>> @@ -305,8 +305,13 @@ static void 
>> raise_mmu_exception(CPULoongArchState *env, target_ulong address,
>>         if (tlb_error == TLBRET_NOMATCH) {
>>           env->CSR_TLBRBADV = address;
>> -        env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, 
>> VPPN,
>> -                                      extract64(address, 13, 35));
>> +        if (env->mode == LA64) {
>> +            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, 
>> CSR_TLBREHI_64,
>> +                                        VPPN, extract64(address, 13, 
>> 35));
>> +        } else {
>> +            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, 
>> CSR_TLBREHI_32,
>> +                                        VPPN, extract64(address, 13, 
>> 19));
>> +        }
>>       } else {
>>           if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
>>               env->CSR_BADV = address;
>> @@ -371,12 +376,20 @@ static void fill_tlb_entry(CPULoongArchState 
>> *env, int index)
>>         if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>           csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
>> -        csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, VPPN);
>> +        if (env->mode == LA64) {
>> +            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, 
>> VPPN);
>> +        } else {
>> +            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, 
>> VPPN);
>> +        }
>>           lo0 = env->CSR_TLBRELO0;
>>           lo1 = env->CSR_TLBRELO1;
>>       } else {
>>           csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
>> -        csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI, VPPN);
>> +        if (env->mode == LA64) {
>> +            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, 
>> VPPN);
>> +        } else {
>> +            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, 
>> VPPN);
>> +        }
>>           lo0 = env->CSR_TLBELO0;
>>           lo1 = env->CSR_TLBELO1;
>>       }
>> @@ -496,7 +509,7 @@ void helper_tlbfill(CPULoongArchState *env)
>>         if (pagesize == stlb_ps) {
>>           /* Only write into STLB bits [47:13] */
>> -        address = entryhi & ~MAKE_64BIT_MASK(0, 
>> R_CSR_TLBEHI_VPPN_SHIFT);
>> +        address = entryhi & ~MAKE_64BIT_MASK(0, 
>> R_CSR_TLBEHI_64_VPPN_SHIFT);
>>             /* Choose one set ramdomly */
>>           set = get_random_tlb(0, 7);
>>
>

