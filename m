Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0C7CC5E3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsl0Y-0002VS-7w; Tue, 17 Oct 2023 10:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsl0S-0002UZ-FE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:25:12 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsl0L-0008PJ-SQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:25:11 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507b9408c61so1668377e87.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697552693; x=1698157493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP+Bc7Qr1lCxWV8ncOwMur5ivxl1AKWpiTU4zWjFipk=;
 b=YwbDJMi1aoNgPn56Z/4mtWDVqEgdCjX2WtoAMz8BYwKi7T7tGFWEJqiAxL+ukAMFFx
 AGT3BNOrTaRbvgPGNFbm/uhSghRJrFB4jriNz4ySebIT8iI2hDT+YOWclb3I9rgeslhN
 jqMdckew3tcVTH0f3qIJXiyO6toaRIW6LWlFiAtUpkvDS3fotM3pGaVBOCTH/PZABJB4
 zZORtCUli8PphMfHvDzGaPzR9tsszLGKPbIRs1FWfaaZ7mQ8bpVdIV3nbJSdF5TNjq1q
 K1agE75uGj+yUAaEmRb6gFeQ0LM26S1NLITpoxm3HXsdYlg27rSrytI+INiQe/Ha12o3
 huBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552693; x=1698157493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VP+Bc7Qr1lCxWV8ncOwMur5ivxl1AKWpiTU4zWjFipk=;
 b=qRi2Phrb166o7SV3+yBNByJaD2+ovj4looQ2Csw34xzD1FtZWEScUZtZbT+A1Xmw8z
 mgRoiFQa+LBEAGZi+fMjOJ096x5nMJ1XvM7mOCpjbwjmfFC9ucbKLaxa6jYUE2/DViQL
 ot791LcQ4mC0Jv2cegcZrM7FaTK9gH5cKOICuAZuRvvrj2I/SCJQeG1r+zLXA7NopqRN
 TtZouKQEhb52QLI58dZeUdfhsLExve6/4AsS/1nbJMh7PEvom2pm3FXTInmjG7t0K+H4
 JijMMkGF67t7SFoPh7gDeRlwbcrKUAWzMJn4wDol3QeyDH3JNy71qmCNQ3M7q5/zw81t
 2mGw==
X-Gm-Message-State: AOJu0YzuQwd2jGr+Zy5V5NuZ9XnGUZq6K1TnA9Zeajlmxnvvgy3x40nO
 iTZvAcr8qda+Za0kntd5jm+D1bk5RUVs+8IwTKqrNg==
X-Google-Smtp-Source: AGHT+IG0WN+T6Xzp962N7hB/W9C45vJqjHIPR/MUEiCnt7vZem+j2CAlH2+DUYcY1BjE96+zaekU9NZapamnPIcKDZ0=
X-Received: by 2002:a05:6512:3b0c:b0:507:9693:12aa with SMTP id
 f12-20020a0565123b0c00b00507969312aamr2572573lfv.15.1697552693482; Tue, 17
 Oct 2023 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
 <20230915185453.1871167-3-peter.maydell@linaro.org>
 <87edhtbbod.fsf@linaro.org>
