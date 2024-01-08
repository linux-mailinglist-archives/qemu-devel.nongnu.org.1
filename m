Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B178C826F1D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpDg-0006WI-Pg; Mon, 08 Jan 2024 07:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rMpDe-0006Vb-Iw; Mon, 08 Jan 2024 07:59:06 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rMpDd-0007kN-07; Mon, 08 Jan 2024 07:59:06 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5edfcba97e3so16946377b3.2; 
 Mon, 08 Jan 2024 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704718743; x=1705323543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=84mH5B/Jgrq4oAqmKeNIT8qz+4H+QI1lfy9c1DN9izQ=;
 b=gMh31pLEvI66QNSHFGIiQYoNivIEZz6ZrQkdbev+GHMDTktgeE31tF9tCaDiO1wNPF
 cVeY46T6KVAPbKKaS640bEjjahYMifZeoVYbFVhDTjUxWA6JSwvzJ4UgK53piYqekAbI
 L0/CJymsiGISI7/gfQst64SLEWYOf0OqVieoUW59ij4NYf76MuSAe5Ee9i1AlgXELU15
 a3Z4pNI2KPebtV/CIr+u3WDy6ioJH4hNfT6KVSEZ43QJnZtoBOuHcHqBK+5FWvfJ1cFg
 uKt7vG18B7Ka0PTE8W7hopFiA9KdaYQ+ZzSRWtFS3GhhRP4akEgLTyifRHH5CPSCpbdk
 pA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718743; x=1705323543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=84mH5B/Jgrq4oAqmKeNIT8qz+4H+QI1lfy9c1DN9izQ=;
 b=gt7qkFPYZ6AiLJtc7mJ4C8mpsUumEcATbMkayPFw2flFO6yQO1cChANwv0kdUE0OFu
 aW3AmqEgR3pRVJLKBy/smXXmw12mBZjMylhq9qlcdkfjjddILTZ3kY+0TKnnWLguN1kU
 Je9R4Yift71ho/qaNAxNJFQuFHoq+PVfVrxH0YdeRS77gs85Fe8t6alZmnc2wjNOvOAw
 kMqn8eMW91lhB+rNFP274dc+d3jol86EZrfzWoxpjWB+79n9zDFhueFij4JKtdi9hisL
 Anj2zS8r4u1wiptsIUc4vGe8s8/q2c8AbdVLYWfg0W46LIRDi+bEu0d0dl2ZBppx/oyG
 QRkw==
X-Gm-Message-State: AOJu0Yz6nVYp1fllXdD5Q0cMV+osuawUKi6GfKfvnNkV0LiJV1UGN/L/
 I29mAd6K+zkxvm6K46QkINX3QoxQgqNtfZ4cNKM=
X-Google-Smtp-Source: AGHT+IHYZLxbUMgfLMUY1RGG26e79rYvsf77s2sSVJ52pKwezxEqjrKS75qf1FMBC32YJILuyuFb6ueYOa3Q45NpC2U=
X-Received: by 2002:a25:800f:0:b0:da0:7d1e:6e0 with SMTP id
 m15-20020a25800f000000b00da07d1e06e0mr1458451ybk.20.1704718743406; Mon, 08
 Jan 2024 04:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20240107165702.47819-1-n.ostrenkov@gmail.com>
 <f030dc08-f010-43dd-9aaf-e9b8048a8e43@linaro.org>
In-Reply-To: <f030dc08-f010-43dd-9aaf-e9b8048a8e43@linaro.org>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Mon, 8 Jan 2024 15:58:52 +0300
Message-ID: <CAC8KSA1S8ruxXmGhppout+Y5bYyy5Ot==Kq6aBKAim8hG1OiYw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add PCIe to Freescale i.MX6
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000024912f060e6ec3c3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000024912f060e6ec3c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! Thanks! I'll send a new version of this patch.

But what about fsl imx7? Should it also have PCIE_DEVICES?

=D0=BF=D0=BD, 8 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 15:20, Phil=
ippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Hi Nikita,
>
> On 7/1/24 17:57, Nikita Ostrenkov wrote:
> > Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> > ---
> >   hw/arm/Kconfig            |  3 +++
> >   hw/arm/fsl-imx6.c         | 25 ++++++++++++++++++++++
> >   include/hw/arm/fsl-imx6.h | 44 ++++++++++++++++++++------------------=
-
> >   3 files changed, 51 insertions(+), 21 deletions(-)
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 660f49db49..575bb68c76 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -530,13 +530,16 @@ config FSL_IMX31
> >
> >   config FSL_IMX6
> >       bool
> > +    imply PCI_DEVICES
>
> This should be PCIE_DEVICES.
>
> >       imply I2C_DEVICES
> >       select A9MPCORE
> > +    select PCI
>
> Incorrect, should be PCI_EXPRESS, but this is already
> (indirectly) selected by PCI_EXPRESS_DESIGNWARE which
> you select below, so not needed.
>
> >       select IMX
> >       select IMX_FEC
> >       select IMX_I2C
> >       select IMX_USBPHY
> >       select WDT_IMX2
> > +    select PCI_EXPRESS_DESIGNWARE
> >       select SDHCI
>

--00000000000024912f060e6ec3c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi! Thanks! I&#39;ll send a new version of this patch.=C2=
=A0<div><br></div><div>But what about fsl imx7? Should it also have PCIE_DE=
VICES?</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">=D0=BF=D0=BD, 8 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2=
 15:20, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org=
">philmd@linaro.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Nikita,<br>
<br>
On 7/1/24 17:57, Nikita Ostrenkov wrote:<br>
&gt; Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmai=
l.com" target=3D"_blank">n.ostrenkov@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 +++<br>
&gt;=C2=A0 =C2=A0hw/arm/fsl-imx6.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 25 ++=
++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/arm/fsl-imx6.h | 44 ++++++++++++++++++++-------=
------------<br>
&gt;=C2=A0 =C2=A03 files changed, 51 insertions(+), 21 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index 660f49db49..575bb68c76 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -530,13 +530,16 @@ config FSL_IMX31<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0config FSL_IMX6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
<br>
This should be PCIE_DEVICES.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0imply I2C_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select A9MPCORE<br>
&gt; +=C2=A0 =C2=A0 select PCI<br>
<br>
Incorrect, should be PCI_EXPRESS, but this is already<br>
(indirectly) selected by PCI_EXPRESS_DESIGNWARE which<br>
you select below, so not needed.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select IMX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select IMX_FEC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select IMX_I2C<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select IMX_USBPHY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select WDT_IMX2<br>
&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_DESIGNWARE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select SDHCI<br>
</blockquote></div>

--00000000000024912f060e6ec3c3--

