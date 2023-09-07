Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716B796F71
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe67x-0007Xc-HT; Wed, 06 Sep 2023 23:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe67u-0007Wm-7w; Wed, 06 Sep 2023 23:56:18 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe67i-0000h3-J2; Wed, 06 Sep 2023 23:56:17 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ab29af398aso375694b6e.1; 
 Wed, 06 Sep 2023 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694058958; x=1694663758; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqPpKo8arXpvt63KwCef8iwcEHazifZ1yA2KCn32GXE=;
 b=eb0fqwmsBQdafSFSG6osJe7TTPzHFSIzVZ3vkO9LCM1Cax3qHkyncECSaZwYGfq3jJ
 CEXKp79xGa0mWsJ2gOVEl90FoKDLSUwQWcFTPIqlXGgCcYT2bELM2Iy2RnXvWUzlT1J1
 2A/fE+SlkAGWXrg3D8T3wLaam5QViAmxqDCUxrJMoOXwb8R0KxE+RFe+XedArboJDTni
 Du3Gbpz6Getj+sMfPi4FolP71+PI3ES9Pi2O7AKT06emsyRqqT06tPi0GLdFFWsXeqNf
 hguTVgt1poP6DXVXa8mfHiP2PpDJZfLdpbZW67h5JHN+Wdn0NJhR28vWqqDRBlL9D048
 tPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694058958; x=1694663758;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oqPpKo8arXpvt63KwCef8iwcEHazifZ1yA2KCn32GXE=;
 b=cJBh1BHKcj8DSE8ZQM5PJ9D3YfKelgkAZiEacwVjjBKH9PnlpOPYEUvVGZ5EAGPsbG
 RHwtk26I/M6e03EztdJcfiznmZ15dGa0X0xW8kfw66jolG+VB3k2Hxx8pMdYHj/giIu4
 k3fJl9y26fk41x4B7CViryw5McPUBH3dVXpJk6rQn1XY4Ue06YCiasQ05tvf854yNLCA
 1qkOFn/+hBj59Vdjl0f3bCZatAhVYepUAwupmEqNgOkOlQ3qOHsdYz7a+v29j61wo91v
 Gx7/Zyonb4ZuEvbNxpxZ0Urp7awnGbd3hFef79yJfR2NN2ORUG1+rTCY+1BZ+j/G5v1O
 nFvA==
X-Gm-Message-State: AOJu0Yxj0zY/r1cckj2fROxBUfRWXVGU06bbNrd+g1q2Twswo6+elOjc
 GzJhBKN4Nf/z9vGNDeY3erg=
X-Google-Smtp-Source: AGHT+IHl/LK0z9ol21fiS5ErZ/wLwZiXSvpVaqL5jAMJSUCCnXf7EVDuK48PAnxS0A58Ak39wmO3MA==
X-Received: by 2002:a05:6808:48:b0:3a8:8ab1:57ff with SMTP id
 v8-20020a056808004800b003a88ab157ffmr18429169oic.45.1694058957521; 
 Wed, 06 Sep 2023 20:55:57 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 gq1-20020a17090b104100b002639c4f81cesm516558pjb.3.2023.09.06.20.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 20:55:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 13:55:51 +1000
