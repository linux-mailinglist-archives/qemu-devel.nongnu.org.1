Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1A73697B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYl8-0003Wa-3I; Tue, 20 Jun 2023 06:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYl6-0003WJ-Ed
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:38:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYl4-0004Ey-Ud
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:38:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-988a076a7d3so327491466b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257525; x=1689849525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mTFreq68Pm/7uDYcBwKfnJwgB74XQlqT9nPRxFB/EbI=;
 b=Fcnb06VoFOHBlCLMLFFNP2lp5sBvUlcp0KXUYGbp73a+QUcyinXudtJafv5LHy7n3X
 5KOJ3qdLH0O+zsxsucSVT1u1pHVuVyx7/ShwTBYH3S+Z1w5RH1oFF94+Kexop92qmU22
 /suc9CqRIAAtYoElwpUbGv9bxoAP75H6Nzk+DU3peJHrzVhV229M18j+dbasCD5Ygvqt
 X+sqmCR/4yFL0OSabr9809LAAQ/xxPtg+zBW/oXfoPUTza9xfPY4TVAyRGjToQlxCPUX
 PCFaHBxTfSDrRQSbAzs1mfsLsMeza7ymXGXAPJ9DWoFMZqcBEPWTN38umFQZ/2lD2cVr
 wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257525; x=1689849525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mTFreq68Pm/7uDYcBwKfnJwgB74XQlqT9nPRxFB/EbI=;
 b=AYEY/ULnKeEQJfbBgnSNFTZq7ompGNP04nUY78WRifsniuNnHeAoUppOelTn59HNlk
 9Ho2rTcB9rn27RzddQDWYxcu46edkDqFRR19oiC6Isqsfb53o/y+jp5ZyVuc5eMhuhOD
 OCAJ6ifKmduZqVmh/cu+qvtwgAnIwumja1ZUpLNrFS2z5C9m/aHIRVZJlD3pwzrMfr7I
 s1+tUAjjalFuS2v3fL9bPYS0qMoAJdssxeWYhx/zcriYvvrbkBpQqV8XpEQU1cKGy2du
 gwtfTP0JYQTnabg/U4+higEyqhMxdzW1eS0tOmODH4Up4LzA2ZvmkUnJ5/it0sG/Az/Z
 fZaw==
X-Gm-Message-State: AC+VfDwCIMA5e2roaPo9G4ejvxpWCstEKCA9MTZhY6sAmX0gdZaAnDl8
 KJCbrAqbbQoU0P6cDOZdFwMt11rQrXBGR+GQuIVsCycj
X-Google-Smtp-Source: ACHHUZ56vKO78MJJ8NMNL/P8FMdurF5urV4ki0vnR6vgIxzeyPTrwAJVQ//gUBAk54uQegBhqFIFmA==
X-Received: by 2002:a17:907:2d28:b0:96a:3e39:f567 with SMTP id
 gs40-20020a1709072d2800b0096a3e39f567mr13712768ejc.47.1687257525352; 
 Tue, 20 Jun 2023 03:38:45 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a170906168800b0098884f86e41sm1117816ejd.123.2023.06.20.03.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:38:44 -0700 (PDT)
Message-ID: <02f54fc1-0ceb-d905-85b6-81892345778f@linaro.org>
Date: Tue, 20 Jun 2023 12:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 22/34] target/arm/tcg: Reduce 'helper-crypto.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> +++ b/target/arm/tcg/crypto_helper.c
> @@ -12,12 +12,17 @@
>   #include "qemu/osdep.h"
>   
>   #include "cpu.h"
> -#include "exec/helper-proto.h"
>   #include "tcg/tcg-gvec-desc.h"
>   #include "crypto/aes.h"
>   #include "crypto/sm4.h"
>   #include "vec_internal.h"
>   
> +#define HELPER_H "tcg/helper-crypto.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#include "exec/helper-info.c.inc"
> +#undef  HELPER_H
> +

foo_helper.c does not require helper-gen.h.inc.

Usually we put helper-info.c.inc into one of the translate*.c files; probably 
translate-neon.c in this case.


r~

