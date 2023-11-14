Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA97EB8EE
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 22:49:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r31GZ-0003Z1-K9; Tue, 14 Nov 2023 16:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r31GX-0003Ys-Qc
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:48:13 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r31GU-0007cL-Ro
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:48:13 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-545557de8e6so5066a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699998487; x=1700603287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=589yOBCrxeQ30NyE1oNk2MVFSh62gkuS196woEBeR/k=;
 b=vPcF4QTvXknYjma08AlY4amKAbjcGMxaXJdGdIP2sn6FDqKSoyYXDVLjnEHT7IYT5V
 NG4pdXUKDlm9E0ohA12gOSWHhBZiqhsy7RGIoXdgqOrdfaNFxAcaZbMHwMf+6lIq9kRq
 AlPruBIYyvsU2vF99SN1f+XkMNWP5NsVkjBxeHz240HqV8UKn4UYr7D5j6suwk/TfEVH
 cKG+WgFgA3gz8mXk4pssKM3vELkzLN2thjtMMTqYif5dfaTZGhU2yXDJiLUxtb29J8rK
 wE6EZr9d28mHN11ztl+9Mo3xeCOrujq6qesNb2ezDbOknudmv388R5HQfQXC538buQuM
 Uspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699998487; x=1700603287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=589yOBCrxeQ30NyE1oNk2MVFSh62gkuS196woEBeR/k=;
 b=qVEeNDRfHPDUNOqvwpguOPcvAuZ9PgLEsoVa58+N0xxn7Dc7CdSiBlyLLFjRQLRLR0
 i7zUZWVR8OgnYIgNVsy3DQYIsSHiUg74dlUbuJBtGiZAMoDp9HxlhYY0HjlIPILuI7TK
 uwLcp4nGep2nQ1KXLIL/H0PNis3ZLRWXPqRgUwpS7LA638y/BVCxzDgDMLOjmbvsG2tj
 ArGEP+eFI9Wfs7+sLoYiL6pELaFOTcIsiJXgsMK8Z0WBWu/8igCzPluGZ9ip0++1wBZ3
 EuSkqd3fsKDJbfgfuVSe61iPi48fOnkgd3ho7kdRM0yILkoUFq7+ipzriV078CM5Ur08
 fWrw==
X-Gm-Message-State: AOJu0YwIz/37OjGfRX8x6b3oGR3sSYZhAf8vWHA/kQPV8D9mDG3Isj98
 PVJRXJnXkus6v1vZJDsWr4+JlbFy+xK5stobVl98B7yhOrmqeNeAVuAEaA==
X-Google-Smtp-Source: AGHT+IEfeYyE+L9p/FHTt1xDUyzgrjqegrGd7A0yqEyI3s+LCBCZ24XYRtWkJOzMzkm3EDoNixCJGflLRd4NwmcRgwY=
X-Received: by 2002:a05:6402:3712:b0:547:9b49:f221 with SMTP id
 ek18-20020a056402371200b005479b49f221mr48445edb.6.1699998487230; Tue, 14 Nov
 2023 13:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
In-Reply-To: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
From: Patrick Venture <venture@google.com>
Date: Tue, 14 Nov 2023 13:47:54 -0800
Message-ID: <CAO=notx53PD6E731PB2oCyu6dSuKA=fT+R+datSPnOAQuVVfJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/i2c: add pca9543 i2c-mux switch
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f3bab6060a23bdbd"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=venture@google.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000f3bab6060a23bdbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 10:34=E2=80=AFPM Potin Lai <potin.lai.pt@gmail.com>=
 wrote:

> Add pca9543 2-channel i2c-mux switch support.
>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
>

Reviewed-by: Patrick Venture <venture@google.com>