Message-Id: <CVCDS2JE96GO.28S7VHXGJSODJ@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 13/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_RUN_VCPU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-14-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-14-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Once the L1 has created a nested guest and its associated VCPU, it can
> request for the execution of nested guest by setting its initial state
> which can be done either using the h_guest_set_state or using the input
> buffers along with the call to h_guest_run_vcpu(). On guest exit, L0
> uses output buffers to convey the exit cause to the L1. L0 takes care of
> switching context from L1 to L2 during guest entry and restores L1 contex=
t
> on guest exit.
>
> Unlike nested-hv, L2 (nested) guest's entire state is retained with
> L0 after guest exit and restored on next entry in case of nested-papr.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c           | 471 +++++++++++++++++++++++++++-----
>  include/hw/ppc/spapr_cpu_core.h |   7 +-
>  include/hw/ppc/spapr_nested.h   |   6 +
>  3 files changed, 408 insertions(+), 76 deletions(-)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 67e389a762..3605f27115 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -12,6 +12,17 @@
>  #ifdef CONFIG_TCG
>  #define PRTS_MASK      0x1f
> =20
> +static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
> +                                     SpaprMachineStateNestedGuestVcpu *v=
cpu);
> +static void exit_process_output_buffer(PowerPCCPU *cpu,
> +                                      SpaprMachineStateNestedGuest *gues=
t,
> +                                      target_ulong vcpuid,
> +                                      target_ulong *r3);
> +static void restore_common_regs(CPUPPCState *dst, CPUPPCState *src);
> +static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
> +                       target_ulong vcpuid,
> +                       bool inoutbuf);
> +
>  static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>                                 SpaprMachineState *spapr,
>                                 target_ulong opcode,
> @@ -187,21 +198,21 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>          return H_PARAMETER;
>      }
> =20
> -    spapr_cpu->nested_host_state =3D g_try_new(struct nested_ppc_state, =
1);
> -    if (!spapr_cpu->nested_host_state) {
> +    spapr_cpu->nested_hv_host =3D g_try_new(struct nested_ppc_state, 1);
> +    if (!spapr_cpu->nested_hv_host) {
>          return H_NO_MEM;
>      }

Don't rename existing thing in the same patch as adding new thing.

> =20
>      assert(env->spr[SPR_LPIDR] =3D=3D 0);
>      assert(env->spr[SPR_DPDES] =3D=3D 0);
> -    nested_save_state(spapr_cpu->nested_host_state, cpu);
> +    nested_save_state(spapr_cpu->nested_hv_host, cpu);
> =20
>      len =3D sizeof(*regs);
>      regs =3D address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
>                                  MEMTXATTRS_UNSPECIFIED);
>      if (!regs || len !=3D sizeof(*regs)) {
>          address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
> -        g_free(spapr_cpu->nested_host_state);
> +        g_free(spapr_cpu->nested_hv_host);
>          return H_P2;
>      }
> =20
> @@ -276,105 +287,146 @@ static target_ulong h_enter_nested(PowerPCCPU *cp=
u,
> =20
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>  {
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    CPUState *cs =3D CPU(cpu);

I think it would be worth seeing how it looks to split these into
original and papr functions rather than try mash them together.

>      CPUPPCState *env =3D &cpu->env;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong r3_return =3D env->excp_vectors[excp]; /* hcall return =
value */
>      struct nested_ppc_state l2_state;
> -    target_ulong hv_ptr =3D spapr_cpu->nested_host_state->gpr[4];
> -    target_ulong regs_ptr =3D spapr_cpu->nested_host_state->gpr[5];
> -    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
> +    target_ulong hv_ptr, regs_ptr;
> +    target_ulong hsrr0 =3D 0, hsrr1 =3D 0, hdar =3D 0, asdr =3D 0, hdsis=
r =3D 0;
>      struct kvmppc_hv_guest_state *hvstate;
>      struct kvmppc_pt_regs *regs;
>      hwaddr len;
> +    target_ulong lpid =3D 0, vcpuid =3D 0;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu =3D NULL;
> +    struct SpaprMachineStateNestedGuest *guest =3D NULL;
> =20
>      assert(spapr_cpu->in_nested);
> -
> -    nested_save_state(&l2_state, cpu);
> -    hsrr0 =3D env->spr[SPR_HSRR0];
> -    hsrr1 =3D env->spr[SPR_HSRR1];
> -    hdar =3D env->spr[SPR_HDAR];
> -    hdsisr =3D env->spr[SPR_HDSISR];
> -    asdr =3D env->spr[SPR_ASDR];
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> +        nested_save_state(&l2_state, cpu);
> +        hsrr0 =3D env->spr[SPR_HSRR0];
> +        hsrr1 =3D env->spr[SPR_HSRR1];
> +        hdar =3D env->spr[SPR_HDAR];
> +        hdsisr =3D env->spr[SPR_HDSISR];
> +        asdr =3D env->spr[SPR_ASDR];
> +    } else if (spapr->nested.api =3D=3D NESTED_API_PAPR) {
> +        lpid =3D spapr_cpu->nested_papr_host->gpr[5];
> +        vcpuid =3D spapr_cpu->nested_papr_host->gpr[6];
> +        guest =3D spapr_get_nested_guest(spapr, lpid);
> +        assert(guest);
> +        vcpu_check(guest, vcpuid, false);
> +        vcpu =3D &guest->vcpu[vcpuid];
> +
> +        exit_nested_restore_vcpu(cpu, excp, vcpu);
> +        /* do the output buffer for run_vcpu*/
> +        exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
> +    } else
> +        g_assert_not_reached();
> =20
>      /*
>       * Switch back to the host environment (including for any error).
>       */
>      assert(env->spr[SPR_LPIDR] !=3D 0);
> -    nested_load_state(cpu, spapr_cpu->nested_host_state);
> -    env->gpr[3] =3D env->excp_vectors[excp]; /* hcall return value */
> =20
> -    cpu_ppc_hdecr_exit(env);
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> +        nested_load_state(cpu, spapr_cpu->nested_hv_host);
> +        env->gpr[3] =3D r3_return;
> +    } else if (spapr->nested.api =3D=3D NESTED_API_PAPR) {
> +        restore_common_regs(env, spapr_cpu->nested_papr_host);
> +        env->tb_env->tb_offset -=3D vcpu->tb_offset;
> +        env->gpr[3] =3D H_SUCCESS;
> +        env->gpr[4] =3D r3_return;
> +        hreg_compute_hflags(env);
> +        ppc_maybe_interrupt(env);
> +        tlb_flush(cs);
> +        env->reserve_addr =3D -1; /* Reset the reservation */

There's a bunch of stuff that's getting duplicated anyway, so
it's actually not clear that this maze of if statements makes
it simpler to see that nothing is missed.

> +    }
> =20
> -    spapr_cpu->in_nested =3D false;
> +    cpu_ppc_hdecr_exit(env);
> =20
> -    g_free(spapr_cpu->nested_host_state);
> -    spapr_cpu->nested_host_state =3D NULL;
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> +        hv_ptr =3D spapr_cpu->nested_hv_host->gpr[4];
> +        regs_ptr =3D spapr_cpu->nested_hv_host->gpr[5];
> +
> +        len =3D sizeof(*hvstate);
> +        hvstate =3D address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
> +                                    MEMTXATTRS_UNSPECIFIED);
> +        if (len !=3D sizeof(*hvstate)) {
> +            address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
> +            env->gpr[3] =3D H_PARAMETER;
> +            return;
> +        }
> =20
> -    len =3D sizeof(*hvstate);
> -    hvstate =3D address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
> -                                MEMTXATTRS_UNSPECIFIED);
> -    if (len !=3D sizeof(*hvstate)) {
> -        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
> -        env->gpr[3] =3D H_PARAMETER;
> -        return;
> -    }
> +        hvstate->cfar =3D l2_state.cfar;
> +        hvstate->lpcr =3D l2_state.lpcr;
> +        hvstate->pcr =3D l2_state.pcr;
> +        hvstate->dpdes =3D l2_state.dpdes;
> +        hvstate->hfscr =3D l2_state.hfscr;
> +
> +        if (excp =3D=3D POWERPC_EXCP_HDSI) {
> +            hvstate->hdar =3D hdar;
> +            hvstate->hdsisr =3D hdsisr;
> +            hvstate->asdr =3D asdr;
> +        } else if (excp =3D=3D POWERPC_EXCP_HISI) {
> +            hvstate->asdr =3D asdr;
> +        }
> =20
> -    hvstate->cfar =3D l2_state.cfar;
> -    hvstate->lpcr =3D l2_state.lpcr;
> -    hvstate->pcr =3D l2_state.pcr;
> -    hvstate->dpdes =3D l2_state.dpdes;
> -    hvstate->hfscr =3D l2_state.hfscr;
> +        /* HEIR should be implemented for HV mode and saved here. */
> +        hvstate->srr0 =3D l2_state.srr0;
> +        hvstate->srr1 =3D l2_state.srr1;
> +        hvstate->sprg[0] =3D l2_state.sprg0;
> +        hvstate->sprg[1] =3D l2_state.sprg1;
> +        hvstate->sprg[2] =3D l2_state.sprg2;
> +        hvstate->sprg[3] =3D l2_state.sprg3;
> +        hvstate->pidr =3D l2_state.pidr;
> +        hvstate->ppr =3D l2_state.ppr;
> +
> +        /* Is it okay to specify write len larger than actual data writt=
en? */
> +        address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
> +
> +        len =3D sizeof(*regs);
> +        regs =3D address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
> +                                    MEMTXATTRS_UNSPECIFIED);
> +        if (!regs || len !=3D sizeof(*regs)) {
> +            address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
> +            env->gpr[3] =3D H_P2;
> +            return;
> +        }
> =20
> -    if (excp =3D=3D POWERPC_EXCP_HDSI) {
> -        hvstate->hdar =3D hdar;
> -        hvstate->hdsisr =3D hdsisr;
> -        hvstate->asdr =3D asdr;
> -    } else if (excp =3D=3D POWERPC_EXCP_HISI) {
> -        hvstate->asdr =3D asdr;
> -    }
> +        len =3D sizeof(env->gpr);
> +        assert(len =3D=3D sizeof(regs->gpr));
> +        memcpy(regs->gpr, l2_state.gpr, len);
> =20
> -    /* HEIR should be implemented for HV mode and saved here. */
> -    hvstate->srr0 =3D l2_state.srr0;
> -    hvstate->srr1 =3D l2_state.srr1;
> -    hvstate->sprg[0] =3D l2_state.sprg0;
> -    hvstate->sprg[1] =3D l2_state.sprg1;
> -    hvstate->sprg[2] =3D l2_state.sprg2;
> -    hvstate->sprg[3] =3D l2_state.sprg3;
> -    hvstate->pidr =3D l2_state.pidr;
> -    hvstate->ppr =3D l2_state.ppr;
> +        regs->link =3D l2_state.lr;
> +        regs->ctr =3D l2_state.ctr;
> +        regs->xer =3D l2_state.xer;
> +        regs->ccr =3D l2_state.cr;
> =20
> -    /* Is it okay to specify write length larger than actual data writte=
n? */
> -    address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
> +        if (excp =3D=3D POWERPC_EXCP_MCHECK ||
> +            excp =3D=3D POWERPC_EXCP_RESET ||
> +            excp =3D=3D POWERPC_EXCP_SYSCALL) {
> +            regs->nip =3D l2_state.srr0;
> +            regs->msr =3D l2_state.srr1 & env->msr_mask;
> +        } else {
> +            regs->nip =3D hsrr0;
> +            regs->msr =3D hsrr1 & env->msr_mask;
> +        }
> =20
> -    len =3D sizeof(*regs);
> -    regs =3D address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
> -                                MEMTXATTRS_UNSPECIFIED);
> -    if (!regs || len !=3D sizeof(*regs)) {
> -        address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
> -        env->gpr[3] =3D H_P2;
> -        return;
> +        /* Is it okay to specify write len larger than actual data writt=
en? */
> +        address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>      }
> =20
> -    len =3D sizeof(env->gpr);
> -    assert(len =3D=3D sizeof(regs->gpr));
> -    memcpy(regs->gpr, l2_state.gpr, len);
> -
> -    regs->link =3D l2_state.lr;
> -    regs->ctr =3D l2_state.ctr;
> -    regs->xer =3D l2_state.xer;
> -    regs->ccr =3D l2_state.cr;
> +    spapr_cpu->in_nested =3D false;
> =20
> -    if (excp =3D=3D POWERPC_EXCP_MCHECK ||
> -        excp =3D=3D POWERPC_EXCP_RESET ||
> -        excp =3D=3D POWERPC_EXCP_SYSCALL) {
> -        regs->nip =3D l2_state.srr0;
> -        regs->msr =3D l2_state.srr1 & env->msr_mask;
> +    if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
> +        g_free(spapr_cpu->nested_hv_host);
> +        spapr_cpu->nested_hv_host =3D NULL;
>      } else {
> -        regs->nip =3D hsrr0;
> -        regs->msr =3D hsrr1 & env->msr_mask;
> +        g_free(spapr_cpu->nested_papr_host);
> +        spapr_cpu->nested_papr_host =3D NULL;
>      }
> =20
> -    /* Is it okay to specify write length larger than actual data writte=
n? */
> -    address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
>  SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> @@ -1372,6 +1424,274 @@ static target_ulong h_guest_get_state(PowerPCCPU =
*cpu,
>      return h_guest_getset_state(cpu, spapr, args, false);
>  }
> =20
> +static void restore_common_regs(CPUPPCState *dst, CPUPPCState *src)
> +{
> +    memcpy(dst->gpr, src->gpr, sizeof(dst->gpr));
> +    memcpy(dst->crf, src->crf, sizeof(dst->crf));
> +    memcpy(dst->vsr, src->vsr, sizeof(dst->vsr));
> +    dst->nip =3D src->nip;
> +    dst->msr =3D src->msr;
> +    dst->lr  =3D src->lr;
> +    dst->ctr =3D src->ctr;
> +    dst->cfar =3D src->cfar;
> +    cpu_write_xer(dst, src->xer);
> +    ppc_store_vscr(dst, ppc_get_vscr(src));
> +    ppc_store_fpscr(dst, src->fpscr);
> +    memcpy(dst->spr, src->spr, sizeof(dst->spr));
> +}
> +
> +static void restore_l2_state(PowerPCCPU *cpu,
> +                             CPUPPCState *env,
> +                             struct SpaprMachineStateNestedGuestVcpu *vc=
pu,
> +                             target_ulong now)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong lpcr, lpcr_mask, hdec;
> +    lpcr_mask =3D LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
> +
> +    if (spapr->nested.api =3D=3D NESTED_API_PAPR) {
> +        assert(vcpu);
> +        assert(sizeof(env->gpr) =3D=3D sizeof(vcpu->env.gpr));
> +        restore_common_regs(env, &vcpu->env);
> +        lpcr =3D (env->spr[SPR_LPCR] & ~lpcr_mask) |
> +               (vcpu->env.spr[SPR_LPCR] & lpcr_mask);
> +        lpcr |=3D LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HD=
ICE;
> +        lpcr &=3D ~LPCR_LPES0;
> +        env->spr[SPR_LPCR] =3D lpcr & pcc->lpcr_mask;
> +
> +        hdec =3D vcpu->env.tb_env->hdecr_expiry_tb - now;
> +        cpu_ppc_store_decr(env, vcpu->dec_expiry_tb - now);
> +        cpu_ppc_hdecr_init(env);
> +        cpu_ppc_store_hdecr(env, hdec);
> +
> +        env->tb_env->tb_offset +=3D vcpu->tb_offset;
> +    }
> +}
> +
> +static void enter_nested(PowerPCCPU *cpu,
> +                         uint64_t lpid,
> +                         struct SpaprMachineStateNestedGuestVcpu *vcpu)

