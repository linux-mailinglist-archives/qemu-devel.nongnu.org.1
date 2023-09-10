Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7132799E0D
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJSM-0002t5-OR; Sun, 10 Sep 2023 08:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJSI-0002rR-RD
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:22:23 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJSE-0003YM-Uc
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A6E8060BA8
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16698C433CA
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348537;
 bh=wYhyFZ8UC+yUvL1vJmLSqaPxok83zTZMcBz6Jhu7rNc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SVtXMRARDtegCkalTcZkJqTkvvfA/mYLNhld5vJ+YU5RD7iavlBWLAnDHflpZGXsY
 qAO0ZrA7Wm9b9UHZkurZ1yQGQ/wDR/AuLJNrR0czh6D2JwK7OlNq9FzV55ygMGc9Dh
 4omDiKJzkPqJTZyK4VVSRIc3f6OOBmng6UvTNRL63ygPlWewsF15M8AS20meDH0ArX
 KwhTT476OH7e5gX3NclDI5FTTcg7LuaCXKqlaP32inJiPJWmfLas29h1iqvLlvY5M0
 d33IjZAeZtN5Iu9v98PrSHJ70rrXddF8TVAA4BmcfJgfG8W91IIPyQDFMWvK7JPr4i
 4/jTnJwGlSsAQ==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2bcc4347d2dso57810061fa.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:22:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzf8Ii0zos9NlOludaK4BvqGh2U5jx+ZPanC0mgSL1yQoVCzxjt
 UFn6KSqg69f96EFkP9WGdDRaBwE9ZP2dopeaIfA=
X-Google-Smtp-Source: AGHT+IFRDeZ+dcS5T8gtAZPjrtG4PYxJYTl72wYjwYp/BebFLqN5qO3Y9yXRz1knwXPTLfrhWJrYsZWdHXOCcAlpRZI=
X-Received: by 2002:a2e:3517:0:b0:2b6:e2aa:8fbc with SMTP id
 z23-20020a2e3517000000b002b6e2aa8fbcmr5509637ljz.8.1694348535281; Sun, 10 Sep
 2023 05:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-6-richard.henderson@linaro.org>
In-Reply-To: <20230819010218.192706-6-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:22:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4BuS5Og-ABMxNDUHLeJvDYt8YdunofH-FdU0DmZYg+w@mail.gmail.com>
Message-ID: <CAMj1kXH4BuS5Og-ABMxNDUHLeJvDYt8YdunofH-FdU0DmZYg+w@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] crypto: Add generic 16-bit carry-less multiply
 routines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
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

