Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060F7A354B
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 13:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpa5-0007nl-QC; Sun, 17 Sep 2023 07:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpa3-0007kN-Qg
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:04:47 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhpa2-0005gM-38
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 07:04:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-530a6cbbb47so2009799a12.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694948685; x=1695553485;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=grHZbyL3ERhe2yXr8z9NS4yiyeT3YygMf+Lgujy7oSQ=;
 b=S+a282+sDxHOD+RrCbZd4Dr2tOLLYCCh3aWMgnfUZ6/vNr9dsCrOrAWJOO+rAq8EkS
 De1wLu8qSaPXlYsC3KLyjUiVWC/0pWU+y+3K4NxJUn1hSsGo6RddlyDi0fRokRhMQfho
 evrzsM0a5aLOkapQEp8zBZNf2tQGnKFmetMrfgRqjF8PHPJXADL16xZeDrVpi8ipeJt+
 EATOfskgelw48M57sSVTHHai9Sb7qEXYvIwPw0wxXm4WH1K/eHxb1KlBYvjJxiWYCGlU
 woj2KJHw6y0g4u+ehu3g/Xv6gfsB4L6cj0wEBUQQfTVlMBcL2jeWXTiHMKgeLASreSk9
 kl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694948685; x=1695553485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=grHZbyL3ERhe2yXr8z9NS4yiyeT3YygMf+Lgujy7oSQ=;
 b=t0Ybr5FIeFvAoOJvdukBDzcGByFvIo46hmblIJlUlr6luFZWNLYJ+VpeS2zMSoLoXu
 S9tS4G0HHc4fqeZUBmxOtYU2gTnRuBPzwVLVBmzl61N7VD7jhBqiPbUwxjcCTcPvgNUy
 f2UmpxYj5VXU4iGyBSyfFOZoJMGoX6sO+nKHkEYYy66GTWK+mzNdvYLXUPiy9fE9ufOL
 u1u/QQ5ki5a/yTgR3iuZeGXp7ICKqPTiPDEjJCrkdIuEoN8nSS7f2DfeSbW8r6GbpvCs
 Bh/8MOTurj+vrf0gBrkB+FvecdeqbGO6yqmA6whUf3M04qTu/ZSN8rY9PakhLAo6yJGJ
 PZhQ==
X-Gm-Message-State: AOJu0Yx3F59gGVv397B3utntY/JV2j6BsPJshEfxE/rhraAgQY4Try+3
 jUeY9GtsZuQnOO21K/Ja2U1k7TlNJz/JpnVnHoVuZg==
X-Google-Smtp-Source: AGHT+IH6PTxr7kBG56HOKKX+bN7L9kimo6VkWYZNfJGgfXgky4jV9zc2ckuHQq4AjHrAyGTBtTh5Y01e8UG8PfDqJSY=
X-Received: by 2002:a05:6402:352:b0:51e:5251:8f45 with SMTP id
 r18-20020a056402035200b0051e52518f45mr5346913edw.4.1694948684851; Sun, 17 Sep
 2023 04:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-19-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-19-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 12:04:33 +0100
Message-ID: <CANCZdfooUqzCtEB4318jB126H_bO=rnNEQBmu8tCphHzF7XSYA@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] bsd-user: Implement do_obreak function
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000046021f06058bfebc"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
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

--00000000000046021f06058bfebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Match linux-user, by manually applying the following commits, in order:
>
> d28b3c90cfad1a7e211ae2bce36ecb9071086129   linux-user: Make sure initial
> brk(0) is page-aligned
> 15ad98536ad9410fb32ddf1ff09389b677643faa   linux-user: Fix qemu brk() to
> not zero bytes on current page
> dfe49864afb06e7e452a4366051697bc4fcfc1a5   linux-user: Prohibit brk() to
> to shrink below initial heap address
> eac78a4b0b7da4de2c0a297f4d528ca9cc6256a3   linux-user: Fix signed math
> overflow in brk() syscall
> c6cc059eca18d9f6e4e26bb8b6d1135ddb35d81a   linux-user: Do not call
> get_errno() in do_brk()
> e69e032d1a8ee8d754ca119009a3c2c997f8bb30   linux-user: Use
> MAP_FIXED_NOREPLACE for do_brk()
> cb9d5d1fda0bc2312fc0c779b4ea1d7bf826f31f   linux-user: Do nothing if too
> small brk is specified
> 2aea137a425a87b930a33590177b04368fd7cc12   linux-user: Do not align brk
> with host page size
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-mem.h            | 45 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  7 ++++++
>  2 files changed, 52 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000046021f06058bfebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Match linux-user, by manually applying the following commits, in order:<br>
<br>
d28b3c90cfad1a7e211ae2bce36ecb9071086129=C2=A0 =C2=A0linux-user: Make sure =
initial brk(0) is page-aligned<br>
15ad98536ad9410fb32ddf1ff09389b677643faa=C2=A0 =C2=A0linux-user: Fix qemu b=
rk() to not zero bytes on current page<br>
dfe49864afb06e7e452a4366051697bc4fcfc1a5=C2=A0 =C2=A0linux-user: Prohibit b=
rk() to to shrink below initial heap address<br>
eac78a4b0b7da4de2c0a297f4d528ca9cc6256a3=C2=A0 =C2=A0linux-user: Fix signed=
 math overflow in brk() syscall<br>
c6cc059eca18d9f6e4e26bb8b6d1135ddb35d81a=C2=A0 =C2=A0linux-user: Do not cal=
l get_errno() in do_brk()<br>
e69e032d1a8ee8d754ca119009a3c2c997f8bb30=C2=A0 =C2=A0linux-user: Use MAP_FI=
XED_NOREPLACE for do_brk()<br>
cb9d5d1fda0bc2312fc0c779b4ea1d7bf826f31f=C2=A0 =C2=A0linux-user: Do nothing=
 if too small brk is specified<br>
2aea137a425a87b930a33590177b04368fd7cc12=C2=A0 =C2=A0linux-user: Do not ali=
gn brk with host page size<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 45 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 7 ++++++<br>
=C2=A02 files changed, 52 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div></div></div>

--00000000000046021f06058bfebc--