That's not good since we have h_enter_nested for the old API. Really
have to be a bit more consistent with using papr_ for naming I think.
And you don't have to call this enter_nested anyway, papr_run_vcpu is
okay too since that matches the API call. Can just add a comment /*
Enter the L2 VCPU, equivalent to h_enter_nested */ if you think that's
needed.

> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong now =3D cpu_ppc_load_tbl(env);
> +
> +    assert(env->spr[SPR_LPIDR] =3D=3D 0);
> +    assert(spapr->nested.api); /* ensure API version is initialized */
> +    spapr_cpu->nested_papr_host =3D g_try_new(CPUPPCState, 1);
> +    assert(spapr_cpu->nested_papr_host);
> +    memcpy(spapr_cpu->nested_papr_host, env, sizeof(CPUPPCState));
> +
> +    restore_l2_state(cpu, env, vcpu, now);
> +    env->spr[SPR_LPIDR] =3D lpid; /* post restore_l2_state */
> +
> +    spapr_cpu->in_nested =3D true;
> +
> +    hreg_compute_hflags(env);
> +    ppc_maybe_interrupt(env);
> +    tlb_flush(cs);
> +    env->reserve_addr =3D -1; /* Reset the reservation */

       ^^^
       This is the kind of block that could be pulled into a
       common helper function. There's 3-4 copies now?