> ---
>  hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
>  include/hw/i2c/i2c_mux_pca954x.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index db5db956a6..6aace0fc47 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -30,6 +30,7 @@
>
>  #define PCA9548_CHANNEL_COUNT 8
>  #define PCA9546_CHANNEL_COUNT 4
> +#define PCA9543_CHANNEL_COUNT 2
>
>  /*
>   * struct Pca954xState - The pca954x state object.
> @@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t
> channel)
>      return pca954x->bus[channel];
>  }
>
> +static void pca9543_class_init(ObjectClass *klass, void *data)
> +{
> +    Pca954xClass *s =3D PCA954X_CLASS(klass);
> +    s->nchans =3D PCA9543_CHANNEL_COUNT;
> +}
> +
>  static void pca9546_class_init(ObjectClass *klass, void *data)
>  {
>      Pca954xClass *s =3D PCA954X_CLASS(klass);
> @@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] =3D {
>          .class_init    =3D pca954x_class_init,
>          .abstract      =3D true,
>      },
> +    {
> +        .name          =3D TYPE_PCA9543,
> +        .parent        =3D TYPE_PCA954X,
> +        .class_init    =3D pca9543_class_init,
> +    },
>      {
>          .name          =3D TYPE_PCA9546,
>          .parent        =3D TYPE_PCA954X,
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h
> b/include/hw/i2c/i2c_mux_pca954x.h
> index 3dd25ec983..1da5508ed5 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -3,6 +3,7 @@
>
>  #include "hw/i2c/i2c.h"
>
> +#define TYPE_PCA9543 "pca9543"
>  #define TYPE_PCA9546 "pca9546"
>  #define TYPE_PCA9548 "pca9548"
>
> --
> 2.31.1
>
>

--000000000000f3bab6060a23bdbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 12, 2023 at 10:34=E2=80=
=AFPM Potin Lai &lt;<a href=3D"mailto:potin.lai.pt@gmail.com">potin.lai.pt@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Add pca9543 2-channel i2c-mux switch support.<br>
<br>
Signed-off-by: Potin Lai &lt;<a href=3D"mailto:potin.lai.pt@gmail.com" targ=
et=3D"_blank">potin.lai.pt@gmail.com</a>&gt;<br></blockquote><div>=C2=A0</d=
iv><div>Reviewed-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.c=
om">venture@google.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
---<br>
=C2=A0hw/i2c/i2c_mux_pca954x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++=
++++++<br>
=C2=A0include/hw/i2c/i2c_mux_pca954x.h |=C2=A0 1 +<br>
=C2=A02 files changed, 13 insertions(+)<br>
<br>
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c<br>
index db5db956a6..6aace0fc47 100644<br>
--- a/hw/i2c/i2c_mux_pca954x.c<br>
+++ b/hw/i2c/i2c_mux_pca954x.c<br>
@@ -30,6 +30,7 @@<br>
<br>
=C2=A0#define PCA9548_CHANNEL_COUNT 8<br>
=C2=A0#define PCA9546_CHANNEL_COUNT 4<br>
+#define PCA9543_CHANNEL_COUNT 2<br>
<br>
=C2=A0/*<br>
=C2=A0 * struct Pca954xState - The pca954x state object.<br>
@@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t cha=
nnel)<br>
=C2=A0 =C2=A0 =C2=A0return pca954x-&gt;bus[channel];<br>
=C2=A0}<br>
<br>
+static void pca9543_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 Pca954xClass *s =3D PCA954X_CLASS(klass);<br>
+=C2=A0 =C2=A0 s-&gt;nchans =3D PCA9543_CHANNEL_COUNT;<br>
+}<br>
+<br>
=C2=A0static void pca9546_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Pca954xClass *s =3D PCA954X_CLASS(klass);<br>
@@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D pca954x_clas=
s_init,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.abstract=C2=A0 =C2=A0 =C2=A0 =3D true,<b=
r>
=C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_PCA9543,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_PC=
A954X,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D pca9543_class_ini=
t,<br>
+=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_PCA9546,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_PCA954X,<br>
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca9=
54x.h<br>
index 3dd25ec983..1da5508ed5 100644<br>
--- a/include/hw/i2c/i2c_mux_pca954x.h<br>
+++ b/include/hw/i2c/i2c_mux_pca954x.h<br>
@@ -3,6 +3,7 @@<br>
<br>
=C2=A0#include &quot;hw/i2c/i2c.h&quot;<br>
<br>
+#define TYPE_PCA9543 &quot;pca9543&quot;<br>
=C2=A0#define TYPE_PCA9546 &quot;pca9546&quot;<br>
=C2=A0#define TYPE_PCA9548 &quot;pca9548&quot;<br>
<br>
-- <br>
2.31.1<br>
<br>
</blockquote></div></div>

--000000000000f3bab6060a23bdbd--

