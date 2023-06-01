Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3027719CD9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hvT-0005t1-LT; Thu, 01 Jun 2023 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4hvQ-0005qJ-No
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:01:08 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4hvN-00083b-PX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:01:08 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f5021faa16so956730e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685624463; x=1688216463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jf+2LrbrzbTmkdZVcT04IKm82iTnVpk5mMk8DbFhBDU=;
 b=lCLZfu35eQJ9jU1Xc3SvlozzX7Jxjj8HckNfnwRXQqOxhi6EP/zu+LWPeFRtMglajJ
 +0f9PcP8JYH3EEU0l9yvFXrY7sdvAC16Z+eHmFKj4glhp7GLcdhLcodGI+NNvp+pPaGC
 JcfNmbeQ9WF5L6U0i4UnTKycu6LPsKgEvTFURtkldZlXVW+971MxX7yIULmQAjO/Y2EI
 CX/OYOa9mc2a4S6KnpTbzuKoq3QFL43b0ZPleC7tE4izYcIcBJEi2gD1yfg1oKr5V9UW
 +xapPqigYXa5gjXGKyWI/ik5DH7zhxWCYdQIYgwCUwCOefAZlyJnAo98KRaYR7GKVNCM
 YsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685624463; x=1688216463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jf+2LrbrzbTmkdZVcT04IKm82iTnVpk5mMk8DbFhBDU=;
 b=DwiZ1DAq/VbKz5ILZkSarSrdLUbLYPJH4Ds7A9EyZv1BBaQXEX9v5N0Rsn6Rh4Q/gA
 YYxzr8KraT6Lmo8Ake3GuULEjPTHkcC4u4B3ym7xOU6WpVliy3K9Yxit6Q5o3p2jDS4D
 YmO4xkX9HhAz/kU1Rvm+HHiyB+cwwfdWnuR2SHEehVhM6yPKQgdZy01jUhG+djzulrDR
 +9tWyuXVkx5PG7ZlpzM/xJKXUAAVLbC1EZHR8aGkRXuMl0B9Ky9j9/kBJgBzOAoxKdfU
 L1zYsWsmPikcu844WZIWMkb6hVBimHZJm8xFpymWP7/lLThTI4cKkhyLjij5+r9LWXjO
 /Dnw==
X-Gm-Message-State: AC+VfDzpGIeJuK+H34YLxjnEpowgQbz7eCtFQI/6z4YXTVIiCANEfdwK
 4YE8n8Uuf0Tb4qpKwQz6+yER8LgNrkKg8IzSVQIFeQ==
X-Google-Smtp-Source: ACHHUZ685jAnGbXmsLOT2LVFmO4PsIx1cjdBpqSDXY2dgNA4g066aAiWcTXHLidY/C1FxrXP6ItWkQs3oYfC7wwQ/R0=
X-Received: by 2002:a19:f708:0:b0:4f3:b32d:f739 with SMTP id
 z8-20020a19f708000000b004f3b32df739mr1444581lfe.19.1685624463318; Thu, 01 Jun
 2023 06:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601123332.3297404-1-ardb@kernel.org>
 <20230601123332.3297404-2-ardb@kernel.org>
In-Reply-To: <20230601123332.3297404-2-ardb@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 14:00:52 +0100
Message-ID: <CAFEAcA_Z_3xNC6HjuyvRtf+s9pJjGsZeSZ87VG03J2yZZ60Wtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Use x86 intrinsics to implement PMULL.P64
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Thu, 1 Jun 2023 at 13:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  host/include/i386/host/cpuinfo.h |  1 +
>  target/arm/tcg/vec_helper.c      | 26 +++++++++++++++++++-
>  util/cpuinfo-i386.c              |  1 +
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
> index 073d0a426f31487d..cf4ced844760d28f 100644
> --- a/host/include/i386/host/cpuinfo.h
> +++ b/host/include/i386/host/cpuinfo.h
> @@ -27,6 +27,7 @@
>  #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
>  #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
>  #define CPUINFO_AES             (1u << 18)
> +#define CPUINFO_PMULL           (1u << 19)
>
>  /* Initialized with a constructor. */
>  extern unsigned cpuinfo;
> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index f59d3b26eacf08f8..fb422627588439b3 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -25,6 +25,14 @@
>  #include "qemu/int128.h"
>  #include "vec_internal.h"
>
> +#ifdef __x86_64__
> +#include "host/cpuinfo.h"
> +#include <wmmintrin.h>
> +#define TARGET_PMULL  __attribute__((__target__("pclmul")))
> +#else
> +#define TARGET_PMULL
> +#endif
> +
>  /*
>   * Data for expanding active predicate bits to bytes, for byte elements.
>   *
> @@ -2010,12 +2018,28 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
>   * Because of the lanes are not accessed in strict columns,
>   * this probably cannot be turned into a generic helper.
>   */
> -void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
> +void TARGET_PMULL HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
>  {
>      intptr_t i, j, opr_sz = simd_oprsz(desc);
>      intptr_t hi = simd_data(desc);
>      uint64_t *d = vd, *n = vn, *m = vm;
>
> +#ifdef __x86_64__
> +    if (cpuinfo & CPUINFO_PMULL) {
> +       switch (hi) {
> +       case 0:
> +               *(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x0);
> +               break;
> +       case 1:
> +               *(__m128i *)vd = _mm_clmulepi64_si128(*(__m128i *)vm, *(__m128i *)vn, 0x11);
> +               break;
> +       default:
> +               g_assert_not_reached();
> +       }
> +        return;
> +    }
> +#endif

This needs to cope with the input vectors being more than
just 128 bits wide, I think. Also you probably still
need the clear_tail() to clear any high bits of the register.

thanks
-- PMM

