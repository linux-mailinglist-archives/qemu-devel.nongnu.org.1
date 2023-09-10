Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E8799E16
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJVR-0004pj-4h; Sun, 10 Sep 2023 08:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJVL-0004pM-0m
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:25:31 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJVI-0004DF-In
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 35454B80B7F
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D91C433C9
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348724;
 bh=QmiZF40GbkBh/DJBbUoo/xpmGKk1AgKRtXcbRLCN3/E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ec9EhIwH5MWGLrYWEZHo+lWKB096Qlb2djuzcM//g72bHPOo+FdfDYmgL79sXTW2D
 qooequLccsBP0HDxzEs2Ok3W/d+7xuXU4AbaRLVkCXiG+SB5md5Mi738NBzhbu1SNY
 0AkmfjbGfghzpZrbJkTmCiadiRBGJdVOvKDuHaiaWzxf6YKOTqp6ty7dt6NxE40/BM
 y3LNumyrzh50AJMhQSZakZW+qJN7hsauNX+rNM7gj61obAMad18UTcIeO08wCMtK0G
 Qj06rAg01SF22hagtXNRAT+DdDeuPtf9dIzQkgMdm3F5/cpSVH3siAFRPJ3c/Z9Fu5
 Pnzn/frYbPbLA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-502153ae36cso5558866e87.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:25:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4VNuh+ZQTLccBow+uPc4MDwH/yaV4C0ltY/ncJcy+0I0yZkoX
 0kJ76MYEnZ7ZZtLo5AtNDixD0I1eZENERwNujoY=
X-Google-Smtp-Source: AGHT+IHV8QBSwd0P1QbpuVk31CnQwArnlBmhEdbUjMu2tUz3/PeuXiMiG3hMSnucs9FAaOY2pYwYEgbR04k4HhqdcqM=
X-Received: by 2002:ac2:53ad:0:b0:500:7de4:300e with SMTP id
 j13-20020ac253ad000000b005007de4300emr4934416lfh.58.1694348723075; Sun, 10
 Sep 2023 05:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-14-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-14-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:25:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHcKzWHR=qdBZBw0RK-+zkfBF_tTQzMeENDO5d0P++PQ@mail.gmail.com>
Message-ID: <CAMj1kXEHcKzWHR=qdBZBw0RK-+zkfBF_tTQzMeENDO5d0P++PQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/19] crypto: Add generic 64-bit carry-less multiply
 routine
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

On Mon, 21 Aug 2023 at 18:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  host/include/generic/host/crypto/clmul.h | 15 +++++++++++++++
>  include/crypto/clmul.h                   | 19 +++++++++++++++++++
>  crypto/clmul.c                           | 18 ++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 host/include/generic/host/crypto/clmul.h
>
> diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
> new file mode 100644
> index 0000000000..915bfb88d3
> --- /dev/null
> +++ b/host/include/generic/host/crypto/clmul.h
> @@ -0,0 +1,15 @@
> +/*
> + * No host specific carry-less multiply acceleration.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef GENERIC_HOST_CRYPTO_CLMUL_H
> +#define GENERIC_HOST_CRYPTO_CLMUL_H
> +
> +#define HAVE_CLMUL_ACCEL  false
> +#define ATTR_CLMUL_ACCEL
> +
> +Int128 clmul_64_accel(uint64_t, uint64_t)
> +    QEMU_ERROR("unsupported accel");
> +
> +#endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
> diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
> index 0ea25a252c..c82d2d7559 100644
> --- a/include/crypto/clmul.h
> +++ b/include/crypto/clmul.h
> @@ -8,6 +8,9 @@
>  #ifndef CRYPTO_CLMUL_H
>  #define CRYPTO_CLMUL_H
>
> +#include "qemu/int128.h"
> +#include "host/crypto/clmul.h"
> +
>  /**
>   * clmul_8x8_low:
>   *
> @@ -61,4 +64,20 @@ uint64_t clmul_16x2_odd(uint64_t, uint64_t);
>   */
>  uint64_t clmul_32(uint32_t, uint32_t);
>
> +/**
> + * clmul_64:
> + *
> + * Perform a 64x64->128 carry-less multiply.
> + */
> +Int128 clmul_64_gen(uint64_t, uint64_t);
> +
> +static inline Int128 clmul_64(uint64_t a, uint64_t b)
> +{
> +    if (HAVE_CLMUL_ACCEL) {
> +        return clmul_64_accel(a, b);
> +    } else {
> +        return clmul_64_gen(a, b);
> +    }
> +}
> +
>  #endif /* CRYPTO_CLMUL_H */
> diff --git a/crypto/clmul.c b/crypto/clmul.c
> index 36ada1be9d..abf79cc49a 100644
> --- a/crypto/clmul.c
> +++ b/crypto/clmul.c
> @@ -92,3 +92,21 @@ uint64_t clmul_32(uint32_t n, uint32_t m32)
>      }
>      return r;
>  }
> +
> +Int128 clmul_64_gen(uint64_t n, uint64_t m)
> +{
> +    uint64_t rl = 0, rh = 0;
> +
> +    /* Bit 0 can only influence the low 64-bit result.  */
> +    if (n & 1) {
> +        rl = m;
> +    }
> +
> +    for (int i = 1; i < 64; ++i) {
> +        uint64_t mask = -(n & 1);
> +        rl ^= (m << i) & mask;
> +        rh ^= (m >> (64 - i)) & mask;
> +        n >>= 1;
> +    }
> +    return int128_make128(rl, rh);
> +}
> --
> 2.34.1
>

