Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212237227AB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ATf-0006MP-Ki; Mon, 05 Jun 2023 09:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATd-0006Kd-6U; Mon, 05 Jun 2023 09:42:29 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATb-00017Q-G8; Mon, 05 Jun 2023 09:42:28 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1a15ce37b39so5442225fac.1; 
 Mon, 05 Jun 2023 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972545; x=1688564545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ke61rezqvRHLpeBHeQ/7QurMVhhoywcdK6P6Ml5//Tg=;
 b=VeIJYTXhYowwsVE4l2whTO38XhCKp0PhsXHZBm3ZCT3QUWwBwwpxGF2BUgyTDQIwPj
 MSdjL/A8BLtLnE+4QJfZrZXCMTxYB+IZATzPGhRHvePQsI0Su2x2DtvF3GpJ7piHLvVO
 5GedSqnotgCZbQwP6pwNUbGi1+DQzNkwhGDQOQgZY0e+KEPIb3drqr1S1jFUbf3jRArk
 8QwGO4dqY+nZRgdkSiZUQV90ikMlzVqp9v/9haSuDVWpROlbY8xaTGFW3FNe/svjWewO
 QGjfHoJjl8zwvHSdFWYLZhGf34I08NxrBE7UM9tgKwJk2ep6zmbDXUBrbponzH5feqdm
 5Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972545; x=1688564545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ke61rezqvRHLpeBHeQ/7QurMVhhoywcdK6P6Ml5//Tg=;
 b=c8ic4MqL2ZdVe0Alu4eRiRQTJjXgn3x2ejEnoNicWL2w0YC9ufKuWte5aSsHkupFrM
 csHy2HxHhvriOJ7LbIw8hp6HdOCBPIea8mL4zUiiLMYIXaY3UqAd/oH9eSCvLzdhvHLk
 BdoJpwfOk2YSQ6k5bViNO5kaMvdhnrjbdceFioOM/uITLVc511Evv9xglofJ6RMTnCus
 NjqlFXGdWgL5lmqoFZ6WHFGyTPTgZ35Ug6eQQx2SyvJBAY9y0/uA7aZjXibV0/hvBFY3
 38brm9fR3me/zhjqHaVv2bvKTj0B8/kNuN6M7B90cIvakZmSzjIKku0P206xfKSQhozI
 uDEw==
X-Gm-Message-State: AC+VfDwiGSDWry9ccqfYeLJhDqoKNyCehz4bSfkqcCdcWgYBBcDBPAHH
 W7R/ZNNISfRpMrkeD18rock=
X-Google-Smtp-Source: ACHHUZ76DpBbuJA4Td/jPEEeYZgfcP/JZn77LFBELdhLViQK98SARPyBouNaUdR60XUKh501oCcaTw==
X-Received: by 2002:a05:6870:4311:b0:196:cd24:14e6 with SMTP id
 w17-20020a056870431100b00196cd2414e6mr7717194oah.11.1685972545557; 
 Mon, 05 Jun 2023 06:42:25 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a056820138a00b0054fdb673104sm267562oow.9.2023.06.05.06.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:42:25 -0700 (PDT)
Message-ID: <6a1f0c3f-2063-be85-6d58-c672472d019a@gmail.com>
Date: Mon, 5 Jun 2023 10:42:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] target/ppc: Rework store conditional to avoid
 branch
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230605025445.161932-1-npiggin@gmail.com>
 <20230605025445.161932-4-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230605025445.161932-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> Rework store conditional to avoid a branch in the success case.
> Change some of the variable names and layout while here so
> gen_conditional_store more closely matches gen_stqcx_.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued. Thanks,


Daniel

> v2:
> - Reinstate lost DEF_MEMOP [Richard]
> 
> I think the DEF_MEMOP is redundant here, but admit that's not something
> that should be changed with this patch. I will look at cleaning those up
> later.
> 
> Thanks,
> Nick
> 
>   target/ppc/translate.c | 63 ++++++++++++++++++++----------------------
>   1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index acb99d8691..434caad258 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3813,31 +3813,32 @@ static void gen_stdat(DisasContext *ctx)
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
> -    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
> +    gen_addr_reg_index(ctx, EA);
> +    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
>   
> -    t0 = tcg_temp_new();
>       tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
> -                              cpu_gpr[reg], ctx->mem_idx,
> +                              cpu_gpr[rs], ctx->mem_idx,
>                                 DEF_MEMOP(memop) | MO_ALIGN);
>       tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
>       tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
> -    tcg_gen_or_tl(t0, t0, cpu_so);
> -    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
> -    tcg_gen_br(l2);
> +    tcg_gen_or_tl(cr0, cr0, t0);
>   
> -    gen_set_label(l1);
> -
> -    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
> -
> -    gen_set_label(l2);
> +    gen_set_label(lfail);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
>       tcg_gen_movi_tl(cpu_reserve, -1);
>   }
>   
> @@ -3891,25 +3892,26 @@ static void gen_lqarx(DisasContext *ctx)
>   /* stqcx. */
>   static void gen_stqcx_(DisasContext *ctx)
>   {
> -    TCGLabel *lab_fail, *lab_over;
> -    int rs = rS(ctx->opcode);
> +    TCGLabel *lfail;
>       TCGv EA, t0, t1;
> +    TCGv cr0;
>       TCGv_i128 cmp, val;
> +    int rs = rS(ctx->opcode);
>   
>       if (unlikely(rs & 1)) {
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>           return;
>       }
>   
> -    lab_fail = gen_new_label();
> -    lab_over = gen_new_label();
> +    lfail = gen_new_label();
> +    EA = tcg_temp_new();
> +    cr0 = tcg_temp_new();
>   
> +    tcg_gen_mov_tl(cr0, cpu_so);
>       gen_set_access_type(ctx, ACCESS_RES);
> -    EA = tcg_temp_new();
>       gen_addr_reg_index(ctx, EA);
> -
> -    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
> -    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
> +    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
>   
>       cmp = tcg_temp_new_i128();
>       val = tcg_temp_new_i128();
> @@ -3932,15 +3934,10 @@ static void gen_stqcx_(DisasContext *ctx)
>   
>       tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
>       tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
> -    tcg_gen_or_tl(t0, t0, cpu_so);
> -    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
> -
> -    tcg_gen_br(lab_over);
> -    gen_set_label(lab_fail);
> -
> -    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
> +    tcg_gen_or_tl(cr0, cr0, t0);
>   
> -    gen_set_label(lab_over);
> +    gen_set_label(lfail);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
>       tcg_gen_movi_tl(cpu_reserve, -1);
>   }
>   #endif /* defined(TARGET_PPC64) */

