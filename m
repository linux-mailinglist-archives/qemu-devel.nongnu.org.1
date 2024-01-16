Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157D82F28D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmXk-0001f9-Ug; Tue, 16 Jan 2024 11:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmXi-0001Zn-In
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:44:02 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmXg-0005vE-NG
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:44:02 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so11627875a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705423439; x=1706028239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEWHIsOs0K0h8LuxnFBVrPkY6pIftjFFe53K4qEN0iw=;
 b=UMF+FPoEH1Fkau6fUegJWt+fCtEJ9iuIS9tmUwLyGqFdENTWp6cUlqbOrRLsbG/W4r
 0BdegcNB/vLgYbDDqNqUUzTbkOVFedo3VzPmXZSWzD6yMd4qOXaOQ4tosNVt1nvz8yHo
 3KPoixxUsANglJhmBgNP2tijTzRuQ7mDqgJV9ARSvcV3MXr5IWDLMdt1rzKej1DGDhLs
 PS5GC+vMnOtYNxADj64zmVNPC08YGfuVJeyftfliTalningapboHr8dwRek4w3b/pB9l
 fEqi2VDJeoPb58i8n97LqKObDGEP5T/ob9ynUac+EmmIfGsIrJNQRWNuAadAM2U824oK
 M4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423439; x=1706028239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEWHIsOs0K0h8LuxnFBVrPkY6pIftjFFe53K4qEN0iw=;
 b=s3SDWrqKew/vsmavqwj1416corZmUVOY+7Rrwiv63jw3ZrbFaPQFcb3ivhgQIJSTDn
 lempoDYmhkhMHRQeNX0vh3aF2RKKMo7JzjCq2rmNKbwezehj+EmborMcd3Q/Y5yIQfXX
 UTlIj3ovvtv9VpgTQSAzj43LblD4TNXOMmkcekPJKI5JfIQtmaLyfKiCPn2ktnoN8H+u
 THj+8fyy2QgbiJq0cwAjOUmbwDoXquzDrZpkyQtBuKzSHYzfC+mCAZn5AeJ0uN1dAubP
 Tzigi5aYThD9s43S7hLpyra0WaI3USsLUV3eRsZNEa5qFNeY8Ycygzpj0c1da6hwUth1
 aIUw==
X-Gm-Message-State: AOJu0YyfLYz+doIU9nt0x93cvfh/biz32/VgeEags4PhwkmaRqvgx2tb
 EWWAxn/Zc5ITKjn67zgjemxB4WBoq8EsmSs/t7AeWcNzZ4t/7g==
X-Google-Smtp-Source: AGHT+IGFGl2T4WvnJZo/NVA65E62ccTpzGnsuE654Uns4u39ylX8RacuPRkheZC66bJjd/FjPNegpkNTAxWI2X2eLzM=
X-Received: by 2002:a05:6402:17cf:b0:559:c8e6:9d71 with SMTP id
 s15-20020a05640217cf00b00559c8e69d71mr61950edy.27.1705423438827; Tue, 16 Jan
 2024 08:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <CAFEAcA9c58iVvgW4wnNT1H3tzsdYbxyU-kT7bJP=A3E+B-t7PA@mail.gmail.com>
 <7a73231a-d7ae-4abe-9bca-e8e295a5f70d@linaro.org>
In-Reply-To: <7a73231a-d7ae-4abe-9bca-e8e295a5f70d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 16:43:47 +0000
Message-ID: <CAFEAcA-wV-1njkAhjV1kjp1NW8RVjZLNjJMThrcuhjakNT3TTg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 16 Jan 2024 at 16:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 13/1/24 14:36, Peter Maydell wrote:
> > On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Since v2 [2]:
> >> - Dropped "Simplify checking A64_MTE bit in FEATURE_ID register"
> >> - Correct object_property_get_bool() uses
> >> - Update ARM_FEATURE_AARCH64 && aa64_mte
> >>
> >> Since RFC [1]:
> >> - Split one patch per feature
> >> - Addressed Peter's review comments
> >>
> >> [1] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd@l=
inaro.org/
> >> [2] https://lore.kernel.org/qemu-devel/20240109180930.90793-1-philmd@l=
inaro.org/
> >>
> >> Based-on: <20231123143813.42632-1-philmd@linaro.org>
> >>    "hw: Simplify accesses to CPUState::'start-powered-off' property"
> >>
> >> Philippe Mathieu-Daud=C3=A9 (14):
> >>    hw/arm/armv7m: Introduce cpudev variable in armv7m_realize()
> >>    hw/arm/armv7m: Ensure requested CPU type implements ARM_FEATURE_M
> >>    hw/arm/armv7m: Move code setting 'start-powered-off' property aroun=
d
> >>    hw/arm/armv7m: Always set 'init-nsvtor' property for Cortex-M CPUs
>
>
> > The first part of this is fine and reasonable cleanup, but I
> > continue to disagree about the later parts. What we want to do is
> > "if this property is present, then set it", and that's what we do.
> > Conversion to "if <some condition we know that the CPU is using to
> > decide whether to define the property> then set it" is duplicating
> > the condition logic in two places and opening the door for bugs
> > where we change the condition in one place and not in the other.
> > Where the <some condition> is a simple "feature X is set" it doesn't
> > look too bad, but where it gets more complex it makes it IMHO more
> > obvious that this is a bad idea, for example with:
> >
> > -        if (object_property_find(cpuobj, "reset-cbar")) {
> > +        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
> > +            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
>
> For that we could add helpers such
>
>    static inline bool arm_feature_cbar(CPUState *cpu) {
>      return arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
>             arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
>    }
>
> and use it in the target/ code where we register the property
> and in the hw/ code where we set it.

Well, we could, but why? The question we're trying to
answer is "can we set this property?" and the simplest
and most logical way to test that is "does the object
have the property?". I really don't understand why we
would want to change the code at all.

> Do you mind taking the cleanup patches (1-4) meanwhile?

Yes, I can take patches 1-4.

thanks
-- PMM

