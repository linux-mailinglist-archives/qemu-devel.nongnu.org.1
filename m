Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B880799E1B
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJYA-0006sW-UN; Sun, 10 Sep 2023 08:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJY9-0006s3-3E
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:28:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJY6-0004cJ-Ty
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:28:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DA45560DB7
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D64C433C9
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348901;
 bh=869VERnE3N0VctqrZkv5ZdrMJoRvYhM3ko95dCHmAyY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=AlpX+rAHRve1+vQQg/tlKtLOosZlBrmLemQZW42NK901ZhkHPQyDqo5pzG0aYJmwH
 BbWD5IdRXyckPDTwwYZsFeFddtoEw2i6CmFCScyUJ2sKeR/Qf6Q5yLeM5wv2gVGDT6
 WSq1XvEsPeGzLwZf6j551LAKR30o7BCfAeA8pAzK0Fe0AtZ2MUhLrPS9xsHVr9qs+J
 Fi68Rr5PuOxBoVkwSpfGEzz539mDXFJ0/vX8krARSFfB4/Po0F448QB2edgdnjZ+1g
 xW5DQ3jMJdK7hKq8OAbQRIzgomvWCvHgJI3jM83YgV5YBG1kqMJjNt+iPkxNLbW5s+
 2eJPmA1WAfZoQ==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2bce552508fso57963731fa.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:28:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywr9H3hKsQfQz87DMie1hXM0GoGv5js1gbr3JNoU3YsvVNwMb6a
 3AOumzRzPDYk42Oq2OXirx9I47nJ6wwaupQkOL0=
X-Google-Smtp-Source: AGHT+IGpRiACc5KUfFhsPpJ+EDoLUXhBLWB3IiJo4ejXER0oouSDFwKA32S93wd14vLz1MitO6ucsKxGq8YpBO71W1M=
X-Received: by 2002:a2e:828b:0:b0:2b1:ed29:7c47 with SMTP id
 y11-20020a2e828b000000b002b1ed297c47mr4807527ljg.8.1694348899474; Sun, 10 Sep
 2023 05:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-6-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-6-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:28:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEb_At-NwL8H0E+5Lcqg0P7sZvUV0FjDVcyOpht3N8ZmQ@mail.gmail.com>
Message-ID: <CAMj1kXEb_At-NwL8H0E+5Lcqg0P7sZvUV0FjDVcyOpht3N8ZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] crypto: Add generic 16-bit carry-less multiply
 routines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Mon, 21 Aug 2023 at 18:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/crypto/clmul.h | 16 ++++++++++++++++
>  crypto/clmul.c         | 21 +++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
> index 153b5e3057..c7ad28aa85 100644
> --- a/include/crypto/clmul.h
> +++ b/include/crypto/clmul.h
> @@ -38,4 +38,20 @@ uint64_t clmul_8x4_odd(uint64_t, uint64_t);
>   */
>  uint64_t clmul_8x4_packed(uint32_t, uint32_t);
>
> +/**
> + * clmul_16x2_even:
> + *
> + * Perform two 16x16->32 carry-less multiplies.
> + * The odd words of the inputs are ignored.
> + */
> +uint64_t clmul_16x2_even(uint64_t, uint64_t);
> +
> +/**
> + * clmul_16x2_odd:
> + *
> + * Perform two 16x16->32 carry-less multiplies.
> + * The even bytes of the inputs are ignored.

even words

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> + */
> +uint64_t clmul_16x2_odd(uint64_t, uint64_t);
> +
>  #endif /* CRYPTO_CLMUL_H */
> diff --git a/crypto/clmul.c b/crypto/clmul.c
> index 82d873fee5..2c87cfbf8a 100644
> --- a/crypto/clmul.c
> +++ b/crypto/clmul.c
> @@ -58,3 +58,24 @@ uint64_t clmul_8x4_packed(uint32_t n, uint32_t m)
>  {
>      return clmul_8x4_even_int(unpack_8_to_16(n), unpack_8_to_16(m));
>  }
> +
> +uint64_t clmul_16x2_even(uint64_t n, uint64_t m)
> +{
> +    uint64_t r = 0;
> +
> +    n &= 0x0000ffff0000ffffull;
> +    m &= 0x0000ffff0000ffffull;
> +
> +    for (int i = 0; i < 16; ++i) {
> +        uint64_t mask = (n & 0x0000000100000001ull) * 0xffffffffull;
> +        r ^= m & mask;
> +        n >>= 1;
> +        m <<= 1;
> +    }
> +    return r;
> +}
> +
> +uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
> +{
> +    return clmul_16x2_even(n >> 16, m >> 16);
> +}
> --
> 2.34.1
>

