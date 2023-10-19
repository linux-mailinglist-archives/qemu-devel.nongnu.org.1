Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6C7CEE76
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 05:36:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtJod-0002qe-AV; Wed, 18 Oct 2023 23:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJob-0002qM-EZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:35:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtJoY-0006qP-U4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 23:35:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d4372322aso3818068a91.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697686513; x=1698291313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XxYUoOFyAJNHyVXhNR6HdTghDr/N0IJWKv1SyyBKg9E=;
 b=NUurRsoR3H6q9yHK/6d881L3PyOR0GZ0iNhU1Xr1KJh1x9KjIPGJjwXCQGhkdsQSJb
 urQEyHQtdXIIxpBZVm/svARbiJbsQVmUQ9mOZ2ssacundFtycckXYMSNLH1c9OwZbLYu
 fMU/ExC04KHQOcXL5WuuyaWoT8HVbypJHajOUKiBHQnwB8H/rvDb7ZxxQtIUNmeI6hF2
 YTk3wb1nHdVY3oYGJoaoFulSaCoa4qKbHAvCSjMb0yfvLDQH/J50hiwbQOgCqR5shGPD
 v5BIdpWcXWGiRHKmfbRRmPMFkwNM3+imiwRefN08BKu/jCsapTpCdgUccnNP1lizoS/r
 GH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697686513; x=1698291313;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XxYUoOFyAJNHyVXhNR6HdTghDr/N0IJWKv1SyyBKg9E=;
 b=TjmW19tVj6kMX49cQWmnOOFxXnsbuvGN01tJrxRT1dP0wAkVhUXbi//yeJvjxhLYaI
 U/1aIQ/6iL4/iydSUXBdjYKS8HYt3/cn+H0PH5Pb1npW3FDt4MiUrDa/3l+LHVfJxLKS
 00jfqjt/T0DcC6Qygi0dVaDiPzzX/ImMv16O1ZSx/CNd3Acsk0Bexc4uchQhYO9jk9TX
 EJUVlgTIFcDd7P0Y+V77RK8xohk9gOVBDUiWduXYwBg0nW8c+P2q4F92Q2TXmdgDboHg
 lo+8bwC4VV1sPpnNSS6l4B41ckWlbb3uTeQL4hDk052BLPXTS1CevjJzK/Jn6xf8SvZt
 A0Cw==
X-Gm-Message-State: AOJu0YwOnIZicvJoVuQ4VxZkQpX8ZT+qyew1ho/oRauKHPy/evo2GyBs
 EwvksGI4puQpujJAVOZ7pvZrX1DikD9hdJYHoh0=
X-Google-Smtp-Source: AGHT+IFPovUR3NjkMCMTEaGgr6uJ2kcA0+px/Oku0Y+lAaYNgXphsxoPoMpUNoDuh1GC64Jydr0Siw==
X-Received: by 2002:a17:90b:3d84:b0:27d:b488:92ee with SMTP id
 pq4-20020a17090b3d8400b0027db48892eemr1010911pjb.2.1697686512933; 
 Wed, 18 Oct 2023 20:35:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a17090acc0c00b0027d12b1e29dsm623740pju.25.2023.10.18.20.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 20:35:12 -0700 (PDT)
Message-ID: <546ec2af-08be-4fb6-b745-e4ba4d4b91a8@linaro.org>
Date: Wed, 18 Oct 2023 20:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/i386: split eflags computation out of
 gen_compute_eflags
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-14-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> The new x86 decoder wants to compute EFLAGS before writeback, which
> can be an issue for some instructions such as ARPL.  Extract code
> to compute the EFLAGS without clobbering CC_SRC, in case the ARPL
> memory write causes a fault.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index e13bf7df591..2da7c357cdc 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -872,18 +872,20 @@ static void gen_op_update_neg_cc(DisasContext *s)
>       tcg_gen_movi_tl(s->cc_srcT, 0);
>   }
>   
> -/* compute all eflags to cc_src */
> -static void gen_compute_eflags(DisasContext *s)
> +/* compute all eflags to reg */
> +static void gen_mov_eflags(DisasContext *s, TCGv reg)
>   {
>       TCGv zero, dst, src1, src2;
>       int live, dead;
>   
>       if (s->cc_op == CC_OP_EFLAGS) {
> +        if (reg != cpu_cc_src) {
> +            tcg_gen_mov_tl(reg, cpu_cc_src);
> +        }

tcg_gen_mov_tl already takes care of eliding the nop move.

>           return;
>       }
>       if (s->cc_op == CC_OP_CLR) {
> -        tcg_gen_movi_tl(cpu_cc_src, CC_Z | CC_P);
> -        set_cc_op(s, CC_OP_EFLAGS);
> +        tcg_gen_movi_tl(reg, CC_Z | CC_P);
>           return;
>       }
>   
> @@ -909,7 +911,13 @@ static void gen_compute_eflags(DisasContext *s)
>       }
>   
>       gen_update_cc_op(s);
> -    gen_helper_cc_compute_all(cpu_cc_src, dst, src1, src2, cpu_cc_op);
> +    gen_helper_cc_compute_all(reg, dst, src1, src2, cpu_cc_op);
> +}

You don't want to gen_update_cc_op.
I think you want

     TCGv_i32 cc_op = cpu_cc_op;
     if (s->cc_op != CC_OP_DYNAMIC)
         cc_op = tcg_constant_i32(s->cc_op);
     gen_helper_cc_compute_all(..., cc_op);

No write to cpu_cc_op required at all, since...

> +/* compute all eflags to cc_src */
> +static void gen_compute_eflags(DisasContext *s)
> +{
> +    gen_mov_eflags(s, cpu_cc_src);
>       set_cc_op(s, CC_OP_EFLAGS);
>   }

... this will modify it again anyway.


r~


