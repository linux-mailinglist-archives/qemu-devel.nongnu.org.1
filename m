Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C385C745BE1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIMd-00044a-2f; Mon, 03 Jul 2023 08:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qGIMa-000441-ST
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 08:09:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qGIMU-0005HY-UW
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 08:09:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143798f542so955271f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688386136; x=1690978136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4iet2pru+RZn3tUf33NEcOEB75XNKhB4/wAn7mo+js=;
 b=X6LIHi5FshM+44n5L86wkJ3n4xXEC1k2KNtSMofH+Id7Ue9MrQHGUElTJ3DFrHM3c0
 zOf6MANbhtNFWc3dsW3icIL3EixVFme//19KSeV7LTZNW1orCje+/gufdOcfo4Bw6/zR
 E7+TyMujMSOTIE8ZIq7krV2FsVqyz7SAlssikhN9uzRhTB9YZOidtET6mWMoIG3bWMSY
 mcGkV71euLjtb9HLsgR0/VIvbXCFfor3d1kJHNzvKR6O5TxvQVEVDzq32K4dZ4twq14E
 fVs73lkgkN5P3HFt7K+F5LT5P/ZGwaCQBzFnd3H4GcCAzo8eN1YEPHpIV2tB8cBRuG55
 xW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688386136; x=1690978136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4iet2pru+RZn3tUf33NEcOEB75XNKhB4/wAn7mo+js=;
 b=BmQOWgQvhkdXSDZLNM6vdMdb22dpJOw1prSTbUIhnnRds3DYXdufdsKsZ6nEPCIChC
 j0qMKOBiUqc6TBU4u4rD19eWsu5+PGxR8+EZnH2lngSv9Lvct3AG+EMwM1iVVOxPREUr
 hieAWYyleh3JoRbATU/QlVdd/gs4NuvImV4Bp6nZzhyB8f7i1cxjW3vcmQVAlQ3G9/ew
 zWBEESRysP9oCVJXbjkUg8pLaI69JVD/y7aWT/lVbQvxL83Q8QJ3wYrc9AjdDSPSduD6
 NuA+/hYi8T+yNTl+6+acxDHuZXUnY6gmQhg95JFGlXKEElRcTr4NWq0JhIWvHzOho9X4
 TntQ==
X-Gm-Message-State: ABy/qLaEl5R3lPwHuzrwk7q/9fjzMe4jxBLkfXYwX63VC2O549n35ejp
 qetrWoh1WIqXw+MYGtETe3iB1dk8osf5IiI+IWOIJQ==
X-Google-Smtp-Source: APBJJlGwHPClRqn+oAio4X1aDsNOBI9A9Iq2eEHoyvskZIux00VCmwjx+NgoD5LHvDqCEekkmEP99hYfLpyhAqMPeik=
X-Received: by 2002:adf:fd51:0:b0:311:1a45:3606 with SMTP id
 h17-20020adffd51000000b003111a453606mr8720058wrs.30.1688386136495; Mon, 03
 Jul 2023 05:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-3-richard.henderson@linaro.org>
