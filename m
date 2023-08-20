Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF18781C6B
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaHv-00005D-M6; Sun, 20 Aug 2023 00:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaHt-00004z-Og
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:43:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaHr-0002Ud-LT
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:43:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so282703966b.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506617; x=1693111417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5+XswHuAZwHssPFQKa4sQjLhnDT5jdgQgZrmCCdip3M=;
 b=AU4a4KjamR3VyyJukCtN/S+V2nWUqAxoedMHWAxL35dhWRdSq0eGTD5T8qvujyuNLr
 930meHGHi889/HbJ28Gx0vBQKOoUPuCek/yXbZ/9URBJrliSYHq/VR+AaBBj4QRPb4wN
 A5kt1eESAet7/4XMGxCRgRreOyMz570Rf6yKQc1kmGB1MLh5fLidQ3C1kXl1LUOHfRR0
 ZKbPj8VWo2HTEEM4PCsfLw1iXhHkX5fF4Wj8g8Nrs5uWSDP2tLtV74YdPx+rmHAletwi
 Ufj95OKWd3a7K2/o6QPvyXE3/qwsejryawhQGq4i/o5OOmZHFEU0VG4t9EdlwH1HZiUE
 0uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506617; x=1693111417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+XswHuAZwHssPFQKa4sQjLhnDT5jdgQgZrmCCdip3M=;
 b=TexV7o3x4AmOZ8UGNt2hsvi68NODLCVS1+i6WuC2wraFzCq21MIYXOd0ndljC0H0zm
 KR2GN3pmLu6yLOjn11kUDmJBOREpE5eoM0cWG1abe2CjtYWCRg+pd6Kn3Loomb2Ru/MF
 xHnXiRDYEAAnD/EOgYsp4cixHCS0kC65PavApxTKk7HlnM8ErQqrbTSSEp5xJEWvb5op
 ykX9Bo/NnndhGxv7e3v3BOiss6TUj3vaZOyDhaI45TpzPZjRN12tuMbaF7CaQVT0OtOY
 QiaF5Gqg4F8mcOqZ4x1MTuHh1dMOba1+586vaM98qPnQnmf+RnbIBtOxAAV/qE/bX2TX
 FqaQ==
X-Gm-Message-State: AOJu0YxHJVZDTSi813PmHFa8ul0B4j4h1Nio2WFjz3Q6mYriU49eQAaB
 UkT1PK8L9wlWxczvAC5iClSDSfoYlIgIQr7Ucy8yA4hP08k0LiCNM+w=
X-Google-Smtp-Source: AGHT+IFzi2VClZZGJjLQbwQGtHaa70pTg3uB8OD3CwgWmyJPKxdo4jMCcfQtrTqcPkQvwoaWgZne1LHW65FUT2AvWdQ=
X-Received: by 2002:a17:906:18c:b0:99c:ae35:8cd with SMTP id
 12-20020a170906018c00b0099cae3508cdmr2753043ejb.43.1692506617607; Sat, 19 Aug
 2023 21:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-21-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-21-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:43:30 -0600
Message-ID: <CANCZdfruRBZD71MDRFtJCXw31BDXWAmujxz_12+uT1-_+5f9dQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] Implement shmctl(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b90744060353670e"
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x636.google.com
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

--000000000000b90744060353670e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 33 +++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 37 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000b90744060353670e
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
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++=
+++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 37 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000b90744060353670e--

