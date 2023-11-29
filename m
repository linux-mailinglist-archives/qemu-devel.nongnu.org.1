Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9117FCE21
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 06:00:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Ces-0003jT-0H; Tue, 28 Nov 2023 23:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Cep-0003iq-T1; Tue, 28 Nov 2023 23:58:43 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8Cen-0005um-FL; Tue, 28 Nov 2023 23:58:43 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b837d974ecso3891529b6e.2; 
 Tue, 28 Nov 2023 20:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701233920; x=1701838720; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFXwOfzj3INXQA0FmdTHKhUQLzh/+a1GG5Hf++nBfUw=;
 b=gEMOEv07w9BVP/SpkzK7b4LbuzA/Hyub8Cd9Nzr0PwWV6kbGp/dlDfgnT7Ghz5NE57
 7txKxe6dDh+I3b6u4L76oulnv8ztFz1KzDpjgVBCrcGQc9/bou0bfIMCMxasHaey4vMt
 FoIVvUF8wcHYUiUKZm+6lL1gsKjh89ItRrFTXc/1fcuqdXc06VmwdwxCd/Xfdxk3qwKe
 zO9amNMVlxFg0rPJD330viF/1cQX7KVWJKJcE5AiucNnmQjCIoZZbUJlrQ5DzcDm+Jz4
 NJKhamP5BzLqUvpyFDCdyGw8994Szjp8h04Dm5N50uU2jaqLA66hepHfErUknRg0BBhV
 7zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701233920; x=1701838720;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qFXwOfzj3INXQA0FmdTHKhUQLzh/+a1GG5Hf++nBfUw=;
 b=bZ9XkIQKg/3cFox4eJxGRdVK5EesNQeXzXk3BXIO/5djoZ5gG/quTtf1kl1Rg9LyvR
 3C4+A04/pQ8Z3cD+hPUZ6fkCYYsBfxsgPgZ+tCLDe9DofikfN3sNPjoQfiC33JDhEI4L
 uuN6xwK830Le/z9XtTBM1sj0al4sHs7qDtau9E8CJCKP5zeh8vnay992MLNEkLe73yEd
 vw2xBceftzH3rsYQrnIzCUSHsA69KcZtl/go4uVG+msOt2cxOrOg56fwGazwQkU4u5oF
 NdRmzP9VqR6xxMmDqerCgb1RvYwK3HLFhUbXqW9tJhC+AmIN6ikm49f0OoCW+Wc1fpkF
 IH6g==
X-Gm-Message-State: AOJu0YygUkDZV/jOBs+vnuvOI5FFYhUHhZcWIwmJtkXHkHE7ghNIMX/7
 4K/dvznUjA3ybQFQAgL3HxQ=
X-Google-Smtp-Source: AGHT+IEjCTXGfr+vfyOm65roNQygvs3Ij5u/su6hM2mqZLU1pd4JuFbYhdF4OjNptCwY5Ws/RWXf2w==
X-Received: by 2002:a05:6808:10d4:b0:3b8:44e3:dfda with SMTP id
 s20-20020a05680810d400b003b844e3dfdamr22219492ois.3.1701233919870; 
 Tue, 28 Nov 2023 20:58:39 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 b3-20020a056a0002c300b006cbb83adc1bsm9809658pft.44.2023.11.28.20.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 20:58:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2023 14:58:32 +1000
Message-Id: <CXB13ADEZY4S.SIG59TWJVDJL@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clegoate@redhat.com>, <qemu-devel@nongnu.org>, <mikey@neuling.org>,
 <vaibhav@linux.ibm.com>, <jniethe5@gmail.com>, <sbhat@linux.ibm.com>,
 <kconsul@linux.vnet.ibm.com>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 14/14] spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
