Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 412FB78FBE0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1fn-0001zl-Ry; Fri, 01 Sep 2023 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc1fi-0001wQ-62
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:46:38 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc1ff-0001OD-Bp
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:46:37 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so3299749e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693565193; x=1694169993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwsaLX6raeY8tGZgGItUmuVH7mgRE4z3Rq6Kw2fySHg=;
 b=MQd/rli+97zCnldETU/f/tlEIdvB6b/xO5ZD/FNGRaYc0LT+Z168GLOkdVVC+3O9IY
 YYu3LW0M1e4zWwt/1jr6YyhDbt6GHUkywMcrncQ59sJ2IoaAYHe9Drboej7R2RnuR/MU
 Y2M05W9wFpZ+na2PhG+0BPf/sqmFoWzxc/B2xlCOBgHfZJQXrGo2yMQJfnPeMInyot1q
 ubEaGGDXkppDYmXEVshem1Od+pmZNPUK4QbHvehCSUpxaWCmF7ibny0xcAvu+NYhJKmu
 pGDeBTBHrhtQPaljsiFgPwvxfiS0JNiTiJAeAgRE3zuTt5QRQ3gd5E/la/gk5gFKQ0Mv
 f5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693565193; x=1694169993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwsaLX6raeY8tGZgGItUmuVH7mgRE4z3Rq6Kw2fySHg=;
 b=RTk83TrWPrpx6xK7WEnwVKB8XPDv/dv8esKpupykJSiaFzLeGsoWYjO2tejmi+9Sho
 YmFdw6y2M6LibWgiLlB8qIqC4PQb/qFbaxRmycSBsAhkbfHf3VpHzAhr9pQBxI+d66tE
 Jl1xycf2VlwnUFRjndzP7daVZcrkHsLE/nPvHhm1s1GVsNKdeUAl57MlkfiYpRAisHO2
 GuOGZo1qWm4BfGs77/1FguW21zfJuoggDBuMBLpC3LKNAKpaNZUTqfbCZeKqYOc+AOtF
 2Mez3aLdaSUzrm4Z2ee1+IqgTr+XNcuh4g3l71181xJiu4UvC+sJ22wzIllZZs4/z328
 SHAg==
X-Gm-Message-State: AOJu0Ywa01iiIswOwwJ1MgG8az3L4GUfengYWd7vs9WruYjnxQ64m0pX
 LKThqxdBE0WbdXn739Fb0Z3dBCIh1+7CAOZufZXI/A==
X-Google-Smtp-Source: AGHT+IFqtZPqmN/Sz114zmtwzLsXY0dUltFNOOBUH5OL2OriRpUKBc5nrvTerDEUDSx7mMzmnbrOC0KV69sFK9G/GQM=
X-Received: by 2002:a19:7706:0:b0:500:bf56:cca6 with SMTP id
 s6-20020a197706000000b00500bf56cca6mr1107347lfc.53.1693565192677; Fri, 01 Sep
 2023 03:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-3-philmd@linaro.org>
In-Reply-To: <20230831225607.30829-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Sep 2023 11:46:21 +0100
Message-ID: <CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT_ydZWOwC0kBkDYYYQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] target/arm: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, 
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Thu, 31 Aug 2023 at 23:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   target/arm/tcg/translate-m-nocp.c:509:18: error: declaration shadows a =
local variable [-Werror,-Wshadow]
>         TCGv_i32 tmp =3D load_cpu_field(v7m.fpdscr[M_REG_NS]);
>                  ^
>   target/arm/tcg/translate-m-nocp.c:433:14: note: previous declaration is=
 here
>     TCGv_i32 tmp;
>              ^
>   target/arm/tcg/mve_helper.c:2463:17: error: declaration shadows a local=
 variable [-Werror,-Wshadow]
