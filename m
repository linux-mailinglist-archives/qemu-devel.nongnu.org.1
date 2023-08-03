Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5C76DDC9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 04:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNdl-00038u-SD; Wed, 02 Aug 2023 22:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNdj-000382-Cs
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:00:35 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNdh-0007ht-E5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:00:34 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a44fae863fso329657b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691028032; x=1691632832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+H1rUW6iEWl6n5UdD3r7jQPB59Qd3MbKccfUhRNOPI=;
 b=Eq/7PusYu/3iEK+1XOGcf4/Sq4FZzGs8MPTOs6GdB8yCrl7OzoAkzXoZIfg9FcxlFo
 EImmRuxNDGYFz5aG57HFe0mi+yAxT4Q2l6BfrLc7Ac2tzK4zlGMdEfCD/q/6YjorjTm7
 Y+nI6U4LBWXQH742oz8e8o+HkgU800yYpBYmASTv8S6fPQJERbUoTtnJeBEe4MDKhlKd
 EcoZ4fsHPc6FG+l3nfvSgRkGSdQfsM7Lg6jQI3JBPu1Qk/d+7j7FLVESian+FAxSmEQI
 HVmwvm1EpNJnNtL6zZYGk6sddgIRbO9klHnIR4eSkFEzRlU1aBIK/jKIB8pVuEe4DmCE
 hQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691028032; x=1691632832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+H1rUW6iEWl6n5UdD3r7jQPB59Qd3MbKccfUhRNOPI=;
 b=K/7XTq4QLzfiKJg0P1HRYRB0UU+Gk8eO/yuvGpLK4L9Fw1vwu7qH1f+DinzvzynFSm
 DsmfJsDLl2AWNHf44rynUR0geXgbdB8vkSr6YZOFLC3bQsUCb76B8LXalG/1Nqm1cM4z
 SiWpIlwKEsvZPIxPdP8rKYrHheJSjKTkyxnTw4HuKXSPpOgzu9uU3GD15ohfd5d6rYMU
 Ii4WN1Cst9RWOWwKEB6/o6cT92bTNLu/MxtjvwKDG1fXr+vh/y+T58r1CeD9KTaHNyJe
 GXfLwu818e0BIvaZaTE/aek4TroPLvuZqrAYtJdp7BHWnBZiRfgaBQ5YHn6lhF/KYlBD
 UHZA==
X-Gm-Message-State: ABy/qLaVGOIEojpKwII62/OfKzx/zsrNBnC8RjGII1peC7bWtmgGyauG
 2uNhfnpyHJODTdUHDl/grp+w2xOGUETpyp5IhZg=
X-Google-Smtp-Source: APBJJlGt80lRiR4ioURXVw2t6ZgbATyLn5QDfO2LPTDvmk5w86wpoSFJKu7QDPaDmrUqzKNQxMX5Zg==
X-Received: by 2002:aca:230d:0:b0:3a7:239d:af64 with SMTP id
 e13-20020aca230d000000b003a7239daf64mr12431845oie.49.1691028031861; 
 Wed, 02 Aug 2023 19:00:31 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 b14-20020aa7870e000000b00686c77a2905sm11606773pfo.20.2023.08.02.19.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 19:00:31 -0700 (PDT)
Message-ID: <13b823f2-ab77-3456-1c00-bc9b8880327a@linaro.org>
Date: Wed, 2 Aug 2023 19:00:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/m68k: Map FPU exceptions to FPSR register
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230803005534.421387-1-keithp@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803005534.421387-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/2/23 17:55, Keith Packard via wrote:
> Add helpers for reading/writing the 68881 FPSR register so that
> changes in floating point exception state can be seen by the
> application.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/m68k/cpu.h        |  2 ++
>   target/m68k/fpu_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++
>   target/m68k/helper.c     |  4 +--
>   target/m68k/helper.h     |  2 ++
>   target/m68k/translate.c  |  4 +--
>   5 files changed, 80 insertions(+), 4 deletions(-)

Good catch.  Mostly ok.

> +static inline int cpu_m68k_exceptbits_from_host(int host_bits)
...
> +static inline int cpu_m68k_exceptbits_to_host(int target_bits)

No need for inline markers.

> +uint32_t HELPER(get_fpsr)(CPUM68KState *env)
> +{
> +    int host_flags = get_float_exception_flags(&env->fp_status);
> +    int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
> +    int except = (env->fpsr & ~(0xf8)) | target_flags;
> +    return except;
> +}
> +
> +uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
> +{
> +    return HELPER(get_fpsr)(env);
> +}

In general it is bad form to call HELPER(foo) directly.
In this case it doesn't hurt, but better form to reverse the implementations.

> +void HELPER(set_fpsr)(CPUM68KState *env, uint32_t val)
> +{
> +    env->fpsr = val;
> +
> +    int host_flags = cpu_m68k_exceptbits_to_host((int) env->fpsr);
> +    set_float_exception_flags(host_flags, &env->fp_status);
> +}
> +
> +void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val)
> +{
> +    return HELPER(set_fpsr)(env, val);
> +}

Likewise.

What's missing is an update to vmstate, to make sure all the architectural bits are 
properly saved. Add

     env->fpsr = cpu_m68k_get_fpsr(env);

to a (new) fpu_pre_save and

     cpu_m68k_set_fpsr(env, env->fpsr);

to fpu_post_load in target/m68k/cpu.c.


r~

