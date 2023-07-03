Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F7745633
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGE4T-0002Vt-2j; Mon, 03 Jul 2023 03:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGE4Q-0002VR-Ea
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:34:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGE4N-0005Am-PK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:34:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143798f542so678422f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688369635; x=1690961635;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6SxwcF9nmDbtlXiXRcbpwrNKuD5dIu4EEVbCU3sHh8=;
 b=XC1E/nVEBd9cxfMzA+KBvpLj3KHO8GhjlsS1bNpZp07EvjrnbBwcTJMziitfe+0v14
 N7HwP6v0oJLpJZ/l+8K1TBLJ7M6ryoxiSlZL9SeDvp2SnWm7vZlPhFGeoHx6OU31R6s7
 S0NW6XctFyIayvA/GzC5nfSRpZmxhXR24XytHYNi3zbC0yD1dqhXEnr43ZEwDdRtgQAO
 tSZcW2J6zmZl2Aqkhnj4iORv6OPbovwoBdj3bCVimaAjQqA9nl+Sq1fuM4xX0XXeCt+p
 ytzl88G1QDhQTLlCy1b9rCjefp317nIm47dELNBBwvPR5l8oEI/0t1p9H/aY90q0Wkxt
 popQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688369635; x=1690961635;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D6SxwcF9nmDbtlXiXRcbpwrNKuD5dIu4EEVbCU3sHh8=;
 b=G5dTV137lMIdsJa2I1rUoZPYZyNjfNzFUm+WUzDFZFUk8W2DyLbxHpVWeUGzgP6ddp
 A1ptno0sH6Q3jVVcfY0yCCvRqELI8tLlxtoEMoyxR+aYhgiLlHliaYoV4fHXRa8kB+9B
 9b1HdSM6f8+yAKti6YwA9VDnD/w109u7X/7WZv8fTVVqowoBjwsLIX9woehzvIeUvD37
 HHhEa4oW/jmAab2kNTTWMQ3eh0KDiQltQ3lMwbSlSJNsLbeUcu2FB3iufebfuweCAqha
 ktImsyYAefPrcgyn/42y6diW6IvKUq/WptMetceTptIUP8ASikL1mljobThGGvDNOHhc
 f29g==
X-Gm-Message-State: ABy/qLa411IlYgoHk1d8ZUThV1YRRWiQagI5g1b9IjtM2pM7V5gLx3xz
 k7JAZi5AWKAmKVBSj9RM06yBRQ==
X-Google-Smtp-Source: APBJJlFYpCu9hqKn5Et4BuABFYdeHiDqqnWSjx7iIYI28yWV4Z5VU9OsQqiKdaa+lMZVU0RzQ/yj9w==
X-Received: by 2002:a5d:554a:0:b0:314:14ea:e2de with SMTP id
 g10-20020a5d554a000000b0031414eae2demr7855163wrw.0.1688369635486; 
 Mon, 03 Jul 2023 00:33:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056000194a00b0031134bcdacdsm24873234wry.42.2023.07.03.00.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 00:33:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B2771FFBB;
 Mon,  3 Jul 2023 08:33:54 +0100 (BST)
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
 <87jzwoba78.fsf@linaro.org>
 <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
 <87fs6ifp5e.fsf@linaro.org>
 <CAKmqyKNHvP4MJOPP8i-Lj5Bu3-DNi00SngEe5X+c8_vA0EGLaQ@mail.gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>, =?utf-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Erik Skultety <eskultet@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>
Subject: Re: How do you represent a host gcc and a cross gcc in lcitool?
Date: Mon, 03 Jul 2023 08:31:58 +0100
In-reply-to: <CAKmqyKNHvP4MJOPP8i-Lj5Bu3-DNi00SngEe5X+c8_vA0EGLaQ@mail.gmail.com>
Message-ID: <87h6qlphy5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Alistair Francis <alistair23@gmail.com> writes:

> On Fri, Jun 23, 2023 at 8:29=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>>
>> Alistair Francis <alistair23@gmail.com> writes:
>>
>> > On Thu, Jun 1, 2023 at 4:58=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
>> >>
>> >>
>> >> Brian Cain <bcain@quicinc.com> writes:
>> >>
>> >> >> -----Original Message-----
>> >> >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> >> Sent: Wednesday, May 31, 2023 6:24 AM
>> >> >> To: Daniel P.Berrang=C3=A9 <berrange@redhat.com>
>> >> >> Cc: qemu-devel <qemu-devel@nongnu.org>; Michael Tokarev
>> >> >> <mjt@tls.msk.ru>; Erik Skultety <eskultet@redhat.com>; Brian Cain
>> >> >> <bcain@quicinc.com>; Palmer Dabbelt <palmer@dabbelt.com>; Alistair=
 Francis
