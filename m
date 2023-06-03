Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E382720E02
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 07:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5KF1-0005f9-DA; Sat, 03 Jun 2023 01:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KEs-0005eg-Am
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:55:46 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KEq-00014J-Nd
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:55:46 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3980f2df1e7so2351073b6e.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685771742; x=1688363742;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jttbcJnFZj39GM1LJug9GJjGL1ipDurAc4n00MT/aso=;
 b=ZlaYwgEvBKfFlxXVf80aEV9ctcabAaoqK9DimxRwKQKcopMOCyBPPA3q4gRZQKaS2i
 P+DwWxvV+Zx66qIiZXII7jViOWEc3S68XcFfxxnUd97R1TpBTsAsPWoM5wI9a4JRRAYc
 P66+SzDd+otWvHo5ZxlODFlRbTFj7iQrySPPLNODR0Gc9dX5BmfsFnCJoKA80+pYUmvU
 fP7hMXA3QgreT9AbKGLUFIBOQDgLcU2f2hjcJfrmYNSKKZFjsIZx4v0ZYxL+fmZ2oc9H
 mTVj60nX8yoO8u4iyFubZ/p0XJZGX+yO+eTL0sLeMtLeXTq5ufixLcXig/Yo8Pf/2BNE
 NJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685771742; x=1688363742;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jttbcJnFZj39GM1LJug9GJjGL1ipDurAc4n00MT/aso=;
 b=QaD6Z0/WNk2djHcMLGVQMWrn+762ovbsjvv6/S4lLzmWOHqdgnMhHBdB7MUAMSaLR2
 98EXAh/WGbY/D4N6NJd2WRCtHeycunKOR1CYN5/X42VxxL6mNjzkyuoxOADevQ5ud4OR
 JT1LopLWqFOgl3pqSk700IyyinMNMaAsEj2fT48stl+5WIFpWQbz+jLO3U8EgbAMD7pf
 7FF/L+c1bco8JFqJVw37klW3tH2rGoIqU9xr7tTYXnXwIUoQ10oXvN+XFvc1UJNgAgqu
 zwICz2l8XYHh9aJ4hT7x8L7qUgvq8VXutOahvM9xyA44S0pYJoELMpj697mlS+8XUpo1
 LDdQ==
X-Gm-Message-State: AC+VfDw/86FlnQsjoiws6R0MDgpytSZE99zj9DX9c/TKTYfaoHa/ICG9
 PifSbO/sK+MAU8xarW1s/stCVQ==
X-Google-Smtp-Source: ACHHUZ5GFAqPLC5LAM4YaQIbLkgOKfYVpCqqsQmeq9lKbkxefVVPZnBm8xTg1ML20aos2nBoBrK4jw==
X-Received: by 2002:aca:2b08:0:b0:398:c78:ab82 with SMTP id
 i8-20020aca2b08000000b003980c78ab82mr2534998oik.19.1685771742128; 
 Fri, 02 Jun 2023 22:55:42 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 ik8-20020a170902ab0800b001a194df5a58sm2345266plb.167.2023.06.02.22.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 22:55:41 -0700 (PDT)
Message-ID: <16f864db-7f60-3176-461d-f510243d2d60@linaro.org>
Date: Fri, 2 Jun 2023 22:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/20] target/arm: Convert CFINV, XAFLAG and AXFLAG to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the CFINV, XAFLAG and AXFLAG insns to decodetree.
> The old decoder handles these in handle_msr_i(), but
> the architecture defines them as separate instructions
> from MSR (immediate).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  6 ++++
>   target/arm/tcg/translate-a64.c | 56 ++++++++++++++++++----------------
>   2 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 553f6904d9c..26a0b44cea9 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -188,3 +188,9 @@ CLREX           1101 0101 0000 0011 0011 imm:4 010 11111
>   DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
>   ISB             1101 0101 0000 0011 0011 imm:4 110 11111
>   SB              1101 0101 0000 0011 0011 0000 111 11111
> +
> +# PSTATE
> +
> +CFINV           1101 0101 0000 0 000 0100 0000 000 11111
> +XAFLAG          1101 0101 0000 0 000 0100 0000 001 11111
> +AXFLAG          1101 0101 0000 0 000 0100 0000 010 11111
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 09258a9854f..33bebe594d1 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1809,9 +1809,25 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
>       return true;
>   }
>   
> -static void gen_xaflag(void)
> +static bool trans_CFINV(DisasContext *s, arg_CFINV *a)
>   {
> -    TCGv_i32 z = tcg_temp_new_i32();
> +    if (!dc_isar_feature(aa64_condm_4, s)) {
> +        return false;
> +    }
> +    tcg_gen_xori_i32(cpu_CF, cpu_CF, 1);
> +    s->base.is_jmp = DISAS_NEXT;
> +    return true;
> +}

The settings of is_jmp do not need to be copied across.
That's another benefit of extracting from MSR_i.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

