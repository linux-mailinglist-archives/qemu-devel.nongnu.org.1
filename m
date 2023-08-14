Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4477B422
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSwW-0006l2-Fu; Mon, 14 Aug 2023 04:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qVSwN-0006iW-Un
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:28:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qVSwG-0000B9-Nn
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:28:43 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx5_Gp5dlk8QwYAA--.49566S3;
 Mon, 14 Aug 2023 16:28:25 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxrM6p5dlkeKZZAA--.23978S3; 
 Mon, 14 Aug 2023 16:28:25 +0800 (CST)
Subject: Re: [PATCH v2 6/8] target/loongarch: Add avail_LAM to check atomic
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 c@jia.je, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-7-gaosong@loongson.cn>
 <dc7bd910-fdff-74a8-12a2-0fd2cf814b9f@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <673a9cc0-6234-0d35-ec49-bd96d790a2fe@loongson.cn>
Date: Mon, 14 Aug 2023 16:28:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dc7bd910-fdff-74a8-12a2-0fd2cf814b9f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM6p5dlkeKZZAA--.23978S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1kAry5Ar1xtr4xZF4xAFc_yoW8uFy8pr
 1vyr48GrW5Wr93JwnrJay5XFy3Xr48K3W7Xw1Sqa43Ar4UJr1Ygr4jq3sIgr17A3y8Xr4Y
 vF1YvrnruF47X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.359,
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

在 2023/8/12 上午12:13, Richard Henderson 写道:
> On 8/11/23 03:02, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/insn_trans/trans_atomic.c.inc | 12 ++++++++++++
>>   target/loongarch/translate.h                   |  1 +
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc 
>> b/target/loongarch/insn_trans/trans_atomic.c.inc
>> index 194818d74d..867d09375a 100644
>> --- a/target/loongarch/insn_trans/trans_atomic.c.inc
>> +++ b/target/loongarch/insn_trans/trans_atomic.c.inc
>> @@ -9,6 +9,10 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, 
>> MemOp mop)
>>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>>       TCGv t0 = make_address_i(ctx, src1, a->imm);
>> +    if (!avail_LAM(ctx)) {
>> +        return true;
>> +    }
>> +
>>       tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
>>       tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
>>       tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
>> @@ -25,6 +29,10 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, 
>> MemOp mop)
>>       TCGv t0 = tcg_temp_new();
>>       TCGv val = tcg_temp_new();
>> +    if (!avail_LAM(ctx)) {
>> +        return true;
>> +    }
>> +
>>       TCGLabel *l1 = gen_new_label();
>>       TCGLabel *done = gen_new_label();
> 
> I think these two are wrong.  LAM says "AM* atomic memory instructions".
> I think LL/SC are always available.
> 
Yes, you are right, I will correct it on v3.

>> @@ -53,6 +61,10 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
>>       TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
>>       TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
>> +    if (!avail_LAM(ctx)) {
>> +        return true;
>> +    }
> 
> While correct, I think it would be better style to use LAM instead of 
> ALL in the TRANS(am*) instructions.
> 
Ok.

Thanks.
Song Gao


