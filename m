Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8544972FDCC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PCy-0003WU-Pb; Wed, 14 Jun 2023 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9PCo-0003Tx-6T; Wed, 14 Jun 2023 08:02:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9PCm-0002Te-1x; Wed, 14 Jun 2023 08:02:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b3a6fc8067so27146035ad.3; 
 Wed, 14 Jun 2023 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686744145; x=1689336145;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brYdMjALb2HM7oRIBGjadRTP8SPLu/A836+ti8xloMo=;
 b=o/G0PqTX86WkoXXTM0lOV5P90rr2qrL1hsbQbDnmZtyHkh1KY7tcOonahlKdKLKdbZ
 gL/oV3B50dd3XDxGAO+biJCxtKUplDMfi9Nx8e62IXqR3SOeTubDTrkUh/R6gNanfjJ2
 OZQIy9I3Jy95e+ZVees0AxEnrZ6X08VY37Y2OblAQ9SJauShBXwXxhYarqdLwIUADKk4
 i6QcP+Ds+cm+33pyUv3TzxaWTvqmXjzjuQoc9i2I+F9DGHCAVQh0OD899VdCxWVPAU9c
 AnY9KwSRLpX7m8z8i7o6CE/dnRYnZrMznt9NKZEjjouhFGsIjdVmJj77kovTfcGY8zZW
 PQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686744145; x=1689336145;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=brYdMjALb2HM7oRIBGjadRTP8SPLu/A836+ti8xloMo=;
 b=bmIpj3Qx5/cJ87VilGXUOnBDWN26QcHDnT5MyIGA6IXueevB6otaSFmflBGEchaVmx
 hLFUjTO8fq3kLbGgXuCVcSJeH7T4iGitMPMlRP02ddasiMiMzEpfxmqDflmOusI45h/g
 I/eZvleXJVc6JMY6CAkZB+aXR0iWeFIHotVSQx1ZpfHfIA8wPaRLF2WdTjhS5h1NZg8L
 35lfjDF2wt9JnyBCEXIO5yqJJ3FqinuQRwvrqPNWT1bnpxM4ItURK4LvF93CPzVohmp6
 WUIuUhO65aJPuYM2O0UaEt7+a8kF4Hirh+ix9FfwPwrW95V3s8NIfA4JFbc20AyKhXVX
 lNXQ==
X-Gm-Message-State: AC+VfDxFPC5HbJ2+V5yFFp2omBJHSkZywX09WhZLSQ6ts4olD0Oy8ntE
 ttjljfMjGKFfMOtqs6aBcBI=
X-Google-Smtp-Source: ACHHUZ5SNZQRqzkstDGuejJHGw+RiKXQEynWltZ/LUk9kGTElvspyGKxkVy3vn5YNEiWTugZbBvgEQ==
X-Received: by 2002:a17:902:d2cb:b0:1ae:50a4:78da with SMTP id
 n11-20020a170902d2cb00b001ae50a478damr11698607plc.67.1686744144440; 
 Wed, 14 Jun 2023 05:02:24 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 jd10-20020a170903260a00b001b3d4bb352dsm5434324plb.175.2023.06.14.05.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:02:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 22:02:20 +1000
Message-Id: <CTCCW8LJ6EZR.1VDVZ6UVH6FGF@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 3/4] ppc/spapr: load and store l2 state with helper
 functions
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-4-npiggin@gmail.com>
 <90f62b35-aba5-df79-a50d-29f78a79c7b3@linux.ibm.com>
