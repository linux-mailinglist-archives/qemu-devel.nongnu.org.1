Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050EF771B85
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSuhI-0004VS-AJ; Mon, 07 Aug 2023 03:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qSuhF-0004VD-Gu
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:30:33 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qSuhD-0000Co-Ub
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2997961090
 for <qemu-devel@nongnu.org>; Mon,  7 Aug 2023 07:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAACC433C7
 for <qemu-devel@nongnu.org>; Mon,  7 Aug 2023 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691393421;
 bh=GPR5hAMeMxYRytaMpTK0VddgzZONjkOJL42vjScS2pg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TgxJUVvtQQxaIbfBheRKwN/gISdvNOxt9X2Q9l0cOh9kOAP25iVCN0WiBsJdYOSh9
 uS8cbavkUBXBiQb32o0fmc2cj8KJD+pnlo9W8qNuUqk4vE2RNtWTggYtoCUGs15M8/
 1ttA+izYZ3+bNy4CK8GuIqjcYsylguGK/xKjKZiTlQ/u7cHwZ+ci9JUK+TNAoi1fFd
 XpxMqBlVhWtZon/ieURAcbmlL5HH6cFEKgeL/vTG5SAgXX6BcryoFlVAbOwBT0bMd2
 +tq/r+cowwCdiLc65Z9hO9T5Mvvt/kXp/zmOsG+OVNpvIqjqW5dK+2LAHiw/hJ5fIu
 7TxQuTAc5NS9Q==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-4fe28f92d8eso6543931e87.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 00:30:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtIlk535krhSpwTjNjDKwSRWmiNJzkXLaxQi09QrEMT3mLFMtH
 HSzowJfJjkcVZ+m4sD0pYipFh9xybSgF1X99WBs=
X-Google-Smtp-Source: AGHT+IFDVJHfM+dAryeWUz8bU0ccvPCYPiyTb47xtpauCK18VzE8rf5UgpQHR7ep9Me8szStv4UYS1aZO1bppWluelA=
X-Received: by 2002:a05:6512:4ca:b0:4fb:9d61:db44 with SMTP id
 w10-20020a05651204ca00b004fb9d61db44mr4662856lfq.12.1691393419488; Mon, 07
 Aug 2023 00:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230731093902.1796249-1-ardb@kernel.org>
In-Reply-To: <20230731093902.1796249-1-ardb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Aug 2023 09:30:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEAsQ5kYut-BSr_xOB1Wuzmk0T9tZLZvwn8xoZ6ixqUQ@mail.gmail.com>
Message-ID: <CAMj1kXHEAsQ5kYut-BSr_xOB1Wuzmk0T9tZLZvwn8xoZ6ixqUQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Use accelerated helper for AES64KS1I
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

(cc riscv maintainers)

On Mon, 31 Jul 2023 at 11:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
> implement the first half of the key schedule derivation. This does not
> actually involve shifting rows, so clone the same uint32_t 4 times into
> the AES vector to counter that.
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  target/riscv/crypto_helper.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
> index 4d65945429c6dcc4..257c5c4863fb160f 100644
> --- a/target/riscv/crypto_helper.c
> +++ b/target/riscv/crypto_helper.c
> @@ -148,24 +148,17 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, ta=
rget_ulong rnum)
>
>      uint8_t enc_rnum =3D rnum;
>      uint32_t temp =3D (RS1 >> 32) & 0xFFFFFFFF;
> -    uint8_t rcon_ =3D 0;
> -    target_ulong result;
> +    AESState t, rc =3D {};
>
>      if (enc_rnum !=3D 0xA) {
>          temp =3D ror32(temp, 8); /* Rotate right by 8 */
> -        rcon_ =3D round_consts[enc_rnum];
> +        rc.w[0] =3D rc.w[1] =3D rc.w[2] =3D rc.w[3] =3D round_consts[enc=
_rnum];

This can be simplified to

rc.w[0] =3D rc.w[1] =3D round_consts[enc_rnum];


>      }
>
> -    temp =3D ((uint32_t)AES_sbox[(temp >> 24) & 0xFF] << 24) |
> -           ((uint32_t)AES_sbox[(temp >> 16) & 0xFF] << 16) |
> -           ((uint32_t)AES_sbox[(temp >> 8) & 0xFF] << 8) |
> -           ((uint32_t)AES_sbox[(temp >> 0) & 0xFF] << 0);
> +    t.w[0] =3D t.w[1] =3D t.w[2] =3D t.w[3] =3D temp;
> +    aesenc_SB_SR_AK(&t, &t, &rc, false);
>
> -    temp ^=3D rcon_;
> -
> -    result =3D ((uint64_t)temp << 32) | temp;
> -
> -    return result;
> +    return t.d[0];
>  }
>
>  target_ulong HELPER(aes64im)(target_ulong rs1)
> --
> 2.39.2
>

