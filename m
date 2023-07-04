Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81F74760C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiUT-0006JQ-FS; Tue, 04 Jul 2023 12:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiU9-00062X-0d
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:02:38 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGiU6-00029s-Pf
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:02:36 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-40339da998eso40756661cf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688486552; x=1691078552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qEfASsX9I66EYZpQngebDCtBV8yUFZ0BaQyIrGzZMOc=;
 b=rcHMdha4zHrFBiR6bmh5x5AzcjQYg7QnqfPDNmXAbgcKxKW66a7cATteaoRZMFxYbc
 lhsMmI2UcS423wPAmgh7r/TzVxzS1Rim1/8+Rce5pV2yRmZyve+pqeIJGoCh6zTyv4JC
 aVoqUnlqYJobRoxnf093EfWwo5Q5Uw8lUKqwH9dq4ETU4GNLJo/QtTDg5B0p4ucDeUG8
 4lRzShfC26xJpKEn29PmIqsZmzGlOsE59/KX5w9g2GxskMZ3dGrQn12Xq5oVMDVylBXR
 WHRVF3N8DYWRNtpfQbV96pwquYU+b8Qokv5IB0zNct0q62C3ZBZYVmv4CTshc92/u4Hs
 Pl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486552; x=1691078552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qEfASsX9I66EYZpQngebDCtBV8yUFZ0BaQyIrGzZMOc=;
 b=iQzbtSd41fHYcVzseITWicQCteh/solp+PczLcOlHOq19KgWp0p4i76oJYho4Wk6CC
 5ZsOY+3ATAvYZ0bNAu2gYyK5lOUqX+jNsUDL3loi1jv0Qu79Qg1i6++2UewDVornB3lp
 fkV9llcgdrn/AMF+2Wxd1JkEOonpjeB0aB/cRzjS3QY7agqtCSR7rg2uyDqPdii3hrio
 Bz0fc3mBeT+ZBnAeevJKLWV0vriZgUz8hQrj61rFYAUBM8/8x1YolHNL48O7+HN/3zc5
 PDnkb1UcORF7MV0wO+FF+Uj0z/cycSIJTiXysY6OlZ/dmLU4OiUVm05XMAQK9eMRw6UF
 qgdw==
X-Gm-Message-State: AC+VfDwr5SpQ9SOUm74tp5q5/xH0LK/zu+DDUNJzEYpB7BgpCE32U1aT
 TBpbxyEHBOD15krRAIg/RnwjekNc5JV+0+yibCc=
X-Google-Smtp-Source: ACHHUZ6oDp9XHBZWl0wLoCJGzKdwVenongIT9fv8mU/0L37bB36can0CJzt7XrmK8f67NHBv1muelq8jX0kDx3K2KxU=
X-Received: by 2002:ac8:5a86:0:b0:401:e140:58ab with SMTP id
 c6-20020ac85a86000000b00401e14058abmr17022683qtc.32.1688486552236; Tue, 04
 Jul 2023 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230627224451.11739-1-dongwon.kim@intel.com>
In-Reply-To: <20230627224451.11739-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 18:02:21 +0200
Message-ID: <CAJ+F1CJSgmN0XxL6eTACozZ=Rd_yg023dgELBWgHdbNZbyxq-g@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: replace the surface with null surface when
 resetting
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: multipart/alternative; boundary="0000000000002778d805ffab69e6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

--0000000000002778d805ffab69e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 1:05=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:

