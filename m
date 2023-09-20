Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1A7A8CAB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2je-0007hf-E6; Wed, 20 Sep 2023 15:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2jc-0007gv-Np
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:19:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2jb-0002SQ-71
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:19:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-501bd6f7d11so372163e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695237576; x=1695842376;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ScSMQIvvFvUvNa0xFuJImGBIbtjHjm9BMs0Gk/lKro=;
 b=Rt6PvM5l3IUj+Mnl5akUJx6yAxSfU1W90HT5LrcfpFEI2GeU7UFjIZ1UztZc3MqjwQ
 9DvDPu1GOw/IQWaODpozqwO5dOx7qJzIqF63PxCxbff2LkHxcDH0ihU1+AdQZMdhDzDZ
 VrkT338R9nWA3gCOVAOsfGXYz6SAW2s/ADSzeoPI6Ve+QdQsoK/ifxj72tebE45vBSbN
 z4IpmG4gcDDDs85AtbW5mKkYQIME1jnJHF+rq8l+D77BDLdVUB2N64s4WCLJKpcRo4s7
 yqMzVN3uhPd9MQHByQNwdHhzC4XPKE8UnXPhmF3zxwY4Z3WyT90rAmv1HzJ08D5xoGUK
 v4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695237576; x=1695842376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ScSMQIvvFvUvNa0xFuJImGBIbtjHjm9BMs0Gk/lKro=;
 b=F+I6BBr5sbc3oACvCih0hrHCWu2AYGnfB1mXUd5i7bVyELVugB1SvyYzFOBnRcSscz
 x/FOBCy1HV5xVOGqcj4ePJ4g1m31OuTYjQ3Lp3Kb1YSQrFl2s4cFwWoEoyjOlGEobc72
 CjUVTVfyt+S2AcOOpozlSqDI/TI+LWvd7nWyec5zBEm/tVOddQiBZ4xar+8HRd4+JaVX
 ZXNW5PMHV0bIgiJUdHp2aoOdgd+xm1Q8SwZs1ppYb8x/vPphoxGgpwfmUt8ifkssH9Kb
 MXQ+0sCObZEECDd9SJLqHyOzM/ycMQkVgM8oEuduCDk9+ytZ6OBLIPfBRR7srpkJ++w1
 Q8Nw==
X-Gm-Message-State: AOJu0YyKHJy+UsPEiG1N+uZGJ4HDmmzu06So9p1YyCn2g/4yS3QGa3Y3
 yX2UhkvbYofoPQ2Np7ImAnb81djOEUcnumLgzrxriq7G2Jr8KcDEHgvIZZgv
X-Google-Smtp-Source: AGHT+IHaPFgyW3dQKg1a8xTjc1le+YCthUO5eq+7wtljKkQEn/GfZh7PcT37k6erLfh0c5QSJnYZDQHvt6xEyBi19P8=
X-Received: by 2002:a05:6512:ea1:b0:500:95f7:c416 with SMTP id
 bi33-20020a0565120ea100b0050095f7c416mr3832485lfb.7.1695237576412; Wed, 20
 Sep 2023 12:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-27-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-27-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 20:19:25 +0100
Message-ID: <CANCZdfoFqJi-GU1Yxpwx4aCcuSv2AtmUOGf=6tYrO5w1nSMvQg@mail.gmail.com>
Subject: Re: [PATCH v2 26/28] bsd-user: Implement fork(2) and vfork(2) system
 calls.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000008d673b0605cf41f2"
Received-SPF: none client-ip=2a00:1450:4864:20::12c;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000008d673b0605cf41f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 42 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Though i have minor qualms about vfork =3D=3D fork, for bsd-user it's fine
since I
don't think the performance difference will be that large for the typical
case
where vfork + exec exists for older (now kinda really old) programs that
used
to use this.

Warner

--0000000000008d673b0605cf41f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 | 34 ++++++++++++++++++++++++=
++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 42 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div><br></div><div>Though i have minor qualms about vfork=
 =3D=3D fork, for bsd-user it&#39;s fine since I</div><div>don&#39;t think =
the performance difference will be that large for the typical case</div><di=
v>where vfork=C2=A0+ exec exists for older (now kinda really old) programs =
that used</div><div>to use this.</div><div><br></div><div>Warner</div></div=
></div>

--0000000000008d673b0605cf41f2--

