Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD7788104
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRP6-00079S-8o; Fri, 25 Aug 2023 03:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRP4-00070O-4i; Fri, 25 Aug 2023 03:38:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZRP1-0006kt-RX; Fri, 25 Aug 2023 03:38:45 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so596027b3a.3; 
 Fri, 25 Aug 2023 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692949121; x=1693553921;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlKNG7FuFzHEneUgzBD6cy+xvFnIDPBAozu/WWrCKG8=;
 b=inM3w3yWbMeNy/3IuJwZTfMiYBojxXw2VWIlBraoT1Ln3X+8s6jNMveDHx/9VVPJHo
 na0YHxOdQLY+/YesaWcwVRlw+wqAAKz6tsMQnN2RMA+21Olra1O3pr4YTrdaESJCNjZP
 wkMPMAOfMMOSCI1+fXsLpnmxTdBaqWfdXRticDa4XSJCHuOYBPsXcr59hYYbhwLCOl/e
 1aYJ7juE158RDTu5wbsZInbXXe9bdHObY5cirxDQMiPgtGwWjnEQ44/bC6tqxPAphoqI
 0s5P/pKI7u0cC4xGzFCWKaLZGhfTwosceQiYSSedDIGfU6SR8hkeBkpq8BmgsY8i5E7C
 B6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692949121; x=1693553921;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SlKNG7FuFzHEneUgzBD6cy+xvFnIDPBAozu/WWrCKG8=;
 b=aOib9CadqwDYCNYMvKTt7SBPjQTOJQu85udq6vOfIzz/REydfsi0DgbTVv3VF7EVe4
 WjwITKORTZHaozy/kloCyqwz8encs7LcM8vbZuAix4FRcKAfwkHbqeYiCr8oMXXdoBsI
 d65VRvVZxovvv++5mvN54g5ZmkY2NV3a+/0PXLDlhqJfdB2IFrDEi445PiHFokcig3EL
 yX7fJnNZ6QMS4VjcNxS/tpUyGZwJJzTyMDNwilZ4h7mPGdzCyJuORJ52BTZsW62zR8IB
 ajF2tIj3+SbuVE5dS3sI/Yg7ncjJOuQx7ow/n0AgUGRkn54AHmLGoEDiCcRvZu/ukJBM
 5a3w==
X-Gm-Message-State: AOJu0YxrT+n4efdfvjdth5EB+c9ucU5HBgMUGTgAXrwsMjRLhTMSrAEh
 qgj0YiWdidiTrYid8KMEK5Y=
X-Google-Smtp-Source: AGHT+IEtXhI4J+G7n2E0ve7iruBGgAcGCo/Gvs9ERHEXcDRe8D8C5P3Tgty/cNe9hYn/3tQ9j9uNcw==
X-Received: by 2002:a05:6a00:190e:b0:68b:bf47:d7b0 with SMTP id
 y14-20020a056a00190e00b0068bbf47d7b0mr8555979pfi.3.1692949121101; 
 Fri, 25 Aug 2023 00:38:41 -0700 (PDT)
Received: from localhost ([1.146.69.243]) by smtp.gmail.com with ESMTPSA id
 e12-20020aa7824c000000b0068bc6a75848sm895227pfn.156.2023.08.25.00.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:38:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2023 17:38:31 +1000
Message-Id: <CV1GDHA1R3DJ.1LZ6DG73V2VVU@wheely>
Cc: "Song Gao" <gaosong@loongson.cn>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Greg Kurz" <groug@kaod.org>, "Aurelien
 Jarno" <aurelien@aurel32.net>, <qemu-ppc@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Aleksandar Rikalo"
 <aleksandar.rikalo@syrmia.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Jiaxun Yang"
 <jiaxun.yang@flygoat.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Xiaojuan
 Yang" <yangxiaojuan@loongson.cn>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH 07/12] target/ppc: Use generic hrev64_i64() in BRH /
 BSWAP16x8 opcodes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125332.55086-1-philmd@linaro.org>
In-Reply-To: <20230822125332.55086-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Aug 22, 2023 at 10:53 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/translate.c              | 10 +---------
>  target/ppc/translate/vsx-impl.c.inc | 19 ++-----------------
>  2 files changed, 3 insertions(+), 26 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 74796ec7ba..91a9ec2d1c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6435,15 +6435,7 @@ static void gen_brw(DisasContext *ctx)
>  /* brh */
>  static void gen_brh(DisasContext *ctx)
>  {
> -    TCGv_i64 mask =3D tcg_constant_i64(0x00ff00ff00ff00ffull);
> -    TCGv_i64 t1 =3D tcg_temp_new_i64();
> -    TCGv_i64 t2 =3D tcg_temp_new_i64();
> -
> -    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
> -    tcg_gen_and_i64(t2, t1, mask);
> -    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], mask);
> -    tcg_gen_shli_i64(t1, t1, 8);
> -    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
> +    tcg_gen_hrev64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)=
]);
>  }
>  #endif
> =20
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/v=
sx-impl.c.inc
> index 0f5b0056f1..639ab7f1bc 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -154,23 +154,8 @@ static void gen_lxvdsx(DisasContext *ctx)
>  static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
>                            TCGv_i64 inh, TCGv_i64 inl)
>  {
> -    TCGv_i64 mask =3D tcg_constant_i64(0x00FF00FF00FF00FF);
> -    TCGv_i64 t0 =3D tcg_temp_new_i64();
> -    TCGv_i64 t1 =3D tcg_temp_new_i64();
> -
> -    /* outh =3D ((inh & mask) << 8) | ((inh >> 8) & mask) */
> -    tcg_gen_and_i64(t0, inh, mask);
> -    tcg_gen_shli_i64(t0, t0, 8);
> -    tcg_gen_shri_i64(t1, inh, 8);
> -    tcg_gen_and_i64(t1, t1, mask);
> -    tcg_gen_or_i64(outh, t0, t1);
> -
> -    /* outl =3D ((inl & mask) << 8) | ((inl >> 8) & mask) */
> -    tcg_gen_and_i64(t0, inl, mask);
> -    tcg_gen_shli_i64(t0, t0, 8);
> -    tcg_gen_shri_i64(t1, inl, 8);
> -    tcg_gen_and_i64(t1, t1, mask);
> -    tcg_gen_or_i64(outl, t0, t1);
> +    tcg_gen_hrev64_i64(outh, inh);
> +    tcg_gen_hrev64_i64(outl, inl);
>  }
> =20
>  static void gen_bswap32x4(TCGv_i64 outh, TCGv_i64 outl,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


