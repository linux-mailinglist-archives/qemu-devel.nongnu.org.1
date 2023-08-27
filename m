Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7A789B6B
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7pZ-0003gG-8q; Sun, 27 Aug 2023 00:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7pL-0003fw-4Q
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:56:44 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7pJ-0006TM-08
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:56:42 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a8614fe8c4so1696371b6e.1
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112199; x=1693716999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nT40qjRZ5xct9JtHJQGteG+v4X1NI48l66cJeIhhV1k=;
 b=YDxcCq+MywVVQ+sD+j/7qRtaraN84jTBaSCMo6SuJ+3S/Tt8OEmLIWLwgcQXlqmDNq
 fU8ktQeppcAe8fC/if/6Rn5fFdvE6A9uq+kGeJ5sH3gfBBJ0+cyX7swFYRduR/HKkHHy
 PfEy1OheIYjtpkNE4wkJbqqTgxu/xTMNpTgPBBU7pWggdO2P2R2//GIGK81OAOMMCU/F
 zHYgoq0uKKP0sE/MLybirxCVkxF5EjSmBoF3BE1dkWnaq21lDaoAVLVdBQ0zG19nUoVv
 opU2lJzsIiOh/YE/pyESdCcyBzA7sAn/cX9khPDqPHhMVGBQcozA1mQ38TGRvkArNaOu
 44qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112199; x=1693716999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nT40qjRZ5xct9JtHJQGteG+v4X1NI48l66cJeIhhV1k=;
 b=lcm9jrRtCalEKI2lJzQMQP0kZNWx55nC7ph8X1b7EwkyRJ/hEE6mrPg3pm8IG2pHFX
 iz3oGvKhOkv9bKespWs9qCLGtF4s9MEevm4/pf4dKXMfgFdYTtN60HaqszxX5e1uCpzU
 wyCHlBgXd8OdF0Ym6vbuqZMkNhVHSxCxyn/AoVU39+lyH/0AP0SVMMQOkg0U38a30Vke
 zyVAc1igTSBhK1WnaynIjy8VhOO7eI7h6rowGjX68tFNcZ01PkowgL5dHh1L//0yXnJh
 BVGmmwMT3rquM+UotLGqmKd3TNRJe108A/wtD3Q4DY27wdGjVFcWttDRCwTjq9bUcmSu
 fvBg==
X-Gm-Message-State: AOJu0Yzow/bI6kAtL0tkZe/TmUPyLa8JjLdKe2WV+bHhIab1IaH9eWPb
 cn087vdye0sUZvyRX4Dc4roQbw==
X-Google-Smtp-Source: AGHT+IEnkAb7SDsMB7kltsA+2EqpkPhKSkSGFoNGnIgYLxUxsEp+JzOtI6njjgcifMOWI4K6AEySQQ==
X-Received: by 2002:a05:6808:178a:b0:3a7:4a89:752c with SMTP id
 bg10-20020a056808178a00b003a74a89752cmr9965384oib.31.1693112198897; 
 Sat, 26 Aug 2023 21:56:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fe24-20020a056a002f1800b0068a690b44basm4139658pfb.31.2023.08.26.21.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:56:38 -0700 (PDT)
Message-ID: <3ab5d805-50ca-963f-33a1-bccafe07c046@linaro.org>
Date: Sat, 26 Aug 2023 21:56:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] target/tricore: Implement hptof insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
> +uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
> +{
> +    float16 f_arg = make_float16(arg);
> +    uint32_t result = 0;
> +    int32_t flags = 0;
> +
> +    if (float16_is_any_nan(f_arg)) {
> +        if (float16_is_signaling_nan(f_arg, &env->fp_status)) {
> +            flags |= float_flag_invalid;
> +        }
> +        result = 0;
> +        result = float32_set_sign(result, f_arg >> 15);
> +        result = deposit32(result, 23, 8, 0xff);
> +        result = deposit32(result, 21, 2, extract32(f_arg, 8, 2));
> +        result = deposit32(result, 0, 8, extract32(f_arg, 0, 8));
> +    } else if (float16_is_infinity(f_arg)) {
> +        if (float16_is_neg(f_arg)) {
> +            result = NEG_INFINITY;
> +        } else {
> +            result = POS_INFINITY;
> +        }
> +    } else {
> +        set_flush_inputs_to_zero(0, &env->fp_status);
> +        result = float16_to_float32(f_arg, true, &env->fp_status);
> +        set_flush_inputs_to_zero(1, &env->fp_status);
> +        flags = f_get_excp_flags(env);
> +    }

Again, only the else case.


r~

