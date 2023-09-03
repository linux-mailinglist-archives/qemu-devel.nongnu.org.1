Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD2790AFD
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcg3M-0006tH-A2; Sun, 03 Sep 2023 01:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcg3J-0006t8-Cb
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:53:41 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcg3G-0007YC-MU
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:53:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-570e005c480so273485eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693720417; x=1694325217;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQwExx+cBBr+fSeiIZNLH1/93YNMpwKfs7bmvelRVTw=;
 b=PjZDTDXK5nzo6dVcz48+mwasR4HB5v6zRpZN8he6RHai0+8re5ytmH4WOwjWotsUQd
 MG0MaRaOIwDGMMlYBfwiUvWiNfUk7Klj98tAW53VNCjMpiLU877dgqJc/payBiuaoDA4
 aJ8cxoSyBUgE+EHaoV5wrt+rUCRTNz9PYWjIqMsM82XkkDs4PMWN7Rgz1JNVaNLWtGgs
 psYwEsisVCl0BgcTZ2cpd8OxwLeymP7xkQH5aee8qTzUX79jdyoTRsB7x4s4uEeyyRKQ
 RPCdPV/A4ukpbpYyZu+/Y2L6J6oNMtY2Utvvtb3Jp5ClLmnAGXDHSrUZXu2Jv//JzClL
 jRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693720417; x=1694325217;
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQwExx+cBBr+fSeiIZNLH1/93YNMpwKfs7bmvelRVTw=;
 b=ln5o5Mf65UudA/HX8js5jK+Siwemesfh9g0pEt1jhwjGfxLB4uYJlsA7jA+FM4lm2r
 wQDScnwud72+8g4m2J19lS08bCEquXeRkqjoIczHhePN2AkUgNiAgav+GtAaRSiDfvhd
 GbE7aZWmDPQnwkfKWWHerbpPH4oh0wPhOpuO0yWynkPzyTxtRgnPsYz57U9UKVFSvtAz
 cPmNC44iXsgaEU2LFAlKr7AfXZJRbSJt2h579i8p49mCKN+1L7FMSjlFI2rvMXwjINpH
 2DTg2viE+o8A+x1FQ1LsZvMdQQMGbYGowkBuSUa4feJCDjrz2/J3lkSiLzkHdpk9x9ky
 J40g==
X-Gm-Message-State: AOJu0YwpC8jStPHlnt5MATBnPwGdVln0xBzph9kckaEoyZ+TPv3jAspG
 oc4ZzCCIe1UDoMWMwB7Wc1Sijg==
X-Google-Smtp-Source: AGHT+IFRvvXaoC1wVqnR8VcRI+fzKYZTOoa1kEF0PLrPq1RT5V5crl0/9wtfx5BYMnjtu+0l+k2zOg==
X-Received: by 2002:a05:6808:1687:b0:3a9:ba39:6d6e with SMTP id
 bb7-20020a056808168700b003a9ba396d6emr9498376oib.0.1693720417385; 
 Sat, 02 Sep 2023 22:53:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 ft17-20020a17090b0f9100b00268b9862343sm6928136pjb.24.2023.09.02.22.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 22:53:37 -0700 (PDT)
Message-ID: <ff0c7ba4-2c4f-4638-acc5-8819179da7e1@daynix.com>
Date: Sun, 3 Sep 2023 14:53:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] util: Delete checks for old host definitions
Content-Language: en-US
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20230810225922.21600-1-akihiko.odaki@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230810225922.21600-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

Can anyone have look at this?

I also have another patch similar but for thunk. It was reviewed but no 
one has made a pull request yet:
https://patchew.org/QEMU/20230808152314.102036-1-akihiko.odaki@daynix.com/

Regards,
Akihiko Odaki

On 2023/08/11 7:59, Akihiko Odaki wrote:
> IA-64 and PA-RISC host support is already removed with commit
> b1cef6d02f("Drop remaining bits of ia64 host support").
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   util/async-teardown.c |  3 ---
>   util/oslib-posix.c    | 14 ++------------
>   2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 62cdeb0f20..396963c091 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -121,10 +121,7 @@ static void *new_stack_for_clone(void)
>   
>       /* Allocate a new stack and get a pointer to its top. */
>       stack_ptr = qemu_alloc_stack(&stack_size);
> -#if !defined(HOST_HPPA)
> -    /* The top is at the end of the area, except on HPPA. */
>       stack_ptr += stack_size;
> -#endif
>   
>       return stack_ptr;
>   }
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 760390b31e..6da3cc5014 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -585,7 +585,7 @@ char *qemu_get_pid_name(pid_t pid)
>   
>   void *qemu_alloc_stack(size_t *sz)
>   {
> -    void *ptr, *guardpage;
> +    void *ptr;
>       int flags;
>   #ifdef CONFIG_DEBUG_STACK_USAGE
>       void *ptr2;
> @@ -618,17 +618,7 @@ void *qemu_alloc_stack(size_t *sz)
>           abort();
>       }
>   
> -#if defined(HOST_IA64)
> -    /* separate register stack */
> -    guardpage = ptr + (((*sz - pagesz) / 2) & ~pagesz);
> -#elif defined(HOST_HPPA)
> -    /* stack grows up */
> -    guardpage = ptr + *sz - pagesz;
> -#else
> -    /* stack grows down */
> -    guardpage = ptr;
> -#endif
> -    if (mprotect(guardpage, pagesz, PROT_NONE) != 0) {
> +    if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
>           perror("failed to set up stack guard page");
>           abort();
>       }

