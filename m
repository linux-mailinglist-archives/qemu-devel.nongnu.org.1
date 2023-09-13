Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11C79F1C1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVFa-0000ux-GS; Wed, 13 Sep 2023 15:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgVFX-0000uo-Qr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:10:07 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgVFV-0007yu-7E
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JegkZ17jmlbc1nYoIryWxyM2ep1fy9beti6KGuuswdY=; b=G+BfP+S07Yhj1u1ukwGIXwktLP
 MCbuS7KRApgHvupmR+4A21BU6I/oVOqOg24tsdJAkCvpji9U1ONSPdh5QwT4w3goOH4V6TLM4dOvK
 FHELbaA5sysbPEeAExgfimozVDDjhqVo77UMwNlpg11JDYdArXqHVtj9JNtd0+sTN+uE=;
Message-ID: <9d1b595a-9f12-4912-a527-ae5732f6e20b@rev.ng>
Date: Wed, 13 Sep 2023 21:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] accel/tcg: Modify tlb_*() to use CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-4-anjo@rev.ng>
 <f5bb1f4f-ccab-5245-8f99-2daefd6aecf0@linaro.org>
Organization: rev.ng
In-Reply-To: <f5bb1f4f-ccab-5245-8f99-2daefd6aecf0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


> On 9/12/23 08:34, Anton Johansson wrote:
>> Changes tlb_*() functions to take CPUState instead of CPUArchState, as
>> they don't require the full CPUArchState. This makes it easier to
>> decouple target-(in)dependent code.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   include/exec/cpu_ldst.h |   8 +-
>>   accel/tcg/cputlb.c      | 218 +++++++++++++++++++---------------------
>>   2 files changed, 107 insertions(+), 119 deletions(-)
>>
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index da10ba1433..8d168f76ce 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -361,19 +361,19 @@ static inline uint64_t tlb_addr_write(const 
>> CPUTLBEntry *entry)
>>   }
>>     /* Find the TLB index corresponding to the mmu_idx + address 
>> pair.  */
>> -static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
>> +static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
>>                                     vaddr addr)
>>   {
>> -    uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> 
>> CPU_TLB_ENTRY_BITS;
>> +    uintptr_t size_mask = cpu_tlb(cpu)->f[mmu_idx].mask >> 
>> CPU_TLB_ENTRY_BITS;
>
> No, I think this is a bad idea, because it bakes an extra memory 
> indirection into very fundamental routines.
>
> If we change anything here, we should pass in CPUTLB.
Yeah, you're right. I'll pass CPUTLB instead, or do you have another idea?

Thanks a lot for the input!

-- 
Anton Johansson,
rev.ng Labs Srl.


