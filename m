Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB563799E0A
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJQC-0002Am-62; Sun, 10 Sep 2023 08:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJQ8-0002AI-Vk
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:20:09 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJQ5-0002wS-LH
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 6875DCE0B2C
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19B5C433C7
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348391;
 bh=xx4yqgVn8gCVBibeH5RLR2yufk0PHXJR7PfMbMqY1sc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Y7Hrs5/3xQKtNNVYLpnIAUDP7GrvrQheJZ5G7BZ0YZwSOxubH+Qa9Y4wRea5zMDpk
 Jr4t/1ZBgU5yYwmQbgyMrl0GK3CLy6FKzHoZvOSLog7gqG/wyt/DrS08m3zeXHgtiD
 Brf42v4QSazI/ZoXHzWfgsyZTnO/aEdHWcQHHlVWHryQDMFnYjQjr3G+FJZCuyaEbc
 F6X989uWfSYZhp0U85VDC31hOkL4rjS+HOBJWyxLmXxkyVqucXCWYfeRfeEKOK/SQQ
 heOGrUYLcfOZPh9wQXk/Uo2tW+l6vfiE3pQ/jA25QZQOxXpzdv/Ch4q5OUEx6092U5
 1d0MtSA/faJtQ==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-500bbe3ef0eso4240660e87.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:19:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzShXkKyeev5r8jAfwWak2ZE/+z9PiFWTvL8KH5DTNn2Unelt/A
 FI0vYalndQ7vFyge0oSK5HX8TWGbt40FIuDOs9Y=
X-Google-Smtp-Source: AGHT+IHOsBvye3Q4eI6SJ3CfO90nOIAol9JD7vVjFaEFZwfV8z3D/gJbod/3WqhTvorOoqck3qdE0ATB/lZQKs0hEz0=
X-Received: by 2002:a05:6512:692:b0:4fb:8aca:6bb4 with SMTP id
 t18-20020a056512069200b004fb8aca6bb4mr3837033lfe.20.1694348389875; Sun, 10
 Sep 2023 05:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-2-richard.henderson@linaro.org>
In-Reply-To: <20230819010218.192706-2-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:19:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE0MBFn6=E-jvPvEALthWP4XLY2XJSH5xm+g7KhnDZhVA@mail.gmail.com>
Message-ID: <CAMj1kXE0MBFn6=E-jvPvEALthWP4XLY2XJSH5xm+g7KhnDZhVA@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] crypto: Add generic 8-bit carry-less multiply
 routines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.73.55; envelope-from=ardb@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Sat, 19 Aug 2023 at 03:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/crypto/clmul.h | 41 +++++++++++++++++++++++++++++
>  crypto/clmul.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
>  crypto/meson.build     |  9 ++++---
>  3 files changed, 107 insertions(+), 3 deletions(-)
>  create mode 100644 include/crypto/clmul.h
>  create mode 100644 crypto/clmul.c
>
> diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
> new file mode 100644
> index 0000000000..153b5e3057
> --- /dev/null
> +++ b/include/crypto/clmul.h
> @@ -0,0 +1,41 @@
> +/*
> + * Carry-less multiply operations.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2023 Linaro, Ltd.
> + */
> +
> +#ifndef CRYPTO_CLMUL_H
> +#define CRYPTO_CLMUL_H
> +
> +/**
> + * clmul_8x8_low:
> + *
> + * Perform eight 8x8->8 carry-less multiplies.
> + */
> +uint64_t clmul_8x8_low(uint64_t, uint64_t);
> +
> +/**
> + * clmul_8x4_even:
> + *
> + * Perform four 8x8->16 carry-less multiplies.
> + * The odd bytes of the inputs are ignored.
> + */
> +uint64_t clmul_8x4_even(uint64_t, uint64_t);
> +
> +/**
> + * clmul_8x4_odd:
> + *
> + * Perform four 8x8->16 carry-less multiplies.
> + * The even bytes of the inputs are ignored.
> + */
> +uint64_t clmul_8x4_odd(uint64_t, uint64_t);
> +
> +/**
> + * clmul_8x4_packed:
> + *
> + * Perform four 8x8->16 carry-less multiplies.
> + */
> +uint64_t clmul_8x4_packed(uint32_t, uint32_t);
> +
> +#endif /* CRYPTO_CLMUL_H */
> diff --git a/crypto/clmul.c b/crypto/clmul.c
> new file mode 100644
> index 0000000000..82d873fee5
> --- /dev/null
> +++ b/crypto/clmul.c
> @@ -0,0 +1,60 @@
> +/*
> + * Carry-less multiply operations.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2023 Linaro, Ltd.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "crypto/clmul.h"
> +
> +uint64_t clmul_8x8_low(uint64_t n, uint64_t m)
> +{
> +    uint64_t r = 0;
> +
> +    for (int i = 0; i < 8; ++i) {
> +        uint64_t mask = (n & 0x0101010101010101ull) * 0xff;
> +        r ^= m & mask;
> +        m = (m << 1) & 0xfefefefefefefefeull;
> +        n >>= 1;
> +    }
> +    return r;
> +}
> +
> +static uint64_t clmul_8x4_even_int(uint64_t n, uint64_t m)
> +{
> +    uint64_t r = 0;
> +
> +    for (int i = 0; i < 8; ++i) {
> +        uint64_t mask = (n & 0x0001000100010001ull) * 0xffff;
> +        r ^= m & mask;
> +        n >>= 1;
> +        m <<= 1;
> +    }
> +    return r;
> +}
> +
> +uint64_t clmul_8x4_even(uint64_t n, uint64_t m)
> +{
> +    n &= 0x00ff00ff00ff00ffull;
> +    m &= 0x00ff00ff00ff00ffull;
> +    return clmul_8x4_even_int(n, m);
> +}
> +
> +uint64_t clmul_8x4_odd(uint64_t n, uint64_t m)
> +{
> +    return clmul_8x4_even(n >> 8, m >> 8);
> +}
> +
> +static uint64_t unpack_8_to_16(uint64_t x)
> +{
> +    return  (x & 0x000000ff)
> +         | ((x & 0x0000ff00) << 8)
> +         | ((x & 0x00ff0000) << 16)
> +         | ((x & 0xff000000) << 24);
> +}
> +
> +uint64_t clmul_8x4_packed(uint32_t n, uint32_t m)
> +{
> +    return clmul_8x4_even_int(unpack_8_to_16(n), unpack_8_to_16(m));
> +}
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 5f03a30d34..9ac1a89802 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -48,9 +48,12 @@ if have_afalg
>  endif
>  crypto_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
>
> -util_ss.add(files('sm4.c'))
> -util_ss.add(files('aes.c'))
> -util_ss.add(files('init.c'))
> +util_ss.add(files(
> +  'aes.c',
> +  'clmul.c',
> +  'init.c',
> +  'sm4.c',
> +))
>  if gnutls.found()
>    util_ss.add(gnutls)
>  endif
> --
> 2.34.1
>

