Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5997E5F83
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:56:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pao-0005Ej-4u; Wed, 08 Nov 2023 15:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0paY-0005E6-W2
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:55:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0paV-0005fj-UJ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:55:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so515785e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476946; x=1700081746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOxgXi0+nZ830fEffTfy/FaqPFSWjQNHLF2MJ3HjJgE=;
 b=dIP/43WcQNgKN/dj+E+4GHlvStT2xoqCeOKTHGYNXSeud44PE3tVEEv2Fp++AgB/Dj
 9SNRTPIT/9S2z1PDsZcYqO7tqDQhmCeSMJITForifVCerSd5nZUCoogpoEpXOxZna1aF
 FNthZzysxSqPFYe6cjzYR2V0O0Fj+sowYSkJBDoDIPXwhPet1KsN4MgX6tHOPOcNXdpy
 m70NAppLVE4HD/ViVW56eiS/XXqOxnVhSNN/3KIxWItPs2herG0wLzkOMFkVCu9QTu+9
 sGFYHQ3dKu3wx5LJ/Q4o8KqhPEBSLTEKf0BSw13n2H1cDbc8izFoWM5ytppvk6b1KcT5
 rE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476946; x=1700081746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOxgXi0+nZ830fEffTfy/FaqPFSWjQNHLF2MJ3HjJgE=;
 b=McSWwJwl89HtQwnclilt8czyIepamPI//B3VcMg8UjRoC566wQBYDhW994bc/52XgP
 HVv4EuhZRIu1aYYN1S7jfHo2tCSHphSfaezaiRXR03TE7CIhJlwUgZm/IbOTT60g33pb
 aGeQGX0F51UxqzQz1ejf/8wQ5NUskCPGHn2gouAGYHx9Juhl3t6ndMFPR7MTr2E8hBnP
 j/3oeEakwumNsG9o2TvCtt/Nrc9dXLemG6c9YapRe1ASAife8GkVEXCDcw92fUf0p5wp
 ye9sQu/AlKdGNUTrZHJdvTPXSFPhx/BP4rKdc9bV/UB31vp0pmigsSsGAVDI5Z6BKhCh
 rJtw==
X-Gm-Message-State: AOJu0YyzDCQbEVpol0SoFnj23WdNN0BK0VqITRHJvjwiaDrONCsGVPgJ
 W8jhCDmYsOMjMC04WBTyj1zW87O9b2kzkEF50nc=
X-Google-Smtp-Source: AGHT+IGTu3L1JO1mOswApDqaVA0vHgKufSuDFsJIX1ujErBJ/jX/pirCDdrWitNFm0QD1+vcGK/K6w==
X-Received: by 2002:a05:600c:45c9:b0:409:7900:f3ef with SMTP id
 s9-20020a05600c45c900b004097900f3efmr2760546wmo.38.1699476946090; 
 Wed, 08 Nov 2023 12:55:46 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm20771584wms.4.2023.11.08.12.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 12:55:45 -0800 (PST)
Message-ID: <9e0ddda1-8b4b-47b1-ae2a-b8ffd32536dd@linaro.org>
Date: Wed, 8 Nov 2023 21:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/35 1/2] target/alpha: Pass immediate value to
 gen_bcond_internal()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20231028194522.245170-33-richard.henderson@linaro.org>
 <20231108205247.83234-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108205247.83234-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/11/23 21:52, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Simplify gen_bcond() by passing an immediate value.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
> [PMD: Split from bigger patch, part 1/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 32333081d8..46efe1df7c 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
>   }
>   
>   static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
> -                                        TCGv cmp, int32_t disp)
> +                                        TCGv cmp, uint64_t imm, int32_t disp)
>   {
>       uint64_t dest = ctx->base.pc_next + (disp << 2);
>       TCGLabel *lab_true = gen_new_label();
>   
>       if (use_goto_tb(ctx, dest)) {
> -        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
> +        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
>   
>           tcg_gen_goto_tb(0);
>           tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
> @@ -472,11 +472,11 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
>   
>           return DISAS_NORETURN;
>       } else {
> -        TCGv_i64 z = load_zero(ctx);
> +        TCGv_i64 i = tcg_constant_i64(imm);
>           TCGv_i64 d = tcg_constant_i64(dest);
>           TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
>   
> -        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
> +        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
>           return DISAS_PC_UPDATED;
>       }
>   }
> @@ -484,15 +484,8 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
>   static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
>                                  int32_t disp, int mask)
>   {
> -    if (mask) {
> -        TCGv tmp = tcg_temp_new();
> -        DisasJumpType ret;
> -
> -        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
> -        ret = gen_bcond_internal(ctx, cond, tmp, disp);
> -        return ret;
> -    }
> -    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
> +    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
> +                              !!mask, disp);

Hmm we can pass 'mask' directly.

>   }
>   
>   /* Fold -0.0 for comparison with COND.  */
> @@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
>       DisasJumpType ret;
>   
>       gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
> -    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
> +    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
>       return ret;
>   }
>   


