Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 255FA776554
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmIk-0007R7-1u; Wed, 09 Aug 2023 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTmIi-0007Nu-Bj
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:44:48 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTmIf-0000m1-Pq
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:44:48 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bca3311b4fso8734a34.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691599484; x=1692204284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHGEfoLJ3r+HsKHJ3U7RkhjTmZ6ahM0Hd3poslJ6rOM=;
 b=ganFZ2QQEsPAtpmYk4rZ9jFrVqeKGnXHT3Z+SDW50sZ0o6Q9T9KIOb+BFVaV3PZECG
 Y4R3YRh3MoBUJcxuX+MSmb2pshm2tJc2cQStR4dloRfo/kfPZUIp6XGlW8uHvLiVXUHU
 T2hLdiCJlQIRcq8lun9w+pYYmbsa40CFPf4C/2/Fe6aZ2E2z+DJ0ysfaszjDplxCcSrp
 /Jb1QpzjcPiax8RsnpJF7ZIngf/iLswhMBFE67j5kIrHvoqQsXwYw0A/L8Gv+138JJ2O
 2/j4BbipMh/uH9VwxuOgP+jjaoJLNsDUytDZQvlA4Jl3pDE6rQP2vaRf8KWxQU8mkuOL
 pAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691599484; x=1692204284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHGEfoLJ3r+HsKHJ3U7RkhjTmZ6ahM0Hd3poslJ6rOM=;
 b=LEzL8B8K6RzfV2Ad6ZncJsRil5Hqz0ax0liCtb3Or/fwZ1Zx6kqAIVGjO+9MPnGyTK
 0y7z4qr14yYKMJkdGUnCT2DeNoo9QLHrJxQnJK9DHSsnaLyX0siwyO1aH1P98dJwC77M
 LGG/STpCCwvTHzioLHBILdnx/yO6n3KLtzYWJTfNCLwzrSmLXYVxKdnKuawLZfEO2IqM
 R/IwD9qOlQWnVmYclJWcpq8ohleYyh5Cp8yvfVSQCVYnvISaBTePF7fracADvWqiO4W/
 AhPdpqjOL0KYmvCmoLfPaoP7MqMLzKR8x2B4C5ulzzecz2PlFOo3gXycf4vPO7dUhr/O
 hLdQ==
X-Gm-Message-State: AOJu0YxJ3w1HTXjKMaEYYjBG/JfjqTrjfQZPMCyEO49Fa/GA2B32ra2x
 bEwPXGPCZzHSRCiOQ55F3djXAw==
X-Google-Smtp-Source: AGHT+IGSJK/tDra+/I0mJAxH/MA7UnCvLAPNrwTYrlVf89M8RR7hr3ho/kHbIER/mmduO86AjDzhaw==
X-Received: by 2002:a05:6830:1286:b0:6b9:4d79:e08a with SMTP id
 z6-20020a056830128600b006b94d79e08amr3591818otp.32.1691599484387; 
 Wed, 09 Aug 2023 09:44:44 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a63e501000000b00564250660f3sm8377751pgh.78.2023.08.09.09.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 09:44:43 -0700 (PDT)
Message-ID: <7cf090b3-c124-cfe2-85b7-aeccc09139db@linaro.org>
Date: Wed, 9 Aug 2023 09:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 07/11] target/i386: Add support for native library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-8-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-8-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 07:17, Yeqi Fu wrote:
> This commit introduces support for native library calls on the
> i386 target. When special instructions reserved for native calls
> are encountered, the code now performs address translation and
> generates the corresponding native call.
> 
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>   configs/targets/i386-linux-user.mak   |  1 +
>   configs/targets/x86_64-linux-user.mak |  1 +
>   target/i386/tcg/translate.c           | 27 +++++++++++++++++++++++++++
>   3 files changed, 29 insertions(+)
> 
> diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
> index 5b2546a430..2d8bca8f93 100644
> --- a/configs/targets/i386-linux-user.mak
> +++ b/configs/targets/i386-linux-user.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=i386
>   TARGET_SYSTBL_ABI=i386
>   TARGET_SYSTBL=syscall_32.tbl
>   TARGET_XML_FILES= gdb-xml/i386-32bit.xml
> +CONFIG_NATIVE_CALL=y
> diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
> index 9ceefbb615..a53b017454 100644
> --- a/configs/targets/x86_64-linux-user.mak
> +++ b/configs/targets/x86_64-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_BASE_ARCH=i386
>   TARGET_SYSTBL_ABI=common,64
>   TARGET_SYSTBL=syscall_64.tbl
>   TARGET_XML_FILES= gdb-xml/i386-64bit.xml
> +CONFIG_NATIVE_CALL=y
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 90c7b32f36..28bf4477fb 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -33,6 +33,7 @@
>   #include "helper-tcg.h"
>   
>   #include "exec/log.h"
> +#include "native/native.h"
>   
>   #define HELPER_H "helper.h"
>   #include "exec/helper-info.c.inc"
> @@ -6810,6 +6811,32 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>       case 0x1d0 ... 0x1fe:
>           disas_insn_new(s, cpu, b);
>           break;
> +    case 0x1ff:
> +        if (native_bypass_enabled()) {
> +            TCGv ret = tcg_temp_new();
> +            TCGv arg1 = tcg_temp_new();
> +            TCGv arg2 = tcg_temp_new();
> +            TCGv arg3 = tcg_temp_new();
> +            const char *fun_name = lookup_symbol((s->base.pc_next) & 0xfff);

I'm not keen on this lookup_symbol interface.
I would much rather there be some data encoded in the native.so.


> +            uintptr_t ra = GETPC();
> +            uint32_t a1 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 4, ra);
> +            uint32_t a2 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 8, ra);
> +            uint32_t a3 = cpu_ldl_data_ra(env, env->regs[R_ESP] + 12, ra);
> +            tcg_gen_movi_tl(arg1, a1);
> +            tcg_gen_movi_tl(arg2, a2);
> +            tcg_gen_movi_tl(arg3, a3);

This is wrong.  You are performing the stack load at translation time, but it must be done 
at execution time.  You need

	tcg_gen_addi_tl(arg1, cpu_regs[R_ESP], 4);  /* arg1 = esp + 4 */
	gen_op_ld_v(s, MO_UL, arg1, arg1);          /* arg1 = *arg1 */

etc.


r~

