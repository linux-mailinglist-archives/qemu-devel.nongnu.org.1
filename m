Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6847A12CE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 03:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgxOZ-0004a3-Gm; Thu, 14 Sep 2023 21:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxOX-0004Zr-TI; Thu, 14 Sep 2023 21:13:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxOV-00083M-LK; Thu, 14 Sep 2023 21:13:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso12955475ad.0; 
 Thu, 14 Sep 2023 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694740394; x=1695345194; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssdLI8uuzpET2t77s60vQQVZHhENjtHfcO48jXVtQ3g=;
 b=f20Kpq0UwAbeFLz5fXFrBLThbp8fdBW2+m7BKRemoH3fm9+4srokVEHHTTBg9x6Otw
 1E3ZlpEBUcfmyQtL5YHu0GzaOIWURYuJf0s+PIot1LPVKOOMw85hF+D5IQ3odKjxBt8X
 YqFAE7DeaOzzlIwBSzT1RpF4tICcdX8XwC+2Ju0y9t7ZvVMPNI19Zcjy29sKn3S0GVP+
 ffQJsUQLDgvn12QFQ4C4EGRVJD+QRGYnyJIBI8SruHpo64TMBEdo4n03xQVpENHj7D9L
 vIlE0DZgKNuMOd2lAL/1vMI3Xbyg28gCQ8L0YKM6wR1RH9q5Ib7vbG0uTCl+OW4wzsRg
 0PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694740394; x=1695345194;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ssdLI8uuzpET2t77s60vQQVZHhENjtHfcO48jXVtQ3g=;
 b=BsIWn9rpbogDX90QWOn9SGTfhNZ2c40W8EcQOj/zD1BgxFEwLtcE8qUhSBrVLr4RlX
 FO5Ud5fYpeoPAQNJbl6j+B27mCjjt92vEA5g0zJ9MyEg8k2tQ0B5nXQmjUw7d8gVKqSs
 nyNL8OeLaXiglrOTwccI+EIGTqZP80g6F1dBwoXBWHf5W9IkrE0lQiUQxDhbp0JGauFo
 yIVxVBkLG8gPYGNfhDLMpdy5T3jW6CeSfppNTw0Sf9oxKarcqJIj2L+nTstUQwFBqcE5
 hU+SiEE79KURito+OjbGNocsuh6cp28QirFcNQPFxJcGcz8ccbKyzqkOYYOkzFhJfiFv
 sSMQ==
X-Gm-Message-State: AOJu0YykzDBgO3p8QTzdRkTLYFsxi8W+lE9FAN9CsyC04CQ0AaHbedtm
 SOr6nDVFr1G9/c5QM3LfoTc=
X-Google-Smtp-Source: AGHT+IEqq8/nF9jALWuJkQaAqOQM5TWHfOQrWzj7tFX2QquW4XrNm7EWjN6BJgb5YJ9Hl+IrVHb6eg==
X-Received: by 2002:a17:903:32ca:b0:1c1:f3f8:3949 with SMTP id
 i10-20020a17090332ca00b001c1f3f83949mr320903plr.1.1694740393637; 
 Thu, 14 Sep 2023 18:13:13 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 o10-20020a170902d4ca00b001bf3bdbceb5sm2191520plg.134.2023.09.14.18.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 18:13:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Sep 2023 11:13:07 +1000
Message-Id: <CVJ3BU3MZKOR.1SBA8KVQYWOXL@wheely>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 3/4] target/ppc: Add clrbhrb and mfbhrbe instructions
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202447.3381835-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230912202447.3381835-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Wed Sep 13, 2023 at 6:24 AM AEST, Glenn Miles wrote:
> Add support for the clrbhrb and mfbhrbe instructions.
>
> Since neither instruction is believed to be critical to
> performance, both instructions were implemented using helper
> functions.
>
> Access to both instructions is controlled by bits in the
> HFSCR (for privileged state) and MMCR0 (for problem state).
> A new function, helper_mmcr0_facility_check, was added for
> checking MMCR0[BHRBA] and raising a facility_unavailable exception
> if required.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.h         |  1 +
>  target/ppc/helper.h      |  4 ++++
>  target/ppc/misc_helper.c | 43 ++++++++++++++++++++++++++++++++++++++++
>  target/ppc/translate.c   | 13 ++++++++++++
>  4 files changed, 61 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bda1afb700..ee81ede4ee 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -541,6 +541,7 @@ FIELD(MSR, LE, MSR_LE, 1)
> =20
>  /* HFSCR bits */
>  #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities=
 */
