Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185A373DBFE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj5N-0001qT-Hw; Mon, 26 Jun 2023 06:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDj5H-0001pe-Ng; Mon, 26 Jun 2023 06:04:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDj5F-00009Y-PK; Mon, 26 Jun 2023 06:04:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b7f68f1c9eso12056305ad.2; 
 Mon, 26 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687773872; x=1690365872;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmhhoyxNTmGxJqioqiJzsQ7Up0560CH37iOVP2wVvkY=;
 b=Bv1UJhhbVXM2rYodOONpzBcmzt5921uEhFAnCd1tRjV1NoKXXuuTo7843GuqqYl4aK
 GPRuQnHbbwbQnxs5p4Ug/dRA2qO4GUzrQMgYc86iVLXZ0lZbPzu7R01y4JSNsF/cG0bT
 DTskngKQzgeKtXYyGB+UdUbUnINEyxO//PWBLGjWHWU6O6ntxnLBw16wMf23GhVDHjks
 1njk8KF8KDSUKz4BU5uKSe72Y0mRvzM2yXtMkAs1eOGA3+6TowGYY3idSAGpkrAYPHsI
 5fjHJg6hxn0f3Jk22pB8Nl1JEkl1NGoUA7PjK6SgX6rsm2JBXEiW8Ajv9nSvtn7YP7rs
 oeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773872; x=1690365872;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FmhhoyxNTmGxJqioqiJzsQ7Up0560CH37iOVP2wVvkY=;
 b=IN8ua/G+KMwl1SGHdbvUfpaLACVmpyTkjD0CwIdIU8ESOVz4/JaKJwCt1/VhQugdXy
 YXAbJdifKM4Zari8dYXWBRV5wMmF72ufPDJ6an58l61eUrkxiUEL+J74a7W9YWCKiVQf
 Ffr706tIiq6vM4Mst5TlH95EoKUUTc/Y5L74jQVK+KG0xiLjcyz3HiH+IxTfGP9/8HNf
 KZZ1+6V9euMT0fT4mNyZMDyfwjITEZlAhaPmQj4NZlNUU0tvhDC0dz1fmQVyyAF7Pn/7
 ocHkFZ6lCdWJjE0vDA3fus/bKUVR1JJkiAfxOTdfxQLaT2PkeMAlcry2TW9UjKM4kPJR
 yzoA==
X-Gm-Message-State: AC+VfDz5GtDNtCJjiBj/6JCy86c4Xt+B4gb+XeaSCoIeFELzHx0OHZ5U
 MRbRWBB4Pb5H1TM8dj51av0=
X-Google-Smtp-Source: ACHHUZ78BtOpWNLUw/xcdyMhXaCaPi/G/WlVFtTHuNKPRuhrEkqHbdj7oHcLrJZcX+xErVm9GnbcAQ==
X-Received: by 2002:a17:903:4091:b0:1b1:78ba:f350 with SMTP id
 z17-20020a170903409100b001b178baf350mr6291929plc.46.1687773871661; 
 Mon, 26 Jun 2023 03:04:31 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a170902bc4700b001b03b7f8adfsm3731087plz.246.2023.06.26.03.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:04:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2023 20:04:22 +1000
Message-Id: <CTMHWGLNST28.1P1TPVQWO5LR7@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "John Snow"
 <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming
 too many events
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-5-npiggin@gmail.com>
 <b1b7ab0d-caf2-46ca-eed2-7cdc87c0b600@ispras.ru>
In-Reply-To: <b1b7ab0d-caf2-46ca-eed2-7cdc87c0b600@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Mon Jun 26, 2023 at 6:07 PM AEST, Pavel Dovgalyuk wrote:
> e500 has the same problem, I think, according to this issue:=20
> https://gitlab.com/qemu-project/qemu/-/issues/1634

Same symptoms. e500 looks like it does the dt build in
machine_init_done notifier, though. Maybe I miss something.
I'll take a look.

>
> Btw, ARM virt platform rebuilds fdt only at initialization phase, not=20
> when reset.

I was actually wondering about keeping the same rng-seed across resets
to make the code even simpler, but decided to keep behaviour unchanged.
That seems like one downside.

> Isn't this behavior correct? Shouldn't PPC platforms do the similar thing=
?

I believe spapr does this for an spapr "feature" that rebuilds the fdt
at runtime ("client-architecture-support"), so reset has to build the
original one again.

Thanks,
Nick

>
> On 23.06.2023 15:57, Nicholas Piggin wrote:
> > spapr_machine_reset gets a random number to populate the device-tree
> > rng seed with. When loading a snapshot for record-replay, the machine
> > is reset again, and that tries to consume the random event record
> > again, crashing due to inconsistent record
> >=20
> > Fix this by saving the seed to populate the device tree with, and
> > skipping the rng on snapshot load.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c         | 12 +++++++++---
> >   include/hw/ppc/spapr.h |  1 +
> >   2 files changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d290acfa95..55948f233f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1017,7 +1017,6 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
apr, void *fdt, bool reset)
> >   {
> >       MachineState *machine =3D MACHINE(spapr);
> >       SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> > -    uint8_t rng_seed[32];
> >       int chosen;
> >  =20
> >       _FDT(chosen =3D fdt_add_subnode(fdt, 0, "chosen"));
> > @@ -1095,8 +1094,7 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
apr, void *fdt, bool reset)
> >           spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> >       }
> >  =20
> > -    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> > -    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_see=
d)));
> > +    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32)=
);
> >  =20
> >       _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture=
-vec-5"));
> >   }
> > @@ -1649,6 +1647,14 @@ static void spapr_machine_reset(MachineState *ma=
chine, ShutdownCause reason)
> >       void *fdt;
> >       int rc;
> >  =20
> > +    if (reason !=3D SHUTDOWN_CAUSE_SNAPSHOT_LOAD) {
> > +        /*
> > +         * Record-replay snapshot load must not consume random, this w=
as
> > +         * already replayed from initial machine reset.
> > +         */
> > +        qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
> > +    }
> > +
> >       pef_kvm_reset(machine->cgs, &error_fatal);
> >       spapr_caps_apply(spapr);
> >  =20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index f47e8419a5..f4bd204d86 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -204,6 +204,7 @@ struct SpaprMachineState {
> >       uint32_t fdt_size;
> >       uint32_t fdt_initial_size;
> >       void *fdt_blob;
> > +    uint8_t fdt_rng_seed[32];
> >       long kernel_size;
> >       bool kernel_le;
> >       uint64_t kernel_addr;


