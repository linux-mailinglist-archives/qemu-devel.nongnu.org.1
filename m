Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B21832D8C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:55:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQs8j-0004F0-Au; Fri, 19 Jan 2024 11:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQs8e-0004E3-9r
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:54:40 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQs8b-0005kc-8Y
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:54:40 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cdeb80fdfdso12574161fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705683273; x=1706288073; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VKo14nNjMspmI9IxH1AOTDwceC29Cl5/kWyMJjbH8c=;
 b=OzMz+dgbqQh0grGcLmSN1O59Pi/JzRRo27QZyfxe6x9/WngnQcIpO00KkkUMYu0MKd
 keGn943NK1ueXhXmYabQola58gqsNnEO44EjkvUVjrL9M9nNXkefg0xJnu90HFrXlSpj
 XX4DRLUbPMUDe9zRADzYQhkN4HjdKuhOzC3RBXjbCJsdQs/5eKKyDB8z2KR5bZxitMEx
 JC2uVUven/9NjxBGCJLdFuf+SFUivQ04/KevJRyrMoT5cU2aQLAEnkrRvx4Q+0da3AtT
 ge86bkOYHMDznXLNyMqzamFF0DwJL1te9gUjclkqvwz/RHF1ueUeHcUpehEwJ11EjvYu
 QXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683273; x=1706288073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VKo14nNjMspmI9IxH1AOTDwceC29Cl5/kWyMJjbH8c=;
 b=llRwr72yT43jYstICDlW8+0Om2ORe7T+fLjBOZ746wmafCNHpTAie048rAYr81UV2O
 MIwbgeFkoYa1HaMdIMgqQErB89HncsX3iqtEC1u+yqfvwPmXNVSWIie42L+DpDiC5B+T
 o4PxZ2ht56IMLF7ut+LTPR6MUmQL1WjAaTBKiil20LDxLlgWmBPUGGgn5cc0BM08NUcW
 s0TbIXqufIb/XbJW/sBUoqMqLCNKPlY+3B5WRZU5QzXt/y2CHa8OTQY1TukuTcrQVbKG
 ssomq/L74/Ey+ycgpSdOEJtRheyRkGgKTHB5ePw5H4vfzf4HCU8p2JzPpF0XBmyZkAvh
 uD5g==
X-Gm-Message-State: AOJu0YxaNCuEXt2Gjb1S54yCbBqQPQ75EpDxHoLeEqDjGBS+o9DBzavw
 YSInjLWrwLe72XGXJbvXqCB8sI/wOtO/1aquQsQcJXeL3Fzzmu/lFzw4/lL3AgeorQ9bqvaYdxB
 OzlG2C1SKMuFUIYAyVDy9octC1sEkdGIU5rnxQA==
X-Google-Smtp-Source: AGHT+IGvz8NY58VpW6T/HJHz1w1NKNjuVqXvfmOcq2MDh5zSu5irvrW9dHZrZLKgCjbG/oSDjikg4Vs1E1NyJCJQ8Bc=
X-Received: by 2002:a2e:3e17:0:b0:2cd:2c9e:180 with SMTP id
 l23-20020a2e3e17000000b002cd2c9e0180mr779162lja.116.1705683273609; Fri, 19
 Jan 2024 08:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <CAFEAcA9c58iVvgW4wnNT1H3tzsdYbxyU-kT7bJP=A3E+B-t7PA@mail.gmail.com>
 <7a73231a-d7ae-4abe-9bca-e8e295a5f70d@linaro.org>
 <CAFEAcA-wV-1njkAhjV1kjp1NW8RVjZLNjJMThrcuhjakNT3TTg@mail.gmail.com>
In-Reply-To: <CAFEAcA-wV-1njkAhjV1kjp1NW8RVjZLNjJMThrcuhjakNT3TTg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:54:22 +0000
Message-ID: <CAFEAcA_1egxsS=N_L_BtVvRTNZNC9uBYUNH34UUa3KaO9nPehQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] hw/arm: Prefer arm_feature() over
 object_property_find()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Jan 2024 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 16 Jan 2024 at 16:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > On 13/1/24 14:36, Peter Maydell wrote:
> > > On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@lin=
aro.org> wrote:
> > >>
> > >> Since v2 [2]:
> > >> - Dropped "Simplify checking A64_MTE bit in FEATURE_ID register"
> > >> - Correct object_property_get_bool() uses
> > >> - Update ARM_FEATURE_AARCH64 && aa64_mte
> > >>
> > >> Since RFC [1]:
> > >> - Split one patch per feature
> > >> - Addressed Peter's review comments
> > >>
> > >> [1] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd=
@linaro.org/
> > >> [2] https://lore.kernel.org/qemu-devel/20240109180930.90793-1-philmd=
@linaro.org/
> > >>
> > >> Based-on: <20231123143813.42632-1-philmd@linaro.org>
> > >>    "hw: Simplify accesses to CPUState::'start-powered-off' property"
> > >>
> > >> Philippe Mathieu-Daud=C3=A9 (14):
> > >>    hw/arm/armv7m: Introduce cpudev variable in armv7m_realize()
> > >>    hw/arm/armv7m: Ensure requested CPU type implements ARM_FEATURE_M
> > >>    hw/arm/armv7m: Move code setting 'start-powered-off' property aro=
und
> > >>    hw/arm/armv7m: Always set 'init-nsvtor' property for Cortex-M CPU=
s
> >
> >
> > > The first part of this is fine and reasonable cleanup, but I
> > > continue to disagree about the later parts. What we want to do is
> > > "if this property is present, then set it", and that's what we do.
> > > Conversion to "if <some condition we know that the CPU is using to
> > > decide whether to define the property> then set it" is duplicating
> > > the condition logic in two places and opening the door for bugs
> > > where we change the condition in one place and not in the other.
> > > Where the <some condition> is a simple "feature X is set" it doesn't
> > > look too bad, but where it gets more complex it makes it IMHO more
> > > obvious that this is a bad idea, for example with:
> > >
> > > -        if (object_property_find(cpuobj, "reset-cbar")) {
> > > +        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
> > > +            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
> >
> > For that we could add helpers such
> >
> >    static inline bool arm_feature_cbar(CPUState *cpu) {
> >      return arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
> >             arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> >    }
> >
> > and use it in the target/ code where we register the property
> > and in the hw/ code where we set it.
>
> Well, we could, but why? The question we're trying to
> answer is "can we set this property?" and the simplest
> and most logical way to test that is "does the object
> have the property?". I really don't understand why we
> would want to change the code at all.
>
> > Do you mind taking the cleanup patches (1-4) meanwhile?
>
> Yes, I can take patches 1-4.

Hmm, this doesn't apply cleanly (probably due to the dependency
noted in the Based-on tag). Can you resend the relevant patches
in a form where they'll apply, or ping me once the dependency has
gone upstream), please?

thanks
-- PMM

