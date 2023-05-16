Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32571704AE2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pys4e-00015Y-3T; Tue, 16 May 2023 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pys4b-00014S-I9
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:38:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pys4a-0003iL-2e
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:38:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96b4ed40d97so314080166b.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684233506; x=1686825506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MA77nGVbeznvJo3CFRKaUeMAlOrz/uJ33UG0RZGl2ig=;
 b=sIu1bo0Gx+eVlYvkVHEe8fI8/lDDkf503dFZ7Fq+2+z6EvLj5K7zek3gWx9zfASxYm
 uRK79C2LWl/3vnyMtThFN+Toj8n/icUg31CD+oO/I5qLORMpKE0LpyoSMx+3pNF+UZ/z
 vUB1yAaaOjVJuLzeYvzFFD1ySIc1S+nPPiX3AX5jIPy7QYdeMRxMI8/6LeC5qnStIgvL
 lMszTVIhgPE8sBJjr+5GDONZSCRVdEqNAMKBr9wiV7gWvSxVAm7nTCS1LphRVQmVYTM+
 fSGSenEmxTR9A7aYHvfNn/YIUaJsjhWk9r1jiWxpRHwPUso4szpd6+acOqXMO/tY3xOF
 MQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684233506; x=1686825506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MA77nGVbeznvJo3CFRKaUeMAlOrz/uJ33UG0RZGl2ig=;
 b=GzP0kURLHqb/lm2Fd7eMLluy5qdyZ+5P8Gy5vR6l/CUW2Bu7Cx+nbAttn0a+7A7/7G
 xvQa4XkRNbbcUQZihnov+OD18HgiM1DG3U7yDmloeX8XeR/5XBse6E5PtZj7IUUUP+cA
 gQGr30/sv9+PAHYhQeG9xgdVfkjmEx3fzFMonZ/+u+AIKpn4Q46XRZcHKoQ1+otsOqxy
 qjT3sB+u/zaPx7QmoQ8ZSRY+pJt6IxDIGufre+Inr5ayCiQ9RWysPeSdEP7bP0Gccn1Q
 KuDIFc3WQ9AHwPogu1JN+omJhcHwyIeCwtGzyb7E8HIOYYRhjvW/c5GfdctyUYUhq6Y1
 1vRw==
X-Gm-Message-State: AC+VfDyAyHVnxHA0p3KFO8akQ9b9xElZJ948jrOlsZ3wWGzzrlEqMTn/
 PG2TSddhzlvgjQ/4VkRE0ITjoVrPZTQhXOXY5bu76g==
X-Google-Smtp-Source: ACHHUZ4xD+40G/HphU4u9r9WvFYIr+uSv0HIFBWFWewZpxnPswCALxnSm+eR+iTYQ82FA2jASpgfTSCyVTq3dYg/RUU=
X-Received: by 2002:a17:907:9703:b0:966:265d:edc9 with SMTP id
 jg3-20020a170907970300b00966265dedc9mr31701470ejc.74.1684233506244; Tue, 16
 May 2023 03:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-11-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:38:15 +0100
Message-ID: <CAFEAcA_6jHw5kvqZNNR+2c_ihdPgD9d1ByBH0fNvDr6tX88jyA@mail.gmail.com>
Subject: Re: [PATCH v5 10/54] accel/tcg: Use have_atomic16 in
 ldst_atomicity.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Mon, 15 May 2023 at 15:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hosts using Intel and AMD AVX cpus are quite common.
> Add fast paths through ldst_atomicity using this.
>
> Only enable with CONFIG_INT128; some older clang versions do not
> support __int128_t, and the inline assembly won't work on structures.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/ldst_atomicity.c.inc | 76 +++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 16 deletions(-)
>
> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index dd387c9bdd..69c1c61997 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -35,6 +35,14 @@
>
>  #if defined(CONFIG_ATOMIC128)
>  # define HAVE_al16_fast    true
> +#elif defined(CONFIG_TCG_INTERPRETER)
> +/*
> + * FIXME: host specific detection for this is in tcg/$host/,
> + * but we're using tcg/tci/ instead.
> + */
> +# define HAVE_al16_fast    false
> +#elif defined(__x86_64__) && defined(CONFIG_INT128)
> +# define HAVE_al16_fast    likely(have_atomic16)
>  #else
>  # define HAVE_al16_fast    false
>  #endif
> @@ -178,6 +186,12 @@ load_atomic16(void *pv)
>
>      r.u = qatomic_read__nocheck(p);
>      return r.s;
> +#elif defined(__x86_64__) && defined(CONFIG_INT128)
> +    Int128Alias r;
> +
> +    /* Via HAVE_al16_fast, have_atomic16 is true. */
> +    asm("vmovdqa %1, %0" : "=x" (r.u) : "m" (*(Int128 *)pv));
> +    return r.s;

This is a compile-time check, so why if we can do
16-byte atomic loads would CONFIG_ATOMIC128 not be set?

>  #else
>      qemu_build_not_reached();
>  #endif
> @@ -399,6 +413,24 @@ load_atom_extract_al16_or_al8(void *pv, int s)
>          r = qatomic_read__nocheck(p16);
>      }
>      return r >> shr;
> +#elif defined(__x86_64__) && defined(CONFIG_INT128)
> +    uintptr_t pi = (uintptr_t)pv;
> +    int shr = (pi & 7) * 8;
> +    uint64_t a, b;
> +
> +    /* Via HAVE_al16_fast, have_atomic16 is true. */
> +    pv = (void *)(pi & ~7);
> +    if (pi & 8) {
> +        uint64_t *p8 = __builtin_assume_aligned(pv, 16, 8);
> +        a = qatomic_read__nocheck(p8);
> +        b = qatomic_read__nocheck(p8 + 1);
> +    } else {
> +        asm("vmovdqa %2, %0\n\tvpextrq $1, %0, %1"
> +            : "=x"(a), "=r"(b) : "m" (*(__uint128_t *)pv));
> +    }
> +    asm("shrd %b2, %1, %0" : "+r"(a) : "r"(b), "c"(shr));
> +
> +    return a;

Similarly this seems to just be an asm version of
the CONFIG_ATOMIC128 code.

thanks
-- PMM

