Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA1789B6A
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:55:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7o4-0002wJ-Pt; Sun, 27 Aug 2023 00:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7nt-0002vb-1O
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:55:18 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7np-0005Wh-Tn
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:55:11 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d35a9d7a5bdso2034232276.0
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112107; x=1693716907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rm8bKJL/uB5DrkeXCL7ZVWUi+8t6fsAibXb1VmWkBIE=;
 b=XHTiuFyvBfo0IZI4RM7CeiuA9SARj3Yu564hqsNBmaTkq4medEDY+A7BYv3idnBMp8
 UaeaiGAXfgtsBAZJ0zvSKpx/sBD+9GkB68WuecV8OO7OFrEUwwWKxUdF2HZk22VFDVD3
 Aj5XEVA6cCkKQw6p7Vc+kLeoJo/+vyhPQ/xp3vHxHvZkl5qKsAkYgZ/LoXqF2Atrl1Df
 rADr1JX4jd7UDGR0GSa2+osJTkIo9iOgl/kAFf04f12xwVg6CXYQQnFyR9DjvPGDEg8b
 ffKVj5Z4ClyE74/4fAG4Pb7ryFKZK8fRRE+z7x2MhM2FMA7KS4MWfz3JZJbmWaaZcGBh
 6MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112107; x=1693716907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rm8bKJL/uB5DrkeXCL7ZVWUi+8t6fsAibXb1VmWkBIE=;
 b=eJZXVYaMCJoiB0uHpzrFkfMwM1jx0MTQpisRp2qgziKUfrJ1Iam8+TtEKyUjSFTLVB
 uGH9O5Rbzu1G0E0rcNtjx8DRsc3SCfHGR+GRQnhxNfDxLp4Ph9AHfNPUuXbLio/qLjTB
 y3Cle7FT3dpjXOWD3whTW0lcJ2pRADk4hWulZeUjXIYRLE9ex9vOAAcX+5INob0KIYnV
 w4BJuDnEUw5KwAr5RwWMWVaMEyJTTcV4U/SIL5sh6tRtKM0RO4w/punbtxi3UmXhlQmQ
 YnQ3Z/5xeyr26koPruQ8itWrF/j6bo7hK17HQqhXoEU8DaG9jQW/cWurMQp8yKDcZAuI
 B3zA==
X-Gm-Message-State: AOJu0YyICnOiRG4UX6at3OPJ8o6usUmmsQMfEMIzw2OvYdzFjiWCNZ2s
 lRp5e86iQ74UjAvONqq0H6q1pw==
X-Google-Smtp-Source: AGHT+IGPe0jPJ1J2PqmryeyWAIXU+atrjFPeDtoOEGily+tS+HC5rTUuBvwzqE7cEEpZw09q0FhqQw==
X-Received: by 2002:a25:d207:0:b0:d08:2101:562d with SMTP id
 j7-20020a25d207000000b00d082101562dmr23726591ybg.34.1693112107733; 
 Sat, 26 Aug 2023 21:55:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 22-20020aa79156000000b006877a17b578sm4126053pfi.40.2023.08.26.21.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:55:07 -0700 (PDT)
Message-ID: <5598bd01-6d2e-5661-8cb5-aa5a49b22ffd@linaro.org>
Date: Sat, 26 Aug 2023 21:55:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/10] target/tricore: Implement ftohp insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> +uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
> +{
> +    float32 f_arg = make_float32(arg);
> +    uint32_t result = 0;
> +    int32_t flags = 0;
> +
> +    if (float32_is_infinity(f_arg)) {
> +        if (float32_is_neg(f_arg)) {
> +            return  HP_NEG_INFINITY;
> +        } else {
> +            return  HP_POS_INFINITY;
> +        }
> +    } else if (float32_is_any_nan(f_arg)) {
> +        if (float32_is_signaling_nan(f_arg, &env->fp_status)) {
> +            flags |= float_flag_invalid;
> +        }
> +        result = float16_set_sign(result, arg >> 31);
> +        result = deposit32(result, 10, 5, 0x1f);
> +        result = deposit32(result, 8, 2, extract32(arg, 21, 2));
> +        result = deposit32(result, 0, 8, extract32(arg, 0, 8));
> +        if (extract32(result, 0, 10) == 0) {
> +            result |= (1 << 8);
> +        }
> +    } else {
> +        set_flush_to_zero(0, &env->fp_status);
> +        result = float32_to_float16(f_arg, true, &env->fp_status);
> +        set_flush_to_zero(1, &env->fp_status);
> +        flags = f_get_excp_flags(env);
> +    }

All of this is standard behaviour.  All you need is the final else case.

> +    set_float_detect_tininess(true, &env->fp_status);

s/true/float_tininess_before_rounding/


r~

