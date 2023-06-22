Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB973A1D5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKJG-0006Ba-M3; Thu, 22 Jun 2023 09:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qCKJF-0006BP-4f
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:25:13 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qCKJD-00072M-EO
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:25:12 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f954d78bf8so4429699e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687440306; x=1690032306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QH2+qTEywL+QIAQFNalSE1GaTvMf+6clGri0//KwB84=;
 b=k4+BlrbXWqT/mm1Fu1YIU0TnNSIjDZZTChWQtqlw4VK9pdNHPZ8iiGgTCbfhh6pIcU
 lPw+DlWWVLScXBuU/wFzY4wLGEeIUd4yOu4mhBd0mirM/Uob27tismwOoneNA/mRg8yA
 d9ySQwZKzJOyn1n2C4S1z3ip9gO8re4ySOsvt9k3b1rmbQvQwnF0d6R3e9XNCW8nBw81
 iNvphZEMuNSExdlbUKaf5+qOPqczNywUzbWRJmbXL2bpXzc3B+RbC1zU8APQ093EOVm6
 /G9VJrTRCK+mCCn1qcjDxRgmzet5u6BSrQfSBq6FNJzq9/pYc8RspLfv1971Y2QgNS9d
 hwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687440306; x=1690032306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QH2+qTEywL+QIAQFNalSE1GaTvMf+6clGri0//KwB84=;
 b=gL9tLcqaF7+vTesSox0yD/bmdnoCqZvoOpzivBDmeowuW6DcDcttDCK+0IqagoFNa1
 ET6xkRChNYPbLmqFlxEAzwTaFyYwf97FWdvmmVSt6j0NkJF+PwTqZVaFbRMk62f8ivLM
 Rm1C5ZOk5cB8eAN3KEdWATTHIW5UjtbzDGXiN3huW6jIRs4YHHgz+EjASY9Pd6Co3MiY
 zr10TIabbWCw8Fblt1hq766Okm4gsR8MJPupK6X7C5wVCZz9e9odDA0jO+/xiT17XH7M
 fG2VeLnkB2zfsW0aftPU5QHRP50AADy0Rsb6dzSBfrt6tXWhcK9viBIHjy6w+YG3gfpw
 gcNA==
X-Gm-Message-State: AC+VfDxGJsnDolfJE8cVz/C0PaEr3h1HO+fq6tbKTsb+7lvNJirL8HwF
 qAPZoC8TP/t8eKbYJy1tPjIglMzebmtFYagBHlbyyM04OVAoCbXL
X-Google-Smtp-Source: ACHHUZ76zRMdkZRZSHXYZOgzTyVk/E6pa5Eskow0s4KLhXmsNkCuTklcGMkoek/Pj+1dRro+TEP7sIbvwzdHCv+DXoA=
X-Received: by 2002:a19:f246:0:b0:4f7:4170:a5c9 with SMTP id
 d6-20020a19f246000000b004f74170a5c9mr10951648lfk.66.1687440306204; Thu, 22
 Jun 2023 06:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230621211931.29448-1-dongwon.kim@intel.com>
In-Reply-To: <20230621211931.29448-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Jun 2023 15:24:25 +0200
Message-ID: <CAJ+F1CJhDBPHY12xYh74g1t6K+WXhZ2ThKFw09QDNnTNA49RzQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: OUT_OF_MEMORY if failing to create udmabuf
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="00000000000007f59305feb7d02c"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x12d.google.com
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

--00000000000007f59305feb7d02c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 21, 2023 at 11:40=E2=80=AFPM Dongwon Kim <dongwon.kim@intel.com=
> wrote:

> Respond with VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY if it fails to create
> an udmabuf for the blob resource.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66cddd94d9..efe66ca7a3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -635,9 +635,11 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
>              if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
>                  virtio_gpu_update_scanout(g, scanout_id, res, r);
>                  return;
> +            } else {
> +                *error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +                return;
>              }
>          }
> -
>

unrelated style change


>          data =3D res->blob;
>      } else {
>          data =3D (uint8_t *)pixman_image_get_data(res->image);
> --
> 2.34.1
>
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000007f59305feb7d02c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 21, 2023 at 11:40=E2=80=
=AFPM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Respond with VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY if it fails to cr=
eate<br>
an udmabuf for the blob resource.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 66cddd94d9..efe66ca7a3 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -635,9 +635,11 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!virtio_gpu_update_dmab=
uf(g, scanout_id, res, fb, r)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_up=
date_scanout(g, scanout_id, res, r);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *error =3D VIRTIO_=
GPU_RESP_ERR_OUT_OF_MEMORY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br></blockquote><div><br></div><div>unrelated style change</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D res-&gt;blob;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D (uint8_t *)pixman_image_get_data=
(res-&gt;image);<br>
-- <br>
2.34.1<br>
<br>
<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &l=
t;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.co=
m</a>&gt; <br></div></div><br clear=3D"all"><br><span class=3D"gmail_signat=
ure_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-A=
ndr=C3=A9 Lureau<br></div></div>

--00000000000007f59305feb7d02c--

