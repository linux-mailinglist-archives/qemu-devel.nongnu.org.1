Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D31CE74750A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhhf-000364-6A; Tue, 04 Jul 2023 11:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGhhc-00035t-Tb
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:12:29 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGhhb-0007xx-9z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:12:28 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-401e23045beso45665151cf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688483546; x=1691075546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HOnRI6VRB8Rbm4InpGPWJtwAKxdIdOLDdmbFayzQr9s=;
 b=IazlJWNwgyPSgb8JqKc1CvWxRUmPXfz2jkAL0aMcBPPHHdG2OtEZvHknFxr3SWhC/+
 3+l6whUFdX3ksDCw0DkNAv7RR+bJ/l+1LEy7Zu5mw4U/qL5Hwa8o8X9or4X/k3OwuexW
 XXpZMlszmwyYOuZfQR/bb2ysbxX4T+hMdeLGc+8Px7krHYcp9R6csV082B7AaW4kLShX
 w+L91IQoljsqlgmvTSdWMCmdooxu4XR/l6DwqiT13A575XFEBNSW0T5O0tosg8K/cx+2
 zMwW5AeEwLSff39Emc3L3ShTI6jWhwKw6vncY/JjmDrdeeExBGM5Oavsp4kL3iuJCOOY
 rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688483546; x=1691075546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOnRI6VRB8Rbm4InpGPWJtwAKxdIdOLDdmbFayzQr9s=;
 b=lr7COrqfxZ/Yi1o9VaVbZgyavAGuy6+tOy5KmwmTCPJOKF8wZ6SWLkFPmv+tisiLs6
 2pqxHRL6Eq2k6t7Z3/wdB6rfmMHRkYhKvJQTOtbgmBQPDaK0F5txvejuHzEjUpppWomw
 a30RtAu+vaWduzkflCKSvJNoTBLW7fZ1Ah/rOSCmQbuEOtXZpUZI1EnequZmYcatNyoU
 S7YxEocSidEWSG1jW8I8ksirD/t3rV8RoJQ1mO/3fgdLxC+HkoxrbO9j3UPAo4PxEZb2
 jARAuJX0Wu0QszVCE8UsCWKUGotakwOF3fFjXfcm9IYu/93xqtZZYoKxfN8MADHEYfz5
 XQiw==
X-Gm-Message-State: AC+VfDzzSLEo6vA7c65wWsTwSeCPj+0BSfmG6bHPFWOMyWcnpwVGR0l0
 mdEOhjEAqyXZJYiJzg9DlHt/rCsOObLY+gUxSio=
X-Google-Smtp-Source: ACHHUZ6aBmcXWSYkojdnWpFK/keHRB6T5fz5UQ5EnBZYkeaGTo6/23eEd62fp3SJ4x1IyNnCxzNGAmsr75e3t9gh51Q=
X-Received: by 2002:a05:622a:1649:b0:400:85a8:f844 with SMTP id
 y9-20020a05622a164900b0040085a8f844mr15916125qtj.12.1688483546192; Tue, 04
 Jul 2023 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230627221139.11250-1-dongwon.kim@intel.com>
In-Reply-To: <20230627221139.11250-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 17:12:14 +0200
Message-ID: <CAJ+F1C+b8OXuTVS7oVdP+pvm8arSBWznxDki2TFttmRdeWqb1w@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: do not replace surface when scanout is
 disabled
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="000000000000fade9405ffaab506"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

--000000000000fade9405ffaab506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 28, 2023 at 12:32=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com=
> wrote:

> Surface is replaced with a place holder whenever the surface res
> is unreferenced by the guest message. With this logic, there is
> very frequent switching between guest display and the place holder
> image, which is looking like a flickering display if the guest driver
> is designed to unref the current scanout resource before sending out
> a new scanout resource. So it is better to leave the current scanout
> image until there is a new one flushed by the guest.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Why is the driver not setting a different scanout before destroying the
resource?

I think it's wrong to not replace the surface, as the associated scanout
resource may be destroyed or explicitly disabled for various purposes, and
we don't want to display garbage either.

---
>  hw/display/virtio-gpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66cddd94d9..9d3e922c8f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -387,7 +387,6 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,
> int scanout_id)
>          res->scanout_bitmask &=3D ~(1 << scanout_id);
>      }
>
> -    dpy_gfx_replace_surface(scanout->con, NULL);
>      scanout->resource_id =3D 0;
>      scanout->ds =3D NULL;
>      scanout->width =3D 0;
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fade9405ffaab506
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 28, 2023 at 12:32=E2=80=
=AFAM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@=
intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Surface is replaced with a place holder whenever the surface res=
<br>
is unreferenced by the guest message. With this logic, there is<br>
very frequent switching between guest display and the place holder<br>
image, which is looking like a flickering display if the guest driver<br>
is designed to unref the current scanout resource before sending out<br>
a new scanout resource. So it is better to leave the current scanout<br>
image until there is a new one flushed by the guest.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Why is the driver not setting a different scanout before destroying t=
he resource?</div><div><br></div><div>I think it&#39;s wrong to not replace=
 the surface, as the associated scanout resource may be destroyed or explic=
itly disabled for various purposes, and we don&#39;t want to display garbag=
e either.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
---<br>
=C2=A0hw/display/virtio-gpu.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 66cddd94d9..9d3e922c8f 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -387,7 +387,6 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, in=
t scanout_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res-&gt;scanout_bitmask &amp;=3D ~(1 &lt;=
&lt; scanout_id);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 dpy_gfx_replace_surface(scanout-&gt;con, NULL);<br>
=C2=A0 =C2=A0 =C2=A0scanout-&gt;resource_id =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0scanout-&gt;ds =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0scanout-&gt;width =3D 0;<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000fade9405ffaab506--

