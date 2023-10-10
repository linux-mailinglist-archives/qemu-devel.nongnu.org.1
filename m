Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDC7C0219
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqG41-0005yT-A9; Tue, 10 Oct 2023 12:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqG3y-0005xp-CJ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:58:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqG3w-0006uG-Lh
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:58:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c7373cff01so185055ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696957106; x=1697561906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7Ej2WxT7urpGSoMiUNjZN3Ad/P/DYGo4owevQYo+tU=;
 b=fGvYEH6HMaBa9xcFKzEVgPgh+HGp6b8NL0f6JGC2nGmkU4TtWYfw9i7FxYUrvuOmec
 +4wT+P0GSVwbAErMEbCy+ZoVTPQLO8v6eDcxpi/a99mY6hwNpdvn+8UdbtKGR8jMdAp4
 WM4yL0YgKmr/3Ju/hpDkj1d0ly/8HW7eMaiKDnm7EPQOL9XO37+mj6jzJHC7czK2+2ih
 4TfT4aJPnqJEEnsGgQEEBH3ZH6kKE7zDux6PJGeKFYCSdwEa9S6Co+iIEXfchyuisdfL
 Zjoe38skfr/Lz8BtwGpK2rByJointNUsggOgIzAVdhbyGjejWu+nzktgGa1R3njzpdhV
 UsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696957106; x=1697561906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7Ej2WxT7urpGSoMiUNjZN3Ad/P/DYGo4owevQYo+tU=;
 b=S7nA5P/LigFFjo8M5XzG/iLA0cs5atBD/ahLXPYo1Xif5oboKR+rzrYgWLwhfdL/pU
 4+O5ORajvxxcN29TvU2dVsgGUTn4lPGHSAnqGv89wKL/Fzie0WnkQpOgPL+wsBWJc3+w
 Vt8SPK/0g2JSmo+DFXwLj/9jD9nQgK4P+BeI2e6YXU1m8R0MlXIViZI4OA9PrxNUP4PR
 IM7wFqD4UnbtFmZxAi0ZW/8QrP/HRbb1LR9eVV1nBL2jvnzzcxqV/xwdAaHW+g7Cnbzw
 Y05DKMSrr5E+iKe7vs7R988VOk6R7GeMOXyXqyTIecDRB4llH0nTjOJNWdWXeGxalu+R
 oGVw==
X-Gm-Message-State: AOJu0YyJlccyowEhk/sGtVGcJm2GzRxQazkee+jEBAfLgE4WM1LrkEbX
 PmgIbgfVy3vapwvMQZvykpqmRQ==
X-Google-Smtp-Source: AGHT+IHRGUgZ+g+3pHEdRkuvmleMhIu1MryFHx9a8YItxUSUJsLHAOnzqB9SCKfWe1hfcyiBn1w7JQ==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id
 k4-20020a170902c40400b001c99fa6ce5bmr8454948plk.16.1696957106056; 
 Tue, 10 Oct 2023 09:58:26 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 jb13-20020a170903258d00b001bc21222e34sm1850919plb.285.2023.10.10.09.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:58:25 -0700 (PDT)
Message-ID: <22c8b7c1-d8ef-4eea-9431-d1ad3cbb681d@linaro.org>
Date: Tue, 10 Oct 2023 09:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Clean up global variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20231009092434.50356-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231009092434.50356-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/9/23 02:24, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    target/sparc/translate.c:2823:66: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
>                                                                     ^
>    include/tcg/tcg.h:579:17: note: previous declaration is here
>    extern TCGv_env tcg_env;
>                    ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index f92ff80ac8..26ed371109 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2820,19 +2820,19 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> -static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
> +static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env env)


Better to eliminate the argument entirely...

>   {
>       TCGv_i32 r_tl = tcg_temp_new_i32();
>   
>       /* load env->tl into r_tl */
> -    tcg_gen_ld_i32(r_tl, tcg_env, offsetof(CPUSPARCState, tl));
> +    tcg_gen_ld_i32(r_tl, env, offsetof(CPUSPARCState, tl));

... so that this *does* reference the global.


r~

