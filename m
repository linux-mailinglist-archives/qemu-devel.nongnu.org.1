Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2A781C5C
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZvU-0007Tf-VA; Sun, 20 Aug 2023 00:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZv1-0007T6-5p
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:20:03 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXZuy-0006no-M0
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:20:02 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so285147766b.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692505199; x=1693109999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6FP/pVCrdTJl4JfwwRHxwuOF0vdprDXVcv41ApiYuTA=;
 b=5k02I53R7kFIHjwCR6D8teG1MD3f358jD2sZpLDTCMMgDPKyZKS93DxbVe5gzaR0ZU
 l/OZCKEp8L4SjjU1T3RxkCtL2GJ0CT7+3XO7ZGcz1J9PBdfbkcLAGz4Q+UmSAhJcE7OC
 ERxGWIZPTEJUa09lYIZUPmod/b6TpaY4NoepKBi7TGlYXKZNz7s9ux689+oS7Xv5pWgy
 lZk7VFv3RGUWMSvNZWnlcp60mRyhFUs4Y8BeNzVmRNSZY/hwRr6Tl+/KWl4QJuKddG4W
 g0QoPJ+VjFJh33Ql3wY3+qJCVJNqeg3KWJKkbuieYUPA7FPX9Cln+VSUTL8JBK+qaL9/
 Xwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692505199; x=1693109999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FP/pVCrdTJl4JfwwRHxwuOF0vdprDXVcv41ApiYuTA=;
 b=ZU/uqBD7emnjWZoN5YfOwrtCN6lit0+JfCjZP40trrUKTCNqYX0ZClO84i4iuFGA2k
 uR0oKDNLzy9nnJYJk0FCz+G99GVXcH87hbbTOAAdeVbAcNiiqMY47DVMzjS6elZwNtb2
 20nFLd6a9nQYndHLuz5WzEr5uGMe4Pucd1ov4gHxq88e+oRYptOf0TLYq4GByDXATTGn
 C1LE/A1q1Zya9MBuE1/L4Mtt9a1O/bw0vIYqIgiJnvsHsTZ1N5CqR9Gf7sdgQR8GD8bE
 6k4p0d56S71rR2WIxY1JSU/Nd4Hs4klEMobAMP37oHw6UtCsk9SDMtAi+okZD52Ex9Xt
 05Fw==
X-Gm-Message-State: AOJu0Ywhkq7VI1U8pSFbITfcAp8dq/R+Vci9snZBnQpWAWZl/NJPBNAI
 Ogd+p/mR4pOmhlOpAaZppZyDztA2rbe9Tl99aXzJLg==
X-Google-Smtp-Source: AGHT+IEkwCLMrHUANUiOBcCg13DdaPCX62mIzUiAiUdiYdpiEk1DP83X9cCsi0FdegXnkcSE/1dW9yKkhxznycBFIBo=
X-Received: by 2002:a17:906:51d9:b0:99d:9a55:1f5c with SMTP id
 v25-20020a17090651d900b0099d9a551f5cmr3073687ejk.51.1692505199174; Sat, 19
 Aug 2023 21:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-8-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-8-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:19:52 -0600
Message-ID: <CANCZdfoiqEE2QTgdMNT2e2X13tFWSKG69fb2Y-km8NDAjDpndg@mail.gmail.com>
Subject: Re: [PATCH 07/22] Add bsd-mem.c to meson.build
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002d743d0603531363"
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62f.google.com
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

--0000000000002d743d0603531363
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:48=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> ---
>  bsd-user/bsd-mem.c   | 0
>  bsd-user/meson.build | 1 +
>  2 files changed, 1 insertion(+)
>  create mode 100644 bsd-user/bsd-mem.c
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/bsd-user/meson.build b/bsd-user/meson.build
> index 5243122fc5..6ee68fdfe7 100644
> --- a/bsd-user/meson.build
> +++ b/bsd-user/meson.build
> @@ -7,6 +7,7 @@ bsd_user_ss =3D ss.source_set()
>  common_user_inc +=3D include_directories('include')
>
>  bsd_user_ss.add(files(
> +  'bsd-mem.c',
>    'bsdload.c',
>    'elfload.c',
>    'main.c',
> --
> 2.40.0
>
>

--0000000000002d743d0603531363
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:48=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">---<br>
=C2=A0bsd-user/bsd-mem.c=C2=A0 =C2=A0| 0<br>
=C2=A0bsd-user/meson.build | 1 +<br>
=C2=A02 files changed, 1 insertion(+)<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.c<br></blockquote><div><br></div>=
<div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsd=
imp.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c<br>
new file mode 100644<br>
index 0000000000..e69de29bb2<br>
diff --git a/bsd-user/meson.build b/bsd-user/meson.build<br>
index 5243122fc5..6ee68fdfe7 100644<br>
--- a/bsd-user/meson.build<br>
+++ b/bsd-user/meson.build<br>
@@ -7,6 +7,7 @@ bsd_user_ss =3D ss.source_set()<br>
=C2=A0common_user_inc +=3D include_directories(&#39;include&#39;)<br>
<br>
=C2=A0bsd_user_ss.add(files(<br>
+=C2=A0 &#39;bsd-mem.c&#39;,<br>
=C2=A0 =C2=A0&#39;bsdload.c&#39;,<br>
=C2=A0 =C2=A0&#39;elfload.c&#39;,<br>
=C2=A0 =C2=A0&#39;main.c&#39;,<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--0000000000002d743d0603531363--

