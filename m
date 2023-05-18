Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ABD7083FA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzej1-0006xK-UP; Thu, 18 May 2023 10:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ido.ber3@gmail.com>)
 id 1pzej0-0006x0-1y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:35:26 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ido.ber3@gmail.com>)
 id 1pzeiy-0001MZ-FE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:35:25 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-3f39600f9b8so10689251cf.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684420523; x=1687012523;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7laxQvselTFgPc8ahAoxVSv6VFklyi9ZezIofVcIlA=;
 b=IeTvr7BuD8Cr8VulKCNACicdxLi9x8nPSTBDKccFVn+8IH2d6HA6X41GfbmpS2j0X3
 Rk01g1FXcVPchUdzq6W4Nx+RxKd2nwdG6Wx94K1TpBc8yyUBBSjgAqeVi4ZWkvDT5YEm
 Fmz0Vn1p9aJmMXHOv2QNSadd6pnqkUJco3acomgy3cKX+B9vaS8qV+6pfMf03bXThBs7
 ALcDTm5MHCKQSV+CL6CAtS96uGXiL6eUmiyCfJvVnBmIQDKjvYZ2hQHAu3VqFoYfrSIt
 8nqELU7RWjTkeR5CiO/Rqe8upVs2vxUWwJ/tsyVCOsCIU2Qncql5YG3S6GNFZ8FGdyax
 cxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684420523; x=1687012523;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7laxQvselTFgPc8ahAoxVSv6VFklyi9ZezIofVcIlA=;
 b=c+Vkb3LeQRNOZKRs26Q1kLuu0FQJrt0vxrnTvbeZqKnnm0clu865CJenNuhFT3HqJ8
 pHVXJCtoahXAET9F7sLQkG91LyOJpqVvNB5xvCTX4Kz7TUetYijcP2BORxczQz6fGhMR
 nTZNz0VbKLSjy3HqU+TKOaCWOCo0CKzQc9UOOn6LvDrk4Tw7WevR8CZ+DYfLmPLw3idN
 JRmDEVzYeBexO2HmNXKz734YxVrxSgOYWOyGrdePYZ1y9utWj+tlOXOiOVkOi/ac0YFU
 NXL4gVPsf80FKGOQy88Y09Q3ddwtBcmSIR+lPUeBPrBTY61Y0oFyZ87dXJ+YaJTlLiod
 n2OA==
X-Gm-Message-State: AC+VfDw7/XcVmh9vRLQhIkLfm78p4141ygPHw3gUuEftRj9C9j/wUPs6
 MGwTjm+FLG2SCIRHRIhZwoFMtnYequaV96ptCdgOKSgeZnc=
X-Google-Smtp-Source: ACHHUZ4927aCjRNV2iXjL1JJ5VKLEP/zhtgBaCX4fgrjXlmE7vrMpyW0yWqdGqKx/o8NRpg/azZ1XbyQpA2aOKCiyFY=
X-Received: by 2002:a05:622a:44b:b0:3f6:837f:79c9 with SMTP id
 o11-20020a05622a044b00b003f6837f79c9mr5890583qtx.26.1684420522562; Thu, 18
 May 2023 07:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANamGFG1Lq+QSMshgYChj663K=Sj19YEh8WP=HWYM6HBnpRpWw@mail.gmail.com>
 <CAFEAcA83RoCWzZD3pOdJndtRYynf7j0GwTEZCfOz6uOv5fybnQ@mail.gmail.com>
In-Reply-To: <CAFEAcA83RoCWzZD3pOdJndtRYynf7j0GwTEZCfOz6uOv5fybnQ@mail.gmail.com>
From: ido berenbaum <ido.ber3@gmail.com>
Date: Thu, 18 May 2023 17:35:11 +0300
Message-ID: <CANamGFFb_zwkAe0+VRfj7daL0CSs4-hS5SX-GRSmG2kJJCLV0Q@mail.gmail.com>
Subject: Re: Gpio in vexpress
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e6574c05fbf8b642"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=ido.ber3@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000e6574c05fbf8b642
Content-Type: text/plain; charset="UTF-8"

Oh, I was under the impression the vexpress board is not based on a real
physical hardware like virt.
In any case, In my workplace we use the qemu for our CI testing, to prevent
the need to use our hardware for logical tests.
The thing is our SoC is not implemented in qemu, and so we are using the
vexpress as it is similar enough when considering the core structure.
But, as it is not identical we need to make changes to make it fit our use
cases. For example, add a gpio.

Do you think we should use a different SoC as a base for our development?

On Tue, May 16, 2023, 12:17 Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 16 May 2023 at 07:36, ido berenbaum <ido.ber3@gmail.com> wrote:
> >
> > Hi, I was trying to understand the architecture of the vexpress virtual
> machine in regards to adding new gpios that are going to be external.
> > First, is it right to act as if I am developing on a physical board and
> add the gpios to the VexpressMachineState struct?
> > Secondly, which gpio type fits here? I see that for fsl_imx7 it is the
> imx_gpio, but what is for vexpress? Should I create one?
> > Or, can I use pl061?
>
> The vexpress is a model of a real piece of hardware, so the
> answer is "you model what the real hardware is doing". You
> should be able to find that out in the technical reference
> manual for the board / daughterboard.
>
> Why are you interested in the vexpress in particular?
> It is a pretty elderly development board...
>
> thanks
> -- PMM
>

--000000000000e6574c05fbf8b642
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Oh, I was under the impression the vexpress board is=
 not based on a real physical hardware like virt.</div><div dir=3D"auto">In=
 any case, In my workplace we use the qemu for our CI testing, to prevent t=
he need to use our hardware for logical tests.</div><div dir=3D"auto">The t=
hing is our SoC is not implemented in qemu, and so we are using the vexpres=
s as it is similar enough when considering the core structure.</div><div di=
r=3D"auto">But, as it is not identical we need to make changes to make it f=
it our use cases. For example, add a gpio.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Do you think we should use a different SoC as a base for=
 our development?<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, May 16, 2023, 12:17 Peter Maydell &lt=
;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noref=
errer">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Tue, 16 May 2023 at 07:36, ido berenbaum &lt;<a href=3D"ma=
ilto:ido.ber3@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">id=
o.ber3@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi, I was trying to understand the architecture of the vexpress virtua=
l machine in regards to adding new gpios that are going to be external.<br>
&gt; First, is it right to act as if I am developing on a physical board an=
d add the gpios to the VexpressMachineState struct?<br>
&gt; Secondly, which gpio type fits here? I see that for fsl_imx7 it is the=
 imx_gpio, but what is for vexpress? Should I create one?<br>
&gt; Or, can I use pl061?<br>
<br>
The vexpress is a model of a real piece of hardware, so the<br>
answer is &quot;you model what the real hardware is doing&quot;. You<br>
should be able to find that out in the technical reference<br>
manual for the board / daughterboard.<br>
<br>
Why are you interested in the vexpress in particular?<br>
It is a pretty elderly development board...<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div></div>

--000000000000e6574c05fbf8b642--