> The primary guest scanout shows the booting screen right after reboot
> but additional guest displays (i.e. max_ouptuts > 1) will keep displaying
> the old frames until the guest virtio gpu driver gets initialized, which
> could cause some confusion. A better way is to to replace the surface wit=
h
> a place holder that tells the display is not active during the reset of
> virtio-gpu device.
>
> And to immediately update the surface with the place holder image after
> the switch, displaychangelistener_gfx_switch needs to be called with
> 'update =3D=3D TRUE' in dpy_gfx_replace_surface when the new surface is N=
ULL.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/display/virtio-gpu.c |  5 +++++
>  ui/console.c            | 11 ++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66cddd94d9..de92f003b5 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1354,6 +1354,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>      VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>      struct virtio_gpu_simple_resource *res, *tmp;
>      struct virtio_gpu_ctrl_command *cmd;
> +    int i =3D 0;
>
>      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>          virtio_gpu_resource_destroy(g, res);
> @@ -1372,6 +1373,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>          g_free(cmd);
>      }
>
> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
> +    }
> +
>      virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>  }
>
> diff --git a/ui/console.c b/ui/console.c
> index e173731e20..768f39697c 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1787,6 +1787,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>      static const char placeholder_msg[] =3D "Display output is not activ=
e.";
>      DisplayState *s =3D con->ds;
>      DisplaySurface *old_surface =3D con->surface;
> +    DisplaySurface *new_surface =3D surface;
>      DisplayChangeListener *dcl;
>      int width;
>      int height;
> @@ -1800,19 +1801,19 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>              height =3D 480;
>          }
>
> -        surface =3D qemu_create_placeholder_surface(width, height,
> placeholder_msg);
> +        new_surface =3D qemu_create_placeholder_surface(width, height,
> placeholder_msg);
>      }
>
> -    assert(old_surface !=3D surface);
> +    assert(old_surface !=3D new_surface);
>
>      con->scanout.kind =3D SCANOUT_SURFACE;
> -    con->surface =3D surface;
> -    dpy_gfx_create_texture(con, surface);
> +    con->surface =3D new_surface;
> +    dpy_gfx_create_texture(con, new_surface);
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (con !=3D (dcl->con ? dcl->con : active_console)) {
>              continue;
>          }
> -        displaychangelistener_gfx_switch(dcl, surface, FALSE);
> +        displaychangelistener_gfx_switch(dcl, new_surface, surface ?
> FALSE : TRUE);
>      }
>      dpy_gfx_destroy_texture(con, old_surface);
>      qemu_free_displaysurface(old_surface);
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002778d805ffab69e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 28, 2023 at 1:05=E2=80=AF=
AM Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The primary guest scanout shows the booting screen right after reboot=
<br>
but additional guest displays (i.e. max_ouptuts &gt; 1) will keep displayin=
g<br>
the old frames until the guest virtio gpu driver gets initialized, which<br=
>
could cause some confusion. A better way is to to replace the surface with<=
br>
a place holder that tells the display is not active during the reset of<br>
virtio-gpu device.<br>
<br>
And to immediately update the surface with the place holder image after<br>
the switch, displaychangelistener_gfx_switch needs to be called with<br>
&#39;update =3D=3D TRUE&#39; in dpy_gfx_replace_surface when the new surfac=
e is NULL.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com" target=
=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
Signed-off-by: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" tar=
get=3D"_blank">dongwon.kim@intel.com</a>&gt;<br></blockquote><div><br></div=
><div>Acked-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu.c |=C2=A0 5 +++++<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++----=
-<br>
=C2=A02 files changed, 11 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 66cddd94d9..de92f003b5 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -1354,6 +1354,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)<br>
=C2=A0 =C2=A0 =C2=A0VirtIOGPU *g =3D VIRTIO_GPU(vdev);<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *res, *tmp;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd;<br>
+=C2=A0 =C2=A0 int i =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_FOREACH_SAFE(res, &amp;g-&gt;reslist, next, tmp)=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_resource_destroy(g, res);<br>
@@ -1372,6 +1373,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(cmd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; g-&gt;parent_obj.conf.max_outputs; i++)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_replace_surface(g-&gt;parent_obj.scano=
ut[i].con, NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));<br>
=C2=A0}<br>
<br>
diff --git a/ui/console.c b/ui/console.c<br>
index e173731e20..768f39697c 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -1787,6 +1787,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,<br>
=C2=A0 =C2=A0 =C2=A0static const char placeholder_msg[] =3D &quot;Display o=
utput is not active.&quot;;<br>
=C2=A0 =C2=A0 =C2=A0DisplayState *s =3D con-&gt;ds;<br>
=C2=A0 =C2=A0 =C2=A0DisplaySurface *old_surface =3D con-&gt;surface;<br>
+=C2=A0 =C2=A0 DisplaySurface *new_surface =3D surface;<br>
=C2=A0 =C2=A0 =C2=A0DisplayChangeListener *dcl;<br>
=C2=A0 =C2=A0 =C2=A0int width;<br>
=C2=A0 =C2=A0 =C2=A0int height;<br>
@@ -1800,19 +1801,19 @@ void dpy_gfx_replace_surface(QemuConsole *con,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0height =3D 480;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 surface =3D qemu_create_placeholder_surface(wi=
dth, height, placeholder_msg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_surface =3D qemu_create_placeholder_surfac=
e(width, height, placeholder_msg);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 assert(old_surface !=3D surface);<br>
+=C2=A0 =C2=A0 assert(old_surface !=3D new_surface);<br>
<br>
=C2=A0 =C2=A0 =C2=A0con-&gt;scanout.kind =3D SCANOUT_SURFACE;<br>
-=C2=A0 =C2=A0 con-&gt;surface =3D surface;<br>
-=C2=A0 =C2=A0 dpy_gfx_create_texture(con, surface);<br>
+=C2=A0 =C2=A0 con-&gt;surface =3D new_surface;<br>
+=C2=A0 =C2=A0 dpy_gfx_create_texture(con, new_surface);<br>
=C2=A0 =C2=A0 =C2=A0QLIST_FOREACH(dcl, &amp;s-&gt;listeners, next) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (con !=3D (dcl-&gt;con ? dcl-&gt;con :=
 active_console)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 displaychangelistener_gfx_switch(dcl, surface,=
 FALSE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 displaychangelistener_gfx_switch(dcl, new_surf=
ace, surface ? FALSE : TRUE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0dpy_gfx_destroy_texture(con, old_surface);<br>
=C2=A0 =C2=A0 =C2=A0qemu_free_displaysurface(old_surface);<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000002778d805ffab69e6--

