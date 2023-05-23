Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4270E191
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UjD-0001st-AU; Tue, 23 May 2023 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UjA-0001sk-W9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:19:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uj9-0005qu-Ep
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:19:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f41dceb93bso501115e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858750; x=1687450750;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/I2HAQRfDM7x38B/NHIzvq/ic7efyuJLQuZxgm28YTg=;
 b=hO+UhKictDzaQDxPiol/WJrXntfipsA0v/4RmatfbRlTPQqeRQCZdQA0BiAYwlJoYL
 uSyRczbEMl5BVBCMQyUwo2Y6bFuWgVYzZEa5yIKpRkRBieXbKTZjOMPNRSOgZJoihX7A
 xN0gCA3znGc9Vp+w4/cCulknz351Ol1ygm27K/UUnanbkAkGxVqLflcmjDlDIr4vfYkh
 tCh4rJFoCahHd/KzGJNp4w0rX0DGtYB9GSNxmjKq3OYPUeIkXFwaMW976xoothB2qj+l
 elw2os3Z7jA71aYQEZY0WKeWI5nhialHDLlPn9yIeA5dnutiYGbn+dvZNrxWwTziYYah
 3v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858750; x=1687450750;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/I2HAQRfDM7x38B/NHIzvq/ic7efyuJLQuZxgm28YTg=;
 b=eSE1/CVaI6bULDkv6s4u/XAZlE/9P0McGw3k5Xhf/OEJQ6SoU/FlE1zcA1KcCEWlxo
 dn4lNBjqGuiAwXjwnesfNxSJqt942QMgmUWf8VhL3k+MUAXuzCHJ58D7fhgIdCg7Q+Xp
 cHWor9e4s4dAWw7FwL4bqkqaMYpMgn6thYnkpYFvregOhNVuLZONST0FY7yvCOl9InLH
 jFECKRGIlTqrncReGitvoTYhP7Yq5M0vKru9Cq6as+ReTmr1y+0gggr40ThdoUX+kbHb
 Tn1gdCGDZk7Gg5Fsabcqp8+yHAKZo30OM5KAgdJN9MDqGy5b8R7MIlaJbWdOIUgq7M0s
 SfSg==
X-Gm-Message-State: AC+VfDwhpeNg8xm8BO4+Y5o5cIvn3A4EcrVQVKvzlI68vndVD/s8/k82
 r+MRSpxx/mRZh5NMm1RMWoos/w==
X-Google-Smtp-Source: ACHHUZ7v3l6ay9ax9iOOw2lYkP6zZ0toAZFaa07mQy3l4957JsbbR14KHwPw/LN1Hx83T3LK+VTsJg==
X-Received: by 2002:a5d:5589:0:b0:306:2c01:4f08 with SMTP id
 i9-20020a5d5589000000b003062c014f08mr10867905wrv.21.1684858749640; 
 Tue, 23 May 2023 09:19:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m13-20020adfe94d000000b002fda1b12a0bsm11770803wrn.2.2023.05.23.09.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:19:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF131FFBB;
 Tue, 23 May 2023 17:19:08 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-6-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/27] util/bufferiszero: Use i386 host/cpuinfo.h
Date: Tue, 23 May 2023 17:18:29 +0100
In-reply-to: <20230523134733.678646-6-richard.henderson@linaro.org>
Message-ID: <875y8j2f7n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Use cpuinfo_init() during init_accel(), and the variable cpuinfo
> during test_buffer_is_zero_next_accel().  Adjust the logic that
> cycles through the set of accelerators for testing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/bufferiszero.c | 126 ++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 81 deletions(-)
>
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 1886bc5ba4..d3c14320ef 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
<snip>
> +static unsigned __attribute__((noinline))
> +select_accel_cpuinfo(unsigned info)
>  {
> -    bool (*fn)(const void *, size_t) =3D buffer_zero_int;
> -    if (cache & CACHE_SSE2) {
> -        fn =3D buffer_zero_sse2;
> -        length_to_accel =3D 64;
> -    }
> -#ifdef CONFIG_AVX2_OPT
> -    if (cache & CACHE_SSE4) {
> -        fn =3D buffer_zero_sse4;
> -        length_to_accel =3D 64;
> -    }
> -    if (cache & CACHE_AVX2) {
> -        fn =3D buffer_zero_avx2;
> -        length_to_accel =3D 128;
> -    }
> -#endif
> +    static const struct {
> +        unsigned bit;
> +        unsigned len;
> +        bool (*fn)(const void *, size_t);
> +    } all[] =3D {
>  #ifdef CONFIG_AVX512F_OPT
> -    if (cache & CACHE_AVX512F) {
> -        fn =3D buffer_zero_avx512;
> -        length_to_accel =3D 256;
> -    }
> +        { CPUINFO_AVX512F, 256, buffer_zero_avx512 },
>  #endif
> -    buffer_accel =3D fn;
> +#ifdef CONFIG_AVX2_OPT
> +        { CPUINFO_AVX2,    128, buffer_zero_avx2 },
> +        { CPUINFO_SSE4,     64, buffer_zero_sse4 },
> +#endif
> +        { CPUINFO_SSE2,     64, buffer_zero_sse2 },
> +        { CPUINFO_ALWAYS,    0, buffer_zero_int },
> +    };
> +

Arguably we could have a brief one liner saying table in order of
preference.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