>> >> >> <alistair.francis@wdc.com>; Bin Meng <bin.meng@windriver.com>
>> >> >> Subject: How do you represent a host gcc and a cross gcc in lcitoo=
l?
>> >> >>
>> >> >> WARNING: This email originated from outside of Qualcomm. Please be=
 wary of
>> >> >> any links or attachments, and do not enable macros.
>> >> >>
>> >> >> Hi,
>> >> >>
>> >> >> While trying to convert the debian-riscv64-cross docker container =
to an
>> >> >> lcitool based one I ran into a problem building QEMU. The configur=
e step
>> >> >> fails because despite cross compiling we still need a host compile=
r to
>> >> >> build the hexagon codegen tooling.
>> >> >
>> >> > I thought we'd fixed this container definition so that we only
>> >> > downloaded the hexagon toolchain instead? Do we really need a host
>> >> > compiler for that container build?
>> >> >
>> >> > Or am I misunderstanding and you're referring to features required =
to
>> >> > support idef parser? Does "hexagon codegen" refer to hexagon's TCG
>> >> > generation or hexagon code itself (required by tests/tcg)?
>> >>
>> >> I think so:
>> >>
>> >> #
>> >> #  Step 1
>> >> #  We use a C program to create semantics_generated.pyinc
>> >> #
>> >> gen_semantics =3D executable(
>> >>     'gen_semantics',
>> >>     'gen_semantics.c',
>> >>     native: true, build_by_default: false)
>> >>
>> >> semantics_generated =3D custom_target(
>> >>     'semantics_generated.pyinc',
>> >>     output: 'semantics_generated.pyinc',
>> >>     command: [gen_semantics, '@OUTPUT@'],
>> >> )
>> >> hexagon_ss.add(semantics_generated)
>> >>
>> >>
>> >> >
>> >> >> After scratching my head for a while I discovered we did have host=
 GCC's
>> >> >> in our cross images despite there being no explicit request for th=
em in
>> >> >> the docker description. It turned out that the gcovr requirement p=
ulled
>> >> >> in lcov which itself had a dependency on gcc. However this is a bu=
g:
>> >> >>
>> >> >>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818
>> >> >>
>> >> >> which has been fixed in bookworm (and of course sid which is the o=
nly
>> >> >> way we can get a riscv64 build of QEMU at the moment). Hence my ha=
cky
>> >> >> attempts to get gcc via side effect of another package failed.
>> >> >>
>> >> >> Hence the question in $SUBJECT. I tried to add a mapping to lcitoo=
l for
>> >> >> a pseudo hostgcc package:
>> >> >>
>> >> >> +  hostgcc:
>> >> >> +    default: gcc
>> >> >> +    pkg:
>> >> >> +    MacOS:
>> >> >> +    cross-policy-default: skip
>> >> >>
>> >> >> however this didn't work. Do we need a new mechanism for this or a=
m I
>> >> >> missing a way to do this?
>> >> >>
>> >> >> RiscV guys,
>> >> >>
>> >> >> It's clear that relying on Debian Sid for the QEMU cross build for=
 RiscV
>> >> >> is pretty flakey. Are you guys aware of any other distros that bet=
ter
>> >> >> support cross compiling to a riscv64 target or is Debian still the=
 best
>> >> >> bet? Could you be persuaded to build a binary docker image with the
>> >> >> cross compilers and libraries required for a decent cross build as=
 an
>> >> >> alternative?
>> >
>> > It's probably not very helpful, but I find Arch based distros to be
>> > the best bet for this.
>>
>> I've never tried arch under docker, isn't it just as much of a moving
>> target?
>
> I haven't really tried Arch under Docker. I agree that it is a fast
> moving target. I guess it's up for debate if it's too much churn or
> not
>
> Would a working Arch image be helpful with lcitool?
>
>>
>> > Are you still looking for a Docker image? I could try and get
>> > something working
>>
>> Yes, although I have converted debian-riscv64-cross to lcitool and had
>> it working sid has since broken. Are there any pushes to have riscv as a
>> first class distro citizen soon or is stuff still in the early ports
>> stage?
>
> There are pushes. I thought RISC-V was progressing towards first class
> distro support, but it seems to have stalled recently.
>
> I actually thought you could cross compile with Debian bullseye, yet
> alone bookworm, has someone tried? Otherwise I can give it a crack

No.

There is a riscv64 compiler and libc in bullseye onwards which we use
for building tests. However to do a full cross compile you need a
multi-arch setup. As riscv64 is still in ports the only way to achieve
this is to use sid.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

