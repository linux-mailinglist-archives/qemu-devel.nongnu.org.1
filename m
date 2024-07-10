Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E592C8F4
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 05:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRNhO-0006OL-Pz; Tue, 09 Jul 2024 23:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRNhL-0006NX-WE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:08:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRNhJ-0000WW-5r
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:08:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax0PEz+41m9bECAA--.8567S3;
 Wed, 10 Jul 2024 11:08:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx78cv+41ma_FBAA--.20398S3; 
 Wed, 10 Jul 2024 11:08:33 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: Remove avail_64 in trans_srai_w()
 and simplify it
To: Feiyang Chen <chris.chenfeiyang@gmail.com>, richard.henderson@linaro.org
Cc: c@jia.je, qemu-devel@nongnu.org
References: <20240628033357.50027-1-chris.chenfeiyang@gmail.com>
 <CACWXhKkxXZF+6-V38BuFiRQPR+Wo+V0B1kh-wMU6YE5ibH0TZA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <82279357-2c18-061d-dafd-8f78279926de@loongson.cn>
Date: Wed, 10 Jul 2024 11:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACWXhKkxXZF+6-V38BuFiRQPR+Wo+V0B1kh-wMU6YE5ibH0TZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx78cv+41ma_FBAA--.20398S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfXw1xZFWkGry8Ar43urX_yoW5JrykpF
 4UCF1UKF48XrZ3ZrZ7Zw4DWFyDXFsFya12gw4IkFn5Cw4Dtr10grZ293yagryqy34Iqr40
 vFZa934qgay5J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU88Ma5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.431,
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

在 2024/7/10 上午10:43, Feiyang Chen 写道:
> ping
>
> https://lore.kernel.org/qemu-devel/20240628033357.50027-1-chris.chenfeiyang@gmail.com/
Hi,

I'll be pushing the LoongArch patches this week.

Thanks.
Song Gao
> h
> On Fri, Jun 28, 2024 at 1:34 PM Feiyang Chen
> <chris.chenfeiyang@gmail.com> wrote:
>> Since srai.w is a valid instruction on la32, remove the avail_64 check
>> and simplify trans_srai_w().
>>
>> Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only instructions")
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_shift.c.inc | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
>> index 2f4bd6ff28..377307785a 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
>> @@ -67,19 +67,9 @@ static void gen_rotr_d(TCGv dest, TCGv src1, TCGv src2)
>>       tcg_gen_rotr_tl(dest, src1, t0);
>>   }
>>
>> -static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
>> +static void gen_sari_w(TCGv dest, TCGv src1, target_long imm)
>>   {
>> -    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>> -    TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
>> -
>> -    if (!avail_64(ctx)) {
>> -        return false;
>> -    }
>> -
>> -    tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
>> -    gen_set_gpr(a->rd, dest, EXT_NONE);
>> -
>> -    return true;
>> +    tcg_gen_sextract_tl(dest, src1, imm, 32 - imm);
>>   }
>>
>>   TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
>> @@ -94,6 +84,7 @@ TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
>>   TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
>>   TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
>>   TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
>> +TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
>>   TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
>>   TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>>   TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
>> --
>> 2.34.1
>>


