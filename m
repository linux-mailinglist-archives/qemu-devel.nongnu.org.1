Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C491A7E91B1
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:52:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DgT-0004q2-Gh; Sun, 12 Nov 2023 11:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DgK-0004pd-JP
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:51:33 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DgI-0001BP-Ur
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:51:32 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc58219376so32810745ad.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699807889; x=1700412689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFpseA08NP/0/C33Ov0lLdGQblo05aF1IRw1m9RHTpw=;
 b=U3sg/6AI2/8eFeNWONbk5COV9sfZ1SRRnrEi+i0P5FJ9eVSvRNqkICPYNHsuA7xmYG
 j4v7/LqoCA7IXGBxPPeVamiwhQgAeEjtTv485Ub/vY45mg0AbflXBGq8tAS91NO1nVbf
 gjn+PIX4Qw+B5Tcvqg771bGRjLYUMXj9gse0IWyaUbZzbJtZhb+zxryaEp5lm4MbYQgH
 B3mth7FUrKOL0tzqtwF71EAxyLTpraKf7kBfbeS12XxN3ykdftPZymPvrOlMp3oJtfFm
 /NijjHjtbvqs4AzVZkgvA26LupP+AxS4nXV1yIAd+gOacQqpswlapuAW4CfBWL1OwxPt
 KYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699807889; x=1700412689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFpseA08NP/0/C33Ov0lLdGQblo05aF1IRw1m9RHTpw=;
 b=DotCuCaw6lhFOpxjQy4g1Duf5hrBoyhJgxSXbDcBJPh7hGdVogbJPdQYtVKw9VSPxp
 XbCOLoOxuI7pyh3izq8Q4UPZYBnJqinoODTDHXfNuX+MbBnVwU9eeIp3yN0FhwKCGp1G
 iURToZxWGmiJoVuT2Z6KLTwbTKiu0I4w5K9FPaH4uA1KZZBK05TKUy7oa1tXFh6Pm2FU
 sRctQOV8RtOvow+YUkqxadB5L7RjwiCc4zaaiulSkZM5pME8nRxHitNwgjj0xgx4UI3S
 E7s+J/2esWh8lB6jphlrs462k1CbGngBSnsfPcxnZDbNItJeKoDGZvYBAZ01U+ENPZRt
 J0mw==
X-Gm-Message-State: AOJu0Yzc4R1RcvIx1z6NjYnJk8mYT1lXVl40mfwBjVRoBtFo4odIBCYT
 bbmFzuCQLzFJXIs0YAkE+jIPXxpw+yuE170hZEg=
X-Google-Smtp-Source: AGHT+IFriunOTsUgW5RAoCgS/FpMr46kqgY5hhsWlWDHU75CrmHb9QC7qCRsxZG29Qwj/IGfdReKQQ==
X-Received: by 2002:a17:902:bcc9:b0:1ca:b26a:9729 with SMTP id
 o9-20020a170902bcc900b001cab26a9729mr5037428pls.38.1699807889320; 
 Sun, 12 Nov 2023 08:51:29 -0800 (PST)
Received: from [192.168.114.227] (c-24-20-177-206.hsd1.or.comcast.net.
 [24.20.177.206]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902be0400b001c76fcccee8sm2722818pls.156.2023.11.12.08.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 08:51:28 -0800 (PST)
Message-ID: <69b0cb84-329e-4636-b7a0-24ba69fa41b7@linaro.org>
Date: Sun, 12 Nov 2023 08:51:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: xtensa: fix signal delivery in FDPIC
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
References: <20231111112252.1387418-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231111112252.1387418-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 11/11/23 03:22, Max Filippov wrote:
> In FDPIC signal handlers are passed around as FD pointers. Actual code
> address and GOT pointer must be fetched from memory by the QEMU code
> that implements kernel signal delivery functionality. This change is
> equivalent to the following kernel change:
> 9c2cc74fb31e ("xtensa: fix signal delivery to FDPIC process")
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d2796be69d7c ("linux-user: add support for xtensa FDPIC")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> index f5fb8b5cbebe..32dcfa522919 100644
> --- a/linux-user/xtensa/signal.c
> +++ b/linux-user/xtensa/signal.c
> @@ -157,6 +157,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>   {
>       abi_ulong frame_addr;
>       struct target_rt_sigframe *frame;
> +    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
> +    abi_ulong handler = 0;
> +    abi_ulong handler_fdpic_GOT = 0;
>       uint32_t ra;
>       bool abi_call0;
>       unsigned base;
> @@ -165,6 +168,17 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       frame_addr = get_sigframe(ka, env, sizeof(*frame));
>       trace_user_setup_rt_frame(env, frame_addr);
>   
> +    if (is_fdpic) {
> +        abi_ulong funcdesc_ptr = ka->_sa_handler;
> +
> +        if (get_user_ual(handler, funcdesc_ptr)
> +            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
> +            goto give_sigsegv;
> +        }
> +    } else {
> +        handler = ka->_sa_handler;
> +    }

This part is ok, with the last hunk, because it's taking care of the fd for the handler.

> @@ -185,14 +199,21 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       }
>   
>       if (ka->sa_flags & TARGET_SA_RESTORER) {
> -        ra = ka->sa_restorer;
> +        if (is_fdpic) {
> +            if (get_user_ual(ra, ka->sa_restorer)) {
> +                unlock_user_struct(frame, frame_addr, 0);
> +                goto give_sigsegv;
> +            }
> +        } else {
> +            ra = ka->sa_restorer;
> +        }

This part is questionable.  It does match the kernel, so as far as that goes,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, it does not handle the GOT register for the restorer, like we do on ARM.  That 
said, I can't find any libc sources for xtensa, or at least that aren't out of date by a 
decade, so I can't tell if libc *knows* the got register won't be loaded, and it doesn't 
matter because it only uses the sigreturn syscall.


r~

