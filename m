Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA167189AE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 20:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4R0r-0001jh-Ss; Wed, 31 May 2023 14:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4R0q-0001jX-BM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:57:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4R0n-0008Gm-WA
 for qemu-devel@nongnu.org; Wed, 31 May 2023 14:57:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso6105069f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685559452; x=1688151452;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0ldhMcHbZlwinCi6h7a2UdabyftUe1BQKSbXNRUCg=;
 b=oItgdaeJMvgp9Vj5SPSwOABtgRPgEnS1Us6ZeIrR4KhwoEA6XkVjL3S0y5jMXCzSe3
 4GGbnelmjKOcEIO2MyLEaqxNrjLFL037K7rhwUtxgWc3XO1jdPgOVx3XXVM19LqKUbSS
 FVTZrj4/lAaH/ZpxLI1RCyRfvePO2AQ7h3MaTvZfbMZ3gUkWniVdbNmSCMWjr+NQPS4N
 m2FvZ6PNSzEaBFwB6pTBgmnLWFP2DDL5kJaTLW63Yb6OMVQ8fsWNpF8ftGQLcLE9EUx1
 Dv/npDvnykgvqkgqQM1fnGubmUlssqLf6lcfbRNniccgOPfesd6nuOxpbZ1vbOlprrER
 HUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685559452; x=1688151452;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hc0ldhMcHbZlwinCi6h7a2UdabyftUe1BQKSbXNRUCg=;
 b=DDEBIR5hlBXr10bf8PsNElE7xtCAKWzkbBKDlv2ZwgWVF89v5RL1RXAgIPlisZC3o2
 P6n1bOXcTaflFfG779qzPDb/6f4ONfn5quxVLnY5P9dahB5fGyfBkQcEqiHtcIljvr7d
 HSyv+w6ejATj0MZobOOP59LkevODDpzQD/VFSU1Z+PgISx5gI1EiVcaHMfVjkQ4bRSLY
 MheMSVVafjcuhtvTzuE1zA5S3//JldnY4WtlKONgknp/h7PJN5jsHUEcmQEOxCeoL7+3
 S8VVYRprl5jFPSj4GkDG/QCaBO5R7uC+LT+9h6ZgXPFp2VQgJXTfj+5kokJ7nqQdruyV
 9pCg==
X-Gm-Message-State: AC+VfDzlSCjPHn4qV1g2ul4A7m7122Q8qK3o+MGW7pNAtx3bAVZQiN+H
 B67W4o7vVpNc0XeMj/uNPkfk1g==
X-Google-Smtp-Source: ACHHUZ4UKnD6j+TsbhBvTalp73tfPX+gLjeNmbCn5K2pCPJiyU0J4xOBtT7zFRKteC4T9CSJxjaYxg==
X-Received: by 2002:a5d:58d9:0:b0:309:3ddc:1c8d with SMTP id
 o25-20020a5d58d9000000b003093ddc1c8dmr4867372wrf.70.1685559452205; 
 Wed, 31 May 2023 11:57:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6602000000b0030903d44dbcsm7511028wru.33.2023.05.31.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 11:57:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6147C1FFBB;
 Wed, 31 May 2023 19:57:31 +0100 (BST)
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <bcain@quicinc.com>
Cc: =?utf-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Erik  Skultety
 <eskultet@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, "Marco Liebel
 (QUIC)" <quic_mliebel@quicinc.com>
Subject: Re: How do you represent a host gcc and a cross gcc in lcitool?
Date: Wed, 31 May 2023 19:57:20 +0100
In-reply-to: <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
Message-ID: <87jzwoba78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Brian Cain <bcain@quicinc.com> writes:

>> -----Original Message-----
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Sent: Wednesday, May 31, 2023 6:24 AM
>> To: Daniel P.Berrang=C3=A9 <berrange@redhat.com>
>> Cc: qemu-devel <qemu-devel@nongnu.org>; Michael Tokarev
>> <mjt@tls.msk.ru>; Erik Skultety <eskultet@redhat.com>; Brian Cain
>> <bcain@quicinc.com>; Palmer Dabbelt <palmer@dabbelt.com>; Alistair Franc=
is
>> <alistair.francis@wdc.com>; Bin Meng <bin.meng@windriver.com>
>> Subject: How do you represent a host gcc and a cross gcc in lcitool?
>>=20
>> WARNING: This email originated from outside of Qualcomm. Please be wary =
of
>> any links or attachments, and do not enable macros.
>>=20
>> Hi,
>>=20
>> While trying to convert the debian-riscv64-cross docker container to an
>> lcitool based one I ran into a problem building QEMU. The configure step
>> fails because despite cross compiling we still need a host compiler to
>> build the hexagon codegen tooling.
>
> I thought we'd fixed this container definition so that we only
> downloaded the hexagon toolchain instead? Do we really need a host
> compiler for that container build?
>
> Or am I misunderstanding and you're referring to features required to
> support idef parser? Does "hexagon codegen" refer to hexagon's TCG
> generation or hexagon code itself (required by tests/tcg)?

I think so:

#
#  Step 1
#  We use a C program to create semantics_generated.pyinc
#
gen_semantics =3D executable(
    'gen_semantics',
    'gen_semantics.c',
    native: true, build_by_default: false)

semantics_generated =3D custom_target(
    'semantics_generated.pyinc',
    output: 'semantics_generated.pyinc',
    command: [gen_semantics, '@OUTPUT@'],
)
hexagon_ss.add(semantics_generated)


>
>> After scratching my head for a while I discovered we did have host GCC's
>> in our cross images despite there being no explicit request for them in
>> the docker description. It turned out that the gcovr requirement pulled
>> in lcov which itself had a dependency on gcc. However this is a bug:
>>=20
>>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818
>>=20
>> which has been fixed in bookworm (and of course sid which is the only
>> way we can get a riscv64 build of QEMU at the moment). Hence my hacky
>> attempts to get gcc via side effect of another package failed.
>>=20
>> Hence the question in $SUBJECT. I tried to add a mapping to lcitool for
>> a pseudo hostgcc package:
>>=20
>> +  hostgcc:
>> +    default: gcc
>> +    pkg:
>> +    MacOS:
>> +    cross-policy-default: skip
>>=20
>> however this didn't work. Do we need a new mechanism for this or am I
>> missing a way to do this?
>>=20
>> RiscV guys,
>>=20
>> It's clear that relying on Debian Sid for the QEMU cross build for RiscV
>> is pretty flakey. Are you guys aware of any other distros that better
>> support cross compiling to a riscv64 target or is Debian still the best
>> bet? Could you be persuaded to build a binary docker image with the
>> cross compilers and libraries required for a decent cross build as an
>> alternative?
>>=20
>> Thanks,
>>=20
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

