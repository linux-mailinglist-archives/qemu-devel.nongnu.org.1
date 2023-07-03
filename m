Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09D7456A5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEUH-0005Mi-5Y; Mon, 03 Jul 2023 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGEUA-0005KE-19
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:00:38 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGEU8-0001zx-GR
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:00:37 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99342a599e9so178030766b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688371235; x=1690963235;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V9ye7gpqLM3ngP9yY/dxY8j0x9Y1ATCGezSuocEZb2k=;
 b=DZSGAy/OGIvfvg/JHlQHnGaFJnHScwOU+LiFg9aeCXlBVg2OZqwPJfwATUlXbNHbXG
 RQMtF/XWXp8LAtIEnrbbp8/oGzfYf1FIMlmmk4t2HqNUZMPoApKYYRkV13qjFYWB/N9F
 SY+IgX9D8tLoMaxAFTAjBbmgy0XcOYE0UyezUqFk46bRFd4YQw+OWj+dw268iHlQn4kC
 BLbYgn2kpgCx6cAhSq9Yq7jy/2eRFRXjuSg9NPLfoOjcz5ydiOv+8pUfhJfPNaB+W6yG
 3fvcxsvdgTBc7RUNmg8NyW/MMNuuzjvuejttl3ep7ky77Y7sFl9DIFPwK3ahRokpdxa3
 NybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688371235; x=1690963235;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V9ye7gpqLM3ngP9yY/dxY8j0x9Y1ATCGezSuocEZb2k=;
 b=Y037c2PxMxcVHhZq+RJizwhf2eW5jVdjdrkVcxVhrjj7R7nFyatf8mu5X45f5nDzX6
 H/Isq/HOKRQWQQKVINO7M1+TkrYleYCmFDdPbkzn7k+tf1pP0ZLhi0DyP8eqUfw0ILk5
 Wx+9cUqcfUHwWOZdYhn8XhZp/2bVybaH1sgsFbR3sbUX5pwfnF3J5g+SUTjwMsKso+ck
 riRKoGAESo0AoYKivigavznTbbh7ozppk+v++X47C6IDW/ptcwK4orwhjW5xTa6bebun
 cXt1OzbWBgzQ24RpzTH33CC3ViI5uvV9YtM1UzlarKtUmdXtEIeTl22o8J00wLvgRTgP
 R5Bw==
X-Gm-Message-State: ABy/qLZLqfNamIclfsqjORazgb85TOFfwQRhNhIVnGYA22SQUaHX0I3O
 L++QvmPyCFFxlTvR+NpN5znaug==
X-Google-Smtp-Source: ACHHUZ6tUDZ/h13wHPDTuSqZjd5fRviqQt4R22cykFWCdIftPgur5JbaxBVXKtoXtL7tyMDaLfRndw==
X-Received: by 2002:a17:906:13d6:b0:974:c32c:b484 with SMTP id
 g22-20020a17090613d600b00974c32cb484mr7112760ejc.72.1688371234979; 
 Mon, 03 Jul 2023 01:00:34 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 a3-20020a17090682c300b00992025654c4sm8082795ejy.182.2023.07.03.01.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 01:00:34 -0700 (PDT)
Message-ID: <9ec360d2-533d-c36e-a4aa-285219e6a5e8@linaro.org>
Date: Mon, 3 Jul 2023 10:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 08/38] tests/qtests: clean-up and fix leak in
 generic_fuzz
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230630180423.558337-1-alex.bennee@linaro.org>
 <20230630180423.558337-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630180423.558337-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/30/23 20:03, Alex Bennée wrote:
> An update to the clang tooling detects more issues with the code
> including a memory leak from the g_string_new() allocation. Clean up
> the code to avoid the allocation and use ARRAY_SIZE while we are at
> it.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v3
>    - use g_strconcat instead
> ---
>   tests/qtest/fuzz/generic_fuzz.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

