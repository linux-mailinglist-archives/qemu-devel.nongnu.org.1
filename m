Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3181F297
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:51:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcjS-00017s-K1; Wed, 27 Dec 2023 17:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcjR-00017i-HW
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:50:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcjP-0001VD-Uf
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:50:33 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cd5cdba609so4193823a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717430; x=1704322230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fEL79n9ZmuWhwsfPl6PWa+JiwghQnUA1nQdTsB2o+ao=;
 b=pGmeI+ZQhJeGRyIlIiXJFnW+FaUp9brAyh3pV2Aou0CenYBDhzMjdWTNGWe41A4wAM
 zPN7nOv5ZqnH1ZOqNIW2D51+D5DiHftRQhdW8of1WuoZh7HH/WWhmVntquRCxNe7dz0A
 4GoCSCaJEvBH8FMeXL1hHqnSa9XDoYjRLtvhoc2lBVtXbQv/25WSqXFT4Udr+t0VmFOm
 EghZ4YkGC21aYOTeEFdoFTP5L55vAv/gyM6EvoXJI+Wmu4XNcZWrxIfJP12XF923wawC
 R8mEHvc7Q5IqyTeDBlG3bVc91XFsBj8P+C8EbhcpYvad8nTZVpUbZws0mnx+GDf4UExQ
 k1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717430; x=1704322230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fEL79n9ZmuWhwsfPl6PWa+JiwghQnUA1nQdTsB2o+ao=;
 b=qwIfFMcrF8dAHMhwTzxDQrzq04wGhEYe80klonE5O60jVKwdc2tYe/Sluqr/DJ+aoz
 oh2eEmqoYA74tmC+nxaZFjUQgMX39IiTI4dqSkHfp1WbqM5IspgUUwXqIfLI8LSv+Ado
 JqlNOYd4qLNJzfCR6xJZE5H1+KSeUdyJ4CLdEO90DS4UJZDwjbYmKlOQivN71It0jcRY
 loUW4sdgx1K6ESSkraFURportUT9q+jopH55WVb4Kg5bj2Gp1PYUQg8+qzhGHwb0hLnG
 06QwaUYkkTtBh6YrW49ZmX56Jlr7v8zR1PeWLjsghx/ab8VjgkLiZuz4Cw9OiNDVgpob
 68vg==
X-Gm-Message-State: AOJu0YzjLJGx7HybYbvcTEJfpx56NVCNDqMVcbKVhCTofatyshQkXn0R
 LRIrU6uz5U4fRPpNz5gWHJhZuE0RVdzJHQ==
X-Google-Smtp-Source: AGHT+IFWNUD7YjId0rMuFD693gMbugB16U7TtCX+GbQgs8GrJnou+oorQeNThNQct2H/1vLdvu2LvQ==
X-Received: by 2002:a05:6a20:72a4:b0:196:38bf:a238 with SMTP id
 o36-20020a056a2072a400b0019638bfa238mr1135890pzk.51.1703717430491; 
 Wed, 27 Dec 2023 14:50:30 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 x11-20020aa784cb000000b006d9667206bdsm6801175pfn.90.2023.12.27.14.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:50:30 -0800 (PST)
Message-ID: <34263e7c-1419-4680-89ef-dd4fd28c1a88@linaro.org>
Date: Thu, 28 Dec 2023 09:50:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/35] target/arm: Always use arm_pan_enabled() when
 checking if PAN is enabled
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> Currently the code in target/arm/helper.c mostly checks the PAN bits
> in env->pstate or env->uncached_cpsr directly when it wants to know
> if PAN is enabled, because in most callsites we know whether we are
> in AArch64 or AArch32. We do have an arm_pan_enabled() function, but
> we only use it in a few places where the code might run in either an
> AArch32 or AArch64 context.
> 
> For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
> even when the PSTATE.PAN bit is set, the "is PAN enabled" test
> becomes more complicated. Make all places that check for PAN use
> arm_pan_enabled(), so we have a place to put the FEAT_NV test.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3270fb11049..4b0e46cfaae 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -263,6 +263,15 @@ void init_cpreg_list(ARMCPU *cpu)
>       g_list_free(keys);
>   }
>   
> +static bool arm_pan_enabled(CPUARMState *env)
> +{
> +    if (is_a64(env)) {
> +        return env->pstate & PSTATE_PAN;
> +    } else {
> +        return env->uncached_cpsr & CPSR_PAN;
> +    }
> +}

Worth splitting out helpers aa{32,64}_pan_enabled to avoid the is_a64 check when context 
dictates?

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

