Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03272A2C8
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hPu-0002dm-39; Fri, 09 Jun 2023 15:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hPp-0002cy-Vj
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:04:55 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hPm-0006mc-RF
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:04:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-650c89c7e4fso2212120b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686337489; x=1688929489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+C8+d0S2bw00YZMFNjh1AFwTSdqeQQ3MkDo/fZGPraw=;
 b=Y/YL2PmZrytoNAe6ol0hXfZA0L/+J2jaszdpgBdJUWadlXlUyE2PKI+hJhNQGVgeMk
 xC5hA/EySjTKgBW2cPvBEg9hLcne9wMvuUx49uiSRNLSrS1abCVW2WjV43PIgc5U+0xQ
 VyGQdWAw/bk3ccyQFIkJZN37Kc+cOH/MTfT3qS8E69cMn8ahAPPdJA4FtRnjGtKGbQSo
 5mwX4VDr79JPO6LxjK7lIf2lDIX8xCckr5pSaXAlP4uJeEdByVwnwkAqkiQb0jLan0Jm
 kE60e0+bDXo63a24qDtNtmMh8kTaibq8aT1vtLDm5y5DGqn5QKBJFQRLgtQZTxiqWOqF
 wRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686337489; x=1688929489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+C8+d0S2bw00YZMFNjh1AFwTSdqeQQ3MkDo/fZGPraw=;
 b=CNU1wZ+krESp+Fllw/sMIHFMFuVWaY8IDC3BqkJvNUipqsyUx4lT2uPip6isGf6hKy
 fJe8PA5gB5zZ9kunAUEMPDVeEl84LeTa7GLlhy72z13j0sZwDaiZpv05QaFoATM775JH
 nMpUC1WnU0unZeovgWoaBddC3bzlLD02PSFTrV96ljOBYmBffqAse+8lVf4XExq7Q1Yr
 e4vDFXS0z4xU+iS4XzIkIyb+3IBxmO0Uau00teKX2dzK7My5/UkUvvzwDdiLP93lP7om
 /pSGSj19lp+ditR1xDrrEjbnFEvWvjX4vFzG4bRaG73ji7umdluj9OHZHMjDMV7Bdg8R
 u2Xw==
X-Gm-Message-State: AC+VfDwrZF8hBB6YmKDx77/+hCnJlXnxMJKBQX0alHFO2yVnkq6ZExB/
 8dfOpOFpbBk0B4qXx2UV7lUbO9/jY4fBsPI0O/Y=
X-Google-Smtp-Source: ACHHUZ6zIh/BzafpbFIpAMpPtjWSzw6thhgbnj/UYJwqVvAb6tHVWT4k4/IpwHckBWfK3gT1N3UFcw==
X-Received: by 2002:a05:6a00:2d0b:b0:64f:5406:d59e with SMTP id
 fa11-20020a056a002d0b00b0064f5406d59emr2840562pfb.17.1686337489346; 
 Fri, 09 Jun 2023 12:04:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 v65-20020a632f44000000b00543e9e17207sm3247680pgv.30.2023.06.09.12.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:04:48 -0700 (PDT)
Message-ID: <0e66e8cd-7ad4-106b-ae79-9606d5b5fc4d@linaro.org>
Date: Fri, 9 Jun 2023 12:04:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 11/22] target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
> Instead of including helper-vfp.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 -
>   target/arm/tcg/mve_helper.c     | 5 +++++
>   target/arm/tcg/sve_helper.c     | 4 ++++
>   target/arm/tcg/translate-a64.c  | 5 +++++
>   target/arm/tcg/translate-neon.c | 5 +++++
>   target/arm/tcg/translate-vfp.c  | 6 ++++++
>   target/arm/tcg/vec_helper.c     | 5 +++++
>   target/arm/vfp_helper.c         | 5 +++++
>   8 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 9d85675d17..4d1b7ec6b4 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -813,5 +813,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>   #include "tcg/helper-sme.h.inc"
>   #endif
>   
> -#include "tcg/helper-vfp.h.inc"
>   #include "tcg/helper-mve.h.inc"
> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index 403b345ea3..9914f45b16 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -27,6 +27,11 @@
>   #include "tcg/tcg.h"
>   #include "fpu/softfloat.h"
>   
> +#define HELPER_H "tcg/helper-vfp.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H
> +

Again, none of the *_helper.c need helper-gen.h.inc, only prototypes.


r~

