Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E8745424
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 05:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGADV-0003fd-5f; Sun, 02 Jul 2023 23:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGADS-0003f6-JA
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 23:27:06 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGADO-0004VQ-Iy
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 23:27:06 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-44357f34e2dso1224581137.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688354821; x=1690946821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ha3ejA+guA1pjse2uCjDPe9+go6mdz7ajtsgMm4Ade4=;
 b=HOYbj4XU9He+kK19tIe7kotFmaddAwPjJxCfPTCMXaj+lTTfQaQBEGI5WYtc7+1qtn
 oxDgLp4QnhSevPIA5EXSvrEqARMSDlh/27Jeb9GPzyCENSK0Rk8pIlX3sY/4+2fhW8F3
 5a/nFP3qXyScJMYO1tXqphnqFrN0XgmyRtihHDKS6eobvK19ECC7M4z33pgCgLgCx2UF
 79+I257hXnQHW52PomBoM0yWfqsxtiB7AoE1CbvGm9JGAxvz7om2zz+4UtXThFy9lkF0
 YLdBE+DnpfOgwESHRi4AqgiHZOqS0ejVKv8f7p4H8tiAx3AyKl8+9v3funoAdgdjyY8C
 32Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688354821; x=1690946821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ha3ejA+guA1pjse2uCjDPe9+go6mdz7ajtsgMm4Ade4=;
 b=DAnHttjfEKrf5jOlSItiw79w7ZWSEoG6fz2F5gFbSE8rAh+WBjL/yHM34C/w3seWcb
 kT8flPYRrN7QRHkdjpbId0o66MT+M79qSxN8GnRBFIYj0shT5vYCTZAYQpnfQ9tKCfQB
 QeeBXRBVTtYeVeBmBvEJ6qMg0H8eImfzjvw/x5Go+ow1MlRNoulDLRwyjKV5nIk6iHRP
 vjjYJR8XedFT8ZwTjd7mzoMCy+WY/pwPoB0YupKM1ZD2irg49sZW9oft0hmWXP4nOVUu
 CAG0+7QUUp/KZ9KjFUsi4lMggwfvYBYxfsjdZUKy5iyixKbVd4PsIiQdNk9aY3mjcUbi
 +bnA==
X-Gm-Message-State: ABy/qLbnP8Tnmf98P2g9dLO9qpW0dv6j9T3vTfi6BUFuz3kQlgLGKfgq
 UcfT+YsuFQ000jImFFhQagS0TowzX0u1bd1iIYFXpcKfBQQvEg==
X-Google-Smtp-Source: APBJJlFicZrl1UvOPSriQtC6KtB2tqjJDhbRk/8RNprHBYtT9embyxZH2FvoM6pLrALukLN2RZJz8O23rZ2+Hh7QOiA=
X-Received: by 2002:a67:fb14:0:b0:443:66b9:b8e4 with SMTP id
 d20-20020a67fb14000000b0044366b9b8e4mr4170031vsr.34.1688354821097; Sun, 02
 Jul 2023 20:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
 <87jzwoba78.fsf@linaro.org>
 <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
 <87fs6ifp5e.fsf@linaro.org>
In-Reply-To: <87fs6ifp5e.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 13:26:35 +1000
Message-ID: <CAKmqyKNHvP4MJOPP8i-Lj5Bu3-DNi00SngEe5X+c8_vA0EGLaQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Fri, Jun 23, 2023 at 8:29=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > On Thu, Jun 1, 2023 at 4:58=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
> >>
> >>
> >> Brian Cain <bcain@quicinc.com> writes:
> >>
> >> >> -----Original Message-----
> >> >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >> Sent: Wednesday, May 31, 2023 6:24 AM
> >> >> To: Daniel P.Berrang=C3=A9 <berrange@redhat.com>
> >> >> Cc: qemu-devel <qemu-devel@nongnu.org>; Michael Tokarev
> >> >> <mjt@tls.msk.ru>; Erik Skultety <eskultet@redhat.com>; Brian Cain
> >> >> <bcain@quicinc.com>; Palmer Dabbelt <palmer@dabbelt.com>; Alistair =
Francis
> >> >> <alistair.francis@wdc.com>; Bin Meng <bin.meng@windriver.com>
> >> >> Subject: How do you represent a host gcc and a cross gcc in lcitool=
?
> >> >>
> >> >> WARNING: This email originated from outside of Qualcomm. Please be =
wary of
> >> >> any links or attachments, and do not enable macros.
> >> >>
> >> >> Hi,
> >> >>
> >> >> While trying to convert the debian-riscv64-cross docker container t=
o an
> >> >> lcitool based one I ran into a problem building QEMU. The configure=
 step
