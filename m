Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF703710D45
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B3E-00067c-U1; Thu, 25 May 2023 09:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2B3C-000675-85
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2B36-0005kQ-Lt
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d24136663so1647736b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685021435; x=1687613435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILTjzHI/vQv42NeYDe1o6ICQtql6vxj18vFolpidHG4=;
 b=qqojgQ9sVZ962A0GXfSygQOkCrGMrYA2hmhOMZfIRuXt5+oCw75vIVlH60r46MOYW+
 buDVsUNeY4t+2K4C/ggjHEqs8z7/b/EZEF2RyeiP6qYi1kT153dsOFLxhYhHA+q+SxmD
 GCCgLzhknvkwrpm9in1iMGh5F2u6P7mm2ZZrp6NtjEMG1p9OjmHlsbFD8GmtK/Urg1gv
 KJvac06tA5+nNfTGo+Ld2lVcKEfgR4T8+mQ5G9FPkoanXseft1dVz7LWEikS96dwAmM7
 s6nDBtSO3dnnIlwIGDkQzjzYgU8azFXlQDYBvZnbSG+aReioMJHNyZ5/OXCeVEmzJpJy
 mb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021435; x=1687613435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILTjzHI/vQv42NeYDe1o6ICQtql6vxj18vFolpidHG4=;
 b=Ro3UdvO2J3wj1Qylozbnn6mz0I15TM9anbxeIkcAcmnRH9CLSyWH/upTKmWT6GZN0n
 xa6jPMG0uXknjTSdBVnnvVQsMprK4qGKJux86pWC5ZJcokucapf55A88TthouFG7wwGo
 +kpTH33sJwFdKYNi5J7u3yfSWITnqYvcAubU2z3wbNvWdV4REjbkLSic941neOWHPDel
 b8Ohl0a2Wj+9Vt7YSucZAdBe/xK2xYBdi+kIaWhuOmuFIlF4nYt6pE2NT/6n9vQ15jxI
 VPjBHpe0ahp8Hf5u8QWtSTzNXKmONTY3xQYRiugm+TKO4CnqFWzokEYd96hU1LkIkXu9
 BpKQ==
X-Gm-Message-State: AC+VfDyyjC3+aWfQtTzuuJ6uUJ4Rj11gtFAll74HEHUCgcauNbVQBPlr
 UMof3KqTmGIsXY0X6rl2uBn4tzSPTT+bT3Ez8aA=
X-Google-Smtp-Source: ACHHUZ7g6SgxkwnJtGyU8Vr69PiqOsc7cXpfK1ghi5513QnZQwqw0A+/kt56ELnOZvu+J9cdtr8XyA==
X-Received: by 2002:a05:6a00:13a8:b0:646:c30d:e9c2 with SMTP id
 t40-20020a056a0013a800b00646c30de9c2mr8960533pfg.28.1685021434345; 
 Thu, 25 May 2023 06:30:34 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a62be0b000000b0064f46570bb7sm1168221pff.167.2023.05.25.06.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:30:33 -0700 (PDT)
Message-ID: <085fece3-862c-60d4-0baf-82cc5267e7fd@linaro.org>
Date: Thu, 25 May 2023 06:30:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
 <77189848-d618-9f55-4ae9-92756e635371@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <77189848-d618-9f55-4ae9-92756e635371@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 5/25/23 06:22, Paolo Bonzini wrote:
