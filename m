Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944A725CB0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qzx-0003dn-AJ; Wed, 07 Jun 2023 07:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qzr-0003XM-LV; Wed, 07 Jun 2023 07:06:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qzo-0004k4-Rn; Wed, 07 Jun 2023 07:06:35 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-977e7d6945aso505921866b.2; 
 Wed, 07 Jun 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686135987; x=1688727987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2cMy1otWPsHOeUK6OYWVKw+FkrFxzqEE8sxNl3CDmE=;
 b=TWaEpM1rAKhTOT1DdftP1VY8x7xeJ3TMDlfXnc41Ot2i1s5SIRkBKWBMa8o/ER7sEM
 8IixGu9SfbEcatpu//ZiZhcn5ejZ3QoIglO1583GoqOMkLs6o4XNr8kG2rhOAB+NCO+N
 HZ8wPXt90UhTu8+dqTTSM1Gj4RaA10it0DDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686135987; x=1688727987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2cMy1otWPsHOeUK6OYWVKw+FkrFxzqEE8sxNl3CDmE=;
 b=IQR1i9oaE6wz0xw4tuZqYrKct76fO3PNr5mlCucQsWpr6ak1eGutptkTi8ec5G57cO
 1QyBtLBCXuft3ySF2m8cKg1DS5udjGBW4aep79xoCeKsbjLn9bYRHbPg9eGuD0z+H8eg
 34/6UWjwqSthcQa6MB5qMg1Zl/WA/xFc46OY6ofmFyHXIxh73/OKChoiRT2nYYEWlW5d
 FtWgZu7UxBGCUq80UacuI9SvW8NzdIAr+7lavoC+f4a1JZuDpwhAlc6FZbA53cRUSqZz
 Gpt+MzqcZkYGnEa0y4jVp7bNdcvNI7cIuudJR2+ZyQ6l2JmGciQKx917pihzw+ex/aS/
 AAGA==
X-Gm-Message-State: AC+VfDyBlcKP+wg0aSKL32q6C07h2WGeS+mKu017Y+yhZ5ofwgqjW76o
 68vDSaaq7ue5u6CPcSPO3HwYolf48dmuQhKFddE=
X-Google-Smtp-Source: ACHHUZ4rR1IX055OqnfBI6utDSG+kcO56zQvRDPnFUYTc/Rjl1iKXfyHhX4wZOoe1ee81jClMmKUyhdyQrmxkTt8i+c=
X-Received: by 2002:a17:907:e9f:b0:966:53b1:b32a with SMTP id
 ho31-20020a1709070e9f00b0096653b1b32amr5804993ejc.53.1686135986718; Wed, 07
 Jun 2023 04:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-13-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 11:06:13 +0000
Message-ID: <CACPK8Xce052zza6XvQYijhPEL7NDqS3cKW0x3r0DGiJENYXDGw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 7 Jun 2023 at 04:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Cortex A7 CPUs with an FPU implementing VFPv4 without NEON support
> have 16 64-bit FPU registers and not 32 registers. Let users set the
> number of VFP registers with a CPU property.
>
> The primary use case of this property is for the Cortex A7 of the
> Aspeed AST2600 SoC.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

You saw a crash with a buildroot image without this change, as I recall?

The logic is a bit hard to follow but it is good to see a fix.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  target/arm/cpu.h        |  2 ++
>  hw/arm/aspeed_ast2600.c |  2 ++
>  target/arm/cpu.c        | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d469a2637b32..79f1a96ddf39 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -916,6 +916,8 @@ struct ArchCPU {
>      bool has_pmu;
>      /* CPU has VFP */
>      bool has_vfp;
> +    /* CPU has 32 VFP registers */
> +    bool has_vfp_d32;
>      /* CPU has Neon */
>      bool has_neon;
>      /* CPU has M-profile DSP extension */
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 1bf12461481c..a8b3a8065a11 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -316,6 +316,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>                                  &error_abort);
>          object_property_set_bool(OBJECT(&s->cpu[i]), "neon", false,
>                                  &error_abort);
> +        object_property_set_bool(OBJECT(&s->cpu[i]), "vfp-d32", false,
> +                                &error_abort);
>          object_property_set_link(OBJECT(&s->cpu[i]), "memory",
>                                   OBJECT(s->memory), &error_abort);
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5182ed0c9113..74fe6ae78192 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1275,6 +1275,9 @@ static Property arm_cpu_cfgend_property =3D
>  static Property arm_cpu_has_vfp_property =3D
>              DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
>
> +static Property arm_cpu_has_vfp_d32_property =3D
> +            DEFINE_PROP_BOOL("vfp-d32", ARMCPU, has_vfp_d32, true);
> +
>  static Property arm_cpu_has_neon_property =3D
>              DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
>
> @@ -1406,6 +1409,22 @@ void arm_cpu_post_init(Object *obj)
>          }
>      }
>
> +    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
> +        cpu->has_vfp_d32 =3D true;
> +        if (!kvm_enabled()) {
> +            /*
> +             * The permitted values of the SIMDReg bits [3:0] on
> +             * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
> +             * make sure that has_vfp_d32 can not be set to false.
> +             */
> +            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
> +                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
> +                qdev_property_add_static(DEVICE(obj),
> +                                         &arm_cpu_has_vfp_d32_property);
> +            }
> +        }
> +    }
> +
>      if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>          cpu->has_neon =3D true;
>          if (!kvm_enabled()) {
> @@ -1672,6 +1691,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
>
> +    if (cpu->has_vfp_d32 !=3D cpu->has_neon) {
> +        error_setg(errp, "ARM CPUs must have both VFP-D32 and Neon or ne=
ither");
> +        return;
> +    }
> +
> +   if (!cpu->has_vfp_d32) {
> +        uint32_t u;
> +
> +        u =3D cpu->isar.mvfr0;
> +        u =3D FIELD_DP32(u, MVFR0, SIMDREG, 1); /* 16 registers */
> +        cpu->isar.mvfr0 =3D u;
> +    }
> +
>      if (!cpu->has_vfp) {
>          uint64_t t;
>          uint32_t u;
> --
> 2.40.1
>

