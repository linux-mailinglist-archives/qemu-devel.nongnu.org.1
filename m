Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE6381FB89
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyog-00030K-Sj; Thu, 28 Dec 2023 17:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyof-00030B-40
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:25:25 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyod-0001jU-Eq
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:25:24 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2041bb80cb3so4752545fac.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703802322; x=1704407122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xJfb7Vg2M9OxoUmqWy1rnYXQ1sBWophXy9m+E7lV4s=;
 b=vsTjmcexIZsNkm09O5AuT6/GKd/YghO7FO9HdDBWVfmC88TAZKXGMzQh61jOEvBAb0
 n6q7UxaIrV75L7xElxSa3KGFyJm2r3tunq/7SxBKpyOKUuqq4VhvP9CulLj2aauPr5ya
 +IKiaPBuO3YAC43hvfV4+zUy4D3tuJg4Ykj/z3tQgm7EkYkFPPwgx3d+LuDrKTYQWe56
 2+YFwff++jovBNBir1XsPsun/DV/gY2vvY4/uIino0FRrgE51cVkXvrMz1JkyOc/h4hd
 IuBSKJR3HV8vK/lNuvkodxbEui6HiZm7T179qY4IHx5Ldevyz1hxFkBkYVWdJi3sGaK9
 jLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703802322; x=1704407122;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xJfb7Vg2M9OxoUmqWy1rnYXQ1sBWophXy9m+E7lV4s=;
 b=M/W9pUXBDd7l9XfrGA1zUZp1WdkxAXELmEndQRINQ8bXYlp3xogN6/e9vbaiyhrhJd
 QzRYmpyfCzBIaaY+PDD+chKZPba2e1elGrOV8V7IXvNLzeMwqK05VqLtHXIckUnPeJE7
 2IvP9bmNqxUvApJwwYgpup8aIxxvPdVyKCFnXH9O8EipPsKD7j5bbfgbgb/L+8aFeMYs
 v5IB+A3Z7NpYXnSC6vQb554moi904Yck+rGw5r0/RpZ/iXVFIDB/d9CQHRKctHnsqRQ9
 FyFxLqX7TBraKziUHRBerJYZOkclxTqlUvT9llNpm7sgFsgSJq8FpNwN5IM+73CBG6JG
 ZJKA==
X-Gm-Message-State: AOJu0YwUP6SCZ3dLclg62iSeazQ+l0Tnqa5qKS2zEo1SZVwXTYTzLEya
 qgdFS33WnISYHRFYtBviJ+CmO3SUQDUpEA==
X-Google-Smtp-Source: AGHT+IF6L18SdZi7v/xOX57+oHos6E3zVeOo+ZFiaPnADb+sT39DVpl5AsI/HKAf/M1WspeB4fEv8A==
X-Received: by 2002:a05:6871:10f:b0:203:b52f:7079 with SMTP id
 y15-20020a056871010f00b00203b52f7079mr12633725oab.115.1703802321786; 
 Thu, 28 Dec 2023 14:25:21 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 r29-20020aa79edd000000b006d9c65cc854sm6822111pfq.26.2023.12.28.14.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:25:21 -0800 (PST)
Message-ID: <5294c676-706e-492d-b46a-e62d87a4fb5c@linaro.org>
Date: Fri, 29 Dec 2023 09:25:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] target/i386: extract gen_far_call/jmp, reordering
 temporaries
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-18-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> Extract the code into new functions, and swap T0/T1 so that T0 corresponds
> to the first immediate in the instruction stream.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 90 ++++++++++++++++++++-----------------
>   1 file changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index e5f71170967..edbad0ad746 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2525,12 +2525,12 @@ static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
>                        offsetof(CPUX86State,segs[seg_reg].selector));
>   }
>   
> -static inline void gen_op_movl_seg_T0_vm(DisasContext *s, X86Seg seg_reg)
> +static inline void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)

In general, you probably want to drop inline markers as you come across them, and just let 
the compiler inline as it chooses.

>   {
> -    tcg_gen_ext16u_tl(s->T0, s->T0);
> -    tcg_gen_st32_tl(s->T0, tcg_env,
> +    tcg_gen_ext16u_tl(seg, seg);

While cleaning, maybe better to not silently modify the input?

> +static void gen_far_call(DisasContext *s)
> +{
> +    if (PE(s) && !VM86(s)) {
> +        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
> +        gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T0,
> +                                   tcg_constant_i32(s->dflag - 1),
> +                                   eip_next_tl(s));
> +    } else {
> +        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
> +        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);

New temps?

> +        gen_helper_lcall_real(tcg_env, s->tmp3_i32, s->tmp2_i32,
> +                              tcg_constant_i32(s->dflag - 1),
> +                              eip_next_i32(s));
> +    }
> +    s->base.is_jmp = DISAS_JUMP;
> +}
> +
> +static void gen_far_jmp(DisasContext *s)
> +{
> +    if (PE(s) && !VM86(s)) {
> +        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);

Likewise.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

