Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17C7246BB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xy1-0002O9-J5; Tue, 06 Jun 2023 10:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xxr-0002Le-Cc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:47:18 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Xxo-0004Zl-Ik
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:47:13 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-33d5df1a862so17816895ab.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686062831; x=1688654831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L37G/UpRFPDvK/5tOtKP8t2IzAdWmUCIXxNGGLU2uko=;
 b=T8vfjlV7OfKpPU2lmzALcSf3LInmDZEaYNKC3Brd2nwa/JH+0VJ+0wKrmgk2k/ZScN
 dW0o0oYsJxS3jOrunIG6I2JxSg3OE50zvYCM8NY/mBnxaQb/7Z1j24//G1ugfDDybuU/
 d5u39peMcgOniEzyreSxd+9hbtZB8SV7WDQD/CUSUPQHTWYePdUo4C64r0NRexTIEm0p
 ck0hdZD3wXVKXxTYfVug5/9fgcjFPM35pUoS+24C8YrkA5gFAEs1kkO9zcyJEfiTNTm5
 rMkY07AlDgza+gtYuXDVGmRUVxf0CkC4m49DrZ9E/rwwVNTTNyo2cxpHyg3yepw/ptvK
 ylYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686062831; x=1688654831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L37G/UpRFPDvK/5tOtKP8t2IzAdWmUCIXxNGGLU2uko=;
 b=DbnM0KrRWbq3LABW401nFUqi1rnGaYw1M3Gdlp1z46I+3xAsA1PlAWVKPiy6exDBe1
 6Z/x1z1IB1fp+fQR7ypyFz2Lt174tws0OU0BcmdgRb0gzLV5MTLQGciHN1DmISyRFNCB
 /1nsfWTWRw2vsdC+Gl7+VwXVMZZHkdW02eB7kmDh5S/F0t72PjVSMf/vLI4br5dVsjJy
 FucrdL2Qr/tjvHe+nA2j8hxPWl5RvEdms2p3FAZfjpg5fEF2WTGUNrPer5SHfh+20PPB
 qxJaY5V7egHkrhVZgzysmdIv+L7eEmurq8g78mWxPqFQr6TsqIXk29RC9a+7qNkIw5lm
 /hqA==
X-Gm-Message-State: AC+VfDxInp6ve9Gb9bk/a4I13C9+ukNLxS4/TfCZLEfroBFSW9J5r8/u
 BgpPfUE9cl5EZ6jfd4jjPhecpw==
X-Google-Smtp-Source: ACHHUZ4lNSJSUCYJ8ppoQ/aJqEUIQ+oGP7a8zilrzVNCr6UieZ2NoOjhr0hQhuDskc7m4vNKhynXIA==
X-Received: by 2002:a05:6e02:810:b0:33b:1da8:a7d0 with SMTP id
 u16-20020a056e02081000b0033b1da8a7d0mr3252043ilm.29.1686062831137; 
 Tue, 06 Jun 2023 07:47:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a635102000000b0053efc8ac7e9sm1880657pgb.29.2023.06.06.07.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:47:10 -0700 (PDT)
Message-ID: <690f0d7a-20e3-100e-e8b2-3228583c9bdc@linaro.org>
Date: Tue, 6 Jun 2023 07:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/9] target/i386: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
References: <20230605222420.14776-1-philmd@linaro.org>
 <20230605222420.14776-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605222420.14776-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/5/23 15:24, Philippe Mathieu-Daudé wrote:
> Since we *might* have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 5cf14311a6..750253e679 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -6915,7 +6915,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>       dc->popl_esp_hack = 0;
>       /* select memory access functions */
>       dc->mem_index = 0;
> -#ifdef CONFIG_SOFTMMU
> +#ifndef CONFIG_USER_ONLY
>       dc->mem_index = cpu_mmu_index(env, false);
>   #endif
>       dc->cpuid_features = env->features[FEAT_1_EDX];

Alternately, remove the ifdef entirely.  The code is well-defined for user-only.


r~

