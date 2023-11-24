Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708F7F6C33
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:16:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6PT6-0006Fr-S1; Fri, 24 Nov 2023 01:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PT3-0006FY-LG; Fri, 24 Nov 2023 01:15:09 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PSz-0005A6-3e; Fri, 24 Nov 2023 01:15:07 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so1373192b3a.2; 
 Thu, 23 Nov 2023 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700806502; x=1701411302; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hFLkbemPDulVhjBa3h+/mIorYUlMLz1/3rUMv7oQho=;
 b=EYhpdBt+53SQJlxmu8vcZcWKpQObQb4nDuEyD51rgf6YTsAhFXL4euxB+GlWClDwfI
 Oh7eItlJWAPSXX/rami0wlc11jhEdrPVsueh7hqOcbhmxh4/O9Gk+glJt8LcYLDPd+ho
 IEcHJv5eSSNYZCOylPjJ3ULYng6G4/ox9Wg8NauSJdc3kWwOMcLDgCLuYJT6l9uEDBHW
 PYe2W6rW9HMp5MzW53H4pUF9vkSoWRFOKtHTuORUUpbNU77n8fbudJ2p8t+HLBGrZpIY
 mBVrAg7VX8GB1EKIR9x/mCwvXkciwlWy07j7+gA8cAcvvUwvxqBru3PspDP7Cd1CfH7o
 YF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700806502; x=1701411302;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9hFLkbemPDulVhjBa3h+/mIorYUlMLz1/3rUMv7oQho=;
 b=lOIBwquJo0/2qAZro+1MoNeqeswCSCZuAKwwGVttc9kvMQ1PxFX13bOijPdBbBR5q2
 ktEwxtGXWfXHswlxal67hvUGmZZgxRZo7csmrrfhYFParJYrGpefNh3+8cex8G5uI+Kw
 Kv2AbvEX5wP08p+fJprTh1VNZXdmMWrqw6ybK/yNvViRnh3N4gWwk1KstejuCFCjXX6q
 AHexTxNOAwI+3itfL+5i87suL49BfAeDyHUjZgibfmoz148uhFYqsnzApQzBJEjqXkFg
 cTw5gBw1CHqplzfGfOdte1tEDW5pzqm2C1r4UttXzvD+ygLzwuJEGNvXzcpIy4cUfj/Z
 PShw==
X-Gm-Message-State: AOJu0Ywuk6TYgMu95HNvV6aDfjv21U+BjtXuuHujnzt9mTyJRYjGnXRL
 27JAlzSRthybrAnq8qNu5uw=
X-Google-Smtp-Source: AGHT+IG24LnOyYJzwKulYjmKtnXHit74DCUqqMzpe2SVvESVj7OrbgqYxvADJYn1m2IkS+HEdxO6Mg==
X-Received: by 2002:a05:6a00:a0c:b0:6bd:f224:c79e with SMTP id
 p12-20020a056a000a0c00b006bdf224c79emr1573782pfh.11.1700806502286; 
 Thu, 23 Nov 2023 22:15:02 -0800 (PST)
Received: from localhost ([1.145.239.154]) by smtp.gmail.com with ESMTPSA id
 b12-20020aa7810c000000b00690c52267easm2131534pfi.40.2023.11.23.22.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 22:15:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 16:14:44 +1000
Message-Id: <CX6TKW8HRF3K.32M41SQ0H9Y5F@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/7] pnv/chiptod: Add POWER9/10 chiptod model
X-Mailer: aerc 0.15.2
References: <20231123103018.172383-1-npiggin@gmail.com>
 <20231123103018.172383-5-npiggin@gmail.com>
 <bb365d13-e73c-4e84-81b0-b55034f2ce87@kaod.org>
In-Reply-To: <bb365d13-e73c-4e84-81b0-b55034f2ce87@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

On Fri Nov 24, 2023 at 3:49 AM AEST, C=C3=A9dric Le Goater wrote:
> On 11/23/23 11:30, Nicholas Piggin wrote:
> > The ChipTOD (for Time-Of-Day) is a pervasive facility that keeps the
> > clocks on multiple chips consistent which can keep TOD (time-of-day),
> > synchronise it across multiple chips, and can move that TOD to or from
> > the core timebase units.
>
> May be rephrase a bit the sentence above. I find it difficult to read.
>
> > This driver implements basic emulation of chiptod registers sufficient
>
> it's a model.

+1

> > +static void chiptod_power9_send_remotes(PnvChipTOD *chiptod)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
>
> Using qdev_get_machine() in a model is always a bit annoying. There is
> work in progress currently to have a single QEMU binary for all arches
> and when done, the "machine" would encompass something bigger including
> the OCC, BMC, etc.

We need a way to get from one chip to another, fundamentally. I
didn't see a better way, I suppose we could build a PnvHost container
that includes all PnvChips or something.

> Do we know how XSCOM propagates the new state to the chiptop on other
> chips ? is it some sort of broadcast on the bus ? Could we model it ?
> I am only asking, not to be done now.

It's a bit hard to work out. Real ChipTOD is vastly more complicated
than this model :P

It seems that ChipTOD can master PIB scoms to other chips, but also
this TTYPE transactions look like they have a command that goes
on the powerbus via ADU.


> > +static void chiptod_power10_invalidate_remotes(PnvChipTOD *chiptod)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> > +    int i;
> > +
> > +    for (i =3D 0; i < pnv->num_chips; i++) {
> > +        Pnv10Chip *chip10 =3D PNV10_CHIP(pnv->chips[i]);
> > +        if (&chip10->chiptod !=3D chiptod) {
> > +            chip10->chiptod.tod_state =3D tod_not_set;
> > +        }
> > +    }
> > +}
>
> Could we avoid 4 routines doing the same thing and introduce :
>
>    chiptod_power*_set_tod_state(PnvChipTOD *chiptod, enum tod_state new)
>
> ?
>
> We could even introcude a PnvChipClass::get_chiptod handler. Might be
> overkill though.

Good idea...

> > +    case TOD_TX_TTYPE_5_REG:
> > +        if (is_power9) {
> > +            chiptod_power9_invalidate_remotes(chiptod);
> > +        } else {
> > +            chiptod_power10_invalidate_remotes(chiptod);
> > +        }
>
> With PnvChipTODClass::invalidate_remotes and PnvChipTODClass::send_remote=
s
> handlers, or ::set_state, this routine would not need a 'is_power9' param=
eter
> and the model would not need 2 different xscom_ops. Can it be done ?

... yes! ChipTODClass seems to be a good place for it.

> > +static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvChipTOD *chiptod =3D PNV_CHIPTOD(dev);
> > +    PnvChipTODClass *pctc =3D PNV_CHIPTOD_GET_CLASS(chiptod);
> > +
> > +    if (chiptod->primary) {
> > +        chiptod->pss_mss_ctrl_reg |=3D PPC_BIT(1); /* TOD is master */
> > +    }
> > +
> > +    /* Drawer is master (we do not simulate multi-drawer) */
> > +    chiptod->pss_mss_ctrl_reg |=3D PPC_BIT(2);
> > +    chiptod->tod_state =3D tod_running;
>
> Shouldn't these initial values be set in a reset handler ?

Yes, and actually reset state is tod_error so fixed that too.

Thanks,
Nick

