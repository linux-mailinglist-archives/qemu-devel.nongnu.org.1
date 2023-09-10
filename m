Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B3799E18
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 14:26:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfJW9-0005Yv-9C; Sun, 10 Sep 2023 08:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJW6-0005YA-T8
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:26:18 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qfJW4-0004OO-Ft
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 08:26:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AF0D660C35
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E1C433C7
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694348775;
 bh=gMPYe2PWFzZFE39kUSu/9xTFMSl48ojvuCxYN1J9Zbg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PEmhPzwVJPaCBAOGOhNxYYre7wk/sppOB6PIhu0cAUjiYx8EC6pwsQRJD41V0ejwN
 kRcy9AXUBlSyy2mD5bjqXFIIhwYsFru91QrI/AunDCczJMGGFn+CUO4SH+DeFvaJwl
 U/PphLmKpEVwySFtpSt6TktigGUBZzayvCgecBgRI2GOzrVxdSHgWa95VVeRGPY0rn
 EHb5mrzsAxHILtNGqmjZQ3zShtyJwNxnqy1w7wIZvG8rdsKFuzztqD31c1u9L3FZ6c
 fYzj2ePKH+75nf1pwb1HeENGTxJ+coCmgUZNTdJFWIQYCkKcKKTSckKst3X6qYKipf
 jIP2tcIKcuZzA==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso57314311fa.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 05:26:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGClZMcnLkcmjtdmydAk4epqA4x/wZx3KD2GOzH6Snt1ORv72f
 qN+8YboIcHjbtLkxO1kEXd1Xv1mayvuvDYqyxRM=
X-Google-Smtp-Source: AGHT+IGrVPejALYuieztw6W5skmPzBlRSX9tblsPQkEkwWnwrc6quMmC5BEN+08pnGos3nXLg1zwM3R6qwQh4iyax5U=
X-Received: by 2002:a2e:321a:0:b0:2bb:a28b:58e1 with SMTP id
 y26-20020a2e321a000000b002bba28b58e1mr5521567ljy.41.1694348773353; Sun, 10
 Sep 2023 05:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-19-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-19-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Sep 2023 14:26:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG3nBMhiZuGK-BcHNJC50ik2MkSuB04w4yuzGLEaorPbQ@mail.gmail.com>
Message-ID: <CAMj1kXG3nBMhiZuGK-BcHNJC50ik2MkSuB04w4yuzGLEaorPbQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/19] host/include/i386: Implement clmul.h
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

On Mon, 21 Aug 2023 at 18:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Detect PCLMUL in cpuinfo; implement the accel hook.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  host/include/i386/host/cpuinfo.h        |  1 +
>  host/include/i386/host/crypto/clmul.h   | 29 +++++++++++++++++++++++++
>  host/include/x86_64/host/crypto/clmul.h |  1 +
>  include/qemu/cpuid.h                    |  3 +++
>  util/cpuinfo-i386.c                     |  1 +
>  5 files changed, 35 insertions(+)
>  create mode 100644 host/include/i386/host/crypto/clmul.h
>  create mode 100644 host/include/x86_64/host/crypto/clmul.h
>
> diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
> index 073d0a426f..7ae21568f7 100644
> --- a/host/include/i386/host/cpuinfo.h
> +++ b/host/include/i386/host/cpuinfo.h
> @@ -27,6 +27,7 @@
>  #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
>  #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
>  #define CPUINFO_AES             (1u << 18)
> +#define CPUINFO_PCLMUL          (1u << 19)
>
>  /* Initialized with a constructor. */
>  extern unsigned cpuinfo;
> diff --git a/host/include/i386/host/crypto/clmul.h b/host/include/i386/host/crypto/clmul.h
> new file mode 100644
> index 0000000000..dc3c814797
> --- /dev/null
> +++ b/host/include/i386/host/crypto/clmul.h
> @@ -0,0 +1,29 @@
> +/*
> + * x86 specific clmul acceleration.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef X86_HOST_CRYPTO_CLMUL_H
> +#define X86_HOST_CRYPTO_CLMUL_H
> +
> +#include "host/cpuinfo.h"
> +#include <immintrin.h>
> +
> +#if defined(__PCLMUL__)
> +# define HAVE_CLMUL_ACCEL  true
> +# define ATTR_CLMUL_ACCEL
> +#else
> +# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
> +# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
> +#endif
> +
> +static inline Int128 ATTR_CLMUL_ACCEL
> +clmul_64_accel(uint64_t n, uint64_t m)
> +{
> +    union { __m128i v; Int128 s; } u;
> +
> +    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
> +    return u.s;
> +}
> +
> +#endif /* X86_HOST_CRYPTO_CLMUL_H */
> diff --git a/host/include/x86_64/host/crypto/clmul.h b/host/include/x86_64/host/crypto/clmul.h
> new file mode 100644
> index 0000000000..f25eced416
> --- /dev/null
> +++ b/host/include/x86_64/host/crypto/clmul.h
> @@ -0,0 +1 @@
> +#include "host/include/i386/host/crypto/clmul.h"
> diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
> index 35325f1995..b11161555b 100644
> --- a/include/qemu/cpuid.h
> +++ b/include/qemu/cpuid.h
> @@ -25,6 +25,9 @@
>  #endif
>
>  /* Leaf 1, %ecx */
> +#ifndef bit_PCLMUL
> +#define bit_PCLMUL      (1 << 1)
> +#endif
>  #ifndef bit_SSE4_1
>  #define bit_SSE4_1      (1 << 19)
>  #endif
> diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
> index 3a7b7e0ad1..36783fd199 100644
> --- a/util/cpuinfo-i386.c
> +++ b/util/cpuinfo-i386.c
> @@ -39,6 +39,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>          info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
>          info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
>          info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
> +        info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
>
>          /* Our AES support requires PSHUFB as well. */
>          info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
> --
> 2.34.1
>

