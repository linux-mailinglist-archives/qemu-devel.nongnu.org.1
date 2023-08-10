Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3D777CAB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7vB-0003Tu-GL; Thu, 10 Aug 2023 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU7v8-0003St-Vx
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:49:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU7v6-00064O-Is
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:49:54 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-522ab557632so1327029a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682591; x=1692287391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ChbaDo4JHrdqUIhP1FgikI3lYV0NsU5wBxyz0vVZKiE=;
 b=E/ywqvhU/9BsfqAX1e9WmYrzoJwxuyEDcuDHV6UmULauYtmtbkLVIGuRlsA9V72wG8
 SSyWMQ/iN00jkyUC6f2k04XSYGnWXB6VJx/hj0jp7flC904JDYVhoGVtagFp7x4NkvNZ
 FIAgOzRdEx5mXwip6D6kz3M8Dz97IAJ2V3GRKnZ8GxM4nE6IBVeVCyN3tdmC+zkUFCVV
 USftNp0knNzK8eLsEG64odqhLI7Me99Ak3R7cd3MYM2Vv49CA24puLHuxdk0yAd7h7MJ
 eDbE4E9QjJ+Ni7aCOMlpYP848a/m64rJJn20sudLVuMhmtsE8pBZdtehsk+XuiluOaX2
 krig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682591; x=1692287391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ChbaDo4JHrdqUIhP1FgikI3lYV0NsU5wBxyz0vVZKiE=;
 b=R9+M7tKcVvk9lQEevlAiTF45teFeHSJJ+UQRRpgYUOZFphj97MskiuBwLc2Bp28Rgz
 kmYAdLBjF6r288l/erTGIhyeyg1x1jc5lSOE7qYJifIrhPNdMHtf4U71j0Y/JZu1AxQg
 x/nQCn4GjH2QzJ0SPzrcvzDuJV3pwO0aUXLuIB7G4VBYM3VF9qVMRM2q+zg5Y38TWGNH
 t4Jnsgwl0Y+6wokHW7LsXEGmwwmmFEx2vt9J1Ierqd5q4Xi6SZuOODbfk//tBn0b4Wdn
 UEt63N7/g6UfyHzPqBnQYQX0pcMFUSzeqCoYnttb8PGRvVrRVPQZ+R7PQZH0PqJRJe0h
 75Ng==
X-Gm-Message-State: AOJu0YywQS+Yvz47It7TPDCKesdREoyuqr9ReZpsQt0fp3jUs9UhPxRV
 AC3URMWPHFgNgD73BNBNhfRlUlI40cj0ZzAXwey66Q==
X-Google-Smtp-Source: AGHT+IF5ParMvvbqsv13Sk0PLbq3gZz/6oIQ/20k37Kb7IQsSrKCWohMakvI6kqeo6EYuTT95rpcrrfoPoAicudkw44=
X-Received: by 2002:aa7:d0ca:0:b0:523:197c:36e0 with SMTP id
 u10-20020aa7d0ca000000b00523197c36e0mr2630395edo.19.1691682590780; Thu, 10
 Aug 2023 08:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-6-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 16:49:39 +0100
Message-ID: <CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 10 Aug 2023 at 03:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The cortex-a710 is a first generation ARMv9.0-A processor.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/system/arm/virt.rst |   1 +
>  hw/arm/virt.c            |   1 +
>  target/arm/tcg/cpu64.c   | 167 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 51cdac6841..e1697ac8f4 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -58,6 +58,7 @@ Supported guest CPU types:
>  - ``cortex-a57`` (64-bit)
>  - ``cortex-a72`` (64-bit)
>  - ``cortex-a76`` (64-bit)
> +- ``cortex-a710`` (64-bit)
>  - ``a64fx`` (64-bit)
>  - ``host`` (with KVM only)
>  - ``neoverse-n1`` (64-bit)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc2663..d1522c305d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -211,6 +211,7 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("cortex-a55"),
>      ARM_CPU_TYPE_NAME("cortex-a72"),
>      ARM_CPU_TYPE_NAME("cortex-a76"),
> +    ARM_CPU_TYPE_NAME("cortex-a710"),
>      ARM_CPU_TYPE_NAME("a64fx"),
>      ARM_CPU_TYPE_NAME("neoverse-n1"),
>      ARM_CPU_TYPE_NAME("neoverse-v1"),

Will sbsa-ref want this core ?

> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 5ca9070c14..6f555a39ce 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -700,6 +700,172 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      aarch64_add_sve_properties(obj);
>  }
>
> +static const ARMCPRegInfo cortex_a710_cp_reginfo[] = {
> +    /* TODO: trapped by HCR_EL2.TIDCP */
> +    { .name = "CPUACTLR4_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 3,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUECTLR2_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 1, .opc2 = 5,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUACTLR5_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 0,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUACTLR6_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 1,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUACTLR7_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 8, .opc2 = 2,
> +      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUPPMCR4_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 4,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUPPMCR5_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 5,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUPPMCR6_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 6,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUACTLR_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 4, .opc2 = 0,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUPOR2_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 4,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "CPUPMR2_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 8, .opc2 = 5,
> +      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> +
> +    /*
> +     * Stub RAMINDEX, as we don't actually implement caches,
> +     * BTB, or anything else with cpu internal memory.
> +     * "Read" zeros into the IDATA* and DDATA* output registers.
> +     */
> +    { .name = "RAMINDEX_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 1, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 0,
> +      .access = PL3_W, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "IDATA0_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 0,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "IDATA1_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 1,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "IDATA2_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 0, .opc2 = 2,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "DDATA0_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 0,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "DDATA1_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 1,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "DDATA2_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 1, .opc2 = 2,
> +      .access = PL3_R, .type = ARM_CP_CONST, .resetvalue = 0 },
> +};
> +
> +static void define_cortex_a710_cp_reginfo(ARMCPU *cpu)
> +{
> +    /*
> +     * The Cortex A710 has all of the Neoverse V1's IMPDEF
> +     * registers and a few more of its own.
> +     */
> +    define_arm_cp_regs(cpu, neoverse_n1_cp_reginfo);
> +    define_arm_cp_regs(cpu, neoverse_v1_cp_reginfo);
> +    define_arm_cp_regs(cpu, cortex_a710_cp_reginfo);

The TRM doesn't document the existence of these regs
from the n1 reginfo:

    { .name = "ERXPFGCDN_EL1", .state = ARM_CP_STATE_AA64,
      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 2,
      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
    { .name = "ERXPFGCTL_EL1", .state = ARM_CP_STATE_AA64,
      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 1,
      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
    { .name = "ERXPFGF_EL1", .state = ARM_CP_STATE_AA64,
      .opc0 = 3, .opc1 = 0, .crn = 15, .crm = 2, .opc2 = 0,
      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },

This one in the v1 reginfo:

    { .name = "CPUPPMCR3_EL3", .state = ARM_CP_STATE_AA64,
      .opc0 = 3, .opc1 = 6, .crn = 15, .crm = 2, .opc2 = 6,
      .access = PL3_RW, .type = ARM_CP_CONST, .resetvalue = 0 },

exists but has been renamed CPUPPMCR6_EL3, which means it's
a duplicate of an entry in your new array. Meanwhile the
A710's actual CPUPPMCR3_EL3 at 3, 0, c15, c2, 4 isn't in
your new array.

(I thought we had an assert to detect duplicate regdefs,
so I'm surprised this didn't fall over.)

> +}
> +
> +static void aarch64_a710_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cpu->dtb_compatible = "arm,cortex-a710";
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> +    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    set_feature(&cpu->env, ARM_FEATURE_PMU);
> +
> +    /* Ordered by Section B.4: AArch64 registers */
> +    cpu->midr = 0x412FD471;          /* r2p1 */
> +    cpu->revidr = cpu->midr;         /* mirror midr: "no significance" */

The bit about "no significance" is just the boilerplate text from
the architecture manual. I think we should continue our usual
practice of setting the revidr to 0.

For this particular core you can see in the Cortex-A710
Software Developer Errata Notice that the REVIDR appears
to be a collection of bits which are 1 when some erratum
has been fixed in this particular part without having
bumped the rNpN value:
https://developer.arm.com/documentation/SDEN1775101/latest

This is for an A15 erratum, but it does suggest that
guests probably aren't doing that "is revidr == midr"
check before looking at revidr bits:
 https://elixir.bootlin.com/linux/latest/source/arch/arm/kernel/smp_tlb.c#L94

> +    cpu->isar.id_pfr0  = 0x21110131;
> +    cpu->isar.id_pfr1  = 0x00010000; /* GIC filled in later */
> +    cpu->isar.id_dfr0  = 0x06011099; /* w/o FEAT_TRF */

You don't have to suppress FEAT_TRF manually, we do
it in cpu.c.

> +    cpu->id_afr0       = 0;
> +    cpu->isar.id_mmfr0 = 0x10201105;
> +    cpu->isar.id_mmfr1 = 0x40000000;
> +    cpu->isar.id_mmfr2 = 0x01260000;
> +    cpu->isar.id_mmfr3 = 0x02122211;
> +    cpu->isar.id_isar0 = 0x02101110;
> +    cpu->isar.id_isar1 = 0x13112111;
> +    cpu->isar.id_isar2 = 0x21232042;
> +    cpu->isar.id_isar3 = 0x01112131;
> +    cpu->isar.id_isar4 = 0x00010142;
> +    cpu->isar.id_isar5 = 0x11011121;

For isar5 we could say /* with Crypto */

> +    cpu->isar.id_mmfr4 = 0x21021110;

I don't think we implement HPDS == 2 (that's FEAT_HPDS2).
I guess we should push it down to HPDS 1 only in cpu.c
for now. (Or implement it, it's probably simple.)

> +    cpu->isar.id_isar6 = 0x01111111;
> +    cpu->isar.mvfr0    = 0x10110222;
> +    cpu->isar.mvfr1    = 0x13211111;
> +    cpu->isar.mvfr2    = 0x00000043;
> +    cpu->isar.id_pfr2  = 0x00000011;
> +    /* GIC filled in later; w/o FEAT_MPAM */
> +    cpu->isar.id_aa64pfr0  = 0x1201101120111112ull;

We clear out MPAM in cpu.c so you don't need to do it manually.

> +    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
> +    cpu->isar.id_aa64zfr0  = 0x0000110100110021ull;

/* with Crypto */

> +    cpu->isar.id_aa64dfr0  = 0x000000f210305619ull; /* w/o FEAT_{TRF,TRBE} */

We already clear TRACEFILT in cpu.c. We should also
clear out TRACEBUFFER I guess.

Unless I'm miscounting bits, you have a '2' in the
RES0 [35:32] bit field.

> +    cpu->isar.id_aa64dfr1  = 0;
> +    cpu->id_aa64afr0       = 0;
> +    cpu->id_aa64afr1       = 0;
> +    cpu->isar.id_aa64isar0 = 0x0221111110212120ull;

/* with crypto */ again I guess

> +    cpu->isar.id_aa64isar1 = 0x0010111101211032ull;

should be 5 in bits [7:4] ?

> +    cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
> +    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;

This one is specifying FEAT_HPDS2 as well.

> +    cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
> +    cpu->clidr             = 0x0000002282000023ull;

I think you've miscounted with the Ttype1 and Ttype2 fields:
these are at [36:35] and [34:33], so you want 14 instead
of 22 as the first non-zero nibbles.

> +    cpu->gm_blocksize      = 4;
> +    cpu->ctr               = 0x00000004b444c004ull; /* with DIC set */

Why set DIC? The h/w doesn't.

> +    cpu->dcz_blocksize     = 4;
> +    /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_0006_003f */
> +
> +    /* Section B.5.2: PMCR_EL0 */
> +    cpu->isar.reset_pmcr_el0 = 0xa000;  /* with 20 counters */
> +
> +    /* Section B.6.7: ICH_VTR_EL2 */
> +    cpu->gic_num_lrs = 4;
> +    cpu->gic_vpribits = 5;
> +    cpu->gic_vprebits = 5;
> +    cpu->gic_pribits = 5;
> +
> +    /* Section 14: Scalable Vector Extensions support */
> +    cpu->sve_vq.supported = 1 << 0;  /* 128bit */
> +
> +    /*
> +     * The cortex-a710 TRM does not list CCSIDR values.
> +     * The layout of the cache is in text in Table 7-1 (L1-I),
> +     * Table 8-1 (L1-D), and Table 9-1 (L2).
> +     *
> +     * L1: 4-way set associative 64-byte line size, total either 32K or 64K.
> +     * We pick 64K, so this has 256 sets.
> +     *
> +     * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
> +     * We pick 512K, so this has 1024 sets.
> +     */
> +    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
> +    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
> +    cpu->ccsidr[2] = 0x000003ff0000003aull; /* 512KB L2 cache */

I was too lazy to do this for neoverse-v1, so I don't insist
on it here, but if we're going to find ourselves calculating
new-format ccsidr values by hand for each new CPU, I wonder if we
should define a macro that takes numsets, assoc, linesize,
subtracts 1 where relevant, and shifts them into the right bit
fields? (Shame the preprocessor can't do a log2() operation ;-))

> +
> +    /* ??? Not documented -- copied from neoverse-v1 */
> +    cpu->reset_sctlr = 0x30c50838;
> +
> +    define_cortex_a710_cp_reginfo(cpu);
> +    aarch64_add_pauth_properties(obj);
> +    aarch64_add_sve_properties(obj);
> +}
> +
>  /*
>   * -cpu max: a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
> @@ -889,6 +1055,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
>      { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
>      { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
>      { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
> +    { .name = "cortex-a710",        .initfn = aarch64_a710_initfn },
>      { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
>      { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
>      { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
> --
> 2.34.1

thanks
-- PMM

