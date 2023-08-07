Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D8A771AE3
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 08:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSu9u-0003wA-Ol; Mon, 07 Aug 2023 02:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qSu9k-0003vF-0K
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 02:55:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qSu9c-0007bN-3D
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 02:55:55 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxDOtrldBkV90RAA--.34593S3;
 Mon, 07 Aug 2023 14:55:39 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxniNqldBksMtMAA--.23014S3; 
 Mon, 07 Aug 2023 14:55:38 +0800 (CST)
Subject: Re: [PATCH v2 4/5] target/loongarch: Support LoongArch32 TLB entry
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, yijun@loongson.cn,
 shenjinyang@loongson.cn
References: <20230807031850.1961130-1-c@jia.je>
 <20230807031850.1961130-4-c@jia.je>
 <49edfbad-c89b-cc58-3296-1d48b2a7b821@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4c0a66a2-59d5-122e-4402-689c39a3cd4f@loongson.cn>
Date: Mon, 7 Aug 2023 14:55:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49edfbad-c89b-cc58-3296-1d48b2a7b821@jia.je>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniNqldBksMtMAA--.23014S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4UZw1kCr45JryrGw45Jwc_yoW5KF1Dpr
 4kCryjkFyxGrs3GFn3Ga45GrW7Xr4UCanFqw4xXFyYyFsrGrWYqFWkXryq9F18Ar4rG3WU
 ZF1jyrykuF13JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.139,
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

Hi, Jiajie

在 2023/8/7 下午1:17, Jiajie Chen 写道:
> 
> On 2023/8/7 11:18, Jiajie Chen wrote:
>> The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
>> zero in LoongArch32.
>>
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   target/loongarch/cpu-csr.h    |  9 +++++----
>>   target/loongarch/tlb_helper.c | 17 ++++++++++++-----
>>   2 files changed, 17 insertions(+), 9 deletions(-)
>>
Please
Cc: Richard Henderson <richard.henderson@linaro.org>

And
Cc: Jun Yi <yijun@loongson.cn>
CC: shenjinyang@loongson.cn>
Their are also interested with Loongarch32 softmmu.

It would be better use the parameter '--cover-letter' create a patch0.
Add some Change logs and introduction about this series in patch0.

Thanks.
Song Gao
>> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
>> index f8f24032cb..faf76a589b 100644
>> --- a/target/loongarch/cpu-csr.h
>> +++ b/target/loongarch/cpu-csr.h
>> @@ -66,10 +66,11 @@ FIELD(TLBENTRY, D, 1, 1)
>>   FIELD(TLBENTRY, PLV, 2, 2)
>>   FIELD(TLBENTRY, MAT, 4, 2)
>>   FIELD(TLBENTRY, G, 6, 1)
>> -FIELD(TLBENTRY, PPN, 12, 36)
>> -FIELD(TLBENTRY, NR, 61, 1)
>> -FIELD(TLBENTRY, NX, 62, 1)
>> -FIELD(TLBENTRY, RPLV, 63, 1)
>> +FIELD(TLBENTRY_32, PPN, 12, 24)
> 
> Sorry, the starting bit of TLBENTRY_32_PPN should be 8 instead of 12. 
> Will be corrected in v3.
> 
> 
>> +FIELD(TLBENTRY_64, PPN, 12, 36)
>> +FIELD(TLBENTRY_64, NR, 61, 1)
>> +FIELD(TLBENTRY_64, NX, 62, 1)
>> +FIELD(TLBENTRY_64, RPLV, 63, 1)
>>   #define LOONGARCH_CSR_ASID           0x18 /* Address space 
>> identifier */
>>   FIELD(CSR_ASID, ASID, 0, 10)
>> diff --git a/target/loongarch/tlb_helper.c 
>> b/target/loongarch/tlb_helper.c
>> index 6e00190547..690c6ef25f 100644
>> --- a/target/loongarch/tlb_helper.c
>> +++ b/target/loongarch/tlb_helper.c
>> @@ -48,10 +48,17 @@ static int 
>> loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>>       tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
>>       tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
>>       tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
>> -    tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY, PPN);
>> -    tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY, NX);
>> -    tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY, NR);
>> -    tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY, RPLV);
>> +    if (env->mode == LA64) {
>> +        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
>> +        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
>> +        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
>> +        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
>> +    } else {
>> +        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
>> +        tlb_nx = 0;
>> +        tlb_nr = 0;
>> +        tlb_rplv = 0;
>> +    }
>>       /* Check access rights */
>>       if (!tlb_v) {
>> @@ -79,7 +86,7 @@ static int loongarch_map_tlb_entry(CPULoongArchState 
>> *env, hwaddr *physical,
>>        * tlb_entry contains ppn[47:12] while 16KiB ppn is [47:15]
>>        * need adjust.
>>        */
>> -    *physical = (tlb_ppn << R_TLBENTRY_PPN_SHIFT) |
>> +    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
>>                   (address & MAKE_64BIT_MASK(0, tlb_ps));
>>       *prot = PAGE_READ;
>>       if (tlb_d) {


