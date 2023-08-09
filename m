Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D250E775BDB
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qThFC-0006Kp-Uc; Wed, 09 Aug 2023 07:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThF8-0006KU-U3; Wed, 09 Aug 2023 07:20:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThF4-000229-Sg; Wed, 09 Aug 2023 07:20:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f090310dso6538884b3a.0; 
 Wed, 09 Aug 2023 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691580041; x=1692184841;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qcphbv0iO+6FDc61lZ0fVhxZyo7mMU07c8iZVyTzgaE=;
 b=hi0ViBSSeE4tOOiaN94jOpGCmszeO4fN2gAUdfxepCcVwuLZgvk5uVeruVFl1lvawg
 MDCmIKvOyvJRzl7sVljm4u59NzvFmPPaPM0bmA6+poBjel274WHlaZehpkJm8D5gJbhZ
 sbNkwmF/eBGvFsb1kf0LNDS8ZFo+t9Rt/+cDehEHa3y81qQyNfD4/IwhZZpx4bI2GP+F
 nH8VPM0dAdmQ4B7EQzH1j/qEAhQfEi6C587E7pE69CQfII42ppX8WtLmCNv48Bl0Spym
 KwsusSdGTTRF+WVisHfj/pQ9jiAz6CoGVPm1r1t2pPEk1BsYx43e9BhgWrMBgrpNIw5m
 SUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691580041; x=1692184841;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qcphbv0iO+6FDc61lZ0fVhxZyo7mMU07c8iZVyTzgaE=;
 b=h20n1ztUzdPU0Z9oKlFR5anHSglC8AhRnPfXr6ROnXruae9ditvQqCse9PwMEvs5zy
 +VRIPHolPYq3e+HC1UqQpjMEUjBWrhgv+jondSQ4/NyiHuTr/fB7AxjIgB+BC2+fErOY
 BJtY79YirMAx/ltmT9QETOqPJXpcjHfgt5k5Uv0FCqSGN6tRywFInpYCt14hYNN+TIVS
 ATs3PcFil2qyuaDWaaqHe28EdQGIJLr5jQXTzVOBYsSRR7M2/NwERvluwTqpaV04O9Hl
 wqpC7CI6jux/2/0MSXLwDQwVL+Qtx7sC60H60IdeJVXzs1J4pxIaMEVFxiDBYktRWtk+
 qAwg==
X-Gm-Message-State: AOJu0Yzzuyw+Ss5un9iwhQ5iuDAKv8Wthx0d9PvjAPfm8nODZm/WM79/
 qxhF7IO8BCzhvfxLQ5IRDULHoh+sTMg=
X-Google-Smtp-Source: AGHT+IGUwJ/mwwWULd42n7Scu1nVx+M1dlO6HplYanzW7v3E+K1/AaKJpx1aaF4tyZqrGKBYscLGQg==
X-Received: by 2002:a05:6a20:7489:b0:13e:3a7a:2d70 with SMTP id
 p9-20020a056a20748900b0013e3a7a2d70mr2963434pzd.0.1691580040850; 
 Wed, 09 Aug 2023 04:20:40 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 e15-20020aa78c4f000000b00666e883757fsm9723242pfd.123.2023.08.09.04.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 04:20:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 21:20:36 +1000
Message-Id: <CUNZ2SOR0AMY.2H67OHTB0OVDC@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 4/7] tcg/ppc: Use PLD in tcg_out_movi for constant pool
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-5-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

On Tue Aug 8, 2023 at 1:02 PM AEST, Richard Henderson wrote:
> The prefixed instruction has a pc-relative form to use here.

I don't understand this code very well but going by existing
relocs it looks okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 61ae9d8ab7..b3b2e9874d 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -101,6 +101,10 @@
>  #define ALL_GENERAL_REGS  0xffffffffu
>  #define ALL_VECTOR_REGS   0xffffffff00000000ull
> =20
> +#ifndef R_PPC64_PCREL34
> +#define R_PPC64_PCREL34  132
> +#endif
> +
>  #define have_isel  (cpuinfo & CPUINFO_ISEL)
> =20
>  #ifndef CONFIG_SOFTMMU
> @@ -260,6 +264,19 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const =
tcg_insn_unit *target)
>      return false;
>  }
> =20
> +static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *targe=
t)
> +{
> +    const tcg_insn_unit *src_rx =3D tcg_splitwx_to_rx(src_rw);
> +    ptrdiff_t disp =3D tcg_ptr_byte_diff(target, src_rx);
> +
> +    if (disp =3D=3D sextract64(disp, 0, 34)) {
> +        src_rw[0] =3D (src_rw[0] & ~0x3ffff) | ((disp >> 16) & 0x3ffff);
> +        src_rw[1] =3D (src_rw[1] & ~0xffff) | (disp & 0xffff);
> +        return true;
> +    }
> +    return false;
> +}
> +
>  /* test if a constant matches the constraint */
>  static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
>  {
> @@ -684,6 +701,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>          return reloc_pc14(code_ptr, target);
>      case R_PPC_REL24:
>          return reloc_pc24(code_ptr, target);
> +    case R_PPC64_PCREL34:
> +        return reloc_pc34(code_ptr, target);
>      case R_PPC_ADDR16:
>          /*
>           * We are (slightly) abusing this relocation type.  In particula=
r,
> @@ -1111,6 +1130,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGTyp=
e type, TCGReg ret,
>      }
> =20
>      /* Use the constant pool, if possible.  */
> +    if (have_isa_3_10) {
> +        tcg_out_8ls_d(s, PLD, ret, 0, 0, 1);
> +        new_pool_label(s, arg, R_PPC64_PCREL34, s->code_ptr - 2, 0);
> +        return;
> +    }
>      if (!in_prologue && USE_REG_TB) {
>          new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
>                         tcg_tbrel_diff(s, NULL));


