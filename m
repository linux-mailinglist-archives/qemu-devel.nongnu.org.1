Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D60827625
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:16:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtEx-0001QY-G0; Mon, 08 Jan 2024 12:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMtEA-0000bt-9n
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:15:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMtE4-0008Ml-Ip
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:15:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e485c49acso8898945e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704734147; x=1705338947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9b6JowHwulSXZDNlft96WvGTBEMWvfXbKkXSX00xH2M=;
 b=Mpbqd+/8S2baT2+w19s9jqHrg+79ekg3RGEBeJcyByNnVngY9c0WgVqgpMSpd2ET/j
 5p162epKNQ1wbtXWRzIcSBAFmeMgMzAOF3Fw/FsQ5GfccFZAV/e+C8sF1yNhRsBILws9
 GVU+mPGYJK70FGoW5SJSeXc0tLfX9Q2G7UB7NpU+qOo0MRh32RDzZHb7f36x4L9p2CxS
 SLJW2ozl146sHFiXpCFh9Tfu8tiWJB5YIUlZUEKCqzOn1FhOB8HxLrlaIy7qodtWYQgU
 iLJlXJZHLPthJYiEtWmaR0WOyGuFFZ9y5/Go8d8mE0LootiJh2FxzlJxUlqfKZcnBKaW
 aD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734147; x=1705338947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9b6JowHwulSXZDNlft96WvGTBEMWvfXbKkXSX00xH2M=;
 b=LKqJ72vKLcdSUsDjCFP/pAajPOO0Zgv3HFr6zxavhRHEkqqsvhrp5vYj+gJ1K4Iq99
 PjPn0uGs+V8U9/4EPvglVXblZ9eXx9/kW2zs76N8Z7b5ac4VS/Kww3sK2S84uUQSFcQn
 r10Z8sy0LZHgRedu3rUiYWnH/DVkX9y2nBim5YFOq1f0klXxNqm7vagIXoKwGIj42+ch
 OiV6r5ZPOE2a0C5OPMU2GlbQb8TGEgCCXcaWlQ4nmmdTheg4QVsuOildTtptrZ/TpJol
 tx9bSCmd8Z65Wr7lzuNeS8KG5i/R9Eb9fRIwLO2TnqYY63ZDy6H8mE6ZQul7j6QQCwpw
 KU8Q==
X-Gm-Message-State: AOJu0YwWyVwYbwzJAGhzFMKCloWTsJS1jkUVymTFUehRHwtFDEOoPPO0
 5OQtYRfhSGRiGgh1ZQtTFAyeTnTPSnlceA==
X-Google-Smtp-Source: AGHT+IHWRXOGc9nSjvJnelS+SvgtMdQBj9XXeK+4lkRsdwKco5cbRTzsJD4N9dMuJpVZiSj+Qr6c9A==
X-Received: by 2002:a7b:c5cc:0:b0:40d:7607:a996 with SMTP id
 n12-20020a7bc5cc000000b0040d7607a996mr2126052wmk.183.1704734146754; 
 Mon, 08 Jan 2024 09:15:46 -0800 (PST)
Received: from [192.168.1.102] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c154d00b0040e3635ca65sm11777548wmg.2.2024.01.08.09.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 09:15:46 -0800 (PST)
Message-ID: <bd92d4c4-8d12-4036-8d9d-385d67099e4e@linaro.org>
Date: Mon, 8 Jan 2024 18:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] linux-user: Add code for PR_GET/SET_UNALIGN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20211220214135.189157-1-richard.henderson@linaro.org>
 <20211220214135.189157-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20211220214135.189157-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Richard,

(revisiting this old patch.)

