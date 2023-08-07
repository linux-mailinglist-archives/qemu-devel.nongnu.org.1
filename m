Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA87771C3F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvWp-000151-58; Mon, 07 Aug 2023 04:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSvWl-00014t-Bv
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:23:47 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSvWh-0003D4-S6
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:23:46 -0400
Received: from [172.20.10.3] (unknown [112.97.80.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id AA34240DF8;
 Mon,  7 Aug 2023 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691396621; bh=j4r9TFmJOTDFToCVjRzkTzLOnuMzzz/k50E+gQ8QlCw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Rap13YVA1cRuZFwG4Pr6GEqD1bYEd8dA5vVV1gJ6p9o/RqxrgzvTYRGNWRRzPDtoF
 EUzVC5QZIaIjUP8uPtOj2NEPSyN50Qlbg6tjAVcuMd0P3yqqd/GVeTCKh5hhtKqsZb
 AjL/rKwCN0qs8xZRffJL/kOnXQIemWsTnY14QkH8=
Message-ID: <36b5af0a-6966-00bc-76bb-c0afa7a3f296@jia.je>
Date: Mon, 7 Aug 2023 16:23:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/5] target/loongarch: Support LoongArch32 TLB entry
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, yijun@loongson.cn,
 shenjinyang@loongson.cn
References: <20230807031850.1961130-1-c@jia.je>
 <20230807031850.1961130-4-c@jia.je>
 <49edfbad-c89b-cc58-3296-1d48b2a7b821@jia.je>
 <4c0a66a2-59d5-122e-4402-689c39a3cd4f@loongson.cn>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <4c0a66a2-59d5-122e-4402-689c39a3cd4f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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


On 2023/8/7 14:55, gaosong wrote:
> Hi, Jiajie
>
> 在 2023/8/7 下午1:17, Jiajie Chen 写道:
>>
>> On 2023/8/7 11:18, Jiajie Chen wrote:
>>> The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
>>> zero in LoongArch32.
>>>
>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>> ---
>>>   target/loongarch/cpu-csr.h    |  9 +++++----
>>>   target/loongarch/tlb_helper.c | 17 ++++++++++++-----
>>>   2 files changed, 17 insertions(+), 9 deletions(-)
>>>
> Please
> Cc: Richard Henderson <richard.henderson@linaro.org>
>
> And
> Cc: Jun Yi <yijun@loongson.cn>
> CC: shenjinyang@loongson.cn>
> Their are also interested with Loongarch32 softmmu.
>
> It would be better use the parameter '--cover-letter' create a patch0.
> Add some Change logs and introduction about this series in patch0.

Thanks, I will add this in my next version of patch series.

> Thanks.
> Song Gao
>>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>>> index f8f24032cb..faf76a589b 100644
>>> --- a/target/loongarch/cpu-csr.h
>>> +++ b/target/loongarch/cpu-csr.h
>>> @@ -66,10 +66,11 @@ FIELD(TLBENTRY, D, 1, 1)
>>>   FIELD(TLBENTRY, PLV, 2, 2)
>>>   FIELD(TLBENTRY, MAT, 4, 2)
>>>   FIELD(TLBENTRY, G, 6, 1)
>>> -FIELD(TLBENTRY, PPN, 12, 36)
>>> -FIELD(TLBENTRY, NR, 61, 1)
>>> -FIELD(TLBENTRY, NX, 62, 1)
>>> -FIELD(TLBENTRY, RPLV, 63, 1)
>>> +FIELD(TLBENTRY_32, PPN, 12, 24)
>>
>> Sorry, the starting bit of TLBENTRY_32_PPN should be 8 instead of 12. 
>> Will be corrected in v3.
>>
>>
>>> +FIELD(TLBENTRY_64, PPN, 12, 36)
>>> +FIELD(TLBENTRY_64, NR, 61, 1)
>>> +FIELD(TLBENTRY_64, NX, 62, 1)
>>> +FIELD(TLBENTRY_64, RPLV, 63, 1)
>>>   #define LOONGARCH_CSR_ASID           0x18 /* Address space 
>>> identifier */
>>>   FIELD(CSR_ASID, ASID, 0, 10)
>>> diff --git a/target/loongarch/tlb_helper.c 
>>> b/target/loongarch/tlb_helper.c
>>> index 6e00190547..690c6ef25f 100644
>>> --- a/target/loongarch/tlb_helper.c
>>> +++ b/target/loongarch/tlb_helper.c
>>> @@ -48,10 +48,17 @@ static int 
>>> loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>>>       tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
>>>       tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
>>>       tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
>>> -    tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY, PPN);
>>> -    tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY, NX);
>>> -    tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY, NR);
>>> -    tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY, RPLV);
>>> +    if (env->mode == LA64) {
>>> +        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
>>> +        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
>>> +        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
>>> +        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
>>> +    } else {
>>> +        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
>>> +        tlb_nx = 0;
>>> +        tlb_nr = 0;
>>> +        tlb_rplv = 0;
>>> +    }
>>>       /* Check access rights */
>>>       if (!tlb_v) {
>>> @@ -79,7 +86,7 @@ static int 
>>> loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>>>        * tlb_entry contains ppn[47:12] while 16KiB ppn is [47:15]
>>>        * need adjust.
>>>        */
>>> -    *physical = (tlb_ppn << R_TLBENTRY_PPN_SHIFT) |
>>> +    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
>>>                   (address & MAKE_64BIT_MASK(0, tlb_ps));
>>>       *prot = PAGE_READ;
>>>       if (tlb_d) {
>

