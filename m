Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CE7227AE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ATR-0006Ag-Qd; Mon, 05 Jun 2023 09:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATP-00069z-AL; Mon, 05 Jun 2023 09:42:15 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATN-00015a-0v; Mon, 05 Jun 2023 09:42:15 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39a4eb67c5fso3115591b6e.0; 
 Mon, 05 Jun 2023 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972531; x=1688564531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1pmPikwMX2ZQozb+UmI0l7Bi9jiFRp1lRnKYk2rdhw=;
 b=KGbSTQZgjiaCLrAhnmc0cT76TPak1Sy/6savmR/PXAVeEtj+whJSC29PcBYwHx+K1Q
 44AiySgNti0uD5ul+ET9bRoqolEDSi6FXrMnU/YIsxYiJXZPFTJvLfUNXGtSQFLthivs
 rxtWBfV5ZzBZ0F9e1V7X3/9Mm1VQTLxLMRZOXxx/I+eIOCYwN1oniifz1kEOxOO9eZFe
 ULLmtCyldKNxjMGfh+pvNHRAluUgYe6A+YaU1npSbZVN7h534DUKY8F0XAv68lt+Isa3
 o2LOEjxDCZ3uU/cMHN0SaKwi47Id89aZcVJpZ/wnNNlIQ59lb4+iJxP1/41kYMNkxGJP
 6EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972531; x=1688564531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1pmPikwMX2ZQozb+UmI0l7Bi9jiFRp1lRnKYk2rdhw=;
 b=VJ6K8eS3wFVljq6HKcIjzhqCroRISr0L6tgzA0gzVAJkHXe6ods8LmA34qhlWRA3H4
 ur0ECCp07DeewzgSvw5kr/yUfZ8iVYl/wNrfRc8p+KpFsVajsEMGzfGaRyEBePx0jLxj
 +dXQo+g3W4t56ax7Ou3yLyOeDucJzQ+4xHmkArh86h0tEidmt4sVU2Vk63LLh79r26yy
 sN6ui3334YxBhFqfpBY96HWr6N8kPiSUSjvdO8Puh+5poj0PECmc0vUHqQMd5CcMKjxm
 JiL7dTX4iFfvfa6j82ZvM7PWADLcm0201gf+T2Kh3P5GMeTN1ZxJvH7dUfi83taCsrXw
 eT8Q==
X-Gm-Message-State: AC+VfDxDMUW+frpX3p5GwOzvVYyXqHLOLIcMJkJgBOmIWY3IixB5+p8f
 RRCjZPiwREGBVhVvbgDEnOA=
X-Google-Smtp-Source: ACHHUZ4uhwWzqZV7HDsxNA0nLaEacDXJ91piGUBdQWSCXjagP/SbQzPqA01GHXrTyzpQH89t/a5KCQ==
X-Received: by 2002:a05:6808:8f6:b0:39b:7bc3:a75e with SMTP id
 d22-20020a05680808f600b0039b7bc3a75emr674504oic.59.1685972531100; 
 Mon, 05 Jun 2023 06:42:11 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 y126-20020aca3284000000b0038cff7034c0sm3411277oiy.27.2023.06.05.06.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:42:10 -0700 (PDT)
Message-ID: <5ca92901-08df-2ae2-3468-77c8ee36e35b@gmail.com>
Date: Mon, 5 Jun 2023 10:42:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] target/ppc: Ensure stcx size matches larx
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230605025445.161932-1-npiggin@gmail.com>
 <20230605025445.161932-2-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230605025445.161932-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/4/23 23:54, Nicholas Piggin wrote:
> Differently-sized larx/stcx. pairs can succeed if the starting address
> matches. Add a check to require the size of stcx. exactly match the larx
> that established the reservation. Use the term "reserve_length" for this
> state, which matches the terminology used in the ISA.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued. Thanks,


Daniel

> v2:
> - Changed lqarx/stqcx. reservation size to 16 [Richard]
> - Changed name to reserve_length [Richard]
> 
>   target/ppc/cpu.h       | 5 +++--
>   target/ppc/cpu_init.c  | 4 ++--
>   target/ppc/translate.c | 9 +++++++++
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7959bfed0a..45d84ce06a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1123,8 +1123,9 @@ struct CPUArchState {
>       target_ulong ov32;
>       target_ulong ca32;
>   
> -    target_ulong reserve_addr; /* Reservation address */
> -    target_ulong reserve_val;  /* Reservation value */
> +    target_ulong reserve_addr;   /* Reservation address */
> +    target_ulong reserve_length; /* Reservation larx op size (bytes) */
> +    target_ulong reserve_val;    /* Reservation value */
>       target_ulong reserve_val2;
>   
>       /* These are used in supervisor mode only */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 944a74befe..c3dd7052a3 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7421,8 +7421,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>           }
>           qemu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
>       }
> -    qemu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
> -                 env->reserve_addr);
> +    qemu_fprintf(f, " ]     RES %03x@" TARGET_FMT_lx "\n",
> +                 (int)env->reserve_length, env->reserve_addr);
>   
>       if (flags & CPU_DUMP_FPU) {
>           for (i = 0; i < 32; i++) {
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 7a5bf1d820..538f757dec 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -71,6 +71,7 @@ static TCGv cpu_cfar;
>   #endif
>   static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>   static TCGv cpu_reserve;
> +static TCGv cpu_reserve_length;
>   static TCGv cpu_reserve_val;
>   static TCGv cpu_reserve_val2;
>   static TCGv cpu_fpscr;
> @@ -141,6 +142,10 @@ void ppc_translate_init(void)
>       cpu_reserve = tcg_global_mem_new(cpu_env,
>                                        offsetof(CPUPPCState, reserve_addr),
>                                        "reserve_addr");
> +    cpu_reserve_length = tcg_global_mem_new(cpu_env,
> +                                            offsetof(CPUPPCState,
> +                                                     reserve_length),
> +                                            "reserve_length");
>       cpu_reserve_val = tcg_global_mem_new(cpu_env,
>                                            offsetof(CPUPPCState, reserve_val),
>                                            "reserve_val");
> @@ -3585,6 +3590,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
>       gen_addr_reg_index(ctx, t0);
>       tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
>       tcg_gen_mov_tl(cpu_reserve, t0);
> +    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
>       tcg_gen_mov_tl(cpu_reserve_val, gpr);
>       tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>   }
> @@ -3816,6 +3822,7 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
>       gen_set_access_type(ctx, ACCESS_RES);
>       gen_addr_reg_index(ctx, t0);
>       tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
>   
>       t0 = tcg_temp_new();
>       tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
> @@ -3882,6 +3889,7 @@ static void gen_lqarx(DisasContext *ctx)
>       tcg_gen_extr_i128_i64(lo, hi, t16);
>   
>       tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_length, 16);
>       tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
>       tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
>   }
> @@ -3907,6 +3915,7 @@ static void gen_stqcx_(DisasContext *ctx)
>       gen_addr_reg_index(ctx, EA);
>   
>       tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
>   
>       cmp = tcg_temp_new_i128();
>       val = tcg_temp_new_i128();

