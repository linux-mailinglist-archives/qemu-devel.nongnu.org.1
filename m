Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B7791804
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9Zy-0005YR-Ge; Mon, 04 Sep 2023 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qd9Zr-0005YD-Gb
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:25:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qd9Zo-0000LU-E2
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:25:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31de47996c8so1260088f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693833910; x=1694438710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnkQa+mF0QTOMBpgbaz/uDTz5KmvWwY/yP5P2ckABHE=;
 b=W70b++n5Aieg7XcruR6v999EiYbIa4eamQesYRLJs4CTUzY5v8a8IQEmMuJvxSDAem
 c5Az0sKqHwPLCtdCOgSLUg/YKEy1KvGJ09BAYHE/cNg0ssfaZazRVi3tXVXPISsMqyCV
 DRAvyXTfWgY8SQU5IRO/HJ3VoHXqRr1qRPDfzgNzFtr5yda9IsEZ0g1cXsVIL9dPi0Nc
 KdgY0mywsUnycyHMUTrdfub0OYQ2e+llxhbdsM8ob/XdxB193QoCtfYwqIp69oujTxAO
 48/MQmubfcv2bOqdMvmWN9pxETAQYDhfVEqGvJT1S80lVr5lBDBfh6IdR1FUokT0zpmU
 +g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693833910; x=1694438710;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lnkQa+mF0QTOMBpgbaz/uDTz5KmvWwY/yP5P2ckABHE=;
 b=eby3FPU91ZRJNlDIu4xr8lX+S4h4rGPkwAwL4dKEM5yqCr2JKmJ8UGr1xYUHt+SVrJ
 Nxov9LcuYLWzcscOCoD4sEwmrNzIJBvvCytQ/ATJqZs6WtieYfCkIVXINtiRRmcCVPEk
 /dsGVC0MVZb4NqPdwJ4En3Y3PoFeBwYEbSyQE8wkegF6YWh8Av6TGM0PFjFp7j5urTre
 IpxWAFmzaE4bA5TWlW0gN8/R1pKDVmnzhNZjb0CkBAMx5k/3Gt01kBMfkedyObCWOnbM
 dhrMrwYoCe538NxDQ0rXsO/KFARdqbOwrDFTc/qIBmrg6tKalqUXZkqOpOcAwFH8Mqe0
 mrhw==
X-Gm-Message-State: AOJu0YwTe3DTDPVKVM/U9OT+Swoq4V5ho7RmvPxRcRKPllpmrZXJI/TA
 9mU+45KhSqKQPsYfvIBD04+now==
X-Google-Smtp-Source: AGHT+IFU+iuqRpSsdECcJKxr0E2qTpbzeBxbxFIInSPPndMsEvlWlAyKrLR9mx0yZF/ZXesKtTZosw==
X-Received: by 2002:a05:6000:128b:b0:313:fe1b:f441 with SMTP id
 f11-20020a056000128b00b00313fe1bf441mr6616331wrx.29.1693833910160; 
 Mon, 04 Sep 2023 06:25:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a5d6351000000b0030fd03e3d25sm14731535wrw.75.2023.09.04.06.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 06:25:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59D701FFBB;
 Mon,  4 Sep 2023 14:25:09 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
 <efc935f7-67c2-8877-98aa-1aebfcafa534@linaro.org>
 <87h6ofprre.fsf@linaro.org> <b6f1fba2-c9b6-eaf5-9693-06bd8d747bf9@gmx.de>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 laurent@vivier.eu
Subject: Re: [PATCH v5 00/20] linux-user: Implement VDSOs
Date: Mon, 04 Sep 2023 13:51:58 +0100
In-reply-to: <b6f1fba2-c9b6-eaf5-9693-06bd8d747bf9@gmx.de>
Message-ID: <871qfejcju.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Helge Deller <deller@gmx.de> writes:

> On 8/31/23 09:57, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 8/30/23 07:52, Helge Deller wrote:
>>>> On 8/30/23 00:02, Richard Henderson wrote:
>>>>> Changes for v5:
>>>>>  =C2=A0=C2=A0 * Integrated cross-compile, via new build-vdso.sh and m=
eson rules.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 However, keep the binaries in the tree for =
hosts which do not
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 have all of the cross-compile machinery.
>>>>>  =C2=A0=C2=A0 * Update our loongarch64 docker image to avoid a binuti=
ls bug.
>>>>>
>>>>> Just in case the list eats a binary:
>>>>>  =C2=A0=C2=A0 https://gitlab.com/rth7680/qemu/-/tree/lu-vdso
>>>> I pulled that on top of git head, and ran into the build problem
>>>> below.
>>>> Do I miss something?
>>>
>>> No idea, since it worked for me.  Looks like some sort of docker.py pro=
blem.  Alex?
>>>
>>> In the short term, use --disable-containers so that you only use the
>>> cross-compilers that you have locally installed.
<snip>
>>
>> It looks like it detected podman on this setup. Can you invoke the
>> container from the command line?
>
> Yes, if I run it on the command line:
>
> [deller@p100 _build]$ 'podman' 'run' '--rm' '--label' 'com.qemu.instance.=
uuid=3D21e1c0332a2c44b6ae94a71392c57ccf' '--userns=3Dkeep-id' '-u' '1000' '=
-w' '/srv/_build' '-v' '/srv/_build:/srv/_build:rw' '-v' '/home/cvs/qemu/qe=
mu:/home/cvs/qemu/qemu:ro,z' 'qemu/debian-armhf-cross' 'arm-linux-gnueabihf=
-gcc' '-o' 'linux-user/arm/vdso-le.so' '-nostdlib' '-shared' '-Wl,-use-blx'=
 '-Wl,-h,linux-vdso.so.1' '-Wl,--build-id=3Dsha1' '-Wl,--hash-style=3Dboth'=
 '-Wl,-T,../../home/cvs/qemu/qemu/linux-user/arm/vdso.ld' '../../home/cvs/q=
emu/qemu/linux-user/arm/vdso.S' '-mlittle-endian'
>
> I get this interactive(!!!) output where I can use the cursor keys to swi=
th up/down:
>
> ? Please select an image:
>   =E2=96=B8 registry.fedoraproject.org/qemu/debian-armhf-cross:latest
>     registry.access.redhat.com/qemu/debian-armhf-cross:latest
>     docker.io/qemu/debian-armhf-cross:latest
>     quay.io/qemu/debian-armhf-cross:latest
>
> I assume the problem is, that we don't want interactive input at this sta=
ge?
> Probably this is why I get the error message: "Error: short-name
> resolution enforced but cannot prompt without a TTY" ?

No I think the problem is we need to add dependencies to the target to
ensure the containers are built and available (if they are needed). It
looks like because qemu/debian-armhf-cross isn't available on your local
setup it fails and offers some guesses.

If you run:

  make docker-image-debian-armhf-cross

does the target work afterwards?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