>         int64_t extval =3D sextract64(src << shift, 0, 48);
>                 ^
>   target/arm/tcg/mve_helper.c:2443:18: note: previous declaration is here
>     int64_t val, extval;
>                  ^
>   target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variab=
le [-Werror,-Wshadow]
>         int ret =3D 0;
>             ^
>   target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
>     int ret;
>         ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/arm/hvf/hvf.c              | 1 -
>  target/arm/tcg/mve_helper.c       | 8 ++++----
>  target/arm/tcg/translate-m-nocp.c | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 486f90be1d..20d534faef 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1933,7 +1933,6 @@ int hvf_vcpu_exec(CPUState *cpu)
>          uint32_t rt =3D (syndrome >> 5) & 0x1f;
>          uint32_t reg =3D syndrome & SYSREG_MASK;
>          uint64_t val;
> -        int ret =3D 0;
>
>          if (isread) {
>              ret =3D hvf_sysreg_read(cpu, reg, rt);

I'm not sure this is correct.

The hvf_vcpu_exec() function is not documented, but in practice
its caller expects it to return either EXCP_DEBUG (for "this was
a guest debug exception you need to deal with") or something else
(presumably the intention being 0 for OK).

The hvf_sysreg_read() and hvf_sysreg_write() functions are also not
documented, but they return 0 on success, or 1 for a completely
unrecognized sysreg where we've raised the UNDEF exception (but
not if we raised an UNDEF exception for an unrecognized GIC sysreg --
I think this is a bug). We use this return value to decide whether
we need to advance the PC past the insn or not. It's not the same
as the return value we want to return from hvf_vcpu_exec().

So I think the correct fix here is to retain the variable as
locally scoped but give it a name that doesn't clash with the
other function-scoped variable.

> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index 403b345ea3..32087b6f0a 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -924,8 +924,8 @@ DO_1OP_IMM(vorri, DO_ORRI)
>          bool qc =3D false;                                              =
  \
>          for (e =3D 0; e < 16 / ESIZE; e++, mask >>=3D ESIZE) {          =
    \
>              bool sat =3D false;                                         =
  \
> -            TYPE r =3D FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);        =
  \
> -            mergemask(&d[H##ESIZE(e)], r, mask);                        =
\
> +            TYPE r_ =3D FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);       =
  \
> +            mergemask(&d[H##ESIZE(e)], r_, mask);                       =
\
>              qc |=3D sat & mask & 1;                                     =
  \
>          }                                                               =
\
>          if (qc) {                                                       =
\

The commit message doesn't list an error message relating to
this change and it's not immediately obvious to me what 'r'
would be shadowing here.

> @@ -2460,7 +2460,7 @@ static inline int64_t do_sqrshl48_d(int64_t src, in=
t64_t shift,
>              return extval;
>          }
>      } else if (shift < 48) {
> -        int64_t extval =3D sextract64(src << shift, 0, 48);
> +        extval =3D sextract64(src << shift, 0, 48);
>          if (!sat || src =3D=3D (extval >> shift)) {
>              return extval;
>          }
> @@ -2492,7 +2492,7 @@ static inline uint64_t do_uqrshl48_d(uint64_t src, =
int64_t shift,
>              return extval;
>          }
>      } else if (shift < 48) {
> -        uint64_t extval =3D extract64(src << shift, 0, 48);
> +        extval =3D extract64(src << shift, 0, 48);
>          if (!sat || src =3D=3D (extval >> shift)) {
>              return extval;
>          }

These two parts are good, but one of them is missing from the
listed error messages in the commit message.

> diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate=
-m-nocp.c
> index 33f6478bb9..42308c4db5 100644
> --- a/target/arm/tcg/translate-m-nocp.c
> +++ b/target/arm/tcg/translate-m-nocp.c
> @@ -506,7 +506,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int=
 regno,
>
>          gen_branch_fpInactive(s, TCG_COND_EQ, lab_active);
>          /* fpInactive case: reads as FPDSCR_NS */
> -        TCGv_i32 tmp =3D load_cpu_field(v7m.fpdscr[M_REG_NS]);
> +        tmp =3D load_cpu_field(v7m.fpdscr[M_REG_NS]);
>          storefn(s, opaque, tmp, true);
>          lab_end =3D gen_new_label();
>          tcg_gen_br(lab_end);

This one's right too.

thanks
-- PMM