In-Reply-To: <20230703100520.68224-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 3 Jul 2023 14:08:41 +0200
Message-ID: <CAEg0e7hqkof1N9ymmkopPpEP8P+cnUJ=qr365dxHgUQaRPvvgQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/37] tests/multiarch: Add test-aes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 pbonzini@redhat.com, eduardo@habkost.net, alistair.francis@wdc.com, 
 danielhb413@gmail.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 3, 2023 at 12:07=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use a shared driver and backends for i386, aarch64, ppc64, riscv64.
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/test-aes.c            |  58 ++++++++
>  tests/tcg/i386/test-aes.c               |  68 +++++++++
>  tests/tcg/ppc64/test-aes.c              | 116 +++++++++++++++
>  tests/tcg/riscv64/test-aes.c            |  76 ++++++++++
>  tests/tcg/multiarch/test-aes-main.c.inc | 183 ++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target       |   4 +
>  tests/tcg/i386/Makefile.target          |   4 +
>  tests/tcg/ppc64/Makefile.target         |   1 +
>  tests/tcg/riscv64/Makefile.target       |  13 ++
>  9 files changed, 523 insertions(+)
>  create mode 100644 tests/tcg/aarch64/test-aes.c
>  create mode 100644 tests/tcg/i386/test-aes.c
>  create mode 100644 tests/tcg/ppc64/test-aes.c
>  create mode 100644 tests/tcg/riscv64/test-aes.c
>  create mode 100644 tests/tcg/multiarch/test-aes-main.c.inc
>
> diff --git a/tests/tcg/aarch64/test-aes.c b/tests/tcg/aarch64/test-aes.c
> new file mode 100644
> index 0000000000..2cd324f09b
> --- /dev/null
> +++ b/tests/tcg/aarch64/test-aes.c
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "../multiarch/test-aes-main.c.inc"
> +
> +bool test_SB_SR(uint8_t *o, const uint8_t *i)
> +{
> +    /* aese also adds round key, so supply zero. */
> +    asm("ld1 { v0.16b }, [%1]\n\t"
> +        "movi v1.16b, #0\n\t"
> +        "aese v0.16b, v1.16b\n\t"
> +        "st1 { v0.16b }, [%0]"
> +        : : "r"(o), "r"(i) : "v0", "v1", "memory");
> +    return true;
> +}
> +
> +bool test_MC(uint8_t *o, const uint8_t *i)
> +{
> +    asm("ld1 { v0.16b }, [%1]\n\t"
> +        "aesmc v0.16b, v0.16b\n\t"
> +        "st1 { v0.16b }, [%0]"
> +        : : "r"(o), "r"(i) : "v0", "memory");
> +    return true;
> +}
> +
> +bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    return false;
> +}
> +
> +bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
> +{
> +    /* aesd also adds round key, so supply zero. */
> +    asm("ld1 { v0.16b }, [%1]\n\t"
> +        "movi v1.16b, #0\n\t"
> +        "aesd v0.16b, v1.16b\n\t"
> +        "st1 { v0.16b }, [%0]"
> +        : : "r"(o), "r"(i) : "v0", "v1", "memory");
> +    return true;
> +}
> +
> +bool test_IMC(uint8_t *o, const uint8_t *i)
> +{
> +    asm("ld1 { v0.16b }, [%1]\n\t"
> +        "aesimc v0.16b, v0.16b\n\t"
> +        "st1 { v0.16b }, [%0]"
> +        : : "r"(o), "r"(i) : "v0", "memory");
> +    return true;
> +}
> +
> +bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    return false;
> +}
> +
> +bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    return false;
> +}
> diff --git a/tests/tcg/i386/test-aes.c b/tests/tcg/i386/test-aes.c
> new file mode 100644
> index 0000000000..199395e6cc
> --- /dev/null
> +++ b/tests/tcg/i386/test-aes.c
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "../multiarch/test-aes-main.c.inc"
> +#include <immintrin.h>
> +
> +static bool test_SB_SR(uint8_t *o, const uint8_t *i)
> +{
> +    __m128i vi =3D _mm_loadu_si128((const __m128i_u *)i);
> +
> +    /* aesenclast also adds round key, so supply zero. */
> +    vi =3D _mm_aesenclast_si128(vi, _mm_setzero_si128());
> +
> +    _mm_storeu_si128((__m128i_u *)o, vi);
> +    return true;
> +}
> +
> +static bool test_MC(uint8_t *o, const uint8_t *i)
> +{
> +    return false;
> +}
> +
> +static bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t=
 *k)