X-Mailer: aerc 0.15.2
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-15-harshpb@linux.ibm.com>
In-Reply-To: <20231012104951.194876-15-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
> The H_GUEST_RUN_VCPU hcall is used to start execution of a Guest VCPU.
> The Hypervisor will update the state of the Guest VCPU based on the
> input buffer, restore the saved Guest VCPU state, and start its execution=
.
>
> The Guest VCPU can stop running for numerous reasons including HCALLs,
> hypervisor exceptions, or an outstanding Host Partition Interrupt.
> The reason that the Guest VCPU stopped running is communicated through
> R4 and the output buffer will be filled in with any relevant state.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c           | 308 ++++++++++++++++++++++++++++++--
>  include/hw/ppc/spapr.h          |   1 +
>  include/hw/ppc/spapr_cpu_core.h |   7 +-
>  3 files changed, 302 insertions(+), 14 deletions(-)
>
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index e2d0cb5559..d3e7629f63 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -141,6 +141,15 @@ static void nested_save_state(struct nested_ppc_stat=
e *save, PowerPCCPU *cpu)
>      save->tb_offset =3D env->tb_env->tb_offset;
>  }
> =20
> +static void nested_post_state_update(CPUPPCState *env, CPUState *cs)
> +{
> +    hreg_compute_hflags(env);
> +    ppc_maybe_interrupt(env);
> +    tlb_flush(cs);
> +    env->reserve_addr =3D -1; /* Reset the reservation */
> +

Extra newline. And don't strip out comments please.

> +}
> +
>  static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *=
load)
>  {
>      CPUState *cs =3D CPU(cpu);
> @@ -172,19 +181,7 @@ static void nested_load_state(PowerPCCPU *cpu, struc=
t nested_ppc_state *load)
>      env->spr[SPR_PPR] =3D load->ppr;
> =20
>      env->tb_env->tb_offset =3D load->tb_offset;
> -
> -    /*
> -     * MSR updated, compute hflags and possible interrupts.
> -     */
> -    hreg_compute_hflags(env);
> -    ppc_maybe_interrupt(env);
> -
> -    /*
> -     * Nested HV does not tag TLB entries between L1 and L2, so must
> -     * flush on transition.
> -     */
> -    tlb_flush(cs);
> -    env->reserve_addr =3D -1; /* Reset the reservation */
> +    nested_post_state_update(env, cs);
>  }
> =20
>  /*
> @@ -426,6 +423,9 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int=
 excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> +static
> +void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, i=
nt excp);

Would be nicer if the implementations could go above, then the APIs
below so you don't need this.

> +
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -434,6 +434,10 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      assert(spapr_cpu->in_nested);
>      if (spapr->nested.api =3D=3D NESTED_API_KVM_HV) {
>          spapr_exit_nested_hv(cpu, excp);
> +    } else if (spapr->nested.api =3D=3D NESTED_API_PAPR) {
> +        spapr_exit_nested_papr(spapr, cpu, excp);
> +    } else {
> +        g_assert_not_reached();

The assert leg should have been introduced in the previous patch.

>      }
>  }
> =20
> @@ -1455,6 +1459,283 @@ static target_ulong h_guest_get_state(PowerPCCPU =
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

Still don't like having a CPUPPCState to save into. It does give you a
bunch of variables you need, but you still need a lot of bespoke code
for FPSCR, XER, NIP, etc. so it's not really buying you anything.

If there was a general ppc_cpu_state_save/restore() function then sure,
but I don't think we have ti.

Now I think about it we could probably use the same struct and mostly
the same code for both APIs. They both do the same thing conceptually,
the difference is just that the PAPR API saves a few more registers.

> +    memcpy(dst->spr, src->spr, sizeof(dst->spr));

It's not really clear we can do this, since some SPRs have special
implementations. And AFAIKS the current code already has at least
one bug at a glance because of this, and that's DPDES.

Fortunately Linux doesn't really use it in !SMT and we don't support
SMT + nested at the moment. The problem just gets worse by doing a
wholesale memcpy of SPRs.

> +}

> +
> +static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
> +                                     SpaprMachineStateNestedGuestVcpu *v=
cpu)

The "restore" here and  in nested_papr_restore_l2_state confuse me
I think. This isn't "restoring" the nested vcpu is it? It's saving
it. And nested_papr_restore_l2_state is *loading* the l2 state.

Restore is not a great word, it's a bit ambigous. But in general
this is all to be read from the point of view of the L1 (host), so
"restore" is more suitable for restoring back to host state, but
IMO it should be avoided if possible. "save" can refer to saving
current machine state to somewhere, "load" loading machine state
from somewhere.

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
> +static int get_exit_ids(uint64_t srr0, uint16_t ids[16])
> +{
> +    int nr;
> +
> +    switch (srr0) {
> +    case 0xc00:
> +        nr =3D 10;
> +        ids[0] =3D GSB_VCPU_GPR3;
> +        ids[1] =3D GSB_VCPU_GPR4;
> +        ids[2] =3D GSB_VCPU_GPR5;
> +        ids[3] =3D GSB_VCPU_GPR6;
> +        ids[4] =3D GSB_VCPU_GPR7;
> +        ids[5] =3D GSB_VCPU_GPR8;
> +        ids[6] =3D GSB_VCPU_GPR9;
> +        ids[7] =3D GSB_VCPU_GPR10;
> +        ids[8] =3D GSB_VCPU_GPR11;
> +        ids[9] =3D GSB_VCPU_GPR12;
> +        break;
> +    case 0xe00:
> +        nr =3D 5;
> +        ids[0] =3D GSB_VCPU_SPR_HDAR;
> +        ids[1] =3D GSB_VCPU_SPR_HDSISR;
> +        ids[2] =3D GSB_VCPU_SPR_ASDR;
> +        ids[3] =3D GSB_VCPU_SPR_NIA;
> +        ids[4] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xe20:
> +        nr =3D 4;
> +        ids[0] =3D GSB_VCPU_SPR_HDAR;
> +        ids[1] =3D GSB_VCPU_SPR_ASDR;
> +        ids[2] =3D GSB_VCPU_SPR_NIA;
> +        ids[3] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xe40:
> +        nr =3D 3;
> +        ids[0] =3D GSB_VCPU_SPR_HEIR;
> +        ids[1] =3D GSB_VCPU_SPR_NIA;
> +        ids[2] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    case 0xf80:
> +        nr =3D 3;
> +        ids[0] =3D GSB_VCPU_SPR_HFSCR;
> +        ids[1] =3D GSB_VCPU_SPR_NIA;
> +        ids[2] =3D GSB_VCPU_SPR_MSR;
> +        break;
> +    default:
> +        nr =3D 0;
> +        break;
> +    }
> +
> +    return nr;
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
> +    int exit_id_count =3D 0;
> +    uint16_t exit_cause_ids[16];
> +    hwaddr len;
> +
> +    len =3D vcpu->runbufout.size;
> +    gsb =3D address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, =
true,
> +                            MEMTXATTRS_UNSPECIFIED);
> +    if (!gsb || len !=3D vcpu->runbufout.size) {
> +        address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
> +        *r3 =3D H_P2;
> +        return;
> +    }
> +
> +    exit_id_count =3D get_exit_ids(*r3, exit_cause_ids);
> +
> +    /* Create a buffer of elements to send back */
> +    gsb->num_elements =3D cpu_to_be32(exit_id_count);
> +    element =3D gsb->elements;
> +    for (int i =3D 0; i < exit_id_count; i++) {
> +        type =3D guest_state_element_type_find(exit_cause_ids[i]);
> +        assert(type);
> +        element->id =3D cpu_to_be16(exit_cause_ids[i]);
> +        element->size =3D cpu_to_be16(type->size);
> +        element =3D guest_state_element_next(element, NULL, NULL);
> +    }
> +    gsr.gsb =3D gsb;
> +    gsr.len =3D VCPU_OUT_BUF_MIN_SZ;
> +    gsr.flags =3D 0; /* get + never guest wide */
> +    getset_state(guest, vcpuid, &gsr);
> +
> +    address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
> +    return;
> +}
> +
> +static
> +void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, i=
nt excp)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    target_ulong r3_return =3D env->excp_vectors[excp]; /* hcall return =
value */
> +    target_ulong lpid =3D 0, vcpuid =3D 0;
> +    struct SpaprMachineStateNestedGuestVcpu *vcpu =3D NULL;
> +    struct SpaprMachineStateNestedGuest *guest =3D NULL;
> +
> +    lpid =3D spapr_cpu->nested_papr_host->gpr[5];
> +    vcpuid =3D spapr_cpu->nested_papr_host->gpr[6];
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    assert(guest);
> +    spapr_nested_vcpu_check(guest, vcpuid, false);
> +    vcpu =3D &guest->vcpu[vcpuid];
> +
> +    exit_nested_restore_vcpu(cpu, excp, vcpu);
> +    /* do the output buffer for run_vcpu*/
> +    exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
> +
> +    assert(env->spr[SPR_LPIDR] !=3D 0);
> +    restore_common_regs(env, spapr_cpu->nested_papr_host);

