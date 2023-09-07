Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE3796EC6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:04:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4Ll-0006CH-VS; Wed, 06 Sep 2023 22:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Li-0006BQ-FV; Wed, 06 Sep 2023 22:02:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe4Le-0005DJ-1b; Wed, 06 Sep 2023 22:02:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68bec3a9bdbso382147b3a.3; 
 Wed, 06 Sep 2023 19:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694052140; x=1694656940; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+hvhqjhKigGmZH4qJV9cZE2xsQyILuftKamgK73EJ8=;
 b=l0fiJ336QPCpS4242opl2XBe9M+oNkP6LrPVD061sMyQsnQiCShv2VO07vKqNn4921
 0agMjLNO4U2bh0EHW1H62lHAmQ5PDYcG2qKEWCYy+AZsmycH6K8PRp3EgtXkbhjBfzpg
 ay3ogpXBnCW6z/g2BTn8hbFW1ve2l9pHsg11fioG2awoSAvzOrAEI5jIl/RdC+UYXEUi
 Y70Z98X7HcOEfm4HwdkQK3dqs5ejWwwAzr3nD8Sr5kQu8AWO0p5JXRj85wNb7Fs+Hf7L
 nDXhOCBS2G09JpVDL62bSFKxI7Ynw5NVbX8k0NMz8VkBrIBhin6W4/Ams9lLx3mgWEQ7
 faaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694052140; x=1694656940;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H+hvhqjhKigGmZH4qJV9cZE2xsQyILuftKamgK73EJ8=;
 b=d4TnUhc0jG4m8i6F9EqvdRYagnRmI6h0RlLFWs9Jpv8XemgYErUtGtVkuYRuhnofpE
 HnzBDmtDWNtedLXGMjqUARNvA8d4DWjbSSO8jYVSm8J1UQgUYbXX3inCknnY2u1fZI+C
 uhKeM8goXZYJ/UFNsChruSApKjjz4pRHMR5ZHafkS5DwsmC60ec3ynG1rpjYHGWorH1Q
 1gyDCOG7yA7MkcMEsWJq2P050nMSB6Zj0iDD1C88yaL7vxqzSpWfNGfYwLtac3a0CrH+
 zn3RRLbsN9EuyvEo52WvquYOfK8YJrxHDA69Nl7UMrvcDVXJFg0fKAys/KDD0uHnVZ5U
 3HdQ==
X-Gm-Message-State: AOJu0YzCZeC0KA3mL7SCUlsWAMfwwQL5R7mobro2j6FSFZkFpfN6NWYR
 bvNHFohMxHE/lSk7GZvprZ0=
X-Google-Smtp-Source: AGHT+IGOe0c+NLxzNH6yj2gYv4SJbuA27Vfk/optMIJgwo46Nk8j+bXqIY5ZElAoCFNuYjsyg/oPwA==
X-Received: by 2002:a05:6a20:e117:b0:152:1ce8:ce3a with SMTP id
 kr23-20020a056a20e11700b001521ce8ce3amr13566562pzb.18.1694052140227; 
 Wed, 06 Sep 2023 19:02:20 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 e22-20020aa78256000000b0068bc6a75848sm11337699pfn.156.2023.09.06.19.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 19:02:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 12:02:14 +1000
Message-Id: <CVCBD2TBTMXJ.LYNCAVMT7LYB@wheely>
Subject: Re: [PATCH RESEND 06/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_GET_CAPABILITIES
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-7-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-7-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
> This patch implements nested PAPR hcall H_GUEST_GET_CAPABILITIES and
> also enables registration of nested PAPR hcalls whenever an L0 is
> launched with cap-nested-papr=3Dtrue. The common registration routine
> shall be used by future patches for registration of related hcall
> support
> being added. This hcall is used by L1 kernel to get the set of guest
> capabilities that are supported by L0 (Qemu TCG).

Changelog can drop "This patch". Probably don't have to be so
detailed here either -- we already established that PAPR hcalls can
be used with cap-nested-papr in the last patch, we know that L1
kernels make the hcalls to the vhyp, etc.

"Introduce the nested PAPR hcall H_GUEST_GET_CAPABILITIES which
is used to query the capabilities of the API and the L2 guests
it provides."

I would squash this with set.

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_caps.c           |  1 +
>  hw/ppc/spapr_nested.c         | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_nested.h |  6 ++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index d3b9f107aa..cbe53a79ec 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -511,6 +511,7 @@ static void cap_nested_papr_apply(SpaprMachineState *=
spapr,
>              return;
>          }
>          spapr->nested.api =3D NESTED_API_PAPR;
> +        spapr_register_nested_phyp();
>      } else if (kvm_enabled()) {
>          /*
>           * this gets executed in L1 qemu when L2 is launched,

Hmm, this doesn't match nested HV registration. If you want to register
the hcalls in the cap apply, can you move spapr_register_nested()
there first? It may make more sense to go in as a dummy function with
the cap patch first, since you don't introduce all hcalls together.

Also phyp->papr. Scrub for phyp please.

> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index a669470f1a..37f3a49be2 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -6,6 +6,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/spapr_nested.h"
> +#include "cpu-models.h"
> =20
>  #ifdef CONFIG_TCG
>  #define PRTS_MASK      0x1f
> @@ -375,6 +376,29 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> +static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
> +                                             SpaprMachineState *spapr,
> +                                             target_ulong opcode,
> +                                             target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +
> +    if (flags) { /* don't handle any flags capabilities for now */
> +        return H_PARAMETER;
> +    }
> +
> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) =3D=3D
> +        (CPU_POWERPC_POWER9_BASE))
> +        env->gpr[4] =3D H_GUEST_CAPABILITIES_P9_MODE;
> +
> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) =3D=3D
> +        (CPU_POWERPC_POWER10_BASE))
> +        env->gpr[4] =3D H_GUEST_CAPABILITIES_P10_MODE;
> +
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -382,6 +406,12 @@ void spapr_register_nested(void)
>      spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
>      spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_g=
uest);
>  }
> +
> +void spapr_register_nested_phyp(void)
> +{
> +    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
> +}
> +
>  #else
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>  {
> @@ -392,4 +422,9 @@ void spapr_register_nested(void)
>  {
>      /* DO NOTHING */
>  }
> +
> +void spapr_register_nested_phyp(void)
> +{
> +    /* DO NOTHING */
> +}
>  #endif
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index f8db31075b..ce198e9f70 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -189,6 +189,11 @@
>  /* End of list of Guest State Buffer Element IDs */
>  #define GSB_LAST                GSB_VCPU_SPR_ASDR
> =20
> +/* Bit masks to be used in nested PAPR API */
> +#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
> +#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
> +#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000

See introducing these defines with the patch that uses them isn't so
bad :)

Thanks,
Nick

> +
>  typedef struct SpaprMachineStateNestedGuest {
>      unsigned long vcpus;
>      struct SpaprMachineStateNestedGuestVcpu *vcpu;
> @@ -331,6 +336,7 @@ struct nested_ppc_state {
>  };
> =20
>  void spapr_register_nested(void);
> +void spapr_register_nested_phyp(void);
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp);
> =20
>  #endif /* HW_SPAPR_NESTED_H */


