Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFECA799E19
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJXJ-0006Ey-4H; Sun, 10 Sep 2023 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJXG-0006Eh-RC
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:27:30 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJXE-0004WR-Cm
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:27:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DEE3CB80A08
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67CEC433C7
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348845;
 bh=0/vMUz9aI/htueuYXnLkaLsf+pwhctfk9EfjYf2sagQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SXX4LrXiCoW+aWqWC3l8vYNEd/hR4Rgvib4bc3sQD0ElB/BTKB4WhK1f1pNwTM6Dt
 27ytiYT0KZG2AAzrGjyPMf65phXygAzXFOAO9eNqgNfGKjWWEE9qlNsXD6ThOLgxkb
 42CMkGQ7suPNPKE4fh29gv5JbHbZah7PFl7nHZOWeiBbpOKTfrayJr9c3KuSL24NM7
 9gkt9QakndxlZKrtNrHjmRgX53ecL931hU7QBvxMZhjshJFGhxWJkeafV/t/pe/DUh
 QzBL3b1UZ8qPVglOOChnPDm9gmkmP/Hp1+MygoWActxcP1g/oSGZI67EzBCZOThEzp
 Pb0QYHf9Nsdrg==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-501eec0a373so5625503e87.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:27:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZ0RVb2c1961eBMZh+8WEmftSeIlL61bvlHG0STb6Pxz89JIQQ
 5F8MozUyqrGA2ceyjlQD1ZmHGpmyxU6RZdVIYBM=
X-Google-Smtp-Source: AGHT+IEl4YPJuQ/YAfTzqurpBgnAOGcVq0jJ0Dni3CdlMf8aUC4t6wOafwAe6nGD2kR3Y8Kpb6dJlYwRRsCEr4LjjKM=
X-Received: by 2002:a05:6512:6c3:b0:502:adbb:f9db with SMTP id
 u3-20020a05651206c300b00502adbbf9dbmr3314479lff.65.1694348843906; Sun, 10 Sep
 2023 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-2-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-2-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:27:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpObFh0ZE3PHcJ9QbmNOq=tOrJ+GV041ioqi6bLBCtmw@mail.gmail.com>
Message-ID: <CAMj1kXHpObFh0ZE3PHcJ9QbmNOq=tOrJ+GV041ioqi6bLBCtmw@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] crypto: Add generic 8-bit carry-less multiply
 routines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.68.75; envelope-from=ardb@kernel.org;
 helo=ams.source.kernel.org
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

On Mon, 21 Aug 2023 at 18:18, Richard Henderson
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