> On 5/23/23 16:33, Richard Henderson wrote:
>>
>>
>> The tests are poorly ordered, testing many unlikely things before the most likely thing 
>> (normal).  A better ordering would be
>>
>>      if (likely(tp##_is_normal(arg))) {
>>      } else if (tp##_is_zero(arg)) {
>>      } else if (tp##_is_zero_or_denormal(arg)) {
>>      } else if (tp##_is_infinity(arg)) {
>>      } else {
>>          // nan case
>>      }
>>
>> Secondly, we compute the classify bitmask, and then deconstruct the mask again in 
>> set_fprf_from_class.  Since we don't use the classify bitmask for anything else, better 
>> would be to compute the fprf value directly in the if-ladder.
> 
> So something like this:
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index a66e16c2128c..daed97ca178e 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -141,62 +141,30 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
>       return ((f >> 52) & 0x7FF) - 1023;
>   }
> 
> -/* Classify a floating-point number.  */
> -enum {
> -    is_normal   = 1,
> -    is_zero     = 2,
> -    is_denormal = 4,
> -    is_inf      = 8,
> -    is_qnan     = 16,
> -    is_snan     = 32,
> -    is_neg      = 64,
> -};
> -
> -#define COMPUTE_CLASS(tp)                                      \
> -static int tp##_classify(tp arg)                               \
> -{                                                              \
> -    int ret = tp##_is_neg(arg) * is_neg;                       \
> -    if (unlikely(tp##_is_any_nan(arg))) {                      \
> -        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
> -        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
> -                ? is_snan : is_qnan);                          \
> -    } else if (unlikely(tp##_is_infinity(arg))) {              \
> -        ret |= is_inf;                                         \
> -    } else if (tp##_is_zero(arg)) {                            \
> -        ret |= is_zero;                                        \
> -    } else if (tp##_is_zero_or_denormal(arg)) {                \
> -        ret |= is_denormal;                                    \
> -    } else {                                                   \
> -        ret |= is_normal;                                      \
> -    }                                                          \
> -    return ret;                                                \
> -}
> -
> -COMPUTE_CLASS(float16)
> -COMPUTE_CLASS(float32)
> -COMPUTE_CLASS(float64)
> -COMPUTE_CLASS(float128)
> -
> -static void set_fprf_from_class(CPUPPCState *env, int class)
> +static void set_fprf(CPUPPCState *env, uint8_t ret)
>   {
> -    static const uint8_t fprf[6][2] = {
> -        { 0x04, 0x08 },  /* normalized */
> -        { 0x02, 0x12 },  /* zero */
> -        { 0x14, 0x18 },  /* denormalized */
> -        { 0x05, 0x09 },  /* infinity */
> -        { 0x11, 0x11 },  /* qnan */
> -        { 0x00, 0x00 },  /* snan -- flags are undefined */
> -    };
> -    bool isneg = class & is_neg;
> -
>       env->fpscr &= ~FP_FPRF;
> -    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
> +    env->fpscr |= ret << FPSCR_FPRF;
>   }
> 
> -#define COMPUTE_FPRF(tp)                                \
> -void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
> -{                                                       \
> -    set_fprf_from_class(env, tp##_classify(arg));       \
> +#define COMPUTE_FPRF(tp)                                       \
> +void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
> +{                                                              \
> +    int ret;                                                   \
> +    if (tp##_is_normal(arg)) {                                 \
> +        ret = 0x0408;                                          \
> +    } else if (tp##_is_zero(arg)) {                            \
> +        ret = 0x0212;                                          \
> +    } else if (tp##_is_zero_or_denormal(arg)) {                \
> +        ret = 0x1418;                                          \
> +    } else if (unlikely(tp##_is_infinity(arg))) {              \
> +        ret = 0x0509;                                          \
> +    } else {                                                   \
> +        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
> +        ret = (tp##_is_signaling_nan(arg, &dummy)              \
> +               ? 0x0000 : 0x1111);                             \
> +    }                                                          \
> +    set_fprf(env, tp##_is_neg(arg) ? (uint8_t)ret : ret >> 8); \
>   }
> 
>   COMPUTE_FPRF(float16)
> 
> 
> Not tested beyond compilation, but if Zoltan reports that it helps
> I can write a commit message and submit it.

See

https://patchew.org/QEMU/20230523202507.688859-1-richard.henderson@linaro.org/

and follow-up.  It drops this one function in the profile, but only helps very slightly vs 
wall clock.


r~

