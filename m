Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DAC73E222
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDnBm-0002cq-96; Mon, 26 Jun 2023 10:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDnBk-0002cd-JG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:27:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDnBi-00057E-NV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:27:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fa99742be2so9083085e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687789648; x=1690381648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzcmpLbpW5Li73i7EDCKCZGiH1BxBBkBULzrNMVXdCQ=;
 b=lG0t66UFJUhtch2JfGXZMTPKbuZxgUNNcbcnIuYWHYlmApGBlfFmWUrFrxyKjtWmZ6
 k/fa7zl3jkTl9MQCM/hqR9VYoNe+cHN9arQWiL0n14ZB0gnV2GTvvV3k8QtQlGC04txi
 CXBJfeA8nhFgkUwkFwhztyHBlOIyH8du2zpj26Z9oogXH0zJ8Fq+AoxnJDirkv42YdB/
 ZNQ/j4JK+7a4P1KlqmHwkhaHNdlBJTvCmV1rA4MjYp/KFLv49VGqKrz0dfVG9i8M6Lt/
 f4GCGf0TLrH+Tl1BZpIBUd6otpBfK/RYJIkMJLAkVjWcHO/RsCF3q58TIgdVR0lNIDJG
 H0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687789648; x=1690381648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzcmpLbpW5Li73i7EDCKCZGiH1BxBBkBULzrNMVXdCQ=;
 b=fHezshHtVlgOLipUKFw/nVF22fpYl80wDRSoq5LBM9sQrf2Os+xDUXVF6lU4E7LG3J
 CvgJ1p4olo0osoJzXUCzKlRZP2w/3AYm/0H+4OXHUBHvvaVGuW1s/WbfZPlaRhu6AFAv
 lrzHi/pYsGe8rp9nUCMW1JBLl126MJEhPz0gBi/f2jdub2fJIpnHpUB4s0EpHvY70EXO
 3hV0DwDpPo25nt41jEEsaVRZXS1ku5klMfoezJrNUZJ764AZqCVs1+px/OexiYTYfND2
 wAgWjwpeDeFjWScGURwTKWrDAH0MydpXNM79GLyTguXzJw7uJ9chFJaYKf2rAlDFq5A8
 uq0w==
X-Gm-Message-State: AC+VfDwFgvE2zPi2Anvm0gfxqvc6l1HIv5UKpW5iFXrz/CIpPuieGLeY
 PNTZArNJ7xFFFSkpvIovs3sJsw==
X-Google-Smtp-Source: ACHHUZ6EpUkev7oh9VbQdDbJdpKn68zbJjhahpgJEw3VstJecKFtZ9pOs7NfdtscsEnDUs7VBnSbKA==
X-Received: by 2002:a1c:7911:0:b0:3fa:8b53:81d with SMTP id
 l17-20020a1c7911000000b003fa8b53081dmr3352183wme.16.1687789647763; 
 Mon, 26 Jun 2023 07:27:27 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003fb40f5f553sm804411wmr.31.2023.06.26.07.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 07:27:27 -0700 (PDT)
Message-ID: <ba59ed3c-c530-aeab-1c20-0f37f35fafd6@linaro.org>
Date: Mon, 26 Jun 2023 16:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH qemu v4 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
Content-Language: en-US
To: ~jhogberg <john.hogberg@ericsson.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <168778890374.24232.3402138851538068785-1@git.sr.ht>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <168778890374.24232.3402138851538068785-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/8/23 19:49, ~jhogberg wrote:
> From: John Högberg <john.hogberg@ericsson.com>
> 
> Unlike architectures with precise self-modifying code semantics
> (e.g. x86) ARM processors do not maintain coherency for instruction
> execution and memory, requiring an instruction synchronization
> barrier on every core that will execute the new code, and on many
> models also the explicit use of cache management instructions.
> 
> While this is required to make JITs work on actual hardware, QEMU
> has gotten away with not handling this since it does not emulate
> caches, and unconditionally invalidates code whenever the softmmu
> or the user-mode page protection logic detects that code has been
> modified.
> 
> Unfortunately the latter does not work in the face of dual-mapped
> code (a common W^X workaround), where one page is executable and
> the other is writable: user-mode has no way to connect one with the
> other as that is only known to the kernel and the emulated
> application.
> 
> This commit works around the issue by telling software that
> instruction cache invalidation is required by clearing the
> CPR_EL0.DIC flag (regardless of whether the emulated processor
> needs it), and then invalidating code in IC IVAU instructions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1034
> 
> Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: John Högberg <john.hogberg@ericsson.com>
> ---
>   target/arm/cpu.c    | 13 +++++++++++++
>   target/arm/helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 4d5bb57f07..b82fb46157 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1674,6 +1674,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /*
> +     * User mode relies on IC IVAU instructions to catch modification of
> +     * dual-mapped code.
> +     *
> +     * Clear CTR_EL0.DIC to ensure that software that honors these flags uses
> +     * IC IVAU even if the emulated processor does not normally require it.
> +     */
> +#ifdef CONFIG_USER_ONLY
> +    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +        cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, DIC, 0);
> +    }
> +#endif

No need to check for aarch64 -- the bit is present at the same location with the same 
meaning in the v8 aarch32 view: "CTR".  (Prior to v8, this bit was part of the Format 
field, and had value 0 for v6 and v7, so still no need to check before writing this zero.)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

