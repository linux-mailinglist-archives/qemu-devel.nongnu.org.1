Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4F73AE9C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 04:28:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCWWw-0004dD-E5; Thu, 22 Jun 2023 22:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCWWt-0004cn-Sw
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 22:28:07 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCWWs-0004kV-0B
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 22:28:07 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-440bb9bad3cso19621137.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687487285; x=1690079285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35uo4kRrMJGesN+36Etwg2KHM4u8XT3c+o1rXIgCamA=;
 b=iH1lfFl9lozdLIXLHgEci2YkH1t7ImvF50AtZqsWw6smyCJ8c84S4zkSG0/tqdAfiZ
 ZayXkcv4EnQwcFAthbQ1nQVXhbleFGbUG1xSlrctm8w3S1hAEoap5fATgjB/efoXZIaX
 McHiyNGsGaWCGKtVbD/BjMPUY+B1s4SuT2k0cL8EiWh3pTdZZVOF9GsUU7GuorfV6FsB
 rufW+nVdE5myfD+02778PGC4X5bvvE/dLVyPO8lXKWFIKzHGT7zxpi2xdmhONgCdH0Kp
 BLAi4vSLgs1IWLfirogJmCqCwMfuR2St7aHL1F8Qo7ApB8M4wc4+eKxahieljLt6ci5w
 umhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687487285; x=1690079285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35uo4kRrMJGesN+36Etwg2KHM4u8XT3c+o1rXIgCamA=;
 b=Fn/PU2woMOUR1sPCOKB1G12NAtjMn5P7eur4zH4pJqxU5Pqk7qt3n83g3aCPkKypKY
 jd7aP/VvDi5dO8EPs5qMCuUk6EgGrZlPmHI+4KRkXQ973vKaiFD4oGDNszg/dTIC+HXe
 Rl5/Pi+ceWT1eey3qLlF+6rMuxUsG6PUsm2+LyqAmPQCG8rjpHye+4kIbQgqXhpiipLQ
 tBtcp77k+cOKq2b93mpWCBk9q2/NJlTA7Yz+41PquMUu6kp5zAwZvo17CQNAkbo4jgIs
 ov16+5pnuUZzMsSxAWYungqQpiXOSZwbbQKcninMqf17qRt6d2Gm0hCGSRU9kiCgP6Sf
 hvfw==
X-Gm-Message-State: AC+VfDxNHNQy1iYT0xfeM6KAQZpb4ZpXY7Vt7S12VxC211hpHdJXxv/N
 EYEtGPfvOq31QoWbVUbOZgftLQgxs1BJs/a/G1lLg83RhE0tpg==
X-Google-Smtp-Source: ACHHUZ7Q0ZWakw2Dz1X4V3pS9tvMgKaiNlbCEbS9ZgsJwf7LN/MhJDSEIUxjgjfs/94g7vTIev1ERoyXubb+bOwZK38=
X-Received: by 2002:a1f:5fcf:0:b0:471:9378:9be1 with SMTP id
 t198-20020a1f5fcf000000b0047193789be1mr8017474vkb.5.1687487284869; Thu, 22
 Jun 2023 19:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
 <87jzwoba78.fsf@linaro.org>
In-Reply-To: <87jzwoba78.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Jun 2023 12:27:38 +1000
Message-ID: <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
Subject: Re: How do you represent a host gcc and a cross gcc in lcitool?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Brian Cain <bcain@quicinc.com>,
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, 
 Erik Skultety <eskultet@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, 
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 1, 2023 at 4:58=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
>
> Brian Cain <bcain@quicinc.com> writes:
>
> >> -----Original Message-----
> >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Sent: Wednesday, May 31, 2023 6:24 AM
> >> To: Daniel P.Berrang=C3=A9 <berrange@redhat.com>
> >> Cc: qemu-devel <qemu-devel@nongnu.org>; Michael Tokarev
> >> <mjt@tls.msk.ru>; Erik Skultety <eskultet@redhat.com>; Brian Cain
> >> <bcain@quicinc.com>; Palmer Dabbelt <palmer@dabbelt.com>; Alistair Fra=
ncis
> >> <alistair.francis@wdc.com>; Bin Meng <bin.meng@windriver.com>
> >> Subject: How do you represent a host gcc and a cross gcc in lcitool?
> >>
> >> WARNING: This email originated from outside of Qualcomm. Please be war=
y of
> >> any links or attachments, and do not enable macros.
> >>
> >> Hi,
> >>
> >> While trying to convert the debian-riscv64-cross docker container to a=
n
> >> lcitool based one I ran into a problem building QEMU. The configure st=
ep
> >> fails because despite cross compiling we still need a host compiler to
> >> build the hexagon codegen tooling.
> >
> > I thought we'd fixed this container definition so that we only
> > downloaded the hexagon toolchain instead? Do we really need a host
> > compiler for that container build?
> >
> > Or am I misunderstanding and you're referring to features required to
> > support idef parser? Does "hexagon codegen" refer to hexagon's TCG
> > generation or hexagon code itself (required by tests/tcg)?
>
> I think so:
>
> #
> #  Step 1
> #  We use a C program to create semantics_generated.pyinc
> #
> gen_semantics =3D executable(
>     'gen_semantics',
>     'gen_semantics.c',
>     native: true, build_by_default: false)
>
> semantics_generated =3D custom_target(
>     'semantics_generated.pyinc',
>     output: 'semantics_generated.pyinc',
>     command: [gen_semantics, '@OUTPUT@'],
> )
> hexagon_ss.add(semantics_generated)
>
>
> >
> >> After scratching my head for a while I discovered we did have host GCC=
's
> >> in our cross images despite there being no explicit request for them i=
n
> >> the docker description. It turned out that the gcovr requirement pulle=
d
> >> in lcov which itself had a dependency on gcc. However this is a bug:
> >>
> >>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818
> >>
> >> which has been fixed in bookworm (and of course sid which is the only
> >> way we can get a riscv64 build of QEMU at the moment). Hence my hacky
> >> attempts to get gcc via side effect of another package failed.
> >>
> >> Hence the question in $SUBJECT. I tried to add a mapping to lcitool fo=
r
> >> a pseudo hostgcc package:
> >>
> >> +  hostgcc:
> >> +    default: gcc
> >> +    pkg:
> >> +    MacOS:
> >> +    cross-policy-default: skip
> >>
> >> however this didn't work. Do we need a new mechanism for this or am I
> >> missing a way to do this?
> >>
> >> RiscV guys,
> >>
> >> It's clear that relying on Debian Sid for the QEMU cross build for Ris=
cV
> >> is pretty flakey. Are you guys aware of any other distros that better
> >> support cross compiling to a riscv64 target or is Debian still the bes=
t
> >> bet? Could you be persuaded to build a binary docker image with the
> >> cross compilers and libraries required for a decent cross build as an
> >> alternative?

It's probably not very helpful, but I find Arch based distros to be
the best bet for this.

Are you still looking for a Docker image? I could try and get something wor=
king

Alistair

> >>
> >> Thanks,
> >>
> >> --
> >> Alex Benn=C3=A9e
> >> Virtualisation Tech Lead @ Linaro
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

