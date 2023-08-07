Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F3772D0C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT464-0000MB-U6; Mon, 07 Aug 2023 13:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT462-0000Ln-PF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:32:46 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT461-0007Z8-2e
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:32:46 -0400
Received: from [172.20.10.3] (unknown [112.97.81.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 2AB7943928;
 Mon,  7 Aug 2023 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691429562; bh=3tqEjdWAP1z+BBVE9SiN3pXawAhUSB/GDOFrzLvN1oU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Rg5M4qBknRDWzziNESXNo9XIa/0rdb057waVBHw3gbR9TSe15CqpKGt3LZXWojYaZ
 E/KDABcRfzyt3Da8RIfs4A/r3KpbcdvoHx5eaIIPlN8w2RYzQDy12K/nGVgolEh+M+
 ffGewgat+nOZV7vCZj75zwh4zd/kdGRk5EJWEuUY=
Message-ID: <b6da05fc-8eea-70d9-20ac-e6cb9d8ea440@jia.je>
Date: Tue, 8 Aug 2023 01:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 5/6] target/loongarch: Support LoongArch32 DMW
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-6-c@jia.je>
 <21b780f0-baa1-c006-2e82-b646442d86f2@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <21b780f0-baa1-c006-2e82-b646442d86f2@linaro.org>
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


On 2023/8/7 23:50, Richard Henderson wrote:
> On 8/7/23 02:45, Jiajie Chen wrote:
>> LA32 uses a different encoding for CSR.DMW and a new direct mapping
>> mechanism.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu-csr.h    |  7 +++----
>>   target/loongarch/tlb_helper.c | 31 ++++++++++++++++++++++++++++---
>>   2 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index 48ed2e0632..b93f99a9ef 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -188,10 +188,9 @@ FIELD(CSR_DMW, PLV1, 1, 1)
>>   FIELD(CSR_DMW, PLV2, 2, 1)
>>   FIELD(CSR_DMW, PLV3, 3, 1)
>>   FIELD(CSR_DMW, MAT, 4, 2)
>> -FIELD(CSR_DMW, VSEG, 60, 4)
>> -
>> -#define dmw_va2pa(va) \
>> -    (va & MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS))
>> +FIELD(CSR_DMW_32, PSEG, 25, 3)
>> +FIELD(CSR_DMW_32, VSEG, 29, 3)
>> +FIELD(CSR_DMW_64, VSEG, 60, 4)
>>     /* Debug CSRs */
>>   #define LOONGARCH_CSR_DBG            0x500 /* debug config */
>> diff --git a/target/loongarch/tlb_helper.c 
>> b/target/loongarch/tlb_helper.c
>> index 690c6ef25f..cf6f5863f9 100644
>> --- a/target/loongarch/tlb_helper.c
>> +++ b/target/loongarch/tlb_helper.c
>> @@ -173,6 +173,18 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>       return TLBRET_NOMATCH;
>>   }
>>   +static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
>> +                        target_ulong dmw)
>> +{
>> +    if (env->mode == LA64) {
>> +        return va & TARGET_PHYS_MASK;
>> +    } else {
>> +        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
>> +        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
>> +            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
>> +    }
>> +}
>> +
>>   static int get_physical_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                   int *prot, target_ulong address,
>>                                   MMUAccessType access_type, int 
>> mmu_idx)
>> @@ -184,6 +196,11 @@ static int 
>> get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>       uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
>>       uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
>>   +    /* Truncate high 32 bits for LA32 */
>> +    if (env->mode == LA32) {
>> +        address = (uint32_t)address;
>> +    }
>
> You need to do this in the translator, because this also depends on 
> VA32L* and the current priv level.
Could you please elaborate on this? I am checking LA32 and VA32L* in 
get_physical_address() currently, the current priv level is read from 
mmu_idx(or alternatively, read from env->CSR_CRMD), and I am unsure how 
to do this in the translator.
>
> Otherwise the window manipulation looks correct.
>
>
> r~