> +
> +}
> +
> +static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
> +                                     SpaprMachineState *spapr,
> +                                     target_ulong opcode,
> +                                     target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong flags =3D args[0];
> +    target_ulong lpid =3D args[1];
> +    target_ulong vcpuid =3D args[2];
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
> +    struct guest_state_request gsr;
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    if (flags) /* don't handle any flags for now */
> +        return H_PARAMETER;
> +
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +    if (!vcpu_check(guest, vcpuid, true)) {
> +        return H_P3;
> +    }
> +
> +    if (guest->parttbl[0] =3D=3D 0) {
> +        /* At least need a partition scoped radix tree */
> +        return H_NOT_AVAILABLE;
> +    }
> +
> +    vcpu =3D &guest->vcpu[vcpuid];
> +
> +    /* Read run_vcpu input buffer to update state */
> +    gsr.buf =3D vcpu->runbufin.addr;
> +    gsr.len =3D vcpu->runbufin.size;
> +    gsr.flags =3D GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
> +    if (!map_and_getset_state(cpu, guest, vcpuid, &gsr)) {
> +        enter_nested(cpu, lpid, vcpu);
> +    }
> +
> +    return env->gpr[3];
> +}
> +
> +struct run_vcpu_exit_cause run_vcpu_exit_causes[] =3D {
> +    { .nia =3D 0x980,
> +      .count =3D 0,
> +    },
> +    { .nia =3D 0xc00,
> +      .count =3D 10,
> +      .ids =3D {
> +          GSB_VCPU_GPR3,
> +          GSB_VCPU_GPR4,
> +          GSB_VCPU_GPR5,
> +          GSB_VCPU_GPR6,
> +          GSB_VCPU_GPR7,
> +          GSB_VCPU_GPR8,
> +          GSB_VCPU_GPR9,
> +          GSB_VCPU_GPR10,
> +          GSB_VCPU_GPR11,
> +          GSB_VCPU_GPR12,
> +      },
> +    },
> +    { .nia =3D 0xe00,
> +      .count =3D 5,
> +      .ids =3D {
> +          GSB_VCPU_SPR_HDAR,
> +          GSB_VCPU_SPR_HDSISR,
> +          GSB_VCPU_SPR_ASDR,
> +          GSB_VCPU_SPR_NIA,
> +          GSB_VCPU_SPR_MSR,
> +      },
> +    },
> +    { .nia =3D 0xe20,
> +      .count =3D 4,
> +      .ids =3D {
> +          GSB_VCPU_SPR_HDAR,
> +          GSB_VCPU_SPR_ASDR,
> +          GSB_VCPU_SPR_NIA,
> +          GSB_VCPU_SPR_MSR,
> +      },
> +    },
> +    { .nia =3D 0xe40,
> +      .count =3D 3,
> +      .ids =3D {
> +          GSB_VCPU_SPR_HEIR,
> +          GSB_VCPU_SPR_NIA,
> +          GSB_VCPU_SPR_MSR,
> +      },
> +    },
> +    { .nia =3D 0xea0,
> +      .count =3D 0,
> +    },
> +    { .nia =3D 0xf80,
> +      .count =3D 3,
> +      .ids =3D {
> +          GSB_VCPU_SPR_HFSCR,
> +          GSB_VCPU_SPR_NIA,
> +          GSB_VCPU_SPR_MSR,
> +      },
> +    },
> +};
> +
> +static struct run_vcpu_exit_cause *find_exit_cause(uint64_t srr0)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(run_vcpu_exit_causes); i++)
> +        if (srr0 =3D=3D run_vcpu_exit_causes[i].nia) {
> +            return &run_vcpu_exit_causes[i];
> +        }
> +
> +    printf("%s: srr0:0x%016lx\n", __func__, srr0);
> +    return NULL;
> +}

