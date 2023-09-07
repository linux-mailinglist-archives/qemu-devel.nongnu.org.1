Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27164796EB3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 03:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4Ck-0002Vo-JG; Wed, 06 Sep 2023 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Ci-0002Vb-AX; Wed, 06 Sep 2023 21:53:08 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Cf-0000Pv-IY; Wed, 06 Sep 2023 21:53:08 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3aa1446066aso299775b6e.1; 
 Wed, 06 Sep 2023 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694051584; x=1694656384; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fn3DarLtvFlHVjCxbcb0VSjV5omNE9INNAIGMmIbZj8=;
 b=f0lnP5f5vruIdAQA7tCb33+9zB7c5Fc46qjGZR43xTe+Q6RHt5jpYQJVEBCKILkiwh
 yAlxCemhO1U/iligK4NgHyhL+7Z4XpE2ox4Ez2uOQVT/gy5XhbpjKvX9CYJZa7aB98f/
 gTMETU6y9eYLMh8qn5vqjBYAMJ14fP1qWHUnqjfTi1IOy8BZUJ7t573WfU4pZ/ZZDsqz
 Nsvs1xb7xquL3KGfWXTiIzgjrsWqK9th1B30RAQB2EYpqCUibACNII04mGbFwAL0jrv1
 EYufWdzNlj88+qiafkIm5rx9E+hMcsc2gLcFOq9CS8PJZIT/QHlMVn8VaHvTv1hVKIUq
 1Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051584; x=1694656384;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fn3DarLtvFlHVjCxbcb0VSjV5omNE9INNAIGMmIbZj8=;
 b=j2RX7+XT3vmupqGIUoFu31DuspCz3kwhS4cpgpPV3FwKHNsmuDvvQejF1xVQ/Ei/9O
 ZIcZGg6x/YV29Z+RcE74yHk04CdJM2hvfjMvoHk3q61+M7KpcjY3psaOLIke3PMTPjo5
 0aO3P0Wbk5XrmWk68wFJZngdzIqvEEPtH2BIzvj/TqgTjerLcfPE95ox8Iyqq1EHMfln
 2aTGZNEIRzzvmM+Ye2+HYCWAzpAW03iuxMquofhu80HQLGp9DlQOvHcitaqz4DVGyR1w
 67oBzkGv/FIHAP/xJuOsEs241NAYY6DW4RNR+WxjYNLb+bnCvz6z0E3zwbLyvMhT1rsv
 qbzw==
X-Gm-Message-State: AOJu0YzOjW86nEEhv2zypNDshxlv6nS5cU6BgSoQJxBiDJzDWbw0xt7b
 0KM73eMOh63dgqhxh0Kplto=
X-Google-Smtp-Source: AGHT+IGXmfXSQJ/wbnxxZ8mCbAjr7gnIeoimOXf4Y5QwW4za7mT1M35sW4sJrk0fNlHeMw35oggjJQ==
X-Received: by 2002:a05:6358:2820:b0:132:d42f:8e19 with SMTP id
 k32-20020a056358282000b00132d42f8e19mr5021012rwb.31.1694051583787; 
 Wed, 06 Sep 2023 18:53:03 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a639206000000b005642a68a508sm6911245pgd.35.2023.09.06.18.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 18:53:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 11:52:58 +1000
Message-Id: <CVCB5ZAL2PP1.G3HM71BNC39T@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 05/15] ppc: spapr: Introduce cap-nested-papr for
 nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-6-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x234.google.com
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

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> This patch introduces a new cmd line option cap-nested-papr to enable
> support for nested PAPR API by setting the nested.api version accordingly=
.
> It requires the user to launch the L0 Qemu in TCG mode and then L1 Linux
> can then launch the nested guest in KVM mode. Unlike cap-nested-hv,
> this is meant for nested guest on pseries (PowerVM) where L0 retains
> whole state of the nested guest. Both APIs are thus mutually exclusive.
> Support for related hcalls is being added in next set of patches.

Oh, this should be about the final patch too, when you have built
the code to actually support said capability.

Thanks,
Nick

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 48 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0aa9f21516..cbab7a825f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2092,6 +2092,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
>          &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_nested_papr,
>          NULL
>      }
>  };
> @@ -4685,6 +4686,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index a3a790b026..d3b9f107aa 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -491,6 +491,44 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>      }
>  }
> =20
> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
> +                                    uint8_t val, Error **errp)
> +{
> +    ERRP_GUARD();
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (!val) {
> +        /* capability disabled by default */
> +        return;
> +    }
> +
> +    if (tcg_enabled()) {
> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
> +            error_setg(errp, "Nested-PAPR only supported on POWER9 and l=
ater");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-papr=3D=
off\n");
> +            return;
> +        }
> +        spapr->nested.api =3D NESTED_API_PAPR;
> +    } else if (kvm_enabled()) {
> +        /*
> +         * this gets executed in L1 qemu when L2 is launched,
> +         * needs kvm-hv support in L1 kernel.
> +         */
> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
> +            error_setg(errp,
> +                       "KVM implementation does not support Nested-HV");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-hv=3Dof=
f\n");
> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> +            error_setg(errp, "Error enabling cap-nested-hv with KVM");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-hv=3Dof=
f\n");
> +        }
> +    }
> +}
> +
>  static void cap_large_decr_apply(SpaprMachineState *spapr,
>                                   uint8_t val, Error **errp)
>  {
> @@ -736,6 +774,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
>      },
> +    [SPAPR_CAP_NESTED_PAPR] =3D {
> +        .name =3D "nested-papr",
> +        .description =3D "Allow Nested PAPR (Phyp)",
> +        .index =3D SPAPR_CAP_NESTED_PAPR,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_nested_papr_apply,
> +    },
>      [SPAPR_CAP_LARGE_DECREMENTER] =3D {
>          .name =3D "large-decr",
>          .description =3D "Allow Large Decrementer",
> @@ -920,6 +967,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c8b42af430..8a6e9ce929 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,8 +81,10 @@ typedef enum {
>  #define SPAPR_CAP_RPT_INVALIDATE        0x0B
>  /* Support for AIL modes */
>  #define SPAPR_CAP_AIL_MODE_3            0x0C
> +/* Nested PAPR */
> +#define SPAPR_CAP_NESTED_PAPR           0x0D
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
> =20
>  /*
>   * Capability Values
> @@ -1005,6 +1007,7 @@ extern const VMStateDescription vmstate_spapr_cap_s=
bbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;


