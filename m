Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8E7E5F9D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0piX-0000Um-MT; Wed, 08 Nov 2023 16:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0piV-0000UH-3b
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:04:03 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0piT-0007pK-CB
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:04:02 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso1384561fa.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 13:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699477439; x=1700082239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z8aM1Ib8UMp170QJ36gwew/hWv1wzCwtdDC2AGHbG9E=;
 b=k/RIK2t8lCdGQ3kw2tJUN1ZxpPMOF+M/WAxc+y2tTTxH2ZQhbeIl+y0hCopPEJF6wy
 pqoCzN0dRbFE5jJSMy9yB/sce4oBccJQDWhqeJFGZygcu4eGXanTnegXnbtv4jX/WvNT
 R57EOa3RDa4FHO+Vo1VE+P4fDxg/SMdMbX0rYd1MHsTj5xFtnwj8Gc8DTnBaKr6fgHiA
 C162CbNfZAh0lT/5C5dsvDVyW8hU7IFZl74as8xZW0BoEhAQcLjoH3+5c1zGWff1ry6G
 +qH7m5Smd7RFviZPhv2SumZeYuVGD7MEJNisXVuoy1YX5ZAV+WC3JJ6fT4YnyPBoCxpD
 Ra+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699477439; x=1700082239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8aM1Ib8UMp170QJ36gwew/hWv1wzCwtdDC2AGHbG9E=;
 b=O0fKnimoU7PM4vXQ83pH4ILe/i4yHJKXzBaKygox7gkJoFdgXrY6rWO1FzG1WA3KzP
 sn3lyQRZ2Sbg9Zt8GH2CWtBsoEPXjnNo56TRMCyGPxcn+tbtJWyRJngsKy98ZxHhxg2/
 +e2WQRH4l5cIy94BqcNi3PUeHBiUEv6/ZQjsEYL2bLWiQL/E1BI7B3H+PODDIGnK6CKa
 kr7DMmD6J5T8yc7st+4qsLhxlzQ4w0AedkgL465fop5HnynA9KBrD8S59PwyLWY8qLLt
 o2N79U6qak8ddG8AMGdLjc8Fo15NQayoQ+8tCUQmIRu1uh94eE/bWN9oGrf4qXgpZZyh
 XCng==
X-Gm-Message-State: AOJu0YyXHviRL1ADhGtg0mlRFIwjWPAl+bZoTZ/px/DfBCezfN9bYGEm
 8kvXuAf1g0876jIpu20kZreDdyFuatX2s/e5448=
X-Google-Smtp-Source: AGHT+IGB2W+DarqZ5vJp1XE5QzjrCTqnIOdcjdmUmm4tXCDjUJ5ekwRPGxXiSlpKqVRKC71sL9Uw4g==
X-Received: by 2002:a05:651c:222b:b0:2c5:11fe:53b2 with SMTP id
 y43-20020a05651c222b00b002c511fe53b2mr3256323ljq.37.1699477438951; 
 Wed, 08 Nov 2023 13:03:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c168200b00405718cbeadsm1163097wmn.1.2023.11.08.13.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 13:03:58 -0800 (PST)
Message-ID: <7e8a5d3d-2d81-4cc4-808e-265ae786dc2c@linaro.org>
Date: Wed, 8 Nov 2023 22:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/35] target/alpha: Use TCG_COND_TSTNE for
 gen_fold_mzero
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 49 +++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index c7daf46de7..c68c2bcd21 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -490,56 +490,53 @@ static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
>   
>   /* Fold -0.0 for comparison with COND.  */
>   
> -static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
> +static TCGv_i64 gen_fold_mzero(TCGCond *pcond, uint64_t *pimm, TCGv_i64 src)
>   {
> -    uint64_t mzero = 1ull << 63;
> +    TCGv_i64 tmp;
>   
> -    switch (cond) {
> +    *pimm = 0;
> +    switch (*pcond) {
>       case TCG_COND_LE:
>       case TCG_COND_GT:
>           /* For <= or >, the -0.0 value directly compares the way we want.  */
> -        tcg_gen_mov_i64(dest, src);
> -        break;
> +        return src;
>   
>       case TCG_COND_EQ:
>       case TCG_COND_NE:
> -        /* For == or !=, we can simply mask off the sign bit and compare.  */
> -        tcg_gen_andi_i64(dest, src, mzero - 1);
> -        break;
> +        /* For == or !=, we can compare without the sign bit. */

> +        *pcond = *pcond == TCG_COND_EQ ? TCG_COND_TSTEQ : TCG_COND_TSTNE;

OK, $subject is only this line, the rest is purely refactoring.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        *pimm = INT64_MAX;
> +        return src;
>   
>       case TCG_COND_GE:
>       case TCG_COND_LT:
>           /* For >= or <, map -0.0 to +0.0. */
> -        tcg_gen_movcond_i64(TCG_COND_NE, dest, src, tcg_constant_i64(mzero),
> -                            src, tcg_constant_i64(0));
> -        break;
> +        tmp = tcg_temp_new_i64();
> +        tcg_gen_movcond_i64(TCG_COND_EQ, tmp,
> +                            src, tcg_constant_i64(INT64_MIN),
> +                            tcg_constant_i64(0), src);
> +        return tmp;
>   
>       default:
> -        abort();
> +        g_assert_not_reached();
>       }
>   }


