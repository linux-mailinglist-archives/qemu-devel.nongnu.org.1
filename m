Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC372FD9C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 13:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9P72-0000sr-HQ; Wed, 14 Jun 2023 07:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9P6z-0000sR-1Q; Wed, 14 Jun 2023 07:56:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9P6x-0000pM-4l; Wed, 14 Jun 2023 07:56:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6664e4d8fb4so396706b3a.3; 
 Wed, 14 Jun 2023 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686743785; x=1689335785;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWta0cZTpw2edQffLDIAf2wWyBOg0oWFa5VEy2KG83s=;
 b=rQE64WMnBzJnKan5/+0aBKSxw088CMDxwXaymk5074ADUwSPKusw+bmmukPbRZKa4q
 Az62qI5VuHwUngQsGsVCLKthHZDzEsqGWGwQb0qhcUxYIWRVyCFaqsQXbRw9fGE9F+gd
 EIVBsvj1zD0NDZzen70J6YcNfcff6nw/ftOGxTv6LYmcFutmQyPfb1kt+9/Ch6wyLq0B
 IwATeywg47w/wJoek8N1vbjdyqBFpmtfihkpp1O0FZs2Ce489YagpQFCofklAJguf8Hv
 ngUZGyfOa9gYQVohrHVwLKPAeA2ljf1F3QukCkQPvM9xF0LpppnuezALMGyW+UYMGAlb
 5VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686743785; x=1689335785;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lWta0cZTpw2edQffLDIAf2wWyBOg0oWFa5VEy2KG83s=;
 b=EZL2Vz+bSt93NNdCMoAXB+tX0LY9/FH+/Q5xMPzneSqQlIVTZfvjTYYh7oBHeQl1UC
 FCxLLlYVSXSO4atG5J/IKEiYB9DZfhcSdOJieOH+/6dJkyG1aIiIuV2N/zsEVJDx79vt
 1KRF84yYKuh4UgIywod6S86eAURaxZ5o7w16WyNiLIgPB/QPAbZeWq0dvlQGT+r2Vos8
 LKxQmGFj6PwtK9fLgr6uyCuutXk7pHP3FsBUYHBELEZ1fnwRO8JW9KrJILojYYAXe1NI
 /Yv/Mdib4PDJzqupyFOzI/qrmi49M2D0hSdYhqIAIafmGf03lzVWRfQ9csPXP6pZPC+D
 82jQ==
X-Gm-Message-State: AC+VfDz6VzjSKbclvsOdnghHGElcm6DKC+bEiPFk6XpioMO43+ixKmtC
 lW8695XCjz5mLbNflUe6+Hx+xW+g0Vg=
X-Google-Smtp-Source: ACHHUZ5qtXadKbvyM5+RF0YMLvY7M/hPam9WbrKf9fOfba2raMRJwno+o2RVnAnhkejXdfNLB+YXDQ==
X-Received: by 2002:a05:6a20:914f:b0:10b:cb87:f5e with SMTP id
 x15-20020a056a20914f00b0010bcb870f5emr1271224pzc.45.1686743785388; 
 Wed, 14 Jun 2023 04:56:25 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a1709026b8400b001b034d2e71csm12000688plk.34.2023.06.14.04.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 04:56:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 21:56:20 +1000
Message-Id: <CTCCRNIC7LCM.383MVI3UNIDK4@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 2/4] ppc/spapr: Add a nested state struct
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-3-npiggin@gmail.com>
 <f350a17c-5164-93ed-446f-1925ced02f10@linux.ibm.com>
