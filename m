Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5B781F2ED
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 00:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcz6-0007R6-M0; Wed, 27 Dec 2023 18:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcyy-0007Q5-UC
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:06:37 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcyw-0007J0-Ti
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:06:36 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6da67ca9969so4363870a34.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 15:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703718393; x=1704323193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvPajHIy8l1g3X2buf75zd7Xou3Ys9df3H+HTh42yEQ=;
 b=fKUU520v4NtPZWq5pfe94qwJs6fld1+/Df0rmHfPSvkuWdLTJmVdXNwqylZvb3qUaR
 VkrvtISBm3Piz+tdyAcHf32Pc0MgYpafoHdi9mKQaM8d5xrU55/M1dEmclJ8jvMB42g7
 /wTK6fu+o2uXDvpwKn+GLrCpxa4o9DnhR+lDCpP19DuT1zVWUx/1AiiDUNSTRqwgwoQr
 a4Zlq313yGbax29TGb00NERVlt+ijRSiSW4+KDk+qQx0XO1xJA8Uz4/8l8VJdWY5Lr+d
 QIkPT8u3yC/bg/Lz1Y/6icYqvjWxsXUh5F699kyiT05SZfzuSv5ff+yR85qjh7TCsi3+
 UWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703718393; x=1704323193;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvPajHIy8l1g3X2buf75zd7Xou3Ys9df3H+HTh42yEQ=;
 b=gKD44PTjk5KP8m3LCpiwyBEu3qZa/s8qELthv+z0fzk4FThwZ9He/CV6fs27NLHhP8
 wEiRVXLItASQu1YmH7b4Mf+jk1ibyaa98N4PTmdeAhijDHyf/s82NNRF0wh57qISwrY8
 RgQAKD6SF9biz9tZBcJHQ8VrMLu0IUyrk66I/GSWmRoweaHjwYZvTSGcCrkTXmAk+WzE
 PMiKTgRDArVXlqPqJSSSpoP9dxnI5jyvxKUdNTQHiKXRgDsSkLz+5SiuohxjsvZbYidB
 YkQd5zfFTFHOiGZVOuOpI99098DV2QNVprtBaCgNc6ppL3A/Rn+cqipA0muDX/bY+krC
 Q4hw==
X-Gm-Message-State: AOJu0YyEh7ni/24VrI8eWRr56qc9p4UIF29gCQb8lnDCL27EcBmLQC1S
 /FgShgcLANnOVnxm2Lq04VkDIXragnyOFQ==
X-Google-Smtp-Source: AGHT+IFYiYi1lpMyJtj0iIu3C/e7s2q3NFnnAuzJJ/zm/CUQDPrjt3aOrMc+VBIuZBCnh/c13UbjqQ==
X-Received: by 2002:a05:6870:3514:b0:1ea:2e2c:e9e7 with SMTP id
 k20-20020a056870351400b001ea2e2ce9e7mr11519898oah.59.1703718393281; 
 Wed, 27 Dec 2023 15:06:33 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa781cd000000b006d9fd64fdcasm1975921pfn.37.2023.12.27.15.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 15:06:32 -0800 (PST)
Message-ID: <cd9c4cc1-be3b-49d4-a049-c8157a9cae03@linaro.org>
Date: Thu, 28 Dec 2023 10:06:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/35] target/arm: Handle FEAT_NV2 changes to when
 SPSR_EL1.M reports EL2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> With FEAT_NV2, the condition for when SPSR_EL1.M should report that
> an exception was taken from EL2 changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 45444360f95..38e16c2f8a5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11405,10 +11405,18 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>           aarch64_save_sp(env, arm_current_el(env));
>           env->elr_el[new_el] = env->pc;
>   
> -        if (cur_el == 1 && new_el == 1 &&
> -            ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV)) {
> -            /* I_ZJRNN: report EL2 in the SPSR by setting M[3:2] to 0b10 */
> -            old_mode = deposit32(old_mode, 2, 2, 2);
> +        if (cur_el == 1 && new_el == 1) {
> +            uint64_t hcr = arm_hcr_el2_eff(env);
> +            if ((hcr & (HCR_NV | HCR_NV1 | HCR_NV2)) == HCR_NV ||
> +                (hcr & (HCR_NV | HCR_NV2)) == (HCR_NV | HCR_NV2)) {

Maybe clearer as

	if ((hcr & HCR_NV) && ((hcr & HCR_NV2) || !(hcr & HCR_NV1)))

?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +                /*
> +                 * FEAT_NV, FEAT_NV2 may need to report EL2 in the SPSR
> +                 * by setting M[3:2] to 0b10.
> +                 * If NV2 is disabled, change SPSR when NV,NV1 == 1,0 (I_ZJRNN)
> +                 * If NV2 is enabled, change SPSR when NV is 1 (I_DBTLM)
> +                 */
> +                old_mode = deposit32(old_mode, 2, 2, 2);
> +            }
>           }
>       } else {
>           old_mode = cpsr_read_for_spsr_elx(env);


