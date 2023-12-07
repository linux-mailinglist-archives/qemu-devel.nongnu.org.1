Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3AB80952C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 23:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBMgJ-0001zs-7t; Thu, 07 Dec 2023 17:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBMgC-0001zL-Oi
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:17:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBMgA-0007Za-Lp
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:17:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d06d4d685aso11074875ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701987429; x=1702592229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuyGrVe+f9SH+ggAU2z1X+VGSWkd/t+C8TZntd0RzJ0=;
 b=oa54mjSfTZJujD0uOpWPWelPxuIaE8Cehz9p9Nh3Z6gf153QlwlZID6tu8IIZbSJ1T
 lPocHibKdcU2ubaT+r7P14TeKefl+uKoaLC7FvMDaJLKWBZF15ClwYE/a4zs4Egii9c3
 J58Maq025QuWMwyaL+gN8hWOy63fLxduzTr+CMRkeCpeFquib/W0vYbFefIDzd1Aqwg/
 WiYhCLhUq/6y3AsdR6ogsNbulsyNSYg2Z1IaCSLqaMXYzD40uQWZHdsjmFik/UxoNPOk
 HHAoKUsxgPMpPcH+ahes9pHus+nySiJ+ecR9sYWTQS7Eye6x41iIooerlhPQEEzLyZ2n
 glQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701987429; x=1702592229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuyGrVe+f9SH+ggAU2z1X+VGSWkd/t+C8TZntd0RzJ0=;
 b=gwVwy/JQuL73Mb6jONw3qZIXAkRIISjq3wwAbjayiiIw4DhpjUJd3hkmrF524nvclC
 IUSJwYkPc+FzAfp38ZFtQCKFyVbd7Zorh+MciK2li+iYRnDMm9cmFydSZ2q3SZJcAIq5
 BWqsJuuadKzJ9W3s2CetuHQ18ILX/wgb2XuGEJz7vZJONy48RwgdBbXiWqkpD1BtyPP+
 C6lJEXvivp+K/iVbuDa7YGDZLkw00uqvLihHIvNjkr42QRwQUOe6E8Ti4sTyiVaVT7xx
 RxgpPRqWBpNuQNkPK99sK6IvC0DE3EiByX6e1mob8AnZwx7a0CtL/kqwHiKNHKosYZs/
 ABng==
X-Gm-Message-State: AOJu0YzUq14HttPJV9qKeTXor9424C17lAlyO2zOq6XdUYoD1/nycY47
 G0DOp8MdtdjpEFsDClYhcINA4Q==
X-Google-Smtp-Source: AGHT+IGNAxWwWtPfY+OS1JS4Qf47rqwkT4Ae1OGtESLpOnYq+zA4rv80acjxuyvnNY8g35pP2VS+Dg==
X-Received: by 2002:a17:903:11ce:b0:1d0:ab30:5582 with SMTP id
 q14-20020a17090311ce00b001d0ab305582mr2841802plh.129.1701987428791; 
 Thu, 07 Dec 2023 14:17:08 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902ee4c00b001d0c134dc2dsm310721plo.77.2023.12.07.14.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 14:17:08 -0800 (PST)
Message-ID: <4a648903-ad7e-4713-be5f-e58f5174d1a0@linaro.org>
Date: Thu, 7 Dec 2023 14:17:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] util/async: Only call icount_notify_exit() if
 icount is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231207154550.65087-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/7/23 07:45, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   stubs/icount.c |  2 +-
>   util/async.c   | 16 +++++++++-------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/stubs/icount.c b/stubs/icount.c
> index f8e6a014b8..a5202e2dd9 100644
> --- a/stubs/icount.c
> +++ b/stubs/icount.c
> @@ -43,7 +43,7 @@ void icount_account_warp_timer(void)
>   {
>       abort();
>   }
> -
>   void icount_notify_exit(void)
>   {
> +    abort();
>   }
> diff --git a/util/async.c b/util/async.c
> index 8f90ddc304..9007642c27 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -94,13 +94,15 @@ static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
>       }
>   
>       aio_notify(ctx);
> -    /*
> -     * Workaround for record/replay.
> -     * vCPU execution should be suspended when new BH is set.
> -     * This is needed to avoid guest timeouts caused
> -     * by the long cycles of the execution.
> -     */
> -    icount_notify_exit();
> +    if (unlikely(icount_enabled())) {
> +        /*
> +         * Workaround for record/replay.
> +         * vCPU execution should be suspended when new BH is set.
> +         * This is needed to avoid guest timeouts caused
> +         * by the long cycles of the execution.
> +         */
> +        icount_notify_exit();
> +    }

If you're going to do this, remove the test in the non-stub icount_notify_exit.


r~

