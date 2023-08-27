Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A06789B6F
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 07:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7yv-00013H-RM; Sun, 27 Aug 2023 01:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7yn-000132-IT
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:06:30 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7yl-0007uT-9F
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 01:06:29 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1bbb4bde76dso1475310fac.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112785; x=1693717585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YICHZqWjKte46YfHguI2q7GJiXFE8vZKBmfhRNr5xpk=;
 b=uG9csBDd9Uvs3o2cpwtO83NJmCnl4cpFE6ZCZa6mcRrbQJemy0RIETSKnarNf+ZLJR
 ChvjvN9bMkR5JglqUIzN7s2arq3dXoAFDqo3ojTnrtENJn2rP0NuV27dq2ZA29MBAJ2M
 dRrKfoBB0JxnK+z71Uyt3PYiiF0KI5UsYCuLbQ6TgzhNFGZSYvnC6a7Igql5/03TS6JW
 OZO4MHtA5iixsyB1Sgj9fDgoKKFuTR9JqSWToWUp3LJpWLpY9QgbDSWyFtCIWRIj6hnw
 KFVQVuF5xP3/wyC+GikXOYzvkxCO0P1gxFj8fXoyphXHMB+uMqg97v5qrzLCT7F+DabJ
 pcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112785; x=1693717585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YICHZqWjKte46YfHguI2q7GJiXFE8vZKBmfhRNr5xpk=;
 b=hfBddTzRc0aHoFo5O26K6C026IV9pZkuJf6fUhnO22/sAjpgbIbwKOnuCYb+wSdtrX
 1/gUwB5E2+wNiksX1J0IR7mJQliPWiHA+bCkRhXnqexD2tglPLGrCoueeDLO2EboJHYJ
 dlb8gEK57io646TpI/Y6gV3QuW35LBEYF7Q5MQ0FkXwCoe11lmdW+/IK24bMTkCMOqPD
 tRbN8j80Dgtvw80vXel73e0SwovP3I9bWHD+j7vXXWbgODroRSCvaYG74I6GWhD7b2wq
 7cj2xQ14QK326d3w8dbROxpCsRIxpDWRF7sd7V8lIsCsKWzTGx7duewi4l1vpRU67/lA
 Y3pw==
X-Gm-Message-State: AOJu0YxpxRebwV3wytd9iDocMbKa3Of1ZP/nWF4zilPqwDVqf/EAI0/A
 dg6gy5/YjiqoROdCgs8DdRNgSQ==
X-Google-Smtp-Source: AGHT+IETZzU8bbNnx3WFFizgR0qH5L50EGYSvvou9EsfmUv1BqTMZ0zb3VSahIg//AFB9WD73gVkfQ==
X-Received: by 2002:a05:6871:b0b:b0:1b0:3d61:553e with SMTP id
 fq11-20020a0568710b0b00b001b03d61553emr8406529oab.15.1693112784990; 
 Sat, 26 Aug 2023 22:06:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090ae00400b00262d079720bsm6166874pjy.29.2023.08.26.22.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 22:06:24 -0700 (PDT)
Message-ID: <6a02b146-2b2e-8be1-e032-16671ef93a90@linaro.org>
Date: Sat, 26 Aug 2023 22:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/10] target/tricore: Swap src and dst reg for RCRR_INSERT
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-9-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c          | 8 ++++----
>   tests/tcg/tricore/asm/macros.h      | 9 +++++++++
>   tests/tcg/tricore/asm/test_insert.S | 5 +++++
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index d13f85c03a..a68660b326 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -8225,12 +8225,12 @@ static void decode_32Bit_opc(DisasContext *ctx)
>           temp2 = tcg_temp_new(); /* width*/
>           temp3 = tcg_temp_new(); /* pos */
>   
> -        CHECK_REG_PAIR(r3);
> +        CHECK_REG_PAIR(r2);

While it looks as if the end result is the same, it appears the macros used just above are 
wrong.  The field definitions for RCRR on page 1-4 do not match the field definitions for 
INSERT.RCRR on page 3-118.


r~