This is another weird control flow thing, also unclear why it's used
here. Here: 52 lines vs 76, no new struct, simpler for the compiler
to understand and optimise.

int get_exit_ids(uint64_t srr0, uint16_t ids[16])
{
    int nr;

    switch (srr0) {
    case 0xc00:
        nr =3D 10;
        ids[0] =3D GSP_VCPU_GPR3;
        ids[1] =3D GSP_VCPU_GPR4;
        ids[2] =3D GSP_VCPU_GPR5;
        ids[3] =3D GSP_VCPU_GPR6;
        ids[4] =3D GSP_VCPU_GPR7;
        ids[5] =3D GSP_VCPU_GPR8;
        ids[6] =3D GSP_VCPU_GPR9;
        ids[7] =3D GSP_VCPU_GPR10;
        ids[8] =3D GSP_VCPU_GPR11;
        ids[9] =3D GSP_VCPU_GPR12;
        break;
    case 0xe00:
        nr =3D 5;
        ids[0] =3D GSP_VCPU_HDAR;
        ids[1] =3D GSP_VCPU_HDSISR;
        ids[2] =3D GSP_VCPU_ASDR;
        ids[3] =3D GSP_VCPU_NIA;
        ids[4] =3D GSP_VCPU_MSR;
        break;
    case 0xe20:
        nr =3D 4;
        ids[0] =3D GSP_VCPU_HDAR;
        ids[1] =3D GSP_VCPU_ASDR;
        ids[2] =3D GSP_VCPU_NIA;
        ids[3] =3D GSP_VCPU_MSR;
        break;
    case 0xe40:
        nr =3D 3;
        ids[0] =3D GSP_VCPU_HEIR;
        ids[1] =3D GSP_VCPU_NIA;
        ids[2] =3D GSP_VCPU_MSR;
        break;
    case 0xf80:
        nr =3D 3;
        ids[0] =3D GSP_VCPU_HFSCR;
        ids[1] =3D GSP_VCPU_NIA;
        ids[2] =3D GSP_VCPU_MSR;
        break;
    default:
        nr =3D 0;
        break;
    }

    return nr;
}