On 20/12/21 22:41, Richard Henderson wrote:
> This requires extra work for each target, but adds the
> common syscall code, and the necessary flag in CPUState.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h                     |  3 +++
>   linux-user/generic/target_prctl_unalign.h | 27 +++++++++++++++++++++++
>   cpu.c                                     | 20 ++++++++++++-----
>   linux-user/syscall.c                      | 13 +++++++++--
>   4 files changed, 56 insertions(+), 7 deletions(-)
>   create mode 100644 linux-user/generic/target_prctl_unalign.h
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index e948e81f1a..76ab3b851c 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -413,6 +413,9 @@ struct CPUState {
>   
>       bool ignore_memory_transaction_failures;
>   
> +    /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
> +    bool prctl_unalign_sigbus;
> +
>       struct hax_vcpu_state *hax_vcpu;
>   
>       struct hvf_vcpu_state *hvf;
> diff --git a/linux-user/generic/target_prctl_unalign.h b/linux-user/generic/target_prctl_unalign.h
> new file mode 100644
> index 0000000000..bc3b83af2a
> --- /dev/null
> +++ b/linux-user/generic/target_prctl_unalign.h
> @@ -0,0 +1,27 @@
> +/*
> + * Generic prctl unalign functions for linux-user
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef GENERIC_TARGET_PRCTL_UNALIGN_H
> +#define GENERIC_TARGET_PRCTL_UNALIGN_H
> +
> +static abi_long do_prctl_get_unalign(CPUArchState *env, target_long arg2)
> +{
> +    CPUState *cs = env_cpu(env);
> +    uint32_t res = PR_UNALIGN_NOPRINT;
> +    if (cs->prctl_unalign_sigbus) {
> +        res |= PR_UNALIGN_SIGBUS;
> +    }
> +    return put_user_u32(res, arg2);
> +}
> +#define do_prctl_get_unalign do_prctl_get_unalign
> +
> +static abi_long do_prctl_set_unalign(CPUArchState *env, target_long arg2)
> +{
> +    env_cpu(env)->prctl_unalign_sigbus = arg2 & PR_UNALIGN_SIGBUS;
> +    return 0;
> +}
> +#define do_prctl_set_unalign do_prctl_set_unalign
> +
> +#endif /* GENERIC_TARGET_PRCTL_UNALIGN_H */
> diff --git a/cpu.c b/cpu.c
> index 945dd3dded..016bf06a1a 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -174,13 +174,23 @@ void cpu_exec_unrealizefn(CPUState *cpu)
>       cpu_list_remove(cpu);
>   }
>   
> +/*
> + * This can't go in hw/core/cpu.c because that file is compiled only
> + * once for both user-mode and system builds.
> + */
>   static Property cpu_common_props[] = {
> -#ifndef CONFIG_USER_ONLY
> +#ifdef CONFIG_USER_ONLY
>       /*
> -     * Create a memory property for softmmu CPU object,
> -     * so users can wire up its memory. (This can't go in hw/core/cpu.c
> -     * because that file is compiled only once for both user-mode
> -     * and system builds.) The default if no link is set up is to use
> +     * Create a property for the user-only object, so users can
> +     * adjust prctl(PR_SET_UNALIGN) from the command-line.

How can I test this per-thread property?

Shouldn't this be an accel (TCG/user) property, for all threads?

> +     * Has no effect if the target does not support the feature.
> +     */
> +    DEFINE_PROP_BOOL("prctl-unalign-sigbus", CPUState,
> +                     prctl_unalign_sigbus, false),
> +#else
> +    /*
> +     * Create a memory property for softmmu CPU object, so users can
> +     * wire up its memory.  The default if no link is set up is to use
>        * the system address space.
>        */
>       DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ef7a955dbb..3f481eb5b2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6377,6 +6377,12 @@ static abi_long do_prctl_inval1(CPUArchState *env, abi_long arg2)
>   #ifndef do_prctl_get_tagged_addr_ctrl
>   #define do_prctl_get_tagged_addr_ctrl do_prctl_inval0
>   #endif
> +#ifndef do_prctl_get_unalign
> +#define do_prctl_get_unalign do_prctl_inval1
> +#endif
> +#ifndef do_prctl_set_unalign
> +#define do_prctl_set_unalign do_prctl_inval1
> +#endif
>   
>   static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>                            abi_long arg3, abi_long arg4, abi_long arg5)
> @@ -6440,6 +6446,11 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>           }
>           return do_prctl_get_tagged_addr_ctrl(env);
>   
> +    case PR_GET_UNALIGN:
> +        return do_prctl_get_unalign(env, arg2);
> +    case PR_SET_UNALIGN:
> +        return do_prctl_set_unalign(env, arg2);
> +
>       case PR_GET_DUMPABLE:
>       case PR_SET_DUMPABLE:
>       case PR_GET_KEEPCAPS:
> @@ -6482,8 +6493,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>       case PR_SET_THP_DISABLE:
>       case PR_GET_TSC:
>       case PR_SET_TSC:
> -    case PR_GET_UNALIGN:
> -    case PR_SET_UNALIGN:
>       default:
>           /* Disable to prevent the target disabling stuff we need. */
>           return -TARGET_EINVAL;


