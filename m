Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583E7ADC51
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknqk-0006hi-Ce; Mon, 25 Sep 2023 11:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknqd-0006gv-UM
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:50:13 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qknqa-0004E9-2N
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:50:10 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50435a9f800so9516067e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695657005; x=1696261805;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KN/hpbItVITO9IFpAGMvkt34Wujnf/yft5Y7JxmLhrY=;
 b=U/iTyRWP8LLYNRBJJ2e4Bp6SAe5iXpIHoG2TFDXbuMAXv+NUPSdBzW7DTsCRgeOsdP
 BCFpdMy9VcDFmh4iDSUfT8JaVA6vCywzumX/HLLfWvX/dW1R3XkRpDqyGxybmXmu0Tkr
 2ui7YJCJkCtalrUiHMj7gZiSWgGl0pdKiHTlc2Uw3y1a3WE05wlK+W1N4QC5axC+XfOQ
 q97bc2CPo36gnVrGprZTy+z4nibgH0Bu8BU1pso4yShySUwgStCL1ENSJeQJZUNNF/pl
 CHc3UlJBLiMK7CRvO5bEXrNXSnZ/aUhkaSoo+PQk7CDl+bQh6gcdVXoQllvc6XsUo7Vw
 xgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657005; x=1696261805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KN/hpbItVITO9IFpAGMvkt34Wujnf/yft5Y7JxmLhrY=;
 b=rq/ZkHokkx18BRqv9CpQJZWbFhBn7E4pY6z4g3IGtK+6evrFV25Ug9iK3KwaOWj3Op
 lBloJ/zmztJDjE3/ahht6yI24GICzdyu+MGHBWTzlXJu8L6WlyZczNYMGgzBO2R64gKS
 3VngWu3hakdEvFQ+pMvGKm9EHIBNAtQMkC1q5YvdfgmfjNuntWkLee41I7rRGka2l4eE
 kiL5XYXa88LwXQ05qArlslLA/JU/5Jrjk6jGDw1H8o5xm32YmkmQJaR+oWw2/IhWV1JR
 X0RsgMcuzAqAUgsk8a2O0Lfyw0B7tYvCgBHeVOYytKpcXsSCuQFEDvT1I8wsHpiBkeg7
 MUFw==
X-Gm-Message-State: AOJu0YyH2DOzlxl0fVVluBUrs+JkQYcWJ/ACF0BKSHnoR0UYGnB3/lJK
 jSdTYnYZswadlzg9GROfxXjlivoTEOjPe9OwsBCAOA==
X-Google-Smtp-Source: AGHT+IHc5FeqlCNbtWAUPn820WtI9chgqyDB+A3bxSwYVomCJAq9qDVL6tX9kDSBxU8W1/8XYWJhw5+ngCuvmyrkrLg=
X-Received: by 2002:a05:6512:108d:b0:500:b553:c09e with SMTP id
 j13-20020a056512108d00b00500b553c09emr7251582lfg.32.1695657004354; Mon, 25
 Sep 2023 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
 <20230924210136.11966-22-kariem.taha2.7@gmail.com>
In-Reply-To: <20230924210136.11966-22-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 Sep 2023 09:49:53 -0600
Message-ID: <CANCZdfrN_K2mQmsfFB57KJ6J1Wa4V8oHJd7oyo8fPw-gZWoiqw@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] bsd-user: Implement procctl(2) along with
 necessary conversion functions.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000067e55b060630e9e0"
Received-SPF: none client-ip=2a00:1450:4864:20::12e;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12e.google.com
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

--00000000000067e55b060630e9e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 8:36=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and
> h2t/t2h reaper_kill conversion functions.
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/freebsd/os-proc.c    | 222 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |   3 +
>  2 files changed, 225 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

This appears to line up, but if Richard has time for only one review, this
one would be the best place to spend it in case there's something both
Karim and I have overlooked.

Warner

--00000000000067e55b060630e9e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 24, 2023 at 8:36=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Implement t2h_procctl_cmd, h2t_reaper_status, h2t_reaper_pidinfo and h2t/t2=
h reaper_kill conversion functions.<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 | 222 +++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 =C2=A03 +<br>
=C2=A02 files changed, 225 insertions(+)<br></blockquote><div><br></div><di=
v>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp=
.com</a>&gt;</div><div><br></div><div>This appears to line up, but if Richa=
rd has time for only one review, this one would be the best place to spend =
it in case there&#39;s something both Karim and I have overlooked.</div><di=
v><br></div><div>Warner=C2=A0</div></div></div>

--00000000000067e55b060630e9e0--