> +
> +static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
> +                                     SpaprMachineStateNestedGuestVcpu *v=
cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong now, hdar, hdsisr, asdr;
> +
> +    assert(sizeof(env->gpr) =3D=3D sizeof(vcpu->env.gpr)); /* sanity che=
ck */
> +
> +    now =3D cpu_ppc_load_tbl(env); /* L2 timebase */
> +    now -=3D vcpu->tb_offset; /* L1 timebase */
> +    vcpu->dec_expiry_tb =3D now - cpu_ppc_load_decr(env);
> +    /* backup hdar, hdsisr, asdr if reqd later below */
> +    hdar   =3D vcpu->env.spr[SPR_HDAR];
> +    hdsisr =3D vcpu->env.spr[SPR_HDSISR];
> +    asdr   =3D vcpu->env.spr[SPR_ASDR];
> +
> +    restore_common_regs(&vcpu->env, env);
> +
> +    if (excp =3D=3D POWERPC_EXCP_MCHECK ||
> +        excp =3D=3D POWERPC_EXCP_RESET ||
> +        excp =3D=3D POWERPC_EXCP_SYSCALL) {
> +        vcpu->env.nip =3D env->spr[SPR_SRR0];
> +        vcpu->env.msr =3D env->spr[SPR_SRR1] & env->msr_mask;
> +    } else {
> +        vcpu->env.nip =3D env->spr[SPR_HSRR0];
> +        vcpu->env.msr =3D env->spr[SPR_HSRR1] & env->msr_mask;
> +    }
> +
> +    /* hdar, hdsisr, asdr should be retained unless certain exceptions *=
/
> +    if ((excp !=3D POWERPC_EXCP_HDSI) && (excp !=3D POWERPC_EXCP_HISI)) =
{
> +        vcpu->env.spr[SPR_ASDR] =3D asdr;
> +    } else if (excp !=3D POWERPC_EXCP_HDSI) {
> +        vcpu->env.spr[SPR_HDAR]   =3D hdar;
> +        vcpu->env.spr[SPR_HDSISR] =3D hdsisr;
> +    }
> +}
> +
> +static void exit_process_output_buffer(PowerPCCPU *cpu,
> +                                      SpaprMachineStateNestedGuest *gues=
t,
> +                                      target_ulong vcpuid,
> +                                      target_ulong *r3)
> +{
> +    SpaprMachineStateNestedGuestVcpu *vcpu =3D &guest->vcpu[vcpuid];
> +    struct guest_state_request gsr;
> +    struct guest_state_buffer *gsb;
> +    struct guest_state_element *element;
> +    struct guest_state_element_type *type;
> +    struct run_vcpu_exit_cause *exit_cause;
> +    hwaddr len;
> +    int i;
> +
> +    len =3D vcpu->runbufout.size;
> +    gsb =3D address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, =
true,
> +                            MEMTXATTRS_UNSPECIFIED);
> +    if (!gsb || len !=3D vcpu->runbufout.size) {
> +        address_space_unmap(CPU(cpu)->as, gsb, len, 0, true);
> +        *r3 =3D H_P2;
> +        return;
> +    }
> +
> +    exit_cause =3D find_exit_cause(*r3);
> +
> +    /* Create a buffer of elements to send back */
> +    gsb->num_elements =3D cpu_to_be32(exit_cause->count);
> +    element =3D gsb->elements;
> +    for (i =3D 0; i < exit_cause->count; i++) {
> +        type =3D guest_state_element_type_find(exit_cause->ids[i]);
> +        assert(type);
> +        element->id =3D cpu_to_be16(exit_cause->ids[i]);
> +        element->size =3D cpu_to_be16(type->size);
> +        element =3D guest_state_element_next(element, NULL, NULL);
> +    }
> +    gsr.gsb =3D gsb;
> +    gsr.len =3D VCPU_OUT_BUF_MIN_SZ;
> +    gsr.flags =3D 0; /* get + never guest wide */
> +    getset_state(guest, vcpuid, &gsr);
> +
> +    address_space_unmap(CPU(cpu)->as, gsb, len, len, true);
> +    return;
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1388,6 +1708,7 @@ void spapr_register_nested_phyp(void)
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
>      spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
>      spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
> +    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu)=
;
>  }
> =20
>  #else
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 69a52e39b8..09855f69aa 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -53,7 +53,12 @@ typedef struct SpaprCpuState {
> =20
>      /* Fields for nested-HV support */
>      bool in_nested; /* true while the L2 is executing */
> -    struct nested_ppc_state *nested_host_state; /* holds the L1 state wh=
ile L2 executes */
> +    union {
> +        /* nested-hv needs minimal set of regs as L1 stores L2 state */
> +        struct nested_ppc_state *nested_hv_host;
> +        /* In nested-papr, L0 retains entire L2 state, so keep it all sa=
fe. */
> +        CPUPPCState *nested_papr_host;
> +    };

This IMO still shouldn't be a CPUPPCState, but extending
nested_ppc_state. Differences between nested APIs should not
be here either, but inside the nested_ppc_state structure.

Thanks,
Nick

>  } SpaprCpuState;
> =20
>  static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index eaee624b87..ca5d28c06e 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -358,6 +358,12 @@ struct guest_state_request {
>      uint16_t flags;
>  };
> =20
> +struct run_vcpu_exit_cause {
> +    uint64_t nia;
> +    uint64_t count;
> +    uint16_t ids[10]; /* max ids supported by run_vcpu_exit_causes */
> +};
> +
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
>   * New member must be added at the end.


