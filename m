Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565478A105
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKYf-0002lN-LK; Sun, 27 Aug 2023 14:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaKYU-0002JF-UB
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:32:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaKYR-0005J0-FV
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:32:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68c3b9f85b7so797578b3a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693161125; x=1693765925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P8/jTRE6EAk6KuxIjAymVY5cLZcc3bkUv1CR1ZAvdQ4=;
 b=euUSY2Cn8HutcsyGTQyYzPFAjn244URJgSKKwHLjX/pl51Rt8nIM1bJk4Af6G9QAly
 vBSxdyj3GKDrcQ5zYhobW9XPdHVw55TbsSWllPHgxuouWgiLoavLlsdsf0JMnqQZ+bYI
 mdjWeGyG9iiqq/CCaQ+64PModjKobjORG7EbrQJQ0h8SX5JIr87bqBbXAAs8iOEXMXX9
 QFteGPA3q26MqHWMuMetU7w8x9WvYJKntmT3ztxSOqQGz47XEaENzJNjyZzUMCj/+kMw
 PjaMLCMt+/KZwRUkEy5/ysXyyUw/bRYmkfsRvdo1DWvOOfF90A4/MjuslgKbOThp72Wl
 lxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693161125; x=1693765925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8/jTRE6EAk6KuxIjAymVY5cLZcc3bkUv1CR1ZAvdQ4=;
 b=On4P+EvxQuMYkdeS7AlrldvYAmqsrrenhk+oBbLLn6YP/v3FfzFQN7eAbikB7K20LN
 xe1YBKAC+dkqjmxrDoREQnGX7DwnXs27bpGfBUMQtMB3T2E49A8Bd/KyMEzklRtEPnXp
 Rb3+8DH/IX2E+kGgm1rSyWDRUxIzwuDpUOjezS0pcsIOX32fy+jM5d3jeU1pnwPm/FJb
 3owHA8XHKSppePWxHZh3CxEh2ZPnsAAngA6b/p2jvGpq8MhsUPnuxoJxZQvn5aE7Qz4D
 8C/TrEv4ouALKrlY8WCxZc9sqA0q+p9TgbD2Kj7LAdjc5wNK5YycosEYjCE4fHggoH4H
 C5mA==
X-Gm-Message-State: AOJu0YxF3WiWXxT5SlE7D7l4wyF/n9x1gdwOIGH1oJDz4b7RZhJFT5VF
 6FwmoGGUPW0B0I5vc1pzZ5wfAw==
X-Google-Smtp-Source: AGHT+IHoKylKr4xtluzNpVS0KVxBtYebz/uvfswKMGLg+NJfbqZxl5ZJF/ofg8OTDu/wLFLqsemK6w==
X-Received: by 2002:a05:6a00:22c1:b0:689:f13a:5eb5 with SMTP id
 f1-20020a056a0022c100b00689f13a5eb5mr23081014pfj.28.1693161125213; 
 Sun, 27 Aug 2023 11:32:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z22-20020aa791d6000000b00686a80f431dsm5080398pfa.126.2023.08.27.11.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 11:32:04 -0700 (PDT)
Message-ID: <59ca80e3-7e00-ebd8-1e1f-23ef1d828b8c@linaro.org>
Date: Sun, 27 Aug 2023 11:32:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] target/tricore: Implement FTOU insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-5-kbastian@mail.uni-paderborn.de>
 <f8f824f3-add2-a6ea-1e78-48aa9d1b6e56@linaro.org>
 <a5atencg3p7r5yad5ybg75c6clr6ofk24xm2j2yw2pct6wb6bs@5onnabp3kkyg>
 <58ad531d-82aa-d0fe-a830-a41f5b465cb1@linaro.org>
 <aiwaftbattdfzjd4dr5hw62ux4spong5yjpi54b7te4ybq64ty@b5k42n7yhuck>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aiwaftbattdfzjd4dr5hw62ux4spong5yjpi54b7te4ybq64ty@b5k42n7yhuck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.414,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/27/23 09:36, Bastian Koppelmann wrote:
> On Sun, Aug 27, 2023 at 07:49:52AM -0700, Richard Henderson wrote:
>> On 8/27/23 04:07, Bastian Koppelmann wrote:
>>> On Sat, Aug 26, 2023 at 09:50:51PM -0700, Richard Henderson wrote:
>>>> On 8/26/23 09:02, Bastian Koppelmann wrote:
>>>>> +uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
>>>>> +{
>>>>> +    float32 f_arg = make_float32(arg);
>>>>> +    uint32_t result;
>>>>> +    int32_t flags = 0;
>>>>> +
>>>>> +    if (float32_is_any_nan(f_arg)) {
>>>>> +        result = 0;
>>>>> +        flags |= float_flag_invalid;
>>>>> +    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
>>>>> +        result = 0;
>>>>> +        flags = float_flag_invalid;
>>>>> +    } else {
>>>>> +        result = float32_to_uint32(f_arg, &env->fp_status);
>>>>> +        flags = f_get_excp_flags(env);
>>>>> +    }
>>>>
>>>> You should allow softfloat to diagnose the special cases, and negative -> 0
>>>> is standard behaviour.  Therefore:
>>>
>>> You're right. However, there is one special case, negative -> 0 ought to raise
>>> float_flags_invalid.
>>
>> https://gitlab.com/qemu-project/qemu/-/blob/master/fpu/softfloat-parts.c.inc?ref_type=heads#L1162
> 
> Lets say the exponent is negative and the sign is negative, then we raise
> float_flag_inexact and we never reach the code you mentioned here. However,
> TriCore HW raises float_flag_invalid as well in that case. This is what I'm
> catching with float32_lt_quiet() in the same manner as ftouz.

Hmph.  Buggy hardware.  You'd better document this special case,
that less-than-zero is detected before rounding.

I presume -0.0 does not raise invalid, that the bug does not extend that far?


r~

