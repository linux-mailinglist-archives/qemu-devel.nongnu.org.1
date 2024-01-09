Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E78283A8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:07:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN90X-00019k-D4; Tue, 09 Jan 2024 05:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN90V-00019G-4X
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:06:51 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN90T-0001Lb-H7
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:06:50 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2295236b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 02:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704794808; x=1705399608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tebTYO6hYfdi7Pt5EGfK3bXHsJwK/j6BrXpIG6EVoMY=;
 b=GE3qWqZjVHlZNKc8FdTl01BYtysc9qoAvG1lQEEWT/1vEMoKgwRyr3nsPPxkM4SA2O
 8f2fQOsuNxahpo8uwnToayDvL5C7nH2wDyHSOj2SVjqs0bdgIdwb0sr02e/4MOe7FCtj
 1jZ45f9VlGbrN7sB1gNyTxXVy90RlS2SuKnzWBjpGMw6oVvk5lW3SvOa7RoyEQz9zuPL
 ajQUh0t+mmyOzDktfUvq5Tlna9lzJtb5P3H1VO+l3fY8YE7WcAbcjnc2OorkevTvDIYV
 d1JsDds5A7wgTm4A3MQpFdXyrgNO6sw4lLF2GNy5ObImlLFlMjoC0lewIzCtjLdyQ+XU
 t7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704794808; x=1705399608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tebTYO6hYfdi7Pt5EGfK3bXHsJwK/j6BrXpIG6EVoMY=;
 b=D/C8lP5EPCuXPwo5IgDIAClJ3FNd1fA8yieec+O+MKoI7D2CLAl2ZD3TKkRmZ/FOQY
 PSAhCuMsg5EYni0VPWPozhvFNMgWMJopf2yEkuFo55HLfMTWZ5Jx8YD5FdTvUpQznkEh
 yBTPRdz4uc7ZgRdLdEmyYls10+4AiQm4+DI3X0Pt2lC9g+8ZUu8MpPFTPPNQkztN3GDf
 57EfZV6lcxD+2RDdxuDqT0+nPve2NgMruUSJ/UolmP31nnpwMeDIRLH66jS1R1NY10SG
 fHTTHs2yzJUyF00KFBB96Xf//N/2HljI4t0WrBqba29yRU/lUvRNsDWsNoxD9qGEXty3
 StyA==
X-Gm-Message-State: AOJu0Yxu6VxW1OKIZDWz5qASh+HJW3OgeS5AUyzFS9X0uo1Y14hcshwW
 2sJt94Q3777F9pwbUW12aGAkMBy/mkB+WQ==
X-Google-Smtp-Source: AGHT+IG98+fBapMemujJ2wFrhc3aTGsDKI2mGhWJWaU4kNUrLuih/A2YY0PKTSKFylu82mWfC08a9w==
X-Received: by 2002:a05:6a00:38d2:b0:6da:d8c5:fa0d with SMTP id
 ey18-20020a056a0038d200b006dad8c5fa0dmr5039938pfb.4.1704794808160; 
 Tue, 09 Jan 2024 02:06:48 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a62d143000000b006d9a42f25b2sm1335766pfl.201.2024.01.09.02.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 02:06:47 -0800 (PST)
Message-ID: <3bbeda0e-40dc-49a6-821e-630e9576c1b1@linaro.org>
Date: Tue, 9 Jan 2024 21:06:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/hppa: Avoid accessing %gr0 when raising
 exception
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-9-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107132237.50553-9-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/8/24 00:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The value of unwind_breg may reference register %r0, but we need to avoid
> accessing gr0 directly and use the value 0 instead.
> 
> At runtime I've seen unwind_breg being zero with the Linux kernel when
> rfi is used to jump to smp_callin().
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 011b192406..42bd0063c0 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -335,7 +335,7 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
>   
>                   cpu_restore_state(cs, retaddr);
>   
> -                b = env->gr[env->unwind_breg];
> +                b = env->unwind_breg ? env->gr[env->unwind_breg] : 0;
>                   b >>= (env->psw & PSW_W ? 62 : 30);
>                   env->cr[CR_IOR] |= b << 62;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

