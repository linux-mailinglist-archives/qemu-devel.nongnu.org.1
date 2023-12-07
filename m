Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F08808903
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 14:20:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBEHj-0000m5-GZ; Thu, 07 Dec 2023 08:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEHh-0000lV-84
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:19:21 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEHe-000821-S2
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:19:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c0fc1cf3dso9838205e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 05:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701955155; x=1702559955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPWOtTbC9oR51+1Yhc537X/W8/M6ju4cczQ+/UnMd8Y=;
 b=YoQYYlVbO/MOqetLVVXqR2o/Bbbzbpmxxql7q4FmVpmHDmoz01RLHGJhrefTQHHNQg
 kj4qMb/UsUFGSTB19fgFQ4Mgw1DBGJDq8XvQKf78amkrkny5OOIX4vXqpPDlQ2q0od41
 zjRgyxZZ5pYvvQKFzVev8PFuvjVOkQxatHJB9Zi2uxuOuqgift4y8qnGx0RZhWlpmY1w
 kr9RphKofboKTh604bR8E7/Cyb/HSAlKhiZXORd6BIzbLi99LZoub3KB5ryghf/dYmqn
 yHmSlkbBjX8I4t9zgblV4diqvbCb6rXboIoGuMrRRmhqDweA7ehRsnxvs6tlbu3cF2va
 shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701955155; x=1702559955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPWOtTbC9oR51+1Yhc537X/W8/M6ju4cczQ+/UnMd8Y=;
 b=GySaQw/GEhQU6YRQluxDpEoXzMGfnkBih5ztOp0h6EpiDf1iKecHhn/NsrH4t10UQ7
 1QBSK2+EYMe/kW72ycABEvSFFB+FL3Pitd1nR0g+B6zGfojQ+/4U1B7nyW5DtssITZAn
 X+9igZVlLJNBQDKZCkde7SwfYPnV+dDE2k8Q857E5xLBMMPNQp6vSy9UU8vWtM6jAXYV
 zZfiVI8lhTKE35TzWZ3NQEsPEpy2bBQMatRBYDFEkdKFAinGD53wOlmbNOG5XRjCVxju
 Dpgtg+pTrOvLW91ikBZ2uZEYQZO0C2qpcVDMagVhZ3XM0BFjZG71Yf08EOukPjlBOLxO
 ZN8w==
X-Gm-Message-State: AOJu0YyE5Feoun4SPaG3GAEB29kvXzAMq+f798ddYPslyDCHwrPixaVj
 aAkTi9W+ufu1/la3gaZ5rlAkbL96sFJ1cP2zL4Y=
X-Google-Smtp-Source: AGHT+IETB77zY+uSLrw9b5xtAFdOKYpJftEi6n3hLfqb5dgnVGKMkVDoC896DeEnDidNGFv0vs0wlw==
X-Received: by 2002:a05:600c:3647:b0:40b:5e21:d35b with SMTP id
 y7-20020a05600c364700b0040b5e21d35bmr1684216wmq.100.1701955155314; 
 Thu, 07 Dec 2023 05:19:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b0040b4b66110csm1891309wmo.22.2023.12.07.05.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 05:19:14 -0800 (PST)
Message-ID: <461b2494-cc2e-4d0e-bcc0-8dcf93389eb4@linaro.org>
Date: Thu, 7 Dec 2023 14:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict ARM_FEATURE_PMU to system emulation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20231207111048.50568-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231207111048.50568-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/12/23 12:10, Philippe Mathieu-Daudé wrote:
> ARM Performance Monitor Unit is not reachable from user
> emulation, restrict it to system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 51f57fd5b4..60cf747fd6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1410,6 +1410,7 @@ static Property arm_cpu_pmsav7_dregion_property =
>                                              pmsav7_dregion,
>                                              qdev_prop_uint32, uint32_t);
>   
> +#ifndef CONFIG_USER_ONLY
>   static bool arm_get_pmu(Object *obj, Error **errp)
>   {
>       ARMCPU *cpu = ARM_CPU(obj);
> @@ -1432,6 +1433,7 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>       }
>       cpu->has_pmu = value;
>   }
> +#endif
>   
>   unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>   {
> @@ -1592,12 +1594,12 @@ void arm_cpu_post_init(Object *obj)
>       if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
>           qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
>       }
> -#endif
>   
>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>           cpu->has_pmu = true;
>           object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>       }
> +#endif

I think this patch is incomplete: should the PMU registers in
v7_cp_reginfo[] be restricted to TCG?

