Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40072A34D
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7i1q-0003ME-C7; Fri, 09 Jun 2023 15:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i1o-0003LF-5t
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:44:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i1m-0008CS-La
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:44:07 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-650bacd6250so1863398b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686339845; x=1688931845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EoI9BhDicHhnuKCaqYyalWf8y14CjENevoYSLpAcyTk=;
 b=BuS7WUf1r6sUtom/AybGycqLyX/Uxbmgo3u2FSHsVh7BvFwx2yAAVR3J+D2agiBvi2
 Pxun6mRjTvsBBCLe/DingR/xJxfvXqhL1DzVa5Cq+tE33HTg+6xmENbn7mfOphbOH7Tf
 0JPAoz7uRZmLlE0DO6seneNwxOKUVOmBo0ziyQDOXQTAawT9CJQAbg3K+ABX3wB0hLY9
 /40pyz2yEV8yjoVd1KIjnaW+h7SN8sI8yiAaCwvA+rjfoCibbCFxD0PmhEIugMdsedd2
 pWy+QfKddW8H8JQ2+1yocj8KOK3s7gHeL4Y0xDuUuLCVw1Quq8AIfKsn3SeA1mreW+xU
 /X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686339845; x=1688931845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EoI9BhDicHhnuKCaqYyalWf8y14CjENevoYSLpAcyTk=;
 b=Mn5ZsxHj5s7EOdwUsh69mvY3oG1i0emEYRnheQX1A3UygNZ/mssAialUX943tLN42Z
 x0Q01ZPSagEeiS7gAh2YOMHjvvkGnbZHcHCKRGha3uaW18DUVDRBG6NjDMRId5RV+yP/
 ytPBeqCcODGiAnye6cIQgTATl3UnQK7G8bXlrezt1iHQjYhJ1g0guuCF/m1Ta4Yb2ZJd
 O3wrM8BH/0F1Zqibfa3N6GspWoy9nIOjugjgB5bzklHff2zyLqKLsLep3ZGcwzXrcHtj
 LHgIRDDUToQ9bSb1kPrmlRZUCPs7YS+DaDQX19ftioP+9sNs/VCF4Hi1GgawPAZ6NOKG
 xU0w==
X-Gm-Message-State: AC+VfDy7CEJQOMaoGIr4RMxoEUDuii3bmmmy5uZ+L6Jvi5Ys7o6kuplj
 lEi1DEFekpllIcZj5oDeBglQig==
X-Google-Smtp-Source: ACHHUZ7nbB+cDZ/s0L4qtbX9xnVNbNRq+0mYGIvs6HhNmF9vxOmjH5NgVna+lK8FpC1hd8CKqUe7TA==
X-Received: by 2002:a05:6a00:9a4:b0:640:defd:a6d5 with SMTP id
 u36-20020a056a0009a400b00640defda6d5mr2093227pfg.12.1686339845203; 
 Fri, 09 Jun 2023 12:44:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 k7-20020aa792c7000000b0064d57ecaa1dsm3017284pfa.28.2023.06.09.12.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:44:04 -0700 (PDT)
Message-ID: <a923dd0b-e380-e3b3-22c2-bc9c871dce1f@linaro.org>
Date: Fri, 9 Jun 2023 12:44:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 14/22] target/arm/tcg: Reduce 'helper-neon.h.inc' inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> Instead of including helper-neon.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 -
>   target/arm/tcg/neon_helper.c    | 6 +++++-
>   target/arm/tcg/translate-a64.c  | 5 +++++
>   target/arm/tcg/translate-neon.c | 6 ++++++
>   target/arm/tcg/translate-sme.c  | 5 +++++
>   target/arm/tcg/translate.c      | 5 +++++
>   target/arm/tcg/vec_helper.c     | 5 +++++
>   7 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 2cf25f0605..82c34df538 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -608,5 +608,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>   #include "tcg/helper-sme.h.inc"
>   #endif
>   
> -#include "tcg/helper-neon.h.inc"
>   #include "tcg/helper-mve.h.inc"
> diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
> index 0a4ab3e42c..3346a897ad 100644
> --- a/target/arm/tcg/neon_helper.c
> +++ b/target/arm/tcg/neon_helper.c
> @@ -9,10 +9,14 @@
>   #include "qemu/osdep.h"
>   
>   #include "cpu.h"
> -#include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   #include "vec_internal.h"
>   
> +#define HELPER_H "tcg/helper-neon.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H
> +

Again, none of the *_helper.c need helper-gen.h.inc, only prototypes.


r~