> +#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
>  #define HFSCR_IC_MSGP  0xA
> =20
>  #define DBCR0_ICMP (1 << 27)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 1a3d9a7e57..bbc32ff114 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -816,3 +816,7 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
> =20
>  DEF_HELPER_1(tbegin, void, env)
>  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
> +
> +DEF_HELPER_1(clrbhrb, void, env)
> +DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
> +
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 692d058665..45abe04f66 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -139,6 +139,17 @@ void helper_fscr_facility_check(CPUPPCState *env, ui=
nt32_t bit,
>  #endif
>  }
> =20
> +static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
> +                                 uint32_t sprn, uint32_t cause)
> +{
> +#ifdef TARGET_PPC64
> +    if (FIELD_EX64(env->msr, MSR, PR) &&
> +        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
> +        raise_fu_exception(env, bit, sprn, cause, GETPC());
> +    }
> +#endif
> +}
> +
>  void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
>                                 uint32_t sprn, uint32_t cause)
>  {
> @@ -351,3 +362,35 @@ void helper_fixup_thrm(CPUPPCState *env)
>          env->spr[i] =3D v;
>      }
>  }
> +
> +void helper_clrbhrb(CPUPPCState *env)
> +{
> +    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB=
);
> +
> +    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);

Repeating the comment about MMCR0_BHRBA and PPC_BIT_NR discrepancy here
for posterity.

> +
> +    memset(env->bhrb, 0, sizeof(env->bhrb));
> +}
> +
> +uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
> +{
> +    unsigned int index;
> +
> +    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", FSCR_IC_BHRB=
);
> +
> +    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);
> +
> +    if ((bhrbe >=3D env->bhrb_num_entries) ||
> +       (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {

Nitpick, but multi line statment starts again inside the first
parenthesis after a keyword like this.

> +        return 0;
> +    }
> +
> +    /*
> +     * Note: bhrb_offset is the byte offset for writing the
> +     * next entry (over the oldest entry), which is why we
> +     * must offset bhrbe by 1 to get to the 0th entry.
> +     */
> +    index =3D ((env->bhrb_offset / sizeof(uint64_t)) - (bhrbe + 1)) %
> +            env->bhrb_num_entries;
> +    return env->bhrb[index];
> +}
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 7824475f54..b330871793 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6549,12 +6549,25 @@ static void gen_brh(DisasContext *ctx)
>  }
>  #endif
> =20
> +static void gen_clrbhrb(DisasContext *ctx)
> +{
> +    gen_helper_clrbhrb(cpu_env);
> +}
> +
> +static void gen_mfbhrbe(DisasContext *ctx)
> +{
> +    TCGv_i32 bhrbe =3D tcg_constant_i32(_SPR(ctx->opcode));
> +    gen_helper_mfbhrbe(cpu_gpr[rD(ctx->opcode)], cpu_env, bhrbe);
> +}
> +
>  static opcode_t opcodes[] =3D {
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
>  GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
>  GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
>  #endif
> +GEN_HANDLER_E(clrbhrb, 0x1F, 0x0E, 0x0D, 0x3FFF801, PPC_NONE, PPC2_ISA20=
7S),
> +GEN_HANDLER_E(mfbhrbe, 0x1F, 0x0E, 0x09, 0x0000001, PPC_NONE, PPC2_ISA20=
7S),

How much of a pain would it be to add it as decodetree? If there is an
addition a family of existing instrutions here it makes sense to add it
here, for new family would be nice to use decodetree.

I think they're only supported in 64-bit ISA so it could be ifdef
TARGET_PPC64.

Thanks,
Nick

>  GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA30=
0),


