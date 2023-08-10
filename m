Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34A777EE1
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9Dm-0006zi-4k; Thu, 10 Aug 2023 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU9Di-0006zS-DR
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:13:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU9Dg-0007Nl-95
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:13:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so1428184a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691687586; x=1692292386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EiAV9WEj5eIkPc4Jq+fte4QSUn33GtcJgdcXqbMLuSw=;
 b=UpK8woqyYnFX4UCzyEEypyhlkKXlE+Wm5SGQ4NTb0WvXFYm5i2ZdjRwEwpKzsvc3JG
 kMWqQ0a15gyfOuLKXz9Ly/G8K189DmKyKv9nMgcBJ4M6qgeVbp6yqky97qN+adE/Bj1G
 FmW54GiCUN9LaIlEUDGWCg4HwRdwKKFb9WFp+nq/PUodBNJrTjww93Lr6DhQ7hXPamsy
 Gz3iEPZoVJIlOfQ+lXjUA6p7cxL9gHK+RnFhtlr0DxHl+AmBXalcqTOZWoP50aDpiVRq
 vTc8HQ2povhFFMEdravMfyNWAbzwTSQF4WM0Ryo0jv0pVpHx76bgeisr81hwzj/HB2/j
 PWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691687586; x=1692292386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiAV9WEj5eIkPc4Jq+fte4QSUn33GtcJgdcXqbMLuSw=;
 b=O09lZo9Hi9Etqxxn+en6uDtjuqyKhkqziSOUS7KCcQaRtGCJOhpCgYjwQV/ygFPuwZ
 wS/Djw1YI2U25V0bp0I1LBckNh4s9CVdKIomFC47ieY2q2XU9RezqKXfosxadhBHyXHb
 Gd5a959kNCUWKX8yEabRzDZgGE2Rh4gUblGXbPsjhjdqw39Rst9pRLwod5tjISxoS8gx
 LzwXiWa3QWnGfMqGp5g5NZXBSgXq6RLH/drAwECrghxsQBzkvyLJOVMAPmMQIAqnFw9M
 OgyLGwWKq8bj3Uxy9G4b2aKaV8bPrKDOydt61cx1u29P2J7eyEUYwoGLj7/0Psm8XpIP
 dN7w==
X-Gm-Message-State: AOJu0YzYBXS2VMm6NBQSPptORxKQIIgw5LFwMYjfKHSLIQ5anvhz6qNa
 zG5oMpHo/AWCC7v33/hNQJ8M3ML44HpVMs7eKbWnXQ==
X-Google-Smtp-Source: AGHT+IHKJhveIIJDipnYF0KlVJIxclgWYp9kg6JFWuStYXxJd0fbSZfpWlBrGbTRmeXROKjRt+Vo5OdO6uzUvQtAnEQ=
X-Received: by 2002:aa7:c245:0:b0:522:1d47:2d81 with SMTP id
 y5-20020aa7c245000000b005221d472d81mr2435184edo.17.1691687586513; Thu, 10 Aug
 2023 10:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-6-richard.henderson@linaro.org>
 <CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com>
 <17230fdc-6daf-82be-e665-97ca64d16feb@linaro.org>
In-Reply-To: <17230fdc-6daf-82be-e665-97ca64d16feb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 18:12:55 +0100
Message-ID: <CAFEAcA8viVtMGqBJ9D-2rehecb7QB7-F8PObhNTY9U-D=aNMTg@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 10 Aug 2023 at 18:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/10/23 08:49, Peter Maydell wrote:
> > On Thu, 10 Aug 2023 at 03:36, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> The cortex-a710 is a first generation ARMv9.0-A processor.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   docs/system/arm/virt.rst |   1 +
> >>   hw/arm/virt.c            |   1 +
> >>   target/arm/tcg/cpu64.c   | 167 +++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 169 insertions(+)
> >>
> >> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> >> index 51cdac6841..e1697ac8f4 100644
> >> --- a/docs/system/arm/virt.rst
> >> +++ b/docs/system/arm/virt.rst
> >> @@ -58,6 +58,7 @@ Supported guest CPU types:
> >>   - ``cortex-a57`` (64-bit)
> >>   - ``cortex-a72`` (64-bit)
> >>   - ``cortex-a76`` (64-bit)
> >> +- ``cortex-a710`` (64-bit)
> >>   - ``a64fx`` (64-bit)
> >>   - ``host`` (with KVM only)
> >>   - ``neoverse-n1`` (64-bit)
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 7d9dbc2663..d1522c305d 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -211,6 +211,7 @@ static const char *valid_cpus[] = {
> >>       ARM_CPU_TYPE_NAME("cortex-a55"),
> >>       ARM_CPU_TYPE_NAME("cortex-a72"),
> >>       ARM_CPU_TYPE_NAME("cortex-a76"),
> >> +    ARM_CPU_TYPE_NAME("cortex-a710"),
> >>       ARM_CPU_TYPE_NAME("a64fx"),
> >>       ARM_CPU_TYPE_NAME("neoverse-n1"),
> >>       ARM_CPU_TYPE_NAME("neoverse-v1"),
> >
> > Will sbsa-ref want this core ?
>
> It only has 40 PA bits, and I think sbsa-ref requires 48.

Yes, it does want 48 (we ran into that with some other core).

> >> +    cpu->isar.id_mmfr4 = 0x21021110;
> >
> > I don't think we implement HPDS == 2 (that's FEAT_HPDS2).
> > I guess we should push it down to HPDS 1 only in cpu.c
> > for now. (Or implement it, it's probably simple.)
>
> Feh.  I thought I'd double-checked all of the features.
> I'll have a look at implementing that.

I think we (meaning Linaro) kind of noted a lot of features
as architecturally optional and then didn't think through
that we might need them anyway for specific implementations.
(I got surprised by FEAT_NV that way for the Neoverse-V1.)

> >> +    cpu->ctr               = 0x00000004b444c004ull; /* with DIC set */
> >
> > Why set DIC? The h/w doesn't.
>
> Heh.  From the comment in neoverse-v1, I thought you had force enabled it there.  But it
> must simply be a h/w option?

Yes, the Neoverse-V1 TRM documents a config option of
"instruction cache hardware coherency" (which sets DIC),
and that the IDC pin "reflects the inverse value of the
BROADCASTCACHEMAINTPOU pin". So I opted for the config
choices that happen to be faster for QEMU.

thanks
-- PMM

