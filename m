Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E176609C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPB5e-0008Mk-Qh; Thu, 27 Jul 2023 20:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPB5c-0008Hc-FX
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:12:16 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPB5a-0002tl-OT
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:12:16 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-38c35975545so1287468b6e.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690503133; x=1691107933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WB7bZ6q8enmhov8oSskMAuQ5HPXdeZ6/Vaftpio2EvQ=;
 b=QxQdffqtkdFCS3T+p/uhl44FqUOJ/LjLxGVcxeQNnRhYhkHWOileRMX6D6FA98EV9i
 lw2RXuQBPQt7jWkvB9S2p69FiecGJGGDgSbGZiGKXh0jykW3rc5ENtpZxOAOKMpUubKA
 DGkWa8KqZdHn9RHzfUiNlcgHACilu23/Gb8jo+8IS0OgM4hr7M9RF9S7yuLLQ7UU39Aq
 Ovvc890ihSmHZmEFWdcNeC/4ZEcv49xyOtGBgcHqbKUX9ciZUNTgVZiyA3+eoFPOgAGA
 DgefkoY4z97iK84q+Zm0wiqFVnyPbb254A8x0dmvCw2jc5/BDy/bdiBFoISp4l+8C76k
 fTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690503133; x=1691107933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WB7bZ6q8enmhov8oSskMAuQ5HPXdeZ6/Vaftpio2EvQ=;
 b=P4stzlt40MX10glcPWdmqoi3An0DCWQmGPRe0klRBkpswWhBo0Ak3LYsHPuls/SidO
 g+SEXCBZugIqZYpXbWJyyi2K3wSDh0sUFOoTO+wXDR/bD48Syt2SZegldHnbXlGpprg1
 UEicglocvZWCr8Gx/bT/sEXCQf2qECnRnKpEgcAuQPS/87PFvdeonKkBwrll3eO2USNw
 Kz5FozB4CNJdnrSi/lWl9I7FKtLiYhyXFLpEi4GUJkD8sfsFxzCqgPpj71MJ8gJvpbEr
 3meTExTxxWSt6fmkI6U5BBtlTKDJTeQuI/oKrBR/uH24cZePfCBq8lumThjv+TenPGue
 IkYw==
X-Gm-Message-State: ABy/qLZ/2BnV57/MPIE0R24KhywS7z8RuL5hMSJDCHm9G2EN6/RE7/G8
 hMWn4sa4LOSyV4yTYR/a/yrn+bBPM/me/krKqzg=
X-Google-Smtp-Source: APBJJlFBoq3pc2yHTsB8D8DUMHyGXSLKG++Vod5Q5nxT4SCL/V2DYkMwR95Pxb/hKXWUpIErGSB2dw==
X-Received: by 2002:a05:6808:1449:b0:3a1:eb47:a943 with SMTP id
 x9-20020a056808144900b003a1eb47a943mr1066838oiv.10.1690503133348; 
 Thu, 27 Jul 2023 17:12:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a638c51000000b0050f85ef50d1sm2127166pgn.26.2023.07.27.17.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 17:12:12 -0700 (PDT)
Message-ID: <1e1db540-b07e-bcae-c614-67ec6c6300f0@linaro.org>
Date: Thu, 27 Jul 2023 17:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMLfYE3fYCUhnaEE@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMLfYE3fYCUhnaEE@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/27/23 14:19, Helge Deller wrote:
> Words are stored in big endian in the guest memory for armeb.
> 
> Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with
> host atomics") switched to use qatomic_cmpxchg() to swap a word with the
> memory content, but missed to endianess-swap the oldval and newval
> values when emulating an armeb CPU.
> 
> The bug can be verified with qemu >= v7.2 on any little-endian host,
> when starting the armeb binary of the upx program, which just hangs
> without this patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
> Reported-by: John Reiser <jreiser@BitWagon.com>
> Closes: https://github.com/upx/upx/issues/687
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index a992423257..ff0bff7c63 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -117,8 +117,8 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *env)
>   {
>       uint32_t oldval, newval, val, addr, cpsr, *host_addr;
> 
> -    oldval = env->regs[0];
> -    newval = env->regs[1];
> +    oldval = tswap32(env->regs[0]);
> +    newval = tswap32(env->regs[1]);
>       addr = env->regs[2];

There's a similar bug with arm_kernel_cmpxchg64_helper just below, but

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

as far as this goes.


r~


