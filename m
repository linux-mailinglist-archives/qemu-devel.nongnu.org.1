Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B886A771494
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 13:47:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScDZ-00047q-22; Sun, 06 Aug 2023 07:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScDU-00047G-Qo; Sun, 06 Aug 2023 07:46:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScDS-0001n8-Ta; Sun, 06 Aug 2023 07:46:36 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so2386876b3a.0; 
 Sun, 06 Aug 2023 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691322393; x=1691927193;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUQ2kHzqlRhH+XU/VrYVal7Nx4iNWT+g03fflwfM+jw=;
 b=hsgSB5TP99IBFU6cU09MN/oFvZY7Qalt11/n2P85DCqbcDq0tYic8OBLqhHcV7RWcu
 fTXIOCLpUP8V+3iqCQ/1pzqmr+Nj5ZLLFFU1R0dkdNGlxYWmZyz/Sh1oczwgwjrpcQBD
 gU4IUrLGXgqHAtAEhv1Bx0zd9/K/y2UJVGvoXrug/mJxhfCXOaapQ474Up6Ii7tos4iY
 cQQJw9BusAI+j+U/y7WpeRw4sw9yk3wuqZYdVt9qIH1rJPfaZ/4CvQwTqace+IdI7qt+
 sJoT/274fjjEKpp/q95p+QTLoLCqvMIvaNUQKJ91OnB8oLjGlmG0TRiuld2ooKWOUCET
 QAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691322393; x=1691927193;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUQ2kHzqlRhH+XU/VrYVal7Nx4iNWT+g03fflwfM+jw=;
 b=BFNf+486thnMi0YbpjCHUFsl15sfTiEUwQU314c525B1bJWYDpIJibD/fGhgiR4wlv
 qYCX7rxXnXelfYrl+kFV+4kzpY5Z7tQ2FybP8zHt6309WGYlnjHyUcBicQmy16IVKO3q
 9qq4Hp2xXNoPSMBA6VcidyPVmvdUi9KDZgFf6Way38qT0GmKD0agoNhMM6scX1U4xTsm
 P8uMDvxGIeRwYrdrWRH/bKnCe/icpBJIrzHAp7s0KMFsnKi7zSjKycnuRmOK04j8Bh4e
 tIkjKdAiFLyAQQpKq+RMzgkvj1G1xE6jgmnalg77UJFKWhGVp5J463XqqTmGJFbXg5K2
 iHMA==
X-Gm-Message-State: AOJu0YxQKUabUiFz95Y4WEsHraeCeV6CaLZWvR80SGYuatCIrRer99Nr
 nMmZDk623kaIJWzEsFTx5I8=
X-Google-Smtp-Source: AGHT+IF08hx1Q5p66GCzmqcCx8qxDLy7tSCGIAeSVe2W8LezkgCFoDb1KmlzPgHFroV5d1NvCzI2fg==
X-Received: by 2002:a05:6a20:a108:b0:13d:d5bd:6985 with SMTP id
 q8-20020a056a20a10800b0013dd5bd6985mr6546478pzk.12.1691322392742; 
 Sun, 06 Aug 2023 04:46:32 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a63ad04000000b005646bc58f07sm3534862pgf.17.2023.08.06.04.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 04:46:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Aug 2023 21:46:25 +1000
Message-Id: <CULFQXOOUWDB.3GMPJXRWAWSDW@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming
 too many events
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-5-npiggin@gmail.com>
 <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
In-Reply-To: <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Fri Aug 4, 2023 at 6:50 PM AEST, Pavel Dovgalyuk wrote:
> BTW, there is a function qemu_register_reset_nosnapshotload that can be=
=20
> used in similar cases.
> Can you just use it without changing the code of the reset handler?

I didn't know that, thanks for pointing it out. I'll take a closer look
at it before reposting.

Thanks,
Nick

>
> On 26.07.2023 21:35, Nicholas Piggin wrote:
> > spapr_machine_reset gets a random number to populate the device-tree
> > rng seed with. When loading a snapshot for record-replay, the machine
> > is reset again, and that tries to consume the random event record
> > again, crashing due to inconsistent record
> >=20
> > Fix this by saving the seed to populate the device tree with, and
> > skipping the rng on snapshot load.
> >=20
> > Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c         | 12 +++++++++---
> >   include/hw/ppc/spapr.h |  1 +
> >   2 files changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7d84244f03..ecfbdb0030 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1022,7 +1022,6 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
apr, void *fdt, bool reset)
> >   {
> >       MachineState *machine =3D MACHINE(spapr);
> >       SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> > -    uint8_t rng_seed[32];
> >       int chosen;
> >  =20
> >       _FDT(chosen =3D fdt_add_subnode(fdt, 0, "chosen"));
> > @@ -1100,8 +1099,7 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
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
> > @@ -1654,6 +1652,14 @@ static void spapr_machine_reset(MachineState *ma=
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


