Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2B07CFC32
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTki-0003A4-QO; Thu, 19 Oct 2023 10:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtTkg-00039E-09
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:11:54 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtTkd-0004M5-6s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:11:53 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so99273251fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697724709; x=1698329509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QzE8cEnCqAlO7riBcPFXNtjLLxK7HJshFyl/nicQO5E=;
 b=zlVUT5qj+mzkdO7Bi5d65WFp1IbAGMsvKCzm01GXHtL3WY1gQexl6NRR/XufVn4ZP3
 8vhckv57+jWIIMxdlTx3uz9BdeBAtVPdg2C7zXov1pnFlcWS3sw98vrMjJ74sOshG7wr
 JFHivp7wgnAbTM80Qd2LIbxtOiLA3xjhOlapqUFrzP4McMw7CGecb5wFuvKOkjf4cC8V
 uJ5qBcdG72h8Sa+7s+BSKGbPhNMY7tS+wC3pSjYGHBLccpsQns5A5U3XQSK29vs7h9aW
 D7wg8UDzhVEFGRuokt0XsdpnwbodmQMahKDGTRHZXhohJ2UxaUeSwZRTJxMOn73UG+Ir
 8p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724709; x=1698329509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QzE8cEnCqAlO7riBcPFXNtjLLxK7HJshFyl/nicQO5E=;
 b=j0obSuEXuYQx0oReUXbGg/VVsE+rFo9B7+v6a7nr0yV0EZc6J2ztl8yBe/3BIfrb9R
 b6+lUIw6+ABn0T14R6n/oe+W7NnlIy5rdDerLXXlbadfqctjZJU/wOpAmSGVBhmWpcy8
 Uyip/npaylmtrUOCD7KJ8oSk2vJwGoT1LvIA9zO5ZBN8cL0bZPCvTUWZ2dKxCTjOoAd3
 TvxebVWJR3fCoXDyAFCudqo/rDFBRWidHP7rl0Zhv3OCy37tb8f+1x0nx7tXGzLEjuE7
 DDAYBjf0MaJSetoGeA+mvRVcDDIptloQiLsg1RlIEG0Zhr1VU+yf2LhtthBaeNxsUKz1
 b0cg==
X-Gm-Message-State: AOJu0Yy5g0JHpbPTWCd9FuccRO8S1B43zT56C4oNlaivmYg16GF9JUw/
 mmqm6+cdE9xkk+DSSUJjxPlKJgvnn+l8L8IBQVddXg==
X-Google-Smtp-Source: AGHT+IHpF5lLLhWrkZwKfM+E1q/ESg/v+UFHyuWwz9YLZxpFiHY4PEiEso4BESvvqZuX3kC3WQjZuQ==
X-Received: by 2002:a2e:a40c:0:b0:2c5:31de:6c02 with SMTP id
 p12-20020a2ea40c000000b002c531de6c02mr1341302ljn.15.1697724708571; 
 Thu, 19 Oct 2023 07:11:48 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 b16-20020adfee90000000b0032d87b13240sm4571106wro.73.2023.10.19.07.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 07:11:47 -0700 (PDT)
Message-ID: <0be5ec0b-d4dc-9c14-4c2f-07e2cc79aec5@linaro.org>
Date: Thu, 19 Oct 2023 16:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/20] target/sparc: Introduce cpu_put_psr_icc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231017064109.681935-1-richard.henderson@linaro.org>
 <20231017064109.681935-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017064109.681935-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Richard,

On 17/10/23 08:40, Richard Henderson wrote:
> Isolate linux-user from changes to icc representation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h        | 1 +
>   linux-user/sparc/signal.c | 2 +-
>   target/sparc/win_helper.c | 7 ++++++-
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 758a4e8aaa..955329f6c9 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -619,6 +619,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
>   /* win_helper.c */
>   target_ulong cpu_get_psr(CPUSPARCState *env1);
>   void cpu_put_psr(CPUSPARCState *env1, target_ulong val);
> +void cpu_put_psr_icc(CPUSPARCState *env1, target_ulong val);
>   void cpu_put_psr_raw(CPUSPARCState *env1, target_ulong val);
>   #ifdef TARGET_SPARC64
>   void cpu_change_pstate(CPUSPARCState *env1, uint32_t new_pstate);
> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
> index 2be9000b9e..dfcae707e0 100644
> --- a/linux-user/sparc/signal.c
> +++ b/linux-user/sparc/signal.c
> @@ -164,7 +164,7 @@ static void restore_pt_regs(struct target_pt_regs *regs, CPUSPARCState *env)
>        */
>       uint32_t psr;
>       __get_user(psr, &regs->psr);
> -    env->psr = (psr & PSR_ICC) | (env->psr & ~PSR_ICC);

This keeps the non-PSR_ICC fields from env->psr, ...

> +    cpu_put_psr_icc(env, psr);
>   #endif
>   
>       /* Note that pc and npc are handled in the caller. */
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index 3a7c0ff943..bf2c90c780 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -67,9 +67,14 @@ target_ulong cpu_get_psr(CPUSPARCState *env)
>   #endif
>   }
>   
> -void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
> +void cpu_put_psr_icc(CPUSPARCState *env, target_ulong val)
>   {
>       env->psr = val & PSR_ICC;

... while this zeroes the non-PSR_ICC fields. Is that expected?

> +}
> +
> +void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
> +{
> +    cpu_put_psr_icc(env, val);
>   #if !defined(TARGET_SPARC64)
>       env->psref = (val & PSR_EF) ? 1 : 0;
>       env->psrpil = (val & PSR_PIL) >> 8;


