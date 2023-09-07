Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2285796F16
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe55a-00082t-O6; Wed, 06 Sep 2023 22:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe55X-000827-Kc; Wed, 06 Sep 2023 22:49:47 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe55R-0001lK-Li; Wed, 06 Sep 2023 22:49:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bcac140aaaso402269a34.2; 
 Wed, 06 Sep 2023 19:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694054979; x=1694659779; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LG8L/krzvJmL9LFvT0q6F8UskyYP/dtlYL5mCceaOnE=;
 b=MFTNjA2Rsxs2U9ZyLhXQALkkvsHnOFmyBnzt1U4BtDsy2+QaM+sfpib1kPicuvBV3K
 3US1vnBDRanjQ2So1eatpX4y+LIK/CzM1DFvwOpJsh+vNtxXI4U0NEyO4Ma2u7Apkzsk
 5VLciab1G4szweCoMQaqdOoC4pYaE1gwFSpqK5XBMmkYuZbsP9n9UZE2uWKfWXooFhfL
 xhWF/k7DbI0o7h3+NkOpjNPQ9+r2pD2B9tQJrZOCSSw6Byzknlpix7p1lDxxjSRWOCuk
 NviNKVg2rL2/iQktWSRqzhK5Nt4PTOlPpaJSPaW6c+hfpo1DR4N3m/WwFz2b5tWdZHi0
 qjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694054979; x=1694659779;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LG8L/krzvJmL9LFvT0q6F8UskyYP/dtlYL5mCceaOnE=;
 b=AixgF3fYfaCCeBCooX9E6muFAxopvl2SITBiQe6JHaYa+2GLBmO2c1DgjqTA0/uIZd
 17MqICRyQvwtdNfwxKkWp6zazjEbB4PlvdHfvuxC7FXdUkEWtG0yBXSAW/CL3CdzAivw
 6ISEm5BiLlBAfF18KSNO0oGf00RdeJ7u2f+7aHWABO/z5FvxXCU6pBYaKiqfv9wFOoKw
 kGsAofj6bKregLo7sOUhnRdIct2pBmUmQrHqR+WHnFJl4g4I4dgJW7YmEH6+UaKfWCFn
 pYH2KUTY7y3PqTvNlAxTpx0fTG4cIannsYdb0DsKUuW3rITCPSJhQd41LXpugyiV61Jn
 Vw/Q==
X-Gm-Message-State: AOJu0Yx5/yIpAeUsi0KB0qs6Y6r9EN4r6NIRHAWd889tqD3+hY131aVt
 wpA6ImSy4bwGi9VHujrcE0I=
X-Google-Smtp-Source: AGHT+IHlBPDDoq8V2TtMJj0Hp8cEKZQZQW20mZWzCoZkYSfZNl2yXWYtv9xGXI+1pxWOyWhReRp1dA==
X-Received: by 2002:a05:6358:998f:b0:13e:b477:8015 with SMTP id
 j15-20020a056358998f00b0013eb4778015mr5232246rwb.9.1694054979590; 
 Wed, 06 Sep 2023 19:49:39 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a005a00b0025dc5749b4csm497664pjb.21.2023.09.06.19.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 19:49:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 12:49:33 +1000
Message-Id: <CVCCDB85C7Z2.3EOW6KPE9LCRJ@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 09/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE_VCPU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-10-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-10-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> This patch implements support for hcall H_GUEST_CREATE_VCPU which is
> used to instantiate a new VCPU for a previously created nested guest.
> The L1 provide the guest-id (returned by L0 during call to
> H_GUEST_CREATE) and an associated unique vcpu-id to refer to this
> instance in future calls. It is assumed that vcpu-ids are being
> allocated in a sequential manner and max vcpu limit is 2048.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c         | 110 ++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h        |   1 +
>  include/hw/ppc/spapr_nested.h |   1 +
>  3 files changed, 112 insertions(+)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 09bbbfb341..e7956685af 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -376,6 +376,47 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> +static
> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> +                                                     target_ulong lpid)
> +{
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    guest =3D g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(=
lpid));
> +    return guest;
> +}

Are you namespacing the new API stuff with papr or no? Might be good to
reduce confusion.

> +
> +static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
> +                       target_ulong vcpuid,
> +                       bool inoutbuf)

What's it checking? That the id is valid? Allocated? Enabled?

