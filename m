Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A939D71FA6C
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ykp-0002LL-Om; Fri, 02 Jun 2023 02:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4ykn-0002Km-IH; Fri, 02 Jun 2023 02:59:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4ykl-0005RM-Tg; Fri, 02 Jun 2023 02:59:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso2011679b3a.3; 
 Thu, 01 Jun 2023 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685689154; x=1688281154;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqlwG3P5LdQIZlz6m894YPiIP/VY4aaNRPlJ1+2s4J0=;
 b=LYeXryVFTq82QbQtv2loDx+BOcDU/fTwEWBROp/47vSAc5CwPwXqGQrL4AF7GWq/si
 TdjDijLbv8df9+kg5bgAM7nzeQsSHZtFSPCwkS7x7KRF5e4DlQ5FdwGC1KGMci4OTavy
 gKEBc0Gy11kkc7RhLcT20MS+XWUuzPvj6gEFMtPXRtCF3ot/lh6h9jYI2OI+854VsJql
 yAoYY5PV9dyIahaqd1aVig/QcrMRTC68anl3Pdnj6wwKCp0ySFOS7N/zFq0/R4aQQOMw
 pnhzk5SQXOhpsyJuMrZg2Pi42oco1T9o+b7Rh7XMr0ZWWHKXrE4hj3Z2ps34OC5Zvy2Z
 NuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685689154; x=1688281154;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MqlwG3P5LdQIZlz6m894YPiIP/VY4aaNRPlJ1+2s4J0=;
 b=d56eKzGWBn3qrZpXuC9kR26/qXsKxVL2Pu7koTR7Z86hTUpv0DMvcIQEbzDRkdziMI
 jLb6mTMtLpb8raUmWUVXkFqTmhXzcxu9rW1thx5o0+CbvEsDQKPiQdcsMs7EL5cv0mTf
 FlbgKgdW/U65by5Zbm/EdDgxKTwCIuyx4/c5b3BOKBuiEzyjHZvpG5Zu2EigVDahNGR4
 vHnKpkx79HyE9uFRyH6O3f9mLrxbav1OSJY+Xfg80ph0ozlnwd7wg7F6UzYJ5mL//Fcq
 KU6PsMIV37/EyBriTQjsbX0isXOTT8H5zoBRnSMzkbi8cYfN1GALZBtkrqZnUlU0l8uG
 s23A==
X-Gm-Message-State: AC+VfDye4rAoBCNIDMFH0SekRBVmSvHj9jk0p9Phbwc/bZ3Cj5LJwIdh
 WR5mQsp9czMgU4n12GapQHI=
X-Google-Smtp-Source: ACHHUZ50nZPnObMDpj0ZKj5Lv+gSB49IZgpUAqzRjBjTWHwXVVPhhlqUJFPw3NldekuGtZzjAHKRrQ==
X-Received: by 2002:a05:6a21:9995:b0:10b:91c5:45a8 with SMTP id
 ve21-20020a056a21999500b0010b91c545a8mr13828414pzb.15.1685689153848; 
 Thu, 01 Jun 2023 23:59:13 -0700 (PDT)
Received: from localhost ([1.146.22.171]) by smtp.gmail.com with ESMTPSA id
 h13-20020a63e14d000000b0053fed3131e6sm526734pgk.65.2023.06.01.23.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 23:59:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jun 2023 16:59:06 +1000
Message-Id: <CT1YXJ6J1W97.3RLRVO5ZNY61F@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [RFC PATCH 5/5] spapr: Allow up to 8 threads SMT configuration
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-6-npiggin@gmail.com>
 <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
In-Reply-To: <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Thu Jun 1, 2023 at 5:20 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/31/23 03:23, Nicholas Piggin wrote:
> > TCG now supports multi-threaded configuration at least enough for
> > pseries to be functional enough to boot Linux.
> >=20
> > This requires PIR and TIR be set, because that's how sibling thread
> > matching is done.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c          | 4 ++--
> >   hw/ppc/spapr_cpu_core.c | 7 +++++--
> >   2 files changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index dcb7f1c70a..11074cefea 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2524,8 +2524,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
 *spapr, Error **errp)
> >       int ret;
> >       unsigned int smp_threads =3D ms->smp.threads;
> >  =20
> > -    if (!kvm_enabled() && (smp_threads > 1)) {
> > -        error_setg(errp, "TCG cannot support more than 1 thread/core "
> > +    if (!kvm_enabled() && (smp_threads > 8)) {
> > +        error_setg(errp, "TCG cannot support more than 8 threads/core =
"
> >                      "on a pseries machine");
>
> I think we should add test on the CPU also.

On the CPU type, POWER7 can have 1/2/4, POWER8 can have 1/2/4/8?
POWER9 could also switch PVR between big and small core depending
on whether you select SMT8 I suppose.

> >           return;
> >       }
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 9b88dd549a..f35ee600f1 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -255,7 +255,7 @@ static void spapr_cpu_core_unrealize(DeviceState *d=
ev)
> >   }
> >  =20
> >   static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *sp=
apr,
> > -                               SpaprCpuCore *sc, Error **errp)
> > +                               SpaprCpuCore *sc, int thread_nr, Error =
**errp)
>
> thread_index may be ?

Sure.

> >   {
> >       CPUPPCState *env =3D &cpu->env;
> >       CPUState *cs =3D CPU(cpu);
> > @@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> >       kvmppc_set_papr(cpu);
>
> so, spapr_create_vcpu() set cs->cpu_index :
>      cs->cpu_index =3D cc->core_id + i;
>
> and spapr_realize_vcpu :
>    =20
> > +    env->spr_cb[SPR_PIR].default_value =3D cs->cpu_index;
> > +    env->spr_cb[SPR_TIR].default_value =3D thread_nr;
> > +
> it would be cleaner to do the SPR assignment in one place.

I'll try that, it sounds good.

Thanks,
Nick