I need to take a look a bit closer, but AFAIKS you aren't
loading L1 decr when exiting to host...

> +    env->tb_env->tb_offset -=3D vcpu->tb_offset;

This is nasty, and I can say that because I did it in the
original code. We should call a timebase helper to do this
adjustment for us.

> +    env->gpr[3] =3D H_SUCCESS;
> +    env->gpr[4] =3D r3_return;
> +    nested_post_state_update(env, cs);
> +    cpu_ppc_hdecr_exit(env);
> +
> +    spapr_cpu->in_nested =3D false;
> +    g_free(spapr_cpu->nested_papr_host);
> +    spapr_cpu->nested_papr_host =3D NULL;
> +}
> +
> +static void nested_papr_restore_l2_state(PowerPCCPU *cpu,
> +                                         CPUPPCState *env,
> +                                         SpaprMachineStateNestedGuestVcp=
u *vcpu,
> +                                         target_ulong now)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong lpcr, lpcr_mask, hdec;
> +    lpcr_mask =3D LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
> +
> +    assert(vcpu);
> +    assert(sizeof(env->gpr) =3D=3D sizeof(vcpu->env.gpr));
> +    restore_common_regs(env, &vcpu->env);
> +    lpcr =3D (env->spr[SPR_LPCR] & ~lpcr_mask) |
> +           (vcpu->env.spr[SPR_LPCR] & lpcr_mask);
> +    lpcr |=3D LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
> +    lpcr &=3D ~LPCR_LPES0;
> +    env->spr[SPR_LPCR] =3D lpcr & pcc->lpcr_mask;
> +
> +    hdec =3D vcpu->hdecr_expiry_tb - now;
> +    cpu_ppc_store_decr(env, vcpu->dec_expiry_tb - now);
> +    cpu_ppc_hdecr_init(env);
> +    cpu_ppc_store_hdecr(env, hdec);
> +
> +    env->tb_env->tb_offset +=3D vcpu->tb_offset;
> +}
> +
> +static void nested_papr_run_vcpu(PowerPCCPU *cpu,
> +                                 uint64_t lpid,
> +                                 SpaprMachineStateNestedGuestVcpu *vcpu)
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
> +    nested_papr_restore_l2_state(cpu, env, vcpu, now);
> +    env->spr[SPR_LPIDR] =3D lpid; /* post restore l2 state */
> +
> +    spapr_cpu->in_nested =3D true;
> +
> +    nested_post_state_update(env, cs);
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
> +    if (!spapr_nested_vcpu_check(guest, vcpuid, true)) {
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
> +        nested_papr_run_vcpu(cpu, lpid, vcpu);
> +    }

