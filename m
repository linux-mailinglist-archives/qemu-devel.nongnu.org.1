Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A173B546
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCe2V-0001gI-Tx; Fri, 23 Jun 2023 06:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCe2M-0001Zc-7I
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:29:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCe2K-0001bb-AP
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:29:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so5993695e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687516142; x=1690108142;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGH9BrqzS0ZJ8Ml/udqg4k6QXUaBqZEMJqSzNiHRIMA=;
 b=MU3LWMNKS8IMIgjVEozb29dd3epO3l9dZnFc1ZCG9aC23GC2sRMeEo/u0NbVzC7BxD
 oRL7qLBtx7d5Iw2vw3/bfM+bXweCXIt1kCiuVoRhee0tmgvUZCcFf44q4hhuKHcCyCIk
 xAu3dIrDh+VA/1PkSFghwpRqEKQv6FblvXbGw71TNZ13ZmQDPg2Jv5fmWFHs6IEAP/7v
 +7rXo1T/vBPspLFQYFR22nJbpJw3s+pCWBQnEcdajCrkGOJze2J1jyZR7uyVnTB04Wxo
 nmY2r5voiQBe2nhPhbMMBISsohr7wlJ67Z5Jqhrpm0Dq9aZKSntf66d6FVXQg3Q3yf2n
 UT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687516142; x=1690108142;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KGH9BrqzS0ZJ8Ml/udqg4k6QXUaBqZEMJqSzNiHRIMA=;
 b=aUhVSCbADX77N7GrC+WFQ2Bwp0ERWvSLW0oh0lKzvLvmyfH3D8/SnXHG7M2e2zoIB4
 2EIcJHB7G4RjogXqt7Q4InjuIPjo+xjqA0UXYjCYBclM4iOwxRUZI3yZyZNAoxLr48a8
 7y/9jEqADhz7JGmc2YYIP5BB2RlLhEOz8AA6lRrBcsdRVtN4F0EANeDbi0N4Fjj6yxuP
 9MbwAbFURo1Zrw7L3hKDnE1zw/rXTBlVZpaj53HxCNax+8SVQ2quMFCO4mVafAy3rHyT
 Co6y+Z9oXc8eypiouMmkZxyi26DfDQ5EZluKz/l1oAL5OsroUjblwIa8LYav1hqOyG6n
 P0Lg==
X-Gm-Message-State: AC+VfDzYKeBVapxOG9YNQ/qwHhW1srQzVf6oyYMQJdN9L7uVSJwWEfiU
 equRCyiC5Z2QzTXdJLiGtU/5bQ==
X-Google-Smtp-Source: ACHHUZ68qnQ0A015fLLoYGJsGtXjIWVZlvUA+6NcUVelc4CWuHkKv7g+bmKpTAemmMjlIHqFkK/xZA==
X-Received: by 2002:adf:f3d0:0:b0:30d:7c09:b677 with SMTP id
 g16-20020adff3d0000000b0030d7c09b677mr17617242wrp.39.1687516142475; 
 Fri, 23 Jun 2023 03:29:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a5d4283000000b00312780bedc3sm9142008wrq.56.2023.06.23.03.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 03:29:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABCE61FFBB;
 Fri, 23 Jun 2023 11:29:01 +0100 (BST)
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
 <87jzwoba78.fsf@linaro.org>
 <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
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
Date: Fri, 23 Jun 2023 11:25:12 +0100
In-reply-to: <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
Message-ID: <87fs6ifp5e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> On Thu, Jun 1, 2023 at 4:58=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>>
>>
>> Brian Cain <bcain@quicinc.com> writes:
>>
>> >> -----Original Message-----
>> >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> Sent: Wednesday, May 31, 2023 6:24 AM
>> >> To: Daniel P.Berrang=C3=A9 <berrange@redhat.com>
>> >> Cc: qemu-devel <qemu-devel@nongnu.org>; Michael Tokarev
>> >> <mjt@tls.msk.ru>; Erik Skultety <eskultet@redhat.com>; Brian Cain
>> >> <bcain@quicinc.com>; Palmer Dabbelt <palmer@dabbelt.com>; Alistair Fr=
ancis
>> >> <alistair.francis@wdc.com>; Bin Meng <bin.meng@windriver.com>
>> >> Subject: How do you represent a host gcc and a cross gcc in lcitool?
>> >>
>> >> WARNING: This email originated from outside of Qualcomm. Please be wa=
ry of
>> >> any links or attachments, and do not enable macros.
>> >>
>> >> Hi,
>> >>
>> >> While trying to convert the debian-riscv64-cross docker container to =
an
>> >> lcitool based one I ran into a problem building QEMU. The configure s=
tep
>> >> fails because despite cross compiling we still need a host compiler to
>> >> build the hexagon codegen tooling.
>> >
>> > I thought we'd fixed this container definition so that we only
>> > downloaded the hexagon toolchain instead? Do we really need a host
>> > compiler for that container build?
>> >
>> > Or am I misunderstanding and you're referring to features required to
>> > support idef parser? Does "hexagon codegen" refer to hexagon's TCG
>> > generation or hexagon code itself (required by tests/tcg)?
>>
>> I think so:
>>
>> #
>> #  Step 1
>> #  We use a C program to create semantics_generated.pyinc
>> #
>> gen_semantics =3D executable(
>>     'gen_semantics',
>>     'gen_semantics.c',
>>     native: true, build_by_default: false)
>>
>> semantics_generated =3D custom_target(
>>     'semantics_generated.pyinc',
>>     output: 'semantics_generated.pyinc',
>>     command: [gen_semantics, '@OUTPUT@'],
>> )
>> hexagon_ss.add(semantics_generated)
>>
>>
>> >
>> >> After scratching my head for a while I discovered we did have host GC=
C's
>> >> in our cross images despite there being no explicit request for them =
in
>> >> the docker description. It turned out that the gcovr requirement pull=
ed
>> >> in lcov which itself had a dependency on gcc. However this is a bug:
>> >>
>> >>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818
>> >>
>> >> which has been fixed in bookworm (and of course sid which is the only
>> >> way we can get a riscv64 build of QEMU at the moment). Hence my hacky
>> >> attempts to get gcc via side effect of another package failed.
>> >>
>> >> Hence the question in $SUBJECT. I tried to add a mapping to lcitool f=
or
>> >> a pseudo hostgcc package:
>> >>
>> >> +  hostgcc:
>> >> +    default: gcc
>> >> +    pkg:
>> >> +    MacOS:
>> >> +    cross-policy-default: skip
>> >>
>> >> however this didn't work. Do we need a new mechanism for this or am I
>> >> missing a way to do this?
>> >>
>> >> RiscV guys,
>> >>
>> >> It's clear that relying on Debian Sid for the QEMU cross build for Ri=
scV
>> >> is pretty flakey. Are you guys aware of any other distros that better
>> >> support cross compiling to a riscv64 target or is Debian still the be=
st
>> >> bet? Could you be persuaded to build a binary docker image with the
>> >> cross compilers and libraries required for a decent cross build as an
>> >> alternative?
>
> It's probably not very helpful, but I find Arch based distros to be
> the best bet for this.

I've never tried arch under docker, isn't it just as much of a moving
target?

> Are you still looking for a Docker image? I could try and get
> something working

Yes, although I have converted debian-riscv64-cross to lcitool and had
it working sid has since broken. Are there any pushes to have riscv as a
first class distro citizen soon or is stuff still in the early ports
stage?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

