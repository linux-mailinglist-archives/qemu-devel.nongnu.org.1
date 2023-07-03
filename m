Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA7745B6E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHyk-000842-DS; Mon, 03 Jul 2023 07:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qGHya-0007ri-QV
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:44:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qGHyW-0005nw-FX
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:44:15 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8BxGsaBtKJkXTYFAA--.8377S3;
 Mon, 03 Jul 2023 19:44:02 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxniNjtKJka9oZAA--.39609S3; 
 Mon, 03 Jul 2023 19:44:01 +0800 (CST)
Subject: Re: [PATCH v2 09/46] target/loongarch: Implement xvhaddw/xvhsubw
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-10-gaosong@loongson.cn>
 <5eb0a8b4-d5ff-7fdf-f509-bd7aaf05a8c9@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <83a8ca97-3102-2988-f235-ec2375046207@loongson.cn>
Date: Mon, 3 Jul 2023 19:43:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5eb0a8b4-d5ff-7fdf-f509-bd7aaf05a8c9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxniNjtKJka9oZAA--.39609S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr13uF45Ww1DWFW3WFyfGrX_yoW5Zr1Upr
 18Jr1UJryUJr18Jr1UJr1UJryUJr1UJw1UJr1UJF1UJr1UJr1jqr1UXr1jgr1UJr48Jr1U
 Jr1UJr1UZr1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



在 2023/7/2 下午2:11, Richard Henderson 写道:
> On 6/30/23 09:58, Song Gao wrote:
>> --- a/target/loongarch/lsx_helper.c
>> +++ b/target/loongarch/vec_helper.c
>> @@ -14,20 +14,18 @@
>>   #include "tcg/tcg.h"
>>   #include "vec.h"
>>   -#define DO_ADD(a, b)  (a + b)
>> -#define DO_SUB(a, b)  (a - b)
>> -
>>   #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
>> -void HELPER(NAME)(CPULoongArchState *env,                            \
>> +void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,            \
>>                     uint32_t vd, uint32_t vj, uint32_t vk)             \
>> { \
>> -    int i;                                                           \
>> +    int i, len;                                                      \
>>       VReg *Vd = &(env->fpr[vd].vreg);                                 \
>>       VReg *Vj = &(env->fpr[vj].vreg);                                 \
>>       VReg *Vk = &(env->fpr[vk].vreg);                                 \
>>       typedef __typeof(Vd->E1(0)) TD;                                  \
>>                                                                        \
>> -    for (i = 0; i < LSX_LEN/BIT; i++) {                              \
>> +    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                        \
>> +    for (i = 0; i < len / BIT ; i++) {                               \
>>           Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i)); \
>> } \
>>   }
>
> It would be better to use the gen_helper_gvec_3 function signature:
>
> void HELPER(name)(void *vd, void *vj, void *vk, uint32_t desc)
> {
>     VReg *Vd = vd, ...;
>     int oprsz = simd_oprsz(desc);
>
>     for (i = 0; i < oprsz / (BIT / 8); i++) {
>         ...
>     }
> }
>
> You should do the file rename and the conversion of the existing LSX 
> operations in a separate patch.
>
>> @@ -44,13 +42,17 @@ void HELPER(vhaddw_q_d)(CPULoongArchState *env,
>>       VReg *Vk = &(env->fpr[vk].vreg);
>>         Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), 
>> int128_makes64(Vk->D(0)));
>> +    if (oprsz == 32) {
>> +        Vd->Q(1) = int128_add(int128_makes64(Vj->D(3)),
>> +                              int128_makes64(Vk->D(2)));
>> +    }
>
> Better as a loop, and all the rest.
>
>
OK,   I will correct them on v3.

Thanks.
Song Gao


