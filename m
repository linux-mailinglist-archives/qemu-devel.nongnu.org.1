Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A17CDC7E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt685-00054r-6H; Wed, 18 Oct 2023 08:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qt683-00050p-LN; Wed, 18 Oct 2023 08:58:27 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qt680-0006N3-PJ; Wed, 18 Oct 2023 08:58:26 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27d17f5457fso5316340a91.0; 
 Wed, 18 Oct 2023 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697633903; x=1698238703; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quvO6CR9tMYYF4zkNlcpUtBC1CzgPuF/b+7fsGw5NwU=;
 b=IpgYPpRKFrdWUfIz9q0n8z9SMm8Q5xQ+YAxfLJPE4lJzY8zJNZ85k1zf/zdGPJmJAg
 bnaBO72etziyztdTu2GRyRnXJ7Ewmexi5yylbgGUZAtnW6SzVJEbIRh9tYM+2ejqqlG4
 XYxeNBVQrA/OhNJOsSaYS/JWSvnZenRm9QBoMh0GGN3QrsRTxT8HyxevfoNN3m/LEwN6
 lUH3VZ5T0LG1g9z7nxCkDrtVRyq83j9IdMvahVCcj9FKfAG4bc2YG9QTIv0ffLGMi8GH
 AhxG2BtskSvUV4ZopDSWIqhiytILoRopcgF+YqPidZptPct1GG6CP+aM88AT5FAcIfIN
 LTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697633903; x=1698238703;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=quvO6CR9tMYYF4zkNlcpUtBC1CzgPuF/b+7fsGw5NwU=;
 b=CAWzeeJyhE7LkrgL7v/Xt0xUQ43wDvas1XNiwsuJhkEPpvTZg30rWgCVdTcKZ2ufeD
 BLImJdG4nTgwyTYY9qTX+Yr6dCk7fdOm9Pu8T1scFEGCu9K+zm8xS8yv1zwj/wJ20Li6
 0l7Unto+hZ1G/BG09JrqYL6PbQPP66JIl6ViTd8aHk8COnsMzS4dLyRKYyEzaW4DLk7B
 Zl3i0rGOLKaJhCCdNDl5Uk/XQiA7JBrQmmcYSTbNQPgffMKX0r2Fl/Wq+2D0Ds7SuaZ7
 wWq+vdocHQz2C68h3c7fanDcSU/9Zo3m1yzmU+78XVnqbqTogzNs1Kg9b0IA3TOo6QN4
 GRYw==
X-Gm-Message-State: AOJu0Yx4w6Q2AjSqfzzCBoFIsGADnu869byJvtaskz1PuPmzIsC3TzxN
 0IUvgUegk5Ly4DLGtknlShE=
X-Google-Smtp-Source: AGHT+IGMsIdXEsHnth7jPX87UPdhZczDGAHQnn4tINttjqOa4ruX3Wy0fzhYfvSGO2IdNW8CUmZWRQ==
X-Received: by 2002:a17:90b:4acf:b0:27d:2601:bc92 with SMTP id
 mh15-20020a17090b4acf00b0027d2601bc92mr7052009pjb.11.1697633902158; 
 Wed, 18 Oct 2023 05:58:22 -0700 (PDT)
Received: from localhost (61-68-209-245.tpgi.com.au. [61.68.209.245])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a17090a4b0f00b0027654d389casm1244713pjh.54.2023.10.18.05.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 05:58:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Oct 2023 22:58:16 +1000
Message-Id: <CWBKZPU8DSYO.GHTQKPP8DSQ2@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH 4/4] hw/ppc/spapr: Rename 'softmmu' -> 'tcg'
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231002143855.50978-1-philmd@linaro.org>
 <20231002143855.50978-5-philmd@linaro.org> <ZRt3cnl0fH0sBupE@zatzit>
In-Reply-To: <ZRt3cnl0fH0sBupE@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Tue Oct 3, 2023 at 12:07 PM AEST, David Gibson wrote:
> On Mon, Oct 02, 2023 at 04:38:54PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > spapr_softmmu.c isn't related to having a soft MMU, but having
> > the TCG accelerator. Rename it using the 'tcg' suffix.
>
> That's not really accurate.  The functions in there absolutely are
> about the emulated MMU.  They're not needed for KVM, because KVM has
> its own MMU emulation, but they're not strictly speaking related to TCG.

Not sure what to do with these.

The spapr facilities names AFAIK don't really differentiate between
when they are supplied for KVM vs TCG, so we could use spapr_mmu.c
or spapr_hpt.c. Or leave as softmmu? Anyone have preferences? I like
hpt.

softmmu_resize_hpt_* could go to spapr_resize_hpt_*

Thanks,
Nick

>
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/ppc/{spapr_softmmu.c =3D> spapr_tcg.c} | 0
> >  hw/ppc/meson.build                      | 2 +-
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >  rename hw/ppc/{spapr_softmmu.c =3D> spapr_tcg.c} (100%)
> >=20
> > diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_tcg.c
> > similarity index 100%
> > rename from hw/ppc/spapr_softmmu.c
> > rename to hw/ppc/spapr_tcg.c
> > diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> > index 7c2c52434a..281100a58d 100644
> > --- a/hw/ppc/meson.build
> > +++ b/hw/ppc/meson.build
> > @@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
> >    'pef.c',
> >  ))
> >  ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
> > -  'spapr_softmmu.c',
> > +  'spapr_tcg.c',
> >  ))
> >  ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
> >  ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(


