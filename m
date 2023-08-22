Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930AD783FE1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYPow-0003Un-Va; Tue, 22 Aug 2023 07:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYPon-0003UF-Cc
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:06 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYPoi-00066V-M7
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:45:04 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so9043032a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692704698; x=1693309498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrQ0nn/R+ah4RfL4YqoGKD8z4L73n4KEcrCq0geYfv0=;
 b=Ni0IT5CW+haVBHOuKiICtnG5pAUT8jfczPf/ScQX80Z952HQWBBtWUKVeWssCCNwt8
 /rRrtLKNeteXofO+FxOqWzYVr5VHyEswK0xXdu0AaeWwnIgHlevgSPAQZys0misY4E1s
 B35Q73qYOretcZypL9m9Oseahh0tlrwAy5XeOk61CqA7IIzTrI5V8bi31Do/6/4a2HQz
 3APwRGrFBhiKWTf6uIzLEO+sd7AwnmSpSIqRrKwVhsUXpZ1pvpj/DEAgMLddYucbSAfp
 upaG8Lx9LHv86jssCcorJkr9Br7d5g0SFiFMPSc+aMzew9qLQ3A9yjNWYC/doOxgdrRb
 K20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692704698; x=1693309498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrQ0nn/R+ah4RfL4YqoGKD8z4L73n4KEcrCq0geYfv0=;
 b=RbYCxC+X1so+qCePj4jiyOk8XuVI2g/9NQbir1Y+IInzwjj1sB9wGqaXqdEY1L9O5Q
 XxveNvJL1QKQDHYSNSarbVUxJwOW/O5hOD9VwlhPs0T/wlaY1+7ZZLdymbplEWajhwy2
 x1rk3d/mlBZDb2jyqd5s11nirMhPk1irFPY8+aEYirLaMfua9/rWJrstU36tKETxUeUL
 XgJYPJPVEE40SCoA4m1FCj+elM5aGTXn9k00tggL9B+uhsJclIdPNpadrcjJLdgmbnII
 mAm7b8vXsoetFsXOty6SB83yGhD6PJVVRlbOIs43dnN/ezVHX9EtUpY7rO8/1/xs5E4H
 2/GA==
X-Gm-Message-State: AOJu0Yy2cW4C8cCMvC5qZWkFf2Jp7NIfk1xRVTQg8mBD8Hc+Dl3bDDAW
 jyojfofYUDrnT6TOSBy+pfP4Z5sGEHB7RAgIYlNS4w==
X-Google-Smtp-Source: AGHT+IGOMUZV3gAogPQHeNs57R2pbxmapHl2TOmjngnAuz9wZikQrLPQ7eoKfEofE7G/cVDEvARILfMiAAdM9muVATs=
X-Received: by 2002:a05:6402:348b:b0:522:ab20:368a with SMTP id
 v11-20020a056402348b00b00522ab20368amr10369244edc.13.1692704697794; Tue, 22
 Aug 2023 04:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-3-philmd@linaro.org>
In-Reply-To: <20230822110129.41022-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 12:44:46 +0100
Message-ID: <CAFEAcA-36XE-9ikSp0F4EMUKysz=ms2JyLCc8GOWcgJq3sb=hw@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/cris: Use hswap_i32() in SWAPW opcode
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 22 Aug 2023 at 12:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it instead of open-coding
> it as t_gen_swapw().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/cris/translate.c         | 14 +-------------
>  target/cris/translate_v10.c.inc |  2 +-
>  2 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 42103b5558..925ed2c6f6 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -399,18 +399,6 @@ static inline void t_gen_swapb(TCGv d, TCGv s)
>      tcg_gen_or_tl(d, d, t);
>  }
>
> -/* Swap the halfwords of the s operand.  */
> -static inline void t_gen_swapw(TCGv d, TCGv s)
> -{
> -    TCGv t;
> -    /* d and s refer the same object.  */
> -    t =3D tcg_temp_new();
> -    tcg_gen_mov_tl(t, s);
> -    tcg_gen_shli_tl(d, t, 16);
> -    tcg_gen_shri_tl(t, t, 16);
> -    tcg_gen_or_tl(d, d, t);
> -}
> -
>  /*
>   * Reverse the bits within each byte.
>   *
> @@ -1675,7 +1663,7 @@ static int dec_swap_r(CPUCRISState *env, DisasConte=
xt *dc)
>          tcg_gen_not_tl(t0, t0);
>      }
>      if (dc->op2 & 4) {
> -        t_gen_swapw(t0, t0);
> +        tcg_gen_hswap_i32(t0, t0);
>      }
>      if (dc->op2 & 2) {
>          t_gen_swapb(t0, t0);
> diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.=
c.inc
> index b7b0517982..0ff15769ec 100644
> --- a/target/cris/translate_v10.c.inc
> +++ b/target/cris/translate_v10.c.inc
> @@ -506,7 +506,7 @@ static void dec10_reg_swap(DisasContext *dc)
>      if (dc->dst & 8)
>          tcg_gen_not_tl(t0, t0);
>      if (dc->dst & 4)
> -        t_gen_swapw(t0, t0);
> +        tcg_gen_hswap_i32(t0, t0);

Both these are operating on TCGv, not TCGv_i32, so I think this
should be tcg_gen_hswap_tl(). (Compare the tcg_gen_not_tl()
calls.)

>      if (dc->dst & 2)
>          t_gen_swapb(t0, t0);
>      if (dc->dst & 1)

thanks
-- PMM

