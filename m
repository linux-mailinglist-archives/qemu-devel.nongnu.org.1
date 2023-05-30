Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25811716335
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q401X-0002k1-4r; Tue, 30 May 2023 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q401V-0002jd-Gs
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:08:29 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q401T-0005i2-SR
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:08:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30aebe2602fso1525037f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455706; x=1688047706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6HkpIykue4z315sGe067YeidNKQP5gS5byB5c6QgE4=;
 b=i3h6CEhiSWh+Cp0xHlohdJyQeaiKFVgeYsputGtLjNRg1xH2HD9MFvJuuSZlo1VCK6
 DYj0ALLc9XHLOv0lHQ95xWJ4U63jvo2z/1+AuLMiQgSzsHdDfkJpWWpffJfhJchZT5bN
 GZH9twe7sLIRF2AorqfIDi6CoQuWFWAwxq7K5jJLmbS0mbHf49Xjgod8/jlTGI9eSHnA
 XIE15V6O+IYrtPTpTXyqOhNS+gDmq26YXG+uUxqHKJM4yYNuTgsyLJIhkNYsT3g79FPQ
 mH6T2bPKle9sMTtOm3f8/6/dwfEwUSd9cZZOI7Iezcy4Wb3MleZ+BaFSu0+jSO5uQ9YQ
 CNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455706; x=1688047706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6HkpIykue4z315sGe067YeidNKQP5gS5byB5c6QgE4=;
 b=NRaN1Y2gx9xCxP/HiiHtD+Z8tHtiK5qVgBp9/QZ6nuJODSzWdEkpXVheY8z0WTlTxx
 iDatEgxHby2NQRgj4taDLhU5dVDkNbO607tcR3clW6Fn3fKN4dnVw+nKdYDiwuSktKNb
 BTIynnqfK7a5P6Zf+vjp+/o1j7p/Ak4DdIaGRdAglXAbCxWi5wCEvdYg8VNN15Iv5Kj+
 elZxAugyPMnCGo8AbuhK5JKV9ikSszCZlgXUyCbrd+H1QvZTdtDAjcfPTRJ2uKLBPHqa
 d/9Q5+HC1IMHog6ZBt7b3eZPbHm+jwETiOgNFslbuu9JGAA7B1yzej6bguJjXoIMKPxu
 aymw==
X-Gm-Message-State: AC+VfDwV6rgvHrPaGVZ3kRrDov5B6Z6ea+MBt7AedoGhdbLz7udavFuq
 +nreI8bww/a09xb/nEa4z3TIIw==
X-Google-Smtp-Source: ACHHUZ5LLDC8WZcnZA7W6MZ9AM25TzwXhXTeEBs3wK1bCB6wtveW6gd9AmUHS8nyMSh0j1A4zSutsg==
X-Received: by 2002:a05:6000:136f:b0:309:4e85:897e with SMTP id
 q15-20020a056000136f00b003094e85897emr1598771wrz.17.1685455706324; 
 Tue, 30 May 2023 07:08:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0ac300b003f50e88ffc1sm21328712wmr.0.2023.05.30.07.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:08:25 -0700 (PDT)
Message-ID: <61d22bb4-96de-c49f-525d-a236cacf564d@linaro.org>
Date: Tue, 30 May 2023 16:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230530135204.2903761-1-ardb@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530135204.2903761-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Ard,

On 30/5/23 15:52, Ard Biesheuvel wrote:
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

Per the recent cpuinfo API added in commit 6bc12fd042, I suppose
we should add CPUINFO_AES to host/include/i386/host/cpuinfo.h.

