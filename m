Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BC73DDF8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkeA-0004jJ-Jd; Mon, 26 Jun 2023 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDke8-0004j4-Cy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:44:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDke6-0008U0-MZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:44:40 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb41682472so1629404e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687779876; x=1690371876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg+RrOQiAT/pqFj2Nj+Bi+ew2HmbVvFwfbRFztC46zE=;
 b=F6b6ZzSdBLmi0ecpYrfbIhDus+6WdhxNtzjXZ9+YDaGGKUmYMENCqrJRDFKH1SpMDm
 934StN/FTES6XppMLRvIzwDOlFIZmE/XHyVSSfjerYzyhF/ZWIeSgN19G/lW8ju5pcxa
 /F4776Y7eac2m/MiMJ8PoFKS317cP3MtmR3TkI3oLEWdDfQpIQVujo/hLqh+yRpE6UIp
 iOIbPJc/iaRkEg964TN5dl+sNUQ+NtClSZohUMtkQ1C3cFTMV0AjrWnu3/xKCmYd9wcF
 maYLi93E61RY4BVqeM+NbgfFrB/J1oi1VHru+CBBgT1C3yU0IjBv+hxej3S8URZFH19B
 QrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687779876; x=1690371876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tg+RrOQiAT/pqFj2Nj+Bi+ew2HmbVvFwfbRFztC46zE=;
 b=XhgnCDHYIgsjh6nq+oCFDWUFMo0q2lJsQ/YxQoY1Qd2Y7WgqZPD+VzxDQHjNbLJFHM
 P6n/tnrLN5k4cfw2V3DcN6B3bnN3lkn28N225xFjnA5dOb0wu+cj+xogilxJItlOAgMi
 jNckC2REk12CjpNNBX72kxmxVXZ0v5WeWI8hcG/2NoZt+v73/HCEx7kHNaIurqykTLMy
 /OkgWdFtzPP4CXWyNFDOtMJmk1zue2/5IuRqVS1alTCYwdjMu96yteJ8+oYp89syswbP
 xe/CqJnR7grTqrZDi8nXRb0FW8OdqgU6Z38FC12C6XgJiUSBx7OGLciUJaFgCMav4GAG
 iMCw==
X-Gm-Message-State: AC+VfDzCKYpSe6hgCoTHWrmDLxzkbqqjLofKSKMHBTZLLbqfrKUjZ8SR
 QMMekPlgxs9uKeICeHzHa5DJl5Cr+KQmUcJVv8DBO6FRsD0WtzrY9SY=
X-Google-Smtp-Source: ACHHUZ5TazOQS9XZ07z8g5hlSk7g+xlGvRlJk2uZwIAGvy/SZNmGHvZbFpEx+sCNzFnSUe1bRszlw0dsLi9jdvqhb6E=
X-Received: by 2002:a19:5e42:0:b0:4f7:5e8b:2acf with SMTP id
 z2-20020a195e42000000b004f75e8b2acfmr16399447lfi.44.1687779875414; Mon, 26
 Jun 2023 04:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621222704.29932-1-dongwon.kim@intel.com>
In-Reply-To: <20230621222704.29932-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Jun 2023 13:44:24 +0200
Message-ID: <CAJ+F1CLVFWOzNx-bd99N=R+-bEHA4WTxm3zjNhAHqkdBe=eUHA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-udmabuf: create udmabuf for blob even when
 iov_cnt == 1
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000eee93505ff06df88"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x130.google.com
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

--000000000000eee93505ff06df88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 12:47=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com=
> wrote:

> There were often cases where a scanout blob sometimes has just 1 entry
> that is linked to many pages in it. So just checking whether iov_cnt is 1
> is not enough for screening small, non-scanout blobs. Therefore adding
> iov_len check as well to make sure it creates an udmabuf only for a scano=
ut
> blob, which is at least bigger than one page size.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu-udmabuf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-udmabuf.c
> b/hw/display/virtio-gpu-udmabuf.c
> index 69e2cf0bd6..ef1a740de5 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -132,7 +132,8 @@ void virtio_gpu_init_udmabuf(struct
> virtio_gpu_simple_resource *res)
>      void *pdata =3D NULL;
>
>      res->dmabuf_fd =3D -1;
> -    if (res->iov_cnt =3D=3D 1) {
> +    if (res->iov_cnt =3D=3D 1 &&
> +        res->iov[0].iov_len < 4096) {
>          pdata =3D res->iov[0].iov_base;
>      } else {
>          virtio_gpu_create_udmabuf(res);
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000eee93505ff06df88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 22, 2023 at 12:47=E2=80=
=AFAM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">There were often cases where a scanout blob sometimes has just 1=
 entry<br>
that is linked to many pages in it. So just checking whether iov_cnt is 1<b=
r>
is not enough for screening small, non-scanout blobs. Therefore adding<br>
iov_len check as well to make sure it creates an udmabuf only for a scanout=
<br>
blob, which is at least bigger than one page size.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu-udmabuf.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabu=
f.c<br>
index 69e2cf0bd6..ef1a740de5 100644<br>
--- a/hw/display/virtio-gpu-udmabuf.c<br>
+++ b/hw/display/virtio-gpu-udmabuf.c<br>
@@ -132,7 +132,8 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_r=
esource *res)<br>
=C2=A0 =C2=A0 =C2=A0void *pdata =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0res-&gt;dmabuf_fd =3D -1;<br>
-=C2=A0 =C2=A0 if (res-&gt;iov_cnt =3D=3D 1) {<br>
+=C2=A0 =C2=A0 if (res-&gt;iov_cnt =3D=3D 1 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;iov[0].iov_len &lt; 4096) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata =3D res-&gt;iov[0].iov_base;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_create_udmabuf(res);<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000eee93505ff06df88--

