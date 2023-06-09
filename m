Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48CF72A2B8
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hL1-0000Wg-JI; Fri, 09 Jun 2023 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hKz-0000WA-Lj
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:59:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hKy-0005Ql-2K
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:59:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-652d1d3e040so1717915b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686337190; x=1688929190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QI+tiuhPeVZrW0nLn35iWBDTOQ+amXGe6PjfU62NhSM=;
 b=xJqRRaO7WTzUJUSJURbu8L/gUZpN0lk7yCdhHbOfmkpjwXgQLkV39FMqcyleE/Kxqo
 eBe2rHHZXmauRdy3R9YYcbmb1Jb9ezNqEHkVh6msJjKIt30LMX10n/OjY8MaADybHfTB
 Kb3yb4qv8LnCP5IN/nqpMKyLeDVn8/ibKJmX2065ZD5Fg4kyiAVtmQbnMJfyozpWFjbR
 x4uFFa6F4TALOuFl5Mnd1vr7rzH6YqYfMOJx1E1LToc8y4OcsX9k1iev8L+WOBf6FoKH
 MBh11+4j49C8Tju4AQXejHv+jWW5XIaqxt3fszAvBZEF0PfIHWdhViM5Sg+DK92EOxTE
 aXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686337190; x=1688929190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QI+tiuhPeVZrW0nLn35iWBDTOQ+amXGe6PjfU62NhSM=;
 b=bmskTrYulPZodIMg5np2FxmkMyEBRr1mgEqyfuy+M4UgyAN1RyyEvBYMcfS/ZeGjJr
 fXNjZcfgt/DU740aVzZrW/h4+ziElKUFP1+PCpkqBFervONhsjzZ9Sb/r0yzJG8pnlyD
 wcmPD7scCD3zC9i8tug/9FGkgnh1d/VlFvZaCF3cuIhgVhz6Px8J33vINdyQn50WAag/
 ypGv0CADotPdhlqH1UaxF4nr1YdE7+azBs02zUihq9dVAFEgTd4wmbwf1HtyRHQwpNWR
 EruZh6eAaJktkqXP/uV7x2Rj/DHLuPnAg6iEHfys3qCdm18Fs1SCRAsh1oh3HFjaaJ90
 kKyg==
X-Gm-Message-State: AC+VfDxA8oVuq5LL8tcRSpYivKOkgnCpaJOXHgoBJQoW7jPUhBKVHWDf
 XT3GPIpOwQFan7W9ozGXFN5IOw==
X-Google-Smtp-Source: ACHHUZ6GMWQrQLugV17ux/jx56ciUsgaNAHmmBSjmAvZ1ScbWXKUa6yiULj7ltuQk/ukoTZ9SditkA==
X-Received: by 2002:a05:6a20:a10b:b0:116:fc1b:fa3b with SMTP id
 q11-20020a056a20a10b00b00116fc1bfa3bmr2087107pzk.9.1686337190608; 
 Fri, 09 Jun 2023 11:59:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b0064ff643f954sm2967345pfn.88.2023.06.09.11.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:59:50 -0700 (PDT)
Message-ID: <5624531a-48ca-9d78-1046-108b8e4df603@linaro.org>
Date: Fri, 9 Jun 2023 11:59:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/22] target/arm/tcg: Reduce 'helper-iwmmxt.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
> Instead of including helper-iwmmxt.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/helper.h               | 1 -
>   target/arm/tcg/iwmmxt_helper.c    | 6 +++++-
>   target/arm/tcg/translate-iwmmxt.c | 6 ++++++
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index c4a321c0ea..dd12fee107 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -949,5 +949,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>   #include "tcg/helper-sme.h.inc"
>   #endif
>   
> -#include "tcg/helper-iwmmxt.h.inc"
>   #include "tcg/helper-mve.h.inc"
> diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
> index 610b1b2103..fa84b5f672 100644
> --- a/target/arm/tcg/iwmmxt_helper.c
> +++ b/target/arm/tcg/iwmmxt_helper.c
> @@ -22,7 +22,11 @@
>   #include "qemu/osdep.h"
>   
>   #include "cpu.h"
> -#include "exec/helper-proto.h"
> +
> +#define HELPER_H "tcg/helper-iwmmxt.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H

You should only require helper-proto.h.inc here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This was exactly the sort of thing that I had in mind.


r~

