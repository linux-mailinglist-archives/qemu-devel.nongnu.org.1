Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E9829389
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:03:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNRep-0001WT-4r; Wed, 10 Jan 2024 01:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNRen-0001Vi-Ih
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:01:41 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNRem-0006ZE-3E
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 01:01:41 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbb4806f67so3202472b6e.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 22:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704866499; x=1705471299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yUr0rz0CGQNbyRQhIZTuzB+wBwc8xG3a/ElYHjeU7h0=;
 b=txGUnBsai3hd5yG1dO7b8oXHxX9ImEDzWlMDWzggY82nUCXxp0AmYVFFTg1rrCIAl/
 Pq/0YMwL3ySA6mT0rI5oEGj3OADZud/WeKCTo6OWkA+RbP0gLdYYF+dKtZVPT7d5qTCb
 pbyFlcAZVuL8lok9g95LUGjwhxEqfel5SmYTq20ClvGTgTuvl/ucVMA6GO2TK/Gsv1pe
 iDDOufdRymYMa64rgZOb/elMUVE5dwnpzFNJXCzCjEJv5J2L+kfvSrd6Q589OEB3WKpO
 y8zuxXRBEQttHVjDRIBKPrpVac1sjOid1zxSexEHvV5a69ecYLgQhn2RaVPdpQQ+q1lb
 sYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704866499; x=1705471299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yUr0rz0CGQNbyRQhIZTuzB+wBwc8xG3a/ElYHjeU7h0=;
 b=MOuaHC5MfTkOZmkl7UD+DsqCTihNnb4d9dVZBe4/2QcClsgmYEtBSI3fTnW6r6Ntgj
 9MJl4qiX1LaN893Jhx26X0V6b1kTDXMCJSR9QhrasZS/XIQWckVgeNIl18BJMo6oyLct
 14aIxgrP2ukCq9yyJq5F9IcGvfvsAFt5Kbg9R85ZvlkT61MNV7MFMA9UvC+ZfPTcK9rL
 PYteuEddPVewOL4APtDz8htambUT/EevvrNcdF5TT29Yb3lopX31hVYfX5U354myrDwb
 z+lr4qV5VDoWM2R320gK2fo4f+/i50T49O0vHoDuHmvKMQD8bV16SdnGc0MK9HFU5uWO
 s+AQ==
X-Gm-Message-State: AOJu0YzM2sJn5AV9uHnk7Ao6+ike1VaCYSwYoFq7YZb7/sDKG4ETzWyG
 0ZuI3RZy/tetGGlt+rhLrEiIgjjeqjti8w==
X-Google-Smtp-Source: AGHT+IEdazBoRIJyIXAHGRQEa7qvLWwDCTKT97SvHBfi+8LK9dvSjTDMiWqABDv5Dmyz7cFlZc63zQ==
X-Received: by 2002:a05:6808:11ca:b0:3bd:3e8b:8734 with SMTP id
 p10-20020a05680811ca00b003bd3e8b8734mr551518oiv.99.1704866498914; 
 Tue, 09 Jan 2024 22:01:38 -0800 (PST)
Received: from [192.168.40.227] (ip-38-9-1-25.internet.url.net.au. [38.9.1.25])
 by smtp.gmail.com with ESMTPSA id
 s9-20020aa78d49000000b006d9b2d86bcasm2648982pfe.46.2024.01.09.22.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 22:01:38 -0800 (PST)
Message-ID: <6c877f5e-e0f2-4ef1-920a-df850484c358@linaro.org>
Date: Wed, 10 Jan 2024 17:01:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] target/arm/cpu: Simplify checking A64_MTE bit in
 FEATURE_ID register
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
 <20240109180930.90793-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240109180930.90793-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/10/24 05:09, Philippe Mathieu-Daudé wrote:
> cpu_isar_feature(aa64_mte, cpu) is testing a AArch64-only ID
> register. The ARM_FEATURE_AARCH64 check is redundant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1c8b787482..c828b333c9 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1690,8 +1690,7 @@ void arm_cpu_post_init(Object *obj)
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
> -        cpu_isar_feature(aa64_mte, cpu)) {
> +    if (cpu_isar_feature(aa64_mte, cpu)) {
>           object_property_add_link(obj, "tag-memory",
>                                    TYPE_MEMORY_REGION,
>                                    (Object **)&cpu->tag_memory,

It is not redundant.

If !AARCH64, then the isar registers tested by aa64_mte are invalid.


r~

