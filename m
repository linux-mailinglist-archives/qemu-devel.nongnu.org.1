Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60158777B90
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:05:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7Cc-0004fb-P7; Thu, 10 Aug 2023 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU7Ca-0004en-SI
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:03:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU7CZ-00050F-1P
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:03:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso892142b3a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691679829; x=1692284629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDopEXVB8Cz/L+euXO83cymHp9IOkF+xPBhsyYc6pQg=;
 b=w7zXTCoSZhRs2/Vx67k42c8B5HVcwtmZu6rfGhF7Jw8+YCeJBVC1lmMA7UPRvMZJHk
 TVOehe7ZUBh4Mp2pqkHEdBMDy+rx+O7cadcu3Z84i73OupHM0agcnxOpXqHGRp+kcK+Y
 lxjklXrgh+vGV60cRyY9iCYdJjtVKwkcBZ7jSS/PaairOU9Y727YsZMw2JvajUer1IUy
 7hPhrTEuvSOejogQnqrCSI95jiTpI56GsDLYrTABt3Ujv/EnUp8jo/jiMHqmq/3sVQvv
 13fhCeAMA9wQpj5LYxugfV8Dlj+7tx5/Lt34b1sVoaXZcXHZNTHx5W9KPlH+Bw9IcJtK
 ETeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691679829; x=1692284629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDopEXVB8Cz/L+euXO83cymHp9IOkF+xPBhsyYc6pQg=;
 b=Rdhk5dSUqfySq8WoP+5bOlygoa/anYpWbokSoFLYpeoy5aPbDqZvDdAEw7IHNAbzMA
 RhXPzKxq2nXo0zgpTFeusK92CEPq8C5SeVqCkl/gH5MW/VVOZG+y3KKPuU/4+hzeQCDy
 mwm0UYKmHUgGxyPlj8xCChOGdLleEcVS/KrS5x4MsdMdLeyNyf27589EI1rMk7EZTVzy
 FLvE7TowkAS6ymkpORWeDoIvkNgPNBViEqbm+FqcXc8EryG+PIatqrJDdN0Pv+sAstBy
 Zbr/BEUL+4oN5WA77bVyHSJsMIhYdNQOVSshdu4RrIUtwvUQc6jAGEFNId2fHt8vdBOT
 7q0A==
X-Gm-Message-State: AOJu0YxKLmeSBDuF7f1FGYgsOgUx5ntDFfMsLlrD0NDIJwP/0qV5ov7s
 6fJfHDWBxRi74SRf+MajjImITw==
X-Google-Smtp-Source: AGHT+IFcocg8cTIJgmIPhx8474+WJzhqTzD6OXJgM8DnRCXiAxYu/6QtXnuxnE+v18v/MdxM3fyHGg==
X-Received: by 2002:a05:6a00:3a1a:b0:687:9909:3c75 with SMTP id
 fj26-20020a056a003a1a00b0068799093c75mr3372509pfb.4.1691679829286; 
 Thu, 10 Aug 2023 08:03:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a63b346000000b00553b9e0510esm1500985pgt.60.2023.08.10.08.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:03:48 -0700 (PDT)
Message-ID: <57292469-fe1c-60d2-a7f0-b715c62af3a9@linaro.org>
Date: Thu, 10 Aug 2023 08:03:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/6] target/loongarch: Add some checks before
 translating fpu instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 Jiajie Chen <c@jia.je>
References: <20230810124112.236640-1-gaosong@loongson.cn>
 <20230810124112.236640-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810124112.236640-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/10/23 05:41, Song Gao wrote:
> This patch adds REQUIRE_FP/FP_SP/FP_DP to check CPUCFG2.FP/FP_SP/FP_DP.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.h                        |   6 +
>   .../loongarch/insn_trans/trans_farith.c.inc   | 132 ++++++++++++------
>   target/loongarch/insn_trans/trans_fcmp.c.inc  |   4 +
>   target/loongarch/insn_trans/trans_fcnv.c.inc  |  56 ++++----
>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 104 ++++++++++----
>   target/loongarch/insn_trans/trans_fmov.c.inc  |  47 +++++--
>   6 files changed, 247 insertions(+), 102 deletions(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 9f550793ca..5594d83011 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -459,6 +459,9 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
>   #define HW_FLAGS_EUEN_FPE   0x04
>   #define HW_FLAGS_EUEN_SXE   0x08
>   #define HW_FLAGS_VA32       0x20
> +#define HW_FLAGS_FP         0x40
> +#define HW_FLAGS_FP_SP      0x80
> +#define HW_FLAGS_FP_DP      0x100
>   
>   static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>                                           uint64_t *cs_base, uint32_t *flags)
> @@ -469,6 +472,9 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>       *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
>       *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
>       *flags |= is_va32(env) * HW_FLAGS_VA32;
> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP) * HW_FLAGS_FP;
> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_SP) * HW_FLAGS_FP_SP;
> +    *flags |= FIELD_EX32(env->cpucfg[2], CPUCFG2, FP_DP) * HW_FLAGS_FP_DP;

You do not need to put any of these in HW_FLAGS, because CPUCFG space never changes for 
the lifetime of the cpu.

You can extract these into DisasContext in loongarch_tr_init_disas_context.

> +#define REQUIRE_FP do { \
> +    if ((ctx->base.tb->flags & HW_FLAGS_FP) == 0) { \
> +        return false; \
> +    } \
> +} while (0)
> +
> +#define REQUIRE_FP_SP do { \
> +    if ((ctx->base.tb->flags & HW_FLAGS_FP_SP) == 0) { \
> +        return false; \
> +    } \
> +} while (0)
> +
> +#define REQUIRE_FP_DP do { \
> +    if ((ctx->base.tb->flags & HW_FLAGS_FP_DP) == 0) { \
> +        return false; \
> +    } \
> +} while (0)

It would be much better to not create so many of these REQUIRE macros.

> +TRANS(fadd_s, gen_fff, 0, gen_helper_fadd_s)
> +TRANS(fadd_d, gen_fff, 1, gen_helper_fadd_d)

0 vs 1 is very opaque.

Better is something like Jiajie Chen's TRANS_64,

> +/* for LoongArch64-only instructions */
> +#define TRANS_64(NAME, FUNC, ...) \
> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +    { \
> +        return ctx->la64 && FUNC(ctx, a, __VA_ARGS__); \
> +    }

But as we now know, we would need at least 7 of these.

Even better would be to generalize this so that every instruction records the condition 
under which it is valid.

Perhaps

typedef struct DisasContext {
     ...
     uint32_t cpucfg1;
     uint32_t cpucfg2;
};

static void loongarch_tr_init_disas_context(...)
{
     ...
     ctx->cpucfg1 = env->cpucfg[1];
     ctx->cpucfg2 = env->cpucfg[2];
}

#define avail_ALL(C)  true
#define avail_64(C)   FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64
#define avail_FP(C)   FIELD_EX32((C)->cpucfg2, CPUCFG2, FP)
etc


#define TRANS(NAME, AVAIL, FUNC, ...) \
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a)  \
     { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }

so that the above becomes

TRANS(fadd_s, FP_SP, gen_fff, gen_helper_fadd_s)
TRANS(fadd_d, FP_DP, gen_fff, gen_helper_fadd_d)

and even simple instructions get

TRANS(add_w, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)
TRANS(add_d,  64, gen_rrr, EXT_NONE, EXT_NONE, EXT_SIGN, tcg_gen_add_tl)


r~

