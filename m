Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374517DB246
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:29:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIxB-00026I-B2; Sun, 29 Oct 2023 23:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qxIx7-00025q-EQ
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:28:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qxIx3-0007hK-Hz
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:28:33 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxh+jUIj9lp6k1AA--.3756S3;
 Mon, 30 Oct 2023 11:28:20 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxkN3RIj9lyMo2AA--.54582S3; 
 Mon, 30 Oct 2023 11:28:19 +0800 (CST)
Subject: Re: [PATCH v1 5/6] linux-user/loongarch64: Add LSX sigcontext
 save/restore
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-6-gaosong@loongson.cn>
 <b2335b60-b2f5-4ece-ab75-079fac4f7f9b@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <1abf4116-4677-0d2a-5917-89889703a06a@loongson.cn>
Date: Mon, 30 Oct 2023 11:28:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b2335b60-b2f5-4ece-ab75-079fac4f7f9b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxkN3RIj9lyMo2AA--.54582S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWfAFyUCr4rZFyxuF17Arc_yoW5XFWkpF
 48GFW8ArWUJFs3Grsrta4UX345Ar18Ja1UWrnaq3W8GrWUAr1vgr9rWry29FyUZr4kAry2
 qF4Ut3WUuFn8ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
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

在 2023/10/29 上午5:35, Richard Henderson 写道:
> On 10/9/23 20:37, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   linux-user/loongarch64/signal.c | 107 ++++++++++++++++++++++++++------
>>   1 file changed, 87 insertions(+), 20 deletions(-)
>>
>> diff --git a/linux-user/loongarch64/signal.c 
>> b/linux-user/loongarch64/signal.c
>> index 277e9f5757..4b09e50a5f 100644
>> --- a/linux-user/loongarch64/signal.c
>> +++ b/linux-user/loongarch64/signal.c
>> @@ -33,6 +33,14 @@ struct target_fpu_context {
>>       uint32_t fcsr;
>>   } QEMU_ALIGNED(FPU_CTX_ALIGN);
>>   +#define LSX_CTX_MAGIC           0x53580001
>> +#define LSX_CTX_ALIGN           16
>> +struct target_lsx_context {
>> +    uint64_t regs[2 * 32];
>> +    uint64_t fcc;
>> +    uint32_t fcsr;
>> +} QEMU_ALIGNED(LSX_CTX_ALIGN);
>
> It probably doesn't matter here because fo the alignment, but all 
> types within target structures should be using abi_{ullong,uint} etc.
>
>
Ok,
>> @@ -99,8 +109,15 @@ static abi_ptr setup_extcontext(struct 
>> extctx_layout *extctx, abi_ptr sp)
>>         /* For qemu, there is no lazy fp context switch, so fp always 
>> present. */
>>       extctx->flags = SC_USED_FP;
>> -    sp = extframe_alloc(extctx, &extctx->fpu,
>> +
>> +    if (env->extctx_flags & EXTCTX_FLAGS_LSX) {
>> +        sp = extframe_alloc(extctx, &extctx->lsx,
>> +                        sizeof(struct target_lsx_context), 
>> LSX_CTX_ALIGN, sp);
>> +
>> +    } else if (env->extctx_flags & EXTCTX_FLAGS_FPU) {
>> +        sp = extframe_alloc(extctx, &extctx->fpu,
>>                           sizeof(struct target_fpu_context), 
>> FPU_CTX_ALIGN, sp);
>> +    }
>
> I think this is overly complicated.  (1) The fpu is always present, 
> and (2) you don't need a special flag on env, you can check the same 
> CSR bits as for system mode.
>
I think extctx_flags is incorrectly named, fp_alive_flags or 
vec_alive_flags would be more appropriate.
The flags function like the kernel's 'thread_lsx_context_live', 
'thread_lasx_context_live' functions, checking if the LSX/LASX 
instructions are used.
If we don't use the LSX/LASX instructions, we don't need to use 
lsx_context/lasx_context even though the LSX/LASX enable bit is set.

and  EXTCTX_FLAGS_FPU is not required.

Thanks.
Song Gao
> I'll note that while this layout matches the kernel, it is an 
> unfortunate set of data structures.  Any program has to look for all 
> of {FPU,LSX,LASX}_CTX_MAGIC in order to find the basic fp registers.
>
>
> r~


