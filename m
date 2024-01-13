Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC7A82CCD2
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 14:39:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOeCe-0007Kw-P6; Sat, 13 Jan 2024 08:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOeCZ-0007Ka-1J
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:37:31 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOeCX-0008V1-4F
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:37:30 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5590f5fa93cso186813a12.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 05:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705153046; x=1705757846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rz24OMvi/V2SXbGCS1IxK9DxcCEEIjiEZAyA2+zzZc=;
 b=fho5Q8EjIG71+tJ/QkldMvQKDr43lbpTvU1tD2GWsoYflj/G10ZjcWxNY5eEw6nCL6
 7hl+VvqLqZ65WA29wd+SO4SpOharG99aV9uTZgTie5kWp4i8EyOMiGZG357lfvNgdV8C
 93uDFMMQT//GRhSIeTt57Zs2Y2r0qeBl2+aMg4jggvE0s1R6R+hLw9iU8MxecDd9I/J8
 sa3hdrMM830vwoLkBhnC4KCg7mrNyxqtVG7p6KinevUr5Fpi4wttnhHXhauW7kbJCZtY
 r4uYkVlgS2N3gJoghpPsaLiZRj484eZJBjAoWPBwGXcjY+B9VEqPchz5Ks/vc5fFZYQb
 rsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705153046; x=1705757846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rz24OMvi/V2SXbGCS1IxK9DxcCEEIjiEZAyA2+zzZc=;
 b=eGhHU3ktvFMxHLU+jWMThx60vLEnrKwtmf+X6IVT+2tUVlhNdJ+FFkjIUNO3t287sf
 M0T4n9Kzb8epy1//0toY1u6BzzOazAXQno+R3Cf0/6oib2jrmoOW8xxGcOAvM5hCu1Lq
 24QK2hz8S5bxPS7YfuY8TL2z0z78j8V77/hFJfEIUZSQYl/zszd3mHHaimssXkz5/mnz
 T56FnZsBkYuN3kNmoM8Cza5wQOhRF+ZJJmbYHu5QGybhNPcEVgo04TI0beSkJv0tXnU3
 FQ+EMvEm1oi9PR3mZIm+RKTvZ0KmznOo0EIIQikuv2cv1lo0zy+Jqvk/dIwQAfJuEk+h
 SP/A==
X-Gm-Message-State: AOJu0YyWfsOQnWnqIUy+teZIgk9afNvwj5cYlasMcvyUvB8/5cka28Lo
 +ZNQ4ojOHsJqzt/X04ZuItItHvzc2CntPU43IiDPg0u8sMBQjg==
X-Google-Smtp-Source: AGHT+IEFatFmxhqUzrc60Lqwqt/8ztwxYuxm8NO3lDTfOsUB6qyjMzekHJGP1a1zywT026F3xSTSBFFp4HzydNpglIU=
X-Received: by 2002:aa7:cd62:0:b0:557:9018:9980 with SMTP id
 ca2-20020aa7cd62000000b0055790189980mr1356731edb.52.1705153045887; Sat, 13
 Jan 2024 05:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 13:36:53 +0000
Message-ID: <CAFEAcA9c58iVvgW4wnNT1H3tzsdYbxyU-kT7bJP=A3E+B-t7PA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since v2 [2]:
> - Dropped "Simplify checking A64_MTE bit in FEATURE_ID register"
> - Correct object_property_get_bool() uses
> - Update ARM_FEATURE_AARCH64 && aa64_mte
>
> Since RFC [1]:
> - Split one patch per feature
> - Addressed Peter's review comments
>
> [1] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd@lina=
ro.org/
> [2] https://lore.kernel.org/qemu-devel/20240109180930.90793-1-philmd@lina=
ro.org/
>
> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>   "hw: Simplify accesses to CPUState::'start-powered-off' property"
>
> Philippe Mathieu-Daud=C3=A9 (14):
>   hw/arm/armv7m: Introduce cpudev variable in armv7m_realize()
>   hw/arm/armv7m: Ensure requested CPU type implements ARM_FEATURE_M
>   hw/arm/armv7m: Move code setting 'start-powered-off' property around
>   hw/arm/armv7m: Always set 'init-nsvtor' property for Cortex-M CPUs
>   hw/arm: Prefer arm_feature(M_SECURITY) over object_property_find()
>   hw/arm: Prefer arm_feature(THUMB_DSP) over object_property_find(dsp)
>   hw/arm: Prefer arm_feature(V7) over
>     object_property_find(pmsav7-dregion)
>   hw/arm: Prefer arm_feature(EL3) over object_property_find(has_el3)
>   hw/arm: Prefer arm_feature(EL2) over object_property_find(has_el2)
>   hw/arm: Prefer arm_feature(CBAR*) over
>     object_property_find(reset-cbar)
>   hw/arm: Prefer arm_feature(PMU) over object_property_find(pmu)
>   hw/arm: Prefer arm_feature(GENERIC_TMR) over 'kvm-no-adjvtime'
>     property
>   hw/arm: Prefer arm_feature(AARCH64) over object_property_find(aarch64)
>   hw/arm: Prefer cpu_isar_feature(aa64_mte) over
>     property_find(tag-memory)

The first part of this is fine and reasonable cleanup, but I
continue to disagree about the later parts. What we want to do is
"if this property is present, then set it", and that's what we do.
Conversion to "if <some condition we know that the CPU is using to
decide whether to define the property> then set it" is duplicating
the condition logic in two places and opening the door for bugs
where we change the condition in one place and not in the other.
Where the <some condition> is a simple "feature X is set" it doesn't
look too bad, but where it gets more complex it makes it IMHO more
obvious that this is a bad idea, for example with:

-        if (object_property_find(cpuobj, "reset-cbar")) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
+            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {

thanks
-- PMM

