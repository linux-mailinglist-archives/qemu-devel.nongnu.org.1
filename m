Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE062778629
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 05:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUJ4C-0002dc-G5; Thu, 10 Aug 2023 23:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qUJ4A-0002dO-0M
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 23:43:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qUJ46-0002Rj-PF
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 23:43:57 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxXetvrtVkFEQVAA--.40274S3;
 Fri, 11 Aug 2023 11:43:43 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxWM1urtVk4klUAA--.15228S3; 
 Fri, 11 Aug 2023 11:43:42 +0800 (CST)
Subject: Re: [PATCH v1 2/6] target/loongarch: Add some checks before
 translating fpu instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 Jiajie Chen <c@jia.je>
References: <20230810124112.236640-1-gaosong@loongson.cn>
 <20230810124112.236640-3-gaosong@loongson.cn>
 <57292469-fe1c-60d2-a7f0-b715c62af3a9@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b8622827-a4e6-ebc3-662f-36f725c4533a@loongson.cn>
Date: Fri, 11 Aug 2023 11:43:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <57292469-fe1c-60d2-a7f0-b715c62af3a9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM1urtVk4klUAA--.15228S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr47KFWrKr1Utr4DJr4UZFc_yoWrtFy8pF
 4ktFWjqrWUtrZ3Zws7tr45XFy7Ar4rK3W7Jr1Iqa48AFWDJrnIgFy0qr4qgF4UXr48Xr1j
 yF4DJwsxZFnxJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.156,
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

在 2023/8/10 下午11:03, Richard Henderson 写道:
> On 8/10/23 05:41, Song Gao wrote:
>> This patch adds REQUIRE_FP/FP_SP/FP_DP to check CPUCFG2.FP/FP_SP/FP_DP.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.h                        |   6 +
>>   .../loongarch/insn_trans/trans_farith.c.inc   | 132 ++++++++++++------
>>   target/loongarch/insn_trans/trans_fcmp.c.inc  |   4 +
>>   target/loongarch/insn_trans/trans_fcnv.c.inc  |  56 ++++----
>>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 104 ++++++++++----
>>   target/loongarch/insn_trans/trans_fmov.c.inc  |  47 +++++--
>>   6 files changed, 247 insertions(+), 102 deletions(-)
>>
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index 9f550793ca..5594d83011 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -459,6 +459,9 @@ static inline void set_pc(CPULoongArchState *env, 
>> uint64_t value)
>>   #define HW_FLAGS_EUEN_FPE   0x04
>>   #define HW_FLAGS_EUEN_SXE   0x08
>>   #define HW_FLAGS_VA32       0x20
>> +#define HW_FLAGS_FP         0x40
>> +#define HW_FLAGS_FP_SP      0x80
>> +#define HW_FLAGS_FP_DP      0x100
>>   static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, 
>> vaddr *pc,
>>                                           uint64_t *cs_base, uint32_t 
>> *flags)
>> @@ -469,6 +472,9 @@ static inline void 
>> cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>>       *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * 
>> HW_FLAGS_EUEN_FPE;
>>       *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * 
>> HW_FLAGS_EUEN_SXE;
>>       *flags |= is_va32(env) * HW_FLAGS_VA32;
>> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP) * HW_FLAGS_FP;
>> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_SP) * 
>> HW_FLAGS_FP_SP;
>> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_DP) * 
>> HW_FLAGS_FP_DP;
> 
> You do not need to put any of these in HW_FLAGS, because CPUCFG space 
> never changes for the lifetime of the cpu.
> 
> You can extract these into DisasContext in loongarch_tr_init_disas_context.
> 
>> +#define REQUIRE_FP do { \
>> +    if ((ctx->base.tb->flags & HW_FLAGS_FP) == 0) { \
>> +        return false; \
>> +    } \
>> +} while (0)
>> +
>> +#define REQUIRE_FP_SP do { \
>> +    if ((ctx->base.tb->flags & HW_FLAGS_FP_SP) == 0) { \
>> +        return false; \
>> +    } \
>> +} while (0)
>> +
>> +#define REQUIRE_FP_DP do { \
>> +    if ((ctx->base.tb->flags & HW_FLAGS_FP_DP) == 0) { \
>> +        return false; \
>> +    } \
>> +} while (0)
> 
> It would be much better to not create so many of these REQUIRE macros.
> 
>> +TRANS(fadd_s, gen_fff, 0, gen_helper_fadd_s)
>> +TRANS(fadd_d, gen_fff, 1, gen_helper_fadd_d)
> 
> 0 vs 1 is very opaque.
> 
> Better is something like Jiajie Chen's TRANS_64,
> 
>> +/* for LoongArch64-only instructions */
>> +#define TRANS_64(NAME, FUNC, ...) \
>> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
>> +    { \
>> +        return ctx->la64 && FUNC(ctx, a, __VA_ARGS__); \
>> +    }
> 
> But as we now know, we would need at least 7 of these.
> 
> Even better would be to generalize this so that every instruction 
> records the condition under which it is valid.
> 
> Perhaps
> 
> typedef struct DisasContext {
>      ...
>      uint32_t cpucfg1;
>      uint32_t cpucfg2;
> };
> 
> static void loongarch_tr_init_disas_context(...)
> {
>      ...
>      ctx->cpucfg1 = env->cpucfg[1];
>      ctx->cpucfg2 = env->cpucfg[2];
> }
> 
> #define avail_ALL(C)  true
> #define avail_64(C)   FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == 
> CPUCFG1_ARCH_LA64
> #define avail_FP(C)   FIELD_EX32((C)->cpucfg2, CPUCFG2, FP)
> etc
> 
> 
> #define TRANS(NAME, AVAIL, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a)  \
>      { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
> 
> so that the above becomes
> 
> TRANS(fadd_s, FP_SP, gen_fff, gen_helper_fadd_s)
> TRANS(fadd_d, FP_DP, gen_fff, gen_helper_fadd_d)
> 
> and even simple instructions get
> 
> TRANS(add_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
> TRANS(add_d,  64, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
> 
Thanks for your suggestions, I will send v2 as soon as possblie.

Thanks.
Song Gao


