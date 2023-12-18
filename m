Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1D7816A33
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:50:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFAFC-00040D-FV; Mon, 18 Dec 2023 04:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFAFA-0003zS-MA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:49:00 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFAF8-0006BB-VE
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:49:00 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5534abbc637so854058a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702892937; x=1703497737; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rzm0E835i0JWDe+HCQaZ1ik9yylUdADi+Oh0GkKdvQ=;
 b=LYcsqDY1XYpLQrDV7H66TEtKVq9d7qzsSV+Ut96H9GbFj1e6gz4WS0YmUDL8ysWyF+
 7OtuCVH8AWLrj5gbx3kYZa2LFgZ7snwyfQPUsRelXsAmcUltYlY96Vj56ana6b67jOEj
 DRrxo0gvczGNHWYtmsADgQEKar9p5+zW4Th6O2sg1byVbocQEFLywrjwPRogwTDoxyNy
 3B7k/A35WfcT54LAw8CDu4RavkNy/sg6fWpwSc3d/c5vxRAHCfRn3SGwS8F0rApb+VSb
 OgpkRwjr9dyl828oUs/vr8/10kkInWlZzvMK1EV8uBgYkZkWHjZzb3TP5vkhWFXMiYcq
 n5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702892937; x=1703497737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rzm0E835i0JWDe+HCQaZ1ik9yylUdADi+Oh0GkKdvQ=;
 b=iglEI6jhro2xWvHCHqgZ0nfUpmIlIU1YaLtPorwfD827vQ9ztrqvUDJgrHCSwJKsqD
 +trwK5fuvTH3qkgNibRizzFI2hyDh8sC+bJ+ROrAKIX7PbGfn0A+HbY50MO8xPwH0t0F
 8ZV5dzYyj4j5DyjFtu+l9vnJ3jacYqEutlMzOyuWwBhxI/xnBIiap2x8TOyPMR6K4oga
 W01vQDhqm8mYuZ7bJkNOB7Y6BA3HL0RDZEPBOBlU/tDiAxxcJbwoQHaDDoPqxpCSfiNV
 bnjdMjs9CzuOx/g2aqgKCi7S/B66MNlGnXXzlI7izQ71jlwj9T0ZjVwtqj4Zx/B1CFPo
 Ij3A==
X-Gm-Message-State: AOJu0YyU1S+AoEFGdF6dyOf88mXwO/3VMfq+cr/GJWXbNQBSzrUfyqvW
 mzb8Va+N0CMF5DxHULRRwWmKAURhn3Ti7hCirhMMiQ==
X-Google-Smtp-Source: AGHT+IFJWliWDFQ7yEBF2WnXbPX+wma1ojFtmH+69LkCl7i7E2SDJTpqLA8dyC5YRvmUNLgU5V6Mn5iJofSTZ0jJpcQ=
X-Received: by 2002:a50:ccdd:0:b0:553:5077:213c with SMTP id
 b29-20020a50ccdd000000b005535077213cmr583762edj.71.1702892936802; Mon, 18 Dec
 2023 01:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20231214171447.44025-1-philmd@linaro.org>
 <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
 <871qbkug24.fsf@pond.sub.org>
In-Reply-To: <871qbkug24.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 09:48:45 +0000
Message-ID: <CAFEAcA9vEvOeTseaC27hz9RKe13zs_2oPGjK-bLs8VL1wQF2jw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 18 Dec 2023 at 07:26, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> QOM properties are added on the ARM vCPU object when a
> >> feature is present. Rather than checking the property
> >> is present, check the feature.
> >>
> >> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >> RFC: If there is no objection on this patch, I can split
> >>      as a per-feature series if necessary.
> >>
> >> Based-on: <20231123143813.42632-1-philmd@linaro.org>
> >>   "hw: Simplify accesses to CPUState::'start-powered-off' property"
> >
> > I'm not a super-fan of board-level code looking inside
> > the QOM object with direct use of arm_feature() when
> > it doesn't have to. What's wrong with asking whether
> > the property exists before trying to set it?
>
> I'm not a fan of using QOM instead of the native C interface.
>
> The native C interface is CPUArmState method arm_feature().

But we don't in most of these cases really want to know "is this
a CPU with feature foo?". What we're asking is "does this
QOM property exist so it won't blow up if I set/get it?".

> Attempts to use it on anything but a CPUArmState * will be caught by the
> compiler.  object_property_find() will happily take any Object.
>
> Likewise, typos in its second argument will be caught by the compiler.
> object_property_find() will happily return NULL then.
>
>
> I also don't like adding QOM properties to instances.
> arm_cpu_post_init() seems to do that.  I feel it's best to stick to
> class properties whenever practical.

I agree, and the Arm CPU is a bit of an outlier in what it's
doing, for reasons that are largely I think historical. I'd
be happy to review patches that change these to class properties
where applicable, but I suspect that might be tricky...

thanks
-- PMM

