Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61AB821991
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:20:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbrW-0002Oq-2I; Tue, 02 Jan 2024 05:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbrT-0002OH-Sh
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:19:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbrR-0008Rj-TJ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:19:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d76fefd6bso30302225e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704190740; x=1704795540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P0/StGvVuC/bo6BjbyC2TfUp3Xe9igN8yY9DbnztYMw=;
 b=jelUYgtCirFYF9E4/JYMjqKq2DlV6EgJzLpFU0IWHklbkPYqvByxefTqhzGaP0rEj7
 fIt+XrgFLK8ggry2IIpHJ+fxOxUwkotIlqCP+iTIdcVWcSs0FXfs40xAvmYqEryH94Re
 dj/si4P2GWx+a6unaJQvDFl4zZdlEn51VoamLdRvvn1HJvMJ03BJYw1nWiSCdgEfOlH6
 pTYimI8obMzGE/HQLoYk9ANTjm3ldf56u1S1tZ4vwkxHk4XoD5Hdh0WoZTJ7cYo8PJej
 RW6P6FkXlPzvDJXc+MdMkrqqVL4nW2IqcP8aTE7WWXG7zzcAPbiNI+IDS8mUfHqZhO5U
 QxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704190740; x=1704795540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0/StGvVuC/bo6BjbyC2TfUp3Xe9igN8yY9DbnztYMw=;
 b=pxbhZ5m5MYyo5fUznwHI7Q3luyyPLZxpzHmK4eGScv/dQ4+lmFqRCQEwiuJ3P4Bw61
 k0fbSR34n+TPc/ruPMLBRwakdbmkKr9zci0/j8uMwG0IP1nGwhYu744aYQ9HEcAyomrG
 U1n7Wb9+69sF6P9B7pgQHZJcIjkd7zyhlaZEQOTV4Wz7oALHhBlV5sJ0t5siOKEmmMpZ
 PhWCiBjuWawZUk7agJxceCsDvV2TLG6yp66X5MJVNs7WuxzPsZnKFVSuriDBov8T7HXw
 wdy84dBHfQ6+bDyQmIfRZ/FknBMozwtJg+wXNrs6vc/nGO7X+fzqCEGBrOAXofSDbpT/
 rJmA==
X-Gm-Message-State: AOJu0YweJyfgUtQqfq/fZQneAscdy5fBP9dXrdK2jc6Hu3YbVw8bttHV
 Y9CkmqtGAghMad3prKO4Qt6oCS09RAAnNQ==
X-Google-Smtp-Source: AGHT+IHcHCCbYJ8jUxi5t6IgylxO3cYuJydaI1XKZXMQHFbWgDUzRAgQ+lYNnPqv5oUOqmqc5ePpkQ==
X-Received: by 2002:a05:600c:6a98:b0:40d:5c0c:927e with SMTP id
 jl24-20020a05600c6a9800b0040d5c0c927emr2487060wmb.373.1704190740128; 
 Tue, 02 Jan 2024 02:19:00 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 s21-20020a05600c45d500b0040c3953cda5sm51875328wmo.45.2024.01.02.02.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:18:59 -0800 (PST)