In-Reply-To: <90f62b35-aba5-df79-a50d-29f78a79c7b3@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Fri Jun 9, 2023 at 6:00 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/8/23 14:43, Nicholas Piggin wrote:
> > Arguably this is just shuffling around register accesses, but one nice
> > thing it does is allow the exit to save away the L2 state then switch
> > the environment to the L1 before copying L2 data back to the L1, which
> > logically flows more naturally and simplifies the error paths.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr_hcall.c | 164 ++++++++++++++++++++++--------------------=
-
> >   1 file changed, 85 insertions(+), 79 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index d5b8d54692..da6440f235 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1663,9 +1663,9 @@ static target_ulong h_enter_nested(PowerPCCPU *cp=
u,
> >                                      target_ulong *args)
> >   {
> >       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > -    CPUState *cs =3D CPU(cpu);
> >       CPUPPCState *env =3D &cpu->env;
> >       SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +    struct nested_ppc_state l2_state;
> >       target_ulong hv_ptr =3D args[0];
> >       target_ulong regs_ptr =3D args[1];
> >       target_ulong hdec, now =3D cpu_ppc_load_tbl(env);
> > @@ -1699,6 +1699,10 @@ static target_ulong h_enter_nested(PowerPCCPU *c=
pu,
> >           return H_PARAMETER;
> >       }
> >  =20
> > +    if (hv_state.lpid =3D=3D 0) {
> > +        return H_PARAMETER;
> > +    }
> > +
> >       spapr_cpu->nested_host_state =3D g_try_new(struct nested_ppc_stat=
e, 1);
> >       if (!spapr_cpu->nested_host_state) {
> >           return H_NO_MEM;
> > @@ -1717,46 +1721,49 @@ static target_ulong h_enter_nested(PowerPCCPU *=
cpu,
> >           return H_P2;
> >       }
> >  =20
> > -    len =3D sizeof(env->gpr);
> > +    len =3D sizeof(l2_state.gpr);
> >       assert(len =3D=3D sizeof(regs->gpr));
> > -    memcpy(env->gpr, regs->gpr, len);
> > +    memcpy(l2_state.gpr, regs->gpr, len);
> >  =20
> > -    env->lr =3D regs->link;
> > -    env->ctr =3D regs->ctr;
> > -    cpu_write_xer(env, regs->xer);
> > -    ppc_set_cr(env, regs->ccr);
> > -
> > -    env->msr =3D regs->msr;
> > -    env->nip =3D regs->nip;
> > +    l2_state.lr =3D regs->link;
> > +    l2_state.ctr =3D regs->ctr;
> > +    l2_state.xer =3D regs->xer;
> > +    l2_state.cr =3D regs->ccr;
> > +    l2_state.msr =3D regs->msr;
> > +    l2_state.nip =3D regs->nip;
> >  =20
> >       address_space_unmap(CPU(cpu)->as, regs, len, len, false);
> >  =20
> > -    env->cfar =3D hv_state.cfar;
> > -
> > -    assert(env->spr[SPR_LPIDR] =3D=3D 0);
> > -    env->spr[SPR_LPIDR] =3D hv_state.lpid;
> > +    l2_state.cfar =3D hv_state.cfar;
> > +    l2_state.lpidr =3D hv_state.lpid;
> >  =20
> >       lpcr_mask =3D LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_ME=
R;
> >       lpcr =3D (env->spr[SPR_LPCR] & ~lpcr_mask) | (hv_state.lpcr & lpc=
r_mask);
> >       lpcr |=3D LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDI=
CE;
> >       lpcr &=3D ~LPCR_LPES0;
> > -    env->spr[SPR_LPCR] =3D lpcr & pcc->lpcr_mask;
> > +    l2_state.lpcr =3D lpcr & pcc->lpcr_mask;
> >  =20
> > -    env->spr[SPR_PCR] =3D hv_state.pcr;
> > +    l2_state.pcr =3D hv_state.pcr;
> >       /* hv_state.amor is not used */
> > -    env->spr[SPR_DPDES] =3D hv_state.dpdes;
> > -    env->spr[SPR_HFSCR] =3D hv_state.hfscr;
> > -    hdec =3D hv_state.hdec_expiry - now;
> > +    l2_state.dpdes =3D hv_state.dpdes;
> > +    l2_state.hfscr =3D hv_state.hfscr;
> >       /* TCG does not implement DAWR*, CIABR, PURR, SPURR, IC, VTB, HEI=
R SPRs*/
> > -    env->spr[SPR_SRR0] =3D hv_state.srr0;
> > -    env->spr[SPR_SRR1] =3D hv_state.srr1;
> > -    env->spr[SPR_SPRG0] =3D hv_state.sprg[0];
> > -    env->spr[SPR_SPRG1] =3D hv_state.sprg[1];
> > -    env->spr[SPR_SPRG2] =3D hv_state.sprg[2];
> > -    env->spr[SPR_SPRG3] =3D hv_state.sprg[3];
> > -    env->spr[SPR_BOOKS_PID] =3D hv_state.pidr;
> > -    env->spr[SPR_PPR] =3D hv_state.ppr;
> > +    l2_state.srr0 =3D hv_state.srr0;
> > +    l2_state.srr1 =3D hv_state.srr1;
> > +    l2_state.sprg0 =3D hv_state.sprg[0];
> > +    l2_state.sprg1 =3D hv_state.sprg[1];
> > +    l2_state.sprg2 =3D hv_state.sprg[2];
> > +    l2_state.sprg3 =3D hv_state.sprg[3];
> > +    l2_state.pidr =3D hv_state.pidr;
> > +    l2_state.ppr =3D hv_state.ppr;
> > +    l2_state.tb_offset =3D env->tb_env->tb_offset + hv_state.tb_offset=
;
> > +
> > +    /*
> > +     * Switch to the nested guest environment and start the "hdec" tim=
er.
> > +     */
> > +    nested_load_state(cpu, &l2_state);
> >  =20
> > +    hdec =3D hv_state.hdec_expiry - now;
> >       cpu_ppc_hdecr_init(env);
> >       cpu_ppc_store_hdecr(env, hdec);
> >  =20
> > @@ -1772,14 +1779,8 @@ static target_ulong h_enter_nested(PowerPCCPU *c=
pu,
> >        * and it's not obviously worth a new data structure to do it.
> >        */
> >  =20
> > -    env->tb_env->tb_offset +=3D hv_state.tb_offset;
> >       spapr_cpu->in_nested =3D true;
> >  =20
> > -    hreg_compute_hflags(env);
> > -    ppc_maybe_interrupt(env);
> > -    tlb_flush(cs);
> > -    env->reserve_addr =3D -1; /* Reset the reservation */
> > -
> >       /*
> >        * The spapr hcall helper sets env->gpr[3] to the return value, b=
ut at
> >        * this point the L1 is not returning from the hcall but rather w=
e
> > @@ -1793,49 +1794,69 @@ void spapr_exit_nested(PowerPCCPU *cpu, int exc=
p)
> >   {
> >       CPUPPCState *env =3D &cpu->env;
> >       SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > -    target_ulong r3_return =3D env->excp_vectors[excp]; /* hcall retur=
n value */
> > +    struct nested_ppc_state l2_state;
> >       target_ulong hv_ptr =3D spapr_cpu->nested_host_state->gpr[4];
> >       target_ulong regs_ptr =3D spapr_cpu->nested_host_state->gpr[5];
> > +    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
> >       struct kvmppc_hv_guest_state *hvstate;
> >       struct kvmppc_pt_regs *regs;
> >       hwaddr len;
> >  =20
> >       assert(spapr_cpu->in_nested);
> >  =20
> > +    nested_save_state(&l2_state, cpu);
> > +    hsrr0 =3D env->spr[SPR_HSRR0];
> > +    hsrr1 =3D env->spr[SPR_HSRR1];
> > +    hdar =3D env->spr[SPR_HDAR];
> > +    hdsisr =3D env->spr[SPR_HDSISR];
> > +    asdr =3D env->spr[SPR_ASDR];
> > +
> > +    /*
> > +     * Switch back to the host environment (including for any error).
> > +     */
> > +    assert(env->spr[SPR_LPIDR] !=3D 0);
> > +    nested_load_state(cpu, spapr_cpu->nested_host_state);
> > +    env->gpr[3] =3D env->excp_vectors[excp]; /* hcall return value */
> > +
> >       cpu_ppc_hdecr_exit(env);
> >  =20
> > +    spapr_cpu->in_nested =3D false;
> > +
> > +    g_free(spapr_cpu->nested_host_state);
> > +    spapr_cpu->nested_host_state =3D NULL;
> > +
> >       len =3D sizeof(*hvstate);
> >       hvstate =3D address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
> >                                   MEMTXATTRS_UNSPECIFIED);
> >       if (len !=3D sizeof(*hvstate)) {
> >           address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
> > -        r3_return =3D H_PARAMETER;
> > -        goto out_restore_l1;
> > +        env->gpr[3] =3D H_PARAMETER;
> > +	return;
> >       }
> >  =20
> > -    hvstate->cfar =3D env->cfar;
> > -    hvstate->lpcr =3D env->spr[SPR_LPCR];
> > -    hvstate->pcr =3D env->spr[SPR_PCR];
> > -    hvstate->dpdes =3D env->spr[SPR_DPDES];
> > -    hvstate->hfscr =3D env->spr[SPR_HFSCR];
> > +    hvstate->cfar =3D l2_state.cfar;
> > +    hvstate->lpcr =3D l2_state.lpcr;
> > +    hvstate->pcr =3D l2_state.pcr;
> > +    hvstate->dpdes =3D l2_state.dpdes;
> > +    hvstate->hfscr =3D l2_state.hfscr;
> >  =20
> >       if (excp =3D=3D POWERPC_EXCP_HDSI) {
> > -        hvstate->hdar =3D env->spr[SPR_HDAR];
> > -        hvstate->hdsisr =3D env->spr[SPR_HDSISR];
> > -        hvstate->asdr =3D env->spr[SPR_ASDR];
> > +        hvstate->hdar =3D hdar;
> > +        hvstate->hdsisr =3D hdsisr;
> > +        hvstate->asdr =3D asdr;
> >       } else if (excp =3D=3D POWERPC_EXCP_HISI) {
> > -        hvstate->asdr =3D env->spr[SPR_ASDR];
> > +        hvstate->asdr =3D asdr;
> >       }
> >  =20
> >       /* HEIR should be implemented for HV mode and saved here. */
> > -    hvstate->srr0 =3D env->spr[SPR_SRR0];
> > -    hvstate->srr1 =3D env->spr[SPR_SRR1];
> > -    hvstate->sprg[0] =3D env->spr[SPR_SPRG0];
> > -    hvstate->sprg[1] =3D env->spr[SPR_SPRG1];
> > -    hvstate->sprg[2] =3D env->spr[SPR_SPRG2];
> > -    hvstate->sprg[3] =3D env->spr[SPR_SPRG3];
> > -    hvstate->pidr =3D env->spr[SPR_BOOKS_PID];
> > -    hvstate->ppr =3D env->spr[SPR_PPR];
> > +    hvstate->srr0 =3D l2_state.srr0;
> > +    hvstate->srr1 =3D l2_state.srr1;
> > +    hvstate->sprg[0] =3D l2_state.sprg0;
> > +    hvstate->sprg[1] =3D l2_state.sprg1;
> > +    hvstate->sprg[2] =3D l2_state.sprg2;
> > +    hvstate->sprg[3] =3D l2_state.sprg3;
> > +    hvstate->pidr =3D l2_state.pidr;
> > +    hvstate->ppr =3D l2_state.ppr;
> >  =20
> >       /* Is it okay to specify write length larger than actual data wri=
tten? */
> >       address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
> > @@ -1845,46 +1866,31 @@ void spapr_exit_nested(PowerPCCPU *cpu, int exc=
p)
> >                                   MEMTXATTRS_UNSPECIFIED);
> >       if (!regs || len !=3D sizeof(*regs)) {
> >           address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
> > -        r3_return =3D H_P2;
> > -        goto out_restore_l1;
> > +        env->gpr[3] =3D H_P2;
> > +	return;
> >       }
> >  =20
> >       len =3D sizeof(env->gpr);
> >       assert(len =3D=3D sizeof(regs->gpr));
> > -    memcpy(regs->gpr, env->gpr, len);
> > +    memcpy(regs->gpr, l2_state.gpr, len);
> >  =20
> > -    regs->link =3D env->lr;
> > -    regs->ctr =3D env->ctr;
> > -    regs->xer =3D cpu_read_xer(env);
> > -    regs->ccr =3D ppc_get_cr(env);
> > +    regs->link =3D l2_state.lr;
> > +    regs->ctr =3D l2_state.ctr;
> > +    regs->xer =3D l2_state.xer;
> > +    regs->ccr =3D l2_state.cr;
> >  =20
> >       if (excp =3D=3D POWERPC_EXCP_MCHECK ||
> >           excp =3D=3D POWERPC_EXCP_RESET ||
> >           excp =3D=3D POWERPC_EXCP_SYSCALL) {
> > -        regs->nip =3D env->spr[SPR_SRR0];
> > -        regs->msr =3D env->spr[SPR_SRR1] & env->msr_mask;
> > +        regs->nip =3D l2_state.srr0;
> > +        regs->msr =3D l2_state.srr1 & env->msr_mask;
> >       } else {
> > -        regs->nip =3D env->spr[SPR_HSRR0];
> > -        regs->msr =3D env->spr[SPR_HSRR1] & env->msr_mask;
> > +        regs->nip =3D hsrr0;
> > +        regs->msr =3D hsrr1 & env->msr_mask;
> >       }
> >  =20
>
> Can the copying of L2 data to L1 be abstraced with an inline helper
> routine as well ? Then the spapr_exit_nested will look more neat:
>   - nested_save_state(l2)
>   - nested_load_state(host)
>   - copy_l2_state_to_l1() <=3D=3D=3D something like this?

I did start to look at that, but I thought having the code to move
the data in and out of the actual the hcall API format in the
hcall functions themselves worked okay.

If there could be some streamlining or code sharing with the v2
nested-HV API, I wouldn't mind that but would probably like to see
it done as part of the v2 patches so we can see how it works.

Thanks,
Nick