In-Reply-To: <87edhtbbod.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 15:24:42 +0100
Message-ID: <CAFEAcA9pbOuo0uRXLMCngkbF+jpDKRivZ=y66xn1KHunC--zrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Implement Neoverse N2 CPU model
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Tue, 17 Oct 2023 at 14:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Implement a model of the Neoverse N2 CPU. This is an Armv9.0-A
> > processor very similar to the Cortex-A710. The differences are:
> >  * no FEAT_EVT
> >  * FEAT_DGH (data gathering hint)
> >  * FEAT_NV (not yet implemented in QEMU)
> >  * Statistical Profiling Extension (not implemented in QEMU)
> >  * 48 bit physical address range, not 40
> >  * CTR_EL0.DIC =3D 1 (no explicit icache cleaning needed)
> >  * PMCR_EL0.N =3D 6 (always 6 PMU counters, not 20)
> >
> > Because it has 48-bit physical address support, we can use
> > this CPU in the sbsa-ref board as well as the virt board.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/system/arm/virt.rst |   1 +
> >  hw/arm/sbsa-ref.c        |   1 +
> >  hw/arm/virt.c            |   1 +
> >  target/arm/tcg/cpu64.c   | 103 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 106 insertions(+)
> >
> > diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> > index e1697ac8f48..7c4c80180c6 100644
> > --- a/docs/system/arm/virt.rst
> > +++ b/docs/system/arm/virt.rst
> > @@ -63,6 +63,7 @@ Supported guest CPU types:
> >  - ``host`` (with KVM only)
> >  - ``neoverse-n1`` (64-bit)
> >  - ``neoverse-v1`` (64-bit)
> > +- ``neoverse-n2`` (64-bit)
> >  - ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
> >
> >  Note that the default is ``cortex-a15``, so for an AArch64 guest you m=
ust
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index bc89eb48062..4db287287e1 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -154,6 +154,7 @@ static const char * const valid_cpus[] =3D {
> >      ARM_CPU_TYPE_NAME("cortex-a72"),
> >      ARM_CPU_TYPE_NAME("neoverse-n1"),
> >      ARM_CPU_TYPE_NAME("neoverse-v1"),
> > +    ARM_CPU_TYPE_NAME("neoverse-n2"),
> >      ARM_CPU_TYPE_NAME("max"),
> >  };
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 8ad78b23c24..42253462735 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -215,6 +215,7 @@ static const char *valid_cpus[] =3D {
> >      ARM_CPU_TYPE_NAME("a64fx"),
> >      ARM_CPU_TYPE_NAME("neoverse-n1"),
> >      ARM_CPU_TYPE_NAME("neoverse-v1"),
> > +    ARM_CPU_TYPE_NAME("neoverse-n2"),
> >  #endif
> >      ARM_CPU_TYPE_NAME("cortex-a53"),
> >      ARM_CPU_TYPE_NAME("cortex-a57"),
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index ea43cf3c1ee..370cc82f0ef 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -963,6 +963,108 @@ static void aarch64_a710_initfn(Object *obj)
> >      aarch64_add_sve_properties(obj);
> >  }
> >
> > +/* Extra IMPDEF regs in the N2 beyond those in the A710 */
> > +static const ARMCPRegInfo neoverse_n2_cp_reginfo[] =3D {
> > +    { .name =3D "CPURNDBR_EL3", .state =3D ARM_CP_STATE_AA64,
> > +      .opc0 =3D 3, .opc1 =3D 6, .crn =3D 15, .crm =3D 3, .opc2 =3D 0,
> > +      .access =3D PL3_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
> > +    { .name =3D "CPURNDPEID_EL3", .state =3D ARM_CP_STATE_AA64,
> > +      .opc0 =3D 3, .opc1 =3D 6, .crn =3D 15, .crm =3D 3, .opc2 =3D 1,
> > +      .access =3D PL3_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
> > +};
> > +
> > +static void aarch64_neoverse_n2_initfn(Object *obj)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(obj);
> > +
> > +    cpu->dtb_compatible =3D "arm,neoverse-n2";
> > +    set_feature(&cpu->env, ARM_FEATURE_V8);
> > +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> > +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> > +    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> > +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> > +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> > +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> > +    set_feature(&cpu->env, ARM_FEATURE_PMU);
> > +
> > +    /* Ordered by Section B.5: AArch64 ID registers */
> > +    cpu->midr          =3D 0x410FD493; /* r0p3 */
> > +    cpu->revidr        =3D 0;
> > +    cpu->isar.id_pfr0  =3D 0x21110131;
> > +    cpu->isar.id_pfr1  =3D 0x00010000; /* GIC filled in later */
> > +    cpu->isar.id_dfr0  =3D 0x16011099;
> > +    cpu->id_afr0       =3D 0;
> > +    cpu->isar.id_mmfr0 =3D 0x10201105;
> > +    cpu->isar.id_mmfr1 =3D 0x40000000;
> > +    cpu->isar.id_mmfr2 =3D 0x01260000;
> > +    cpu->isar.id_mmfr3 =3D 0x02122211;
> > +    cpu->isar.id_isar0 =3D 0x02101110;
> > +    cpu->isar.id_isar1 =3D 0x13112111;
> > +    cpu->isar.id_isar2 =3D 0x21232042;
> > +    cpu->isar.id_isar3 =3D 0x01112131;
> > +    cpu->isar.id_isar4 =3D 0x00010142;
> > +    cpu->isar.id_isar5 =3D 0x11011121; /* with Crypto */
> > +    cpu->isar.id_mmfr4 =3D 0x01021110;
> > +    cpu->isar.id_isar6 =3D 0x01111111;
> > +    cpu->isar.mvfr0    =3D 0x10110222;
> > +    cpu->isar.mvfr1    =3D 0x13211111;
> > +    cpu->isar.mvfr2    =3D 0x00000043;
> > +    cpu->isar.id_pfr2  =3D 0x00000011;
> > +    cpu->isar.id_aa64pfr0  =3D 0x1201111120111112ull; /* GIC filled in=
 later */
> > +    cpu->isar.id_aa64pfr1  =3D 0x0000000000000221ull;
> > +    cpu->isar.id_aa64zfr0  =3D 0x0000110100110021ull; /* with Crypto *=
/
> > +    cpu->isar.id_aa64dfr0  =3D 0x000011f210305619ull;
> > +    cpu->isar.id_aa64dfr1  =3D 0;
> > +    cpu->id_aa64afr0       =3D 0;
> > +    cpu->id_aa64afr1       =3D 0;
> > +    cpu->isar.id_aa64isar0 =3D 0x0221111110212120ull; /* with Crypto *=
/
> > +    cpu->isar.id_aa64isar1 =3D 0x0011111101211052ull;
> > +    cpu->isar.id_aa64mmfr0 =3D 0x0000022200101125ull;
> > +    cpu->isar.id_aa64mmfr1 =3D 0x0000000010212122ull;
> > +    cpu->isar.id_aa64mmfr2 =3D 0x1221011112101011ull;
> > +    cpu->clidr             =3D 0x0000001482000023ull;
> > +    cpu->gm_blocksize      =3D 4;
> > +    cpu->ctr               =3D 0x00000004b444c004ull;
> > +    cpu->dcz_blocksize     =3D 4;
> > +    /* TODO FEAT_MPAM: mpamidr_el1 =3D 0x0000_0001_001e_01ff */
>
> Jonathan mentioned he was hacking about with MPAM so if there is a stub
> implementation of the fields it would be nice to add them.

I'm just following the existing A710 code here. There isn't
a stub implementation of the fields, which is why there's
just a TODO comment documenting the ID register value.

> > +
> > +    /* Section B.7.2: PMCR_EL0 */
> > +    cpu->isar.reset_pmcr_el0 =3D 0x3000;  /* with 6 counters */
> > +
> > +    /* Section B.8.9: ICH_VTR_EL2 */
> > +    cpu->gic_num_lrs =3D 4;
> > +    cpu->gic_vpribits =3D 5;
> > +    cpu->gic_vprebits =3D 5;
> > +    cpu->gic_pribits =3D 5;
> > +
> > +    /* Section 14: Scalable Vector Extensions support */
> > +    cpu->sve_vq.supported =3D 1 << 0;  /* 128bit */
> > +
> > +    /*
> > +     * The Neoverse N2 TRM does not list CCSIDR values.  The layout of
> > +     * the caches are in text in Table 7-1, Table 8-1, and Table 9-1.
> > +     *
> > +     * L1: 4-way set associative 64-byte line size, total 64K.
> > +     * L2: 8-way set associative 64 byte line size, total either 512K =
or 1024K.
> > +     */
> > +    cpu->ccsidr[0] =3D make_ccsidr64(4, 64, 64 * KiB);   /* L1 dcache =
*/
> > +    cpu->ccsidr[1] =3D cpu->ccsidr[0];                   /* L1 icache =
*/
> > +    cpu->ccsidr[2] =3D make_ccsidr64(8, 64, 512 * KiB);  /* L2 cache *=
/
> > +
> > +    /* FIXME: Not documented -- copied from neoverse-v1 */
> > +    cpu->reset_sctlr =3D 0x30c50838;
>
> Hmm reset_sctlr might need to be bigger because being used for sctlr_el3
> is a 64 bit entity which has a number of fields:

In theory, yes. In practice, only if we get to a point where we
want to set some bit in the top 32 bits, which we don't yet.

>
>   - DSSBS,bit[44] to have some sort of impdef value
>   - the others all look like architecturally UNKNOWN values
>
> Otherwise I think this is:
>
>   - 3 - RES1 29:28
>   - 0 - RES0 + I assume LE EE bit
>   - c - RES1 23, EIS 22 (architecturally UNKNOWN on reset)
>   - 5 - RES1 18, 16
>   - 0 - RES0 15:14, EnDB 13 (architecturally UNKNOWN on reset), I 12 RES0
>   - 8 - EOS 11 (architecturally UNKNOWN on reset)
>   - 3 - RES1 5:4
>   - 8 - SA 3 (architecturally UNKNOWN on reset)
>
> It's a little confusing because the language describing these
> architecturally unknown states refers to resetting to EL3 (I assume a
> decent firmware would make sure everything is set correctly). Which
> makes me wonder if reset_sctlr is really "sane values for a direct
> kernel boot"?

It's the hardware reset value, at least nominally speaking.
We use the value for our SCTLR_EL1 if we aren't emulating EL2 or EL3,
which means we diverge a little from the hardware which probably doesn't
support an EL1-only config.

To the extent that we need to set values here for kernel boot, we would
do that in hw/arm/boot.c. But mostly we don't, because the kernel sets
up the SCTLR register for the EL it is entered in.

This used to be a bit better defined on older CPUs when previous
versions of the architecture weren't so loose about values being
UNKNOWN on reset. It's unfortunate that we don't have the documented
value for whatever the IMPDEF reset value is for this CPU. In
practice, because it's IMPDEF and UNKNOWN it doesn't matter too much --
guest software will set it as needed. The value used here is "safe"
because it's one we already use for other CPUs.

> > +
> > +    /*
> > +     * The Neoverse N2 has all of the Cortex-A710 IMPDEF registers,
> > +     * and a few more RNG related ones.
> > +     */
> > +    define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);
> > +    define_arm_cp_regs(cpu, neoverse_n2_cp_reginfo);
> > +
> > +    aarch64_add_pauth_properties(obj);
> > +    aarch64_add_sve_properties(obj);
> > +}
> > +
> >  /*
> >   * -cpu max: a CPU with as many features enabled as our emulation supp=
orts.
> >   * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c=
;
> > @@ -1159,6 +1261,7 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
> >      { .name =3D "a64fx",              .initfn =3D aarch64_a64fx_initfn=
 },
> >      { .name =3D "neoverse-n1",        .initfn =3D aarch64_neoverse_n1_=
initfn },
> >      { .name =3D "neoverse-v1",        .initfn =3D aarch64_neoverse_v1_=
initfn },
> > +    { .name =3D "neoverse-n2",        .initfn =3D aarch64_neoverse_n2_=
initfn },
> >  };
> >
> >  static void aarch64_cpu_register_types(void)

thanks
-- PMM