> >> >> fails because despite cross compiling we still need a host compiler=
 to
> >> >> build the hexagon codegen tooling.
> >> >
> >> > I thought we'd fixed this container definition so that we only
> >> > downloaded the hexagon toolchain instead? Do we really need a host
> >> > compiler for that container build?
> >> >
> >> > Or am I misunderstanding and you're referring to features required t=
o
> >> > support idef parser? Does "hexagon codegen" refer to hexagon's TCG
> >> > generation or hexagon code itself (required by tests/tcg)?
> >>
> >> I think so:
> >>
> >> #
> >> #  Step 1
> >> #  We use a C program to create semantics_generated.pyinc
> >> #
> >> gen_semantics =3D executable(
> >>     'gen_semantics',
> >>     'gen_semantics.c',
> >>     native: true, build_by_default: false)
> >>
> >> semantics_generated =3D custom_target(
> >>     'semantics_generated.pyinc',
> >>     output: 'semantics_generated.pyinc',
> >>     command: [gen_semantics, '@OUTPUT@'],
> >> )
> >> hexagon_ss.add(semantics_generated)
> >>
> >>
> >> >
> >> >> After scratching my head for a while I discovered we did have host =
GCC's
> >> >> in our cross images despite there being no explicit request for the=
m in
> >> >> the docker description. It turned out that the gcovr requirement pu=
lled
> >> >> in lcov which itself had a dependency on gcc. However this is a bug=
:
> >> >>
> >> >>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818
> >> >>
> >> >> which has been fixed in bookworm (and of course sid which is the on=
ly
> >> >> way we can get a riscv64 build of QEMU at the moment). Hence my hac=
ky
> >> >> attempts to get gcc via side effect of another package failed.
> >> >>
> >> >> Hence the question in $SUBJECT. I tried to add a mapping to lcitool=
 for
> >> >> a pseudo hostgcc package:
> >> >>
> >> >> +  hostgcc:
> >> >> +    default: gcc
> >> >> +    pkg:
> >> >> +    MacOS:
> >> >> +    cross-policy-default: skip
> >> >>
> >> >> however this didn't work. Do we need a new mechanism for this or am=
 I
> >> >> missing a way to do this?
> >> >>
> >> >> RiscV guys,
> >> >>
> >> >> It's clear that relying on Debian Sid for the QEMU cross build for =
RiscV
> >> >> is pretty flakey. Are you guys aware of any other distros that bett=
er
> >> >> support cross compiling to a riscv64 target or is Debian still the =
best
> >> >> bet? Could you be persuaded to build a binary docker image with the
> >> >> cross compilers and libraries required for a decent cross build as =
an
> >> >> alternative?
> >
> > It's probably not very helpful, but I find Arch based distros to be
> > the best bet for this.
>
> I've never tried arch under docker, isn't it just as much of a moving
> target?

I haven't really tried Arch under Docker. I agree that it is a fast
moving target. I guess it's up for debate if it's too much churn or
not

Would a working Arch image be helpful with lcitool?

>
> > Are you still looking for a Docker image? I could try and get
> > something working
>
> Yes, although I have converted debian-riscv64-cross to lcitool and had
> it working sid has since broken. Are there any pushes to have riscv as a
> first class distro citizen soon or is stuff still in the early ports
> stage?

There are pushes. I thought RISC-V was progressing towards first class
distro support, but it seems to have stalled recently.

I actually thought you could cross compile with Debian bullseye, yet
alone bookworm, has someone tried? Otherwise I can give it a crack

Alistair

>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

