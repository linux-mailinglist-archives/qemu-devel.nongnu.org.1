Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2072F426
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9J5P-0003eU-1t; Wed, 14 Jun 2023 01:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9J5L-0003dj-S3; Wed, 14 Jun 2023 01:30:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9J5J-0003oZ-Ma; Wed, 14 Jun 2023 01:30:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b5018cb4dcso663335ad.2; 
 Tue, 13 Jun 2023 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686720619; x=1689312619;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCwZAi+ZsE6t3/Vn3q7kptmpYCsczogIvfUo3u0/0XM=;
 b=sdUFZmB6tHY5ImONj83vPrn9VlbYO1cpykXLugzvHmaOzHj+I0zRDPn1z2IqFFClaw
 py1S7lVolkaEjhx0R8GBL+AF9ssGIOWbsUEhobb0SqqhQlLngVOMmYNKBsYdXEF96kxK
 mEZMwkZyve7B9O5K/7J2dRGeOE/V9cbQjGx1iozGdfxRrfeZtwH8C+n1ZbEWPSHo4vJU
 YlriC1QUZi2NeMps0deW/VTcxj7XxFXEdV7IZ0+zHa4Bjj/rNypaYujLGvLZMavw8foG
 ebY1D1ZxtLIIaqDIJqQk7byJQAqJwkXErnMHGaTOchGAgAj7sWn0yZDXPwGimxzi7tRU
 ErOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686720619; x=1689312619;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XCwZAi+ZsE6t3/Vn3q7kptmpYCsczogIvfUo3u0/0XM=;
 b=GtJpZYODeRYQpvJv4KfSeUERFGmjkJPs/LrCLM9hJAZ96AjEe43e1LgFtkWlDWhkZ2
 icGEmufCUPEOo3c7xnREsydrDf42Ei1U4kEccHRmAGS2dL82qNXuDX8UPrj7bwn6XYkl
 kUh9squ6lMweKd2SXQXRNH2IFmBrr2jfJ0ojglZNk5hWeVbun58K8qro62CL0+haQxae
 vs0jE2g4BlIxY/CYiF9ImuIlmXm5/x6E6zaZowH1Mlhc/A7yom1hL0JDZEJ2At2G1hNx
 7lrdXYMJVk8iZkZFLNZ7g0A8crmjMf8t9ekuMn/NDtHQc0Vxz8Rt000yQb6jcjrFzbZ/
 SyAA==
X-Gm-Message-State: AC+VfDz6NT+F+zsM7gi0Ksfy6Zx6JtUv+dE8ikoL0mMFXni1WlBJCE1g
 qydCuxGW9+/SLsX+9Xs7RkwHZfMSSR4=
X-Google-Smtp-Source: ACHHUZ5eO3/GxNTjwKXOzb+eLwO6cJ7t9kjx5DtMXVbmzbxRximsuDiNhuG19M5n0vJQ7m8lwGmIWg==
X-Received: by 2002:a17:90a:694c:b0:259:3fe2:e78f with SMTP id
 j12-20020a17090a694c00b002593fe2e78fmr591029pjm.4.1686720619441; 
 Tue, 13 Jun 2023 22:30:19 -0700 (PDT)
Received: from localhost (220-244-204-78.tpgi.com.au. [220.244.204.78])
 by smtp.gmail.com with ESMTPSA id
 28-20020a17090a1a1c00b0025c09577ce1sm3032261pjk.7.2023.06.13.22.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:30:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 15:30:14 +1000
Message-Id: <CTC4K105L91Y.YIIZVUGP786T@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Frederic Barrat" <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH 1/4] pnv/chiptod: Add POWER9/10 chiptod model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230603233612.125879-1-npiggin@gmail.com>
 <20230603233612.125879-2-npiggin@gmail.com>
 <69c9cd27-87b5-3864-1ae2-a6b01a26086e@kaod.org>
In-Reply-To: <69c9cd27-87b5-3864-1ae2-a6b01a26086e@kaod.org>
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

On Tue Jun 6, 2023 at 12:57 AM AEST, C=C3=A9dric Le Goater wrote:
> On 6/4/23 01:36, Nicholas Piggin wrote:

> > diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> > new file mode 100644
> > index 0000000000..04ef703e0f
> > --- /dev/null
> > +++ b/hw/ppc/pnv_chiptod.c
> > @@ -0,0 +1,488 @@
> > +/*
> > + * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
> > + *
> > + * Copyright (c) 2022-2023, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
>
> You can simplify the header with
>
>   * SPDX-License-Identifier: GPL-2.0-or-later

Sure.

> > +
> > +static void chiptod_power9_send_remotes(PnvChipTOD *chiptod)
>
> Adding a class handler could be an alternative implementation.

Might be a good idea, I'll see how it looks.

> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> > +    int i;
> > +
> > +    for (i =3D 0; i < pnv->num_chips; i++) {
>
> There are a few other models (XIVE, XIVE2) which loop on the chips,
> is it time to introduce a pnv_foreach_chip(fn, data) routine ?
>
>
> > +        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
> > +        if (&chip9->chiptod !=3D chiptod) {
> > +            chip9->chiptod.tod_state =3D tod_running;
> > +        }
> > +    }
> > +}

[snip]

> > +    case TOD_TX_TTYPE_CTRL_REG:
> > +        if (val & PPC_BIT(35)) { /* SCOM addressing */
> > +            uint32_t addr =3D val >> 32;
> > +            uint32_t reg =3D addr & 0xfff;
> > +            PnvCore *pc;
> > +
> > +            if (reg !=3D PC_TOD) {
> > +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addr=
essing: "
> > +                              "unimplemented slave register 0x%" PRIx3=
2 "\n",
> > +                              reg);
> > +                return;
> > +            }
> > +
> > +            /*
> > +             * This may not deal with P10 big-core addressing at the m=
oment.
> > +             * The big-core code in skiboot syncs small cores, but it =
targets
> > +             * the even PIR (first small-core) when syncing second sma=
ll-core.
> > +             */
> > +            pc =3D pnv_get_vcpu_by_xscom_base(chiptod->chip, addr & ~0=
xfff);
>
> hmm, couldn't we map xscom subregions, one for each thread instead ?

I'm not sure what you mean. This scom-addressing uses the xscom
address of the core's PC unit (where its time facilities are) to
point nest chiptod transfers to cores.

>
> > +            if (pc) {
> > +                /*
> > +                 * If TCG implements SMT, TFMR is a per-core SPR and s=
hould
> > +                 * be updated such that it is reflected in all threads=
.
> > +                 * Same for TB if the chiptod model ever actually adju=
sted it.
> > +                 */
> > +                chiptod->slave_cpu_target =3D pc->threads[0];
>
> ah ! SMT is implemented :) The xscom subregions would help to get the
> CPU pointer.

I think I may be mistaken at least in the "get_vcpu" part. I think
it should be get core, I don't know if chiptod is capable of addressing
threads individually.

I could test it with SMT patches and see what skiboot does.

> > +static int pnv_chiptod_dt_xscom(PnvXScomInterface *dev, void *fdt,
> > +                                int xscom_offset,
> > +                                const char compat[], size_t compat_siz=
e)
> > +{
> > +    PnvChipTOD *chiptod =3D PNV_CHIPTOD(dev);
> > +    g_autofree char *name =3D NULL;
> > +    int offset;
> > +    uint32_t lpc_pcba =3D PNV9_XSCOM_CHIPTOD_BASE;
>
> lpc ?

Shh don't tell anybody I mostly code via copy and paste :P

[snip]

> > +static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
> > +{
> > +    static bool got_primary =3D false;
> > +    static bool got_secondary =3D false;
> > +
> > +    PnvChipTOD *chiptod =3D PNV_CHIPTOD(dev);
> > +    PnvChipTODClass *pctc =3D PNV_CHIPTOD_GET_CLASS(chiptod);
> > +
> > +    if (!got_primary) {
> > +        got_primary =3D true;
> > +        chiptod->primary =3D true;
> > +        chiptod->pss_mss_ctrl_reg |=3D PPC_BIT(1); /* TOD is master */
> > +    } else if (!got_secondary) {
> > +        got_secondary =3D true;
> > +        chiptod->secondary =3D true;
> > +    }
>
> It would be cleaner to introduce "primary" and "secondary" properties
> defined by the model realizing the PnvChipTOD objects.

Hum. There's a few hard-coded primaries on chip_id =3D=3D 0 already
in the tree. I don't know how closely related they are, chiptod
can set other chips as primary AFAIK but maybe it just makes
sense to make primary a chip property.

I might dig a bit more into what we (and other IBM firmware) want
to test or expect with these primaries. Maybe another pass to
tidy all that up can be done.

[...]

> > +#ifndef PPC_PNV_CHIPTOD_H
> > +#define PPC_PNV_CHIPTOD_H
> > +
> > +#include "qom/object.h"
> > +
> > +#define TYPE_PNV_CHIPTOD "pnv-chiptod"
> > +OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
> > +#define TYPE_PNV9_CHIPTOD TYPE_PNV_CHIPTOD "-POWER9"
> > +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
> > +#define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
> > +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD=
)
> > +
> > +enum tod_state {
>
> PnvChipTODState would be better naming.

Agree.

Thanks,
Nick