Message-ID: <22711e1f-088f-4d92-a307-cdf7603e8571@linaro.org>
Date: Tue, 2 Jan 2024 11:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/ppc: Use new registers for LQ destination
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240102013456.131846-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102013456.131846-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/1/24 02:34, Richard Henderson wrote:
> LQ has a constraint that RTp != RA, else SIGILL.
> Therefore, force the destination of INDEX_op_qemu_*_ld128 to be a
> new register pair, so that it cannot overlap the input address.
> 
> This requires new support in process_op_defs and tcg_reg_alloc_op.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 526cd4ec01f ("tcg/ppc: Support 128-bit load/store")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> This bug may be triggered with qemu-aarch64 and
> tests/tcg/multiarch/linux-test.c.
> 
> r~
> 
> ---
>   tcg/ppc/tcg-target-con-set.h |  2 +-
>   tcg/tcg.c                    | 21 ++++++++++++++++-----
>   tcg/ppc/tcg-target.c.inc     |  3 ++-
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
> index bbd7b21247..cb47b29452 100644
> --- a/tcg/ppc/tcg-target-con-set.h
> +++ b/tcg/ppc/tcg-target-con-set.h
> @@ -35,7 +35,7 @@ C_O1_I3(v, v, v, v)
>   C_O1_I4(r, r, ri, rZ, rZ)
>   C_O1_I4(r, r, r, ri, ri)
>   C_O2_I1(r, r, r)
> -C_O2_I1(o, m, r)
> +C_N1O1_I1(o, m, r)
>   C_O2_I2(r, r, r, r)
>   C_O2_I4(r, r, rI, rZM, r, r)
>   C_O2_I4(r, r, r, r, rI, rZM)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 896a36caeb..e2c38f6d11 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -653,6 +653,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
>   #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
>   
>   #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
> +#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1),
>   #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
>   
>   #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
> @@ -676,6 +677,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
>   #undef C_O1_I3
>   #undef C_O1_I4
>   #undef C_N1_I2
> +#undef C_N1O1_I1
>   #undef C_N2_I1
>   #undef C_O2_I1
>   #undef C_O2_I2
> @@ -696,6 +698,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
>   #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
>   
>   #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
> +#define C_N1O1_I1(O1, O2, I1)           { .args_ct_str = { "&" #O1, #O2, #I1 } },
>   #define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
>   
>   #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
> @@ -718,6 +721,7 @@ static const TCGTargetOpDef constraint_sets[] = {
>   #undef C_O1_I3
>   #undef C_O1_I4
>   #undef C_N1_I2
> +#undef C_N1O1_I1
>   #undef C_N2_I1
>   #undef C_O2_I1
>   #undef C_O2_I2
> @@ -738,6 +742,7 @@ static const TCGTargetOpDef constraint_sets[] = {
>   #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
>   
>   #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
> +#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1)
>   #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
>   
>   #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
> @@ -2988,6 +2993,7 @@ static void process_op_defs(TCGContext *s)
>                       .pair = 2,
>                       .pair_index = o,
>                       .regs = def->args_ct[o].regs << 1,
> +                    .newreg = def->args_ct[o].newreg,
>                   };
>                   def->args_ct[o].pair = 1;
>                   def->args_ct[o].pair_index = i;
> @@ -3004,6 +3010,7 @@ static void process_op_defs(TCGContext *s)
>                       .pair = 1,
>                       .pair_index = o,
>                       .regs = def->args_ct[o].regs >> 1,
> +                    .newreg = def->args_ct[o].newreg,
>                   };
>                   def->args_ct[o].pair = 2;
>                   def->args_ct[o].pair_index = i;
> @@ -5036,17 +5043,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>                   break;
>   
>               case 1: /* first of pair */
> -                tcg_debug_assert(!arg_ct->newreg);
>                   if (arg_ct->oalias) {
>                       reg = new_args[arg_ct->alias_index];
> -                    break;
> +                } else if (arg_ct->newreg) {
> +                    reg = tcg_reg_alloc_pair(s, arg_ct->regs,
> +                                             i_allocated_regs | o_allocated_regs,
> +                                             output_pref(op, k),
> +                                             ts->indirect_base);
> +                } else {
> +                    reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
> +                                             output_pref(op, k),
> +                                             ts->indirect_base);
>                   }
> -                reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
> -                                         output_pref(op, k), ts->indirect_base);
>                   break;
>   
>               case 2: /* second of pair */
> -                tcg_debug_assert(!arg_ct->newreg);
>                   if (arg_ct->oalias) {
>                       reg = new_args[arg_ct->alias_index];
>                   } else {
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 856c3b18f5..54816967bc 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2595,6 +2595,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>           tcg_debug_assert(!need_bswap);
>           tcg_debug_assert(datalo & 1);
>           tcg_debug_assert(datahi == datalo - 1);
> +        tcg_debug_assert(!is_ld || datahi != index);
>           insn = is_ld ? LQ : STQ;
>           tcg_out32(s, insn | TAI(datahi, index, 0));
>       } else {
> @@ -4071,7 +4072,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>   
>       case INDEX_op_qemu_ld_a32_i128:
>       case INDEX_op_qemu_ld_a64_i128:
> -        return C_O2_I1(o, m, r);
> +        return C_N1O1_I1(o, m, r);
>       case INDEX_op_qemu_st_a32_i128:
>       case INDEX_op_qemu_st_a64_i128:
>           return C_O0_I3(o, m, r);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