> +{
> +    __m128i vi =3D _mm_loadu_si128((const __m128i_u *)i);
> +    __m128i vk =3D _mm_loadu_si128((const __m128i_u *)k);
> +
> +    vi =3D _mm_aesenc_si128(vi, vk);
> +
> +    _mm_storeu_si128((__m128i_u *)o, vi);
> +    return true;
> +}
> +
> +static bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
> +{
> +    __m128i vi =3D _mm_loadu_si128((const __m128i_u *)i);
> +
> +    /* aesdeclast also adds round key, so supply zero. */
> +    vi =3D _mm_aesdeclast_si128(vi, _mm_setzero_si128());
> +
> +    _mm_storeu_si128((__m128i_u *)o, vi);
> +    return true;
> +}
> +
> +static bool test_IMC(uint8_t *o, const uint8_t *i)
> +{
> +    __m128i vi =3D _mm_loadu_si128((const __m128i_u *)i);
> +
> +    vi =3D _mm_aesimc_si128(vi);
> +
> +    _mm_storeu_si128((__m128i_u *)o, vi);
> +    return true;
> +}
> +
> +static bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint=
8_t *k)
> +{
> +    return false;
> +}
> +
> +static bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint=
8_t *k)
> +{
> +    __m128i vi =3D _mm_loadu_si128((const __m128i_u *)i);
> +    __m128i vk =3D _mm_loadu_si128((const __m128i_u *)k);
> +
> +    vi =3D _mm_aesdec_si128(vi, vk);
> +
> +    _mm_storeu_si128((__m128i_u *)o, vi);
> +    return true;
> +}
> diff --git a/tests/tcg/ppc64/test-aes.c b/tests/tcg/ppc64/test-aes.c
> new file mode 100644
> index 0000000000..1d2be488e9
> --- /dev/null
> +++ b/tests/tcg/ppc64/test-aes.c
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "../multiarch/test-aes-main.c.inc"
> +
> +#undef BIG_ENDIAN
> +#define BIG_ENDIAN  (__BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__)
> +
> +static unsigned char bswap_le[16] __attribute__((aligned(16))) =3D {
> +    8,9,10,11,12,13,14,15,
> +    0,1,2,3,4,5,6,7
> +};
> +
> +bool test_SB_SR(uint8_t *o, const uint8_t *i)
> +{
> +    /* vcipherlast also adds round key, so supply zero. */
> +    if (BIG_ENDIAN) {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "vspltisb 1,0\n\t"
> +            "vcipherlast 0,0,1\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i) : "memory", "v0", "v1");
> +    } else {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 34,0,%2\n\t"
> +            "vspltisb 1,0\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "vcipherlast 0,0,1\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(bswap_le) : "memory", "v0", "v1", "v=
2");
> +    }
> +    return true;
> +}
> +
> +bool test_MC(uint8_t *o, const uint8_t *i)
> +{
> +    return false;
> +}
> +
> +bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    if (BIG_ENDIAN) {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 33,0,%2\n\t"
> +            "vcipher 0,0,1\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(k) : "memory", "v0", "v1");
> +    } else {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 33,0,%2\n\t"
> +            "lxvd2x 34,0,%3\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "vperm 1,1,1,2\n\t"
> +            "vcipher 0,0,1\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(k), "r"(bswap_le)
> +              : "memory", "v0", "v1", "v2");
> +    }
> +    return true;
> +}
> +
> +bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
> +{
> +    /* vcipherlast also adds round key, so supply zero. */
> +    if (BIG_ENDIAN) {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "vspltisb 1,0\n\t"
> +            "vncipherlast 0,0,1\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i) : "memory", "v0", "v1");
> +    } else {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 34,0,%2\n\t"
> +            "vspltisb 1,0\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "vncipherlast 0,0,1\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(bswap_le) : "memory", "v0", "v1", "v=
2");
> +    }
> +    return true;
> +}
> +
> +bool test_IMC(uint8_t *o, const uint8_t *i)
> +{
> +    return false;
> +}
> +
> +bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    if (BIG_ENDIAN) {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 33,0,%2\n\t"
> +            "vncipher 0,0,1\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(k) : "memory", "v0", "v1");
> +    } else {
> +        asm("lxvd2x 32,0,%1\n\t"
> +            "lxvd2x 33,0,%2\n\t"
> +            "lxvd2x 34,0,%3\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "vperm 1,1,1,2\n\t"
> +            "vncipher 0,0,1\n\t"
> +            "vperm 0,0,0,2\n\t"
> +            "stxvd2x 32,0,%0"
> +            : : "r"(o), "r"(i), "r"(k), "r"(bswap_le)
> +              : "memory", "v0", "v1", "v2");
> +    }
> +    return true;
> +}
> +
> +bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    return false;
> +}
> diff --git a/tests/tcg/riscv64/test-aes.c b/tests/tcg/riscv64/test-aes.c
> new file mode 100644
> index 0000000000..3d7ef0e33a
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-aes.c
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "../multiarch/test-aes-main.c.inc"
> +
> +bool test_SB_SR(uint8_t *o, const uint8_t *i)
> +{
> +    uint64_t *o8 =3D (uint64_t *)o;
> +    const uint64_t *i8 =3D (const uint64_t *)i;
> +
> +    asm("aes64es %0,%2,%3\n\t"
> +        "aes64es %1,%3,%2"
> +        : "=3D&r"(o8[0]), "=3D&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));
> +    return true;
> +}
> +
> +bool test_MC(uint8_t *o, const uint8_t *i)
> +{
> +    return false;
> +}
> +
> +bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    uint64_t *o8 =3D (uint64_t *)o;
> +    const uint64_t *i8 =3D (const uint64_t *)i;
> +    const uint64_t *k8 =3D (const uint64_t *)k;
> +
> +    asm("aes64esm %0,%2,%3\n\t"
> +        "aes64esm %1,%3,%2\n\t"
> +        "xor %0,%0,%4\n\t"
> +        "xor %1,%1,%5"
> +        : "=3D&r"(o8[0]), "=3D&r"(o8[1])
> +        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));
> +    return true;
> +}
> +
> +bool test_ISB_ISR(uint8_t *o, const uint8_t *i)
> +{
> +    uint64_t *o8 =3D (uint64_t *)o;
> +    const uint64_t *i8 =3D (const uint64_t *)i;
> +
> +    asm("aes64ds %0,%2,%3\n\t"
> +        "aes64ds %1,%3,%2"
> +        : "=3D&r"(o8[0]), "=3D&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));
> +    return true;
> +}
> +
> +bool test_IMC(uint8_t *o, const uint8_t *i)
> +{
> +    uint64_t *o8 =3D (uint64_t *)o;
> +    const uint64_t *i8 =3D (const uint64_t *)i;
> +
> +    asm("aes64im %0,%0\n\t"
> +        "aes64im %1,%1"
> +        : "=3Dr"(o8[0]), "=3Dr"(o8[1]) : "0"(i8[0]), "1"(i8[1]));
> +    return true;
> +}
> +
> +bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    return false;
> +}
> +
> +bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint8_t *k)
> +{
> +    uint64_t *o8 =3D (uint64_t *)o;
> +    const uint64_t *i8 =3D (const uint64_t *)i;
> +    const uint64_t *k8 =3D (const uint64_t *)k;
> +
> +    asm("aes64dsm %0,%2,%3\n\t"
> +        "aes64dsm %1,%3,%2\n\t"
> +        "xor %0,%0,%4\n\t"
> +        "xor %1,%1,%5"
> +        : "=3D&r"(o8[0]), "=3D&r"(o8[1])
> +        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));
> +    return true;
> +}
> diff --git a/tests/tcg/multiarch/test-aes-main.c.inc b/tests/tcg/multiarc=
h/test-aes-main.c.inc
> new file mode 100644
> index 0000000000..0039f8ba55
> --- /dev/null
> +++ b/tests/tcg/multiarch/test-aes-main.c.inc
> @@ -0,0 +1,183 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +
> +static bool test_SB_SR(uint8_t *o, const uint8_t *i);
> +static bool test_MC(uint8_t *o, const uint8_t *i);
> +static bool test_SB_SR_MC_AK(uint8_t *o, const uint8_t *i, const uint8_t=
 *k);