> +{
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
> +
> +    if (vcpuid >=3D NESTED_GUEST_VCPU_MAX) {
> +        return false;
> +    }
> +
> +    if (!(vcpuid < guest->vcpus)) {
> +        return false;
> +    }
> +
> +    vcpu =3D &guest->vcpu[vcpuid];
> +    if (!vcpu->enabled) {
> +        return false;
> +    }
> +
> +    if (!inoutbuf) {
> +        return true;
> +    }
> +
> +    /* Check to see if the in/out buffers are registered */
> +    if (vcpu->runbufin.addr && vcpu->runbufout.addr) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>                                               SpaprMachineState *spapr,
>                                               target_ulong opcode,
> @@ -448,6 +489,11 @@ static void
>  destroy_guest_helper(gpointer value)
>  {
>      struct SpaprMachineStateNestedGuest *guest =3D value;
> +    int i =3D 0;

Don't need to set i =3D 0 twice. A newline would be good though.

> +    for (i =3D 0; i < guest->vcpus; i++) {
> +        cpu_ppc_tb_free(&guest->vcpu[i].env);
> +    }
> +    g_free(guest->vcpu);
>      g_free(guest);
>  }
> =20
> @@ -518,6 +564,69 @@ static target_ulong h_guest_create(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env, *l2env;
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    if (flags) { /* don't handle any flags for now */
> +        return H_UNSUPPORTED_FLAG;
> +    }
> +
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +
> +    if (vcpuid < guest->vcpus) {
> +        return H_IN_USE;
> +    }
> +
> +    if (guest->vcpus >=3D NESTED_GUEST_VCPU_MAX) {
> +        return H_P3;
> +    }
> +
> +    if (guest->vcpus) {
> +        struct SpaprMachineStateNestedGuestVcpu *vcpus;

Ditto for using typedefs. Do a sweep for this.

> +        vcpus =3D g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
> +                            guest->vcpu,
> +                            guest->vcpus + 1);

g_try_renew doesn't work with NULL mem? That's unfortunate.

> +        if (!vcpus) {
> +            return H_NO_MEM;
> +        }
> +        memset(&vcpus[guest->vcpus], 0,
> +               sizeof(struct SpaprMachineStateNestedGuestVcpu));
> +        guest->vcpu =3D vcpus;
> +        l2env =3D &vcpus[guest->vcpus].env;
> +    } else {
> +        guest->vcpu =3D g_try_new0(struct SpaprMachineStateNestedGuestVc=
pu, 1);
> +        if (guest->vcpu =3D=3D NULL) {
> +            return H_NO_MEM;
> +        }
> +        l2env =3D &guest->vcpu->env;
> +    }

These two legs seem to be doing the same thing in different
ways wrt l2env. Just assign guest->vcpu in the branches and
get the l2env from guest->vcpu[guest->vcpus] afterward, no?

> +    /* need to memset to zero otherwise we leak L1 state to L2 */
> +    memset(l2env, 0, sizeof(CPUPPCState));

AFAIKS you just zeroed it above.

> +    /* Copy L1 PVR to L2 */
> +    l2env->spr[SPR_PVR] =3D env->spr[SPR_PVR];
> +    cpu_ppc_tb_init(l2env, SPAPR_TIMEBASE_FREQ);

I would move this down to the end, because it's setting up the
vcpu...

> +
> +    guest->vcpus++;
> +    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
> +    guest->vcpu[vcpuid].enabled =3D true;
> +

... This is still allocating the vcpu so move it up.

> +    if (!vcpu_check(guest, vcpuid, false)) {
> +        return H_PARAMETER;
> +    }
> +    return H_SUCCESS;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -531,6 +640,7 @@ void spapr_register_nested_phyp(void)
>      spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capab=
ilities);
>      spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
> +    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 8a6e9ce929..c9f9682a46 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -371,6 +371,7 @@ struct SpaprMachineState {
>  #define H_UNSUPPORTED     -67
>  #define H_OVERLAP         -68
>  #define H_STATE           -75
> +#define H_IN_USE          -77

Why add it here and not in the first patch?

>  #define H_INVALID_ELEMENT_ID               -79
>  #define H_INVALID_ELEMENT_SIZE             -80
>  #define H_INVALID_ELEMENT_VALUE            -81
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 7841027df8..2e8c6ba1ca 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -199,6 +199,7 @@
> =20
>  /* Nested PAPR API macros */
>  #define NESTED_GUEST_MAX 4096
> +#define NESTED_GUEST_VCPU_MAX 2048
> =20

PAPR_ prefix?

>  typedef struct SpaprMachineStateNestedGuest {
>      unsigned long vcpus;


