Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94271650B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40f2-00039w-RP; Tue, 30 May 2023 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40eg-0002B3-Sy
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40ef-0007pL-1U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b04706c974so17615245ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685458135; x=1688050135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mRotw+iSAUVrUeFod2O6JDCzdceQwIv5HTL8rc+bKk=;
 b=zA28jFvu3gU/sDQZjNw9sMAUfvHHjlM9OSzCjN+BmK2NEnI8wmRJJLuplOaTEXVG0P
 6GWeYg8DPMscBeUW2D1ipfQY5g2MDkg5IJCy3kVbh0PTRFpRbALSYE4rMZboliXdQGbK
 IPZtpuhcPTXPWTjvM+qsYzqvbN684fPrunaY9nCRlIf4Nw+OS+SmiglkVKtrSQ91MuPX
 1+CghCn3C118vmbqcrwAP0x2rUXiG6OcrCuYyC4YR6b8yManb5puDH31YwaIBMBrAFf0
 I7wT0r3hEQVbJCo5mgC2xwOQtqHHTaIVEbVtrGR+Q4NDzi52Wyav0irec47tw+2WPUDM
 L2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458135; x=1688050135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mRotw+iSAUVrUeFod2O6JDCzdceQwIv5HTL8rc+bKk=;
 b=RPE+Z2Zod0jL5mUdqJIE4hUHYB8+RGbR3fvphTkfBrVkzwjaTObrAKX+8lp1c6A3MW
 QR4zTVFMLT+AumK5ICeErYHCTYOhk+BCPiWQWiZQ5EJpQdcBIYFKoN9VvzW85psb3Ud9
 9OS8R8wzj1pBKfms3aYYKPqrGgDYPyxbmCWY5dQVClrqZRICGnsdlLy+4zuxDeYpMfIS
 sNe2X1qcf8PnVJjWs1HHLJaiUBMCSvBf5Iyre9hTgMV+0kt5/6Tk1L5IyDBGv8dJyTLf
 c9ACxOxyy3Kjei+f+V308kpspDYZXwUpKbEXKPtCqN4xuBiaXoNbNC3i1Fc5uCqBUmbi
 2nOA==
X-Gm-Message-State: AC+VfDyZAFbVJ+a7zfjxK77MQtEe8EFemjYDuQ5vqwW+FrAtrQBsPQO+
 WNUrhc5t0HFa4JQu/nZPWcs2LA==
X-Google-Smtp-Source: ACHHUZ6UFYshVBEpFlDiULXPoDQFGHGHQRNLicj152ZIxlhVGC/4BntXzMpwTvN0CjjJ0WLKZszvcg==
X-Received: by 2002:a17:902:d4c3:b0:1ae:35ba:8c8f with SMTP id
 o3-20020a170902d4c300b001ae35ba8c8fmr3007356plg.13.1685458135474; 
 Tue, 30 May 2023 07:48:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001b03b7f8adfsm4983013plb.246.2023.05.30.07.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:48:55 -0700 (PDT)
Message-ID: <d753128d-d334-e701-a7a2-33c50048e4fb@linaro.org>
Date: Tue, 30 May 2023 07:48:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230530135204.2903761-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530135204.2903761-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 06:52, Ard Biesheuvel wrote:
> ARM intrinsics for AES deviate from the x86 ones in the way they cover
> the different stages of each round, and so mapping one to the other is
> not entirely straight-forward. However, with a bit of care, we can still
> use the x86 ones to emulate the ARM ones, which makes them constant time
> (which is an important property in crypto) and substantially more
> efficient.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Suggestions welcome on how to make this more generic across targets and
> compilers etc.
> 
>   target/arm/tcg/crypto_helper.c | 43 ++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
> index d28690321f..961112b6bd 100644
> --- a/target/arm/tcg/crypto_helper.c
> +++ b/target/arm/tcg/crypto_helper.c
> @@ -18,10 +18,32 @@
>   #include "crypto/sm4.h"
>   #include "vec_internal.h"
>   
> +#ifdef __x86_64
> +#pragma GCC target ("aes")

This doesn't work with clang.

What does work is __attribute__((__target__("aes"))), which requires that you pull those 
little code blocks out to separate functions to be annotated.  I believe they'll be 
inlined afterward, but not really relevant for your improvement.


> +#include <cpuid.h>
> +#include <wmmintrin.h>
> +
> +static bool have_aes(void)
> +{
> +    static int cpuid_have_aes = -1;
> +
> +    if (cpuid_have_aes == -1) {
> +        unsigned int eax, ebx, ecx, edx;
> +        int ret = __get_cpuid(0x1, &eax, &ebx, &ecx, &edx);
> +
> +        cpuid_have_aes = ret && (ecx & bit_AES);
> +    }
> +    return cpuid_have_aes > 0;
> +}
> +#endif

See "host/include/i386/host/cpuinfo.h" and "util/cpuinfo-i386.c".

I'll have a closer look at the other AES uses to see what might be sharable.


r~