In-Reply-To: <f350a17c-5164-93ed-446f-1925ced02f10@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Fri Jun 9, 2023 at 5:09 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/8/23 14:43, Nicholas Piggin wrote:
> > Rather than use a copy of CPUPPCState to store the host state while
> > the environment has been switched to the L2, use a new struct for
> > this purpose.
> >=20
> > Have helper functions to save and load this host state.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr_hcall.c            | 150 ++++++++++++++++++++++++-------=
-
> >   include/hw/ppc/spapr_cpu_core.h |   5 +-
> >   2 files changed, 115 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 0582b524d1..d5b8d54692 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1546,6 +1546,112 @@ static target_ulong h_copy_tofrom_guest(PowerPC=
CPU *cpu,
> >       return H_FUNCTION;
> >   }
> >  =20
> > +struct nested_ppc_state {
> > +    uint64_t gpr[32];
> > +    uint64_t lr;
> > +    uint64_t ctr;
> > +    uint64_t cfar;
> > +    uint64_t msr;
> > +    uint64_t nip;
> > +    uint32_t cr;
> > +
> > +    uint64_t xer;
> > +
> > +    uint64_t lpcr;
> > +    uint64_t lpidr;
> > +    uint64_t pidr;
> > +    uint64_t pcr;
> > +    uint64_t dpdes;
> > +    uint64_t hfscr;
> > +    uint64_t srr0;
> > +    uint64_t srr1;
> > +    uint64_t sprg0;
> > +    uint64_t sprg1;
> > +    uint64_t sprg2;
> > +    uint64_t sprg3;
> > +    uint64_t ppr;
> > +
> > +    int64_t tb_offset;
> > +};
> > +
>
> <snip>
>
> > +static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state=
 *load)
> > +{
> > +    CPUState *cs =3D CPU(cpu);
> > +    CPUPPCState *env =3D &cpu->env;
> > +
> > +    memcpy(env->gpr, load->gpr, sizeof(env->gpr));
> > +
> > +    env->lr =3D load->lr;
> > +    env->ctr =3D load->ctr;
> > +    env->cfar =3D load->cfar;
> > +    env->msr =3D load->msr;
> > +    env->nip =3D load->nip;
> > +
> > +    ppc_set_cr(env, load->cr);
> > +    cpu_write_xer(env, load->xer);
> > +
> > +    env->spr[SPR_LPCR] =3D load->lpcr;
> > +    env->spr[SPR_LPIDR] =3D load->lpidr;
> > +    env->spr[SPR_PCR] =3D load->pcr;
> > +    env->spr[SPR_DPDES] =3D load->dpdes;
> > +    env->spr[SPR_HFSCR] =3D load->hfscr;
> > +    env->spr[SPR_SRR0] =3D load->srr0;
> > +    env->spr[SPR_SRR1] =3D load->srr1;
> > +    env->spr[SPR_SPRG0] =3D load->sprg0;
> > +    env->spr[SPR_SPRG1] =3D load->sprg1;
> > +    env->spr[SPR_SPRG2] =3D load->sprg2;
> > +    env->spr[SPR_SPRG3] =3D load->sprg3;
> > +    env->spr[SPR_BOOKS_PID] =3D load->pidr;
> > +    env->spr[SPR_PPR] =3D load->ppr;
> > +
> > +    env->tb_env->tb_offset =3D load->tb_offset;
> > +
> > +    /*
> > +     * MSR updated, compute hflags and possible interrupts.
> > +     */
> > +    hreg_compute_hflags(env);
> > +    ppc_maybe_interrupt(env);
> > +
> > +    /*
> > +     * Nested HV does not tag TLB entries between L1 and L2, so must
> > +     * flush on transition.
> > +     */
> > +    tlb_flush(cs);
> > +    env->reserve_addr =3D -1; /* Reset the reservation */
> > +}
> > +
>
> <snip>
>
> > @@ -1766,34 +1872,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp=
)
> >       address_space_unmap(CPU(cpu)->as, regs, len, len, true);
> >  =20
> >   out_restore_l1:
> > -    memcpy(env->gpr, spapr_cpu->nested_host_state->gpr, sizeof(env->gp=
r));
> > -    env->lr =3D spapr_cpu->nested_host_state->lr;
> > -    env->ctr =3D spapr_cpu->nested_host_state->ctr;
> > -    memcpy(env->crf, spapr_cpu->nested_host_state->crf, sizeof(env->cr=
f));
> > -    env->cfar =3D spapr_cpu->nested_host_state->cfar;
> > -    env->xer =3D spapr_cpu->nested_host_state->xer;
> > -    env->so =3D spapr_cpu->nested_host_state->so;
> > -    env->ca =3D spapr_cpu->nested_host_state->ca;
> > -    env->ov =3D spapr_cpu->nested_host_state->ov;
> > -    env->ov32 =3D spapr_cpu->nested_host_state->ov32;
> > -    env->ca32 =3D spapr_cpu->nested_host_state->ca32;
>
> Above fields so, ca, ov, ov32, ca32 are not taken care in=20
> nested_load_state, ca being introduced in previous patch.

They should be, by cpu_write_xer.

Thanks,
Nick

