Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552487138F1
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 12:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3DHX-0002eU-4O; Sun, 28 May 2023 06:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3DHV-0002di-Bh; Sun, 28 May 2023 06:05:45 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3DHT-0000br-PO; Sun, 28 May 2023 06:05:45 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af6f309613so2460917a34.0; 
 Sun, 28 May 2023 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685268342; x=1687860342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJVyqtly8GA/peLwD9voB33U7vDXcM0dzlMzIew7Bx4=;
 b=pCSJeQX3McSX16Xrs04AF/OA0n5wxWjNJ1Yd7JcPBhTbIezSVOG0bF51zruCeDBGO+
 3cIawPSLtI4V4MIiDVoV7W4tzahdawXHHTIon++7I3ebXKOGYQyAPYR0QF6aEyZaavQt
 Ey4sdwVZ3/W5xGEKca1XTYwukRa6S9Iz80HxCtaiP+USr6XagOELN0fPTR2AKUaQgK92
 DSH79k5Rb5aCYKWbCQrSWX8Ei7VnRvBA8IdJBl2LJgVvIVr+weriPQfjVpKjHinQgGCy
 2Dv8eh9hk2vgDGaaYzWOT/uiCkFPJhE7VFjnockQHTpYSEmjnzx8LLI9QqITJ4vR9a3X
 /SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685268342; x=1687860342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yJVyqtly8GA/peLwD9voB33U7vDXcM0dzlMzIew7Bx4=;
 b=Oq9lJKGjYGee56F3MWapLKYIOEEx9CUaFfCK15FXaqMlIVvkvy7rXP9H1LLhFs50fz
 AkPZpA3Adc5AXw1ftDrVmrJxqNXkDNfUNmJLmJjnw25+NwY4LtojJq1EN67QLXYQVJfC
 p/pLvuQHgO2HvVu2iNJeOC65ycq2rtvb+eK/M6m0S8dMwAcdatnh70coa7aSNoO99A+8
 wzX7Mz/iAdpSLhsvdn346zJyuWdIgWd+BknjLi90kifDpOEM6bNUmXYo6zu00efPRLs6
 zW46AOP/Ie11jJfxE0j2hpLg1T/pitFDOCqVDAwm6RVpMReQcdmssLKChgQOjqZV91ph
 ghfQ==
X-Gm-Message-State: AC+VfDzy3QgJ4+2Xwe8wME7yWvIVkifjrDNBgob7BroDwkjLRSxYQxrQ
 9LvRp+/SMUBgllTAN8TYBdc=
X-Google-Smtp-Source: ACHHUZ6OmCw7LN+V+gkUTOybd8TsUvHf80UCKk0YlhYZ+UtDgwyT1UdA0M9DW0rlQJaUi+nAL1jIiw==
X-Received: by 2002:a05:6830:408d:b0:6af:7129:5a4e with SMTP id
 x13-20020a056830408d00b006af71295a4emr1944028ott.18.1685268342164; 
 Sun, 28 May 2023 03:05:42 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 k19-20020a056830169300b006af8399084bsm3479862otr.72.2023.05.28.03.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 03:05:41 -0700 (PDT)
Message-ID: <846f8f80-e100-b004-f793-489df3f8e2d9@gmail.com>
Date: Sun, 28 May 2023 07:05:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu
References: <20230523202507.688859-1-richard.henderson@linaro.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230523202507.688859-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 5/23/23 17:25, Richard Henderson wrote:
> Instead of computing an artifical "class" bitmask then
> converting that to the fprf value, compute the final
> value from the start.
> 
> Reorder the tests to check the most likely cases first.

Queued in ppc-next ("artifical" typo fixed).


Thanks,

Daniel

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/fpu_helper.c | 78 ++++++++++++-----------------------------
>   1 file changed, 22 insertions(+), 56 deletions(-)
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index a66e16c212..03150a0f10 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -141,62 +141,28 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
>       return ((f >> 52) & 0x7FF) - 1023;
>   }
>   
> -/* Classify a floating-point number.  */
> -enum {
> -    is_normal   = 1,
> -    is_zero     = 2,
> -    is_denormal = 4,
> -    is_inf      = 8,
> -    is_qnan     = 16,
> -    is_snan     = 32,
> -    is_neg      = 64,
> -};
> -
> -#define COMPUTE_CLASS(tp)                                      \
> -static int tp##_classify(tp arg)                               \
> -{                                                              \
> -    int ret = tp##_is_neg(arg) * is_neg;                       \
> -    if (unlikely(tp##_is_any_nan(arg))) {                      \
> -        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
> -        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
> -                ? is_snan : is_qnan);                          \
> -    } else if (unlikely(tp##_is_infinity(arg))) {              \
> -        ret |= is_inf;                                         \
> -    } else if (tp##_is_zero(arg)) {                            \
> -        ret |= is_zero;                                        \
> -    } else if (tp##_is_zero_or_denormal(arg)) {                \
> -        ret |= is_denormal;                                    \
> -    } else {                                                   \
> -        ret |= is_normal;                                      \
> -    }                                                          \
> -    return ret;                                                \
> -}
> -
> -COMPUTE_CLASS(float16)
> -COMPUTE_CLASS(float32)
> -COMPUTE_CLASS(float64)
> -COMPUTE_CLASS(float128)
> -
> -static void set_fprf_from_class(CPUPPCState *env, int class)
> -{
> -    static const uint8_t fprf[6][2] = {
> -        { 0x04, 0x08 },  /* normalized */
> -        { 0x02, 0x12 },  /* zero */
> -        { 0x14, 0x18 },  /* denormalized */
> -        { 0x05, 0x09 },  /* infinity */
> -        { 0x11, 0x11 },  /* qnan */
> -        { 0x00, 0x00 },  /* snan -- flags are undefined */
> -    };
> -    bool isneg = class & is_neg;
> -
> -    env->fpscr &= ~FP_FPRF;
> -    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
> -}
> -
> -#define COMPUTE_FPRF(tp)                                \
> -void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
> -{                                                       \
> -    set_fprf_from_class(env, tp##_classify(arg));       \
> +#define COMPUTE_FPRF(tp)                                          \
> +void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
> +{                                                                 \
> +    bool neg = tp##_is_neg(arg);                                  \
> +    target_ulong fprf;                                            \
> +    if (likely(tp##_is_normal(arg))) {                            \
> +        fprf = neg ? 0x08 << FPSCR_FPRF : 0x04 << FPSCR_FPRF;     \
> +    } else if (tp##_is_zero(arg)) {                               \
> +        fprf = neg ? 0x12 << FPSCR_FPRF : 0x02 << FPSCR_FPRF;     \
> +    } else if (tp##_is_zero_or_denormal(arg)) {                   \
> +        fprf = neg ? 0x18 << FPSCR_FPRF : 0x14 << FPSCR_FPRF;     \
> +    } else if (tp##_is_infinity(arg)) {                           \
> +        fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
> +    } else {                                                      \
> +        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
> +        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
> +            fprf = 0x00 << FPSCR_FPRF;                            \
> +        } else {                                                  \
> +            fprf = 0x11 << FPSCR_FPRF;                            \
> +        }                                                         \
> +    }                                                             \
> +    env->fpscr = (env->fpscr & ~FP_FPRF) | fprf;                  \
>   }
>   
>   COMPUTE_FPRF(float16)

