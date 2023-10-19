Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BF7D0446
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtb13-0000Bm-Kc; Thu, 19 Oct 2023 17:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtb11-0000BU-Ga
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:57:15 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtb0z-0006YC-RJ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:57:15 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso2281411fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697752632; x=1698357432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q3Sr2fUKVpN1YpDy4gHDaG94E82b1qaIpPoDFISKM1Q=;
 b=YSg2CjbcdNjChLGMSfAecmCEccrWzw/efu6k61HhD1gBrsWeJtsmUPD27uzTnUE4n7
 FEmrZrS7Yjko6FxuKeBshipoUHolDT1I8kXJD74cmG0KeOICe34GNVoOj+2spAEr9SFc
 qMXGABrWHfTrB2cUUxbqRbzFvi0yJtY/05vlmt6G35uVwYGkpCEyaqRkFcrx1qv9xUqj
 Y+AJdrmQ3bWvUig05VEAWKcIb6Ih8lI2KOu18HPa2iqaNQzkhGqUwmhKQp2eZ237dmDL
 5Fi+djK1fAoZnGCnG04UifvxJgoJrjEs9OIvFEj8Q495xzZf6btFy+CiDHNXmlXAy+Bp
 sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752632; x=1698357432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3Sr2fUKVpN1YpDy4gHDaG94E82b1qaIpPoDFISKM1Q=;
 b=ZWN5SQdnkUELm4aCP2aQYYfAaRTJpAg5R+qh7zp+Hn73jRCiO0krcARJ374hXzN8Us
 3ivi919vvKUd0xsW7NNEPBMA7uVg0RIsKErNcKuPZyd4bNxNUOnl5x9xQjSRh04vQQc8
 30s5yB9+kV56RR4KgwOTNWbwE34UwyiPkfWwMaFJRH9t79b9PEYj36Mj9gPSfywqO2je
 io2FGI1I0b+pocmtXTgsKjks6vhjKFh5jkQtHfUzfk3Bg9TDMZZYjjF2TyrCCVjAH1Ky
 Z54GYSwhzRJbiSoohu/8hpwCSSEWY8OlBRU52MhphSdoEWZ4mtK3sy1RjdF1Hx8p4J0y
 o8NA==
X-Gm-Message-State: AOJu0YyVewcjmY1YJdFbxghU52sEvWaRmflF7+xXkClQVLG0W+4RCRph
 8JgGdjVGtaVOd4hKlDGixbjp9g==
X-Google-Smtp-Source: AGHT+IEiS1oLwHEyGz+wX3jLgjFiiajASO9613ckYELCsrChzp1FAvV5UzUrAELzoBgi5b39k7gnxA==
X-Received: by 2002:a2e:9992:0:b0:2c5:4718:5d45 with SMTP id
 w18-20020a2e9992000000b002c547185d45mr111787lji.52.1697752632081; 
 Thu, 19 Oct 2023 14:57:12 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c458600b00406443c8b4fsm5448109wmo.19.2023.10.19.14.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:57:11 -0700 (PDT)
Message-ID: <5f54e3e1-1c90-0249-04f4-df522e292abe@linaro.org>
Date: Thu, 19 Oct 2023 23:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] target/i386: Use tcg_gen_ext_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 19/10/23 20:29, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 28 +++-------------------------
>   1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 0c81e066de..d420ed8f0a 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -701,33 +701,11 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
>   
>   static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
>   {
> -    switch (size) {
> -    case MO_8:
> -        if (sign) {
> -            tcg_gen_ext8s_tl(dst, src);
> -        } else {
> -            tcg_gen_ext8u_tl(dst, src);
> -        }
> -        return dst;
> -    case MO_16:
> -        if (sign) {
> -            tcg_gen_ext16s_tl(dst, src);
> -        } else {
> -            tcg_gen_ext16u_tl(dst, src);
> -        }
> -        return dst;
> -#ifdef TARGET_X86_64
> -    case MO_32:
> -        if (sign) {
> -            tcg_gen_ext32s_tl(dst, src);
> -        } else {
> -            tcg_gen_ext32u_tl(dst, src);
> -        }
> -        return dst;
> -#endif
> -    default:
> +    if (memop_size(size) == TARGET_LONG_BITS) {
>           return src;
>       }
> +    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
> +    return dst;
>   }

While here, I'd rename 'size' -> 'mop'. Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