If there is an error with map_and_getset, does it set gpr[3] to
an error code? IMO may be nicer if map_and_getset_state returns
the error itself, and this caller can set it in r3.

Thanks,
Nick

> +
> +    return env->gpr[3];
> +}
> +
>  void spapr_register_nested(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
> @@ -1473,6 +1754,7 @@ void spapr_register_nested_papr(void)
>      spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vc=
pu);
>      spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state=
);
>      spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state=
);
> +    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu)=
;
>  }
>  #else
>  void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b9a67895bb..e278ddc7cf 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -594,6 +594,7 @@ struct SpaprMachineState {
>  #define H_GUEST_CREATE_VCPU      0x474
>  #define H_GUEST_GET_STATE        0x478
>  #define H_GUEST_SET_STATE        0x47C
> +#define H_GUEST_RUN_VCPU         0x480
>  #define H_GUEST_DELETE           0x488
> =20
>  #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 9c8c59f173..a9749a2df1 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -53,7 +53,12 @@ typedef struct SpaprCpuState {
> =20
>      /* Fields for nested-HV support */
>      bool in_nested; /* true while the L2 is executing */
> -    struct nested_ppc_state *nested_hv_host; /* holds the L1 state while=
 L2 executes */
> +    union {
> +        /* holds the L1 state while L2 executes */
> +        struct nested_ppc_state *nested_hv_host;
> +        CPUPPCState             *nested_papr_host;
> +    };
> +
>  } SpaprCpuState;
> =20
>  static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)