> +
> +static bool test_ISB_ISR(uint8_t *o, const uint8_t *i);
> +static bool test_IMC(uint8_t *o, const uint8_t *i);
> +static bool test_ISB_ISR_AK_IMC(uint8_t *o, const uint8_t *i, const uint=
8_t *k);
> +static bool test_ISB_ISR_IMC_AK(uint8_t *o, const uint8_t *i, const uint=
8_t *k);
> +
> +/*
> + * From https://doi.org/10.6028/NIST.FIPS.197-upd1,
> + * Appendix B -- Cipher Example
> + *
> + * Note that the formatting of the 4x4 matrices in the document is
> + * column-major, whereas C is row-major.  Therefore to get the bytes
> + * in the same order as the text, the matrices are transposed.
> + *
> + * Note that we are not going to test SubBytes or ShiftRows separately,
> + * so the "After SubBytes" column is omitted, using only the combined
> + * result "After ShiftRows" column.
> + */
> +
> +/* Ease the inline assembly by aligning everything. */
> +typedef struct {
> +    uint8_t b[16] __attribute__((aligned(16)));
> +} State;
> +
> +typedef struct {
> +    State start, after_sr, after_mc, round_key;
> +} Round;
> +
> +static const Round rounds[] =3D {
> +    /* Round 1 */
> +    { { { 0x19, 0x3d, 0xe3, 0xbe,       /* start */
> +          0xa0, 0xf4, 0xe2, 0x2b,
> +          0x9a, 0xc6, 0x8d, 0x2a,
> +          0xe9, 0xf8, 0x48, 0x08, } },
> +
> +      { { 0xd4, 0xbf, 0x5d, 0x30,       /* after shiftrows */
> +          0xe0, 0xb4, 0x52, 0xae,
> +          0xb8, 0x41, 0x11, 0xf1,
> +          0x1e, 0x27, 0x98, 0xe5, } },
> +
> +      { { 0x04, 0x66, 0x81, 0xe5,       /* after mixcolumns */
> +          0xe0, 0xcb, 0x19, 0x9a,
> +          0x48, 0xf8, 0xd3, 0x7a,
> +          0x28, 0x06, 0x26, 0x4c, } },
> +
> +      { { 0xa0, 0xfa, 0xfe, 0x17,       /* round key */
> +          0x88, 0x54, 0x2c, 0xb1,
> +          0x23, 0xa3, 0x39, 0x39,
> +          0x2a, 0x6c, 0x76, 0x05, } } },
> +
> +    /* Round 2 */
> +    { { { 0xa4, 0x9c, 0x7f, 0xf2,       /* start */
> +          0x68, 0x9f, 0x35, 0x2b,
> +          0x6b, 0x5b, 0xea, 0x43,
> +          0x02, 0x6a, 0x50, 0x49, } },
> +
> +      { { 0x49, 0xdb, 0x87, 0x3b,       /* after shiftrows */
> +          0x45, 0x39, 0x53, 0x89,
> +          0x7f, 0x02, 0xd2, 0xf1,
> +          0x77, 0xde, 0x96, 0x1a, } },
> +
> +      { { 0x58, 0x4d, 0xca, 0xf1,       /* after mixcolumns */
> +          0x1b, 0x4b, 0x5a, 0xac,
> +          0xdb, 0xe7, 0xca, 0xa8,
> +          0x1b, 0x6b, 0xb0, 0xe5, } },
> +
> +      { { 0xf2, 0xc2, 0x95, 0xf2,       /* round key */
> +          0x7a, 0x96, 0xb9, 0x43,
> +          0x59, 0x35, 0x80, 0x7a,
> +          0x73, 0x59, 0xf6, 0x7f, } } },
> +
> +    /* Round 3 */
> +    { { { 0xaa, 0x8f, 0x5f, 0x03,       /* start */
> +          0x61, 0xdd, 0xe3, 0xef,
> +          0x82, 0xd2, 0x4a, 0xd2,
> +          0x68, 0x32, 0x46, 0x9a, } },
> +
> +      { { 0xac, 0xc1, 0xd6, 0xb8,       /* after shiftrows */
> +          0xef, 0xb5, 0x5a, 0x7b,
> +          0x13, 0x23, 0xcf, 0xdf,
> +          0x45, 0x73, 0x11, 0xb5, } },
> +
> +      { { 0x75, 0xec, 0x09, 0x93,       /* after mixcolumns */
> +          0x20, 0x0b, 0x63, 0x33,
> +          0x53, 0xc0, 0xcf, 0x7c,
> +          0xbb, 0x25, 0xd0, 0xdc, } },
> +
> +      { { 0x3d, 0x80, 0x47, 0x7d,       /* round key */
> +          0x47, 0x16, 0xfe, 0x3e,
> +          0x1e, 0x23, 0x7e, 0x44,
> +          0x6d, 0x7a, 0x88, 0x3b, } } },
> +};
> +
> +static void verify_log(const char *prefix, const State *s)
> +{
> +    printf("%s:", prefix);
> +    for (int i =3D 0; i < sizeof(State); ++i) {
> +        printf(" %02x", s->b[i]);
> +    }
> +    printf("\n");
> +}
> +
> +static void verify(const State *ref, const State *tst, const char *which=
)
> +{
> +    if (!memcmp(ref, tst, sizeof(State))) {
> +        return;
> +    }
> +
> +    printf("Mismatch on %s\n", which);
> +    verify_log("ref", ref);
> +    verify_log("tst", tst);
> +    exit(EXIT_FAILURE);
> +}
> +
> +int main()
> +{
> +    int i, n =3D sizeof(rounds) / sizeof(Round);
> +    State t;
> +
> +    for (i =3D 0; i < n; ++i) {
> +        if (test_SB_SR(t.b, rounds[i].start.b)) {
> +            verify(&rounds[i].after_sr, &t, "SB+SR");
> +        }
> +    }
> +
> +    for (i =3D 0; i < n; ++i) {
> +        if (test_MC(t.b, rounds[i].after_sr.b)) {
> +            verify(&rounds[i].after_mc, &t, "MC");
> +        }
> +    }
> +
> +    /* The kernel of Cipher(). */
> +    for (i =3D 0; i < n - 1; ++i) {
> +        if (test_SB_SR_MC_AK(t.b, rounds[i].start.b, rounds[i].round_key=
.b)) {
> +            verify(&rounds[i + 1].start, &t, "SB+SR+MC+AK");
> +        }
> +    }
> +
> +    for (i =3D 0; i < n; ++i) {
> +        if (test_ISB_ISR(t.b, rounds[i].after_sr.b)) {
> +            verify(&rounds[i].start, &t, "ISB+ISR");
> +        }
> +    }
> +
> +    for (i =3D 0; i < n; ++i) {
> +        if (test_IMC(t.b, rounds[i].after_mc.b)) {
> +            verify(&rounds[i].after_sr, &t, "IMC");
> +        }
> +    }
> +
> +    /* The kernel of InvCipher(). */
> +    for (i =3D n - 1; i > 0; --i) {
> +        if (test_ISB_ISR_AK_IMC(t.b, rounds[i].after_sr.b,
> +                                rounds[i - 1].round_key.b)) {
> +            verify(&rounds[i - 1].after_sr, &t, "ISB+ISR+AK+IMC");
> +        }
> +    }
> +
> +    /*
> +     * The kernel of EqInvCipher().
> +     * We must compute a different round key: apply InvMixColumns to
> +     * the standard round key, per KeyExpansion vs KeyExpansionEIC.
> +     */
> +    for (i =3D 1; i < n; ++i) {
> +        if (test_IMC(t.b, rounds[i - 1].round_key.b) &&
> +            test_ISB_ISR_IMC_AK(t.b, rounds[i].after_sr.b, t.b)) {
> +            verify(&rounds[i - 1].after_sr, &t, "ISB+ISR+IMC+AK");
> +        }
> +    }
> +
> +    return EXIT_SUCCESS;
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 3430fd3cd8..d217474d0d 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -74,6 +74,10 @@ endif
>  AARCH64_TESTS +=3D sve-ioctls
>  sve-ioctls: CFLAGS+=3D-march=3Darmv8.1-a+sve
>
> +AARCH64_TESTS +=3D test-aes
> +test-aes: CFLAGS +=3D -O -march=3Darmv8-a+aes
> +test-aes: test-aes-main.c.inc
> +
>  # Vector SHA1
>  sha1-vector: CFLAGS=3D-O3
>  sha1-vector: sha1.c
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.tar=
get
> index f2ee7a4db7..fdf757c6ce 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -28,6 +28,10 @@ run-test-i386-bmi2: QEMU_OPTS +=3D -cpu max
>  test-i386-adcox: CFLAGS=3D-O2
>  run-test-i386-adcox: QEMU_OPTS +=3D -cpu max
>
> +test-aes: CFLAGS +=3D -O -msse2 -maes
> +test-aes: test-aes-main.c.inc
> +run-test-aes: QEMU_OPTS +=3D -cpu max
> +
>  #
>  # hello-i386 is a barebones app
>  #
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.t=
arget
> index b084963b9a..5721c159f2 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -36,5 +36,6 @@ run-vector: QEMU_OPTS +=3D -cpu POWER10
>
>  PPC64_TESTS +=3D signal_save_restore_xer
>  PPC64_TESTS +=3D xxspltw
> +PPC64_TESTS +=3D test-aes
>
>  TESTS +=3D $(PPC64_TESTS)
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index 9973ba3b5f..4b14a67f48 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -1,6 +1,13 @@
>  # -*- Mode: makefile -*-
>  # RISC-V specific tweaks
>
> +config-cc.mak: Makefile
> +       $(quiet-@)( \
> +           $(call cc-option,-mrv64g_zk, CROSS_CC_HAS_ZK) \

I think this should be "-march=3Drv64g_zk" instead of "-mrv64g_zk"
Otherwise this will always fail.

But I would drop this gating mechanism and use the idea that you
proposed for Zfa:

TESTS +=3D test-aes
run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don

    /* aes64es rd, rs1, rs2 =3D 0011001 rs2 rs1 000 rd 0110011 */
    asm(".insn r 0x33, 0x0, 0x19, %0, %2, %3\n\t"
        ".insn r 0x33, 0x0, 0x19, %1, %3, %2"
        : "=3D&r"(o8[0]), "=3D&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));

    /* aesesm rd, rs1, rs2 =3D 0011011 rs2 rs1 000 rd 0110011 */
    asm(".insn r 0x33, 0x0, 0x1b, %0, %2, %3\n\t"
        ".insn r 0x33, 0x0, 0x1b, %1, %3, %2\n\t"
        "xor %0,%0,%4\n\t"
        "xor %1,%1,%5"
        : "=3D&r"(o8[0]), "=3D&r"(o8[1])
        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));

    /* aes64ds rd, rs1, rs2 =3D 0011101 rs2 rs1 000 rd 0110011 */
    asm(".insn r 0x33, 0x0, 0x1d, %0, %2, %3\n\t"
        ".insn r 0x33, 0x0, 0x1d, %1, %3, %2"
        : "=3D&r"(o8[0]), "=3D&r"(o8[1]) : "r"(i8[0]), "r"(i8[1]));

    /* aes64im rd, rs1 =3D 0011000 00000 rs1 001 rd 0010011 */
    asm(".insn r 0x13, 0x1, 0x18, %0, %0, x0\n\t"
        ".insn r 0x13, 0x1, 0x18, %1, %1, x0"
        : "=3Dr"(o8[0]), "=3Dr"(o8[1]) : "0"(i8[0]), "1"(i8[1]));

    /* aes64dsm rd, rs1, rs2 =3D 0011111 rs2 rs1 000 rd 0110011 */
    asm(".insn r 0x33, 0x0, 0x1f, %0, %2, %3\n\t"
        ".insn r 0x33, 0x0, 0x1f, %1, %3, %2\n\t"
        "xor %0,%0,%4\n\t"
        "xor %1,%1,%5"
        : "=3D&r"(o8[0]), "=3D&r"(o8[1])
        : "r"(i8[0]), "r"(i8[1]), "r"(k8[0]), "r"(k8[1]));

After changing the code as proposed, I could run the tests successfully
(introducing a bug caused a failure).

BR
Christoph


> +       ) 3> config-cc.mak
> +
> +-include config-cc.mak
> +
>  VPATH +=3D $(SRC_PATH)/tests/tcg/riscv64
>  TESTS +=3D test-div
>  TESTS +=3D noexec
> @@ -9,3 +16,9 @@ TESTS +=3D noexec
>  TESTS +=3D test-noc
>  test-noc: LDFLAGS =3D -nostdlib -static
>  run-test-noc: QEMU_OPTS +=3D -cpu rv64,c=3Dfalse
> +
> +ifneq ($(CROSS_CC_HAS_ZK),)
> +TESTS +=3D test-aes
> +test-aes: CFLAGS +=3D -O -march=3Drv64gzk
> +run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don
> +endif
> --
> 2.34.1
>
>

