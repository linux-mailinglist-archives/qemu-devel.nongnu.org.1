Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2578D64E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLYj-0007eB-JL; Wed, 30 Aug 2023 09:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLYd-0007an-4C
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:48:31 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLYa-0000te-Jz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:48:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so1939465a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693403307; x=1694008107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU+/308y5VTMBdgg9CHduPdBpFwpgai6AoFa0a5G0MI=;
 b=NtZTnInq9ElzB4rnm5Qla25YWMn97XvmmsyL+eXuR1lqcbEwgJdN2r57Lv1EVJ4xwO
 8tXnkAeirYLI3737qwNRQTEizDJbnJAc0FWCOzs4PDcHR8vno6KSVWvZq/RUFjszI8GW
 fBqFXf4om0T8dzX+E6t5FVg3j9PB3dV4b1qZUfDcF4iW+alB0pkzi+pWDsh/SsFMWadA
 Fwmoq9/bVn4l705uIIpE2tDiiIQ2c1MxNp6tzBgtixd1V0RL7FNmWc25Js7HALSmE3WY
 oViM/qU79r6XrEOOScnthXHi5OV9oSZSB8JQwCUGXCc4Wk3WPKsOJdnnDlP9P46IG+bO
 TQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693403307; x=1694008107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU+/308y5VTMBdgg9CHduPdBpFwpgai6AoFa0a5G0MI=;
 b=jfVVPFNPSSiENXGxEZT+0aBkDgTz/J4fKYKCWXM6l6zEm9nVF7C+gCucs8ZKENIVDv
 XAWAlDfqtimRofKC62hU2AFXSAFWSA4xs0nCuVMrsnTSW/oSOKabRfXvXmh2ZhA9iein
 +JFm73ewanY+Fi0UcbB6eDte37IjfLUudC6BBQ4kNOFbyWqqEOlqeaRM1K6KaAT+m/Z6
 gOo6DJK1yFVkER6WxNO69s5IB3zdtad3nItKFaTO5j6WcHfvnS5JWts3RxKGVn36ETeo
 ojzXoGX10L93ijL6/fb1IaLeoYZpNvrQe0Afb5qNVSmAgYLRL6ULHMs/cdHwwqqmjajm
 Dlwg==
X-Gm-Message-State: AOJu0YzIZs0Q03RBMXJXS2KGbbSSTHC/pUmKrLK50TDqp7XJa80VTSuY
 bVMgAacB6+TRAOQGF1HlYfLvBA==
X-Google-Smtp-Source: AGHT+IGLYurw9XN8mjNzXgEmfSUxadBZETM2/qTWlb3JkVFZ8QzhjitbnZboeDbp3dOrHDGgXGcidg==
X-Received: by 2002:a17:907:608c:b0:98e:4f1:f987 with SMTP id
 ht12-20020a170907608c00b0098e04f1f987mr6333139ejc.3.1693403306916; 
 Wed, 30 Aug 2023 06:48:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 vw7-20020a170907058700b0099b921de301sm7226047ejb.159.2023.08.30.06.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 06:48:26 -0700 (PDT)
Message-ID: <2d47dd48-7e1b-5be1-5db7-0e4a388d577e@linaro.org>
Date: Wed, 30 Aug 2023 15:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] target/i386: raise FERR interrupt with iothread locked
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20230830103141.138775-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830103141.138775-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 12:31, Paolo Bonzini wrote:
> Otherwise tcg_handle_interrupt() triggers an assertion failure:
> 
>    #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
>    #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
>    #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
>    #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
>    #9  0x00007fffa42bde14 in code_gen_buffer ()
>    #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
> Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
> Co-developed-by: Richard Henderson <richard.henderson@linaro.org>'
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/fpu_helper.c | 6 ++++++
>   target/i386/tcg/translate.c         | 8 +++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sysemu/fpu_helper.c
> index 1c3610da3b9..93506cdd94e 100644
> --- a/target/i386/tcg/sysemu/fpu_helper.c
> +++ b/target/i386/tcg/sysemu/fpu_helper.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>   #include "cpu.h"
>   #include "hw/irq.h"
>   
> @@ -31,7 +32,9 @@ void x86_register_ferr_irq(qemu_irq irq)
>   void fpu_check_raise_ferr_irq(CPUX86State *env)
>   {
>       if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
> +        qemu_mutex_lock_iothread();
>           qemu_irq_raise(ferr_irq);
> +        qemu_mutex_unlock_iothread();
>           return;
>       }
>   }
> @@ -45,6 +48,9 @@ void cpu_clear_ignne(void)
>   void cpu_set_ignne(void)
>   {
>       CPUX86State *env = &X86_CPU(first_cpu)->env;
> +
> +    assert(qemu_mutex_iothread_locked());
> +
>       env->hflags2 |= HF2_IGNNE_MASK;
>       /*
>        * We get here in response to a write to port F0h.  The chipset should
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 90c7b32f362..e0a622941cb 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -4619,7 +4619,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>                   case 0x0a: /* grp d9/2 */
>                       switch (rm) {
>                       case 0: /* fnop */
> -                        /* check exceptions (FreeBSD FPU probe) */
> +                        /*
> +                         * check exceptions (FreeBSD FPU probe)
> +                         * needs to be treated as I/O because of ferr_irq
> +                         */
> +                        translator_io_start(&s->base);

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>                           gen_helper_fwait(cpu_env);
>                           update_fip = false;
>                           break;
> @@ -5548,6 +5552,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>               (HF_MP_MASK | HF_TS_MASK)) {
>               gen_exception(s, EXCP07_PREX);
>           } else {
> +            /* needs to be treated as I/O because of ferr_irq */
> +            translator_io_start(&s->base);
>               gen_helper_fwait(cpu_env);
>           }
>           break;


