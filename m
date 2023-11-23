Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1C7F5CFA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67Kd-0003BV-86; Thu, 23 Nov 2023 05:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r67Kb-0003B1-9I
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:53:13 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r67KZ-00085i-Ld
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:53:13 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a62d4788so1014543e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700736789; x=1701341589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn231TPQAIm81aDlW6t4vrvp2l2n6+4iyMZdiNal2FU=;
 b=avXNtM+lPymhdDNJnTmVSCUrosXRny6rnCUmpLfAm+BKLBV23QIL1c1qiCtGBjO8WG
 mmRgN4v5EcyWS75hcJij/OEbLl2Q7HDk6sWwlstBoJu9EPOp3bcB4JEegHFBT5mFgAgW
 SE16qQ/nqgOenNARTKbb0ICJ9ZdOI7e/PtcM7djWSdJ94GTqHwUey7L1rR2Dmec4l8/c
 xIGzY3wHPJLGLw+yCuI8gZ8izM3bM1Zo/HUdPJvfTTc3EdxCn/achvxliGRXNPNN5Mdk
 6Q7zUjxrYYe/Lo8wmgvjSDHSVTUhcl8rDfNnMUIq3xj6OAvu91XPwT6OdRNF592dsjzh
 /UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700736789; x=1701341589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hn231TPQAIm81aDlW6t4vrvp2l2n6+4iyMZdiNal2FU=;
 b=ZoFNKf+XOQWa2vtYgQ6m8pg5SdFcKS2UhVvn9At/uX4Gf//IdASrZdSJ1wXKWsuShr
 SnwxR6iX4emlOhoL1ztKF3wUaUiAeOwvsPHER+s50Y3OeI0yL1zyZ1T3YnvfPB1YVGH/
 oixO8vCKH5j+MVkAFJX8nQswzlXnpj9lF286l8woHhFhkaqWDEVtywAQQ9h4rv4VYNGl
 TPW/wB6NrNH342vEwckTxHY71hx+DBaaHBZ5+A3tEYnMMThVYaiqWqIz3sU+OQE7OUbV
 auBu930exxs1ZnvFMnKKFnjA169vbXCQYzfIPITVtP54lZ8+fOiVvWeOiwBaVIK+l1Si
 MGOA==
X-Gm-Message-State: AOJu0YyHExJmyMyYvICf1daETOqCt+WmvDyvb6KxNR4NnBtNNxx/Jxdo
 e/eyBOLz6u18oOrSz61vvmiOxDFlOIVpaa8a3kTtVw==
X-Google-Smtp-Source: AGHT+IH4UXrmQK+84W/DqqbnAWGXE0sTgGhh1lmeuLukojxVDaaC3J6E9F2UUq7czicL+gL1c+daIW8Z9VJ2ZHf7M+M=
X-Received: by 2002:ac2:4c2a:0:b0:4fa:f96c:745f with SMTP id
 u10-20020ac24c2a000000b004faf96c745fmr3513464lfq.38.1700736788955; Thu, 23
 Nov 2023 02:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
In-Reply-To: <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2023 10:52:57 +0000
Message-ID: <CAFEAcA-kvS0TJN=wEeHYrG0Fqqm9Mj5Bx_0TFHwnTts6jXvFfw@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Mon, 20 Nov 2023 at 19:19, John Snow <jsnow@redhat.com> wrote:
>
> On Wed, Nov 15, 2023 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > The Python  Machine() class has passed one of a pre-created socketpair
> > FDs for the serial port chardev. The guest is trying to write to this
> > and blocking.  Nothing in the Machine() class is reading from the
> > other end of the serial port console.

> > The Machine class doesn't know if anything will ever use the console,
> > so as is the change is unsafe.
> >
> > The original goal of John's change was to guarantee we capture early
> > boot messages as some test need that.
> >
> > I think we need to be able to have a flag to say whether the caller nee=
ds
> > an "early console" facility, and only use the pre-opened FD passing for
> > that case. Tests we need early console will have to ask for that guaran=
tee
> > explicitly.
>
> Tch. I see. Thank you for diagnosing this.
>
> From the machine.py perspective, you have to *opt in* to having a
> console, so I hadn't considered that a caller would enable the console
> and then ... not read from it. Surely that's a bug in the caller?

From an Avocado test perspective, I would expect that the test case
should have to explicitly opt *out* of "the console messages appear
in the avocado test log, even if the test case doesn't care about them
for the purposes of identifying when to end the test or whatever".
The console logs are important for after-the-fact human diagnosis
of why a test might have failed, so we should always collect them.

thanks
-- PMM

