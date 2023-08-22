Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF99B784032
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQ0p-0004Qv-1X; Tue, 22 Aug 2023 07:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYQ0n-0004QW-49
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:57:29 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYQ0k-0002eK-E5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:57:28 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so9065554a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692705444; x=1693310244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgqrI3T3hOuQEDML+sVpS9zcCtCaRRyYRjkYaQ3SPyE=;
 b=lrTAwuF/+Sl4oKcU3i6cFc6QeCkvI2BhC38SUyxRy0hGgJdsG5pbkmKARH+v1UuHDf
 zzl3Sjb5lxfqdAQpHn4oS9whCll+X7oJs0ckmV4Fv9/Zwnz1Eyb3muS0kBV8wWH0lpHq
 FUFOmylitRh8SICa0CbqlI9HwteELoHiwVBKlcxVJ7ioaOIOL2DlZHs991ON1UefUjAI
 5EtHoGkWL8awLiZYRxFwXWAp1Ri2xFSylNMP2Dj6d0/MaRrFDjehXMAOYuvKsqSzQ1uG
 Q2fjdVmSDgdI3C05jSPglV+8Hl0bQcUK+xymbtABA8e4g/jsfsT7KnLDLgrPeFzFadGH
 4dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692705444; x=1693310244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgqrI3T3hOuQEDML+sVpS9zcCtCaRRyYRjkYaQ3SPyE=;
 b=RI5/xNmeCJ5+ijEL2fg+qjOhi59djMS9tQO8mj10KQv6KrFUp3mINkogirq40dv4kZ
 1vtv2D90lZ7J1KVshkM7GcMu9YaugkcJ2erwnGFh49bkEyxF9KVwOzIX0lgNDlyDVgjn
 7W1VhZs1ndluCdXu3k4sfesOP5riOijEVJi9T0F2P2k4422Gr7Gcb9aWvHJRnzj9AXD+
 fBukpuYHwsu/QSDoPlAH0PkXR4yq1hQB1nWOiX28GdfOA2Ng3bR3nsoDg9R5aSVL73zC
 bEXlDmx/1rreNB8i30rjVtkELT4O3npY6Sn/wgoCyOKkLc5IMrhsm7rdvl1JuqAgS28T
 5lNA==
X-Gm-Message-State: AOJu0YyQpCmySVIJzCnqIoFEFTCf4SErh9pdeC7oJuUsA648PpaoDJvH
 w0WRkEREM/aYRRzaRt2CvF6D3j+PgOOqpPslCkjn8w==
X-Google-Smtp-Source: AGHT+IHulOu2gt/82OGfW7XqCuqluMSw0hxSodqQ00VCKzlQncVgDk5XB31OI5bIAhXDCrn/AZSVA9hVBYvm4lUlEu4=
X-Received: by 2002:a05:6402:1d4c:b0:51f:ef58:da87 with SMTP id
 dz12-20020a0564021d4c00b0051fef58da87mr12708958edb.2.1692705444165; Tue, 22
 Aug 2023 04:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-6-philmd@linaro.org>
In-Reply-To: <20230822110129.41022-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 12:57:13 +0100
Message-ID: <CAFEAcA-GJiVX5kbx58MNAHQ1z4-bJzjFzJsha_Lp7XB674-NUA@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/mips: Use hswap_i64() in DSHD opcode
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 22 Aug 2023 at 12:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it instead of open-coding
> it in gen_bshfl().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/mips/tcg/translate.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 9bb40f1849..4f34ea9b6a 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -4948,19 +4948,7 @@ static void gen_bshfl(DisasContext *ctx, uint32_t =
op2, int rt, int rd)
>          }
>          break;
>      case OPC_DSHD:
> -        {
> -            TCGv t1 =3D tcg_temp_new();
> -            TCGv t2 =3D tcg_constant_tl(0x0000FFFF0000FFFFULL);
> -
> -            tcg_gen_shri_tl(t1, t0, 16);
> -            tcg_gen_and_tl(t1, t1, t2);
> -            tcg_gen_and_tl(t0, t0, t2);
> -            tcg_gen_shli_tl(t0, t0, 16);
> -            tcg_gen_or_tl(t0, t0, t1);
> -            tcg_gen_shri_tl(t1, t0, 32);
> -            tcg_gen_shli_tl(t0, t0, 32);
> -            tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
> -        }
> +        tcg_gen_hswap_i64(cpu_gpr[rd], t0);

We know that target_long here is 64 bits, but for consistency
with the rest of the function maybe tcg_gen_hswap_tl()
is better? I'm not sure...

thanks
-- PMM

