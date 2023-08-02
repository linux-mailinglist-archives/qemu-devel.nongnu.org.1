Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DAD76CEFE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRC6Y-0002At-5F; Wed, 02 Aug 2023 09:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qRC6V-0002AJ-AF
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:41:31 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qRC6T-0004EB-Em
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:41:30 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-44779e3e394so1826577137.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690983688; x=1691588488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O7USfmRw9igPoe/RH5VSyHakK6h55nKfY15JySRlGE=;
 b=AsIOS8ZvDUD3QPN7/bSBuuYJMoXvXslSuSXoSt6a5W3YWl8DzelTb9XyDmbGQLk1IO
 0RFJ4ZTUIHH8yhNLZ1NWjCm3Avz2gD1lB4E92FUPIPsr6Y39y4Up308oIJt4PhOmgMTC
 R26plIOASvUu3Eg38vvz9JixBbmauE2EykMMiymex3N/UxkJmFgsBacpQA07XxTa8upv
 U/LzJUqJ8RL17QKZOsbJZ1IUWBFqA4pTB5vYDypDr1B0bzL0fJgdcoI9PeWyjy5eATyn
 1yWItywCoTzUQ2fm9Vv7Sr0dptVFENzzjbuOZ+83P+861tACFNZI9NZOh57mAaftpqmG
 KUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690983688; x=1691588488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/O7USfmRw9igPoe/RH5VSyHakK6h55nKfY15JySRlGE=;
 b=X1ba7csznQl5pU1YpEup5FfW9TaVj0nquzsuVycdBUE+d8GBQCwQTEWzjaGf7hyK+2
 fq0GbKqQHcy6eXP/gllmmaQWeEILHp8zu1UkTm8HAYRPYYjf6zidihl2SMAke5Y5tTk9
 Q9JRwdHyPhvhdu+DJp+EX5JldeMFjkKAV5U249Ly43bHNm8lpghaJdBCML+bg9Y7rDRR
 BqqfrpDXzdCvfzBCPyKM8aGpGVbHxq893BvZyCkXM2rM8PvDkBpeQfczhY5s8nxD/Yi9
 Tybu9R1YxdVUM9jq9NCQu5zCP2MEGWHnxcZkZGhItOag7CnH5TJQ1TsovI6TuNcgzEoL
 35pA==
X-Gm-Message-State: ABy/qLbyvXy4u2yDYcRV22ineGGSTyytWEbP/S+anU48XPL+XpAeCZ0J
 hSQzyDRvQt+znhfSq2FBnLrk06QE2pan5XxTxcA=
X-Google-Smtp-Source: APBJJlFD1RLxKsYeYnlW/7awQuwra2mBQRRrkQjDHJEYlUmhoMKJFTdUs5JfFxJt2cLux/ca4Vaw0b55BGa80tdL6Xk=
X-Received: by 2002:a67:f1c2:0:b0:443:8898:2a50 with SMTP id
 v2-20020a67f1c2000000b0044388982a50mr3666824vsm.35.1690983687889; Wed, 02 Aug
 2023 06:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230731084043.1791984-1-ardb@kernel.org>
