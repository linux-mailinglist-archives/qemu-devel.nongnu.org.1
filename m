Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA37838058
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 02:58:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS63E-0002Ww-Jy; Mon, 22 Jan 2024 20:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS63C-0002Wb-SC; Mon, 22 Jan 2024 20:58:06 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS63B-000442-8E; Mon, 22 Jan 2024 20:58:06 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7354ba334so18676325ad.1; 
 Mon, 22 Jan 2024 17:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705975083; x=1706579883; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geVK+nggt06cxRQ0sYTAc0S60cCBzq7960TqgtF33dQ=;
 b=PAKpQ/BHsVJc6gcpsDG9vDz0hV0t7/M3OqWyaqBtu6quji6+pgmmfhfM0gnd92TRCU
 sIII6ka2/c7lBL1OS6Zq3uLQyDWJR6fyBM8VX+7MNMKRD7TSYSEODEzosD0fUjrMMfo0
 J3BanneDkaj0bzA5OtojAPGUXbU5bBWXsCtkBCf3OHz2u7fU8Lfz0ZB/dLOgUfnW2wQq
 2I9kQD/27c1lKgytdgO5QzmuJvk8dI7XjHdEvIx33e0jEMiWgc9d9KjdNojqaL3HoQAI
 nUJusVqjogAqU+kDoz1fhzWg/992CB9YXLr3EyZXlqMQs0GpnGO3BKDGEd1+E/429E4/
 1x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705975083; x=1706579883;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=geVK+nggt06cxRQ0sYTAc0S60cCBzq7960TqgtF33dQ=;
 b=VFUCJrW/d2HzC+aNGOCjAhk5Q4DVzI1Ez/g/MBKCTZ3ibJOouPKEpGNSAsd6fB8gnd
 X53n125mxZBlsFJ2123LhPcaV/QvW9WbMJ30l8w7SCvLtWauzBrjpgxLu5zGS+SQml4h
 8hypI/6JFEsF+VR05do+z4FeMYQbwa3v7jTLt7/1/GoirEARZyfxc3bX3H/YMU6pOmql
 alVGx/Ng4zC9qOvukmPP6yi5M39/StoqtBANhrq5NGmPLg0TqaGBWthuvbzr/HdA+ZnJ
 54a2IeNgmbT6QZ3EaapgiBEyxoyU6sbSbrWEWQFN3ONlEkbGHhbDmJugdlefHcveNA2u
 4nUw==
X-Gm-Message-State: AOJu0YztoFPFIXh2dwvFd6tccgU99J3XZIC2XIK3snKd6LCXukLTcdBe
 tK8GK4PJPHPgvQVYsEZMylRGPw8O6gfqNvfyWNn9DeAdFu1m7z7E
X-Google-Smtp-Source: AGHT+IHDh95E74QUmQD/fnLQR/KgozDoITotI5fU5m5XXPeYgSC0cuSj9C1sdOdhX6B0nYmtvDC1BQ==
X-Received: by 2002:a17:902:ea01:b0:1d4:c445:c705 with SMTP id
 s1-20020a170902ea0100b001d4c445c705mr7043192plg.26.1705975083435; 
 Mon, 22 Jan 2024 17:58:03 -0800 (PST)
Received: from localhost (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f7d100b001d71ae81cbbsm6308410plw.190.2024.01.22.17.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 17:58:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 11:57:56 +1000
Message-Id: <CYLPOZ0VDE7U.40VIK25R65PQ@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: <qemu-ppc@nongnu.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/8] ppc/spapr|pnv: Remove SAO from pa-features when
 running MTTCG
X-Mailer: aerc 0.15.2
References: <20240118140942.164319-1-npiggin@gmail.com>
 <20240118140942.164319-3-npiggin@gmail.com> <ZanA-usH_Ec0uqie@zatzit>
In-Reply-To: <ZanA-usH_Ec0uqie@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Fri Jan 19, 2024 at 10:23 AM AEST, David Gibson wrote:
> On Fri, Jan 19, 2024 at 12:09:36AM +1000, Nicholas Piggin wrote:
> > SAO is a page table attribute that strengthens the memory ordering of
> > accesses. QEMU with MTTCG does not implement this, so clear it in
> > ibm,pa-features. There is a complication with spapr migration that is
> > addressed with comments, it is not a new problem here.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/pnv.c   |  5 +++++
> >  hw/ppc/spapr.c | 15 +++++++++++++++
> >  2 files changed, 20 insertions(+)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index b949398689..4969fbdb05 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -158,6 +158,11 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc=
, void *fdt)
> >      char *nodename;
> >      int cpus_offset =3D get_cpus_node(fdt);
> > =20
> > +    if (qemu_tcg_mttcg_enabled()) {
> > +        /* SSO (SAO) ordering is not supported under MTTCG. */
> > +        pa_features[4 + 2] &=3D ~0x80;
> > +    }
> > +
> >      nodename =3D g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
> >      offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
> >      _FDT(offset);
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 021b1a00e1..1c79d5670d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -284,6 +284,21 @@ static void spapr_dt_pa_features(SpaprMachineState=
 *spapr,
> >          return;
> >      }
> > =20
> > +    if (qemu_tcg_mttcg_enabled()) {
> > +        /*
> > +         * SSO (SAO) ordering is not supported under MTTCG, so disable=
 it.
> > +         * There is no cap for this, so there is a migration bug here.
> > +         * However don't disable it entirely, to allow it to be used u=
nder
> > +         * KVM. This is a minor concern because:
> > +         * - SAO is an obscure an rarely (if ever) used feature.
> > +         * - SAO is removed from POWER10 / v3.1, so there is already a
> > +         *   migration problem today.
> > +         * - Linux does not test this pa-features bit today anyway, so=
 it's
> > +         *   academic.
> > +         */
> > +        pa_features[4 + 2] &=3D ~0x80;
>
> Oof.. I see the reasoning but modifying guest visible parameters based
> on host capabilities without a cap really worries me nonetheless.

Yeah :( It's not a new problem, but changing it based on host
does make it look uglier I guess.

Other option could be to just disable it always. I don't mind
but someone did mention experimenting with it when I asked
about removing support from Linux. They could still test with
bare metal, and if ever started actually being used then we
could add a cap for it.

Thanks,
Nick

