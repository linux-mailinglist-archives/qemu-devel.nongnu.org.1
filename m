Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230274882D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4ZZ-0006Dw-Qv; Wed, 05 Jul 2023 11:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4ZX-0006Cz-9N
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:37:39 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4ZV-00088L-Ot
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:37:39 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b6f943383eso31452201fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571456; x=1691163456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGHy7FMXXJn566nQ8DVkTBJYquiPZWI8dwZTvVmhlPU=;
 b=FxTnvDk2Z3BpKOID6/Elwz/ubFbAo7VOcGolU9q4Lb5SEZ4ctVy6xCQ6oDS2LiUVom
 cfX1ywDZ1IIeZYLp7x26wKjWxlfI95i/W41ZKBjslWjaZOlF5+6nMdE+bivqpQJm9f1M
 JWsJ09iTtvN47LMZmdwa8R9rY44vk075J8zs1VDR3+Jq5qaf+0RvqNVg2grPCTX1Zgog
 3jdj/r0BTLJrLiju4If0l7BuCbUfsVyP8YymtSc6T6OWT7guOFodSBOpAfEzU9VvVNM6
 p7RmRVdB/GnUiu07hBCiForiJzGniY/we4OnndGFgRtyUu+d3VvouSC90yeOvWzNYSOg
 4wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571456; x=1691163456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGHy7FMXXJn566nQ8DVkTBJYquiPZWI8dwZTvVmhlPU=;
 b=HnQlsDUSsoTRcCxv33kXOcRqaEReZ97r8qz3X5bUi84h7UsCLMkZLLkkPBzWOsMjzZ
 kfqP37tVfo5lj6HgqEHdndd4+KYspQAS1LMDrz6hqDck0UBsZHzex+5Bq6rhGj+etNqj
 sjppNM/Ucpx74hGL1m4diF2TO4A1uLjkSgGAJVwst2qE/IMijGk0ArkorsY0Gn3JB5IZ
 JKcUUGjTSPMPcI1VxOG3BrjLlfqSDF96+p3hOJFiswF2+NSZkWVrY+qpymoLTsBV/RXG
 Zncy1gh5UbMNMWarm8BEVdWbELDWEU5KOfXdcPD6agXCiNwHKhXXlC6WWfr4Vsxs9lOH
 m7jw==
X-Gm-Message-State: ABy/qLapRwDlDQeBp8H8bMay06oXANmpH8pcrmJXk0GPtfMHl3fuucnY
 3JqTIGzgqaMriLT4mhoStsoLrQ==
X-Google-Smtp-Source: APBJJlGvbu/89Spcgiqqm2nmwhQBXeq8OmdJnsdWzgflPGrf9aeclkv4ongxF4MRWoh84Laj9O+ZVQ==
X-Received: by 2002:a2e:9d45:0:b0:2b6:c394:91dd with SMTP id
 y5-20020a2e9d45000000b002b6c39491ddmr10585556ljj.10.1688571455909; 
 Wed, 05 Jul 2023 08:37:35 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a2eb164000000b002b6d5395732sm3403585ljm.1.2023.07.05.08.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:37:35 -0700 (PDT)
Message-ID: <d7d27404-fd00-e3eb-77b5-75735b590496@linaro.org>
Date: Wed, 5 Jul 2023 17:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/19] hw/timer/arm_timer: Iterate on timers using
 for() loop statement
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> The same pattern is used for each timer, 2 or 3 times. To avoid
> too much code churn in the next commits, iterate on the number
> of timers using a for() loop statement.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

