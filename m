Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44778C510
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayeh-0003y7-Ex; Tue, 29 Aug 2023 09:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayee-0003vk-VJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:21:12 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayeb-00031i-1k
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:21:12 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50098cc8967so6904454e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315267; x=1693920067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIaXhqvjX6xMFpNg8SHdTT6gdjOJPQH2OOxiQdoGFyE=;
 b=Q0KYQ+/8lKMhyTX6oKfoJq6/k17gRecXkn7MR9Vl/g+DIrxWpDNWktBM7z3Dv5WdKS
 aenijnPbjpWH7/0Fuj6yGLEg/dA6EMzfqVr+fE1YJNsMVE4SdJsWvDSqx2diklxR1sKa
 2iIH2yBsCPK9O7yz7Wepc3zRO6kg9C5mvblALM0g8pqxc/SLl92wRRaX4wINBouOEP+2
 2NDWLjMyaxJTjfWqhffSEFdzk6Kc1HI2qSLfEhvS7qRPftT5pjby7qtnPb+2RFGKnPt/
 z9Hm+ZGWuMMHQBqP6cwns+ndNp136YCaLviIj/EMhZ0UVzKkL68XLzMu150u9cNbvJBm
 o/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315267; x=1693920067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIaXhqvjX6xMFpNg8SHdTT6gdjOJPQH2OOxiQdoGFyE=;
 b=ak9Tyqbmr7bmvOkpQSwmRSFXqOuNt75peSQMbXOePrgFKLREtdqTvMD7lO9Bd6vvBK
 bYP7Y8DMmRt6VbcmY9OOrMi7SNJM8hQiogLdfPq7b0OlZeaECHMkv7k0tsBdkI37s6dL
 T76F8ctBwbiZgh2kw1ZK6LW8HRBQApRDHkQEGnQZycOfs+sWd9imxk0FurN6qQRSKd85
 UVpf5nXYrwn1fZpiCRDOzJBrs4ToSiJs8WiGrTs4AeE/4CNRgu8CxnThlr3Swz1BTA+s
 GY1YbHYddc6KWmhkcI6gIxebtH4dg6EPlPwM4DNBKvwUmhQJbj//4KYm22uODcuQcudt
 aHjg==
X-Gm-Message-State: AOJu0Yxnev4JK2NiLG/vyPBA2/UEIu/Ape+JPLRao0qusDESCc/IClPq
 EjKlDy1F8pv4Z8iFbTlo6Pq0aCadwWsXVRdEKbP5BQ==
X-Google-Smtp-Source: AGHT+IH/hrP8Vedz+JJVF83/9cwgXmz2qgarMo6K/vUwlOUiX6bhCoBCe6GWuGMffZoKtyeL16dGsorNRQkCrYcuCo4=
X-Received: by 2002:a05:6512:3701:b0:500:b7dc:6c90 with SMTP id
 z1-20020a056512370100b00500b7dc6c90mr4198064lfr.36.1693315266838; Tue, 29 Aug
 2023 06:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230822095156.39868-1-philmd@linaro.org>
In-Reply-To: <20230822095156.39868-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:20:56 +0100
Message-ID: <CAFEAcA8CWDg8cBjr_KJdTE2AvvdksU7jGhfHp5sdQU7FHbAb4w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use deposit_z() in BCF opcode
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 22 Aug 2023 at 10:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When clearing a bitfield we don't need to lead the

"load" ?

> source register. Use deposit_z_i32() with the BFC
> opcode to save a load_reg() call.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/arm/tcg/translate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index b71ac2d0d5..1a6938d1b3 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -7255,7 +7255,7 @@ static bool trans_UBFX(DisasContext *s, arg_UBFX *a=
)
>  static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
>  {
>      int msb =3D a->msb, lsb =3D a->lsb;
> -    TCGv_i32 t_in, t_rd;
> +    TCGv_i32 t_rd;
>      int width;
>
>      if (!ENABLE_ARCH_6T2) {
> @@ -7268,15 +7268,14 @@ static bool trans_BFCI(DisasContext *s, arg_BFCI =
*a)
>      }
>
>      width =3D msb + 1 - lsb;
> +    t_rd =3D load_reg(s, a->rd);
>      if (a->rn =3D=3D 15) {
>          /* BFC */
> -        t_in =3D tcg_constant_i32(0);
> +        tcg_gen_deposit_z_i32(t_rd, t_rd, lsb, width);
>      } else {
>          /* BFI */
> -        t_in =3D load_reg(s, a->rn);
> +        tcg_gen_deposit_i32(t_rd, t_rd, load_reg(s, a->rn), lsb, width);
>      }
> -    t_rd =3D load_reg(s, a->rd);
> -    tcg_gen_deposit_i32(t_rd, t_rd, t_in, lsb, width);
>      store_reg(s, a->rd, t_rd);
>      return true;

The comment says we are saving a load_reg() call, but the
code change doesn't seem to do that. Before the change:
 * for BFC we call load_reg for rd
 * for BFI we call load_reg for rn and rd

After the change:
 * for BFC we call load_reg for rd
 * for BFI we call load_reg for rn and rd

So we're not saving any load_reg() calls as far as I can see ?

-- PMM

