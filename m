Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44844721887
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qVA-0007sK-He; Sun, 04 Jun 2023 12:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qV8-0007re-VF
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:22:42 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qV6-0006CR-5s
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:22:42 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6af7d6f6f41so3061119a34.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685895758; x=1688487758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziJ19CMyxRqhzyNJybOr3djel6YcFYrtRHZwwYAbfLo=;
 b=CpWg4usW0GA9gMlrGD+IK4P9vqR/NmkRclpfCKRVyu52pjLf9HYsh2/N6ndZg5b5rC
 xzYoPLTi7ujq4TxyS9Qh1OoMXy1spJFIrNUVGQmk74tVvyqBFKKfCNeqpVRNvWr3jgpS
 Qe1WTp8XONiXlJeu7vXRQPPryQwRt5jTLhc3ihgqnh2P6p7MeeyZXTgaj2dPKGE8TMOg
 l9O3q0ibG5r/mdhWNj096l5g7LhohjAhjO8Q7SqDTx5g8orFWw9wYCNT+NW2DwcFUGUU
 1Gwcbl3xINMHAesdOsYGUEt18/SiWQgQBhZ8OT9YLt3KQ09jMO1EQbxnOqVI/XqkFVzE
 QqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685895758; x=1688487758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ziJ19CMyxRqhzyNJybOr3djel6YcFYrtRHZwwYAbfLo=;
 b=AcvjneUBuMN8auliK12Hrsm781Hs0HXl3p7Xota5vfYtvBegdjtet+9UOUXxE6cEbY
 Fg/CrTTd5rmIZ6E7zlZfBF6N5gqH53hYZZs0GZhPD+eF+jgEgzPy5qwxDkGsaTvXFJTl
 D4eG5Cz+2fr/46LpfrFzzuH/iVp1IDoa11O05kMdhJ5+fgjRLnlxbTTecR0GEtx+DB1t
 60C/ie0ejGK6rWgqHG1jdsj+To1yZj2U0vs1zIWsfJhEWneR9MXLlTbmLWwhian9gi/1
 9GfKPbnSeRddbZY4moyhjPoPJrr7gihLlXvji8uw9+cmbQuj3GmNkG+GaJvr9EG40zXj
 4gPQ==
X-Gm-Message-State: AC+VfDx3VcKqqqYCHzcYIfb8E6kmUjfJ9yax2P+LfKkEhNCOj6Oj9R8R
 hLQYgt3zOAmmzHxCRaipS9wPgg==
X-Google-Smtp-Source: ACHHUZ4QYU60uoe7W4rQz5qQODaU2nYItcpSZsCmZpbD1rHuuMDGTVEtQ9RVGpYXGza4kpVoPYr4gA==
X-Received: by 2002:a05:6358:bd04:b0:128:9ba2:9ec2 with SMTP id
 dh4-20020a056358bd0400b001289ba29ec2mr1286329rwb.7.1685895758339; 
 Sun, 04 Jun 2023 09:22:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7d0c:4d62:710d:ff28?
 ([2602:ae:1598:4c01:7d0c:4d62:710d:ff28])
 by smtp.gmail.com with ESMTPSA id
 8-20020a17090a01c800b00252d960a8dfsm6562040pjd.16.2023.06.04.09.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 09:22:37 -0700 (PDT)
Message-ID: <bcd3a4ce-37c2-af3e-0d66-bac4e9bd7eac@linaro.org>
Date: Sun, 4 Jun 2023 09:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] target/ppc: Rework store conditional to avoid branch
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-4-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230604102858.148584-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/4/23 03:28, Nicholas Piggin wrote:
> Rework store conditional to avoid a branch in the success case.
> Change some of the variable names and layout while here so
> gen_conditional_store more closely matches gen_stqcx_.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/translate.c | 65 ++++++++++++++++++++----------------------
>   1 file changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 77e1c5abb6..cf99e961f7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3812,31 +3812,32 @@ static void gen_stdat(DisasContext *ctx)
>   
>   static void gen_conditional_store(DisasContext *ctx, MemOp memop)
>   {
> -    TCGLabel *l1 = gen_new_label();
> -    TCGLabel *l2 = gen_new_label();
> -    TCGv t0 = tcg_temp_new();
> -    int reg = rS(ctx->opcode);
> +    TCGLabel *lfail;
> +    TCGv EA;
> +    TCGv cr0;
> +    TCGv t0;
> +    int rs = rS(ctx->opcode);
>   
> +    lfail = gen_new_label();
> +    EA = tcg_temp_new();
> +    cr0 = tcg_temp_new();
> +    t0 = tcg_temp_new();
> +
> +    tcg_gen_mov_tl(cr0, cpu_so);
>       gen_set_access_type(ctx, ACCESS_RES);
> -    gen_addr_reg_index(ctx, t0);
> -    tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
> -    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, memop_size(memop), l1);
> +    gen_addr_reg_index(ctx, EA);
> +    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, memop_size(memop), lfail);
>   
> -    t0 = tcg_temp_new();
>       tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
> -                              cpu_gpr[reg], ctx->mem_idx,
> -                              DEF_MEMOP(memop) | MO_ALIGN);
> +                              cpu_gpr[rs], ctx->mem_idx,
> +                              memop | MO_ALIGN);

Lost DEF_MEMOP here.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