In-Reply-To: <20230731084043.1791984-1-ardb@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 2 Aug 2023 09:41:01 -0400
Message-ID: <CAKmqyKMjsRM2wFSs59-bpHpiXsKPmUjYynigAu3DoJ2yqce+gQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Use existing lookup tables for MixColumns
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zewen Ye <lustrew@foxmail.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jul 31, 2023 at 4:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> The AES MixColumns and InvMixColumns operations are relatively
> expensive 4x4 matrix multiplications in GF(2^8), which is why C
> implementations usually rely on precomputed lookup tables rather than
> performing the calculations on demand.
>
> Given that we already carry those tables in QEMU, we can just grab the
> right value in the implementation of the RISC-V AES32 instructions. Note
> that the tables in question are permuted according to the respective
> Sbox, so we can omit the Sbox lookup as well in this case.
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Zewen Ye <lustrew@foxmail.com>
> Cc: Weiwei Li <liweiwei@iscas.ac.cn>
> Cc: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
> - ignore host endianness and use be32_to_cpu() unconditionally
>
>  crypto/aes.c                 |  4 +--
>  include/crypto/aes.h         |  7 ++++
>  target/riscv/crypto_helper.c | 34 +++-----------------
>  3 files changed, 13 insertions(+), 32 deletions(-)
>
> diff --git a/crypto/aes.c b/crypto/aes.c
> index 836d7d5c0bf1b392..df4362ac6022eac2 100644
> --- a/crypto/aes.c
> +++ b/crypto/aes.c
> @@ -272,7 +272,7 @@ AES_Td3[x] =3D Si[x].[09, 0d, 0b, 0e];
>  AES_Td4[x] =3D Si[x].[01, 01, 01, 01];
>  */
>
> -static const uint32_t AES_Te0[256] =3D {
> +const uint32_t AES_Te0[256] =3D {
>      0xc66363a5U, 0xf87c7c84U, 0xee777799U, 0xf67b7b8dU,
>      0xfff2f20dU, 0xd66b6bbdU, 0xde6f6fb1U, 0x91c5c554U,
>      0x60303050U, 0x02010103U, 0xce6767a9U, 0x562b2b7dU,
> @@ -607,7 +607,7 @@ static const uint32_t AES_Te4[256] =3D {
>      0xb0b0b0b0U, 0x54545454U, 0xbbbbbbbbU, 0x16161616U,
>  };
>
> -static const uint32_t AES_Td0[256] =3D {
> +const uint32_t AES_Td0[256] =3D {
>      0x51f4a750U, 0x7e416553U, 0x1a17a4c3U, 0x3a275e96U,
>      0x3bab6bcbU, 0x1f9d45f1U, 0xacfa58abU, 0x4be30393U,
>      0x2030fa55U, 0xad766df6U, 0x88cc7691U, 0xf5024c25U,
> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> index 709d4d226bfe158b..381f24c9022d2aa8 100644
> --- a/include/crypto/aes.h
> +++ b/include/crypto/aes.h
> @@ -30,4 +30,11 @@ void AES_decrypt(const unsigned char *in, unsigned cha=
r *out,
>  extern const uint8_t AES_sbox[256];
>  extern const uint8_t AES_isbox[256];
>
> +/*
> +AES_Te0[x] =3D S [x].[02, 01, 01, 03];
> +AES_Td0[x] =3D Si[x].[0e, 09, 0d, 0b];
> +*/
> +
> +extern const uint32_t AES_Te0[256], AES_Td0[256];
> +
>  #endif
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
> index 99d85a618843e87e..4d65945429c6dcc4 100644
> --- a/target/riscv/crypto_helper.c
> +++ b/target/riscv/crypto_helper.c
> @@ -25,29 +25,6 @@
>  #include "crypto/aes-round.h"
>  #include "crypto/sm4.h"
>
> -#define AES_XTIME(a) \
> -    ((a << 1) ^ ((a & 0x80) ? 0x1b : 0))
> -
> -#define AES_GFMUL(a, b) (( \
> -    (((b) & 0x1) ? (a) : 0) ^ \
> -    (((b) & 0x2) ? AES_XTIME(a) : 0) ^ \
> -    (((b) & 0x4) ? AES_XTIME(AES_XTIME(a)) : 0) ^ \
> -    (((b) & 0x8) ? AES_XTIME(AES_XTIME(AES_XTIME(a))) : 0)) & 0xFF)
> -
> -static inline uint32_t aes_mixcolumn_byte(uint8_t x, bool fwd)
> -{
> -    uint32_t u;
> -
> -    if (fwd) {
> -        u =3D (AES_GFMUL(x, 3) << 24) | (x << 16) | (x << 8) |
> -            (AES_GFMUL(x, 2) << 0);
> -    } else {
> -        u =3D (AES_GFMUL(x, 0xb) << 24) | (AES_GFMUL(x, 0xd) << 16) |
> -            (AES_GFMUL(x, 0x9) << 8) | (AES_GFMUL(x, 0xe) << 0);
> -    }
> -    return u;
> -}
> -
>  #define sext32_xlen(x) (target_ulong)(int32_t)(x)
>
>  static inline target_ulong aes32_operation(target_ulong shamt,
> @@ -55,23 +32,20 @@ static inline target_ulong aes32_operation(target_ulo=
ng shamt,
>                                             bool enc, bool mix)
>  {
>      uint8_t si =3D rs2 >> shamt;
> -    uint8_t so;
>      uint32_t mixed;
>      target_ulong res;
>
>      if (enc) {
> -        so =3D AES_sbox[si];
>          if (mix) {
> -            mixed =3D aes_mixcolumn_byte(so, true);
> +            mixed =3D be32_to_cpu(AES_Te0[si]);
>          } else {
> -            mixed =3D so;
> +            mixed =3D AES_sbox[si];
>          }
>      } else {
> -        so =3D AES_isbox[si];
>          if (mix) {
> -            mixed =3D aes_mixcolumn_byte(so, false);
> +            mixed =3D be32_to_cpu(AES_Td0[si]);
>          } else {
> -            mixed =3D so;
> +            mixed =3D AES_isbox[si];
>          }
>      }
>      mixed =3D rol32(mixed, shamt);
> --
> 2.39.2
>
>

