Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E4781C66
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaCU-0005a2-1l; Sun, 20 Aug 2023 00:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaCL-0005V1-P4
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:37:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaCJ-0001i0-Ij
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:37:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99c4923195dso281984566b.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506274; x=1693111074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tyxYCZBOBFR9oI07SQJuQT8susKjPcQ2VXyPvoTm1Vc=;
 b=JZn0zxRjvjkFZjZ9ccLSUTySANwIz9yB74YpiZdmELsjWMJSYipvkHfocIt+h81aRM
 algtWVceF2/+xdMp7iPJJawx6tJXbZxfKdjhhoac1UIfpHjZmM8ApCTSfNsrzSSwPS8j
 M4K94zBdJiJ2FbjvkWyX1D9Ff4tLfCTeZWvJcbuOg/95y+dgudO2jnPP+YL0OSsKNWKs
 YyCoSMrm3iaxGtyXzTpeHKJXjtbJNclKZmZwWl5wB+FgsTIRdBIPnKufw1ZdKeyBfDRT
 rxVoIvN+tmQ8OxKjChnH7fg/LGlaKv0JrfisnzfoV/LZ8YOzmpbD28NVFYnp1FexThNz
 BC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506274; x=1693111074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyxYCZBOBFR9oI07SQJuQT8susKjPcQ2VXyPvoTm1Vc=;
 b=BHLDH0YrtnfCuty3Xsdy6Cs0dbx8CoWU4wUAKiHgWOjFp8UUbcr658krW1ilFc0dmH
 vr/FBHMQzdwhvnIzQdmJgOU6NkM3HpdqQU2W6DVeZO13TYnGkrieesdR774TPfjvn5hs
 B5UBUUSfbHwp/dv7XLI91RODVkiGdb1/skOA48mvOhBjMLrpzGgKA/uvHSVgxZiAqHnh
 eJX6DmsMDWskWtcaIUkuGi8AVYZbnJRoMgnHzDtdtwxPo955BBqYO3NOW5T/IYHL9zNN
 WDtYEwDm4DbioiJsghTd9gp8uDLKhnFRGCliGDgf1IiplzLdApHWuCqIx0aK9dqVyoTY
 liZQ==
X-Gm-Message-State: AOJu0YyVtslX795YdquWrAes1DzfSZktHhegkeSzS/oPusK5X15lF66m
 ZifOk9TZfy8w5WKEh1QrJZU+O7HTBOSvJlRjVAMU8Q==
X-Google-Smtp-Source: AGHT+IEAbyKZlZQ6MebSodOCgvaFntfLhDbeU+s6CrM3wGTW1JmLEgrfIald5sh9IUbhJ7y5GBcEPicXx2GG2JtfzJU=
X-Received: by 2002:a17:906:dc:b0:94e:4489:f24d with SMTP id
 28-20020a17090600dc00b0094e4489f24dmr2491252eji.61.1692506274285; Sat, 19 Aug
 2023 21:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-17-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-17-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:37:47 -0600
Message-ID: <CANCZdfoZMMKmBDc5V-eUCSRyLsf4X2-iZsxGLrEgqocb+J4-1A@mail.gmail.com>
Subject: Re: [PATCH 16/22] Implement mincore(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000425d9b0603535391"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
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

--000000000000425d9b0603535391
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 27 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000425d9b0603535391
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 ++++=
+++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 27 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt; <br></div></div></div>

--000000000000425d9b0603535391--

