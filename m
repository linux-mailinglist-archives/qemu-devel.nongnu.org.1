Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6232799E14
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJUE-0004Bw-DI; Sun, 10 Sep 2023 08:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJUB-0004Be-2B
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:24:19 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJU8-0003ox-Tw
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:24:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C7CA460DBA
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341F4C433C9
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348655;
 bh=BrMVIFKgisVgQbchSZ8D+Gmg0V90oYr4BQY/jBPWxkU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D27IHS50rHkxdcmSamqjQlqIcA49yeKADfxaVQdwfDONiVmAVU5zYxljSoIVJMqoA
 mKZil2vb0s6BDrdk2NQ7bGWaDafJQ1jLsfQ84lu3KqJ1a5HaFrbNAt152fnUcOqRxI
 q+RKv9KUGQcPfNHmhGvjtBaqivapFmRCvmHfd3YilSCsOa0QDo+gdA4/YV0ONIuDIi
 8h3Q9rC6tNwYXLoJcNzDDP8lbRetgJEsXLlxf/l0sx3lF08wg/cwMBuxgNP/81i8zX
 GqJpbnSbQwGwqNbskFFk5o4/Xd/4/FxEmFZnHRZVG/6QCvl/fe5Ujkegyt7BamTpZN
 25HJxYx7w65Dw==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso59583741fa.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:24:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTrd3KWGzH5hvNeMWG3B2OSIEx4YTu8mYw3iWP9uwjKR4FGoIl
 7IKd0qI81XgsoeNgihUOwhOqfEQ4vx/kRpgKjHo=
X-Google-Smtp-Source: AGHT+IF2TaEqYUaPGvkOtpsbRHsDtwc0iJ/Yex4pylwYnwEnttXSN5uFnI/R4ZZCWTZaqLcZ7/deT3GA7x1SSk0UrQQ=
X-Received: by 2002:a2e:8907:0:b0:2b9:f1ad:9503 with SMTP id
 d7-20020a2e8907000000b002b9f1ad9503mr6487645lji.35.1694348653422; Sun, 10 Sep
 2023 05:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-10-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-10-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:24:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEnGfGLq1-b84mpubVj3fFhi99A-Y3CEwOxy46Ojew3+w@mail.gmail.com>
Message-ID: <CAMj1kXEnGfGLq1-b84mpubVj3fFhi99A-Y3CEwOxy46Ojew3+w@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] crypto: Add generic 32-bit carry-less multiply
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

Replied to v2 by accident:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>  include/crypto/clmul.h |  7 +++++++
>  crypto/clmul.c         | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
> index c7ad28aa85..0ea25a252c 100644
> --- a/include/crypto/clmul.h
> +++ b/include/crypto/clmul.h
> @@ -54,4 +54,11 @@ uint64_t clmul_16x2_even(uint64_t, uint64_t);
>   */
>  uint64_t clmul_16x2_odd(uint64_t, uint64_t);
>
> +/**
> + * clmul_32:
> + *
> + * Perform a 32x32->64 carry-less multiply.
> + */
> +uint64_t clmul_32(uint32_t, uint32_t);
> +
>  #endif /* CRYPTO_CLMUL_H */
> diff --git a/crypto/clmul.c b/crypto/clmul.c
> index 2c87cfbf8a..36ada1be9d 100644
> --- a/crypto/clmul.c
> +++ b/crypto/clmul.c
> @@ -79,3 +79,16 @@ uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
>  {
>      return clmul_16x2_even(n >> 16, m >> 16);
>  }
> +
> +uint64_t clmul_32(uint32_t n, uint32_t m32)
> +{
> +    uint64_t r = 0;
> +    uint64_t m = m32;
> +
> +    for (int i = 0; i < 32; ++i) {
> +        r ^= n & 1 ? m : 0;
> +        n >>= 1;
> +        m <<= 1;
> +    }
> +    return r;
> +}
> --
> 2.34.1
>

