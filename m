Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E887DB247
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIxB-000260-Nc; Sun, 29 Oct 2023 23:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qxIx7-00025e-5f
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:28:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qxIx4-0007k1-Qx
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:28:32 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxyOjZIj9lrKk1AA--.3552S3;
 Mon, 30 Oct 2023 11:28:25 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3tzWIj9lz8o2AA--.51384S3; 
 Mon, 30 Oct 2023 11:28:22 +0800 (CST)
Subject: Re: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set
 LSX/LASX instructions extctx_flags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-3-gaosong@loongson.cn>
 <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <24981f5e-3397-427e-a552-635887d581cd@loongson.cn>
Date: Mon, 30 Oct 2023 11:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax3tzWIj9lz8o2AA--.51384S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF1UWFW8Kr4UAryDGFWrtFc_yoW8Zr1fpr
 1xCFWjkFyUGFZ3JFnxX34UXFyUXr48Jw4UWFnaq3Z5JrW5XryjqrWjqrWqgFyUJw4kuFyj
 vF45Zw13ZF48Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g
 43UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.972,
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

在 2023/10/29 上午5:40, Richard Henderson 写道:
> On 10/9/23 20:36, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/insn_trans/trans_vec.c.inc | 12 ++++++++++++
>>   target/loongarch/internals.h                |  2 ++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/target/loongarch/insn_trans/trans_vec.c.inc 
>> b/target/loongarch/insn_trans/trans_vec.c.inc
>> index 98f856bb29..aef16ef44a 100644
>> --- a/target/loongarch/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
>> @@ -23,8 +23,20 @@ static bool check_vec(DisasContext *ctx, uint32_t 
>> oprsz)
>>     #else
>>   +static void set_vec_extctx(DisasContext *ctx, uint32_t oprsz)
>> +{
>> +    if (oprsz == 16) {
>> +        ctx->extctx_flags |= EXTCTX_FLAGS_LSX;
>> +    }
>> +
>> +    if (oprsz == 32) {
>> +        ctx->extctx_flags |= EXTCTX_FLAGS_LASX;
>> +    }
>> +}
>> +
>>   static bool check_vec(DisasContext *ctx, uint32_t oprsz)
>>   {
>> +    set_vec_extctx(ctx, oprsz);
>>       return true;
>>   }
>
> This doesn't do anything.  Nothing copies the changed value back to env.
> Anyway, I think this is the wrong way to go about it.
>
Oh, It is on patch1.

@@ -294,6 +296,7 @@ static void 
loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
          generate_exception(ctx, EXCCODE_INE);
      }

+    env->extctx_flags |= ctx->extctx_flags;
      ctx->base.pc_next += 4;


Thanks.
Song Gao
> If you want to track what the program is using, you should do it 
> exactly like the real kernel: disable the execution unit, have the 
> program trap, and the enable the execution unit when the trap occurs.  
> At this point, CSR_EUEN enable bits contain exactly which units have 
> been used by the program.
>
>
> r~


