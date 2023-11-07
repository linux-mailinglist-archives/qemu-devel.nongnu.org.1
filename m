Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E317E3FBB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:09:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lmp-0002Ud-UI; Tue, 07 Nov 2023 08:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0Llt-0001Ym-0h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:05:34 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0Llr-0006Re-1r
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:05:32 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso837130166b.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699362329; x=1699967129; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwNbYDewSgt9gS5KTYiSLd/LSIJRPEA6Og9j6BY5gWA=;
 b=XowRVwW4x6zpKiqxmtGCT7MrIn1kyVlfJBnbI9R+8UfyVPRxgDJzPYqyY3xgpQPvQC
 gKXNZFursn+ThX9I6Xv+nAbLAHCu48rh1pLI19OuJIWKpjfQ4ur+SLdHavO88e8R8b4j
 GO/ZxrITOuhWmn00VeEMYiIGreS4Dg97iX9HW6Fp699IhoqnMiaysLgp/z3bGvcMxr+4
 qPzQaKE0NAp+QkYi1yZh+gSb+IrXTthS35p7NqF8fvJRBXpClZQYkpCX89ziydRP9DOo
 UygdBFpSm/K5MDmYgc+NbjtkXMKPf9MQWZNf4yYLVZXl0J8BYQuHEwab3p06OkupOpL9
 H0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362329; x=1699967129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwNbYDewSgt9gS5KTYiSLd/LSIJRPEA6Og9j6BY5gWA=;
 b=p3Hz+WakMw7NwKovD/uHx3kcqVQKmNdaW1Ab4lk/cxrfgF332YyPqjcEyB27AzowwF
 90EEA4LhUFeIVK54Z1YrmH0YP9ZXXgiZCMc99MA2msOx0Vb0wORv/wjy6v80U7mvWsEj
 rau4884tBXTT0Zx2SV1McfnADORCHk5xAWh7DX0J3q82Piuh2kKICJn0yskfpyi2h+Lt
 Vl+BMzAvIiLvguY9EQXcfdJnNZiMrJShAhvXM1Qcqp0+Nj9uFFwyPSEhpu3BBwWl6/EZ
 Zi9RvtRG2rgT0dmqIegA+eHxKkLBP7c1bdfWqwN3eeZdg2XF9STOAaUs52lgrIroE0Xt
 EB1w==
X-Gm-Message-State: AOJu0Yzukbf5WQ8z4Uee9PMm2A14p7ytuJ6ut6QBHF4fcNsp3J5EHyTs
 HwNA5Xyu1zqE/UOXVTFL8zxnR2vdYfVeM3FpYn2zGQ==
X-Google-Smtp-Source: AGHT+IHhTMkfjqIjVeI5bhXPCrB1RBo9x/TuTG87rXo/TepM0Z1MfaNrMo8BeDceBEPoYrApgCXJSAP9dVkuN/cAQGo=
X-Received: by 2002:a17:907:72ca:b0:9de:5e14:d934 with SMTP id
 du10-20020a17090772ca00b009de5e14d934mr8870547ejc.51.1699362329263; Tue, 07
 Nov 2023 05:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20231107105145.2916124-1-alex.bennee@linaro.org>
In-Reply-To: <20231107105145.2916124-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 13:05:17 +0000
Message-ID: <CAFEAcA8wfW7kZuyjJTyXEdAvN5E-YEvu=97+xxaiwtEQGAj5GQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: mark the 32bit alias of PAR when LPAE enabled
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 7 Nov 2023 at 10:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> We also mark it ARM_CP_NO_GDB so we avoid duplicate PAR's in the
> system register XML we send to gdb.
>
> Suggested-by: <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - only set ARM_CP_NO_GDB when no LPAE enabled
>   - also mark as AP_CP_ALIAS
> ---
>  target/arm/helper.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5dc0d20a84..80a35b29bb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3722,20 +3722,6 @@ static void ats_write64(CPUARMState *env, const AR=
MCPRegInfo *ri,
>  }
>  #endif
>
> -static const ARMCPRegInfo vapa_cp_reginfo[] =3D {
> -    { .name =3D "PAR", .cp =3D 15, .crn =3D 7, .crm =3D 4, .opc1 =3D 0, =
.opc2 =3D 0,
> -      .access =3D PL1_RW, .resetvalue =3D 0,
> -      .bank_fieldoffsets =3D { offsetoflow32(CPUARMState, cp15.par_s),
> -                             offsetoflow32(CPUARMState, cp15.par_ns) },
> -      .writefn =3D par_write },
> -#ifndef CONFIG_USER_ONLY
> -    /* This underdecoding is safe because the reginfo is NO_RAW. */
> -    { .name =3D "ATS", .cp =3D 15, .crn =3D 7, .crm =3D 8, .opc1 =3D 0, =
.opc2 =3D CP_ANY,
> -      .access =3D PL1_W, .accessfn =3D ats_access,
> -      .writefn =3D ats_write, .type =3D ARM_CP_NO_RAW | ARM_CP_RAISES_EX=
C },
> -#endif
> -};
> -
>  /* Return basic MPU access permission bits.  */
>  static uint32_t simple_mpu_ap_bits(uint32_t val)
>  {
> @@ -8904,6 +8890,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, generic_timer_cp_reginfo);
>      }
>      if (arm_feature(env, ARM_FEATURE_VAPA)) {
> +        ARMCPRegInfo vapa_cp_reginfo[] =3D {
> +            { .name =3D "PAR", .cp =3D 15, .crn =3D 7, .crm =3D 4, .opc1=
 =3D 0, .opc2 =3D 0,
> +              .access =3D PL1_RW, .resetvalue =3D 0,
> +              .bank_fieldoffsets =3D { offsetoflow32(CPUARMState, cp15.p=
ar_s),
> +                                     offsetoflow32(CPUARMState, cp15.par=
_ns) },
> +              .writefn =3D par_write},
> +#ifndef CONFIG_USER_ONLY
> +            /* This underdecoding is safe because the reginfo is NO_RAW.=
 */
> +            { .name =3D "ATS", .cp =3D 15, .crn =3D 7, .crm =3D 8, .opc1=
 =3D 0, .opc2 =3D CP_ANY,
> +              .access =3D PL1_W, .accessfn =3D ats_access,
> +              .writefn =3D ats_write, .type =3D ARM_CP_NO_RAW | ARM_CP_R=
AISES_EXC },
> +#endif
> +        };
> +
> +        /* When LPAE exists the PAR register is an alias */

We could be a little more explicit:
 /*
  * When LPAE exists this 32-bit PAR register is an alias of the
  * 64-bit AArch32 PAR register defined in lpae_cp_reginfo[]
  */

> +        if (arm_feature(env, ARM_FEATURE_LPAE)) {
> +            vapa_cp_reginfo[0].type =3D ARM_CP_ALIAS | ARM_CP_NO_GDB;
> +        }
>          define_arm_cp_regs(cpu, vapa_cp_reginfo);
>      }
>      if (arm_feature(env, ARM_FEATURE_CACHE_TEST_CLEAN)) {

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

