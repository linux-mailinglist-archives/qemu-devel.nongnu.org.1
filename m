Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD0812E60
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 12:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDjha-0006Dg-6U; Thu, 14 Dec 2023 06:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDjhU-0006DG-00
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:16:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDjhM-0004SZ-Ks
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:16:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-551d5cd1c5fso1001572a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702552571; x=1703157371; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ixpNKPZpuLlL+vxKt+44YSqclDVABkqfD62DzQ6s/o=;
 b=hoLit8FYk7vWwLkvWYQMmn8pQRwhccvAHtiGPwTgMMJVzkWBUl0SBXct8LRW8ln0Ip
 HmVRgdXYDz6nwd/5z3seXbdBm6QR35YHG4Fdk7AwHxSVntW17rXaDp4hrBKpfOSs4e6j
 cFU6Ov25ZJY4ncFpg0PN0blPMCOBMsQ5coVaDb80XO8RxXMvixkfvmeYViX/rvUUhATb
 508cIuOecI9wX2sr0JhqwdX3oqxPUMDxm1tBEJv2fBjqqcZG4dT7lef/gP6lIWZ1atO+
 lNnn+P2NG01wWCeUkact91PWINIbVHyOOp872TspzSvmEFxVcWi9N0fLgGhlfxwDNoYD
 6lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702552571; x=1703157371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ixpNKPZpuLlL+vxKt+44YSqclDVABkqfD62DzQ6s/o=;
 b=SU6sNTF0nxUPm/lABxUps6cRSXiLGnwBqnuDw72LuxL1tbqncv36zp7mQT9+gUnGRv
 o28lXL0W5as9EWmkmLilUwg6dG1XMiul8AQudblqUZA0qLCgWgL+XIlR31Kt6cMA4Pvj
 c3hnEPLg8EsyDntscgWyiKHxfNILwarER5PXnTh1hN3gVHBRK6tCpMMvDMZH2S+2tAzM
 vCepLE3PXwDJBP7OJWmAzhqsCfjtZZ2XpnMnHneBGFKPN/5Lf0e+1WUP5kJbHOlYz6kA
 bNrUZbi47d516btWIHstiEbbkGzNYrqTqMKKGFgxv+ya3lLpncj3aqYp9+wG5keynhlb
 494w==
X-Gm-Message-State: AOJu0Yz2fH/aCAjOVt+UTANna0JL+r6UsWqGd8ukrPmrSovMRHBQJUgm
 qKUYK2OEOsystlnHCSPUX3s9URhO23ZFtyfXw6CKbQ==
X-Google-Smtp-Source: AGHT+IFVqJbLLs39cF9H7yzI1rgzExA/pfzSczOypqG04ZYOczhGw+uIdE3sIzyrrDEiQMY3cAiaubVpNt3qiB0BN2M=
X-Received: by 2002:aa7:d143:0:b0:552:1ce8:256 with SMTP id
 r3-20020aa7d143000000b005521ce80256mr2661123edo.7.1702552570741; Thu, 14 Dec
 2023 03:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20231207111048.50568-1-philmd@linaro.org>
 <461b2494-cc2e-4d0e-bcc0-8dcf93389eb4@linaro.org>
In-Reply-To: <461b2494-cc2e-4d0e-bcc0-8dcf93389eb4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 11:16:00 +0000
Message-ID: <CAFEAcA-f2n+2RO74H-ii4eunH8bgUTQeN9sXfQqCkgFqQ1m1ag@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Restrict ARM_FEATURE_PMU to system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 7 Dec 2023 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 7/12/23 12:10, Philippe Mathieu-Daud=C3=A9 wrote:
> > ARM Performance Monitor Unit is not reachable from user
> > emulation, restrict it to system emulation.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

What's the aim of this patch? In general if we can avoid
ifdefs then I prefer to avoid ifdefs, because they clutter
up the code. So they should come with a justification of
why they're necessary (eg "the QOM property is visible to
the end-user but pointless" or "we want to be able to
change this file to be compiled a different way and this is
a necessary substep" or whatever the reason is).


> > ---
> >   target/arm/cpu.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 51f57fd5b4..60cf747fd6 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1410,6 +1410,7 @@ static Property arm_cpu_pmsav7_dregion_property =
=3D
> >                                              pmsav7_dregion,
> >                                              qdev_prop_uint32, uint32_t=
);
> >
> > +#ifndef CONFIG_USER_ONLY
> >   static bool arm_get_pmu(Object *obj, Error **errp)
> >   {
> >       ARMCPU *cpu =3D ARM_CPU(obj);
> > @@ -1432,6 +1433,7 @@ static void arm_set_pmu(Object *obj, bool value, =
Error **errp)
> >       }
> >       cpu->has_pmu =3D value;
> >   }
> > +#endif
> >
> >   unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> >   {
> > @@ -1592,12 +1594,12 @@ void arm_cpu_post_init(Object *obj)
> >       if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
> >           qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_proper=
ty);
> >       }
> > -#endif
> >
> >       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> >           cpu->has_pmu =3D true;
> >           object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu=
);
> >       }
> > +#endif
>
> I think this patch is incomplete: should the PMU registers in
> v7_cp_reginfo[] be restricted to TCG?

I can't remember if we had this conversation on IRC, but
in general it's preferable not to restrict a regdef to
TCG only because that means that gdb won't be able to read
the register value if you're using KVM.

thanks
-- PMM

